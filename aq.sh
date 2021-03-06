#!/bin/bash
#
# AQ
# Build Android qemu
#
# statically linked binary program
# Qemu Version: 2.10.0-rc2
#
# System: Debian stretch, System Architecture: armel
# System: Debian stretch, System Architecture: x86
# System: Debian stretch, System Architecture: x86_64
# System: Debian jessie, System Architecture: armel
# System: Debian jessie, System Architecture: x86
# System: Debian jessie, System Architecture: x86_64
# System: Ubuntu 16.10, System Architecture: x86_64
#
# Write Date: 20170707
# Modify Date: 20180227 
# aixiao@aixiao.me.
#

path() {
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
}

init() {
    initdate
    check_os
    helloworld
    check_root
    PWD=$(pwd)
    SRC=$PWD/AQ
    LOG=$(pwd)/AQ/LOG
    QEMU_PREFIX=/data/local/aixiao.qemu
    QEMU_VERSION="2.8.0"
    QEMU_VERSION="2.8.1.1"
    QEMU_VERSION="2.10.0-rc0"
    QEMU_VERSION="2.10.0-rc1"
    QEMU_VERSION="2.10.0-rc2"
    QEMU_VERSION="2.10.0-rc3"
    QEMU_VERSION="2.10.0-rc4"
    QEMU_VERSION="2.10.0"
    QEMU_VERSION="2.10.1"
    QEMU_VERSION="2.11.0-rc0"
    QEMU_VERSION="2.11.0-rc4"
    QEMU_VERSION="2.11.0-rc5"
    QEMU_VERSION="2.11.0"
    QEMU_VERSION="2.11.1"
    QEMU_VERSION="2.12.0-rc4"
    QEMU_VERSION="2.12.0"
    QEMU_VERSION="3.0.0"
    QEMU_VERSION="4.0.0-rc2"
    QEMU_VERSION="4.0.0"
    QEMU_VERSION=${qemu_version:-"$QEMU_VERSION"}
    check_qemu_version $QEMU_VERSION
    QEMU_TAR_SRC=${PWD}/AQ/qemu-${QEMU_VERSION}.tar.xz
    QEMU_BIN_TAR_CREATE_SRC="${SRC}/qemu-${QEMU_VERSION}_${arch}.tar.bz2"
    QEMU_TAR_SRC_USR=http://download.qemu-project.org/qemu-${QEMU_VERSION}.tar.xz
    QEMU_SRC_DIR=${PWD}/AQ/qemu-${QEMU_VERSION}
    QEMU_GIT_SRC_DIR=${PWD}/AQ/qemu
    QEMU_CONFIGURE_2_8_0="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu --static --enable-docs --enable-guest-agent --enable-gcrypt --enable-vnc --enable-vnc-jpeg --enable-vnc-png --enable-fdt --enable-bluez --enable-kvm --enable-colo --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-bzip2 --enable-coroutine-pool --enable-tpm --disable-libssh2 --enable-replication --disable-libiscsi --disable-libnfs --disable-libusb --disable-smartcard --disable-usb-redir --disable-glusterfs --disable-seccomp
    "
    QEMU_CONFIGURE_2_8_1_1="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu --static --enable-docs --enable-guest-agent --enable-gcrypt --enable-vnc --enable-vnc-jpeg --enable-vnc-png --enable-fdt --enable-bluez --enable-kvm --enable-colo --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-bzip2 --enable-coroutine-pool --enable-tpm --disable-libssh2 --enable-replication --disable-libiscsi --disable-libnfs --disable-libusb --disable-smartcard --disable-usb-redir --disable-glusterfs --disable-seccomp
    "
    QEMU_CONFIGURE_2_10_0_RC0="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu,i386-linux-user,i386-softmmu --static --enable-docs --enable-guest-agent --disable-sdl --disable-gtk --disable-vte --disable-curses --disable-cocoa --enable-gcrypt --enable-vnc --enable-vnc-jpeg --enable-vnc-png --disable-virtfs --enable-fdt --enable-bluez --enable-kvm --disable-hax --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-libiscsi --disable-libnfs --disable-smartcard --disable-libusb --enable-live-block-migration --disable-usb-redir --enable-bzip2 --enable-coroutine-pool --disable-glusterfs --enable-tpm --enable-libssh2 --enable-replication --enable-vhost-vsock --enable-xfsctl --enable-tools --enable-crypto-afalg
    "
    QEMU_CONFIGURE_2_10_0_RC2="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu,i386-linux-user,i386-softmmu --static --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse --disable-gnutls --disable-nettle --enable-gcrypt --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa --enable-virtfs --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-fdt --enable-bluez --enable-kvm --disable-hax --disable-rdma --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2 --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --disable-libssh2 --disable-numa --disable-tcmalloc --disable-jemalloc --enable-replication --enable-vhost-vsock --disable-opengl --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-crypto-afalg --enable-vhost-user
    "
    QEMU_CONFIGURE_2_11_0_RC0="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu,i386-linux-user,i386-softmmu --static --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse --disable-gnutls --disable-nettle --enable-gcrypt --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa --enable-virtfs --enable-mpath --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-fdt --enable-bluez --enable-kvm --disable-hax --disable-rdma --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2 --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --disable-libssh2 --disable-numa --disable-tcmalloc --disable-jemalloc --enable-replication --enable-vhost-vsock --disable-opengl --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-crypto-afalg --enable-vhost-user --enable-capstone
    "
    QEMU_CONFIGURE_2_11_1="
    ./configure --prefix=${QEMU_PREFIX} --target-list=arm-linux-user,arm-softmmu,i386-linux-user,i386-softmmu --static --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse --disable-gnutls --disable-nettle --enable-gcrypt --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa --enable-virtfs --disable-mpath --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-fdt --enable-bluez --enable-kvm --disable-hax --disable-rdma --enable-vde --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2 --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --disable-libssh2 --disable-numa --disable-tcmalloc --disable-jemalloc --enable-replication --enable-vhost-vsock --disable-opengl --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-crypto-afalg --enable-vhost-user --enable-capstone
    "
    QEMU_CONFIGURE_2_12_0_RC4="
./configure --prefix=${QEMU_PREFIX} --static --enable-malloc-trim --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse --disable-gnutls --disable-nettle --enable-gcrypt --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa --enable-virtfs --disable-mpath --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-membarrier --enable-fdt --enable-bluez --enable-kvm --disable-hax --disable-hvf --disable-whpx --disable-rdma --enable-vde --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-vhost-crypto --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2 --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --disable-libssh2 --disable-numa --enable-libxml2 --disable-tcmalloc --disable-jemalloc --enable-replication --enable-vhost-vsock --disable-opengl --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-crypto-afalg --enable-vhost-user --enable-capstone
    "

    QEMU_CONFIGURE_3_0_0="
./configure --prefix=${QEMU_PREFIX} --static --enable-malloc-trim\
    --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse\
    --disable-gnutls --disable-nettle --enable-gcrypt --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa\
    --enable-virtfs --disable-mpath --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-membarrier --enable-fdt --enable-bluez --enable-kvm --disable-hax
    --disable-hvf --disable-whpx --disable-rdma --enable-vde --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-vhost-crypto --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard\
    --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2\
    --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --disable-libssh2 --disable-numa --enable-libxml2 --disable-tcmalloc --disable-jemalloc --enable-replication --enable-vhost-vsock --disable-opengl\
    --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-crypto-afalg --enable-vhost-user --enable-capstone --disable-capstone
    "

    ALSA_PREFIX="/data/local/alsa"
    QEMU_CONFIGURE_4_0_0_RC2="
./configure --prefix=${QEMU_PREFIX}\
    --static --audio-drv-list=alsa --extra-ldflags=-L${ALSA_PREFIX}/lib\
    --enable-malloc-trim\
    --enable-system --enable-user --disable-bsd-user --enable-docs --enable-guest-agent --disable-guest-agent-msi --disable-pie --disable-modules --enable-debug-tcg --disable-debug-info --disable-sparse\
    --disable-gnutls --disable-nettle --enable-gcrypt --disable-auth-pam --disable-sdl --disable-gtk --disable-vte --disable-curses --enable-iconv --enable-vnc --disable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png --disable-cocoa\
    --enable-virtfs --disable-mpath --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-curl --enable-membarrier --enable-fdt --enable-bluez --enable-kvm --disable-hax\
    --disable-hvf --disable-whpx\
    --disable-rdma --disable-pvrdma --enable-vde --disable-netmap --enable-linux-aio --enable-cap-ng --enable-attr --enable-vhost-net --enable-vhost-vsock --enable-vhost-scsi --enable-vhost-crypto --enable-vhost-kernel  --enable-vhost-user --disable-spice --disable-rbd --enable-libiscsi --disable-libnfs --disable-smartcard\
    --disable-libusb --enable-live-block-migration --disable-usb-redir --disable-lzo --disable-snappy --enable-bzip2 --disable-lzfse\
    --disable-seccomp --enable-coroutine-pool --disable-glusterfs --enable-tpm --enable-libssh2 --disable-numa --enable-libxml2 --disable-tcmalloc --disable-jemalloc --disable-avx2 --enable-replication --disable-opengl\
    --disable-virglrenderer --enable-xfsctl --enable-qom-cast-debug --enable-tools --disable-vxhs --enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vdi --enable-vvfat --enable-qed --enable-parallels --enable-sheepdog --enable-crypto-afalg --enable-capstone --enable-debug-mutex --disable-libpmem\
    "
    
    
    QEMU_CONFIGURE_2_10_0_RC1=$QEMU_CONFIGURE_2_10_0_RC0
    QEMU_CONFIGURE_2_10_0_RC2=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_10_0_RC3=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_10_0_RC4=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_10_0=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_10_1=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_11_0_RC0=$QEMU_CONFIGURE_2_10_0_RC2
    QEMU_CONFIGURE_2_11_0_RC0=$QEMU_CONFIGURE_2_11_0_RC0
    QEMU_CONFIGURE_2_11_0_RC4=$QEMU_CONFIGURE_2_11_0_RC0
    QEMU_CONFIGURE_2_11_0_RC5=$QEMU_CONFIGURE_2_11_0_RC0
    QEMU_CONFIGURE_2_11_0=$QEMU_CONFIGURE_2_11_0_RC0
    QEMU_CONFIGURE_2_11_1=$QEMU_CONFIGURE_2_11_1
    QEMU_CONFIGURE_2_12_0_RC4=$QEMU_CONFIGURE_2_12_0_RC4
    QEMU_CONFIGURE_2_12_0=$QEMU_CONFIGURE_2_12_0_RC4
    QEMU_CONFIGURE_3_0_0=$QEMU_CONFIGURE_3_0_0
    QEMU_CONFIGURE_4_0_0_RC2=$QEMU_CONFIGURE_4_0_0_RC2
    QEMU_CONFIGURE_4_0_0=$QEMU_CONFIGURE_4_0_0_RC2
    QEMU_CONFIGURE_GIT=$QEMU_CONFIGURE_4_0_0

    MAKE_J="$(grep -c ^processor /proc/cpuinfo | grep -E '^[1-9]+[0-9]*$' || echo 1)" ; test $MAKE_J != "1" && make_j=$((MAKE_J - 1)) || make_j=$MAKE_J
    MAKE_J="-j${make_j}"
    pkg_install $OS
    if test "$GIT_QEMU" = "0" ; then
        git_clone
        install qemu-git
        exit 3
    fi
    src_download
    tar_extract
    if test "${QEMU_VERSION}" = "4.0.0-rc2"; then
        build_alsa-lib;
    fi
    install qemu
}

