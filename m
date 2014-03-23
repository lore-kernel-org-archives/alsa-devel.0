From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] More ASoC updates for v3.15
Date: Sun, 23 Mar 2014 16:58:20 +0000
Message-ID: <20140323165820.GB2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657591668716120495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 940112608CF
 for <alsa-devel@alsa-project.org>; Sun, 23 Mar 2014 17:58:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0657591668716120495==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9296f4da3bafa23d8b9abc5cd271a66ea8f90cd2:

  ASoC: tlv320aic31xx: Staticise non-exported symbols (2014-03-13 17:44:22 =
+0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.15-3

for you to fetch changes up to e090d5b6ad20056ec0ef58727e3ae95fd82be090:

  Merge remote-tracking branches 'asoc/topic/simple' and 'asoc/topic/sirf' =
into asoc-next (2014-03-23 14:00:59 +0000)

----------------------------------------------------------------

ASoC: Updates for v3.15

A few more updates for the merge window:

 - Fixes for the simple-card DAI format DT mess.
 - A new driver for Cirrus cs42xx8 devices.
 - DT support for a couple more devices.
 - A revert of a previous buggy fix for soc-pcm, plus a few more fixes
   and cleanups.

----------------------------------------------------------------
Al Viro (3):
      ocfs2 syncs the wrong range...
      sockfd_lookup_light(): switch to fdget^W^Waway from fget_light
      get rid of fget_light()

Ales Novak (1):
      [SCSI] storvsc: NULL pointer dereference fix

Alex Deucher (4):
      drm/radeon: fix runpm disabling on non-PX harder
      drm/radeon/cik: properly set sdma ring status on disable
      drm/radeon/cik: stop the sdma engines in the enable() function
      drm/radeon/cik: properly set compute ring status on disable

Alexander Aring (1):
      at86rf230: fix lockdep splats

Alexei Starovoitov (1):
      x86: bpf_jit: support negative offsets

Amir Vadai (2):
      net/mlx4_core: Fix memory access error in mlx4_QUERY_DEV_CAP_wrapper()
      net/mlx4_core: mlx4_init_slave() shouldn't access comm channel before=
 PF is ready

Amitkumar Karwar (2):
      mwifiex: copy AP's HT capability info correctly
      mwifiex: save and copy AP's VHT capability info correctly

Andrew Lutomirski (1):
      net: Improve SO_TIMESTAMPING documentation and fix a minor code bug

Andrew Morton (1):
      revert "kallsyms: fix absolute addresses for kASLR"

Annie Li (1):
      Xen-netback: Fix issue caused by using gso_type wrongly

Anton Blanchard (2):
      net: unix socket code abuses csum_partial
      ibmveth: Fix endian issues with MAC addresses

Anton Nayshtut (1):
      ipv6: Fix exthdrs offload registration.

Arnd Bergmann (1):
      vmxnet3: fix building without CONFIG_PCI_MSI

Artem Fetishev (1):
      fs/proc/base.c: fix GPF in /proc/$PID/map_files

Axel Lin (1):
      ASoC: tlv320aic31xx: Don't call kfree for memory allocated by devm_kz=
alloc

Ben Hutchings (3):
      perf trace: Decode architecture-specific signal numbers
      bna: Replace large udelay() with mdelay()
      mm/Kconfig: fix URL for zsmalloc benchmark

Bjorn Helgaas (3):
      phy: fix compiler array bounds warning on settings[]
      PCI: Enable INTx in pci_reenable_device() only when MSI/MSI-X not ena=
bled
      PCI: Don't check resource_size() in pci_bus_alloc_resource()

Brian Austin (3):
      ASoC: cs42l73: Fix mask bits for SOC_VALUE_ENUM_SINGLE
      ASoC: cs42l52: Fix mask bits for SOC_VALUE_ENUM_SINGLE
      ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV shift values for ADC, PCM, and=
 Analog kcontrols

Chad Dupuis (1):
      [SCSI] qla2xxx: Fix multiqueue MSI-X registration.

Colin Ian King (1):
      tools/testing/selftests/ipc/msgque.c: handle msgget failure return co=
rrectly

Dan Williams (1):
      [SCSI] isci: fix reset timeout handling

Daniel Borkmann (2):
      net: sctp: fix skb leakage in COOKIE ECHO path of chunk->auth_chunk
      MAINTAINERS: add networking selftests to NETWORKING

Daniel J Blueman (1):
      x86/amd/numa: Fix northbridge quirk to assign correct NUMA node

Dave Airlie (3):
      Merge tag 'vmwgfx-fixes-3.14-2014-03-13' of git://people.freedesktop.=
org/~thomash/linux into drm-fixes
      Merge branch 'drm-fixes-3.14' of git://people.freedesktop.org/~agd5f/=
linux into drm-fixes
      Merge tag 'ttm-fixes-3.14-2014-03-12' of git://people.freedesktop.org=
/~thomash/linux into drm-fixes

Dave Jones (2):
      perf/x86: Fix leak in uncore_type_init failure paths
      x86: Remove CONFIG_X86_OOSTORE

David S. Miller (5):
      Merge branch 'tipc'
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'stmmac'
      Merge branch 'skb_frags'
      Merge branch 'mlx4'

Don Zickus (1):
      perf machine: Use map as success in ip__resolve_ams

Dylan Reid (1):
      ASoC: tegra: Use flat regcache

Eliad Peller (1):
      mac80211: consider virtual mon when calculating min_def

Emmanuel Grumbach (1):
      iwlwifi: mvm: don't WARN when statistics are handled late

Eric Dumazet (3):
      pkt_sched: move the sanity test in qdisc_list_add()
      pkt_sched: fq: do not hold qdisc lock while allocating memory
      tcp: tcp_release_cb() should release socket ownership

Eric W. Biederman (3):
      audit: Use struct net not pid_t to remember the network namespce to r=
eply in
      audit: Send replies in the proper network namespace.
      audit: Update kdoc for audit_send_reply and audit_list_rules_send

Erik Hugne (3):
      tipc: drop subscriber connection id invalidation
      tipc: fix memory leak during module removal
      tipc: don't log disabled tasklet handler errors

Fernando Luis Vazquez Cao (1):
      sched/clock: Prevent tracing recursion in sched_clock_cpu()

Florian Westphal (1):
      inet: frag: make sure forced eviction removes all frags

Gavin Shan (1):
      net/mlx4: Support shutdown() interface

Geert Uytterhoeven (2):
      cris: convert ffs from an object-like macro to a function-like macro
      packet: doc: Spelling s/than/that/

Giridhar Malavali (1):
      [SCSI] qla2xxx: Poll during initialization for ISP25xx and ISP83xx

Giuseppe CAVALLARO (4):
      stmmac: disable at run-time the EEE if not supported
      stmmac: fix and better tune the default buffer sizes
      stmmac: fix chained mode
      stmmac: dwmac-sti: fix broken STiD127 compatibility

Guillaume Nault (2):
      l2tp: fix manual sequencing (de)activation in L2TPv2
      l2tp: fix userspace reception on plain L2TP sockets

Haiyang Zhang (1):
      hyperv: Move state setting for link query

Heiner Kallweit (1):
      ipv6: Avoid unnecessary temporary addresses being generated

Heinz Mauelshagen (2):
      dm cache: fix truncation bug when copying a block to/from >2TB fast d=
evice
      dm cache: fix access beyond end of origin device

Ingo Molnar (1):
      Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/.../acme/li=
nux into perf/urgent

Ivaylo Dimitrov (1):
      wl1251: use skb_trim to make skb shorter

Jean-Francois Moine (2):
      ASoC: simple-card: Fix the reference count of device nodes
      ASoC: simple-card: Simplify code

Jeff Layton (2):
      cifs: sanity check length of data to send before sending
      cifs: mask off top byte in get_rfc1002_length()

Jiri Olsa (1):
      perf symbols: Fix crash in elf_section_by_name

Johannes Berg (2):
      cfg80211: remove racy beacon_interval assignment
      mac80211: clear sequence/fragment number in QoS-null frames

Johannes Weiner (1):
      mm: fix GFP_THISNODE callers and clarify

John W. Linville (3):
      Merge branch 'for-john' of git://git.kernel.org/.../iwlwifi/iwlwifi-f=
ixes
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Juri Lelli (1):
      sched/deadline: Deny unprivileged users to set/change SCHED_DEADLINE =
policy

Jyri Sarha (1):
      ASoC: tlv320aic31xx: Turn power off only once.

Kuninori Morimoto (4):
      ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags
      ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
      ASoC: fsi: fixup compile error for simple-card
      ASoC: rsnd: add DeviceTree support

Lars-Peter Clausen (8):
      ASoC: omap-abe-twl6040: Register machine level DMIC DAPM routes with =
the card
      ASoC: davinci-evm: Register machine level DAPM elements with the card
      ASoC: max98090: Remove unused control_data field
      ASoC: sirf-audio-codec: Remove snd_soc_codec_set_cache_io() call
      ASoC: codecs: Replace instances of rtd->codec with dai->codec
      ASoC: Add helper function to cast component back to CODEC
      ASoC: mfld_machine: Convert to table based DAPM and control setup
      ASoC: mfld_machine: Fix compile error

Laura Abbott (1):
      mm/compaction: break out of loop on !PageBuddy in isolate_freepages_b=
lock

Linus L=C3=BCssing (3):
      bridge: multicast: add sanity check for query source addresses
      bridge: multicast: add sanity check for general query destination
      bridge: multicast: enable snooping on general queries only

Linus Torvalds (19):
      vfs: atomic f_pos accesses as per POSIX
      Merge branch 'for-3.14-fixes' of git://git.kernel.org/.../tj/libata
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      Merge branch 'akpm' (patches from Andrew Morton)
      Merge branch 'for-linus' of git://git.kernel.org/.../ebiederm/user-na=
mespace
      Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
      Merge tag 'sound-3.14-rc7' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'pci-v3.14-fixes-2' of git://git.kernel.org/.../helgaas/pci
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'i2c/for-current' of git://git.kernel.org/.../wsa/linux
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'dm-3.14-fixes-4' of git://git.kernel.org/.../device-mapper=
/linux-dm
      Merge tag 'pm+acpi-3.14-rc7' of git://git.kernel.org/.../rafael/linux=
-pm
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/.../tip=
/tip
      Linux 3.14-rc7

Lukasz Dorau (1):
      [SCSI] isci: correct erroneous for_each_isci_host macro

Marc Zyngier (1):
      ARM: KVM: fix non-VGIC compilation

Mark Brown (13):
      ASoC: io: Remove support for ASoC cache in conjunction with regmap
      ASoC: pcm: Drop incorrect double/extra frees
      Merge remote-tracking branches 'asoc/fix/cs42l51', 'asoc/fix/cs42l52'=
, 'asoc/fix/cs42l73', 'asoc/fix/rcar', 'asoc/fix/spear' and 'asoc/fix/tegra=
' into asoc-linus
      Merge tag 'asoc-v3.15' into asoc-next
      Merge tag 'asoc-v3.15-2' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/codecs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42xx8' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branches 'asoc/topic/intel', 'asoc/topic/io' an=
d 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98090' and 'asoc/topic/=
omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple' and 'asoc/topic/si=
rf' into asoc-next

Markos Chandras (1):
      tools/net/Makefile: Define PACKAGE to fix build problems

Matthew Leach (1):
      net: socket: error on a negative msg_namelen

Michael Chan (1):
      bnx2: Fix shutdown sequence

Michael Kerrisk (1):
      ipc: Fix 2 bugs in msgrcv() MSG_COPY implementation

Michael Opdenacker (1):
      MAINTAINERS: blackfin: add git repository

Michael S. Tsirkin (5):
      skbuff: skb_segment: s/frag/nskb_frag/
      skbuff: skb_segment: s/skb_frag/frag/
      skbuff: skb_segment: s/skb/head_skb/
      skbuff: skb_segment: s/fskb/list_skb/
      skbuff: skb_segment: orphan frags before copying

Mike Christie (1):
      [SCSI] be2iscsi: fix bad if expression

Neil Horman (1):
      vmxnet3: fix netpoll race condition

Nenghua Cao (1):
      asoc: soc-core: fix coccinelle warnings

Nicolin Chen (2):
      ASoC: simple-card: overwrite cpu_dai->fmt with codec_dai->fmt
      ASoC: cs42xx8: Add codec driver support for CS42448/CS42888

Nikolay Aleksandrov (1):
      net: fix for a race condition in the inet frag code

Or Gerlitz (4):
      net/mlx4_core: Fix wrong dump of the vxlan offloads device capability
      net/mlx4_en: Handle vxlan steering rules for mac address changes
      net/mlx4_core: Load the IB driver when the device supports IBoE
      net/mlx4_en: Deregister multicast vxlan steering rules when going down

Oren Givon (1):
      iwlwifi: fix and add 7265 series HW IDs

Pavel Shilovsky (1):
      CIFS: Fix wrong pos argument of cifs_find_lock_conflict

Peter Bostr=C3=B6m (1):
      vlan: Set correct source MAC address with TX VLAN offload enabled

Peter Ujfalusi (2):
      ASoC: davinci: Add edma dmaengine platform driver
      ASoC: davinci-mcasp: Provide correct filter_data for dmaengine for no=
n-DT boot

Peter Zijlstra (1):
      stop_machine: Fix^2 race between stop_two_cpus() and stop_cpus()

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      KVM: SVM: fix cr8 intercept window

Rafael J. Wysocki (4):
      cpufreq: Skip current frequency initialization for ->setpolicy drivers
      ACPI / init: Invoke early ACPI initialization later
      ACPI / sleep: Add extra checks for HW Reduced ACPI mode sleep states
      Merge branches 'pnp', 'acpi-init', 'acpi-sleep' and 'pm-cpufreq'

Richard Weinberger (1):
      i2c: Remove usage of orphaned symbol OF_I2C

Rob Clark (1):
      drm/ttm: don't oops if no invalidate_caches()

Sabrina Dubroca (1):
      ipv6: don't set DST_NOCOUNT for remotely added routes

Sasha Levin (1):
      bonding: correctly handle out of range parameters for lp_interval

Sergei Antonov (1):
      hfsplus: add HFSX subfolder count support

Soren Brinkmann (2):
      net: macb: Check DMA mappings for error
      net: macb: DMA-unmap full rx-buffer

Stefan Wahren (1):
      eth: fec: Fix lost promiscuous mode after reconnecting cable

Suresh Siddha (1):
      x86, fpu: Check tsk_used_math() in kernel_fpu_end() for eager FPU

Tejun Heo (1):
      libata: use wider match for blacklisting Crucial M500

Thomas Hellstrom (2):
      drm/ttm: Work around performance regression with VM_PFNMAP
      drm/vmwgfx: Fix a surface reference corner-case in legacy emulation m=
ode

Thomas Petazzoni (1):
      ASoC: add S/PDIF support to Armada 370 DB ASoC driver

Tobias Klauser (1):
      MAINTAINERS: Add tools/net to NETWORKING [GENERAL]

Wei Liu (1):
      xen-netback: use skb_is_gso in xenvif_start_xmit

Ying Xue (3):
      tipc: allow connection shutdown callback to be invoked in advance
      tipc: fix connection refcount leak
      tipc: avoid to unnecessary process switch under non-block mode

Zhang Rui (1):
      PNP / ACPI: proper handling of ACPI IO/Memory resource parsing failur=
es

dingtianhong (1):
      bonding: set correct vlan id for alb xmit path

hayeswang (2):
      r8152: disable the ECM mode
      r8169: fix the incorrect tx descriptor version

 .gitignore                                         |    3 +
 Documentation/00-INDEX                             |   24 +-
 Documentation/PCI/MSI-HOWTO.txt                    |  119 +-
 Documentation/RCU/00-INDEX                         |    2 +
 Documentation/arm/00-INDEX                         |   14 +
 Documentation/blackfin/00-INDEX                    |    6 +-
 Documentation/block/00-INDEX                       |    2 +
 Documentation/device-mapper/cache.txt              |   11 +-
 Documentation/device-mapper/thin-provisioning.txt  |   34 +-
 Documentation/devicetree/00-INDEX                  |    2 +
 .../devicetree/bindings/arm/omap/omap.txt          |    2 +-
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    4 +-
 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   16 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../interrupt-controller/lsi,zevio-intc.txt        |   18 +
 .../devicetree/bindings/misc/atmel-ssc.txt         |    8 +
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |    5 +
 .../bindings/net/allwinner,sun4i-emac.txt          |    5 +-
 .../bindings/net/allwinner,sun4i-mdio.txt          |    5 +-
 .../devicetree/bindings/net/opencores-ethoc.txt    |   22 +
 .../devicetree/bindings/net/sti-dwmac.txt          |   58 +
 ...capri-pinctrl.txt =3D> brcm,bcm11351-pinctrl.txt} |    8 +-
 .../devicetree/bindings/power/bq2415x.txt          |   47 +
 .../bindings/sound/armada-370db-audio.txt          |   27 +
 .../devicetree/bindings/sound/cs42xx8.txt          |   28 +
 Documentation/devicetree/bindings/sound/da9055.txt |   22 +
 .../bindings/sound/davinci-evm-audio.txt           |    9 +-
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   21 +
 .../devicetree/bindings/sound/fsl,esai.txt         |    5 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |    5 +
 .../devicetree/bindings/sound/mvebu-audio.txt      |    1 +
 .../devicetree/bindings/sound/pcm512x.txt          |   30 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   96 ++
 .../devicetree/bindings/sound/simple-card.txt      |   23 +-
 .../devicetree/bindings/sound/sirf-audio-codec.txt |   17 +
 .../devicetree/bindings/sound/sirf-audio-port.txt  |   20 +
 .../devicetree/bindings/sound/sirf-audio.txt       |   41 +
 .../devicetree/bindings/sound/tdm-slot.txt         |   20 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    1 -
 .../devicetree/bindings/sound/widgets.txt          |   20 +
 .../devicetree/bindings/spi/spi_atmel.txt          |    5 +
 .../devicetree/bindings/vendor-prefixes.txt        |    6 +-
 Documentation/dvb/contributors.txt                 |    2 +-
 Documentation/fb/00-INDEX                          |    6 +
 Documentation/filesystems/00-INDEX                 |    2 +
 Documentation/filesystems/nfs/00-INDEX             |    4 +-
 Documentation/i2c/instantiating-devices            |   41 +-
 Documentation/ide/00-INDEX                         |    2 +
 Documentation/kernel-parameters.txt                |    8 +-
 Documentation/laptops/00-INDEX                     |    6 +-
 Documentation/leds/00-INDEX                        |    8 +
 Documentation/m68k/00-INDEX                        |    2 +
 Documentation/networking/00-INDEX                  |   30 +-
 Documentation/networking/3c505.txt                 |   45 -
 Documentation/networking/can.txt                   |    6 -
 Documentation/networking/packet_mmap.txt           |    2 +-
 Documentation/networking/timestamping.txt          |   52 +-
 Documentation/phy.txt                              |   26 +-
 Documentation/power/00-INDEX                       |    6 +-
 Documentation/ptp/testptp.c                        |   11 +-
 Documentation/s390/00-INDEX                        |    8 +-
 Documentation/scheduler/00-INDEX                   |    2 +
 Documentation/scsi/00-INDEX                        |   16 +
 Documentation/serial/00-INDEX                      |    6 +-
 Documentation/spi/00-INDEX                         |   22 +
 Documentation/spi/spi-summary                      |   17 +-
 Documentation/timers/00-INDEX                      |    2 +
 Documentation/virtual/kvm/00-INDEX                 |    2 +
 Documentation/vm/00-INDEX                          |    4 +-
 Documentation/w1/masters/00-INDEX                  |    4 +-
 Documentation/w1/slaves/00-INDEX                   |    2 +
 Documentation/x86/00-INDEX                         |   18 +-
 Documentation/zh_CN/arm64/booting.txt              |   65 +-
 Documentation/zh_CN/arm64/memory.txt               |   46 +-
 Documentation/zh_CN/arm64/tagged-pointers.txt      |   52 +
 MAINTAINERS                                        |  168 +-
 Makefile                                           |   10 +-
 arch/arc/mm/cache_arc700.c                         |    4 +-
 arch/arm/Kconfig                                   |    3 +
 arch/arm/boot/compressed/.gitignore                |    1 +
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   11 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |    3 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  229 +++
 arch/arm/boot/dts/at91sam9263.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |    4 +
 arch/arm/boot/dts/bcm11351.dtsi                    |    2 +-
 arch/arm/boot/dts/dove.dtsi                        |   11 -
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |   10 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   10 +-
 arch/arm/boot/dts/keystone-clocks.dtsi             |    2 +-
 arch/arm/boot/dts/omap3-gta04.dts                  |    8 +-
 arch/arm/boot/dts/omap3-igep0020.dts               |    2 +-
 arch/arm/boot/dts/omap3-igep0030.dts               |    2 +-
 arch/arm/boot/dts/omap3-n9.dts                     |    2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |    4 +-
 arch/arm/boot/dts/omap3-n950.dts                   |    2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       |   22 +
 ...omap3-tobi.dts =3D> omap3-overo-tobi-common.dtsi} |    3 -
 arch/arm/boot/dts/omap3-overo-tobi.dts             |   22 +
 arch/arm/boot/dts/omap3-overo.dtsi                 |    3 -
 arch/arm/boot/dts/sama5d3.dtsi                     |    2 +-
 arch/arm/boot/dts/ste-href.dtsi                    |    1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |    6 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    6 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   16 +-
 arch/arm/boot/dts/tegra114.dtsi                    |    4 +
 arch/arm/boot/dts/tegra20.dtsi                     |    4 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |    2 +-
 arch/arm/boot/dts/tegra30.dtsi                     |    4 +
 arch/arm/boot/dts/testcases/tests.dtsi             |    2 -
 arch/arm/boot/dts/versatile-pb.dts                 |    4 +-
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/tegra_defconfig                   |    3 +
 arch/arm/include/asm/cacheflush.h                  |    1 +
 arch/arm/include/asm/memory.h                      |    9 +-
 arch/arm/include/asm/pgtable-3level.h              |   15 +-
 arch/arm/include/asm/spinlock.h                    |   15 +-
 arch/arm/kernel/head-common.S                      |   12 +
 arch/arm/kernel/head.S                             |    2 +-
 arch/arm/kernel/setup.c                            |    2 +-
 arch/arm/kvm/arm.c                                 |    3 +-
 arch/arm/kvm/interrupts.S                          |   11 +-
 arch/arm/mach-hisi/Kconfig                         |    2 +-
 arch/arm/mach-imx/Makefile                         |    2 -
 arch/arm/mach-imx/clk-imx6q.c                      |    3 +
 arch/arm/mach-imx/clk-imx6sl.c                     |    3 +
 arch/arm/mach-imx/common.h                         |    4 +-
 arch/arm/mach-imx/pm-imx6q.c                       |    2 -
 arch/arm/mach-moxart/Kconfig                       |    1 -
 arch/arm/mach-omap1/board-nokia770.c               |    1 +
 arch/arm/mach-omap2/Kconfig                        |   10 +-
 arch/arm/mach-omap2/cclock3xxx_data.c              |    2 +
 arch/arm/mach-omap2/cpuidle44xx.c                  |    8 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |   92 +-
 arch/arm/mach-omap2/gpmc.c                         |    4 +-
 arch/arm/mach-omap2/io.c                           |    9 -
 arch/arm/mach-omap2/omap_hwmod.c                   |   20 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |    9 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   21 +-
 arch/arm/mach-omap2/prminst44xx.c                  |    4 +-
 arch/arm/mach-pxa/am300epd.c                       |    1 +
 arch/arm/mach-pxa/include/mach/balloon3.h          |    2 +
 arch/arm/mach-pxa/include/mach/corgi.h             |    1 +
 arch/arm/mach-pxa/include/mach/csb726.h            |    2 +
 arch/arm/mach-pxa/include/mach/gumstix.h           |    1 +
 arch/arm/mach-pxa/include/mach/idp.h               |    1 +
 arch/arm/mach-pxa/include/mach/palmld.h            |    2 +
 arch/arm/mach-pxa/include/mach/palmt5.h            |    2 +
 arch/arm/mach-pxa/include/mach/palmtc.h            |    2 +
 arch/arm/mach-pxa/include/mach/palmtx.h            |    2 +
 arch/arm/mach-pxa/include/mach/pcm027.h            |    2 +
 arch/arm/mach-pxa/include/mach/pcm990_baseboard.h  |    1 +
 arch/arm/mach-pxa/include/mach/poodle.h            |    2 +
 arch/arm/mach-pxa/include/mach/spitz.h             |    2 +-
 arch/arm/mach-pxa/include/mach/tosa.h              |    2 +
 arch/arm/mach-pxa/include/mach/trizeps4.h          |    2 +
 arch/arm/mach-pxa/mioa701.c                        |    9 +
 arch/arm/mach-sa1100/include/mach/collie.h         |    2 +
 arch/arm/mach-shmobile/Kconfig                     |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c            |    6 +-
 arch/arm/mach-tegra/pm.c                           |    1 +
 arch/arm/mach-tegra/tegra.c                        |   10 +
 arch/arm/mach-zynq/common.c                        |   14 +
 arch/arm/mm/dma-mapping.c                          |    2 +-
 arch/arm/mm/dump.c                                 |    3 +
 arch/arm/mm/mm.h                                   |    1 +
 arch/arm/mm/mmu.c                                  |    7 +-
 arch/arm/mm/proc-v6.S                              |    3 +-
 arch/arm/mm/proc-v7.S                              |    2 +-
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/configs/defconfig                       |   18 +-
 arch/arm64/include/asm/atomic.h                    |   53 +-
 arch/arm64/include/asm/barrier.h                   |    2 +-
 arch/arm64/include/asm/cacheflush.h                |    1 +
 arch/arm64/include/asm/cmpxchg.h                   |   17 +-
 arch/arm64/include/asm/esr.h                       |    2 +-
 arch/arm64/include/asm/futex.h                     |   10 +-
 arch/arm64/include/asm/kvm_arm.h                   |    2 +-
 arch/arm64/include/asm/percpu.h                    |    8 +
 arch/arm64/include/asm/pgtable.h                   |   10 +-
 arch/arm64/include/asm/spinlock.h                  |   10 +-
 arch/arm64/include/asm/unistd32.h                  |    5 +-
 arch/arm64/include/uapi/asm/kvm.h                  |    9 +
 arch/arm64/kernel/kuser32.S                        |    6 +-
 arch/arm64/kernel/stacktrace.c                     |    6 +-
 arch/arm64/kernel/vdso.c                           |    4 +-
 arch/arm64/kernel/vdso/Makefile                    |    2 +-
 arch/arm64/kernel/vdso/gettimeofday.S              |    7 +-
 arch/arm64/kvm/hyp.S                               |   27 +-
 arch/arm64/lib/bitops.S                            |    3 +-
 arch/arm64/mm/dma-mapping.c                        |    1 +
 arch/arm64/mm/mmu.c                                |   12 +-
 arch/arm64/mm/pgd.c                                |   11 +-
 arch/avr32/Makefile                                |    2 +-
 arch/avr32/boards/mimc200/fram.c                   |    1 +
 arch/avr32/include/asm/Kbuild                      |    1 +
 arch/avr32/include/asm/io.h                        |    2 +
 arch/c6x/include/asm/cache.h                       |    1 +
 arch/cris/include/asm/bitops.h                     |    2 +-
 arch/ia64/include/asm/unistd.h                     |    2 +-
 arch/ia64/include/uapi/asm/unistd.h                |    2 +
 arch/ia64/kernel/entry.S                           |    2 +
 arch/ia64/kernel/uncached.c                        |    2 +-
 arch/m68k/include/asm/Kbuild                       |    6 +-
 arch/m68k/include/asm/barrier.h                    |    8 -
 arch/m68k/include/asm/unistd.h                     |    2 +-
 arch/m68k/include/uapi/asm/unistd.h                |    2 +
 arch/m68k/kernel/syscalltable.S                    |    2 +
 arch/microblaze/include/asm/delay.h                |    2 +
 arch/microblaze/include/asm/io.h                   |    6 +
 arch/microblaze/kernel/head.S                      |    2 +-
 arch/mips/alchemy/devboards/db1000.c               |    7 +-
 arch/mips/include/asm/fpu.h                        |    2 +
 arch/mips/include/uapi/asm/unistd.h                |   18 +-
 arch/mips/kernel/scall32-o32.S                     |    2 +
 arch/mips/kernel/scall64-64.S                      |    2 +
 arch/mips/kernel/scall64-n32.S                     |    2 +
 arch/mips/kernel/scall64-o32.S                     |    2 +
 arch/parisc/hpux/fs.c                              |   15 +-
 arch/powerpc/include/asm/compat.h                  |    5 +-
 arch/powerpc/include/asm/dma-mapping.h             |    1 +
 arch/powerpc/include/asm/eeh.h                     |   21 +-
 arch/powerpc/include/asm/hugetlb.h                 |    2 +-
 arch/powerpc/include/asm/iommu.h                   |    1 +
 arch/powerpc/include/asm/opal.h                    |    4 +-
 arch/powerpc/include/asm/pgtable-ppc64.h           |   26 +-
 arch/powerpc/include/asm/pgtable.h                 |   22 +
 arch/powerpc/include/asm/ptrace.h                  |   16 +-
 arch/powerpc/include/asm/sections.h                |   12 +
 arch/powerpc/include/asm/vdso.h                    |    6 +-
 arch/powerpc/kernel/crash_dump.c                   |    8 +-
 arch/powerpc/kernel/dma.c                          |   10 +-
 arch/powerpc/kernel/eeh.c                          |   32 +-
 arch/powerpc/kernel/eeh_driver.c                   |    8 +-
 arch/powerpc/kernel/ftrace.c                       |    1 +
 arch/powerpc/kernel/iommu.c                        |   12 +
 arch/powerpc/kernel/irq.c                          |    5 +
 arch/powerpc/kernel/machine_kexec.c                |   14 +-
 arch/powerpc/kernel/machine_kexec_64.c             |    6 +-
 arch/powerpc/kernel/misc_32.S                      |    5 +-
 arch/powerpc/kernel/process.c                      |    9 +
 arch/powerpc/kernel/reloc_64.S                     |    5 +-
 arch/powerpc/kernel/setup_32.c                     |    5 +
 arch/powerpc/kernel/signal_64.c                    |    4 +-
 arch/powerpc/kernel/vdso32/vdso32_wrapper.S        |    2 +-
 arch/powerpc/kernel/vdso64/vdso64_wrapper.S        |    2 +-
 arch/powerpc/mm/hash_utils_64.c                    |   14 +
 arch/powerpc/mm/pgtable_64.c                       |   12 +-
 arch/powerpc/mm/subpage-prot.c                     |    2 +-
 arch/powerpc/perf/core-book3s.c                    |    5 +-
 arch/powerpc/perf/power8-pmu.c                     |  144 ++
 arch/powerpc/platforms/cell/ras.c                  |    3 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c          |  128 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    2 +-
 arch/powerpc/platforms/powernv/opal-xscom.c        |   21 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   84 +
 arch/powerpc/platforms/powernv/pci.c               |  230 +--
 arch/powerpc/platforms/powernv/pci.h               |    6 +-
 arch/powerpc/platforms/powernv/powernv.h           |    8 +
 arch/powerpc/platforms/powernv/setup.c             |    9 +
 arch/powerpc/platforms/pseries/Kconfig             |    1 +
 arch/powerpc/platforms/pseries/eeh_pseries.c       |    2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   22 +-
 arch/powerpc/platforms/pseries/pci.c               |   22 +-
 arch/powerpc/platforms/pseries/setup.c             |    3 +-
 arch/powerpc/sysdev/mpic.c                         |   38 +-
 arch/powerpc/xmon/xmon.c                           |   24 +-
 arch/s390/appldata/appldata_base.c                 |    1 +
 arch/s390/crypto/aes_s390.c                        |   65 +-
 arch/s390/crypto/des_s390.c                        |   95 +-
 arch/s390/kernel/compat_wrapper.S                  |    2 +-
 arch/s390/kernel/head64.S                          |    7 +-
 arch/s390/mm/page-states.c                         |   10 +
 arch/s390/pci/pci_dma.c                            |    8 +-
 arch/sh/boards/mach-ecovec24/setup.c               |    4 +-
 arch/sh/boards/mach-se/7724/setup.c                |    4 +-
 arch/sh/include/cpu-sh2/cpu/cache.h                |    2 +-
 arch/sh/include/cpu-sh2a/cpu/cache.h               |    4 +-
 arch/sh/include/cpu-sh3/cpu/cache.h                |    2 +-
 arch/sh/include/cpu-sh4/cpu/cache.h                |    2 +-
 arch/sh/kernel/cpu/init.c                          |    4 +-
 arch/sh/mm/cache-debugfs.c                         |    2 +-
 arch/sh/mm/cache-sh2.c                             |    4 +-
 arch/sh/mm/cache-sh2a.c                            |    6 +-
 arch/sh/mm/cache-sh4.c                             |    4 +-
 arch/sh/mm/cache-shx3.c                            |    4 +-
 arch/sh/mm/cache.c                                 |    4 +-
 arch/sparc/Kconfig                                 |    2 +-
 arch/sparc/mm/srmmu.c                              |    2 +
 arch/x86/Kconfig                                   |    7 +-
 arch/x86/Kconfig.cpu                               |    4 -
 arch/x86/Kconfig.debug                             |    1 +
 arch/x86/boot/compressed/aslr.c                    |    9 +-
 arch/x86/include/asm/amd_nb.h                      |    2 +-
 arch/x86/include/asm/barrier.h                     |    8 +-
 arch/x86/include/asm/efi.h                         |    3 +
 arch/x86/include/asm/io.h                          |    2 +-
 arch/x86/include/asm/pgtable.h                     |   14 +-
 arch/x86/include/asm/spinlock.h                    |    5 +-
 arch/x86/include/asm/tlbflush.h                    |    6 +-
 arch/x86/include/asm/tsc.h                         |    2 +-
 arch/x86/include/asm/xen/page.h                    |    5 +-
 arch/x86/kernel/amd_nb.c                           |    2 +-
 arch/x86/kernel/cpu/amd.c                          |    5 +-
 arch/x86/kernel/cpu/centaur.c                      |  272 ---
 arch/x86/kernel/cpu/common.c                       |    7 +-
 arch/x86/kernel/cpu/intel.c                        |   10 +-
 arch/x86/kernel/cpu/microcode/amd_early.c          |   43 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |    4 +-
 arch/x86/kernel/cpu/perf_event.c                   |   11 +-
 arch/x86/kernel/cpu/perf_event.h                   |    1 +
 arch/x86/kernel/cpu/perf_event_intel.c             |   11 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c      |   13 +-
 arch/x86/kernel/cpu/perf_event_p6.c                |   48 +-
 arch/x86/kernel/ftrace.c                           |   83 +-
 arch/x86/kernel/head_32.S                          |    7 +-
 arch/x86/kernel/head_64.S                          |    6 +-
 arch/x86/kernel/i387.c                             |   15 +-
 arch/x86/kernel/irq.c                              |    9 +-
 arch/x86/kernel/machine_kexec_64.c                 |    2 +
 arch/x86/kernel/pci-dma.c                          |    4 +-
 arch/x86/kernel/quirks.c                           |   39 +-
 arch/x86/kernel/setup.c                            |   10 +-
 arch/x86/kernel/tsc.c                              |   11 +-
 arch/x86/kernel/tsc_msr.c                          |   30 +-
 arch/x86/kvm/mmu.c                                 |    1 +
 arch/x86/kvm/svm.c                                 |    6 +-
 arch/x86/kvm/vmx.c                                 |    2 +-
 arch/x86/kvm/x86.c                                 |    2 +-
 arch/x86/mm/fault.c                                |   61 +-
 arch/x86/mm/numa.c                                 |   21 +-
 arch/x86/mm/numa_32.c                              |    2 +
 arch/x86/mm/srat.c                                 |   16 +-
 arch/x86/mm/tlb.c                                  |   52 +-
 arch/x86/net/bpf_jit.S                             |    2 +-
 arch/x86/platform/efi/efi-bgrt.c                   |   12 +-
 arch/x86/platform/efi/efi.c                        |   25 +-
 arch/x86/platform/efi/efi_32.c                     |    6 +
 arch/x86/platform/efi/efi_64.c                     |    9 +
 arch/x86/um/asm/barrier.h                          |    4 -
 arch/x86/xen/enlighten.c                           |   12 +
 arch/x86/xen/mmu.c                                 |    4 +-
 arch/x86/xen/p2m.c                                 |   17 +-
 arch/xtensa/Kconfig                                |    3 +-
 arch/xtensa/boot/dts/xtfpga.dtsi                   |   12 +-
 arch/xtensa/include/asm/io.h                       |    2 +-
 arch/xtensa/include/asm/traps.h                    |   44 +-
 arch/xtensa/include/asm/vectors.h                  |    2 +-
 arch/xtensa/include/uapi/asm/unistd.h              |    7 +-
 arch/xtensa/kernel/entry.S                         |  449 ++---
 arch/xtensa/kernel/setup.c                         |    2 +
 arch/xtensa/kernel/time.c                          |    1 +
 arch/xtensa/kernel/vectors.S                       |    2 +-
 arch/xtensa/kernel/xtensa_ksyms.c                  |    2 -
 arch/xtensa/mm/init.c                              |   13 +-
 arch/xtensa/mm/mmu.c                               |    2 +-
 arch/xtensa/platforms/xtfpga/setup.c               |    7 +-
 arch/xtensa/variants/fsf/include/variant/tie.h     |    9 +-
 block/blk-core.c                                   |   20 +-
 block/blk-exec.c                                   |    2 +-
 block/blk-flush.c                                  |  105 +-
 block/blk-lib.c                                    |    8 +
 block/blk-merge.c                                  |   91 +-
 block/blk-mq-cpu.c                                 |   14 +-
 block/blk-mq-tag.c                                 |    2 +-
 block/blk-mq.c                                     |  237 ++-
 block/blk-mq.h                                     |    5 +-
 block/blk-sysfs.c                                  |    2 +
 block/blk-timeout.c                                |    2 +-
 block/blk.h                                        |    2 +-
 drivers/acpi/ac.c                                  |    2 +
 drivers/acpi/battery.c                             |    4 +-
 drivers/acpi/blacklist.c                           |   58 -
 drivers/acpi/button.c                              |    2 +
 drivers/acpi/container.c                           |    5 +-
 drivers/acpi/dock.c                                |   13 +-
 drivers/acpi/ec.c                                  |   64 +
 drivers/acpi/fan.c                                 |    3 +
 drivers/acpi/pci_irq.c                             |    1 +
 drivers/acpi/proc.c                                |    2 +-
 drivers/acpi/processor_throttling.c                |   69 +-
 drivers/acpi/resource.c                            |   10 +
 drivers/acpi/sbs.c                                 |    4 +-
 drivers/acpi/scan.c                                |    6 +-
 drivers/acpi/sleep.c                               |   32 +-
 drivers/acpi/thermal.c                             |    2 +
 drivers/acpi/utils.c                               |    4 -
 drivers/acpi/video.c                               |  147 +-
 drivers/acpi/video_detect.c                        |    8 -
 drivers/ata/Kconfig                                |    1 +
 drivers/ata/ahci.c                                 |   18 +-
 drivers/ata/libata-core.c                          |    3 +-
 drivers/ata/libata-pmp.c                           |    7 +-
 drivers/ata/pata_imx.c                             |    8 +-
 drivers/ata/sata_mv.c                              |   16 +-
 drivers/ata/sata_sil.c                             |    1 +
 drivers/base/component.c                           |    8 +
 drivers/base/dma-buf.c                             |   25 +-
 drivers/base/firmware_class.c                      |    1 +
 drivers/base/regmap/regmap.c                       |   12 +
 drivers/block/aoe/aoecmd.c                         |    4 +-
 drivers/block/mtip32xx/mtip32xx.h                  |    2 +-
 drivers/block/null_blk.c                           |   97 +-
 drivers/block/nvme-core.c                          |  610 +++++--
 drivers/block/nvme-scsi.c                          |  147 ++
 drivers/block/virtio_blk.c                         |    7 +-
 drivers/block/xen-blkback/blkback.c                |   81 +-
 drivers/block/xen-blkback/common.h                 |    5 +-
 drivers/block/xen-blkback/xenbus.c                 |   14 +
 drivers/block/xen-blkfront.c                       |   11 +-
 drivers/block/zram/zram_drv.c                      |    2 +
 drivers/char/Kconfig                               |    1 +
 drivers/char/raw.c                                 |    2 +-
 drivers/char/virtio_console.c                      |    9 +-
 drivers/clk/at91/clk-master.c                      |    2 +-
 drivers/clk/clk-nomadik.c                          |    3 +
 drivers/clk/clk.c                                  |   13 +-
 drivers/clk/keystone/gate.c                        |    1 +
 drivers/clk/mvebu/armada-370.c                     |   21 +-
 drivers/clk/mvebu/armada-xp.c                      |   20 +-
 drivers/clk/mvebu/dove.c                           |   19 +-
 drivers/clk/mvebu/kirkwood.c                       |   34 +-
 drivers/clk/shmobile/clk-rcar-gen2.c               |   48 +-
 drivers/clk/tegra/clk-divider.c                    |    2 +-
 drivers/clk/tegra/clk-id.h                         |    4 +
 drivers/clk/tegra/clk-tegra-periph.c               |   10 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    2 +-
 drivers/clk/tegra/clk-tegra114.c                   |    8 +-
 drivers/clk/tegra/clk-tegra124.c                   |   48 +-
 drivers/clk/tegra/clk-tegra20.c                    |    2 +
 drivers/clocksource/bcm_kona_timer.c               |   54 +-
 drivers/cpufreq/cpufreq.c                          |   58 +-
 drivers/cpufreq/intel_pstate.c                     |   61 +-
 drivers/cpufreq/powernow-k8.c                      |   10 +-
 drivers/crypto/nx/nx-842.c                         |   29 +-
 drivers/dma/Kconfig                                |    1 +
 drivers/dma/imx-sdma.c                             |    1 +
 drivers/dma/ioat/dma.c                             |   52 +-
 drivers/dma/ioat/dma.h                             |    1 +
 drivers/dma/ioat/dma_v2.c                          |   11 +-
 drivers/dma/ioat/dma_v3.c                          |    3 +
 drivers/dma/mv_xor.c                               |   24 +-
 drivers/dma/ste_dma40.c                            |    4 +-
 drivers/edac/edac_mc.c                             |   13 +-
 drivers/edac/edac_mc_sysfs.c                       |   10 +-
 drivers/edac/edac_module.h                         |    2 +-
 drivers/edac/i7300_edac.c                          |   38 +-
 drivers/edac/i7core_edac.c                         |    9 +-
 drivers/extcon/extcon-arizona.c                    |   12 -
 drivers/firewire/core-device.c                     |   22 +-
 drivers/firewire/net.c                             |    6 +-
 drivers/firewire/ohci.c                            |   15 +-
 drivers/firewire/sbp2.c                            |   17 +-
 drivers/fmc/fmc-write-eeprom.c                     |    2 +-
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-bcm-kona.c                       |    4 +-
 drivers/gpio/gpio-clps711x.c                       |    1 +
 drivers/gpio/gpio-intel-mid.c                      |    4 +-
 drivers/gpio/gpio-xtensa.c                         |   16 +
 drivers/gpu/drm/armada/armada_drv.c                |   10 +-
 drivers/gpu/drm/ast/ast_fb.c                       |    2 +-
 drivers/gpu/drm/bochs/Kconfig                      |    1 +
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |    2 +-
 drivers/gpu/drm/drm_ioctl.c                        |   12 +
 drivers/gpu/drm/exynos/Kconfig                     |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   14 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |    3 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   66 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   19 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   23 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    8 +
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   19 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |    5 +-
 drivers/gpu/drm/i915/i915_irq.c                    |    3 +-
 drivers/gpu/drm/i915/intel_display.c               |   22 +-
 drivers/gpu/drm/i915/intel_dp.c                    |   31 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |    6 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    7 -
 drivers/gpu/drm/i915/intel_opregion.c              |    9 +-
 drivers/gpu/drm/i915/intel_panel.c                 |    4 +-
 drivers/gpu/drm/i915/intel_pm.c                    |    6 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |   21 +
 drivers/gpu/drm/i915/intel_ringbuffer.h            |    1 +
 drivers/gpu/drm/mgag200/mgag200_fb.c               |    2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    4 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c           |  179 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_plane.c          |    4 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c           |    7 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |    9 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    3 -
 drivers/gpu/drm/nouveau/Makefile                   |    1 +
 drivers/gpu/drm/nouveau/core/engine/device/nv40.c  |   10 +-
 drivers/gpu/drm/nouveau/core/engine/disp/nv50.c    |    2 +-
 drivers/gpu/drm/nouveau/core/engine/fifo/nve0.c    |    2 +-
 drivers/gpu/drm/nouveau/core/engine/graph/nv50.c   |    2 +-
 drivers/gpu/drm/nouveau/core/include/subdev/mc.h   |    1 +
 drivers/gpu/drm/nouveau/core/subdev/bios/base.c    |    4 +
 drivers/gpu/drm/nouveau/core/subdev/fb/nv1a.c      |    2 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv04.h      |    1 +
 drivers/gpu/drm/nouveau/core/subdev/mc/nv44.c      |    2 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv4c.c      |   45 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   26 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    3 +
 drivers/gpu/drm/nouveau/nouveau_vga.c              |    4 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |   31 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |    9 +-
 drivers/gpu/drm/radeon/btc_dpm.c                   |   32 +
 drivers/gpu/drm/radeon/btcd.h                      |    4 +
 drivers/gpu/drm/radeon/cik.c                       |   10 +-
 drivers/gpu/drm/radeon/cik_sdma.c                  |   14 +-
 drivers/gpu/drm/radeon/dce6_afmt.c                 |   15 +-
 drivers/gpu/drm/radeon/evergreen.c                 |    7 +-
 drivers/gpu/drm/radeon/evergreen_hdmi.c            |   26 +-
 drivers/gpu/drm/radeon/evergreen_smc.h             |    2 +-
 drivers/gpu/drm/radeon/kv_dpm.c                    |    2 +-
 drivers/gpu/drm/radeon/ni.c                        |    3 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |   10 +-
 drivers/gpu/drm/radeon/r100.c                      |    2 -
 drivers/gpu/drm/radeon/r300.c                      |    2 -
 drivers/gpu/drm/radeon/r420.c                      |    2 -
 drivers/gpu/drm/radeon/r520.c                      |    2 -
 drivers/gpu/drm/radeon/r600.c                      |    7 +-
 drivers/gpu/drm/radeon/r600_audio.c                |   14 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |   18 +-
 drivers/gpu/drm/radeon/r600_hdmi.c                 |   15 +-
 drivers/gpu/drm/radeon/radeon.h                    |   10 +-
 drivers/gpu/drm/radeon/radeon_asic.c               |    2 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |    2 +
 drivers/gpu/drm/radeon/radeon_atpx_handler.c       |    3 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    5 +-
 drivers/gpu/drm/radeon/radeon_display.c            |    2 +
 drivers/gpu/drm/radeon/radeon_drv.c                |    3 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   16 +-
 drivers/gpu/drm/radeon/radeon_ring.c               |    2 +-
 drivers/gpu/drm/radeon/radeon_semaphore.c          |   19 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    5 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |    2 +
 drivers/gpu/drm/radeon/reg_srcs/r600               |    1 +
 drivers/gpu/drm/radeon/rs400.c                     |    2 -
 drivers/gpu/drm/radeon/rs600.c                     |    2 -
 drivers/gpu/drm/radeon/rs690.c                     |    2 -
 drivers/gpu/drm/radeon/rv515.c                     |    2 -
 drivers/gpu/drm/radeon/rv770.c                     |    5 +-
 drivers/gpu/drm/radeon/rv770_dpm.c                 |   14 +-
 drivers/gpu/drm/radeon/si.c                        |    7 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |    5 +-
 drivers/gpu/drm/radeon/sumo_dpm.c                  |    2 +-
 drivers/gpu/drm/radeon/trinity_dpm.c               |    3 +-
 drivers/gpu/drm/radeon/uvd_v2_2.c                  |    1 -
 drivers/gpu/drm/tegra/drm.c                        |    2 +-
 drivers/gpu/drm/tegra/rgb.c                        |   11 +
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |    1 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |    8 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   12 +-
 drivers/gpu/drm/ttm/ttm_object.c                   |    2 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |    3 +
 drivers/gpu/drm/vmwgfx/svga3d_reg.h                |  153 +-
 drivers/gpu/drm/vmwgfx/svga3d_surfacedefs.h        |   11 +-
 drivers/gpu/drm/vmwgfx/svga_reg.h                  |    9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |  141 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   10 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   38 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  337 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |   96 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   36 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |  469 ++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   24 +-
 drivers/gpu/host1x/job.c                           |    2 +-
 drivers/hid/hid-apple.c                            |    3 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/hid-hyperv.c                           |   11 +-
 drivers/hid/hid-ids.h                              |    8 +
 drivers/hid/hid-input.c                            |    2 +-
 drivers/hid/hid-microsoft.c                        |    4 +
 drivers/hid/hid-multitouch.c                       |    5 +
 drivers/hid/hid-sensor-hub.c                       |    3 +
 drivers/hid/i2c-hid/i2c-hid.c                      |    2 +-
 drivers/hid/usbhid/hid-quirks.c                    |    1 +
 drivers/hv/connection.c                            |   13 +-
 drivers/hwmon/da9055-hwmon.c                       |    4 -
 drivers/hwmon/max1668.c                            |    2 +-
 drivers/hwmon/ntc_thermistor.c                     |    6 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   68 +-
 drivers/i2c/busses/Kconfig                         |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   33 +-
 drivers/iio/accel/bma180.c                         |   16 +-
 drivers/iio/adc/max1363.c                          |    2 +-
 drivers/iio/gyro/Kconfig                           |    2 +-
 drivers/iio/gyro/st_gyro.h                         |    1 -
 drivers/iio/gyro/st_gyro_core.c                    |    9 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    1 -
 drivers/iio/gyro/st_gyro_spi.c                     |    1 -
 drivers/iio/imu/adis16400.h                        |    1 +
 drivers/iio/imu/adis16400_core.c                   |   10 +-
 drivers/iio/light/cm32181.c                        |   16 +-
 drivers/iio/light/cm36651.c                        |   45 +-
 drivers/iio/light/tsl2563.c                        |   16 +-
 drivers/iio/magnetometer/ak8975.c                  |   16 +-
 drivers/iio/magnetometer/mag3110.c                 |    8 +-
 drivers/infiniband/hw/amso1100/c2.c                |    4 +-
 drivers/infiniband/hw/amso1100/c2_rnic.c           |    3 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |    1 +
 drivers/infiniband/hw/mlx4/main.c                  |  189 ++-
 drivers/infiniband/hw/mlx5/Kconfig                 |    2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   26 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   18 +-
 drivers/infiniband/hw/mlx5/user.h                  |    7 +
 drivers/infiniband/hw/nes/nes.c                    |    5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    4 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |    5 +
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c      |    9 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |    3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |   10 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  181 +-
 drivers/infiniband/ulp/isert/ib_isert.h            |    7 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   14 +-
 drivers/input/misc/arizona-haptics.c               |   19 -
 drivers/iommu/arm-smmu.c                           |  105 +-
 drivers/iommu/omap-iommu-debug.c                   |    4 +-
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-armada-370-xp.c                |    4 +-
 drivers/irqchip/irq-metag-ext.c                    |    2 +-
 drivers/irqchip/irq-metag.c                        |    2 +-
 drivers/irqchip/irq-orion.c                        |   22 +-
 drivers/irqchip/irq-zevio.c                        |  127 ++
 drivers/isdn/hisax/q931.c                          |    2 +-
 drivers/md/Kconfig                                 |   10 -
 drivers/md/bcache/bcache.h                         |    4 +-
 drivers/md/bcache/bset.c                           |    7 +-
 drivers/md/bcache/btree.c                          |    4 +-
 drivers/md/bcache/extents.c                        |    2 +-
 drivers/md/bcache/request.c                        |    6 +-
 drivers/md/bcache/sysfs.c                          |    2 +-
 drivers/md/dm-cache-policy-mq.c                    |    4 +-
 drivers/md/dm-cache-target.c                       |   24 +-
 drivers/md/dm-io.c                                 |   23 +-
 drivers/md/dm-mpath.c                              |    7 +-
 drivers/md/dm-raid1.c                              |    3 +
 drivers/md/dm-snap-persistent.c                    |    3 +
 drivers/md/dm-thin-metadata.c                      |   58 +-
 drivers/md/dm-thin-metadata.h                      |   21 +-
 drivers/md/dm-thin.c                               |  343 +++-
 drivers/md/persistent-data/Kconfig                 |   10 +
 drivers/md/persistent-data/dm-space-map-metadata.c |  115 +-
 drivers/md/persistent-data/dm-space-map-metadata.h |   11 +
 drivers/md/raid1.c                                 |   13 +-
 drivers/md/raid5.c                                 |   90 +-
 drivers/media/dvb-frontends/cx24117.c              |   10 +-
 drivers/media/dvb-frontends/nxt200x.c              |    2 +-
 drivers/media/i2c/adv7842.c                        |    2 +-
 drivers/media/i2c/s5k5baf.c                        |   30 +-
 drivers/media/pci/bt8xx/bttv-cards.c               |    2 +-
 drivers/media/pci/bt8xx/bttv-gpio.c                |    2 +-
 drivers/media/pci/saa7134/saa7134-cards.c          |    2 +-
 drivers/media/platform/exynos4-is/fimc-core.c      |    5 +-
 drivers/media/platform/exynos4-is/fimc-lite.c      |    7 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |    8 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |    2 +
 drivers/media/usb/dvb-usb-v2/mxl111sf-demod.c      |    4 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-demod.h      |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-gpio.c       |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-gpio.h       |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c        |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.h        |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c        |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-phy.h        |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-reg.h        |    2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-tuner.c      |    4 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf-tuner.h      |    4 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c            |    6 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.h            |    2 +-
 drivers/media/usb/hdpvr/hdpvr-core.c               |    4 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c          |    1 +
 drivers/media/v4l2-core/videobuf-dma-contig.c      |   12 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |   10 +-
 drivers/media/v4l2-core/videobuf-vmalloc.c         |   10 +-
 drivers/media/v4l2-core/videobuf2-core.c           |    5 +
 drivers/message/i2o/i2o_config.c                   |    4 +-
 drivers/mfd/da9055-i2c.c                           |   12 +-
 drivers/mfd/max14577.c                             |    2 +
 drivers/mfd/max8997.c                              |    6 +-
 drivers/mfd/max8998.c                              |    6 +-
 drivers/mfd/sec-core.c                             |    2 +
 drivers/mfd/tps65217.c                             |    4 +-
 drivers/mfd/wm8994-core.c                          |    2 +-
 drivers/misc/atmel-ssc.c                           |    6 +
 drivers/misc/genwqe/card_dev.c                     |    1 +
 drivers/misc/mei/client.c                          |   15 +-
 drivers/misc/mic/host/mic_virtio.c                 |    3 +-
 drivers/misc/sgi-gru/grukdump.c                    |   11 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |    2 +-
 drivers/mmc/card/queue.c                           |    2 +-
 drivers/mtd/nand/nand_base.c                       |    2 +-
 drivers/mtd/nand/omap2.c                           |   61 +-
 drivers/mtd/ubi/fastmap.c                          |    8 +-
 drivers/net/Kconfig                                |    2 +-
 drivers/net/bonding/bond_3ad.c                     |   22 +-
 drivers/net/bonding/bond_3ad.h                     |    1 +
 drivers/net/bonding/bond_alb.c                     |    2 +-
 drivers/net/bonding/bond_main.c                    |  159 +-
 drivers/net/bonding/bond_options.c                 |    3 +-
 drivers/net/bonding/bonding.h                      |   47 +-
 drivers/net/can/Kconfig                            |    2 +-
 drivers/net/can/dev.c                              |   15 +-
 drivers/net/can/flexcan.c                          |  179 +-
 drivers/net/can/janz-ican3.c                       |   20 +-
 drivers/net/can/usb/kvaser_usb.c                   |    2 +
 drivers/net/can/vcan.c                             |    9 +-
 drivers/net/ethernet/3com/3c59x.c                  |    2 -
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    3 +
 drivers/net/ethernet/atheros/alx/main.c            |    1 +
 drivers/net/ethernet/broadcom/b44.c                |   14 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   39 +-
 drivers/net/ethernet/broadcom/bnx2.h               |    5 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   13 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   12 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |    6 +-
 drivers/net/ethernet/broadcom/tg3.c                |   20 +-
 drivers/net/ethernet/broadcom/tg3.h                |    6 +-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |    2 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   40 +-
 drivers/net/ethernet/cadence/macb.c                |   16 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    1 +
 drivers/net/ethernet/dec/tulip/tulip_core.c        |    1 +
 drivers/net/ethernet/emulex/benet/be.h             |    4 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   84 +-
 drivers/net/ethernet/ethoc.c                       |  138 +-
 drivers/net/ethernet/freescale/fec_main.c          |   31 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   25 +-
 drivers/net/ethernet/ibm/ibmveth.h                 |    1 -
 drivers/net/ethernet/intel/e100.c                  |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    6 +-
 drivers/net/ethernet/lantiq_etop.c                 |    2 +-
 drivers/net/ethernet/marvell/Kconfig               |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   10 +
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |    4 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |   11 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   14 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |    4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    4 +-
 drivers/net/ethernet/neterion/vxge/vxge-main.c     |    6 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |    1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c    |    4 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    5 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |    9 -
 drivers/net/ethernet/realtek/r8169.c               |    4 +-
 drivers/net/ethernet/sfc/ptp.c                     |    7 +
 drivers/net/ethernet/sfc/tx.c                      |    2 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   20 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  330 ++++
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   93 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +
 drivers/net/ethernet/ti/cpsw.c                     |   31 +-
 drivers/net/ethernet/tile/tilegx.c                 |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   13 +-
 drivers/net/hyperv/netvsc_drv.c                    |   53 +-
 drivers/net/hyperv/rndis_filter.c                  |   21 +-
 drivers/net/ieee802154/at86rf230.c                 |   11 +-
 drivers/net/irda/Kconfig                           |    7 -
 drivers/net/irda/Makefile                          |    1 -
 drivers/net/irda/ep7211-sir.c                      |   70 -
 drivers/net/irda/irtty-sir.c                       |    1 -
 drivers/net/macvlan.c                              |   12 +-
 drivers/net/phy/dp83640.c                          |   32 +-
 drivers/net/phy/mdio-sun4i.c                       |    3 +
 drivers/net/phy/phy.c                              |   11 +-
 drivers/net/phy/phy_device.c                       |   54 +-
 drivers/net/team/team.c                            |    2 +-
 drivers/net/tun.c                                  |    6 +-
 drivers/net/usb/Kconfig                            |   15 +
 drivers/net/usb/Makefile                           |    3 +-
 drivers/net/usb/asix_devices.c                     |    3 +-
 drivers/net/usb/ax88179_178a.c                     |   46 +-
 drivers/net/usb/cdc_ether.c                        |    7 +
 drivers/net/usb/gl620a.c                           |    4 +
 drivers/net/usb/hso.c                              |   32 +-
 drivers/net/usb/mcs7830.c                          |    5 +-
 drivers/net/usb/net1080.c                          |    4 +
 drivers/net/usb/qmi_wwan.c                         |   11 +-
 drivers/net/usb/r8152.c                            |   32 +-
 drivers/net/usb/r815x.c                            |  248 ---
 drivers/net/usb/rndis_host.c                       |    4 +
 drivers/net/usb/smsc75xx.c                         |    4 +
 drivers/net/usb/smsc95xx.c                         |    4 +
 drivers/net/usb/sr9800.c                           |  874 ++++++++++
 drivers/net/usb/sr9800.h                           |  202 +++
 drivers/net/usb/usbnet.c                           |   25 +-
 drivers/net/veth.c                                 |    3 +-
 drivers/net/virtio_net.c                           |    3 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   19 +-
 drivers/net/vxlan.c                                |    3 -
 drivers/net/wan/dlci.c                             |    5 -
 drivers/net/wireless/ath/ar5523/ar5523.c           |    2 +-
 drivers/net/wireless/ath/ath5k/phy.c               |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c     |    4 +
 .../net/wireless/ath/ath9k/ar9462_2p0_initvals.h   |    4 +-
 drivers/net/wireless/ath/ath9k/htc.h               |    2 +
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |    8 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   63 +-
 drivers/net/wireless/ath/ath9k/hw.c                |   13 +-
 drivers/net/wireless/ath/ath9k/init.c              |    8 +-
 drivers/net/wireless/ath/ath9k/recv.c              |   70 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   13 +-
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |   14 +-
 drivers/net/wireless/hostap/hostap_ap.c            |    2 +-
 drivers/net/wireless/hostap/hostap_proc.c          |    2 +-
 drivers/net/wireless/iwlwifi/dvm/mac80211.c        |   22 +-
 drivers/net/wireless/iwlwifi/dvm/sta.c             |    1 +
 drivers/net/wireless/iwlwifi/dvm/tx.c              |   14 +-
 drivers/net/wireless/iwlwifi/iwl-drv.c             |    2 +-
 drivers/net/wireless/iwlwifi/iwl-modparams.h       |   11 +-
 drivers/net/wireless/iwlwifi/iwl-nvm-parse.c       |    5 +
 drivers/net/wireless/iwlwifi/mvm/bt-coex.c         |    7 +-
 drivers/net/wireless/iwlwifi/mvm/fw-api-scan.h     |    4 +-
 drivers/net/wireless/iwlwifi/mvm/mac80211.c        |   24 +-
 drivers/net/wireless/iwlwifi/mvm/mvm.h             |    2 +-
 drivers/net/wireless/iwlwifi/mvm/scan.c            |    5 +-
 drivers/net/wireless/iwlwifi/mvm/sta.c             |    2 +-
 drivers/net/wireless/iwlwifi/mvm/tx.c              |   91 +-
 drivers/net/wireless/iwlwifi/mvm/utils.c           |    2 +
 drivers/net/wireless/iwlwifi/pcie/drv.c            |    8 +-
 drivers/net/wireless/libertas/cfg.c                |    2 +-
 drivers/net/wireless/mwifiex/11ac.c                |    3 +-
 drivers/net/wireless/mwifiex/11n.c                 |    3 +-
 drivers/net/wireless/mwifiex/main.c                |    2 +-
 drivers/net/wireless/mwifiex/pcie.c                |   34 +-
 drivers/net/wireless/mwifiex/scan.c                |    8 +-
 drivers/net/wireless/mwifiex/usb.c                 |   12 +-
 drivers/net/wireless/mwifiex/wmm.c                 |    3 +-
 drivers/net/wireless/rt2x00/rt2500pci.c            |    5 +
 drivers/net/wireless/rt2x00/rt2500usb.c            |    5 +
 drivers/net/wireless/rt2x00/rt2800lib.c            |    5 +-
 drivers/net/wireless/rtl818x/rtl8180/dev.c         |   23 +-
 drivers/net/wireless/rtl818x/rtl8187/rtl8187.h     |   10 +-
 drivers/net/wireless/rtlwifi/ps.c                  |    2 +-
 drivers/net/wireless/rtlwifi/rtl8192ce/hw.c        |   18 +-
 drivers/net/wireless/ti/wl1251/rx.c                |    2 +-
 drivers/net/xen-netback/common.h                   |    6 +-
 drivers/net/xen-netback/interface.c                |    4 +-
 drivers/net/xen-netback/netback.c                  |   55 +-
 drivers/net/xen-netfront.c                         |    6 +-
 drivers/of/address.c                               |    5 +-
 drivers/of/base.c                                  |  128 +-
 drivers/of/of_mdio.c                               |   22 +-
 drivers/of/selftest.c                              |   67 +
 drivers/of/testcase-data/testcases.dtsi            |    3 +
 .../of/testcase-data}/tests-interrupts.dtsi        |    0
 drivers/of/testcase-data/tests-match.dtsi          |   19 +
 .../of/testcase-data}/tests-phandle.dtsi           |    0
 drivers/pci/bus.c                                  |    2 -
 drivers/pci/host/pci-mvebu.c                       |   11 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   70 +-
 drivers/pci/msi.c                                  |   10 +-
 drivers/pci/pci.c                                  |   13 +
 drivers/phy/Kconfig                                |    3 +-
 drivers/phy/phy-core.c                             |   76 +-
 drivers/phy/phy-exynos-dp-video.c                  |    8 +-
 drivers/phy/phy-exynos-mipi-video.c                |   10 +-
 drivers/phy/phy-mvebu-sata.c                       |   10 +-
 drivers/phy/phy-omap-usb2.c                        |   10 +-
 drivers/phy/phy-twl4030-usb.c                      |   10 +-
 drivers/pinctrl/Kconfig                            |    2 +-
 drivers/pinctrl/core.c                             |    8 +-
 drivers/pinctrl/pinctrl-at91.c                     |   10 +-
 drivers/pinctrl/pinctrl-capri.c                    |    2 +-
 drivers/pinctrl/pinctrl-imx1-core.c                |   10 +-
 drivers/pinctrl/pinctrl-sunxi.c                    |    6 +-
 drivers/pinctrl/pinctrl-sunxi.h                    |    6 +-
 drivers/pinctrl/pinctrl-tegra.c                    |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |    6 +-
 drivers/pinctrl/sirf/pinctrl-prima2.c              |    2 +-
 drivers/pinctrl/sirf/pinctrl-sirf.c                |    4 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |   15 +-
 drivers/pnp/pnpacpi/rsparser.c                     |   15 +-
 drivers/power/ds2782_battery.c                     |    2 +-
 drivers/power/isp1704_charger.c                    |    2 -
 drivers/power/max17040_battery.c                   |    5 +-
 drivers/pwm/pwm-lp3943.c                           |    4 +-
 drivers/rapidio/devices/tsi721.h                   |    1 +
 drivers/rapidio/devices/tsi721_dma.c               |   27 +-
 drivers/regulator/ab3100.c                         |    4 +-
 drivers/regulator/core.c                           |   59 +-
 drivers/regulator/da9055-regulator.c               |    4 +-
 drivers/regulator/da9063-regulator.c               |    4 +-
 drivers/regulator/max14577.c                       |   10 +-
 drivers/regulator/s2mps11.c                        |    1 +
 drivers/regulator/s5m8767.c                        |    4 +-
 drivers/rtc/rtc-s3c.c                              |   17 +-
 drivers/s390/cio/chsc.c                            |    1 +
 drivers/s390/cio/cio.c                             |   40 +-
 drivers/s390/cio/qdio.h                            |   14 +-
 drivers/s390/cio/qdio_main.c                       |    2 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |   24 +-
 drivers/s390/net/qeth_core_main.c                  |    5 +-
 drivers/s390/net/qeth_l2_main.c                    |    3 +
 drivers/s390/net/qeth_l3_main.c                    |    3 +
 drivers/sbus/char/jsflash.c                        |    1 -
 drivers/scsi/be2iscsi/be_main.c                    |    2 +-
 drivers/scsi/isci/host.h                           |    5 +-
 drivers/scsi/isci/port_config.c                    |    7 -
 drivers/scsi/isci/task.c                           |    2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |    3 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   46 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   44 +-
 drivers/scsi/qla2xxx/qla_target.h                  |    3 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                 |  158 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.h                 |    7 +-
 drivers/scsi/scsi_lib.c                            |    2 +-
 drivers/scsi/storvsc_drv.c                         |    3 +
 drivers/spi/Kconfig                                |    4 +-
 drivers/spi/spi-ath79.c                            |    4 +-
 drivers/spi/spi-atmel.c                            |   17 +-
 drivers/spi/spi-coldfire-qspi.c                    |    6 +-
 drivers/spi/spi-fsl-dspi.c                         |    6 +-
 drivers/spi/spi-imx.c                              |    4 +-
 drivers/spi/spi-nuc900.c                           |    2 +
 drivers/spi/spi-topcliff-pch.c                     |   15 +-
 drivers/spi/spi.c                                  |    4 +-
 drivers/staging/android/ashmem.c                   |   45 +-
 drivers/staging/android/binder.c                   |    3 +-
 drivers/staging/android/ion/compat_ion.c           |   26 +-
 drivers/staging/android/ion/ion_dummy_driver.c     |   12 +-
 drivers/staging/android/ion/ion_heap.c             |    2 +-
 drivers/staging/android/ion/ion_priv.h             |    1 +
 drivers/staging/android/ion/ion_system_heap.c      |    6 +-
 drivers/staging/android/sw_sync.h                  |   17 +
 drivers/staging/android/sync.c                     |   14 +-
 drivers/staging/bcm/Bcmnet.c                       |    2 +-
 drivers/staging/comedi/drivers.c                   |    2 -
 drivers/staging/comedi/drivers/adv_pci1710.c       |   17 +-
 drivers/staging/comedi/drivers/usbduxsigma.c       |    6 +-
 drivers/staging/cxt1e1/linux.c                     |    2 +
 drivers/staging/dgrp/dgrp_net_ops.c                |  330 ++--
 drivers/staging/gdm72xx/gdm_usb.c                  |    3 +
 drivers/staging/iio/Documentation/iio_utils.h      |    6 +-
 drivers/staging/iio/adc/ad799x_core.c              |   13 +-
 drivers/staging/iio/adc/mxs-lradc.c                |    7 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    2 +-
 drivers/staging/imx-drm/imx-drm-core.c             |   55 +-
 drivers/staging/imx-drm/imx-hdmi.c                 |   22 +-
 drivers/staging/lustre/TODO                        |    5 +-
 .../include/linux/libcfs/libcfs_kernelcomm.h       |    2 +
 .../lustre/include/linux/libcfs/libcfs_private.h   |    2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    2 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |    5 +-
 .../lustre/lustre/include/lustre/lustre_user.h     |    3 +-
 drivers/staging/lustre/lustre/llite/dir.c          |    2 +-
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |    6 +-
 drivers/staging/media/go7007/go7007-loader.c       |    4 +-
 drivers/staging/netlogic/xlr_net.c                 |    7 +-
 drivers/staging/octeon-usb/octeon-hcd.c            |  273 ++-
 drivers/staging/ozwpan/ozproto.c                   |    3 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |   22 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   12 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |    2 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    3 +-
 drivers/staging/rtl8821ae/Kconfig                  |    2 +-
 drivers/staging/rtl8821ae/wifi.h                   |    2 +-
 drivers/staging/usbip/userspace/libsrc/names.c     |    8 +-
 drivers/staging/usbip/vhci_sysfs.c                 |    3 +-
 drivers/staging/wlags49_h2/wl_wext.c               |    2 +-
 drivers/target/iscsi/iscsi_target.c                |   10 +-
 drivers/target/iscsi/iscsi_target_erl1.c           |    4 +-
 drivers/target/iscsi/iscsi_target_erl2.c           |   16 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |    2 +-
 drivers/target/target_core_alua.c                  |    2 +-
 drivers/target/target_core_pr.c                    |   11 +-
 drivers/target/target_core_sbc.c                   |   39 +-
 drivers/target/target_core_spc.c                   |    4 +-
 drivers/target/target_core_transport.c             |    8 +-
 drivers/thermal/Kconfig                            |   13 +-
 drivers/thermal/thermal_core.c                     |   27 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   11 +-
 drivers/tty/hvc/hvc_opal.c                         |    8 +-
 drivers/tty/hvc/hvc_rtas.c                         |   12 +-
 drivers/tty/hvc/hvc_udbg.c                         |    9 +-
 drivers/tty/hvc/hvc_xen.c                          |   17 +-
 drivers/tty/n_gsm.c                                |   11 +
 drivers/tty/n_tty.c                                |   14 +-
 drivers/tty/serial/8250/8250_core.c                |   18 +
 drivers/tty/serial/8250/8250_dw.c                  |    4 +-
 drivers/tty/serial/8250/8250_pci.c                 |    3 +-
 drivers/tty/serial/omap-serial.c                   |   11 +-
 drivers/tty/serial/sirfsoc_uart.c                  |    4 +-
 drivers/tty/vt/vt.c                                |    2 +
 drivers/usb/chipidea/udc.c                         |    4 +-
 drivers/usb/core/config.c                          |    4 +
 drivers/usb/core/driver.c                          |   24 +-
 drivers/usb/core/hcd.c                             |    1 -
 drivers/usb/core/hub.c                             |    7 +-
 drivers/usb/core/quirks.c                          |    4 +
 drivers/usb/core/usb.h                             |    1 -
 drivers/usb/dwc2/core.c                            |    2 +-
 drivers/usb/dwc2/hcd.c                             |   11 -
 drivers/usb/dwc2/platform.c                        |    3 +
 drivers/usb/gadget/bcm63xx_udc.c                   |   58 +-
 drivers/usb/gadget/f_fs.c                          |    7 +-
 drivers/usb/gadget/printer.c                       |    2 +-
 drivers/usb/gadget/s3c2410_udc.c                   |    2 +-
 drivers/usb/host/ehci-hcd.c                        |   13 +-
 drivers/usb/host/ehci-hub.c                        |   26 +-
 drivers/usb/host/xhci-dbg.c                        |    6 +-
 drivers/usb/host/xhci-mem.c                        |   14 +-
 drivers/usb/host/xhci-pci.c                        |    5 +
 drivers/usb/host/xhci-ring.c                       |   68 +-
 drivers/usb/host/xhci.c                            |   24 +-
 drivers/usb/host/xhci.h                            |   41 +-
 drivers/usb/musb/musb_core.c                       |   15 +-
 drivers/usb/musb/musb_host.c                       |    3 +
 drivers/usb/musb/musb_virthub.c                    |   26 +-
 drivers/usb/musb/omap2430.c                        |    2 -
 drivers/usb/phy/phy-msm-usb.c                      |   57 +-
 drivers/usb/phy/phy.c                              |    8 +-
 drivers/usb/serial/ftdi_sio.c                      |    5 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   13 +
 drivers/usb/serial/option.c                        |    6 +-
 drivers/usb/serial/qcserial.c                      |    3 +
 drivers/usb/serial/usb-serial-simple.c             |    3 +-
 drivers/usb/storage/Kconfig                        |    4 +-
 drivers/usb/storage/scsiglue.c                     |    6 +
 drivers/usb/storage/unusual_cypress.h              |    2 +-
 drivers/usb/storage/unusual_devs.h                 |    7 +
 drivers/vfio/vfio_iommu_type1.c                    |    4 +-
 drivers/vhost/net.c                                |   47 +-
 drivers/vhost/scsi.c                               |    6 +
 drivers/video/Kconfig                              |    2 +-
 drivers/video/exynos/Kconfig                       |    3 +-
 drivers/video/omap2/dss/dispc.c                    |   16 +-
 drivers/video/omap2/dss/dpi.c                      |    2 +-
 drivers/video/omap2/dss/sdi.c                      |    2 +-
 drivers/vme/bridges/vme_ca91cx42.c                 |    4 +-
 drivers/vme/bridges/vme_tsi148.c                   |    4 +-
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/w83697hf_wdt.c                    |    2 +-
 drivers/xen/Makefile                               |    1 -
 drivers/xen/events/events_base.c                   |    2 +
 drivers/xen/gntdev.c                               |   13 +-
 drivers/xen/grant-table.c                          |   89 +-
 drivers/xen/xencomm.c                              |  219 ---
 fs/bio-integrity.c                                 |   18 +-
 fs/bio.c                                           |   15 +-
 fs/btrfs/check-integrity.c                         |    4 +-
 fs/btrfs/compression.c                             |    2 +
 fs/btrfs/disk-io.c                                 |    5 +-
 fs/btrfs/extent-tree.c                             |    1 +
 fs/btrfs/inode.c                                   |    4 +-
 fs/btrfs/ioctl.c                                   |   22 +-
 fs/btrfs/send.c                                    |   22 +-
 fs/btrfs/super.c                                   |   13 +-
 fs/btrfs/sysfs.c                                   |   10 +-
 fs/buffer.c                                        |    6 +-
 fs/ceph/acl.c                                      |   11 +-
 fs/ceph/dir.c                                      |   23 +-
 fs/ceph/file.c                                     |    1 +
 fs/ceph/super.c                                    |   32 +-
 fs/ceph/super.h                                    |    7 +-
 fs/ceph/xattr.c                                    |   54 +-
 fs/cifs/cifsacl.c                                  |   61 +-
 fs/cifs/cifsglob.h                                 |   13 +-
 fs/cifs/cifsproto.h                                |    9 +-
 fs/cifs/cifssmb.c                                  |   15 +-
 fs/cifs/dir.c                                      |    2 +-
 fs/cifs/file.c                                     |   94 +-
 fs/cifs/inode.c                                    |   15 +-
 fs/cifs/smb1ops.c                                  |    9 +
 fs/cifs/smb2glob.h                                 |    3 +
 fs/cifs/smb2ops.c                                  |   14 +-
 fs/cifs/smb2pdu.c                                  |    9 +-
 fs/cifs/smb2proto.h                                |    3 +-
 fs/cifs/transport.c                                |   29 +
 fs/cifs/xattr.c                                    |   15 +-
 fs/exec.c                                          |   45 +-
 fs/ext4/ext4.h                                     |    2 +
 fs/ext4/extents.c                                  |    1 +
 fs/ext4/file.c                                     |    2 +-
 fs/ext4/ioctl.c                                    |    3 +-
 fs/ext4/resize.c                                   |   34 +-
 fs/ext4/super.c                                    |   20 +-
 fs/file.c                                          |   58 +-
 fs/file_table.c                                    |    1 +
 fs/fs-writeback.c                                  |   33 +-
 fs/fscache/object-list.c                           |    5 +
 fs/fscache/object.c                                |    3 +
 fs/hfsplus/catalog.c                               |   41 +
 fs/hfsplus/hfsplus_fs.h                            |    1 +
 fs/hfsplus/hfsplus_raw.h                           |    6 +-
 fs/hfsplus/inode.c                                 |    9 +
 fs/hfsplus/options.c                               |    2 +-
 fs/jbd2/transaction.c                              |    6 +-
 fs/jfs/acl.c                                       |    2 +
 fs/jfs/xattr.c                                     |   14 +-
 fs/kernfs/dir.c                                    |   12 +-
 fs/kernfs/mount.c                                  |    8 +-
 fs/lockd/svclock.c                                 |    8 +
 fs/namei.c                                         |   32 +-
 fs/nfs/delegation.c                                |   11 +-
 fs/nfs/dir.c                                       |    5 +
 fs/nfs/inode.c                                     |   14 +-
 fs/nfs/internal.h                                  |   12 +-
 fs/nfs/nfs3acl.c                                   |   34 +-
 fs/nfs/nfs3proc.c                                  |    1 +
 fs/nfs/nfs4client.c                                |    9 +-
 fs/nfs/nfs4filelayout.c                            |   10 +-
 fs/nfs/nfs4namespace.c                             |   12 +-
 fs/nfs/nfs4proc.c                                  |   32 +-
 fs/nfs/nfs4session.c                               |   25 +-
 fs/nfs/nfs4session.h                               |    2 +-
 fs/nfs/nfs4state.c                                 |   19 +-
 fs/nfsd/nfs4acl.c                                  |    9 +-
 fs/notify/dnotify/dnotify.c                        |    2 +-
 fs/notify/fanotify/fanotify.c                      |    8 +-
 fs/notify/fanotify/fanotify_user.c                 |   13 +
 fs/notify/fsnotify.c                               |    2 +-
 fs/notify/group.c                                  |    8 +-
 fs/notify/inotify/inotify.h                        |    2 +-
 fs/notify/inotify/inotify_fsnotify.c               |    3 +-
 fs/notify/inotify/inotify_user.c                   |   14 +-
 fs/notify/notification.c                           |   20 +-
 fs/ntfs/file.c                                     |    2 +-
 fs/ocfs2/alloc.c                                   |   40 +-
 fs/ocfs2/file.c                                    |   60 +-
 fs/ocfs2/localalloc.c                              |   42 +
 fs/ocfs2/localalloc.h                              |    6 +
 fs/ocfs2/namei.c                                   |   17 +
 fs/ocfs2/quota_global.c                            |   27 +-
 fs/ocfs2/quota_local.c                             |    4 -
 fs/open.c                                          |    4 +
 fs/posix_acl.c                                     |   18 +-
 fs/proc/base.c                                     |    1 +
 fs/proc/page.c                                     |    5 +-
 fs/proc/vmcore.c                                   |   26 +-
 fs/quota/dquot.c                                   |   14 +-
 fs/read_write.c                                    |   40 +-
 fs/reiserfs/do_balan.c                             |  895 +++-------
 fs/sync.c                                          |   32 +-
 fs/sysfs/mount.c                                   |    5 +-
 fs/udf/file.c                                      |   14 +-
 fs/udf/inode.c                                     |    1 +
 fs/xfs/xfs_file.c                                  |    2 +-
 fs/xfs/xfs_iops.c                                  |   16 +-
 fs/xfs/xfs_log_cil.c                               |   19 +-
 fs/xfs/xfs_mount.c                                 |   24 +-
 fs/xfs/xfs_sb.c                                    |   10 +-
 fs/xfs/xfs_super.c                                 |    2 +-
 include/asm-generic/pgtable.h                      |   39 +
 include/drm/drmP.h                                 |    3 +
 include/drm/drm_crtc.h                             |    3 +
 include/drm/ttm/ttm_page_alloc.h                   |    2 +
 include/dt-bindings/clock/tegra124-car.h           |    4 +-
 include/kvm/arm_vgic.h                             |    5 +
 include/linux/atmel-ssc.h                          |    1 +
 include/linux/audit.h                              |    3 +-
 include/linux/binfmts.h                            |    1 -
 include/linux/bio.h                                |   12 +
 include/linux/blk-mq.h                             |   16 +-
 include/linux/blkdev.h                             |   11 +-
 include/linux/can/skb.h                            |   38 +
 include/linux/ceph/ceph_fs.h                       |    5 +-
 include/linux/cgroup.h                             |    2 +
 include/linux/clk/ti.h                             |    4 +
 include/linux/compiler-gcc4.h                      |    6 +-
 include/linux/dma-buf.h                            |    2 +-
 include/linux/file.h                               |   27 +-
 include/linux/firewire.h                           |    1 +
 include/linux/fs.h                                 |   17 +-
 include/linux/fsnotify_backend.h                   |    4 +-
 include/linux/gfp.h                                |    4 +
 include/linux/gpio/consumer.h                      |    4 +-
 include/linux/huge_mm.h                            |   41 -
 include/linux/hyperv.h                             |    2 +-
 include/linux/interrupt.h                          |    5 +
 include/linux/ipc_namespace.h                      |    2 -
 include/linux/kernfs.h                             |    9 +-
 include/linux/mfd/arizona/registers.h              |    6 +-
 include/linux/mfd/max8997-private.h                |    2 +-
 include/linux/mfd/max8998-private.h                |    2 +-
 include/linux/mfd/tps65217.h                       |    4 +-
 include/linux/mlx5/driver.h                        |    3 +
 include/linux/mm.h                                 |   20 +-
 include/linux/mmzone.h                             |    4 +-
 include/linux/netdevice.h                          |   36 +-
 include/linux/nfs_xdr.h                            |    7 +
 include/linux/nvme.h                               |    6 +-
 include/linux/of.h                                 |  153 +-
 include/linux/of_device.h                          |    4 +-
 include/linux/page-flags.h                         |    4 +-
 include/linux/pci.h                                |   20 +
 include/linux/phy/phy.h                            |   14 +
 include/linux/platform_data/adau1977.h             |   45 +
 include/linux/platform_data/asoc-s3c.h             |    3 +-
 include/linux/platform_data/asoc-s3c24xx_simtec.h  |    3 +-
 include/linux/platform_data/davinci_asp.h          |    4 +-
 include/linux/regmap.h                             |    9 +
 include/linux/sched.h                              |    3 +-
 include/linux/skbuff.h                             |   22 +-
 include/linux/slab.h                               |    2 +-
 include/linux/smp.h                                |    3 +
 include/linux/spi/spi.h                            |    7 +-
 include/linux/syscalls.h                           |    6 +-
 include/linux/tracepoint.h                         |    6 +
 include/linux/usb.h                                |    2 -
 include/linux/vm_event_item.h                      |    4 +-
 include/linux/vmstat.h                             |    8 +
 include/linux/workqueue.h                          |    5 +-
 include/linux/writeback.h                          |    2 +-
 include/net/datalink.h                             |    2 +
 include/net/dn.h                                   |    2 +
 include/net/dn_route.h                             |    2 +
 include/net/ethoc.h                                |    1 +
 include/net/ip_tunnels.h                           |    1 +
 include/net/ipx.h                                  |   11 +
 include/net/net_namespace.h                        |    8 +
 include/net/netfilter/nf_conntrack.h               |    2 +
 include/net/netfilter/nf_tables.h                  |    9 +-
 include/net/netfilter/nft_reject.h                 |   25 +
 include/net/sctp/structs.h                         |   14 +-
 include/net/sock.h                                 |    6 +-
 include/net/tcp.h                                  |    3 +-
 include/net/xfrm.h                                 |   11 +
 include/rdma/ib_verbs.h                            |    3 +-
 include/sound/rcar_snd.h                           |   36 +-
 include/sound/simple_card.h                        |    6 +-
 include/sound/soc-dai.h                            |    3 +
 include/sound/soc-dapm.h                           |   48 +-
 include/sound/soc.h                                |  137 +-
 include/target/iscsi/iscsi_transport.h             |    1 +
 include/target/target_core_base.h                  |    1 -
 include/trace/events/hswadsp.h                     |  384 +++++
 include/trace/events/intel-sst.h                   |  148 ++
 include/trace/events/power.h                       |    7 +-
 include/trace/events/sunrpc.h                      |    4 +-
 include/trace/events/writeback.h                   |    6 +-
 include/uapi/asm-generic/unistd.h                  |    6 +-
 include/uapi/drm/drm.h                             |    2 +
 include/uapi/drm/vmwgfx_drm.h                      |    1 +
 include/uapi/linux/btrfs.h                         |    1 -
 include/uapi/linux/in6.h                           |   23 +-
 include/uapi/linux/mic_ioctl.h                     |    2 +-
 include/uapi/linux/nvme.h                          |   11 +
 include/uapi/xen/Kbuild                            |    2 +
 include/{ =3D> uapi}/xen/gntalloc.h                  |    0
 include/{ =3D> uapi}/xen/gntdev.h                    |    0
 include/xen/grant_table.h                          |    8 +-
 include/xen/interface/io/blkif.h                   |   34 +-
 include/xen/interface/xencomm.h                    |   41 -
 include/xen/xencomm.h                              |   77 -
 init/main.c                                        |    4 +-
 ipc/mq_sysctl.c                                    |   18 +-
 ipc/mqueue.c                                       |    6 +-
 ipc/msg.c                                          |    2 +
 kernel/audit.c                                     |   31 +-
 kernel/audit.h                                     |    2 +-
 kernel/audit_tree.c                                |    2 +-
 kernel/audit_watch.c                               |    2 +-
 kernel/auditfilter.c                               |   10 +-
 kernel/auditsc.c                                   |    2 +-
 kernel/cgroup.c                                    |   60 +-
 kernel/cpuset.c                                    |   10 +-
 kernel/events/core.c                               |   12 +-
 kernel/irq/Kconfig                                 |    1 +
 kernel/irq/devres.c                                |   45 +
 kernel/irq/irqdesc.c                               |    1 +
 kernel/irq/irqdomain.c                             |    1 +
 kernel/irq/manage.c                                |    3 +-
 kernel/kmod.c                                      |    2 +-
 kernel/power/console.c                             |    1 +
 kernel/printk/printk.c                             |    2 -
 kernel/profile.c                                   |    4 +-
 kernel/sched/clock.c                               |    4 +-
 kernel/sched/core.c                                |   37 +-
 kernel/sched/cpudeadline.c                         |    6 +-
 kernel/sched/deadline.c                            |   20 +-
 kernel/sched/fair.c                                |   10 +-
 kernel/sched/rt.c                                  |    8 +
 kernel/sched/sched.h                               |    1 -
 kernel/stop_machine.c                              |    2 +-
 kernel/time/jiffies.c                              |    6 +
 kernel/time/sched_clock.c                          |   46 +-
 kernel/time/tick-broadcast.c                       |    1 +
 kernel/trace/ring_buffer.c                         |    7 +
 kernel/trace/trace_events.c                        |   10 +
 kernel/tracepoint.c                                |    7 +-
 kernel/user_namespace.c                            |    2 +-
 kernel/workqueue.c                                 |    7 +
 lib/Kconfig.debug                                  |    2 +-
 lib/Makefile                                       |    1 +
 lib/dma-debug.c                                    |  131 +-
 lib/percpu_ida.c                                   |    7 +-
 lib/radix-tree.c                                   |    4 +-
 mm/Kconfig                                         |    4 +-
 mm/compaction.c                                    |   20 +-
 mm/filemap.c                                       |    4 +-
 mm/huge_memory.c                                   |   20 +-
 mm/ksm.c                                           |    2 +-
 mm/memcontrol.c                                    |   20 +-
 mm/memory-failure.c                                |    8 +-
 mm/memory.c                                        |   15 +-
 mm/migrate.c                                       |   11 +-
 mm/mprotect.c                                      |   25 +-
 mm/page-writeback.c                                |    5 +-
 mm/page_alloc.c                                    |   30 +-
 mm/slub.c                                          |   38 +-
 mm/swap.c                                          |    4 +-
 mm/swap_state.c                                    |   63 +-
 mm/swapfile.c                                      |   11 +-
 mm/vmpressure.c                                    |    1 +
 mm/vmstat.c                                        |    4 +-
 net/8021q/vlan_dev.c                               |    3 +
 net/9p/client.c                                    |    2 +-
 net/9p/trans_virtio.c                              |    5 +-
 net/batman-adv/bat_iv_ogm.c                        |   30 +-
 net/batman-adv/hard-interface.c                    |   22 +-
 net/batman-adv/originator.c                        |   36 +
 net/batman-adv/originator.h                        |    4 +
 net/batman-adv/routing.c                           |    4 +-
 net/batman-adv/send.c                              |    9 +-
 net/batman-adv/translation-table.c                 |   23 +-
 net/bluetooth/hidp/core.c                          |   16 +-
 net/bluetooth/hidp/hidp.h                          |    4 +
 net/bridge/br_device.c                             |   54 +-
 net/bridge/br_fdb.c                                |  137 +-
 net/bridge/br_if.c                                 |    6 +-
 net/bridge/br_input.c                              |    4 +-
 net/bridge/br_multicast.c                          |   33 +-
 net/bridge/br_private.h                            |   13 +-
 net/bridge/br_stp_if.c                             |    2 +
 net/bridge/br_vlan.c                               |   27 +-
 net/caif/caif_dev.c                                |    1 +
 net/caif/cfsrvl.c                                  |    1 +
 net/can/af_can.c                                   |    3 +-
 net/can/bcm.c                                      |    4 +-
 net/can/raw.c                                      |   27 +-
 net/ceph/messenger.c                               |    8 +-
 net/ceph/osd_client.c                              |   84 +-
 net/core/dev.c                                     |   28 +-
 net/core/fib_rules.c                               |    7 +
 net/core/flow_dissector.c                          |   20 +-
 net/core/neighbour.c                               |    8 +-
 net/core/netpoll.c                                 |    4 +-
 net/core/rtnetlink.c                               |   21 +-
 net/core/skbuff.c                                  |  103 +-
 net/core/sock.c                                    |   11 +-
 net/dccp/ccids/lib/tfrc.c                          |    2 +-
 net/dccp/ccids/lib/tfrc.h                          |    1 +
 net/decnet/af_decnet.c                             |    5 -
 net/hsr/hsr_framereg.c                             |    2 +-
 net/ieee802154/6lowpan.c                           |   23 +-
 net/ipv4/af_inet.c                                 |    7 +-
 net/ipv4/devinet.c                                 |    3 +-
 net/ipv4/inet_fragment.c                           |    5 +-
 net/ipv4/ip_forward.c                              |   71 +-
 net/ipv4/ip_output.c                               |    3 -
 net/ipv4/ip_tunnel.c                               |   82 +-
 net/ipv4/ip_tunnel_core.c                          |   47 +-
 net/ipv4/ipconfig.c                                |    2 +-
 net/ipv4/netfilter/Kconfig                         |    5 +
 net/ipv4/netfilter/Makefile                        |    1 +
 net/ipv4/netfilter/nf_nat_h323.c                   |    5 +-
 net/ipv4/netfilter/nf_nat_snmp_basic.c             |    4 +-
 net/ipv4/netfilter/nft_reject_ipv4.c               |   75 +
 net/ipv4/route.c                                   |   13 +-
 net/ipv4/tcp.c                                     |   10 +-
 net/ipv4/tcp_cong.c                                |    3 +-
 net/ipv4/tcp_input.c                               |   21 +-
 net/ipv4/tcp_output.c                              |   48 +-
 net/ipv4/udp_offload.c                             |   17 +-
 net/ipv6/Kconfig                                   |    1 +
 net/ipv6/addrconf.c                                |    7 +-
 net/ipv6/exthdrs_core.c                            |    2 +-
 net/ipv6/exthdrs_offload.c                         |    4 +-
 net/ipv6/icmp.c                                    |    2 +-
 net/ipv6/ip6_offload.c                             |   20 +-
 net/ipv6/ip6_output.c                              |   20 +-
 net/ipv6/netfilter/Kconfig                         |    5 +
 net/ipv6/netfilter/Makefile                        |    1 +
 net/ipv6/netfilter/nft_reject_ipv6.c               |   76 +
 net/ipv6/ping.c                                    |    1 +
 net/ipv6/route.c                                   |    2 +-
 net/ipv6/sit.c                                     |   19 +
 net/ipv6/udp_offload.c                             |    2 +-
 net/ipx/af_ipx.c                                   |   22 +-
 net/ipx/ipx_route.c                                |    4 -
 net/l2tp/l2tp_core.c                               |    4 +-
 net/l2tp/l2tp_core.h                               |    1 +
 net/l2tp/l2tp_netlink.c                            |    4 +-
 net/l2tp/l2tp_ppp.c                                |   13 +-
 net/mac80211/cfg.c                                 |   44 +-
 net/mac80211/chan.c                                |    6 +
 net/mac80211/ht.c                                  |    4 +-
 net/mac80211/ibss.c                                |    5 +-
 net/mac80211/ieee80211_i.h                         |   10 +-
 net/mac80211/iface.c                               |   33 +-
 net/mac80211/mesh_ps.c                             |    1 +
 net/mac80211/mlme.c                                |   24 +
 net/mac80211/rx.c                                  |    7 +
 net/mac80211/sta_info.c                            |   67 +-
 net/mac80211/sta_info.h                            |    7 +-
 net/mac80211/tx.c                                  |   17 +-
 net/mac80211/util.c                                |   48 +-
 net/mac80211/wme.c                                 |    5 +
 net/netfilter/Kconfig                              |    6 +-
 net/netfilter/Makefile                             |    1 +
 net/netfilter/ipvs/ip_vs_conn.c                    |    8 +-
 net/netfilter/nf_conntrack_core.c                  |   55 +-
 net/netfilter/nf_conntrack_netlink.c               |   35 +-
 net/netfilter/nf_nat_core.c                        |   56 +-
 net/netfilter/nf_synproxy_core.c                   |    5 +-
 net/netfilter/nf_tables_api.c                      |   82 +-
 net/netfilter/nf_tables_core.c                     |    6 +-
 net/netfilter/nft_ct.c                             |   16 +-
 net/netfilter/nft_log.c                            |    5 +-
 net/netfilter/nft_lookup.c                         |    1 +
 net/netfilter/nft_meta.c                           |    4 +-
 net/netfilter/nft_payload.c                        |    3 +-
 net/netfilter/nft_queue.c                          |    4 +-
 net/netfilter/nft_rbtree.c                         |   16 +-
 net/netfilter/nft_reject.c                         |   89 +-
 net/netfilter/nft_reject_inet.c                    |   63 +
 net/netfilter/xt_CT.c                              |    7 +-
 net/netlink/af_netlink.c                           |    4 +-
 net/nfc/nci/core.c                                 |    2 +-
 net/openvswitch/datapath.c                         |   23 +-
 net/openvswitch/flow_table.c                       |   88 +-
 net/openvswitch/flow_table.h                       |    2 +-
 net/packet/af_packet.c                             |   26 +-
 net/sched/sch_api.c                                |    7 +-
 net/sched/sch_fq.c                                 |   21 +-
 net/sched/sch_pie.c                                |   21 +-
 net/sched/sch_tbf.c                                |   24 +-
 net/sctp/associola.c                               |  211 ++-
 net/sctp/ipv6.c                                    |    2 +
 net/sctp/sm_make_chunk.c                           |    4 +-
 net/sctp/sm_sideeffect.c                           |    7 +-
 net/sctp/sm_statefuns.c                            |   12 +-
 net/sctp/socket.c                                  |   47 +-
 net/sctp/sysctl.c                                  |   18 +-
 net/sctp/ulpevent.c                                |    8 +-
 net/socket.c                                       |   17 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   19 +-
 net/sunrpc/backchannel_rqst.c                      |    6 +-
 net/sunrpc/svc_xprt.c                              |    6 +-
 net/sunrpc/xprtsock.c                              |    6 +-
 net/tipc/bearer.c                                  |    7 +-
 net/tipc/config.c                                  |   11 +-
 net/tipc/core.c                                    |  109 +-
 net/tipc/core.h                                    |    2 +-
 net/tipc/handler.c                                 |    1 -
 net/tipc/link.c                                    |    7 +
 net/tipc/name_table.c                              |   40 +-
 net/tipc/netlink.c                                 |    8 -
 net/tipc/ref.c                                     |    3 -
 net/tipc/server.c                                  |   19 +-
 net/tipc/server.h                                  |    2 -
 net/tipc/socket.c                                  |   12 +-
 net/tipc/subscr.c                                  |   19 +-
 net/unix/af_unix.c                                 |    3 +-
 net/wireless/core.c                                |   19 +-
 net/wireless/core.h                                |    4 +-
 net/wireless/nl80211.c                             |   32 +-
 net/wireless/nl80211.h                             |    8 +-
 net/wireless/reg.c                                 |   12 +-
 net/wireless/scan.c                                |   40 +-
 net/wireless/sme.c                                 |    2 +-
 net/xfrm/xfrm_policy.c                             |    2 +-
 net/xfrm/xfrm_state.c                              |   23 +-
 net/xfrm/xfrm_user.c                               |    5 -
 scripts/Makefile.lib                               |    1 +
 scripts/checkpatch.pl                              |    4 +-
 scripts/gen_initramfs_list.sh                      |    2 +-
 scripts/get_maintainer.pl                          |    2 +-
 scripts/mod/file2alias.c                           |    4 +-
 scripts/mod/modpost.c                              |   13 +
 security/Kconfig                                   |    2 +-
 security/keys/keyring.c                            |    6 +-
 security/selinux/nlmsgtab.c                        |    2 +
 security/selinux/ss/policydb.c                     |    8 +-
 security/selinux/ss/services.c                     |    4 +
 sound/core/pcm_lib.c                               |    1 +
 sound/pci/hda/hda_codec.c                          |   34 +-
 sound/pci/hda/hda_generic.c                        |    8 +-
 sound/pci/hda/hda_generic.h                        |    1 +
 sound/pci/hda/hda_intel.c                          |    2 +-
 sound/pci/hda/patch_analog.c                       |   31 +
 sound/pci/hda/patch_ca0132.c                       |   68 +-
 sound/pci/hda/patch_conexant.c                     |    3 +-
 sound/pci/hda/patch_realtek.c                      |   92 +-
 sound/pci/hda/patch_sigmatel.c                     |   60 +-
 sound/pci/hda/thinkpad_helper.c                    |    1 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/Kconfig                            |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   13 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   20 +-
 sound/soc/blackfin/Kconfig                         |   20 +-
 sound/soc/cirrus/Kconfig                           |    4 +-
 sound/soc/cirrus/snappercl15.c                     |   18 +-
 sound/soc/codecs/88pm860x-codec.c                  |  120 +-
 sound/soc/codecs/Kconfig                           |  191 ++-
 sound/soc/codecs/Makefile                          |   33 +
 sound/soc/codecs/ad1836.c                          |    4 +-
 sound/soc/codecs/ad193x-i2c.c                      |   54 +
 sound/soc/codecs/ad193x-spi.c                      |   48 +
 sound/soc/codecs/ad193x.c                          |  154 +-
 sound/soc/codecs/ad193x.h                          |    7 +
 sound/soc/codecs/ad1980.c                          |    4 +-
 sound/soc/codecs/adau1373.c                        |   39 +-
 sound/soc/codecs/adau1977-i2c.c                    |   59 +
 sound/soc/codecs/adau1977-spi.c                    |   76 +
 sound/soc/codecs/adau1977.c                        | 1018 +++++++++++
 sound/soc/codecs/adau1977.h                        |   37 +
 sound/soc/codecs/adav801.c                         |   53 +
 sound/soc/codecs/adav803.c                         |   50 +
 sound/soc/codecs/adav80x.c                         |  159 +-
 sound/soc/codecs/adav80x.h                         |    7 +
 sound/soc/codecs/ak4104.c                          |    2 -
 sound/soc/codecs/ak4535.c                          |    9 -
 sound/soc/codecs/ak4641.c                          |   24 +-
 sound/soc/codecs/ak4642.c                          |    8 -
 sound/soc/codecs/ak4671.c                          |  250 ++-
 sound/soc/codecs/ak4671.h                          |    2 -
 sound/soc/codecs/alc5623.c                         |  120 +-
 sound/soc/codecs/alc5632.c                         |   48 +-
 sound/soc/codecs/arizona.c                         |  325 ++--
 sound/soc/codecs/cq93vc.c                          |    3 +-
 sound/soc/codecs/cs4270.c                          |    9 -
 sound/soc/codecs/cs4271.c                          |   63 +-
 sound/soc/codecs/cs42l51.c                         |   99 +-
 sound/soc/codecs/cs42l52.c                         |  109 +-
 sound/soc/codecs/cs42l73.c                         |   72 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |   64 +
 sound/soc/codecs/cs42xx8.c                         |  602 +++++++
 sound/soc/codecs/cs42xx8.h                         |  238 +++
 sound/soc/codecs/da7210.c                          |   28 +-
 sound/soc/codecs/da7213.c                          |  159 +-
 sound/soc/codecs/da732x.c                          |  208 ++-
 sound/soc/codecs/da732x.h                          |    3 -
 sound/soc/codecs/da9055.c                          |  111 +-
 sound/soc/codecs/isabelle.c                        |   71 +-
 sound/soc/codecs/lm4857.c                          |    3 +-
 sound/soc/codecs/lm49453.c                         |   47 +-
 sound/soc/codecs/max9768.c                         |    5 -
 sound/soc/codecs/max98088.c                        |   47 +-
 sound/soc/codecs/max98090.c                        |  202 +--
 sound/soc/codecs/max98090.h                        |    1 -
 sound/soc/codecs/max98095.c                        |   60 +-
 sound/soc/codecs/max9850.c                         |    8 -
 sound/soc/codecs/mc13783.c                         |   30 +-
 sound/soc/codecs/ml26124.c                         |   22 +-
 sound/soc/codecs/pcm1681.c                         |   15 +-
 sound/soc/codecs/pcm1792a.c                        |   33 +-
 sound/soc/codecs/pcm512x-i2c.c                     |   71 +
 sound/soc/codecs/pcm512x-spi.c                     |   69 +
 sound/soc/codecs/pcm512x.c                         |  589 +++++++
 sound/soc/codecs/pcm512x.h                         |  171 ++
 sound/soc/codecs/rt5631.c                          |   84 +-
 sound/soc/codecs/rt5640.c                          |   87 +-
 sound/soc/codecs/sgtl5000.c                        |   18 +-
 sound/soc/codecs/si476x.c                          |    6 +-
 sound/soc/codecs/sirf-audio-codec.c                |  524 ++++++
 sound/soc/codecs/sirf-audio-codec.h                |   75 +
 sound/soc/codecs/sn95031.c                         |   46 +-
 sound/soc/codecs/ssm2518.c                         |   24 +-
 sound/soc/codecs/ssm2602-i2c.c                     |   57 +
 sound/soc/codecs/ssm2602-spi.c                     |   41 +
 sound/soc/codecs/ssm2602.c                         |  180 +-
 sound/soc/codecs/ssm2602.h                         |   14 +
 sound/soc/codecs/sta32x.c                          |   90 +-
 sound/soc/codecs/sta529.c                          |   15 +-
 sound/soc/codecs/stac9766.c                        |   38 +-
 sound/soc/codecs/tlv320aic23-i2c.c                 |   59 +
 sound/soc/codecs/tlv320aic23-spi.c                 |   56 +
 sound/soc/codecs/tlv320aic23.c                     |   79 +-
 sound/soc/codecs/tlv320aic23.h                     |    6 +
 sound/soc/codecs/tlv320aic26.c                     |    7 +-
 sound/soc/codecs/tlv320aic31xx.c                   |   19 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    2 -
 sound/soc/codecs/tlv320aic3x.c                     |    6 -
 sound/soc/codecs/tlv320dac33.c                     |   35 +-
 sound/soc/codecs/twl4030.c                         |  101 +-
 sound/soc/codecs/twl6040.c                         |   17 +-
 sound/soc/codecs/uda134x.c                         |    3 +-
 sound/soc/codecs/uda1380.c                         |   43 +-
 sound/soc/codecs/wl1273.c                          |    9 +-
 sound/soc/codecs/wm2000.c                          |    2 -
 sound/soc/codecs/wm2200.c                          |   25 +-
 sound/soc/codecs/wm5100.c                          |   43 +-
 sound/soc/codecs/wm5102.c                          |   32 +-
 sound/soc/codecs/wm5110.c                          |   22 +-
 sound/soc/codecs/wm8350.c                          |    4 +-
 sound/soc/codecs/wm8400.c                          |   37 +-
 sound/soc/codecs/wm8510.c                          |   10 +-
 sound/soc/codecs/wm8523.c                          |   11 +-
 sound/soc/codecs/wm8580.c                          |    9 +-
 sound/soc/codecs/wm8711.c                          |    8 +-
 sound/soc/codecs/wm8728.c                          |   11 +-
 sound/soc/codecs/wm8731.c                          |   11 +-
 sound/soc/codecs/wm8737.c                          |   56 +-
 sound/soc/codecs/wm8741.c                          |   40 +-
 sound/soc/codecs/wm8750.c                          |    6 -
 sound/soc/codecs/wm8753.c                          |   12 +-
 sound/soc/codecs/wm8770.c                          |   10 +-
 sound/soc/codecs/wm8776.c                          |    6 -
 sound/soc/codecs/wm8804.c                          |   10 +-
 sound/soc/codecs/wm8900.c                          |   52 +-
 sound/soc/codecs/wm8903.c                          |  118 +-
 sound/soc/codecs/wm8904.c                          |   86 +-
 sound/soc/codecs/wm8940.c                          |   26 +-
 sound/soc/codecs/wm8955.c                          |   19 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   10 +-
 sound/soc/codecs/wm8960.c                          |    6 -
 sound/soc/codecs/wm8961.c                          |   23 +-
 sound/soc/codecs/wm8962.c                          |   87 +-
 sound/soc/codecs/wm8971.c                          |    6 -
 sound/soc/codecs/wm8974.c                          |   10 +-
 sound/soc/codecs/wm8978.c                          |   38 +-
 sound/soc/codecs/wm8983.c                          |   51 +-
 sound/soc/codecs/wm8985.c                          |   46 +-
 sound/soc/codecs/wm8988.c                          |   70 +-
 sound/soc/codecs/wm8990.c                          |   49 +-
 sound/soc/codecs/wm8991.c                          |   52 +-
 sound/soc/codecs/wm8993.c                          |   74 +-
 sound/soc/codecs/wm8994.c                          |  186 +-
 sound/soc/codecs/wm8995.c                          |   50 +-
 sound/soc/codecs/wm8996.c                          |   87 +-
 sound/soc/codecs/wm8997.c                          |   29 +-
 sound/soc/codecs/wm9081.c                          |   34 +-
 sound/soc/codecs/wm9090.c                          |   10 -
 sound/soc/codecs/wm9705.c                          |   12 +-
 sound/soc/codecs/wm_adsp.c                         |   50 +-
 sound/soc/codecs/wm_hubs.c                         |   16 +-
 sound/soc/davinci/davinci-evm.c                    |   81 +-
 sound/soc/davinci/davinci-mcasp.c                  |  294 ++--
 sound/soc/davinci/edma-pcm.c                       |   57 +
 sound/soc/davinci/edma-pcm.h                       |   25 +
 sound/soc/fsl/Kconfig                              |   12 +-
 sound/soc/fsl/eukrea-tlv320.c                      |  108 +-
 sound/soc/fsl/fsl_esai.c                           |   36 +-
 sound/soc/fsl/fsl_esai.h                           |    2 +-
 sound/soc/fsl/fsl_sai.c                            |  332 ++--
 sound/soc/fsl/fsl_sai.h                            |   48 +-
 sound/soc/fsl/fsl_spdif.c                          |    9 +-
 sound/soc/fsl/imx-mc13783.c                        |    1 -
 sound/soc/fsl/imx-pcm-fiq.c                        |    7 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   10 +-
 sound/soc/fsl/imx-wm8962.c                         |   11 +-
 sound/soc/fsl/wm1133-ev1.c                         |   11 +-
 sound/soc/generic/simple-card.c                    |  295 ++--
 sound/soc/intel/Kconfig                            |   42 +-
 sound/soc/intel/Makefile                           |   27 +-
 sound/soc/intel/byt-rt5640.c                       |  187 ++
 sound/soc/intel/haswell.c                          |  235 +++
 sound/soc/intel/mfld_machine.c                     |  108 +-
 sound/soc/intel/sst-acpi.c                         |  284 ++++
 sound/soc/intel/sst-baytrail-dsp.c                 |  372 ++++
 sound/soc/intel/sst-baytrail-ipc.c                 |  867 ++++++++++
 sound/soc/intel/sst-baytrail-ipc.h                 |   69 +
 sound/soc/intel/sst-baytrail-pcm.c                 |  422 +++++
 sound/soc/intel/sst-dsp-priv.h                     |  309 ++++
 sound/soc/intel/sst-dsp.c                          |  385 +++++
 sound/soc/intel/sst-dsp.h                          |  233 +++
 sound/soc/intel/sst-firmware.c                     |  587 +++++++
 sound/soc/intel/sst-haswell-dsp.c                  |  517 ++++++
 sound/soc/intel/sst-haswell-ipc.c                  | 1785 ++++++++++++++++=
