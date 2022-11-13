FROM ubuntu:latest

RUN myDeps=' \
        build-essential \
        tmux \
        vim \
        vifm \
        tree \
        jq \
        xmlstarlet \
        inotify-tools \
        chrpath \
        diffstat \
        gawk \
        gcc-multilib \
        git \
        language-pack-en-base \
        libsdl1.2-dev \
        locales \
        socat \
        netcat \
        texinfo \
        unzip \
        wget \
        xterm \
    ' \
    checkerDeps=' \
        clang-format \
        clang-tidy \
        cppcheck \
    ' \
    itmDeps=' \
        python3 \
        python3-cryptography \
        python3-pip \
        python3-pexpect \
    ' \
    systemtestDeps=' \
        sudo \
        tshark \
    ' \
    reportDeps=' \
        gcovr \
        lcov \
    ' \
    otherDeps=' \
        clang \
        cmake \
        cpio \
        debianutils \
        doxygen \
        iptables \
        iputils-ping \
        libboost-all-dev \
        libdbus-glib-1-dev \
        net-tools \
        pkg-config \
        xz-utils \
        zlib1g-dev \
    ' \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        $myDeps \
        $checkerDeps \
        $itmDeps \
        $systemtestDeps \
        $reportDeps \
        $otherDeps

# Set up a locale for the python 3 version of bitbake
RUN echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Finally clean the apt-get cache to reduce container size. Do this last
# so that apt-* additional commands can be inserted above without them
# failing.
RUN rm -rf /var/lib/apt/lists/*

COPY .tmux.conf /root/
COPY .vifm /root/.vifm
COPY .gitconfig /root/