function check_alsa() {
    case $1 in
        "4.0.0-rc2") build_alsa-lib; ;;
    esac
}

function build_alsa-lib() {
    ALSA_VERSION="1.1.8";
    ALSA_TAR_SRC="${SRC}/alsa-lib-${ALSA_VERSION}.tar.bz2";
    ALSA_TAR_SRC_USR="ftp://ftp.alsa-project.org/pub/lib/alsa-lib-${ALSA_VERSION}.tar.bz2";
    ALSA_SRC_DIR=${SRC}/alsa-lib-${ALSA_VERSION};
    
    ALSA_CONFIGURE_1_1_8="
./configure --prefix=${ALSA_PREFIX} --enable-static=yes --disable-shared
    "

    if ! test -f ${ALSA_TAR_SRC} ; then
        echo -n "Download ALSA-LIB ${ALSA_VERSION} "
        bg_wait wget -q -T 120 -O ${ALSA_TAR_SRC}_tmp ${ALSA_TAR_SRC_USR}
        if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" || ! test -f ${ALSA_TAR_SRC}_tmp ; then
            echo -ne fail\\n
            test -f ${ALSA_TAR_SRC}_tmp && rm -f ${ALSA_TAR_SRC}_tmp && exit 3
        else
            echo -ne done\\n
            mv ${ALSA_TAR_SRC}_tmp ${ALSA_TAR_SRC}
        fi
    fi
    if ! test -d ${ALSA_SRC_DIR}; then
        echo -n +Extract ALSA ....
        tar -axf ${ALSA_TAR_SRC} -C ${SRC} >> ${BGEXEC_LOG_STATUS_FILE} 2>&1
        if ! test -d ${ALSA_SRC_DIR} ; then
            echo -ne \\b\\b\\b\\bfail\\n
            exit 3
        else
            echo -ne \\b\\b\\b\\bdone\\n
        fi
    fi
    
    cd ${ALSA_SRC_DIR};
    echo -n "Configure ALSA "
    bg_wait $ALSA_CONFIGURE_1_1_8
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) = "0" && test -f ${ALSA_SRC_DIR}/Makefile ; then
        echo -ne done\\n
    else
        echo -ne fail\\n
        exit 3
    fi
    
    make $MAKE_J >> $LOG 2>&1 &
    echo -n Make ALSA\ ;wait_pid $!
    if test -x $ALSA_SRC_DIR/aserver/aserver ; then
         echo -ne done\\n
    else
        echo -ne fail\\n
        exit 3
    fi
    make install >> $LOG 2>&1 &
    echo -n Make install ALSA\ ;wait_pid $!
    if test -x $ALSA_PREFIX/bin/aserver ; then
        echo -ne done\\n
    else
        echo -ne fail\\n
        exit 3
    fi
    
}