++++
 sound/soc/intel/sst-haswell-ipc.h                  |  488 ++++++
 sound/soc/intel/sst-haswell-pcm.c                  |  872 ++++++++++
 sound/soc/intel/{sst_dsp.h =3D> sst-mfld-dsp.h}      |    8 +-
 .../intel/{sst_platform.c =3D> sst-mfld-platform.c}  |    8 +-
 .../intel/{sst_platform.h =3D> sst-mfld-platform.h}  |    4 +-
 sound/soc/kirkwood/Kconfig                         |   11 +-
 sound/soc/kirkwood/Makefile                        |    2 +
 sound/soc/kirkwood/armada-370-db.c                 |  148 ++
 sound/soc/kirkwood/kirkwood-i2s.c                  |    1 +
 sound/soc/omap/Kconfig                             |    4 +-
 sound/soc/omap/ams-delta.c                         |   55 +-
 sound/soc/omap/n810.c                              |   26 +-
 sound/soc/omap/omap-abe-twl6040.c                  |    3 +-
 sound/soc/omap/rx51.c                              |   22 +-
 sound/soc/pxa/corgi.c                              |   49 +-
 sound/soc/pxa/e740_wm9705.c                        |   10 +-
 sound/soc/pxa/e750_wm9705.c                        |   10 +-
 sound/soc/pxa/e800_wm9712.c                        |   19 +-
 sound/soc/pxa/magician.c                           |   60 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   19 +-
 sound/soc/pxa/poodle.c                             |    7 +-
 sound/soc/pxa/spitz.c                              |   58 +-
 sound/soc/pxa/tosa.c                               |   67 +-
 sound/soc/pxa/zylonite.c                           |   17 +-
 sound/soc/s6000/s6105-ipcam.c                      |   28 +-
 sound/soc/samsung/Kconfig                          |    8 +-
 sound/soc/samsung/h1940_uda1380.c                  |    7 +-
 sound/soc/samsung/neo1973_wm8753.c                 |  168 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    5 -
 sound/soc/samsung/smdk_wm8994.c                    |    2 +-
 sound/soc/samsung/tobermory.c                      |    2 +
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/migor.c                               |   19 +-
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/adg.c                            |  229 ++-
 sound/soc/sh/rcar/core.c                           |  426 +++--
 sound/soc/sh/rcar/gen.c                            |  113 +-
 sound/soc/sh/rcar/rsnd.h                           |  206 ++-
 sound/soc/sh/rcar/scu.c                            |  384 -----
 sound/soc/sh/rcar/src.c                            |  723 ++++++++
 sound/soc/sh/rcar/ssi.c                            |  388 ++---
 sound/soc/sirf/Kconfig                             |   14 +
 sound/soc/sirf/Makefile                            |    5 +
 sound/soc/sirf/sirf-audio-port.c                   |  194 +++
 sound/soc/sirf/sirf-audio-port.h                   |   62 +
 sound/soc/sirf/sirf-audio.c                        |  156 ++
 sound/soc/soc-cache.c                              |   13 +-
 sound/soc/soc-compress.c                           |   65 +-
 sound/soc/soc-core.c                               |  552 +++---
 sound/soc/soc-dapm.c                               |  604 +++----
 sound/soc/soc-io.c                                 |   99 +-
 sound/soc/soc-jack.c                               |    5 +-
 sound/soc/soc-pcm.c                                |  109 +-
 sound/soc/spear/spdif_out.c                        |   10 +-
 sound/soc/tegra/Kconfig                            |    2 +-
 sound/soc/tegra/tegra20_ac97.c                     |    2 +-
 sound/soc/tegra/tegra20_das.c                      |    2 +-
 sound/soc/tegra/tegra20_i2s.c                      |    2 +-
 sound/soc/tegra/tegra20_spdif.c                    |    2 +-
 sound/soc/tegra/tegra30_ahub.c                     |    4 +-
 sound/soc/tegra/tegra30_i2s.c                      |    2 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    8 +-
 sound/usb/Kconfig                                  |    1 +
 sound/usb/mixer.c                                  |    1 +
 sound/usb/mixer_maps.c                             |    9 +
 tools/lib/lockdep/Makefile                         |    6 +-
 tools/lib/lockdep/preload.c                        |    2 +-
 tools/lib/lockdep/run_tests.sh                     |    0
 tools/lib/lockdep/uinclude/asm/hash.h              |    6 +
 tools/lib/lockdep/uinclude/linux/rcu.h             |    5 +
 tools/net/Makefile                                 |    2 +-
 tools/perf/builtin-buildid-cache.c                 |   33 +-
 tools/perf/builtin-record.c                        |   10 +-
 tools/perf/builtin-report.c                        |   40 +-
 tools/perf/builtin-top.c                           |    6 +-
 tools/perf/builtin-trace.c                         |   32 +-
 tools/perf/config/Makefile                         |    2 +-
 tools/perf/config/feature-checks/Makefile          |    2 +-
 tools/perf/design.txt                              |    1 -
 tools/perf/perf.h                                  |    4 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   10 -
 tools/perf/util/annotate.c                         |    9 +-
 tools/perf/util/annotate.h                         |    2 +
 tools/perf/util/event.c                            |   36 +-
 tools/perf/util/event.h                            |    6 +-
 tools/perf/util/include/asm/hash.h                 |    6 +
 tools/perf/util/include/linux/bitops.h             |    4 +-
 tools/perf/util/machine.c                          |   44 +-
 tools/perf/util/machine.h                          |    2 +
 tools/perf/util/map.c                              |    5 +-
 tools/perf/util/map.h                              |    1 +
 tools/perf/util/parse-events.c                     |   17 +-
 tools/perf/util/probe-event.c                      |    2 +-
 tools/perf/util/session.c                          |    6 +
 tools/perf/util/symbol-elf.c                       |   10 +-
 tools/perf/util/symbol.c                           |   67 +-
 tools/testing/selftests/ipc/msgque.c               |    1 +
 virt/kvm/arm/vgic.c                                |    1 +
 virt/kvm/coalesced_mmio.c                          |    8 +-
 1779 files changed, 37413 insertions(+), 15444 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
