From: Saurav SAHU <saurav.sahu@st.com>
Subject: Re: ALSA utility aplay/arecord error
Date: Mon, 10 Mar 2008 11:59:04 +0800
Message-ID: <009601c88263$16950fe0$7c70500a@amk.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0092_01C882A6.22E38FE0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog17.obsmtp.com (s200aog17.obsmtp.com [207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id D28852470D
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 04:59:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0092_01C882A6.22E38FE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all

The platform on which I am trying to perform ALSA playback and record =
with USB sound device is based on a MIPS CPU running Linux kernel =
2.6.14. The kernel uses non-coherent DMA in the configuration:
  CONFIG_DMA_NONCOHERENT=3Dy
  CONFIG_DMA_NEED_PCI_MAP_STATE=3Dy
  CONFIG_CPU_BIG_ENDIAN=3Dy
  CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy
  CONFIG_BOOT_ELF32=3Dy
  CONFIG_MIPS_L1_CACHE_SHIFT=3D5
I have attached the kernel .config file for further information. So far, =
I have not succeeded in hearing sound with 'aplay', or capturing sound =
with 'arecord'.

If there have been any similar issues reported on ALSA usage with MIPS =
CPU based on non-coherent DMA in the past, please let me know. Also, if =
there have been any patches developed for successful resolution of this =
issue on similar platform/configuration, it would be very useful for me.

Thanks & Regards
Saurav

  ----- Original Message -----=20
  From: Saurav Sahu=20
  To: alsa-user@lists.sourceforge.net=20
  Sent: Friday, March 07, 2008 4:33 PM
  Subject: Re: ALSA utility aplay/arecord error


  I have been able to resolve the previously reported errors by setting =
the environment variable for ALSA configuration file on the target =
filesystem of the embedded platform.

  However, I do not hear any audio from USB sound device with =
speaker-test or aplay:

  Upon using arecord for recording, I get an error:

  Is this problem related to a low-level driver issue which may not be =
working well on target platform? Could there be a DMA related issue as =
the samples don't seem to be transferred to the USB audio device.


    ----- Original Message -----=20
    From: Saurav Sahu=20
    To: alsa-user@lists.sourceforge.net=20
    Sent: Thursday, March 06, 2008 4:28 PM
    Subject: ALSA utility aplay/arecord error


    Hello

    I am working towards using ALSA for playback and capture on an =
embedded platform running Linux. The kernel uses ALSA driver version =
1.0.10rc1. I had manually built and installed ALSA library (v1.0.10) and =
ALSA utilities (v1.0.10) for the target platform filesystem. I have a =
USB audio device (C-Media) connected to the USB port of the board and it =
seems to be successfully successfully detected by the driver.

    However, when I run ALSA utilities like aplay, arecord or =
speaker-test, I observe errors opening the hardware device which may be =
related to the configuration on the filesystem.

    Are these errors from ALSA utility/library due to the detection of =
hardware, ALSA configuration files or something else related to my =
target device filesystem?

    Thanks in advance for any help. Do let me know if you need any more =
details.

    Best Regards
    Saurav

------=_NextPart_000_0092_01C882A6.22E38FE0
Content-Type: application/octet-stream;
	name="dotconfigmips"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dotconfigmips"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.14=0A=
# Tue Mar  4 12:24:22 2008=0A=
#=0A=
CONFIG_MIPS=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_LOCALVERSION_AUTO=3Dy=0A=
# CONFIG_SWAP is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_POSIX_MQUEUE is not set=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
# CONFIG_IKCONFIG is not set=0A=
CONFIG_RELAY=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
CONFIG_EMBEDDED=3Dy=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_KALLSYMS_ALL=3Dy=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_PRINTK=3Dy=0A=
CONFIG_BUG=3Dy=0A=
CONFIG_BASE_FULL=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
# CONFIG_TINY_SHMEM is not set=0A=
CONFIG_BASE_SMALL=3D0=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_MODULE_SRCVERSION_ALL=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Machine selection=0A=
#=0A=
# CONFIG_MIPS_MTX1 is not set=0A=
# CONFIG_MIPS_BOSPORUS is not set=0A=
# CONFIG_MIPS_PB1000 is not set=0A=
# CONFIG_MIPS_PB1100 is not set=0A=
# CONFIG_MIPS_PB1500 is not set=0A=
# CONFIG_MIPS_PB1550 is not set=0A=
# CONFIG_MIPS_PB1200 is not set=0A=
# CONFIG_MIPS_DB1000 is not set=0A=
# CONFIG_MIPS_DB1100 is not set=0A=
# CONFIG_MIPS_DB1500 is not set=0A=
# CONFIG_MIPS_DB1550 is not set=0A=
# CONFIG_MIPS_DB1200 is not set=0A=
# CONFIG_MIPS_MIRAGE is not set=0A=
# CONFIG_MIPS_COBALT is not set=0A=
# CONFIG_MACH_DECSTATION is not set=0A=
# CONFIG_MIPS_EV64120 is not set=0A=
# CONFIG_MIPS_EV96100 is not set=0A=
# CONFIG_MIPS_IVR is not set=0A=
# CONFIG_MIPS_ITE8172 is not set=0A=
# CONFIG_MACH_JAZZ is not set=0A=
# CONFIG_LASAT is not set=0A=
# CONFIG_MIPS_ATLAS is not set=0A=
# CONFIG_MIPS_MALTA is not set=0A=
CONFIG_POWERTV=3Dy=0A=
# CONFIG_MIPS_SEAD is not set=0A=
# CONFIG_MIPS_SIM is not set=0A=
# CONFIG_MOMENCO_JAGUAR_ATX is not set=0A=
# CONFIG_MOMENCO_OCELOT is not set=0A=
# CONFIG_MOMENCO_OCELOT_3 is not set=0A=
# CONFIG_MOMENCO_OCELOT_C is not set=0A=
# CONFIG_MOMENCO_OCELOT_G is not set=0A=
# CONFIG_MIPS_XXS1500 is not set=0A=
# CONFIG_PNX8550_V2PCI is not set=0A=
# CONFIG_PNX8550_JBS is not set=0A=
# CONFIG_DDB5074 is not set=0A=
# CONFIG_DDB5476 is not set=0A=
# CONFIG_DDB5477 is not set=0A=
# CONFIG_MACH_VR41XX is not set=0A=
# CONFIG_PMC_YOSEMITE is not set=0A=
# CONFIG_QEMU is not set=0A=
# CONFIG_SGI_IP22 is not set=0A=
# CONFIG_SGI_IP27 is not set=0A=
# CONFIG_SGI_IP32 is not set=0A=
# CONFIG_SIBYTE_BIGSUR is not set=0A=
# CONFIG_SIBYTE_SWARM is not set=0A=
# CONFIG_SIBYTE_SENTOSA is not set=0A=
# CONFIG_SIBYTE_RHONE is not set=0A=
# CONFIG_SIBYTE_CARMEL is not set=0A=
# CONFIG_SIBYTE_PTSWARM is not set=0A=
# CONFIG_SIBYTE_LITTLESUR is not set=0A=
# CONFIG_SIBYTE_CRHINE is not set=0A=
# CONFIG_SIBYTE_CRHONE is not set=0A=
# CONFIG_SNI_RM200_PCI is not set=0A=
# CONFIG_TOSHIBA_JMR3927 is not set=0A=
# CONFIG_TOSHIBA_RBTX4927 is not set=0A=
# CONFIG_TOSHIBA_RBTX4938 is not set=0A=
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_DMA_NONCOHERENT=3Dy=0A=
CONFIG_DMA_NEED_PCI_MAP_STATE=3Dy=0A=
CONFIG_CPU_BIG_ENDIAN=3Dy=0A=
# CONFIG_CPU_LITTLE_ENDIAN is not set=0A=
CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy=0A=
CONFIG_BOOT_ELF32=3Dy=0A=
CONFIG_MIPS_L1_CACHE_SHIFT=3D5=0A=
=0A=
#=0A=
# CPU selection=0A=
#=0A=
# CONFIG_CPU_MIPS32_R1 is not set=0A=
CONFIG_CPU_MIPS32_R2=3Dy=0A=
# CONFIG_CPU_MIPS64_R1 is not set=0A=
# CONFIG_CPU_MIPS64_R2 is not set=0A=
# CONFIG_CPU_R3000 is not set=0A=
# CONFIG_CPU_TX39XX is not set=0A=
# CONFIG_CPU_VR41XX is not set=0A=
# CONFIG_CPU_R4300 is not set=0A=
# CONFIG_CPU_R4X00 is not set=0A=
# CONFIG_CPU_TX49XX is not set=0A=
# CONFIG_CPU_R5000 is not set=0A=
# CONFIG_CPU_R5432 is not set=0A=
# CONFIG_CPU_R6000 is not set=0A=
# CONFIG_CPU_NEVADA is not set=0A=
# CONFIG_CPU_R8000 is not set=0A=
# CONFIG_CPU_R10000 is not set=0A=
# CONFIG_CPU_RM7000 is not set=0A=
# CONFIG_CPU_RM9000 is not set=0A=
# CONFIG_CPU_SB1 is not set=0A=
CONFIG_SYS_HAS_CPU_MIPS32_R2=3Dy=0A=
CONFIG_CPU_MIPS32=3Dy=0A=
CONFIG_CPU_MIPSR2=3Dy=0A=
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy=0A=
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy=0A=
=0A=
#=0A=
# Kernel type=0A=
#=0A=
CONFIG_32BIT=3Dy=0A=
# CONFIG_64BIT is not set=0A=
CONFIG_PAGE_SIZE_4KB=3Dy=0A=
# CONFIG_PAGE_SIZE_8KB is not set=0A=
# CONFIG_PAGE_SIZE_16KB is not set=0A=
# CONFIG_PAGE_SIZE_64KB is not set=0A=
CONFIG_CPU_HAS_PREFETCH=3Dy=0A=
CONFIG_8KG3=3Dy=0A=
# CONFIG_MIPS_MT is not set=0A=
CONFIG_CPU_ADVANCED=3Dy=0A=
# CONFIG_CPU_HAS_LLSC is not set=0A=
# CONFIG_CPU_HAS_LLDSCD is not set=0A=
# CONFIG_CPU_HAS_WB is not set=0A=
=0A=
#=0A=
# MIPSR2 Interrupt handling=0A=
#=0A=
CONFIG_CPU_MIPSR2_IRQ_VI=3Dy=0A=
CONFIG_CPU_MIPSR2_IRQ_EI=3Dy=0A=
CONFIG_CPU_MIPSR2_SRS=3Dy=0A=
CONFIG_CPU_HAS_SYNC=3Dy=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
# CONFIG_HIGHMEM is not set=0A=
CONFIG_CPU_SUPPORTS_HIGHMEM=3Dy=0A=
CONFIG_SYS_SUPPORTS_HIGHMEM=3Dy=0A=
CONFIG_ARCH_FLATMEM_ENABLE=3Dy=0A=
CONFIG_SELECT_MEMORY_MODEL=3Dy=0A=
CONFIG_FLATMEM_MANUAL=3Dy=0A=
# CONFIG_DISCONTIGMEM_MANUAL is not set=0A=
# CONFIG_SPARSEMEM_MANUAL is not set=0A=
CONFIG_FLATMEM=3Dy=0A=
CONFIG_FLAT_NODE_MEM_MAP=3Dy=0A=
# CONFIG_SPARSEMEM_STATIC is not set=0A=
# CONFIG_PREEMPT_NONE is not set=0A=
CONFIG_PREEMPT_VOLUNTARY=3Dy=0A=
# CONFIG_PREEMPT is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, ISA, TC)=0A=
#=0A=
CONFIG_HW_HAS_PCI=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
# CONFIG_PCI_DEBUG is not set=0A=
CONFIG_MMU=3Dy=0A=
=0A=
#=0A=
# PCCARD (PCMCIA/CardBus) support=0A=
#=0A=
# CONFIG_PCCARD is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
CONFIG_TRAD_SIGNALS=3Dy=0A=
=0A=
#=0A=
# Networking=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_ASK_IP_FIB_HASH=3Dy=0A=
# CONFIG_IP_FIB_TRIE is not set=0A=
CONFIG_IP_FIB_HASH=3Dy=0A=
# CONFIG_IP_MULTIPLE_TABLES is not set=0A=
# CONFIG_IP_ROUTE_MULTIPATH is not set=0A=
# CONFIG_IP_ROUTE_VERBOSE is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
# CONFIG_IP_PNP_DHCP is not set=0A=
# CONFIG_IP_PNP_BOOTP is not set=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
# CONFIG_INET_DIAG is not set=0A=
# CONFIG_TCP_CONG_ADVANCED is not set=0A=
CONFIG_TCP_CONG_BIC=3Dy=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
# CONFIG_BRIDGE_NETFILTER is not set=0A=
# CONFIG_NETFILTER_NETLINK is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
# CONFIG_IP_NF_CONNTRACK is not set=0A=
# CONFIG_IP_NF_QUEUE is not set=0A=
CONFIG_IP_NF_IPTABLES=3Dy=0A=
# CONFIG_IP_NF_MATCH_LIMIT is not set=0A=
# CONFIG_IP_NF_MATCH_IPRANGE is not set=0A=
# CONFIG_IP_NF_MATCH_MAC is not set=0A=
# CONFIG_IP_NF_MATCH_PKTTYPE is not set=0A=
# CONFIG_IP_NF_MATCH_MARK is not set=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy=0A=
# CONFIG_IP_NF_MATCH_TOS is not set=0A=
# CONFIG_IP_NF_MATCH_RECENT is not set=0A=
# CONFIG_IP_NF_MATCH_ECN is not set=0A=
# CONFIG_IP_NF_MATCH_DSCP is not set=0A=
# CONFIG_IP_NF_MATCH_AH_ESP is not set=0A=
# CONFIG_IP_NF_MATCH_LENGTH is not set=0A=
# CONFIG_IP_NF_MATCH_TTL is not set=0A=
# CONFIG_IP_NF_MATCH_TCPMSS is not set=0A=
# CONFIG_IP_NF_MATCH_OWNER is not set=0A=
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set=0A=
# CONFIG_IP_NF_MATCH_REALM is not set=0A=
# CONFIG_IP_NF_MATCH_SCTP is not set=0A=
# CONFIG_IP_NF_MATCH_DCCP is not set=0A=
# CONFIG_IP_NF_MATCH_COMMENT is not set=0A=
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set=0A=
# CONFIG_IP_NF_MATCH_STRING is not set=0A=
CONFIG_IP_NF_FILTER=3Dy=0A=
# CONFIG_IP_NF_TARGET_REJECT is not set=0A=
# CONFIG_IP_NF_TARGET_LOG is not set=0A=
# CONFIG_IP_NF_TARGET_ULOG is not set=0A=
# CONFIG_IP_NF_TARGET_TCPMSS is not set=0A=
# CONFIG_IP_NF_TARGET_NFQUEUE is not set=0A=
# CONFIG_IP_NF_MANGLE is not set=0A=
# CONFIG_IP_NF_RAW is not set=0A=
# CONFIG_IP_NF_ARPTABLES is not set=0A=
=0A=
#=0A=
# Bridge: Netfilter Configuration=0A=
#=0A=
CONFIG_BRIDGE_NF_EBTABLES=3Dy=0A=
# CONFIG_BRIDGE_EBT_BROUTE is not set=0A=
# CONFIG_BRIDGE_EBT_T_FILTER is not set=0A=
# CONFIG_BRIDGE_EBT_T_NAT is not set=0A=
# CONFIG_BRIDGE_EBT_802_3 is not set=0A=
# CONFIG_BRIDGE_EBT_AMONG is not set=0A=
# CONFIG_BRIDGE_EBT_ARP is not set=0A=
# CONFIG_BRIDGE_EBT_IP is not set=0A=
# CONFIG_BRIDGE_EBT_LIMIT is not set=0A=
# CONFIG_BRIDGE_EBT_MARK is not set=0A=
# CONFIG_BRIDGE_EBT_PKTTYPE is not set=0A=
# CONFIG_BRIDGE_EBT_STP is not set=0A=
# CONFIG_BRIDGE_EBT_VLAN is not set=0A=
# CONFIG_BRIDGE_EBT_ARPREPLY is not set=0A=
# CONFIG_BRIDGE_EBT_DNAT is not set=0A=
# CONFIG_BRIDGE_EBT_MARK_T is not set=0A=
# CONFIG_BRIDGE_EBT_REDIRECT is not set=0A=
# CONFIG_BRIDGE_EBT_SNAT is not set=0A=
# CONFIG_BRIDGE_EBT_LOG is not set=0A=
# CONFIG_BRIDGE_EBT_ULOG is not set=0A=
=0A=
#=0A=
# DCCP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_DCCP is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
CONFIG_BRIDGE=3Dy=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
CONFIG_NET_SCHED=3Dy=0A=
CONFIG_NET_SCH_CLK_JIFFIES=3Dy=0A=
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set=0A=
# CONFIG_NET_SCH_CLK_CPU is not set=0A=
# CONFIG_NET_SCH_CBQ is not set=0A=
# CONFIG_NET_SCH_HTB is not set=0A=
# CONFIG_NET_SCH_HFSC is not set=0A=
# CONFIG_NET_SCH_PRIO is not set=0A=
# CONFIG_NET_SCH_RED is not set=0A=
# CONFIG_NET_SCH_SFQ is not set=0A=
# CONFIG_NET_SCH_TEQL is not set=0A=
CONFIG_NET_SCH_TBF=3Dy=0A=
# CONFIG_NET_SCH_GRED is not set=0A=
# CONFIG_NET_SCH_DSMARK is not set=0A=
# CONFIG_NET_SCH_NETEM is not set=0A=
# CONFIG_NET_SCH_INGRESS is not set=0A=
# CONFIG_NET_QOS is not set=0A=
# CONFIG_NET_CLS is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
# CONFIG_IEEE80211 is not set=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
CONFIG_FW_LOADER=3Dy=0A=
# CONFIG_DEBUG_DRIVER is not set=0A=
=0A=
#=0A=
# Connector - unified userspace <-> kernelspace linker=0A=
#=0A=
# CONFIG_CONNECTOR is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_DEBUG is not set=0A=
# CONFIG_MTD_CONCAT is not set=0A=
CONFIG_MTD_PARTITIONS=3Dy=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
CONFIG_MTD_CMDLINE_PARTS=3Dy=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
CONFIG_MTD_CHAR=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
# CONFIG_FTL is not set=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
# CONFIG_MTD_CFI is not set=0A=
# CONFIG_MTD_JEDECPROBE is not set=0A=
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_CFI_I4 is not set=0A=
# CONFIG_MTD_CFI_I8 is not set=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
# CONFIG_MTD_PLATRAM is not set=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_PHRAM is not set=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
# CONFIG_MTD_BLOCK2MTD is not set=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
CONFIG_MTD_NAND=3Dy=0A=
# CONFIG_MTD_NAND_VERIFY_WRITE is not set=0A=
CONFIG_MTD_NAND_IDS=3Dy=0A=
# CONFIG_MTD_NAND_DISKONCHIP is not set=0A=
# CONFIG_MTD_NAND_NANDSIM is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
# CONFIG_BLK_DEV_UB is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D45056=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_LBD is not set=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
# CONFIG_IOSCHED_AS is not set=0A=
# CONFIG_IOSCHED_DEADLINE is not set=0A=
# CONFIG_IOSCHED_CFQ is not set=0A=
# CONFIG_ATA_OVER_ETH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_RAID_ATTRS is not set=0A=
CONFIG_SCSI=3Dy=0A=
# CONFIG_SCSI_PROC_FS is not set=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
# CONFIG_BLK_DEV_SD is not set=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
# CONFIG_BLK_DEV_SR is not set=0A=
# CONFIG_CHR_DEV_SG is not set=0A=
# CONFIG_CHR_DEV_SCH is not set=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI Transport Attributes=0A=
#=0A=
# CONFIG_SCSI_SPI_ATTRS is not set=0A=
# CONFIG_SCSI_FC_ATTRS is not set=0A=
# CONFIG_SCSI_ISCSI_ATTRS is not set=0A=
# CONFIG_SCSI_SAS_ATTRS is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_3W_9XXX is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_MEGARAID_NEWGEN is not set=0A=
# CONFIG_MEGARAID_LEGACY is not set=0A=
# CONFIG_MEGARAID_SAS is not set=0A=
# CONFIG_SCSI_SATA is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_IPR is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
CONFIG_SCSI_QLA2XXX=3Dy=0A=
# CONFIG_SCSI_QLA21XX is not set=0A=
# CONFIG_SCSI_QLA22XX is not set=0A=
# CONFIG_SCSI_QLA2300 is not set=0A=
# CONFIG_SCSI_QLA2322 is not set=0A=
# CONFIG_SCSI_QLA6312 is not set=0A=
# CONFIG_SCSI_QLA24XX is not set=0A=
# CONFIG_SCSI_LPFC is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
# CONFIG_FUSION_SPI is not set=0A=
# CONFIG_FUSION_FC is not set=0A=
# CONFIG_FUSION_SAS is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# PHY device support=0A=
#=0A=
# CONFIG_PHYLIB is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_CASSINI is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_PCI is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SIS190 is not set=0A=
# CONFIG_SKGE is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_BNX2 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_CHELSIO_T1 is not set=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
# CONFIG_INPUT_MOUSEDEV is not set=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
CONFIG_INPUT_EVDEV=3Dy=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
# CONFIG_INPUT_KEYBOARD is not set=0A=
# CONFIG_INPUT_MOUSE is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Hardware I/O ports=0A=
#=0A=
# CONFIG_SERIO is not set=0A=
# CONFIG_GAMEPORT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
CONFIG_SERIAL_8250_EXTENDED=3Dy=0A=
# CONFIG_SERIAL_8250_MANY_PORTS is not set=0A=
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A=
# CONFIG_SERIAL_8250_DETECT_IRQ is not set=0A=
# CONFIG_SERIAL_8250_RSA is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_JSM is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# TPM devices=0A=
#=0A=
# CONFIG_TCG_TPM is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Hardware Monitoring support=0A=
#=0A=
# CONFIG_HWMON is not set=0A=
# CONFIG_HWMON_VID is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
=0A=
#=0A=
# Multimedia Capabilities Port drivers=0A=
#=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dm=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dm=0A=
CONFIG_SND_TIMER=3Dm=0A=
CONFIG_SND_PCM=3Dm=0A=
CONFIG_SND_HWDEP=3Dm=0A=
CONFIG_SND_RAWMIDI=3Dm=0A=
# CONFIG_SND_SEQUENCER is not set=0A=
# CONFIG_SND_MIXER_OSS is not set=0A=
# CONFIG_SND_PCM_OSS is not set=0A=
# CONFIG_SND_VERBOSE_PRINTK is not set=0A=
# CONFIG_SND_DEBUG is not set=0A=
=0A=
#=0A=
# Generic devices=0A=
#=0A=
# CONFIG_SND_DUMMY is not set=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
# CONFIG_SND_MPU401 is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_ATIIXP_MODEM is not set=0A=
# CONFIG_SND_AU8810 is not set=0A=
# CONFIG_SND_AU8820 is not set=0A=
# CONFIG_SND_AU8830 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_BT87X is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_EMU10K1X is not set=0A=
# CONFIG_SND_CA0106 is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_MIXART is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_HDSPM is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
# CONFIG_SND_AD1889 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
# CONFIG_SND_ENS1371 is not set=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
# CONFIG_SND_INTEL8X0 is not set=0A=
# CONFIG_SND_INTEL8X0M is not set=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VIA82XX_MODEM is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
# CONFIG_SND_HDA_INTEL is not set=0A=
=0A=
#=0A=
# ALSA MIPS devices=0A=
#=0A=
=0A=
#=0A=
# USB devices=0A=
#=0A=
CONFIG_SND_USB_AUDIO=3Dm=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
# CONFIG_USB_OTG is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_EHCI_HCD=3Dy=0A=
# CONFIG_USB_EHCI_SPLIT_ISO is not set=0A=
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set=0A=
# CONFIG_USB_ISP116X_HCD is not set=0A=
CONFIG_USB_OHCI_HCD=3Dy=0A=
# CONFIG_USB_OHCI_BIG_ENDIAN is not set=0A=
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0A=
# CONFIG_USB_UHCI_HCD is not set=0A=
# CONFIG_USB_SL811_HCD is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be =
needed; see USB_STORAGE Help for more information=0A=
#=0A=
CONFIG_USB_STORAGE=3Dy=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_USBAT is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
# CONFIG_USB_STORAGE_ONETOUCH is not set=0A=
=0A=
#=0A=
# USB Input Devices=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
CONFIG_USB_HIDDEV=3Dy=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_ACECAD is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_ITMTOUCH is not set=0A=
# CONFIG_USB_EGALAX is not set=0A=
# CONFIG_USB_YEALINK is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
# CONFIG_USB_KEYSPAN_REMOTE is not set=0A=
# CONFIG_USB_APPLETOUCH is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network Adapters=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
CONFIG_USB_RTL8150=3Dy=0A=
# CONFIG_USB_USBNET is not set=0A=
# CONFIG_USB_MON is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
CONFIG_USB_SERIAL=3Dy=0A=
CONFIG_USB_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_USB_SERIAL_GENERIC is not set=0A=
# CONFIG_USB_SERIAL_AIRPRIME is not set=0A=
# CONFIG_USB_SERIAL_BELKIN is not set=0A=
# CONFIG_USB_SERIAL_WHITEHEAT is not set=0A=
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set=0A=
CONFIG_USB_SERIAL_CP2101=3Dy=0A=
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set=0A=
# CONFIG_USB_SERIAL_EMPEG is not set=0A=
# CONFIG_USB_SERIAL_FTDI_SIO is not set=0A=
# CONFIG_USB_SERIAL_VISOR is not set=0A=
# CONFIG_USB_SERIAL_IPAQ is not set=0A=
# CONFIG_USB_SERIAL_IR is not set=0A=
# CONFIG_USB_SERIAL_EDGEPORT is not set=0A=
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set=0A=
# CONFIG_USB_SERIAL_GARMIN is not set=0A=
# CONFIG_USB_SERIAL_IPW is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN is not set=0A=
# CONFIG_USB_SERIAL_KLSI is not set=0A=
# CONFIG_USB_SERIAL_KOBIL_SCT is not set=0A=
# CONFIG_USB_SERIAL_MCT_U232 is not set=0A=
# CONFIG_USB_SERIAL_PL2303 is not set=0A=
# CONFIG_USB_SERIAL_HP4X is not set=0A=
# CONFIG_USB_SERIAL_SAFE is not set=0A=
# CONFIG_USB_SERIAL_TI is not set=0A=
# CONFIG_USB_SERIAL_CYBERJACK is not set=0A=
# CONFIG_USB_SERIAL_XIRCOM is not set=0A=
# CONFIG_USB_SERIAL_OMNINET is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_PHIDGETKIT is not set=0A=
# CONFIG_USB_PHIDGETSERVO is not set=0A=
# CONFIG_USB_IDMOUSE is not set=0A=
# CONFIG_USB_SISUSBVGA is not set=0A=
# CONFIG_USB_LD is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB DSL modem support=0A=
#=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# InfiniBand support=0A=
#=0A=
# CONFIG_INFINIBAND is not set=0A=
=0A=
#=0A=
# SN Devices=0A=
#=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
# CONFIG_EXT2_FS_XIP is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
# CONFIG_EXT3_FS_XATTR is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_FS_POSIX_ACL is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_INOTIFY is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_DNOTIFY is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_FUSE_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
CONFIG_JFFS2_FS=3Dy=0A=
CONFIG_JFFS2_FS_DEBUG=3D0=0A=
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy=0A=
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set=0A=
CONFIG_JFFS2_ZLIB=3Dy=0A=
CONFIG_JFFS2_RTIME=3Dy=0A=
# CONFIG_JFFS2_RUBIN is not set=0A=
CONFIG_CRAMFS=3Dy=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V3_ACL is not set=0A=
# CONFIG_NFS_V4 is not set=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
# CONFIG_NFSD is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_NFS_COMMON=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5 is not set=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
# CONFIG_9P_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Instrumentation Support=0A=
#=0A=
CONFIG_MARKERS=3Dy=0A=
# CONFIG_MARKERS_DISABLE_OPTIMIZATION is not set=0A=
CONFIG_MARKERS_ENABLE_OPTIMIZATION=3Dy=0A=
CONFIG_LTT=3Dy=0A=
CONFIG_LTT_TRACER=3Dm=0A=
CONFIG_LTT_RELAY=3Dm=0A=
CONFIG_LTT_SERIALIZE=3Dm=0A=
CONFIG_LTT_ALIGNMENT=3Dy=0A=
CONFIG_LTT_HEARTBEAT=3Dy=0A=
CONFIG_LTT_HEARTBEAT_EVENT=3Dy=0A=
CONFIG_LTT_SYNTHETIC_TSC=3Dy=0A=
CONFIG_LTT_USERSPACE_GENERIC=3Dy=0A=
CONFIG_LTT_NETLINK_CONTROL=3Dm=0A=
CONFIG_LTT_STATEDUMP=3Dm=0A=
=0A=
#=0A=
# Probes=0A=
#=0A=
CONFIG_LTT_PROBE_CORE=3Dm=0A=
CONFIG_LTT_PROBE_FS=3Dm=0A=
CONFIG_LTT_PROBE_KERNEL=3Dm=0A=
CONFIG_LTT_PROBE_ARCH=3Dm=0A=
CONFIG_LTT_PROBE_MM=3Dm=0A=
CONFIG_LTT_PROBE_NET=3Dm=0A=
CONFIG_LTT_PROBE_LIST=3Dm=0A=
CONFIG_LTT_PROBE_COMPACT=3Dm=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_PRINTK_TIME=3Dy=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
CONFIG_DETECT_SOFTLOCKUP=3Dy=0A=
# CONFIG_SCHEDSTATS is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set=0A=
# CONFIG_DEBUG_KOBJECT is not set=0A=
CONFIG_DEBUG_INFO=3Dy=0A=
CONFIG_DEBUG_FS=3Dy=0A=
CONFIG_CROSSCOMPILE=3Dy=0A=
# CONFIG_DEBUG_STACK_USAGE is not set=0A=
CONFIG_KGDB=3Dy=0A=
CONFIG_BDI_SWITCH=3Dy=0A=
# CONFIG_GDB_CONSOLE is not set=0A=
# CONFIG_RUNTIME_DEBUG is not set=0A=
# CONFIG_MIPS_UNCACHED is not set=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
# CONFIG_CRYPTO_NULL is not set=0A=
# CONFIG_CRYPTO_MD4 is not set=0A=
# CONFIG_CRYPTO_MD5 is not set=0A=
# CONFIG_CRYPTO_SHA1 is not set=0A=
# CONFIG_CRYPTO_SHA256 is not set=0A=
# CONFIG_CRYPTO_SHA512 is not set=0A=
# CONFIG_CRYPTO_WP512 is not set=0A=
# CONFIG_CRYPTO_TGR192 is not set=0A=
# CONFIG_CRYPTO_DES is not set=0A=
# CONFIG_CRYPTO_BLOWFISH is not set=0A=
# CONFIG_CRYPTO_TWOFISH is not set=0A=
# CONFIG_CRYPTO_SERPENT is not set=0A=
# CONFIG_CRYPTO_AES is not set=0A=
# CONFIG_CRYPTO_CAST5 is not set=0A=
# CONFIG_CRYPTO_CAST6 is not set=0A=
# CONFIG_CRYPTO_TEA is not set=0A=
# CONFIG_CRYPTO_ARC4 is not set=0A=
# CONFIG_CRYPTO_KHAZAD is not set=0A=
# CONFIG_CRYPTO_ANUBIS is not set=0A=
# CONFIG_CRYPTO_DEFLATE is not set=0A=
# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A=
# CONFIG_CRYPTO_CRC32C is not set=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Hardware crypto devices=0A=
#=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC_CCITT is not set=0A=
# CONFIG_CRC16 is not set=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_LIBCRC32C is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
=0A=
#=0A=
# Diagnostics support=0A=
#=0A=
CONFIG_IRQ_HISTORY=3Dy=0A=
CONFIG_IRQ_HISTORY_SIZE=3D1000=0A=
CONFIG_TIMER_LIST_HISTORY=3Dy=0A=
CONFIG_TIMER_LIST_HISTORY_SIZE=3D5=0A=
CONFIG_TIMER_LIST_HISTORY_TIME=3D50=0A=
CONFIG_WATCHPOINT=3Dy=0A=
CONFIG_WATCH_WATCHDOG=3Dy=0A=
# CONFIG_CHECK_ALL_WATCHDOG_WRITES is not set=0A=

------=_NextPart_000_0092_01C882A6.22E38FE0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_NextPart_000_0092_01C882A6.22E38FE0--