initdate() {
    init_date=`date +%s`
}

helloworld() {
    cat <<EOF
-----------------------------
AQ: $VER for $OS $vvv
Qq: 1605227279
Qemail: 1605227279@qq.com
Author: aixiao@aixiao.me
Android Qemu
-----------------------------
EOF
}

check_os() {
    if cat /etc/issue | grep -i 'ubuntu' >> /dev/null 2>&1 ; then
        OS=ubuntu
        OS_VER=$(cat /etc/issue | head -n1 | awk '{print$2}')
        echo -e SYSTEM: UBUNTU $(uname -m) ${OS_VER}\\nKERNEL: $(uname -sr)
    elif test -f /etc/debian_version ; then
        OS=debian
        OS_VER=$(cat /etc/debian_version)
        echo -e SYSTEM: DEBIAN $(uname -m) ${OS_VER}\\nKERNEL: $(uname -sr)
    elif test -f /etc/centos-release ; then
        OS=centos
        OS_VER=$(cat /etc/centos-release | grep -o -E '[0-9.]{3,}') 2>> /dev/null
        echo -e SYSTEM: CENTOS $(uname -m) ${OS_VER}\\nKERNEL: $(uname -sr)
    else
        echo The system does not support
        exit 3
    fi
    vvv=$(echo $OS_VER | cut -b1)
    test $OS = "ubuntu" && vvv=$(echo $OS_VER | awk -F '.' '{print$1}')
    case $OS in
        "debian")
            arch=`uname -m`
            test "$arch" = "i686" && arch=x86
            test "$arch" = "i386" && arch=x86
            test "$arch" = "i486" && arch=x86
            test "$arch" = "i586" && arch=x86
            test "$arch" = "x86_64" && arch=x64
            test "$arch" = "armv7l" && arch=arm
            test "$arch" = "armv6l" && arch=arm
            test "$arch" = "aarch64" && arch=arm;
        case $vvv in
            "8")
                :
                case $arch in
                    "arm")
                        APT1="libbz2-dev libxml2-dev liblzma-dev"
                    ;;
                    "x86")
                        APT1="libbz2-dev libxml2-dev liblzma-dev"
                    ;;
                    "x64")
                        APT1="libbz2-dev libxml2-dev liblzma-dev"
                    ;;
                esac
            ;;
            "9")
                case $arch in
                    "arm")
                         APT1="libbz2-dev libxml2-dev liblzma-dev flex bison texinfo perl python-sphinx"
                     ;;
                     "x86")
                         APT1="libbz2-dev libxml2-dev liblzma-dev"
                     ;;
                     "x64")
                         APT1="libbz2-dev libxml2-dev liblzma-dev flex bison texinfo perl python-sphinx"
                     ;;
                esac
            ;;
        esac
        APT="$APT1"
        ;;
        "ubuntu")
            arch=`uname -m`
            test "$arch" = "i686" && arch=x86
            test "$arch" = "i386" && arch=x86
            test "$arch" = "i486" && arch=x86
            test "$arch" = "i586" && arch=x86
            test "$arch" = "x86_64" && arch=x64
            test "$arch" = "armel7" && arch=arm
        case $vvv in
            "16")
                APT1="libbz2-dev libgcrypt-dev"
            ;;
            "17")
            :
            ;;
        esac
        APT="$APT1"
        ;;
        "*")
            echo -ne The system does not support\\n && exit 3
        ;;
    esac
}

