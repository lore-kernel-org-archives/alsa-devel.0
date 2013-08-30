From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.12
Date: Fri, 30 Aug 2013 11:29:23 +0100
Message-ID: <20130830102923.GY10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5824692680153315673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B2FF2617AC
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 12:29:30 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5824692680153315673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uUCcNMVQw38YqIF/"
Content-Disposition: inline


--uUCcNMVQw38YqIF/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1c9a341bbdc14051a4d8c74ea67269786c7d3736:

  ALSA: hda - Simplify CONFIG_SND_HDA_I915 condition (2013-08-27 14:49:59 +=
0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.12-2

for you to fetch changes up to 6d52825fd4e78b251f4844f6662a3bc4e31671c7:

  Merge remote-tracking branch 'asoc/topic/wm8904' into tmp (2013-08-30 11:=
04:35 +0100)

The diffstat is large as this includes a merge up of v3.11-rc7.

----------------------------------------------------------------

ASoC: Updates for v3.12

A few more updates for v3.12, mostly small cleanups plus the addition of
the DT bindings for kirkwood and the new i.MX S/PDIF driver.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: rx51: change musb mode to OTG

Al Viro (1):
      cope with potentially long ->d_dname() output for shmem/hugetlb

Alan Stern (1):
      USB: OHCI: add missing PCI PM callbacks to ohci-pci.c

Alex Deucher (1):
      drm/radeon/r7xx: fix copy paste typo in golden register setup

Alexey Khoroshilov (1):
      via-ircc: don't return zero if via_ircc_open() failed

Anatolij Gustschin (1):
      usb: phy: fix build breakage

Andrey Vagin (1):
      tcp: set timestamps for restored skb-s

Anthony Foiani (1):
      sata_fsl: save irqs while coalescing

Anton Blanchard (1):
      [SCSI] lpfc: Don't force CONFIG_GENERIC_CSUM on

Ariel Elior (2):
      bnx2x: Protect against VFs' ndos when SR-IOV is disabled
      bnx2x: set VF DMAE when first function has 0 supported VFs

Baruch Siach (1):
      sched_clock: Fix integer overflow

Ben Hutchings (1):
      sfc: Fix lookup of default RX MAC filters when steered using ethtool

Ben Skeggs (2):
      drm/nouveau/mc: fix race condition between constructor and request_ir=
q()
      drm/nv04/disp: fix framebuffer pin refcounting

Benjamin Marzinski (1):
      GFS2: don't overrun reserved revokes

Benoit Cousson (1):
      MAINTAINERS: Update email address for Benoit Cousson

Boris BREZILLON (1):
      ARM: at91: add missing uart clocks DT entries

Chen Gang (1):
      arm64: KVM: use 'int' instead of 'u32' for variable 'target' in kvm_h=
ost.h.

Chris Wilson (2):
      drm/i915: Don't deref pipe->cpu_transcoder in the hangcheck code
      drm/i915: Invalidate TLBs for the rings after a reset

Christian K=C3=B6nig (1):
      drm/radeon: fix UVD message buffer validation

Christoffer Dall (3):
      ARM: KVM: Fix 64-bit coprocessor handling
      ARM: KVM: Fix unaligned unmap_range leak
      KVM: ARM: Squash len warning

Chuck Anderson (1):
      xen/smp: initialize IPI vectors before marking CPU online

Dan Carpenter (6):
      Hostap: copying wrong data prism2_ioctl_giwaplist()
      nl80211: nl80211hdr_put() doesn't return an ERR_PTR
      GFS2: alloc_workqueue() doesn't return an ERR_PTR
      efs: iget_locked() doesn't return an ERR_PTR()
      bfs: iget_locked() doesn't return an ERR_PTR
      VFS: collect_mounts() should return an ERR_PTR

Daniel Drake (2):
      x86: Don't clear olpc_ofw_header when sentinel is detected
      drivers/platform/olpc/olpc-ec.c: initialise earlier

Daniel Gimpelevich (2):
      hso: Earlier catch of error condition
      hso: Fix stack corruption on some architectures

Daniel Mack (1):
      ARM: OMAP2: fix musb usage for n8x0

Daniel Serpell (1):
      sony-laptop: Fix reporting of gfx_switch_status

Daniel Vetter (1):
      drm/i915: unpin backing storage in dmabuf_unmap

Dave Airlie (4):
      Merge branch 'drm-fixes-3.11' of git://people.freedesktop.org/~agd5f/=
linux
      Merge tag 'drm-intel-fixes-2013-08-15' of git://people.freedesktop.or=
g/~danvet/drm-intel
      Merge branch 'drm-nouveau-next' of git://anongit.freedesktop.org/git/=
nouveau/linux-2.6 into drm-fixes
      Merge tag 'drm-intel-fixes-2013-08-23' of git://people.freedesktop.or=
g/~danvet/drm-intel into drm-fixes

David Daney (1):
      MIPS: Handle OCTEON BBIT instructions in FPU emulator.

David S. Miller (3):
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'sfc-3.11' of git://git.kernel.org/.../bwh/sfc

David Vrabel (3):
      x86/xen: do not identity map UNUSABLE regions in the machine E820
      xen/events: initialize local per-cpu mask for all possible events
      xen/events: mask events when changing their VCPU binding

Dmitry Kravkov (3):
      bnx2x: dropless flow control not always functional
      bnx2x: Change DCB context handling
      bnx2x: Consider DCBX remote error

Duan Jiong (1):
      ipv6: handle Redirect ICMP Message with no Redirected Header option

Emmanuel Grumbach (1):
      iwlwifi: pcie: disable L1 Active after pci_enable_device

Fabio Estevam (8):
      ARM: 7819/1: fiq: Cast the first argument of flush_icache_range()
      ASoC: simple-card: Provide owner and MODULE_ALIAS()
      ASoC: fsl_spdif: Remove unnecessary dev_set_drvdata()
      ASoC: fsl_spdif: Reduce the noise on comments
      ASoC: fsl_ssi: Remove unnecessary dev_set_drvdata()
      ASoC: designware_i2s: Remove unnecessary dev_set_drvdata()
      ASoC: ep93xx-i2s: Remove unnecessary dev_set_drvdata()
      ASoC: fsl: Drop SND_SOC_FSL_UTILS from SND_SOC_IMX_SPDIF

Geert Uytterhoeven (1):
      dm cache: avoid conflicting remove_mapping() in mq policy

Giuseppe CAVALLARO (1):
      net: phy: rtl8211: fix interrupt on status link change

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-3.11c' of git://git.kernel.org/.../jic23/iio=
 into staging-linus

Guillaume Clement (1):
      gma500: Fix SDVO turning off randomly

Guy Cohen (1):
      Revert "iwlwifi: pcie: clear RFKILL interrupt in AMPG"

Hannes Frederic Sowa (2):
      ipv6: remove max_addresses check from ipv6_create_tempaddr
      ipv6: drop packets with multiple fragmentation headers

Ian Abbott (1):
      staging: comedi: bug-fix NULL pointer dereference on failed attach

Ilia Mirkin (1):
      drm/nouveau/fb: fix null derefs in nv49 and nv4e init

Ingo Molnar (3):
      Merge branch 'timers/urgent' of git://git.kernel.org/.../frederic/lin=
ux-dynticks into timers/urgent
      Merge branch 'fortglx/3.11/time' of git://git.linaro.org/people/jstul=
tz/linux into timers/urgent
      Merge tag 'amd_ucode_fixes' of git://git.kernel.org/.../bp/bp into x8=
6/urgent

Jean-Francois Moine (2):
      ASoc: kirkwood: add DT support to the mvebu audio subsystem
      ASoc: kirkwood: Use the Kirkwood audio driver in Dove boards

Joern Rennecke (1):
      ARC: [lib] strchr breakage in Big-endian configuration

Johannes Berg (3):
      iwlwifi: mvm: disconnect if time event scheduling fails
      cfg80211: don't request disconnect if not connected
      Revert "genetlink: fix family dump race"

John W. Linville (3):
      Merge branch 'for-john' of git://git.kernel.org/.../iwlwifi/iwlwifi-f=
ixes
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Julien Grall (1):
      xen/arm: missing put_cpu in xen_percpu_init

Jussi Kivilinna (1):
      zd1201: do not use stack as URB transfer_buffer

Kukjin Kim (1):
      ARM: SAMSUNG: fix to support for missing cpu specific map_io

Kuninori Morimoto (1):
      ASoC: fsi: reserve prefetch period on DMA transferring

Lars-Peter Clausen (8):
      ASoC: dmic: Convert table based DAPM setup
      ASoC: dapm: Fix marking widgets dirty when a route is added
      ASoC: tlv320aic32x4: Convert table based control and DAPM setup
      ASoC: wm8904: Remove unnecessary call to snd_soc_dapm_new_widgets()
      ASoC: jack: Remove unnecessary call to snd_soc_dapm_new_widgets()
      ASoC: Call snd_soc_dapm_new_widgets() only once during card initializ=
ation
      ASoC: Move call to snd_soc_dapm_new_widgets() after snd_soc_dapm_auto=
_nc_codec_pins()
      ASoC: Pass card instead of dapm context to snd_soc_dapm_new_widgets()

Li Zefan (1):
      cpuset: fix a regression in validating config change

Li Zhong (1):
      nohz: fix compile warning in tick_nohz_init()

Linus L=C3=BCssing (1):
      batman-adv: check return type of unicast packet preparations

Linus Torvalds (27):
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/.../ti=
p/tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge git://git.kernel.org/.../steve/gfs2-3.0-fixes
      proc: more readdir conversion bug-fixes
      Merge tag 'pinctrl-for-v3.11-3' of git://git.kernel.org/.../linusw/li=
nux-pinctrl
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'arm64-stable' of git://git.kernel.org/.../cmarinas/linux-a=
arch64
      Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-linus
      Merge tag 'stable/for-linus-3.11-rc6-tag' of git://git.kernel.org/...=
/xen/tip
      Revert "x86 get_unmapped_area(): use proper mmap base for bottom-up d=
irection"
      Merge tag 'dm-3.11-fixes' of git://git.kernel.org/.../device-mapper/l=
inux-dm
      Merge tag 'devicetree-fixes-for-3.11' of git://sources.calxeda.com/ke=
rnel/linux
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge branch 'linux-next' of git://cavan.codon.org.uk/platform-driver=
s-x86
      Merge branch 'akpm' (patches from Andrew Morton)
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge branch 'for-3.11-fixes' of git://git.kernel.org/.../tj/cgroup
      Merge branch 'for-3.11-fixes' of git://git.kernel.org/.../tj/libata
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'acpi-3.11-rc7' of git://git.kernel.org/.../rafael/linux-pm
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
      Merge tag 'usb-3.11-rc7' of git://git.kernel.org/.../gregkh/usb
      Merge tag 'staging-3.11-rc7' of git://git.kernel.org/.../gregkh/stagi=
ng
      Linux 3.11-rc7

Maarten Lankhorst (2):
      drm/nouveau/ltcg: fix ltcg memory initialization after suspend
      drm/nouveau/ltcg: fix allocating memory as free

Marc Zyngier (3):
      arm64: KVM: fix 2-level page tables unmapping
      arm64: KVM: perform save/restore of PAR_EL1
      arm64: KVM: add missing dsb before invalidating Stage-2 TLBs

Mark Brown (11):
      Merge remote-tracking branch 'asoc/topic/dmic' into asoc-core
      Merge remote-tracking branch 'asoc/topic/tlv320aic32x4' into asoc-core
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-core
      Merge remote-tracking branch 'asoc/topic/core' into tmp
      Merge remote-tracking branch 'asoc/topic/designware' into tmp
      Merge remote-tracking branch 'asoc/topic/ep93xx' into tmp
      Merge remote-tracking branch 'asoc/topic/fsi' into tmp
      Merge remote-tracking branch 'asoc/topic/fsl' into tmp
      Merge remote-tracking branch 'asoc/topic/kirkwood' into tmp
      Merge remote-tracking branch 'asoc/topic/samsung' into tmp
      Merge remote-tracking branch 'asoc/topic/wm8904' into tmp

Mark Langsdorf (1):
      sata, highbank: fix ordering of SGPIO signals

Martin Peschke (3):
      [SCSI] zfcp: fix lock imbalance by reworking request queue locking
      [SCSI] zfcp: fix schedule-inside-lock in scsi_device list loops
      [SCSI] zfcp: remove access control tables interface (keep sysfs files)

Matthew Garrett (1):
      Revert "hp-wmi: Enable hotkeys on some systems"

Maxime Ripard (3):
      pinctrl: sunxi: Read register before writing to it in irq_set_type
      pinctrl: sunxi: Fix gpio_set behaviour
      pinctrl: sunxi: Add spinlocks

Michal Hocko (1):
      memcg: get rid of swapaccount leftovers

Nicolas Ferre (2):
      ARM: at91/DT: at91sam9x5ek: fix USB host property to enable port C
      ARM: at91/DT: fix at91sam9n12ek memory node

Nicolas Pitre (1):
      ARM: 7816/1: CONFIG_KUSER_HELPERS: fix help text

Nicolin Chen (1):
      ASoC: fsl: Add S/PDIF machine driver

Oleg Nesterov (1):
      proc: kill the extra proc_readfd_common()->dir_emit_dots()

Olof Johansson (2):
      Merge tag 'samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-s=
amsung into fixes
      Merge tag 'at91-fixes' of git://github.com/at91linux/linux-at91 into =
fixes

Pali Roh=C3=A1r (1):
      drm/nouveau: fix reclocking on nv40

Paolo Bonzini (2):
      Merge branch 'kvm-arm64/fixes-3.11-rc4' of git://git.kernel.org/.../m=
az/arm-platforms into kvm-master
      Merge tag 'kvm-arm-fixes-3.11' of git://git.linaro.org/people/cdall/l=
inux-kvm-arm into kvm-master

Peter Meerwald (1):
      iio: adjd_s311: Fix non-scan mode data read

Peter Wu (1):
      r8169: remember WOL preferences on driver load

Radu Caragea (1):
      x86 get_unmapped_area: Access mmap_legacy_base through mm_struct memb=
er

Rafael J. Wysocki (1):
      Revert "ACPI / video: Always call acpi_video_init_brightness() on ini=
t"

Rafa=C5=82 Mi=C5=82ecki (1):
      drm/radeon: fix WREG32_OR macro setting bits in a register

Randy Dunlap (1):
      kernel: fix new kernel-doc warning in wait.c

Richard Genoud (1):
      proc: return on proc_readdir error

Richard Laager (1):
      lib/lz4: correct the LZ4 license

Roland Dreier (1):
      [SCSI] sg: Fix user memory corruption when SG_IO is interrupted by a =
signal

Russell King (1):
      Merge branch 'security-fixes' into fixes

Sathya Perla (1):
      be2net: fix disabling TX in be_close()

Sekhar Nori (1):
      ARM: davinci: nand: specify ecc strength

Stanislaw Gruszka (1):
      iwlwifi: dvm: fix calling ieee80211_chswitch_done() with NULL

Stefano Stabellini (1):
      Merging v3.10-rc2 as I need to apply a fix for

Stephen Warren (1):
      ARM: tegra: always enable USB VBUS regulators

Steven Rostedt (1):
      nohz: Do not warn about unstable tsc unless user uses nohz_full

Steven Whitehouse (2):
      GFS2: Fix typo in gfs2_create_inode()
      GFS2: Check for glock already held in gfs2_getxattr

Tejun Heo (1):
      GFS2: WQ_NON_REENTRANT is meaningless and going away

Terry Suereth (1):
      libata: apply behavioral quirks to sil3826 PMP

Tomasz Figa (1):
      ASoC: Samsung: Do not queue cyclic buffers multiple times

Torsten Kaiser (2):
      x86, microcode, AMD: Make cpu_has_amd_erratum() use the correct struc=
t cpuinfo_x86
      x86, microcode, AMD: Fix early microcode loading

Toshiaki Makita (1):
      bridge: Use the correct bit length for bitmap functions in the VLAN c=
ode

Vijaya Kumar K (1):
      ARM: 7815/1: kexec: offline non panic CPUs on Kdump panic

Vlad Yasevich (3):
      macvtap: simplify usage of tap_features
      macvtap: Correctly set tap features when IFF_VNET_HDR is disabled.
      macvtap: Ignore tap features when VNET_HDR is off

Vyacheslav Dubeyko (2):
      nilfs2: remove double bio_put() in nilfs_end_bio_write() for BIO_EOPN=
OTSUPP error
      nilfs2: fix issue with counting number of bio requests for BIO_EOPNOT=
SUPP error detection

Wei Yongjun (2):
      sony-laptop: return a negative error code in sonypi_compat_init()
      ASoC: fsl_spdif: remove redundant dev_err call in fsl_spdif_probe()

Will Deacon (2):
      arm64: perf: fix array out of bounds access in armpmu_map_hw_event()
      arm64: perf: fix event validation for software group leaders

Willem de Bruijn (1):
      packet: restore packet statistics tp_packets to include drops

Wladislav Wiebe (1):
      of: fdt: fix memory initialization for expanded DT

Yuval Mintz (1):
      bnx2x: prevent VF benign attentions

stephen hemminger (1):
      ipv4: expose IPV4_DEVCONF

 .../devicetree/bindings/sound/imx-audio-spdif.txt  |  34 +++++
 .../devicetree/bindings/sound/mvebu-audio.txt      |  29 ++++
 Documentation/kernel-parameters.txt                |   2 +-
 MAINTAINERS                                        |   6 +-
 Makefile                                           |   2 +-
 arch/arc/lib/strchr-700.S                          |  10 ++
 arch/arm/boot/dts/at91sam9n12ek.dts                |   4 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |   5 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |   2 +
 arch/arm/boot/dts/tegra20-trimslice.dts            |   2 +
 arch/arm/boot/dts/tegra20-whistler.dts             |   4 +
 arch/arm/kernel/fiq.c                              |   3 +-
 arch/arm/kernel/machine_kexec.c                    |   1 +
 arch/arm/kvm/coproc.c                              |  26 +++-
 arch/arm/kvm/coproc.h                              |   3 +
 arch/arm/kvm/coproc_a15.c                          |   6 +-
 arch/arm/kvm/mmio.c                                |   3 +-
 arch/arm/kvm/mmu.c                                 |  36 +++--
 arch/arm/mach-at91/at91sam9x5.c                    |   2 +
 arch/arm/mach-davinci/board-dm355-leopard.c        |   1 +
 arch/arm/mach-davinci/board-dm644x-evm.c           |   1 +
 arch/arm/mach-davinci/board-dm646x-evm.c           |   1 +
 arch/arm/mach-davinci/board-neuros-osd2.c          |   1 +
 arch/arm/mach-omap2/board-n8x0.c                   |   4 -
 arch/arm/mach-omap2/board-rx51.c                   |   2 +-
 arch/arm/mach-omap2/usb-musb.c                     |   5 +-
 arch/arm/mm/Kconfig                                |   9 +-
 arch/arm/plat-samsung/init.c                       |   5 +-
 arch/arm/plat-samsung/s3c-dma-ops.c                |  13 +-
 arch/arm/xen/enlighten.c                           |   1 +
 arch/arm64/include/asm/kvm_asm.h                   |  17 ++-
 arch/arm64/include/asm/kvm_host.h                  |   2 +-
 arch/arm64/kernel/perf_event.c                     |  10 +-
 arch/arm64/kvm/hyp.S                               |  13 ++
 arch/arm64/kvm/sys_regs.c                          |   3 +
 arch/mips/math-emu/cp1emu.c                        |  26 ++++
 arch/x86/include/asm/bootparam_utils.h             |   4 +-
 arch/x86/include/asm/microcode_amd.h               |   2 +-
 arch/x86/kernel/cpu/amd.c                          |  20 +--
 arch/x86/kernel/microcode_amd.c                    |  27 ++--
 arch/x86/kernel/microcode_amd_early.c              |  27 ++--
 arch/x86/kernel/sys_x86_64.c                       |   2 +-
 arch/x86/mm/mmap.c                                 |   8 +-
 arch/x86/xen/setup.c                               |  22 +++
 arch/x86/xen/smp.c                                 |  11 +-
 drivers/acpi/video.c                               |  11 +-
 drivers/ata/libata-pmp.c                           |  12 +-
 drivers/ata/sata_fsl.c                             |   5 +-
 drivers/ata/sata_highbank.c                        |   4 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |   3 +-
 drivers/gpu/drm/i915/i915_gem_dmabuf.c             |   8 ++
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +
 drivers/gpu/drm/i915/intel_display.c               |  86 ++++++++----
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  12 ++
 drivers/gpu/drm/nouveau/core/core/mm.c             |   4 +
 drivers/gpu/drm/nouveau/core/include/subdev/mc.h   |   7 +-
 drivers/gpu/drm/nouveau/core/subdev/fb/ramnv49.c   |  12 +-
 drivers/gpu/drm/nouveau/core/subdev/fb/ramnv4e.c   |   4 +-
 drivers/gpu/drm/nouveau/core/subdev/ltcg/nvc0.c    |  34 +++--
 drivers/gpu/drm/nouveau/core/subdev/mc/base.c      |   6 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv04.c      |   3 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv44.c      |   3 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv50.c      |   3 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv98.c      |   3 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nvc0.c      |   3 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |  58 +++++---
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |   1 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |   3 +
 drivers/gpu/drm/nouveau/nv40_pm.c                  |   2 +-
 drivers/gpu/drm/radeon/radeon.h                    |   2 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   8 ++
 drivers/gpu/drm/radeon/rv770.c                     |  12 +-
 drivers/iio/light/adjd_s311.c                      |   3 +-
 drivers/md/dm-cache-policy-mq.c                    |  16 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   2 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c    |  49 +++++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.h    |   3 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  45 +++++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |  56 ++++----
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   2 +-
 drivers/net/ethernet/sfc/filter.c                  |   2 +-
 drivers/net/irda/via-ircc.c                        |   6 +-
 drivers/net/macvtap.c                              |  18 +--
 drivers/net/phy/realtek.c                          |   4 +-
 drivers/net/usb/hso.c                              |  15 ++-
 drivers/net/wireless/hostap/hostap_ioctl.c         |   4 +-
 drivers/net/wireless/iwlwifi/dvm/mac80211.c        |   5 +-
 drivers/net/wireless/iwlwifi/iwl-prph.h            |   2 -
 drivers/net/wireless/iwlwifi/mvm/time-event.c      |  33 +++--
 drivers/net/wireless/iwlwifi/pcie/rx.c             |   8 --
 drivers/net/wireless/iwlwifi/pcie/trans.c          |  10 +-
 drivers/net/wireless/zd1201.c                      |   4 +-
 drivers/of/fdt.c                                   |   2 +
 drivers/pinctrl/pinctrl-sunxi.c                    |  66 ++++++++-
 drivers/pinctrl/pinctrl-sunxi.h                    |   2 +
 drivers/platform/olpc/olpc-ec.c                    |   2 +-
 drivers/platform/x86/hp-wmi.c                      |  16 ---
 drivers/platform/x86/sony-laptop.c                 |   8 +-
 drivers/s390/scsi/zfcp_erp.c                       |  29 +++-
 drivers/s390/scsi/zfcp_qdio.c                      |   8 +-
 drivers/s390/scsi/zfcp_sysfs.c                     |  14 ++
 drivers/scsi/Kconfig                               |   1 -
 drivers/staging/comedi/drivers.c                   |   2 +-
 drivers/usb/host/ohci-pci.c                        |   5 +
 drivers/usb/phy/phy-fsl-usb.h                      |   2 +-
 drivers/usb/phy/phy-fsm-usb.c                      |   2 +-
 drivers/xen/events.c                               |  13 +-
 fs/bfs/inode.c                                     |   2 +-
 fs/bio.c                                           |  20 ++-
 fs/dcache.c                                        |  11 ++
 fs/efs/inode.c                                     |   2 +-
 fs/gfs2/glock.c                                    |   8 +-
 fs/gfs2/glops.c                                    |  18 ++-
 fs/gfs2/inode.c                                    |   6 +-
 fs/gfs2/main.c                                     |   2 +-
 fs/hugetlbfs/inode.c                               |   8 +-
 fs/namespace.c                                     |   2 +-
 fs/nilfs2/segbuf.c                                 |   5 +-
 fs/proc/fd.c                                       |   2 -
 fs/proc/generic.c                                  |   2 +-
 fs/proc/root.c                                     |   4 +-
 include/linux/dcache.h                             |   1 +
 include/linux/inetdevice.h                         |  34 +----
 include/linux/ipv6.h                               |   1 +
 include/linux/mm_types.h                           |   1 +
 include/linux/sched.h                              |   1 -
 include/linux/wait.h                               |  57 ++++++++
 include/net/ip6_route.h                            |   2 +
 include/sound/soc-dapm.h                           |   2 +-
 include/uapi/linux/ip.h                            |  34 +++++
 init/Kconfig                                       |   2 +-
 kernel/cpuset.c                                    |  14 +-
 kernel/time/sched_clock.c                          |   2 +-
 kernel/time/tick-sched.c                           |   5 +-
 kernel/wait.c                                      |   3 +-
 lib/lz4/lz4_compress.c                             |   4 +-
 lib/lz4/lz4_decompress.c                           |   6 +-
 lib/lz4/lz4hc_compress.c                           |   4 +-
 mm/memcontrol.c                                    |   1 -
 mm/shmem.c                                         |   8 +-
 net/batman-adv/unicast.c                           |  10 +-
 net/bridge/br_fdb.c                                |  10 +-
 net/bridge/br_netlink.c                            |   4 +-
 net/bridge/br_vlan.c                               |   4 +-
 net/ipv4/tcp.c                                     |   7 +
 net/ipv6/addrconf.c                                |  10 +-
 net/ipv6/ndisc.c                                   |   4 +-
 net/ipv6/reassembly.c                              |   5 +
 net/ipv6/route.c                                   |  21 +++
 net/netlink/genetlink.c                            |   7 -
 net/packet/af_packet.c                             |   2 +
 net/wireless/nl80211.c                             |  22 +--
 net/wireless/sme.c                                 |  10 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |   2 -
 sound/soc/codecs/dmic.c                            |  17 +--
 sound/soc/codecs/tlv320aic32x4.c                   |  22 +--
 sound/soc/codecs/wm8904.c                          |   1 -
 sound/soc/dwc/designware_i2s.c                     |   5 +-
 sound/soc/fsl/Kconfig                              |  10 ++
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_spdif.c                          |  17 +--
 sound/soc/fsl/fsl_ssi.c                            |   1 -
 sound/soc/fsl/imx-spdif.c                          | 148 +++++++++++++++++=
++++
 sound/soc/generic/simple-card.c                    |   2 +
 sound/soc/kirkwood/Kconfig                         |   4 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |  26 +++-
 sound/soc/samsung/dma.c                            |   7 +
 sound/soc/sh/fsi.c                                 |  51 ++++---
 sound/soc/soc-core.c                               |   9 +-
 sound/soc/soc-dapm.c                               |   9 +-
 sound/soc/soc-jack.c                               |   2 -
 172 files changed, 1316 insertions(+), 598 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/mvebu-audio.txt
 create mode 100644 sound/soc/fsl/imx-spdif.c

--uUCcNMVQw38YqIF/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIHQAAAoJELSic+t+oim9pdkP/2JYGV5b1weT577LgcP+aUeE
1Pz+TsrxPi+aPMnHOKpFU4KWMtI+drJA5PHoAPN4amc41xxHRoIkN8axcB7MHBSt
T4ByIYmFK18YCYRBRmTp/0kmGvnERDp9qb+H+AQlomKIo7wcNxma7zvIgC8bhv0T
qx8aldnfR1rZNsyakeSBWStC5OsfwnvZbJMRefWxhs5nLRjfyUjTFuYwCQfteXHM
YT0k6wbLd530BNoZSkitg+L/cJuK8oi8TYxo46XCkihTzzuZNRawvOFRM176w5m8
RFALbkjSmt3DlFtZUQtE9UQ/230w52mb+awu/O0CyJ5WPfwgZsz8v3U09TJOC/fY
6l+o6uY/PSCpPpbyNSLiUFwOi80tLg21+CGcHCMPpurw4hW+BU66P+YVmm6v0XzY
RmLyvRNKQd9Ar+2FqDmRQrivAfWwY8K12CCbqqAkI2Pj6mxM6AKDCQSaibghUm7/
v0DQDJSiCHzZbEGmCesC+jDUP8iDQSbD9hBJptC4x1NE1TxAiYbAvHhE5+U3h+VS
b+DP2w0M/xD+VTY5bQXsP0401qCCaVR/JKQBxNo2jBaH4mhyHUjOEgytyisEQkcT
ZHCN3NmK8yOX3vi3Vz9qfRFow202xpvFDH9axfSTg8D4BvopPDNhIFbGosQ0ce7U
LcFjKss3o9p5m+0LQ6QG
=MsD1
-----END PGP SIGNATURE-----

--uUCcNMVQw38YqIF/--

--===============5824692680153315673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5824692680153315673==--