lsi,zevio-intc.txt
 create mode 100644 Documentation/devicetree/bindings/net/opencores-ethoc.t=
xt
 create mode 100644 Documentation/devicetree/bindings/net/sti-dwmac.txt
 rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt =
=3D> brcm,bcm11351-pinctrl.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/power/bq2415x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/armada-370db-au=
dio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs42xx8.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
 create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv320.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm512x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-code=
c.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-port=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt
 create mode 100644 Documentation/devicetree/bindings/sound/widgets.txt
 delete mode 100644 Documentation/networking/3c505.txt
 create mode 100644 Documentation/spi/00-INDEX
 create mode 100644 Documentation/zh_CN/arm64/tagged-pointers.txt
 create mode 100644 arch/arm/boot/dts/at91-sama5d3_xplained.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts =3D> omap3-overo-tobi-common.dtsi=
} (94%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts
 delete mode 100644 arch/arm/boot/dts/testcases/tests.dtsi
 delete mode 100644 arch/m68k/include/asm/barrier.h
 create mode 100644 drivers/gpu/drm/nouveau/core/subdev/mc/nv4c.c
 create mode 100644 drivers/irqchip/irq-zevio.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
 delete mode 100644 drivers/net/irda/ep7211-sir.c
 delete mode 100644 drivers/net/usb/r815x.c
 create mode 100644 drivers/net/usb/sr9800.c
 create mode 100644 drivers/net/usb/sr9800.h
 create mode 100644 drivers/of/testcase-data/testcases.dtsi
 rename {arch/arm/boot/dts/testcases =3D> drivers/of/testcase-data}/tests-i=
nterrupts.dtsi (100%)
 create mode 100644 drivers/of/testcase-data/tests-match.dtsi
 rename {arch/arm/boot/dts/testcases =3D> drivers/of/testcase-data}/tests-p=
handle.dtsi (100%)
 delete mode 100644 drivers/xen/xencomm.c
 create mode 100644 include/linux/platform_data/adau1977.h
 create mode 100644 include/net/netfilter/nft_reject.h
 create mode 100644 include/trace/events/hswadsp.h
 create mode 100644 include/trace/events/intel-sst.h
 rename include/{ =3D> uapi}/xen/gntalloc.h (100%)
 rename include/{ =3D> uapi}/xen/gntdev.h (100%)
 delete mode 100644 include/xen/interface/xencomm.h
 delete mode 100644 include/xen/xencomm.h
 create mode 100644 net/ipv4/netfilter/nft_reject_ipv4.c
 create mode 100644 net/ipv6/netfilter/nft_reject_ipv6.c
 create mode 100644 net/netfilter/nft_reject_inet.c
 create mode 100644 sound/soc/codecs/ad193x-i2c.c
 create mode 100644 sound/soc/codecs/ad193x-spi.c
 create mode 100644 sound/soc/codecs/adau1977-i2c.c
 create mode 100644 sound/soc/codecs/adau1977-spi.c
 create mode 100644 sound/soc/codecs/adau1977.c
 create mode 100644 sound/soc/codecs/adau1977.h
 create mode 100644 sound/soc/codecs/adav801.c
 create mode 100644 sound/soc/codecs/adav803.c
 create mode 100644 sound/soc/codecs/cs42xx8-i2c.c
 create mode 100644 sound/soc/codecs/cs42xx8.c
 create mode 100644 sound/soc/codecs/cs42xx8.h
 create mode 100644 sound/soc/codecs/pcm512x-i2c.c
 create mode 100644 sound/soc/codecs/pcm512x-spi.c
 create mode 100644 sound/soc/codecs/pcm512x.c
 create mode 100644 sound/soc/codecs/pcm512x.h
 create mode 100644 sound/soc/codecs/sirf-audio-codec.c
 create mode 100644 sound/soc/codecs/sirf-audio-codec.h
 create mode 100644 sound/soc/codecs/ssm2602-i2c.c
 create mode 100644 sound/soc/codecs/ssm2602-spi.c
 create mode 100644 sound/soc/codecs/tlv320aic23-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic23-spi.c
 create mode 100644 sound/soc/davinci/edma-pcm.c
 create mode 100644 sound/soc/davinci/edma-pcm.h
 create mode 100644 sound/soc/intel/byt-rt5640.c
 create mode 100644 sound/soc/intel/haswell.c
 create mode 100644 sound/soc/intel/sst-acpi.c
 create mode 100644 sound/soc/intel/sst-baytrail-dsp.c
 create mode 100644 sound/soc/intel/sst-baytrail-ipc.c
 create mode 100644 sound/soc/intel/sst-baytrail-ipc.h
 create mode 100644 sound/soc/intel/sst-baytrail-pcm.c
 create mode 100644 sound/soc/intel/sst-dsp-priv.h
 create mode 100644 sound/soc/intel/sst-dsp.c
 create mode 100644 sound/soc/intel/sst-dsp.h
 create mode 100644 sound/soc/intel/sst-firmware.c
 create mode 100644 sound/soc/intel/sst-haswell-dsp.c
 create mode 100644 sound/soc/intel/sst-haswell-ipc.c
 create mode 100644 sound/soc/intel/sst-haswell-ipc.h
 create mode 100644 sound/soc/intel/sst-haswell-pcm.c
 rename sound/soc/intel/{sst_dsp.h =3D> sst-mfld-dsp.h} (96%)
 rename sound/soc/intel/{sst_platform.c =3D> sst-mfld-platform.c} (99%)
 rename sound/soc/intel/{sst_platform.h =3D> sst-mfld-platform.h} (97%)
 create mode 100644 sound/soc/kirkwood/armada-370-db.c
 delete mode 100644 sound/soc/sh/rcar/scu.c
 create mode 100644 sound/soc/sh/rcar/src.c
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio-port.c
 create mode 100644 sound/soc/sirf/sirf-audio-port.h
 create mode 100644 sound/soc/sirf/sirf-audio.c
 mode change 100644 =3D> 100755 tools/lib/lockdep/run_tests.sh
 create mode 100644 tools/lib/lockdep/uinclude/asm/hash.h
 create mode 100644 tools/perf/util/include/asm/hash.h

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTLxKpAAoJELSic+t+oim9Le4P91aFJ1VOpbTcu2tLGH9ddvl2
6xNqFOy+0NNQJ6+KF118NJyX/i4SLQT5lta1+5ixgrug/8FkJ1e5A/cjBT9/QPT5
bA/iNOoVN0K21H8r1ZBKTjjcj/0UbFdQMh4Sz0oX6oo2eIR/qQYsZskghi96ayzA
7w+3JE/1vC7TpqEvZwbol35mLeK7Tg8L4ecfrLEDj8wF9vsj6atqpWhJnxknMLzD
kO7S5WAmCtsaqBHbJA0p2WRkKaoRXOZOA6+AwbVu/S5TejAzkDsnc82o5QjBDLfK
oVZEFHK3y+51SBZU+DVxmVO/isWX4LxO0uEtaN8SIzors8mstxIh/7fkMws4adSY
7Hjd4zePYynYzTueu6aJpEwR+985iHPxJ57/JEZjktVLFAQVzpkq/JIwHMQ4tFHv
AG/xsizwzsr+J2KogTzYbr05JbctP9E5n4OA1PPnISW5bM/Cf69Ug8cTqO06jvaK
aPid8zs/YoU199wXduIvk3g7FPIe1Wdxx/rJ4bsun9NZRxV9zNK94sSy05m6nBzs
cCmUdz18dC8obsbIsKC78W0eVRW6D8TurA5MAYqSxnjL/BDL2C3kIBHPBhqOYqMG
NXoUaIA13qeDPXK9zjtp9V9WYPGjy9b8sa8xaECzbTD8bPRwcMV+Q62RMTM9X9OX
Py9ypMgJbu6VZU4nXlg=
=thZi
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

--===============0657591668716120495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0657591668716120495==--