check_root() {
    if test $(id -u) != "0" || test $(id -g) != 0 ; then
        echo Root run $0 ?
        exit 3
    fi
}

check_qemu_version() {
    case $1 in
        "2.8.0")      : ;;
        "2.8.1.1")    : ;;
        "2.10.0-rc0") : ;;
        "2.10.0-rc1") : ;;
        "2.10.0-rc2") : ;;
        "2.10.0-rc3") : ;;
        "2.10.0-rc4") : ;;
        "2.10.0")     : ;;
        "2.10.1")     : ;;
        "2.11.0-rc0") : ;;
        "2.11.0-rc4") : ;;
        "2.11.0-rc5") : ;;
        "2.11.0")     : ;;
        "2.11.1")     : ;;
        "2.12.0-rc4") : ;;
        "2.12.0")     : ;;
        "3.0.0")      : ;;
        "4.0.0-rc2")  : ;;
        "4.0.0")      : ;;
        *)            echo -ne The QEMU $QEMU_VERSION version does not support configure\\n ; exit 3 ;;
    esac
}

bg_exec() {
    rm -f $BGEXEC_EXIT_STATUS_FILE
    $@
    echo $? > $BGEXEC_EXIT_STATUS_FILE
}
bg_wait() {
    BGEXEC_EXIT_STATUS_FILE=/tmp/QEMU.status
    BGEXEC_LOG_STATUS_FILE=/tmp/QEMU.log
    bg_exec $@ >> $BGEXEC_LOG_STATUS_FILE 2>&1 &
    wait_pid $!
    ! test -f $BGEXEC_EXIT_STATUS_FILE && exit 3
}

