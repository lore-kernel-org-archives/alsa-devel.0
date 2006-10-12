From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: linux-2.6.19-rc1 (commit c25d5180) build failed
Date: Thu, 12 Oct 2006 16:50:13 +0200
Message-ID: <200610121650.15565.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0381360422=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 81E60120
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Oct 2006 16:50:19 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0381360422==
Content-Type: multipart/signed; boundary="nextPart6528198.K9XUvgEHnz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6528198.K9XUvgEHnz
Content-Type: multipart/mixed;
  boundary="Boundary-01=_lYlLFWY6XL+FjLt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_lYlLFWY6XL+FjLt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

the build with the attached .config failed :

git log :

commit c25d5180441e344a3368d100c57f0a481c6944f7
Merge: 0ca9caa... 9a244b9...
Author: Linus Torvalds <torvalds@g5.osdl.org>

last 16 lines from make :...

WARNING: "snd_opl3_create" [sound/isa/ad1816a/snd-ad1816a.ko] undefined!
WARNING: "snd_timer_interrupt" [sound/isa/ad1816a/snd-ad1816a.ko] undefined!
WARNING: "snd_opl3_create" [sound/drivers/opl4/snd-opl4-lib.ko] undefined!
WARNING: "snd_opl3_reset" [sound/drivers/opl3/snd-opl3-synth.ko] undefined!
WARNING: "snd_opl3_regmap" [sound/drivers/opl3/snd-opl3-synth.ko] undefined!
WARNING: "snd_timer_new" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_interrupt" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_notify" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_pause" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_resolution" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_start" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_open" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_close" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_stop" [sound/core/seq/snd-seq.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
output of ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux n22 2.6.17-gentoo-r8 #4 Tue Sep 19 19:17:45 CEST 2006 i686 Intel(R) P=
entium(R) M processor 1700MHz GNU/Linux
=20
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         loop cpufreq_ondemand ipt_MASQUERADE xt_multiport ip=
t_REJECT xt_tcpudp ip_conntrack_irc ip_conntrack_ftp xt_state xt_limit ipt_=
LOG iptable_nat ip_nat ip_conntrack iptable_filter ip_tables x_tables nls_i=
so8859_1 cifs af_packet snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_=
event snd_seq snd_seq_device radeon drm 8250_pnp psmouse e1000 radeonfb i2c=
_algo_bit cfbcopyarea cfbimgblt cfbfillrect i2c_core 8250_pci 8250 serial_c=
ore snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_page_alloc ehci_hc=
d usbhid uhci_hcd intel_agp agpgart usbcore nls_iso8859_15 nls_cp437 vfat f=
at nls_base nvram snd_rtctimer snd_timer snd soundcore rtc ibm_acpi speedst=
ep_centrino freq_table video thermal processor fan button battery ac fbcon =
crc32 font bitblit softcursor fb

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc1
# Thu Oct 12 15:02:24 2006
#
CONFIG_X86_32=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_DMI=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
CONFIG_BSD_PROCESS_ACCT=3Dy
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_IKCONFIG=3Dy
# CONFIG_IKCONFIG_PROC is not set
CONFIG_RELAY=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_EXTRA_PASS=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Block layer
#
CONFIG_BLOCK=3Dy
CONFIG_LBD=3Dy
CONFIG_BLK_DEV_IO_TRACE=3Dy
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=3Dm
CONFIG_IOSCHED_CFQ=3Dm
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=3Dy
CONFIG_DEFAULT_IOSCHED=3D"noop"

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
# CONFIG_HPET_TIMER is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
CONFIG_VM86=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=3Dm
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dm

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=3Dy
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_HIGHMEM=3Dy
CONFIG_X86_PAE=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_RESOURCES_64BIT=3Dy
# CONFIG_HIGHPTE is not set
CONFIG_MATH_EMULATION=3Dy
# CONFIG_MTRR is not set
CONFIG_REGPARM=3Dy
CONFIG_SECCOMP=3Dy
CONFIG_HZ_100=3Dy
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D100
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=3D0x100000
CONFIG_COMPAT_VDSO=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_PCI is not set
CONFIG_ISA_DMA_API=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_SCx200=3Dm
CONFIG_SCx200HR_TIMER=3Dm

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_NETDEBUG=3Dy
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE=3Dy
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dm
CONFIG_TCP_CONG_WESTWOOD=3Dm
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
CONFIG_DEFAULT_RENO=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"reno"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
CONFIG_BRIDGE=3Dy
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=3Dy
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=3Dm
# CONFIG_DEV_APPLETALK is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
# CONFIG_NET_SCH_CLK_JIFFIES is not set
CONFIG_NET_SCH_CLK_GETTIMEOFDAY=3Dy
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_PRIO=3Dy
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFQ=3Dm
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=3Dy
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=3Dy
# CONFIG_NET_SCH_INGRESS is not set

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
# CONFIG_CLS_U32_PERF is not set
CONFIG_NET_CLS_RSVP=3Dy
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=3Dy
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=3Dm
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_PEDIT=3Dm
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_ESTIMATOR=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dy
CONFIG_AX25_DAMA_SLAVE=3Dy
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=3Dy
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dm
# CONFIG_DMASCC is not set
CONFIG_SCC=3Dm
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=3Dy
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_BAYCOM_PAR=3Dy
CONFIG_BAYCOM_EPP=3Dy
CONFIG_YAM=3Dm
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
# CONFIG_IRCOMM is not set
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
CONFIG_IRDA_DEBUG=3Dy

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_NSC_FIR=3Dm
# CONFIG_WINBOND_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=3Dy
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dm
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=3Dy
# CONFIG_BT_BNEP_MC_FILTER is not set
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_CMTP=3Dm
CONFIG_BT_HIDP=3Dy

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUART=3Dm
# CONFIG_BT_HCIUART_H4 is not set
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_IEEE80211=3Dm
CONFIG_IEEE80211_DEBUG=3Dy
CONFIG_IEEE80211_CRYPT_WEP=3Dm
# CONFIG_IEEE80211_CRYPT_CCMP is not set
CONFIG_IEEE80211_CRYPT_TKIP=3Dm
CONFIG_WIRELESS_EXT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=3Dm

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_NOT_PC=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=3Dy
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
CONFIG_BLK_DEV_XD=3Dm
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=3Dy
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
CONFIG_ATA_OVER_ETH=3Dy

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dm

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_CMD640_ENHANCED=3Dy
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_IDE_ARM is not set
CONFIG_IDE_CHIPSETS=3Dy

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=3Dm
CONFIG_BLK_DEV_DTC2278=3Dm
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dy
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=3Dy
CONFIG_SCSI_SAS_ATTRS=3Dy
CONFIG_SCSI_SAS_LIBSAS=3Dy
CONFIG_SCSI_SAS_LIBSAS_DEBUG=3Dy

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_7000FASST is not set
CONFIG_SCSI_AHA152X=3Dy
CONFIG_SCSI_AHA1542=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_IN2000=3Dm
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_DTC3280=3Dy
CONFIG_SCSI_EATA=3Dy
CONFIG_SCSI_EATA_TAGGED_QUEUE=3Dy
CONFIG_SCSI_EATA_LINKED_COMMANDS=3Dy
CONFIG_SCSI_EATA_MAX_TAGS=3D16
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
CONFIG_SCSI_GENERIC_NCR5380_MMIO=3Dm
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=3Dm
CONFIG_SCSI_IZIP_EPP16=3Dy
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_PAS16 is not set
CONFIG_SCSI_PSI240I=3Dm
CONFIG_SCSI_QLOGIC_FAS=3Dm
CONFIG_SCSI_SYM53C416=3Dm
# CONFIG_SCSI_T128 is not set
CONFIG_SCSI_U14_34F=3Dm
CONFIG_SCSI_U14_34F_TAGGED_QUEUE=3Dy
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=3D8
# CONFIG_SCSI_ULTRASTOR is not set
CONFIG_SCSI_DEBUG=3Dy

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=3Dm
# CONFIG_PATA_QDI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
# CONFIG_IFB is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
# CONFIG_TUN is not set
CONFIG_NET_SB1000=3Dy

#
# ARCnet devices
#
CONFIG_ARCNET=3Dm
CONFIG_ARCNET_1201=3Dm
CONFIG_ARCNET_1051=3Dm
# CONFIG_ARCNET_RAW is not set
CONFIG_ARCNET_CAP=3Dm
CONFIG_ARCNET_COM90xx=3Dm
CONFIG_ARCNET_COM90xxIO=3Dm
CONFIG_ARCNET_RIM_I=3Dm
# CONFIG_ARCNET_COM20020 is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy
# CONFIG_NET_WIRELESS_RTNETLINK is not set

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
CONFIG_ARLAN=3Dy
CONFIG_WAVELAN=3Dm

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_NET_WIRELESS=3Dy

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dy
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLHC=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
CONFIG_ISDN=3Dm

#
# Old ISDN4Linux
#
# CONFIG_ISDN_I4L is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=3Dm
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
# CONFIG_ISDN_CAPI_CAPI20 is not set

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=3Dy
# CONFIG_ISDN_DRV_AVMB1_B1ISA is not set
CONFIG_ISDN_DRV_AVMB1_T1ISA=3Dm
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set

#
# Active Eicon DIVA Server cards
#
CONFIG_CAPI_EICON=3Dy

#
# Telephony Support
#
CONFIG_PHONE=3Dy
CONFIG_PHONE_IXJ=3Dy

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_TSDEV=3Dy
CONFIG_INPUT_TSDEV_SCREEN_X=3D240
CONFIG_INPUT_TSDEV_SCREEN_Y=3D320
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=3Dy
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=3Dy
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=3Dy
CONFIG_JOYSTICK_COBRA=3Dm
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=3Dy
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dy
CONFIG_JOYSTICK_TMDC=3Dy
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_232=3Dy
CONFIG_JOYSTICK_WARRIOR=3Dy
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dy
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dy
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_JOYDUMP=3Dm
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_WISTRON_BTNS=3Dy
CONFIG_INPUT_UINPUT=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dy
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dy
CONFIG_GAMEPORT=3Dy
CONFIG_GAMEPORT_NS558=3Dy
CONFIG_GAMEPORT_L4=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_PNP=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
CONFIG_PPDEV=3Dm
CONFIG_TIPAR=3Dy

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=3Dy
CONFIG_HW_RANDOM_VIA=3Dy
CONFIG_NVRAM=3Dm
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
CONFIG_DTLK=3Dy
CONFIG_R3964=3Dy

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=3Dm
CONFIG_NSC_GPIO=3Dm
CONFIG_CS5535_GPIO=3Dm
CONFIG_RAW_DRIVER=3Dy
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HANGCHECK_TIMER=3Dm

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
CONFIG_SPI=3Dy
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#

#
# SPI Protocol Masters
#

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
CONFIG_BACKLIGHT_DEVICE=3Dy
# CONFIG_LCD_CLASS_DEVICE is not set

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dy
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dy
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dy
CONFIG_SND_OPL4_LIB=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_MTS64=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# ISA devices
#
CONFIG_SND_AD1848_LIB=3Dm
CONFIG_SND_CS4231_LIB=3Dm
CONFIG_SND_ADLIB=3Dy
CONFIG_SND_AD1816A=3Dm
# CONFIG_SND_AD1848 is not set
CONFIG_SND_ALS100=3Dm
CONFIG_SND_AZT2320=3Dm
CONFIG_SND_CMI8330=3Dm
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4232=3Dm
# CONFIG_SND_CS4236 is not set
CONFIG_SND_DT019X=3Dm
CONFIG_SND_ES968=3Dm
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
CONFIG_SND_GUS_SYNTH=3Dm
CONFIG_SND_GUSCLASSIC=3Dm
CONFIG_SND_GUSEXTREME=3Dm
CONFIG_SND_GUSMAX=3Dm
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
CONFIG_SND_OPTI92X_AD1848=3Dm
CONFIG_SND_OPTI92X_CS4231=3Dm
CONFIG_SND_OPTI93X=3Dm
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
CONFIG_SND_SSCAPE=3Dm
CONFIG_SND_WAVEFRONT=3Dm

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=3Dy
CONFIG_MMC_DEBUG=3Dy
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_WBSD=3Dy

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=3Dy

#
# DMA Clients
#
CONFIG_NET_DMA=3Dy

#
# DMA Devices
#

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=3Dy
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=3Dy
CONFIG_OCFS2_FS=3Dm
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_MINIX_FS=3Dy
CONFIG_ROMFS_FS=3Dm
# CONFIG_INOTIFY is not set
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_NTFS_FS=3Dy
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
CONFIG_CONFIGFS_FS=3Dm

#
# Miscellaneous filesystems
#
CONFIG_HFSPLUS_FS=3Dm
# CONFIG_CRAMFS is not set
CONFIG_VXFS_FS=3Dm
CONFIG_HPFS_FS=3Dm
CONFIG_QNX4FS_FS=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dy
# CONFIG_UFS_DEBUG is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=3Dy
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=3Dy
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=3Dy
CONFIG_LDM_DEBUG=3Dy
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=3Dy
CONFIG_NLS_CODEPAGE_936=3Dy
CONFIG_NLS_CODEPAGE_950=3Dy
CONFIG_NLS_CODEPAGE_932=3Dy
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dm
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=3Dm
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dy
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_UNWIND_INFO is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DOUBLEFAULT=3Dy

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_WP512=3Dm
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_ECB is not set
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_TWOFISH_COMMON=3Dy
CONFIG_CRYPTO_TWOFISH_586=3Dm
CONFIG_CRYPTO_SERPENT=3Dy
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_TEST=3Dm

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dy
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dy
CONFIG_AUDIT_GENERIC=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_PLIST=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_KTIME_SCALAR=3Dy



=2D------------------------------------------------------

=2D-=20
MfG/Sincerely
Toralf F=F6rster

--Boundary-01=_lYlLFWY6XL+FjLt
Content-Type: text/plain;
	name="linux-2.6.19-rc1 (commit c25d5180) build failed"
Content-Transfer-Encoding: quoted-printable

Hello,

the build with the attached .config failed :

git log :

commit c25d5180441e344a3368d100c57f0a481c6944f7
Merge: 0ca9caa... 9a244b9...
Author: Linus Torvalds <torvalds@g5.osdl.org>

last 16 lines from make :...

WARNING: "snd_opl3_create" [sound/isa/ad1816a/snd-ad1816a.ko] undefined!
WARNING: "snd_timer_interrupt" [sound/isa/ad1816a/snd-ad1816a.ko] undefined!
WARNING: "snd_opl3_create" [sound/drivers/opl4/snd-opl4-lib.ko] undefined!
WARNING: "snd_opl3_reset" [sound/drivers/opl3/snd-opl3-synth.ko] undefined!
WARNING: "snd_opl3_regmap" [sound/drivers/opl3/snd-opl3-synth.ko] undefined!
WARNING: "snd_timer_new" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_interrupt" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_notify" [sound/core/snd-pcm.ko] undefined!
WARNING: "snd_timer_pause" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_resolution" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_start" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_open" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_close" [sound/core/seq/snd-seq.ko] undefined!
WARNING: "snd_timer_stop" [sound/core/seq/snd-seq.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
output of ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux n22 2.6.17-gentoo-r8 #4 Tue Sep 19 19:17:45 CEST 2006 i686 Intel(R) P=
entium(R) M processor 1700MHz GNU/Linux
=20
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         loop cpufreq_ondemand ipt_MASQUERADE xt_multiport ip=
t_REJECT xt_tcpudp ip_conntrack_irc ip_conntrack_ftp xt_state xt_limit ipt_=
LOG iptable_nat ip_nat ip_conntrack iptable_filter ip_tables x_tables nls_i=
so8859_1 cifs af_packet snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_=
event snd_seq snd_seq_device radeon drm 8250_pnp psmouse e1000 radeonfb i2c=
_algo_bit cfbcopyarea cfbimgblt cfbfillrect i2c_core 8250_pci 8250 serial_c=
ore snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_page_alloc ehci_hc=
d usbhid uhci_hcd intel_agp agpgart usbcore nls_iso8859_15 nls_cp437 vfat f=
at nls_base nvram snd_rtctimer snd_timer snd soundcore rtc ibm_acpi speedst=
ep_centrino freq_table video thermal processor fan button battery ac fbcon =
crc32 font bitblit softcursor fb

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc1
# Thu Oct 12 15:02:24 2006
#
CONFIG_X86_32=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_DMI=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
CONFIG_BSD_PROCESS_ACCT=3Dy
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_IKCONFIG=3Dy
# CONFIG_IKCONFIG_PROC is not set
CONFIG_RELAY=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_EXTRA_PASS=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Block layer
#
CONFIG_BLOCK=3Dy
CONFIG_LBD=3Dy
CONFIG_BLK_DEV_IO_TRACE=3Dy
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=3Dm
CONFIG_IOSCHED_CFQ=3Dm
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=3Dy
CONFIG_DEFAULT_IOSCHED=3D"noop"

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
# CONFIG_HPET_TIMER is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
CONFIG_VM86=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=3Dm
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dm

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=3Dy
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_HIGHMEM=3Dy
CONFIG_X86_PAE=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_RESOURCES_64BIT=3Dy
# CONFIG_HIGHPTE is not set
CONFIG_MATH_EMULATION=3Dy
# CONFIG_MTRR is not set
CONFIG_REGPARM=3Dy
CONFIG_SECCOMP=3Dy
CONFIG_HZ_100=3Dy
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D100
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=3D0x100000
CONFIG_COMPAT_VDSO=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_PCI is not set
CONFIG_ISA_DMA_API=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_SCx200=3Dm
CONFIG_SCx200HR_TIMER=3Dm

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_NETDEBUG=3Dy
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE=3Dy
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dm
CONFIG_TCP_CONG_WESTWOOD=3Dm
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
CONFIG_DEFAULT_RENO=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"reno"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
CONFIG_BRIDGE=3Dy
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=3Dy
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=3Dm
# CONFIG_DEV_APPLETALK is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
# CONFIG_NET_SCH_CLK_JIFFIES is not set
CONFIG_NET_SCH_CLK_GETTIMEOFDAY=3Dy
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_PRIO=3Dy
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFQ=3Dm
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=3Dy
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=3Dy
# CONFIG_NET_SCH_INGRESS is not set

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
# CONFIG_CLS_U32_PERF is not set
CONFIG_NET_CLS_RSVP=3Dy
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=3Dy
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=3Dm
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_PEDIT=3Dm
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_ESTIMATOR=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dy
CONFIG_AX25_DAMA_SLAVE=3Dy
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=3Dy
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dm
# CONFIG_DMASCC is not set
CONFIG_SCC=3Dm
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=3Dy
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_BAYCOM_PAR=3Dy
CONFIG_BAYCOM_EPP=3Dy
CONFIG_YAM=3Dm
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
# CONFIG_IRCOMM is not set
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
CONFIG_IRDA_DEBUG=3Dy

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_NSC_FIR=3Dm
# CONFIG_WINBOND_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=3Dy
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dm
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=3Dy
# CONFIG_BT_BNEP_MC_FILTER is not set
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_CMTP=3Dm
CONFIG_BT_HIDP=3Dy

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUART=3Dm
# CONFIG_BT_HCIUART_H4 is not set
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_IEEE80211=3Dm
CONFIG_IEEE80211_DEBUG=3Dy
CONFIG_IEEE80211_CRYPT_WEP=3Dm
# CONFIG_IEEE80211_CRYPT_CCMP is not set
CONFIG_IEEE80211_CRYPT_TKIP=3Dm
CONFIG_WIRELESS_EXT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=3Dm

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_NOT_PC=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=3Dy
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
CONFIG_BLK_DEV_XD=3Dm
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=3Dy
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
CONFIG_ATA_OVER_ETH=3Dy

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dm

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_CMD640_ENHANCED=3Dy
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_IDE_ARM is not set
CONFIG_IDE_CHIPSETS=3Dy

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=3Dm
CONFIG_BLK_DEV_DTC2278=3Dm
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dy
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=3Dy
CONFIG_SCSI_SAS_ATTRS=3Dy
CONFIG_SCSI_SAS_LIBSAS=3Dy
CONFIG_SCSI_SAS_LIBSAS_DEBUG=3Dy

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_7000FASST is not set
CONFIG_SCSI_AHA152X=3Dy
CONFIG_SCSI_AHA1542=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_IN2000=3Dm
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_DTC3280=3Dy
CONFIG_SCSI_EATA=3Dy
CONFIG_SCSI_EATA_TAGGED_QUEUE=3Dy
CONFIG_SCSI_EATA_LINKED_COMMANDS=3Dy
CONFIG_SCSI_EATA_MAX_TAGS=3D16
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
CONFIG_SCSI_GENERIC_NCR5380_MMIO=3Dm
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=3Dm
CONFIG_SCSI_IZIP_EPP16=3Dy
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_PAS16 is not set
CONFIG_SCSI_PSI240I=3Dm
CONFIG_SCSI_QLOGIC_FAS=3Dm
CONFIG_SCSI_SYM53C416=3Dm
# CONFIG_SCSI_T128 is not set
CONFIG_SCSI_U14_34F=3Dm
CONFIG_SCSI_U14_34F_TAGGED_QUEUE=3Dy
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=3D8
# CONFIG_SCSI_ULTRASTOR is not set
CONFIG_SCSI_DEBUG=3Dy

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=3Dm
# CONFIG_PATA_QDI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
# CONFIG_IFB is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
# CONFIG_TUN is not set
CONFIG_NET_SB1000=3Dy

#
# ARCnet devices
#
CONFIG_ARCNET=3Dm
CONFIG_ARCNET_1201=3Dm
CONFIG_ARCNET_1051=3Dm
# CONFIG_ARCNET_RAW is not set
CONFIG_ARCNET_CAP=3Dm
CONFIG_ARCNET_COM90xx=3Dm
CONFIG_ARCNET_COM90xxIO=3Dm
CONFIG_ARCNET_RIM_I=3Dm
# CONFIG_ARCNET_COM20020 is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy
# CONFIG_NET_WIRELESS_RTNETLINK is not set

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
CONFIG_ARLAN=3Dy
CONFIG_WAVELAN=3Dm

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_NET_WIRELESS=3Dy

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dy
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLHC=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
CONFIG_ISDN=3Dm

#
# Old ISDN4Linux
#
# CONFIG_ISDN_I4L is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=3Dm
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
# CONFIG_ISDN_CAPI_CAPI20 is not set

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=3Dy
# CONFIG_ISDN_DRV_AVMB1_B1ISA is not set
CONFIG_ISDN_DRV_AVMB1_T1ISA=3Dm
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set

#
# Active Eicon DIVA Server cards
#
CONFIG_CAPI_EICON=3Dy

#
# Telephony Support
#
CONFIG_PHONE=3Dy
CONFIG_PHONE_IXJ=3Dy

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_TSDEV=3Dy
CONFIG_INPUT_TSDEV_SCREEN_X=3D240
CONFIG_INPUT_TSDEV_SCREEN_Y=3D320
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=3Dy
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=3Dy
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=3Dy
CONFIG_JOYSTICK_COBRA=3Dm
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=3Dy
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dy
CONFIG_JOYSTICK_TMDC=3Dy
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_232=3Dy
CONFIG_JOYSTICK_WARRIOR=3Dy
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dy
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dy
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_JOYDUMP=3Dm
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_WISTRON_BTNS=3Dy
CONFIG_INPUT_UINPUT=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dy
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dy
CONFIG_GAMEPORT=3Dy
CONFIG_GAMEPORT_NS558=3Dy
CONFIG_GAMEPORT_L4=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_PNP=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
CONFIG_PPDEV=3Dm
CONFIG_TIPAR=3Dy

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=3Dy
CONFIG_HW_RANDOM_VIA=3Dy
CONFIG_NVRAM=3Dm
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
CONFIG_DTLK=3Dy
CONFIG_R3964=3Dy

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=3Dm
CONFIG_NSC_GPIO=3Dm
CONFIG_CS5535_GPIO=3Dm
CONFIG_RAW_DRIVER=3Dy
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HANGCHECK_TIMER=3Dm

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
CONFIG_SPI=3Dy
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#

#
# SPI Protocol Masters
#

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
CONFIG_BACKLIGHT_DEVICE=3Dy
# CONFIG_LCD_CLASS_DEVICE is not set

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dy
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dy
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dy
CONFIG_SND_OPL4_LIB=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_MTS64=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# ISA devices
#
CONFIG_SND_AD1848_LIB=3Dm
CONFIG_SND_CS4231_LIB=3Dm
CONFIG_SND_ADLIB=3Dy
CONFIG_SND_AD1816A=3Dm
# CONFIG_SND_AD1848 is not set
CONFIG_SND_ALS100=3Dm
CONFIG_SND_AZT2320=3Dm
CONFIG_SND_CMI8330=3Dm
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4232=3Dm
# CONFIG_SND_CS4236 is not set
CONFIG_SND_DT019X=3Dm
CONFIG_SND_ES968=3Dm
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
CONFIG_SND_GUS_SYNTH=3Dm
CONFIG_SND_GUSCLASSIC=3Dm
CONFIG_SND_GUSEXTREME=3Dm
CONFIG_SND_GUSMAX=3Dm
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
CONFIG_SND_OPTI92X_AD1848=3Dm
CONFIG_SND_OPTI92X_CS4231=3Dm
CONFIG_SND_OPTI93X=3Dm
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
CONFIG_SND_SSCAPE=3Dm
CONFIG_SND_WAVEFRONT=3Dm

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=3Dy
CONFIG_MMC_DEBUG=3Dy
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_WBSD=3Dy

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=3Dy

#
# DMA Clients
#
CONFIG_NET_DMA=3Dy

#
# DMA Devices
#

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=3Dy
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=3Dy
CONFIG_OCFS2_FS=3Dm
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_MINIX_FS=3Dy
CONFIG_ROMFS_FS=3Dm
# CONFIG_INOTIFY is not set
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_NTFS_FS=3Dy
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
CONFIG_CONFIGFS_FS=3Dm

#
# Miscellaneous filesystems
#
CONFIG_HFSPLUS_FS=3Dm
# CONFIG_CRAMFS is not set
CONFIG_VXFS_FS=3Dm
CONFIG_HPFS_FS=3Dm
CONFIG_QNX4FS_FS=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dy
# CONFIG_UFS_DEBUG is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=3Dy
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=3Dy
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=3Dy
CONFIG_LDM_DEBUG=3Dy
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=3Dy
CONFIG_NLS_CODEPAGE_936=3Dy
CONFIG_NLS_CODEPAGE_950=3Dy
CONFIG_NLS_CODEPAGE_932=3Dy
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dm
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=3Dm
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dy
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_UNWIND_INFO is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DOUBLEFAULT=3Dy

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_WP512=3Dm
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_ECB is not set
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_TWOFISH_COMMON=3Dy
CONFIG_CRYPTO_TWOFISH_586=3Dm
CONFIG_CRYPTO_SERPENT=3Dy
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_TEST=3Dm

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dy
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dy
CONFIG_AUDIT_GENERIC=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_PLIST=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_KTIME_SCALAR=3Dy


--Boundary-01=_lYlLFWY6XL+FjLt--

--nextPart6528198.K9XUvgEHnz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLlYnhyrlCH22naMRAnioAJ9/Q5lmVdcm2OoO4BKf1yYt32NC2ACggI7A
T4cLNVAYRr0etFnM5Uq+icU=
=xOsY
-----END PGP SIGNATURE-----

--nextPart6528198.K9XUvgEHnz--


--===============0381360422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0381360422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0381360422==--
