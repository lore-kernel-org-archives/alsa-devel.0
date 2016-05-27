From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.7
Date: Fri, 27 May 2016 14:02:14 +0100
Message-ID: <20160527130214.GK16172@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1178667463656603755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A33C266ACC
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 15:02:23 +0200 (CEST)
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


--===============1178667463656603755==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 515511a7920c69aebf7f5fef0cb8e1df6767f34c:

  Merge remote-tracking branch 'asoc/topic/hdmi' into asoc-next (2016-05-13=
 14:27:16 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.7-2

for you to fetch changes up to bf65921380cd50b87618df550398e06581f4a361:

  Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next (2016-05-=
27 13:46:02 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.7 part 2

Really sorry about this late pull request.  It looks like at the time I
sent my pull request for v4.7 there was some conflict or other issue
which caused my script to stop merging the ASoC branches at some point
after the HDMI changes.

It's all specific driver updates, including:

 - New drivers for MAX98371 and TAS5720.
 - SPI support for TLV320AIC32x4.
 - TDM support for STI Uniperf IPs.

This code should all have been in -next prior to the merge window apart
=66rom some fixes, it dropped out on the 18th.

----------------------------------------------------------------
Akinobu Mita (1):
      spi: omap2-mcspi: Undo broken fix for dma transfer of vmalloced buffer

Al Viro (6):
      do_splice_to(): cap the size before passing to ->splice_read()
      fix the copy vs. map logics in blk_rq_map_user_iov()
      atomic_open(): fix the handling of create_error
      ecryptfs: fix handling of directory opening
      get_rock_ridge_filename(): handle malformed NM entries
      Merge branch 'ovl-fixes' into for-linus

Alex Deucher (2):
      drm/radeon: fix DP mode validation
      drm/amdgpu: fix DP mode validation

Alexander Shishkin (2):
      perf/x86/intel/pt: Generate PMI in the STOP region as well
      perf/core: Disable the event on a truncated AUX record

Andrea Adami (1):
      ASoC: pxa: Fix module autoload for platform drivers

Andrea Arcangeli (1):
      mm: thp: calculate the mapcount correctly for THP pages during WP fau=
lts

Andreas Dannenberg (2):
      ASoC: add TA5720 digital amplifier DT bindings
      ASoC: add support for TAS5720 digital amplifier

Andrey Ryabinin (1):
      perf/x86: Fix undefined shift on 32-bit kernels

Andrey Utkin (1):
      kvmconfig: add more virtio drivers

Andrey Vostrikov (1):
      spi: spi-fsl-dspi: Fix cs_change handling in message transfer

Andy Lutomirski (1):
      perf/core: Change the default paranoia level to 2

Arindam Nath (1):
      drm/radeon: fix DP link training issue with second 4K monitor

Arnaldo Carvalho de Melo (9):
      perf tools: Use readdir() instead of deprecated readdir_r()
      perf script: Use readdir() instead of deprecated readdir_r()
      perf thread_map: Use readdir() instead of deprecated readdir_r()
      perf tools: Use readdir() instead of deprecated readdir_r()
      perf dwarf: Guard !x86_64 definitions under #ifdef else clause
      perf probe: Check if dwarf_getlocations() is available
      perf evsel: Improve EPERM error handling in open_strerror()
      perf evsel: Handle EACCESS + perf_event_paranoid=3D2 in fallback()
      perf stat: Fallback to user only counters when perf_event_paranoid > 1

Arnd Bergmann (6):
      regmap: fix documentation to match code
      Revert "net/mlx5: Kconfig: Fix MLX5_EN/VXLAN build issue"
      net/mlx5e: make VXLAN support conditional
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 =
into fixes
      Merge tag 'at91-fixes2' of git://git.kernel.org/.../nferre/linux-at91=
 into fixes
      net: mvneta: bm: fix dependencies again

Axel Lin (2):
      ASoC: rt5677: Avoid duplicate the same test in each switch case
      ASoC: max98371 Remove duplicate entry in max98371_reg

Bard Liao (2):
      ASoC: rt298: reset AD dilter is there is no MCLK
      ASoC: rt298: fix capture doesn't work at some cases

Bastien Nocera (1):
      ASoC: tlv320aix31xx: Add ACPI match for Lenovo 100S

Ben Hutchings (2):
      spi: spi-ti-qspi: Fix FLEN and WLEN settings if bits_per_word is over=
ridden
      spi: spi-ti-qspi: Handle truncated frames properly

Boris Brezillon (1):
      ARM: dts: at91: sam9x5: Fix the memory range assigned to the PMC

Chris Diamand (1):
      Input: byd - update copyright header

Colin Ian King (1):
      tools: bpf_jit_disasm: check for klogctl failure

Dan Carpenter (6):
      scsi_dh_alua: uninitialized variable in alua_rtpg()
      netxen: fix error handling in netxen_get_flash_block()
      netxen: reversed condition in netxen_nic_set_link_parameters()
      netxen: netxen_rom_fast_read() doesn't return -1
      qede: uninitialized variable in qede_start_xmit()
      qlcnic: potential NULL dereference in qlcnic_83xx_get_minidump_templa=
te()

Dan Williams (1):
      libnvdimm, pfn: fix ARCH=3Dalpha allmodconfig build failure

Daniel Jurgens (1):
      net/mlx4_en: Fix endianness bug in IPV6 csum calculation

Daniel Vetter (1):
      drm/i915: Bail out of pipe config compute loop on LPT

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2016-05-11' of git://anongit.freedesktop.o=
rg/drm-intel into drm-fixes
      Merge branch 'drm-fixes-4.6' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      Merge branch 'drm-fixes-4.6' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes

David Ahern (1):
      net: ipv6: tcp reset, icmp need to consider L3 domain

David Howells (1):
      KEYS: Fix ASN.1 indefinite length object parsing

David S. Miller (9):
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'bnxt_en-fixes'
      Merge branch 'mlx5-build-fix'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'wireless-drivers-for-davem-2016-05-09' of git://git.kernel=
=2Eorg/.../kvalo/wireless-drivers
      Merge branch 'nps_enet-fixes'
      Merge branch 'net-sched-fixes'
      Merge branch 'bnxt_en-fixes'
      Merge branch 'xgene-fixes'

Dmitry V. Levin (1):
      x86: Use compat version for preadv2 and pwritev2

Elad Kanfi (2):
      net: nps_enet: Tx handler synchronization
      net: nps_enet: bug fix - handle lost tx interrupts

Emmanuel Grumbach (1):
      iwlwifi: mvm: don't override the rate with the AMSDU len

Eric Dumazet (2):
      macvtap: segmented packet is consumed
      tcp: refresh skb timestamp at retransmit time

Fabio Estevam (6):
      ASoC: wm8960: Provide a menu selection text
      ASoC: wm8962: Disable clock if wm8962_runtime_resume() fails
      ASoC: wm8962: Fit error message into a single line
      ASoC: wm8962: Adjust clk definitions so that simple card can work
      ASoC: hdac_hdmi: Remove the unused 'timeout' variable
      spi: spi-ep93xx: Fix the PTR_ERR() argument

Felipe Balbi (1):
      cgroup: fix compile warning

Florian Westphal (1):
      netfilter: conntrack: init all_locks to avoid debug warning

Geert Uytterhoeven (2):
      ravb: Add missing free_irq() call to ravb_close()
      regulator: da9063: Correct module alias prefix to fix module autoload=
ing

Guneshwor Singh (1):
      ASoC: topology: Set CPU DAI name and enable DPCM by default for FE li=
nk

H. Nikolaus Schaller (1):
      Input: twl6040-vibra - fix DT node memory management

Hans de Goede (2):
      regulator: axp20x: Fix axp22x ldo_io voltage ranges
      regulator: axp20x: Fix axp22x ldo_io registration error on cold boot

Herbert Xu (2):
      crypto: hash - Fix page length clamping in hash walk
      crypto: testmgr - Use kmalloc memory for RSA input

Ian Campbell (1):
      VSOCK: do not disconnect socket when peer has shutdown SEND only

Ido Schimmel (2):
      mlxsw: spectrum: Fix rollback order in LAG join failure
      mlxsw: spectrum: Add missing rollback in flood configuration

Imre Deak (1):
      drm/i915/bdw: Add missing delay during L3 SQC credit programming

Ingo Molnar (3):
      MAINTAINERS: Add mmiotrace entry
      Revert "sched/fair: Fix fairness issue on migration"
      Merge tag 'perf-urgent-for-mingo-20160512' of git://git.kernel.org/..=
=2E/acme/linux into perf/urgent

Iyappan Subramanian (5):
      drivers: net: xgene: fix IPv4 forward crash
      drivers: net: xgene: fix sharing of irqs
      drivers: net: xgene: fix ununiform latency across queues
      drivers: net: xgene: fix statistics counters race condition
      drivers: net: xgene: fix register offset

Jack Pham (1):
      regmap: spmi: Fix regmap_spmi_ext_read in multi-byte case

Jamal Hadi Salim (7):
      export tc ife uapi header
      net sched: vlan action fix late binding
      net sched: ipt action fix late binding
      net sched: mirred action fix late binding
      net sched: simple action fix late binding
      net sched: skbedit action fix late binding
      net sched: ife action fix late binding

Jani Nikula (1):
      drm/i915/lvds: separate border enable readout from panel fitter

Jarkko Nikula (1):
      spi: pxa2xx: Do not detect number of enabled chip selects on Intel SPT

Jarno Rajahalme (2):
      udp_tunnel: Remove redundant udp_tunnel_gro_complete().
      udp_offload: Set encapsulation before inner completes.

Jeeja KP (1):
      ASoC: topology: Fix memory leak in widget creation

Jeremy McDermond (7):
      ASoC: tlv320aic32x4: Change name of probe function
      ASoC: tlv320aic32x4: Break out I2C support into separate module
      ASoC: tlv320aic32x4: Add SPI support
      ASoC: tlv320aic32x4: Add 96k sample rate
      ASoC: tlv320aic32x4: Implement resistors on input pins
      ASoC: tlv320aic32x4: Add additional input pins
      ASoC: tlv320aic32x4: Properly implement the positive and negative pin=
s into the mixers

Jim Lodes (1):
      ASoC: omap-pcm: Initialize DMA configuration

Jiri Benc (1):
      gre: do not keep the GRE header around in collect medata mode

Joe Stringer (1):
      openvswitch: Fix cached ct with helper.

Johannes Thumshirn (1):
      qla1280: Don't allocate 512kb of host tags

Josh Poimboeuf (2):
      compiler-gcc: require gcc 4.8 for powerpc __builtin_bswap16()
      x86/kvm: Add stack frame dependency to fastop() inline asm

Junxiao Bi (2):
      ocfs2: revert using ocfs2_acl_chmod to avoid inode cluster lock hang
      ocfs2: fix posix_acl_create deadlock

Kaho Ng (1):
      ALSA: hda - Fix white noise on Asus UX501VW headset

Kalle Valo (1):
      Merge tag 'iwlwifi-for-kalle-2016-05-04' of https://git.kernel.org/..=
=2E/iwlwifi/iwlwifi-fixes

Kangjie Lu (3):
      net: fix infoleak in llc
      net: fix infoleak in rtnetlink
      net: fix a kernel infoleak in x25 module

Koro Chen (1):
      ASoC: mediatek: Add HDMI dai-links in the mt8173-rt5650-rt5676 machin=
e driver

Krzysztof Kozlowski (1):
      regulator: s2mps11: Fix invalid selector mask and voltages for buck9

Kuninori Morimoto (3):
      ASoC: tidyup alphabetical order for SND_SOC_Bxx
      ASoC: rsnd: count .probe/.remove for rsnd_mod_call()
      ASoC: rsnd: don't use prohibited number to PDMACHCRn.SRS

Linus L=FCssing (1):
      bridge: fix igmp / mld query parsing

Linus Torvalds (31):
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      Merge branch 'akpm' (patches from Andrew)
      Merge branch 'libnvdimm-fixes' of git://git.kernel.org/.../nvdimm/nvd=
imm
      Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/.../tip=
/tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge tag 'pci-v4.6-fixes-3' of git://git.kernel.org/.../helgaas/pci
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'spi-fix-v4.6-rc7' of git://git.kernel.org/.../broonie/spi
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'pinctrl-v4.6-4' of git://git.kernel.org/.../linusw/linux-p=
inctrl
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge tag 'sound-4.6' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'keys-fixes-20160512' of git://git.kernel.org/.../dhowells/=
linux-fs
      Merge branch 'akpm' (patches from Andrew)
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'media/v4.6-6' of git://git.kernel.org/.../mchehab/linux-me=
dia
      Merge tag 'regmap-fix-v4.6-rc7' of git://git.kernel.org/.../broonie/r=
egmap
      Merge tag 'regulator-fix-v4.6-rc7' of git://git.kernel.org/.../brooni=
e/regulator
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/.../tip=
/tip
      Merge branch 'for-4.6-fixes' of git://git.kernel.org/.../tj/wq
      Merge branch 'for-4.6-fixes' of git://git.kernel.org/.../tj/cgroup
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      nf_conntrack: avoid kernel pointer value leak in slab name
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Linux 4.6

Liping Zhang (1):
      netfilter: IDLETIMER: fix race condition when destroy the target

Lucas Stach (1):
      drm/radeon: fix PLL sharing on DCE6.1 (v2)

Ludovic Desroches (1):
      pinctrl: at91-pio4: fix pull-up/down logic

Lukas Wunner (2):
      PCI: Fix BUG on device attach failure
      PCI: Do not treat EPROBE_DEFER as device attach failure

Lyude (1):
      Revert "drm/i915: start adding dp mst audio"

Marek Szyprowski (1):
      Input: max8997-haptic - fix NULL pointer dereference

Mark Brown (31):
      regmap: mmio: Fix value endianness selection
      regmap: Fix implicit inclusion of device.h
      regmap: mmio: Parse endianness definitions from DT
      ASoC: wm8960: Depends on I2C
      regmap: mmio: Explicitly say little endian is the defualt in the bus =
config
      Merge branches 'topic/dai-link' and 'topic/find-dai' of git://git.ker=
nel.org/.../broonie/sound into asoc-topology
      Merge remote-tracking branches 'spi/fix/fsl-dspi', 'spi/fix/omap2-mcs=
pi', 'spi/fix/pxa2xx' and 'spi/fix/ti-qspi' into spi-linus
      Merge remote-tracking branch 'regmap/fix/mmio' into regmap-linus
      Merge remote-tracking branches 'regmap/fix/be', 'regmap/fix/doc' and =
'regmap/fix/spmi' into regmap-linus
      Merge remote-tracking branches 'regulator/fix/axp20x', 'regulator/fix=
/da9063', 'regulator/fix/gpio' and 'regulator/fix/s2mps11' into regulator-l=
inus
      ASoC: ak4642: Enable cache usage to fix crashes on resume
      Merge tag 'asoc-v4.7' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ak4642', 'asoc/fix/ep93xx', =
'asoc/fix/kirkwood' and 'asoc/fix/twl6040' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/tlv320aic32x4' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98371' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl6040' into asoc-next
      Merge remote-tracking branch 'asoc/topic/simple' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branch 'asoc/topic/topology' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tas5270' into asoc-next
      Merge remote-tracking branch 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/mtk' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt298' into asoc-next
      Merge remote-tracking branch 'asoc/topic/kconfig' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320aic31xx' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sti' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8960' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next

Mathias Krause (1):
      x86/extable: ensure entries are swapped completely when sorting

Matthias Brugger (1):
      drivers: net: xgene: Fix error handling

Mauro Carvalho Chehab (1):
      Revert "[media] videobuf2-v4l2: Verify planes array in buffer dequeue=
ing"

Maxime Ripard (1):
      regulator: axp20x: Fix LDO4 linear voltage range

Mengdong Lin (4):
      ASoC: topology: ABI - Define types for vendor tuples
      ASoC: topology: Set the link ID when creating a FE DAI link
      ASoC: topology: Check failure to create a widget
      ASoC: topology: Check size mismatch of ABI objects before parsing

Michael Chan (4):
      bnxt_en: Need memory barrier when processing the completion ring.
      bnxt_en: Setup multicast properly after resetting device.
      bnxt_en: Add workaround to detect bad opaque in rx completion (part 1)
      bnxt_en: Add workaround to detect bad opaque in rx completion (part 2)

Mihai Mihalache (1):
      regulator: gpio: check return value of of_get_named_gpio

Mikko Rapeli (1):
      uapi glibc compat: fix compile errors when glibc net/if.h included be=
fore linux/if.h

Miklos Szeredi (4):
      vfs: add vfs_select_inode() helper
      vfs: rename: check backing inode being equal
      vfs: add lookup_hash() helper
      ovl: ignore permissions on underlying lookup

Moise Gergaud (10):
      ASoC: sti: correct typo errors
      ASoC: sti: macro for uniperif tdm regs access
      ASoC: sti: rename unip player type into common player & reader type
      ASoC: sti: define tdm type & default tdm hw config
      ASoC: sti: helper functions for unip tdm slots configuration
      ASoC: sti: helper functions to fix tdm runtime params
      ASoC: sti: unip player tdm mode
      ASoC: sti: unip reader tdm mode
      ASoC: sti: select player for I2S/TDM TX bus
      ASoC: sti-asoc-card: update tdm mode

Namhyung Kim (1):
      perf diff: Fix duplicated output column

Nikolay Aleksandrov (1):
      net: bridge: fix old ioctl unlocked net device walk

PC Liao (2):
      ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver
      ASoC: mediatek: HDMI audio LR channel swapped

Paolo Abeni (1):
      net/route: enforce hoplimit max value

Paul Durrant (1):
      xen-netback: fix extra_info handling in xenvif_tx_err()

Peter Ujfalusi (4):
      ASoC: omap-mcbsp: Enable/disable sidetone block auto clock gating for=
 omap3
      ASoC: simple-card: Add pm callbacks to platform driver
      ASoC: twl6040: Select LPPLL during standby
      ASoC: twl6040: Disconnect AUX output pads on digital mute

Peter Zijlstra (1):
      perf/x86/msr: Fix SMI overflow

Petr Kulhavy (5):
      ASoC: tas571x: implemented digital mute
      ASoC: tas571x: chip type detection via I2C name
      ASoC: tas571x: added missing register literals
      ASoC: tas571x: added support for TAS5721
      ASoC: tas571x: new chip added into TAS571x binding

Phil Turnbull (1):
      netfilter: nfnetlink_acct: validate NFACCT_QUOTA parameter

Rafael J. Wysocki (1):
      sched/fair: Fix !CONFIG_SMP kernel cpufreq governor breakage

Robin Humble (1):
      Revert "proc/base: make prompt shell start from new line after execut=
ing "cat /proc/$pid/wchan""

Sabrina Dubroca (1):
      macsec: key identifier is 128 bits, not 64

Serge E. Hallyn (2):
      cgroup, kernfs: make mountinfo show properly scoped path for cgroup n=
amespaces
      kernfs: kernfs_sop_show_path: don't return 0 after seq_dentry call

Serge Hallyn (1):
      kernfs_path_from_node_locked: don't overwrite nlen

Sergei Shtylyov (1):
      rcar: src: skip disabled-SRC nodes

Sergey Senozhatsky (1):
      zsmalloc: fix zs_can_compact() integer overflow

Shaohui Xie (1):
      net: phylib: fix interrupts re-enablement in phy_start

Shmulik Ladkani (1):
      Documentation/networking: more accurate LCO explanation

Srinivas Kandagatla (2):
      ASoC: qcom: Fix uninitialized symbol warning.
      ASoC: qcom: remove IS_ERR_VALUE usage on int.

Steffen Klassert (3):
      flowcache: Avoid OOM condition under preasure
      xfrm: Reset encapsulation field of the skb before transformation
      vti: Add pmtu handling to vti_xmit.

Stephen Boyd (1):
      ASoC: rsnd: Remove CLK_IS_ROOT

Steven Rostedt (1):
      tools lib traceevent: Do not reassign parg after collapse_tree()

Sudarsana Reddy Kalluru (1):
      qede: prevent chip hang when increasing channels

Sudip Mukherjee (1):
      ASoC: kirkwood: fix build failure

Suzuki K Poulose (1):
      arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip

Tadeusz Struk (3):
      crypto: qat - fix invalid pf2vf_resp_wq logic
      crypto: qat - fix adf_ctl_drv.c:undefined reference to adf_init_pf_wq
      crypto: rsa - select crypto mgr dependency

Takashi Iwai (4):
      ALSA: usb-audio: Quirk for yet another Phoenix Audio devices (v2)
      ALSA: hda - Fix broken reconfig
      ALSA: hda - Fix regression on ATI HDMI audio
      ALSA: usb-audio: Yet another Phoneix Audio device quirk

Thomas Gleixner (2):
      x86/topology: Handle CPUID bogosity gracefully
      x86/topology: Set x86_max_cores to 1 for CONFIG_SMP=3Dn

Uwe Kleine-K=F6nig (1):
      net: fec: only clear a queue's work bit if the queue was emptied

Ville Syrj=E4l=E4 (1):
      drm/i915: Update CDCLK_FREQ register on BDW after changing cdclk freq=
uency

Wanpeng Li (1):
      workqueue: fix rebind bound workers warning

Wenyou Yang (1):
      ARM: dts: at91: sama5d2: use "atmel,sama5d3-nfc" compatible for nfc

Xunlei Pang (1):
      sched/rt, sched/dl: Don't push if task's scheduling class was changed

Yura Pakhuchiy (1):
      ALSA: hda - Fix subwoofer pin on ASUS N751 and N551

Zhou Chengming (1):
      ksm: fix conflict between mmput and scan_get_next_rmap_item

Zi Shen Lim (1):
      arm64: bpf: jit JMP_JSET_{X,K}

anish kumar (1):
      ASoC: Add max98371 codec driver

hchrzani (1):
      perf/x86/intel/uncore: Fix CHA registers configuration procedure for =
Knights Landing platform

xypron.glpk@gmx.de (1):
      net: thunderx: avoid exposing kernel stack

 .../devicetree/bindings/regmap/regmap.txt          |  59 +-
 .../devicetree/bindings/sound/max98371.txt         |  17 +
 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |  10 +
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  48 +-
 .../devicetree/bindings/sound/tas571x.txt          |  10 +-
 .../devicetree/bindings/sound/tas5720.txt          |  25 +
 Documentation/networking/checksum-offloads.txt     |  14 +-
 Documentation/sysctl/kernel.txt                    |   2 +-
 MAINTAINERS                                        |  14 +
 Makefile                                           |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/net/bpf_jit_comp.c                      |   1 +
 arch/x86/configs/kvm_guest.config                  |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   4 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/pt.c                         |   2 +
 arch/x86/events/intel/uncore_snbep.c               |   7 +
 arch/x86/events/msr.c                              |   2 +-
 arch/x86/include/asm/uaccess.h                     |   8 +
 arch/x86/kernel/cpu/intel.c                        |   2 +-
 arch/x86/kernel/smpboot.c                          |   5 +
 arch/x86/kvm/emulate.c                             |   6 +-
 block/blk-map.c                                    |  47 +-
 crypto/Kconfig                                     |   1 +
 crypto/ahash.c                                     |   3 +-
 crypto/testmgr.c                                   |  27 +-
 drivers/base/regmap/internal.h                     |   1 +
 drivers/base/regmap/regmap-mmio.c                  |   5 +-
 drivers/base/regmap/regmap-spmi.c                  |   2 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h     |  11 +
 drivers/crypto/qat/qat_common/adf_ctl_drv.c        |   6 +
 drivers/crypto/qat/qat_common/adf_sriov.c          |  26 +-
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   4 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  16 -
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +
 drivers/gpu/drm/i915/intel_audio.c                 |   9 +-
 drivers/gpu/drm/i915/intel_crt.c                   |   8 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  24 +-
 drivers/gpu/drm/i915/intel_display.c               |   5 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                |  22 -
 drivers/gpu/drm/i915/intel_drv.h                   |   2 -
 drivers/gpu/drm/i915/intel_lvds.c                  |   4 +
 drivers/gpu/drm/i915/intel_pm.c                    |   6 +
 drivers/gpu/drm/radeon/atombios_crtc.c             |  10 +
 drivers/gpu/drm/radeon/atombios_dp.c               |   4 +-
 drivers/gpu/drm/radeon/radeon_dp_auxch.c           |   2 +-
 drivers/input/misc/max8997_haptic.c                |   6 +-
 drivers/input/misc/twl6040-vibra.c                 |   1 +
 drivers/input/mouse/byd.c                          |   4 +
 drivers/media/v4l2-core/videobuf2-v4l2.c           |   6 -
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c    |  11 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.h    |   2 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  19 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |   8 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  82 ++-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  18 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.h  |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  86 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   4 +
 drivers/net/ethernet/ezchip/nps_enet.c             |  30 +-
 drivers/net/ethernet/ezchip/nps_enet.h             |   2 -
 drivers/net/ethernet/freescale/fec_main.c          |  10 +-
 drivers/net/ethernet/marvell/Kconfig               |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/vxlan.h    |  11 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   8 +
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c |  14 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   3 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_minidump.c   |   8 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +
 drivers/net/geneve.c                               |   5 +-
 drivers/net/macsec.c                               |  19 +-
 drivers/net/macvtap.c                              |   2 +-
 drivers/net/phy/phy.c                              |   8 +-
 drivers/net/vxlan.c                                |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  83 +--
 drivers/net/xen-netback/netback.c                  |   1 +
 drivers/nvdimm/pmem.c                              |   4 +-
 drivers/pci/bus.c                                  |   6 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
 drivers/regulator/axp20x-regulator.c               |  12 +-
 drivers/regulator/da9063-regulator.c               |   2 +-
 drivers/regulator/gpio-regulator.c                 |   2 +
 drivers/regulator/s2mps11.c                        |  28 +-
 drivers/scsi/device_handler/scsi_dh_alua.c         |   1 +
 drivers/scsi/qla1280.c                             |   2 +-
 drivers/spi/spi-ep93xx.c                           |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |   4 +-
 drivers/spi/spi-omap2-mcspi.c                      |  62 ++-
 drivers/spi/spi-pxa2xx.c                           |   2 +-
 drivers/spi/spi-ti-qspi.c                          |  45 +-
 fs/ecryptfs/file.c                                 |  71 ++-
 fs/isofs/rock.c                                    |  13 +-
 fs/kernfs/dir.c                                    |   6 +-
 fs/kernfs/mount.c                                  |  15 +
 fs/namei.c                                         |  59 +-
 fs/ocfs2/acl.c                                     |  87 +++
 fs/ocfs2/acl.h                                     |   5 +
 fs/ocfs2/file.c                                    |   4 +-
 fs/ocfs2/namei.c                                   |  23 +-
 fs/ocfs2/refcounttree.c                            |  17 +-
 fs/ocfs2/xattr.c                                   |  14 +-
 fs/ocfs2/xattr.h                                   |   4 +-
 fs/open.c                                          |  12 +-
 fs/overlayfs/super.c                               |   4 +-
 fs/proc/base.c                                     |   2 +-
 fs/splice.c                                        |   3 +
 include/linux/compiler-gcc.h                       |   2 +-
 include/linux/dcache.h                             |  12 +
 include/linux/kernfs.h                             |   2 +
 include/linux/mfd/samsung/s2mps11.h                |   2 +
 include/linux/mfd/twl6040.h                        |   1 +
 include/linux/mm.h                                 |   9 +
 include/linux/namei.h                              |   2 +
 include/linux/netdevice.h                          |   3 +
 include/linux/swap.h                               |   6 +-
 include/linux/uio.h                                |   1 +
 include/net/netns/xfrm.h                           |   1 +
 include/net/udp_tunnel.h                           |   9 -
 include/uapi/linux/if.h                            |  28 +
 include/uapi/linux/if_macsec.h                     |   4 +-
 include/uapi/linux/libc-compat.h                   |  44 ++
 include/uapi/linux/tc_act/Kbuild                   |   1 +
 include/uapi/sound/asoc.h                          |  44 +-
 kernel/cgroup.c                                    |  63 +++
 kernel/events/core.c                               |   2 +-
 kernel/events/ring_buffer.c                        |  10 +-
 kernel/sched/deadline.c                            |   1 +
 kernel/sched/fair.c                                |  29 +-
 kernel/sched/rt.c                                  |   1 +
 kernel/workqueue.c                                 |  11 +
 lib/asn1_decoder.c                                 |  16 +-
 lib/iov_iter.c                                     |  19 +
 mm/huge_memory.c                                   |  71 ++-
 mm/ksm.c                                           |  15 +-
 mm/memory.c                                        |  22 +-
 mm/swapfile.c                                      |  13 +-
 mm/zsmalloc.c                                      |   7 +-
 net/bridge/br_ioctl.c                              |   5 +-
 net/bridge/br_multicast.c                          |  12 +-
 net/core/flow.c                                    |  14 +-
 net/core/rtnetlink.c                               |  18 +-
 net/ipv4/fib_semantics.c                           |   2 +
 net/ipv4/fou.c                                     |   6 +-
 net/ipv4/ip_gre.c                                  |   7 +-
 net/ipv4/ip_vti.c                                  |  18 +
 net/ipv4/tcp_output.c                              |   6 +-
 net/ipv4/udp_offload.c                             |   8 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/route.c                                   |   2 +
 net/ipv6/tcp_ipv6.c                                |   7 +-
 net/llc/af_llc.c                                   |   1 +
 net/netfilter/nf_conntrack_core.c                  |   6 +-
 net/netfilter/nfnetlink_acct.c                     |   2 +
 net/netfilter/xt_IDLETIMER.c                       |   1 +
 net/openvswitch/conntrack.c                        |  13 +
 net/sched/act_ife.c                                |  14 +-
 net/sched/act_ipt.c                                |  19 +-
 net/sched/act_mirred.c                             |  19 +-
 net/sched/act_simple.c                             |  18 +-
 net/sched/act_skbedit.c                            |  18 +-
 net/sched/act_vlan.c                               |  22 +-
 net/vmw_vsock/af_vsock.c                           |  21 +-
 net/x25/x25_facilities.c                           |   1 +
 net/xfrm/xfrm_output.c                             |   3 +
 sound/pci/hda/hda_sysfs.c                          |   8 -
 sound/pci/hda/patch_hdmi.c                         |   7 +-
 sound/pci/hda/patch_realtek.c                      |  13 +
 sound/soc/codecs/Kconfig                           |  38 +-
 sound/soc/codecs/Makefile                          |  11 +-
 sound/soc/codecs/ak4642.c                          |   3 +
 sound/soc/codecs/hdac_hdmi.c                       |   1 -
 sound/soc/codecs/max98371.c                        | 441 +++++++++++++++
 sound/soc/codecs/max98371.h                        |  67 +++
 sound/soc/codecs/rt298.c                           |  51 +-
 sound/soc/codecs/rt298.h                           |   2 +
 sound/soc/codecs/rt5677.c                          |  24 +-
 sound/soc/codecs/tas571x.c                         | 141 ++++-
 sound/soc/codecs/tas571x.h                         |  22 +
 sound/soc/codecs/tas5720.c                         | 620 +++++++++++++++++=
++++
 sound/soc/codecs/tas5720.h                         |  90 +++
 sound/soc/codecs/tlv320aic31xx.c                   |  10 +
 sound/soc/codecs/tlv320aic32x4-i2c.c               |  74 +++
 sound/soc/codecs/tlv320aic32x4-spi.c               |  76 +++
 sound/soc/codecs/tlv320aic32x4.c                   | 279 +++++++---
 sound/soc/codecs/tlv320aic32x4.h                   |   7 +
 sound/soc/codecs/twl6040.c                         |  16 +-
 sound/soc/codecs/wm8962.c                          |   9 +-
 sound/soc/codecs/wm8962.h                          |   6 +-
 sound/soc/generic/simple-card.c                    |   1 +
 sound/soc/kirkwood/Kconfig                         |   1 +
 sound/soc/mediatek/Kconfig                         |   1 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  27 +
 sound/soc/mediatek/mt8173-rt5650.c                 |  50 +-
 sound/soc/mediatek/mtk-afe-pcm.c                   |   2 +
 sound/soc/omap/mcbsp.c                             |   8 +
 sound/soc/omap/omap-pcm.c                          |   2 +
 sound/soc/pxa/brownstone.c                         |   1 +
 sound/soc/pxa/mioa701_wm9713.c                     |   1 +
 sound/soc/pxa/mmp-pcm.c                            |   1 +
 sound/soc/pxa/mmp-sspa.c                           |   1 +
 sound/soc/pxa/palm27x.c                            |   1 +
 sound/soc/pxa/pxa-ssp.c                            |   1 +
 sound/soc/pxa/pxa2xx-ac97.c                        |   1 +
 sound/soc/pxa/pxa2xx-pcm.c                         |   1 +
 sound/soc/qcom/lpass-platform.c                    |   8 +-
 sound/soc/sh/rcar/adg.c                            |   8 +-
 sound/soc/sh/rcar/dma.c                            |  12 +-
 sound/soc/sh/rcar/rsnd.h                           |  13 +-
 sound/soc/sh/rcar/src.c                            |   4 +
 sound/soc/soc-topology.c                           |  48 +-
 sound/soc/sti/sti_uniperif.c                       | 144 ++++-
 sound/soc/sti/uniperif.h                           | 220 +++++++-
 sound/soc/sti/uniperif_player.c                    | 182 ++++--
 sound/soc/sti/uniperif_reader.c                    | 229 ++++++--
 sound/usb/quirks.c                                 |   3 +
 tools/build/Makefile.feature                       |   2 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-all.c                     |   5 +
 tools/build/feature/test-dwarf_getlocations.c      |  12 +
 tools/lib/traceevent/parse-filter.c                |   4 +-
 tools/net/bpf_jit_disasm.c                         |   3 +
 tools/perf/arch/x86/util/dwarf-regs.c              |   8 +-
 tools/perf/builtin-script.c                        |  70 ++-
 tools/perf/builtin-stat.c                          |   7 +-
 tools/perf/config/Makefile                         |   6 +
 tools/perf/util/dwarf-aux.c                        |   9 +
 tools/perf/util/event.c                            |  12 +-
 tools/perf/util/evsel.c                            |  23 +-
 tools/perf/util/parse-events.c                     |  60 +-
 tools/perf/util/sort.c                             |   3 +
 tools/perf/util/thread_map.c                       |   8 +-
 242 files changed, 4385 insertions(+), 1065 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/max98371.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt
 create mode 100644 sound/soc/codecs/max98371.c
 create mode 100644 sound/soc/codecs/max98371.h
 create mode 100644 sound/soc/codecs/tas5720.c
 create mode 100644 sound/soc/codecs/tas5720.h
 create mode 100644 sound/soc/codecs/tlv320aic32x4-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic32x4-spi.c
 create mode 100644 tools/build/feature/test-dwarf_getlocations.c

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSEVUAAoJECTWi3JdVIfQ0EcH/RfhHHe1s013SNQr4gUJ4sTk
Zyzy9mNLOyZ7R3n2s9Pnd1N6ZPqjUx4C2kGqGyNdZinggGDn3qweFfpXLdE6fOwT
WMx9taJjckjxYLTJ1g8V8kcDf2Wt0iFvY3pibaucXTjltvfqnoIlWG6Pk1VMtYDj
8xkiw4SSSOPBC2XlpH2A9v3gYJvGksnOp6t4GguDzScJs0ZGHy7EFJ3bTfu0ELcl
HLk2XVY76jnNuJ690eaTC6K0dG+nUG3XjIf8Gc0mLNjjUf1653UGBRLax0fnwI7v
CLUzkLl10YWjp8HA36hAwVAo2uK6SOZRTwht4xvl7mba7d9zy0gzBDkq/m1dlMA=
=qNvO
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--

--===============1178667463656603755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1178667463656603755==--