wait_pid() {
    while true ; do
        ps -p $1 >> /dev/null
        if test "$?" = "1" ; then
            break
        fi
        sleep 1
        echo -ne .
        sleep 1
        echo -ne .
        sleep 1
        echo -ne .
        sleep 1
        echo -ne .
        sleep 1
        echo -ne \\b\\b\\b\\b\ \ \ \ \\b\\b\\b\\b
        sleep 1
    done
}

function TEE() {
    $@ | tee -a $LOG
}

pkg_install() {
    case $1 in
        debian)
    echo -n "Debian apt update "
    bg_wait TEE apt-get update
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n
    else
        echo -ne done\\n
    fi
    echo -n "Debian apt install "
    DEBIAN_FRONTEND=noninteractive bg_wait TEE apt-get -qqy --force-yes install build-essential git-core $APT
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n-----------------------------\\n
        exit 3
    else
        echo -ne done\\n
    fi
    echo -n "Debian apt build-dep "
    DEBIAN_FRONTEND=noninteractive bg_wait TEE apt-get -qqy --force-yes build-dep qemu-system
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n-----------------------------\\n
        exit 3
    fi
    echo -ne done\\n-----------------------------\\n
        ;;
        ubuntu)
    echo -n "Ubuntu apt update "
    bg_wait TEE apt-get update
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n
    else
        echo -ne done\\n
    fi
    echo -n "Ubuntu apt install "
    DEBIAN_FRONTEND=noninteractive bg_wait TEE apt-get -qqy --force-yes install build-essential git $APT
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n-----------------------------\\n
        exit 3
    else
        echo -ne done\\n
    fi
    echo -n "Ubuntu apt build-dep "
    DEBIAN_FRONTEND=noninteractive bg_wait TEE apt-get -qqy --force-yes build-dep qemu-system
    if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
        echo -ne fail\\n-----------------------------\\n
        exit 3
    else
        echo -ne done\\n-----------------------------\\n
    fi
    ;;
    esac
}

src_download() {
    if ! test -f ${QEMU_TAR_SRC} ; then
        echo -n "Download QEMU ${QEMU_VERSION} "
        bg_wait TEE wget -q -T 120 -O ${QEMU_TAR_SRC}_tmp ${QEMU_TAR_SRC_USR}
        if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" || ! test -f ${QEMU_TAR_SRC}_tmp ; then
            echo -ne fail\\n
            test -f ${QEMU_TAR_SRC}_tmp && rm -f ${QEMU_TAR_SRC}_tmp && exit 3
        else
            echo -ne done\\n
            mv ${QEMU_TAR_SRC}_tmp ${QEMU_TAR_SRC}
        fi
    fi
}

tar_extract() {
    if ! test -d $QEMU_SRC_DIR; then
        echo -n +Extract QEMU ....
        tar -axf $QEMU_TAR_SRC -C $SRC >> $BGEXEC_LOG_STATUS_FILE 2>&1
        if ! test -d $QEMU_SRC_DIR ; then
            echo -ne \\b\\b\\b\\bfail\\n
            exit 3
        else
            echo -ne \\b\\b\\b\\bdone\\n
        fi
    fi
}

tar_create() {
    if test -d $QEMU_PREFIX ; then
        echo -n +Create QEMU $QEMU_BIN_TAR_CREATE_SRC ....
        tar -cjf $QEMU_BIN_TAR_CREATE_SRC $QEMU_PREFIX >> $BGEXEC_LOG_STATUS_FILE 2>&1
        if ! test -f $QEMU_BIN_TAR_CREATE_SRC; then
            echo -ne \\b\\b\\b\\bfail\\n
            exit 3
        else
            echo -ne \\b\\b\\b\\bdone\\n
        fi
    fi
}

check_qemu_bin() {
    if test -d $QEMU_PREFIX ; then
        file $QEMU_PREFIX/bin/qemu-system-i386 | grep "statically linked" > /dev/null 2>&1
        if test $(echo $?) = "0" ; then
            echo -ne statically linked binary program.\\n
        else
            echo -ne dynamically linked binary program.\\n
        fi
    fi
}

git_clone() {
    if ! test -d $QEMU_GIT_SRC_DIR ; then
        echo -n "GIT PULL QEMU "
        cd $SRC
        bg_wait TEE git clone git://git.qemu-project.org/qemu.git
        if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" || ! test -d $QEMU_GIT_SRC_DIR ; then
            echo -ne fail\\n
            exit 3
        fi
        cd $QEMU_GIT_SRC_DIR
        bg_wait TEE git submodule init
        if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" ; then
            echo -ne fail\\n
            exit 3
        fi
        bg_wait TEE git submodule update --recursive
        if test $(cat $BGEXEC_EXIT_STATUS_FILE) != "0" || ! test -f $QEMU_GIT_SRC_DIR/configure ; then
            echo -ne fail\\n
            exit 3
        else
            echo -ne done\\n-----------------------------\\n
        fi
    fi
}

c_configure() {
    local a="'"
    local b="\""
    local c="\\"
    local l=$(grep -ne "static void version(void)" vl.c | cut -d : -f1)
    local l=$((l+2))
    if test "$(grep "AIXIAO.ME" vl.c ; echo $?)" = "1" ; then
        eval "sed -i ${a}${l}i printf(${c}${b}AIXIAO.ME Compile Links, EMAIL AIXIAO@AIXIAO.ME${c}${c}n${c}${b});${a} vl.c"
    else
        exit 3
    fi
}

configure() {
    case $1 in
        qemu)
            case $2 in
                "2.8.0")      ${QEMU_CONFIGURE_2_8_0} ;;
                "2.8.1.1")    ${QEMU_CONFIGURE_2_8_1_1} ;;
                "2.10.0-rc0") ${QEMU_CONFIGURE_2_10_0_RC0} ;;
                "2.10.0-rc1") ${QEMU_CONFIGURE_2_10_0_RC1} ;;
                "2.10.0-rc2") ${QEMU_CONFIGURE_2_10_0_RC2} ;;
                "2.10.0-rc3") ${QEMU_CONFIGURE_2_10_0_RC3} ;;
                "2.10.0-rc4") ${QEMU_CONFIGURE_2_10_0_RC4} ;;
                "2.10.0")     ${QEMU_CONFIGURE_2_10_0} ;;
                "2.10.1")     ${QEMU_CONFIGURE_2_10_1} ;;
                "2.11.0-rc0") ${QEMU_CONFIGURE_2_11_0_RC0} ;;
                "2.11.0-rc4") ${QEMU_CONFIGURE_2_11_0_RC4} ;;
                "2.11.0-rc5") ${QEMU_CONFIGURE_2_11_0_RC5} ;;
                "2.11.0")     ${QEMU_CONFIGURE_2_11_0} ;;
                "2.11.1")     ${QEMU_CONFIGURE_2_11_1} ;;
                "2.12.0-rc4") ${QEMU_CONFIGURE_2_12_0_RC4} ;;
                "2.12.0")     ${QEMU_CONFIGURE_2_12_0_RC4} ;;
                "3.0.0")      ${QEMU_CONFIGURE_3_0_0} ;;
                "4.0.0-rc2")  ${QEMU_CONFIGURE_4_0_0_RC2} ;;
                "4.0.0")      ${QEMU_CONFIGURE_4_0_0_RC2} ;;
            esac
        ;;
        qemu-git)
    ${QEMU_CONFIGURE_GIT}
        ;;
    esac
}

install() {
    case $1 in
        qemu)
            cd $QEMU_SRC_DIR
            echo -n "Configure QEMU "
            bg_wait TEE configure $1 $QEMU_VERSION
            if test $(cat $BGEXEC_EXIT_STATUS_FILE) = "0" && test -f $QEMU_SRC_DIR/Makefile ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi

            c_configure >> /dev/null 2>&1 &
            echo -n Configure QEMU C File\ ;wait_pid $!
            if test "$(grep "AIXIAO.ME" vl.c ; echo $?)" = "1" ; then
                echo -ne fail\\n
                exit 3
            else
                echo -ne done\\n
            fi
            : make $MAKE_J >> $BGEXEC_LOG_STATUS_FILE 2>&1 &
            make $MAKE_J >> $LOG 2>&1 &
            echo -n Make QEMU\ ;wait_pid $!
            if test -x $QEMU_SRC_DIR/arm-softmmu/qemu-system-arm ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi
            : make install >> $BGEXEC_LOG_STATUS_FILE 2>&1 &
            make install >> $LOG 2>&1 &
            echo -n Make install QEMU\ ;wait_pid $!
            if test -x $QEMU_PREFIX/bin/qemu-system-arm ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi
        ;;
        qemu-git)
            cd $QEMU_GIT_SRC_DIR
            echo -n "Configure QEMU "
            bg_wait TEE configure $1
            if test $(cat $BGEXEC_EXIT_STATUS_FILE) = "0" && test -f $QEMU_GIT_SRC_DIR/Makefile ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi
            c_configure >> /dev/null 2>&1 &
            echo -n Configure QEMU C File\ ; wait_pid $!
            if test "$(grep "AIXIAO.ME" vl.c ; echo $?)" = "1" ; then
                echo -ne fail\\n
                exit 3
            else
                echo -ne done\\n
            fi
            make $MAKE_J >> $BGEXEC_LOG_STATUS_FILE 2>&1 &
            echo -n Make QEMU\ ;wait_pid $!
            if test -x $QEMU_GIT_SRC_DIR/arm-softmmu/qemu-system-arm ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi
            make install >> $BGEXEC_LOG_STATUS_FILE 2>&1 &
            echo -n Make install QEMU\ ;wait_pid $!
            if test -x $QEMU_PREFIX/bin/qemu-system-arm ; then
                echo -ne done\\n
            else
                echo -ne fail\\n
                exit 3
            fi
        ;;
    esac
    echo -ne -----------------------------\\n
    tar_create
    check_qemu_bin
    echo -e -----------------------------\\nAll Installation Complete\\n-----------------------------\\nProcessed\ in\ $(awk "BEGIN{print `date +%s`-$init_date}")\ second\(s\)
}

init_exec() {
    case "$1" in
        "--help"|"-h")
            cat << HELP
---------------------------
            AQ
Android Qemu
Qq: 1605227279
Qemail: 1605227279@qq.com
Author: aixiao@aixiao.me
---------------------------
-x
    print debug.
---------------------------
--prefix=
    Installation directory.
---------------------------
--qemuversion=
    Qemu Version.
---------------------------
--gitqemu
    Clone source code from GIT repository.
---------------------------
--help
    print help.
---------------------------
HELP
            exit 3
        ;;
        "--prefix")
            test "$2" != "" && QEMU_PREFIX="$2"
        ;;
        "--qemuversion")
            test "$2" != "" && qemu_version="$2"
        ;;
        "--gitqemu")
            GIT_QEMU="0"
        ;;
    esac
}

while getopts :x x; do
    case ${x} in
        x)
            debug=x;
            shift $((OPTIND-1));
            ;;
    esac

done
test "${debug}" = "x" && set -x;

path
VER=1.17
for((i=1;i<=$#;i++)); do
    ini_cfg=${!i}
    ini_cfg_a=`echo $ini_cfg | sed -r s/^-?-?.*=//`
    ini_cfg_b=`echo $ini_cfg | grep -o -E ^-?-?[a-z]+`
    init_exec "$ini_cfg_b" "$ini_cfg_a"
done
init $@
exit
aixiao@aixiao.me.
201904061843
