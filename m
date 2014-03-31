From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.15
Date: Mon, 31 Mar 2014 11:32:07 +0100
Message-ID: <20140331103207.GN2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1597985138614728842=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CC92619D7
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 12:32:18 +0200 (CEST)
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


--===============1597985138614728842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j1Wwy33+dU2Jf0xa"
Content-Disposition: inline


--j1Wwy33+dU2Jf0xa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit e090d5b6ad20056ec0ef58727e3ae95fd82be090:

  Merge remote-tracking branches 'asoc/topic/simple' and 'asoc/topic/sirf' =
into asoc-next (2014-03-23 14:00:59 +0000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.15-4

for you to fetch changes up to c159a85013afbb8283f0c7272812952e04d5c3a1:

  Merge remote-tracking branches 'asoc/topic/tdm' and 'asoc/topic/tegra' in=
to asoc-next (2014-03-25 21:22:15 +0000)

----------------------------------------------------------------

ASoC: Final updates for v3.15 merge window

A few more updates from last week - use of the tdm_slot mapping from
Xiubo plus a few smaller fixes and cleanups.

----------------------------------------------------------------
Alex Smith (1):
      MIPS: Fix possible build error with transparent hugepages enabled

Andreas Herrmann (1):
      MIPS: Octeon: Fix warning in of_device_alloc on cn3xxx

Arnaldo Carvalho de Melo (1):
      perf bench numa: Make no args mean 'run all tests'

Ben Pfaff (1):
      openvswitch: Correctly report flow used times for first 5 minutes aft=
er boot.

Ben Widawsky (1):
      drm/i915: Fix PSR programming

Benedikt Spranger (1):
      net: cpsw: do not register cpts twice

Bjorn Helgaas (1):
      Revert "[PATCH] Insert GART region into resource map"

Bj=C3=B8rn Mork (1):
      net: cdc_ncm: fix control message ordering

Boris BREZILLON (1):
      ARM: at91: fix network interface ordering for sama5d36

Charles Keepax (1):
      ALSA: compress: Pass through return value of open ops callback

Chris Wilson (1):
      drm/i915: Disable stolen memory when DMAR is active

Christian Riesch (2):
      net: davinci_emac: Replace devm_request_irq with request_irq
      net: davinci_emac: Fix rollback of emac_dev_open()

Clemens Ladisch (1):
      ALSA: oxygen: Xonar DG(X): fix Stereo Upmixing regression

Colin Ian King (1):
      MIPS: Octeon: Fix fall through on bar type OCTEON_DMA_BAR_TYPE_SMALL

Daniel Kurtz (1):
      drm/exynos: Fix (more) freeing issues in exynos_drm_drv.c

Daniel Vetter (2):
      drm/i915: Don't enable display error interrupts from the start
      drm: Fix use-after-free in the shadow-attache exit code

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2014-03-17' of git://anongit.freedesktop.o=
rg/drm-intel into drm-fixes
      Merge tag 'drm-intel-fixes-2014-03-19' of git://anongit.freedesktop.o=
rg/drm-intel into drm-fixes
      Merge branch 'exynos-drm-fixes' of git://git.kernel.org/.../daeinki/d=
rm-exynos into drm-fixes

Dave Jones (2):
      brcmfmac: fix skb leak in brcmf_sdio_txpkt_prep_sg error path.
      block: free q->flush_rq in blk_init_allocated_queue error paths

Dave Kleikamp (1):
      sparc64: don't treat 64-bit syscall return codes as 32-bit

David Miller (1):
      sparc: serial: Clean up the locking for -rt

David S. Miller (6):
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'cnic-net'
      Merge branch 'fixes' of git://git.kernel.org/.../jesse/openvswitch
      sparc64: Make sure %pil interrupts are enabled during hypervisor yiel=
d.
      Merge branch 'davinci_emac'

David Stevens (2):
      vxlan: fix potential NULL dereference in arp_reduce()
      vxlan: fix nonfunctional neigh_reduce()

Deng-Cheng Zhu (4):
      MIPS: APRP: Fix the linking of rtlx interrupt hook
      MIPS: APRP: Unregister rtlx interrupt hook at module exit
      MIPS: APRP: Choose the correct VPE loader by fixing the linking
      MIPS: math-emu: Fix prefx detection and COP1X function field definiti=
on

Doug Wilson (1):
      sparc64:tsb.c:use array size macro rather than number

Eric Dumazet (1):
      tcp: syncookies: do not use getnstimeofday()

Erik Hugne (1):
      tipc: fix spinlock recursion bug for failed subscriptions

Felix Fietkau (1):
      ath9k_hw: fix unreachable code in baseband hang detection code

Fernando Luis V=C3=A1zquez Cao (1):
      HID: hidraw: fix warning destroying hidraw device files after parent

Frank Praznik (1):
      HID: sony: Fix work queue issues.

Helge Deller (2):
      partly revert commit 8a10bc9: parisc/sti_console: prefer Linux fonts =
over built-in ROM fonts
      parisc: wire up sys_utimes

Helmut Schaa (1):
      ath9k: Fix sequence number assignment for non-data frames

Huacai Chen (1):
      MIPS: FPU: Fix conflict of register usage

Hugh Dickins (2):
      mm: fix bad rss-counter if remap_file_pages raced migration
      mm: fix swapops.h:131 bug if remap_file_pages raced migration

Ingo Molnar (1):
      Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/.../acme/li=
nux into perf/urgent

Jani Nikula (1):
      Revert "drm/i915: don't touch the VDD when disabling the panel"

Jarno Rajahalme (2):
      openvswitch: Read tcp flags only then the tranport header is present.
      openvswitch: Fix race.

Jean-Francois Moine (3):
      ASoC: simple-card: dynamically allocate the DAI link and properties
      ASoC: simple-card: Add DT documentation for multi-DAI links
      ASoC: simple-card: Handle many DAI links

Jens Axboe (1):
      mtip32xx: fix bad use of smp_processor_id()

Jim Quinlan (1):
      MIPS: Make local_irq_disable macro safe for non-Mipsr2

Jiri Pirko (1):
      ovs: fix dp check in ovs_dp_reset_user_features

Joe Perches (1):
      MAINTAINERS: Add linux.nics@intel.com to INTEL ETHERNET DRIVERS

John David Anglin (1):
      parisc: Remove unused CONFIG_PARISC_TMPALIAS code

John W. Linville (1):
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Kuninori Morimoto (3):
      ARM: bockw: fixup SND_SOC_DAIFMT_CBx_CFx flags
      ASoC: rcar: bugfix: it cares about the non-src case
      ASoC: rcar: subnode tidyup for renesas,rsnd.txt

Lars Persson (1):
      MIPS: Fix syscall tracing interface

Lars-Peter Clausen (1):
      ASoC: Remove name_prefix unset during DAI link init hack

Li RongQing (1):
      netpoll: fix the skb check in pkt_is_ns

Li Zefan (1):
      cgroup: fix a failure path in create_css()

Linus Torvalds (18):
      Merge branch 'for-linus' of git://git.kernel.org/.../jikos/hid
      Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-linus
      Merge branch 'for-linus' of git://git.kernel.dk/linux-block
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/.../ti=
p/tip
      Merge branch 'for-3.14-fixes' of git://git.kernel.org/.../tj/cgroup
      Merge tag 'pci-v3.14-fixes-3' of git://git.kernel.org/.../helgaas/pci
      Merge tag 'sound-3.14' of git://git.kernel.org/.../tiwai/sound
      Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-linus
      Merge tag 'trace-fixes-v3.14-rc7' of git://git.kernel.org/.../rostedt=
/linux-trace
      futex: revert back to the explicit waiter counting code
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge git://git.kernel.org/.../davem/net
      Merge git://git.kernel.org/.../davem/sparc
      Merge branch 'parisc-3.14' of git://git.kernel.org/.../deller/parisc-=
linux
      Linux 3.14-rc8

Lucas Stach (1):
      ASoC: tegra: move AC97 clock handling to the machine driver

Manuel Lauss (1):
      MIPS: Alchemy: Fix unchecked kstrtoul return value

Mark Brown (14):
      Merge remote-tracking branches 'asoc/fix/cs42l51', 'asoc/fix/cs42l52'=
, 'asoc/fix/cs42l73', 'asoc/fix/rcar', 'asoc/fix/spear' and 'asoc/fix/tegra=
' into asoc-linus
      Merge tag 'asoc-v3.15' into asoc-next
      Merge tag 'asoc-v3.15-2' into asoc-next
      Merge tag 'asoc-v3.15-3' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/cs42l51', 'asoc/fix/cs42l52'=
, 'asoc/fix/cs42l73', 'asoc/fix/rcar', 'asoc/fix/spear' and 'asoc/fix/tegra=
' into asoc-linus
      Merge tag 'asoc-v3.15' into asoc-next
      Merge tag 'asoc-v3.15-2' into asoc-next
      Merge tag 'asoc-v3.15-3' into asoc-next
      Merge tag 'asoc-v3.15-rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/prefix' and 'asoc/topic/rc=
ar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/simple' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tdm' and 'asoc/topic/tegra=
' into asoc-next

Markos Chandras (2):
      MIPS: bcm47xx: Include missing errno.h for ENXIO
      MIPS: asm: syscall: Fix copying system call arguments

Michael Chan (3):
      cnic: Use proper ulp_ops for per device operations.
      cnic,bnx2i,bnx2fc: Fix inconsistent use of page size
      cnic: Update version to 2.5.20 and copyright year.

Mike Snitzer (2):
      block: fix q->flush_rq NULL pointer crash on dm-mpath flush
      block: change flush sequence list addition back to front add

Nicolas Dichtel (3):
      rtnetlink: fix fdb notification flags
      ipmr: fix mfc notification flags
      ip6mr: fix mfc notification flags

Nikolay Aleksandrov (2):
      net: af_key: fix sleeping under rcu
      selinux: add gfp argument to security_xfrm_policy_alloc and fix calle=
rs

Nishanth Menon (1):
      net: micrel : ks8851-ml: add vdd-supply support

Patrick Palka (1):
      perf bench: Fix NULL pointer dereference in "perf bench all"

Paul Bolle (2):
      MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
      isdn/capi: Make Middleware depend on CAPI2.0

Paul Burton (1):
      MIPS: mark O32+FP64 experimental for now

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Remove bogus duplicate code
      KVM: PPC: Book3S HV: Fix register usage when loading/saving VRSAVE

Peter Senna Tschudin (2):
      ATHEROS-ALX: Use dma_set_mask_and_coherent and fix a bug
      ATHEROS-ATL1E: Convert iounmap to pci_iounmap

Rafa=C5=82 Mi=C5=82ecki (1):
      MIPS: BCM47XX: Check all (32) GPIOs when looking for a pin

Ralf Baechle (1):
      MIPS: Fix randconfig build error.

Roger Luethi (1):
      via-rhine: Disable device in error path

Sebastian Hesselbarth (1):
      net: phy: fix uninitalized ethtool_wolinfo in phy_suspend

Shawn Guo (1):
      MAINTAINERS: update IMX kernel git tree

Simon Wood (1):
      HID: hid-lg4ff: Support new version of G27

Stanislaw Gruszka (1):
      Revert "rt2x00: rt2800lib: Update BBP register initialization for RT5=
3xx"

Stefan Agner (1):
      clocksource: vf_pit_timer: use complement for sched_clock reading

Vaibhav Nagarnaik (1):
      tracing: Fix array size mismatch in format string

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Add a workaround for HSW scanline counter weirdness
      drm/i915: Fix scanline counter fixup on BDW

Viller Hsiao (2):
      MIPS: ftrace: Fix icache flush range error
      MIPS: ftrace: Tweak safe_load()/safe_store() macros

Will Deacon (1):
      parisc: locks: remove redundant arch_*_relax operations

Xiubo Li (4):
      ASoC: core: remove the 'of_' prefix of of_xlate_tdm_slot_mask.
      ASoC: fsl-utils: Add fsl_asoc_xlate_tdm_slot_mask() support.
      ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support.
      ASoC: imx-ssi: Add .xlate_tdm_slot_mask() support.

lucien (1):
      ipv6: ip6_append_data_mtu do not handle the mtu of the second fragmen=
t properly

stephen hemminger (1):
      netlink: fix setsockopt in mmap examples in documentation

 .../devicetree/bindings/net/micrel-ks8851.txt      |   1 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  15 +-
 .../devicetree/bindings/sound/simple-card.txt      |  42 +++-
 Documentation/networking/netlink_mmap.txt          |   4 +-
 MAINTAINERS                                        |   5 +-
 Makefile                                           |   2 +-
 arch/arm/boot/dts/sama5d36.dtsi                    |   2 +-
 arch/arm/mach-shmobile/board-bockw.c               |  16 +-
 arch/mips/Kconfig                                  |  24 ++-
 arch/mips/alchemy/board-gpr.c                      |   4 +-
 arch/mips/alchemy/board-mtx1.c                     |   4 +-
 arch/mips/bcm47xx/board.c                          |   1 +
 arch/mips/bcm47xx/nvram.c                          |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |  22 ++-
 arch/mips/include/asm/asmmacro.h                   |  15 +-
 arch/mips/include/asm/fpu.h                        |   2 +-
 arch/mips/include/asm/ftrace.h                     |  20 +-
 arch/mips/include/asm/syscall.h                    |  10 +-
 arch/mips/include/uapi/asm/inst.h                  |   4 +-
 arch/mips/kernel/ftrace.c                          |   5 +-
 arch/mips/kernel/r4k_fpu.S                         |  16 +-
 arch/mips/kernel/rtlx-cmp.c                        |   3 +
 arch/mips/kernel/rtlx-mt.c                         |   3 +
 arch/mips/math-emu/cp1emu.c                        |   6 +-
 arch/mips/mti-malta/malta-amon.c                   |   2 +-
 arch/mips/mti-malta/malta-int.c                    |   4 +-
 arch/mips/pci/msi-octeon.c                         |   1 +
 arch/parisc/include/asm/page.h                     |  11 --
 arch/parisc/include/asm/spinlock.h                 |   4 -
 arch/parisc/include/uapi/asm/unistd.h              |   4 +-
 arch/parisc/kernel/cache.c                         |  64 ------
 arch/parisc/kernel/syscall_table.S                 |   1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  71 +------
 arch/sparc/kernel/process_64.c                     |   4 +-
 arch/sparc/kernel/syscalls.S                       |   4 +-
 arch/sparc/mm/tsb.c                                |   2 +-
 arch/x86/kernel/aperture_64.c                      |  20 +-
 block/blk-core.c                                   |  25 ++-
 block/blk-flush.c                                  |  11 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   2 +-
 drivers/clocksource/vf_pit_timer.c                 |   2 +-
 drivers/gpu/drm/drm_pci.c                          |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  10 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   7 +
 drivers/gpu/drm/i915/i915_irq.c                    |  71 ++++---
 drivers/gpu/drm/i915/intel_ddi.c                   |   1 +
 drivers/gpu/drm/i915/intel_dp.c                    |  12 +-
 drivers/hid/hid-lg4ff.c                            |   2 +
 drivers/hid/hid-sony.c                             |  27 ++-
 drivers/hid/hidraw.c                               |   4 +-
 drivers/isdn/capi/Kconfig                          |  18 +-
 drivers/net/ethernet/atheros/alx/main.c            |  14 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   4 +-
 drivers/net/ethernet/broadcom/cnic.c               | 111 +++++------
 drivers/net/ethernet/broadcom/cnic.h               |   2 +-
 drivers/net/ethernet/broadcom/cnic_defs.h          |   2 +-
 drivers/net/ethernet/broadcom/cnic_if.h            |  16 +-
 drivers/net/ethernet/micrel/ks8851.c               |  30 ++-
 drivers/net/ethernet/ti/cpsw.c                     |   4 -
 drivers/net/ethernet/ti/davinci_cpdma.c            |   4 +-
 drivers/net/ethernet/ti/davinci_emac.c             |  53 +++--
 drivers/net/ethernet/via/via-rhine.c               |   8 +-
 drivers/net/phy/phy_device.c                       |   3 +-
 drivers/net/usb/cdc_ncm.c                          |  48 +++--
 drivers/net/vxlan.c                                | 130 ++++++++++--
 drivers/net/wireless/ath/ath9k/hw.c                |   3 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   4 +-
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |   4 +-
 drivers/net/wireless/rt2x00/rt2800lib.c            |   6 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |  16 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                   |  38 ++--
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  52 ++---
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |  23 +--
 drivers/tty/serial/sunhv.c                         |  22 +--
 drivers/tty/serial/sunsab.c                        |  14 +-
 drivers/tty/serial/sunsu.c                         |  14 +-
 drivers/tty/serial/sunzilog.c                      |  14 +-
 include/linux/ftrace_event.h                       |   4 -
 include/linux/rmap.h                               |   3 +-
 include/linux/security.h                           |  10 +-
 include/linux/usb/cdc_ncm.h                        |   1 +
 include/net/tcp.h                                  |  11 +-
 include/sound/soc-dai.h                            |   2 +-
 include/trace/ftrace.h                             |   7 +-
 kernel/cgroup.c                                    |  11 +-
 kernel/futex.c                                     |  53 ++++-
 kernel/trace/trace_events.c                        |   6 -
 kernel/trace/trace_export.c                        |   7 +-
 lib/fonts/Kconfig                                  |   6 +-
 mm/fremap.c                                        |  28 ++-
 mm/migrate.c                                       |  32 +++
 mm/rmap.c                                          |   5 +-
 net/core/netpoll.c                                 |   2 +-
 net/core/rtnetlink.c                               |  10 +-
 net/ipv4/ipmr.c                                    |  13 +-
 net/ipv6/ip6_output.c                              |  14 +-
 net/ipv6/ip6mr.c                                   |  13 +-
 net/key/af_key.c                                   |  19 +-
 net/openvswitch/datapath.c                         |   9 +-
 net/openvswitch/flow.c                             |   3 +-
 net/tipc/subscr.c                                  |  29 +--
 net/xfrm/xfrm_user.c                               |   6 +-
 security/capability.c                              |   3 +-
 security/security.c                                |   6 +-
 security/selinux/hooks.c                           |  13 +-
 security/selinux/include/security.h                |   2 +-
 security/selinux/include/xfrm.h                    |   3 +-
 security/selinux/selinuxfs.c                       |  28 ++-
 security/selinux/ss/services.c                     |   6 +-
 security/selinux/xfrm.c                            |  14 +-
 sound/core/compress_offload.c                      |   2 +-
 sound/pci/oxygen/xonar_dg.c                        |  30 ++-
 sound/soc/fsl/Kconfig                              |   2 +
 sound/soc/fsl/fsl_esai.c                           |   2 +
 sound/soc/fsl/fsl_utils.c                          |  27 +++
 sound/soc/fsl/fsl_utils.h                          |   4 +-
 sound/soc/fsl/imx-ssi.c                            |   2 +
 sound/soc/generic/simple-card.c                    | 220 +++++++++++++----=
----
 sound/soc/sh/rcar/src.c                            |  18 +-
 sound/soc/soc-core.c                               |  17 +-
 sound/soc/tegra/tegra20_ac97.c                     |  15 +-
 sound/soc/tegra/tegra20_ac97.h                     |   1 -
 sound/soc/tegra/tegra_wm9712.c                     |  17 +-
 tools/perf/bench/numa.c                            |   1 +
 tools/perf/builtin-bench.c                         |   2 +-
 125 files changed, 1152 insertions(+), 840 deletions(-)

--j1Wwy33+dU2Jf0xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOUQjAAoJELSic+t+oim98GoP/14YQe2trLRngE/n6gMowrn8
ElgEhrqJA5+Gzz9d86N4ounXlFtLPPGNqjOwvrJijfyHUJmgQxx/ViaJxTN/AHR7
7HngTufDEsrTEf3ZAPDaKcA5fQZRkw6KhxPLalu2h9lusCTIjYjsbPTqlz3TZd0Y
AhoCDYhIb4Hulh+3j9OwMj6iU+6+y7XJn5FT05xzQNwn9Rtu5ygVoHNMqwmz/oJ6
6imhGQ7x0bWLeK31AH+ge8tjlI4tndgKshQXtf1Hpxiqg1G2fSr3lMe7fQ5atbzz
mj83Qv+6LDCIE4A10FLmE7tX0RUJExg5vrX8G25cNEqj5t0Hpr5OmErjFlXfBIy2
XCs9nON80AHmBy4XzEg2mDt/WV//OXecsWQDZ4hyJZ5ccuifYpDfWxrB6TTPZYn8
CxPCO60jRJ5ok/XlQJqZjW6jt2jp/yj2w3C/ZnkkK0zltaFAXbv1hy1cynKgNtxU
8HbmvPn7L5kSGhhqpsPxlrJaR9QLEy16TQQxtlq91ad0gIRXVa/iip7yPimbgYaj
DR467/4OaxXQUAX2/GUFv+54guWbSUfI12o6QZt2Y27f7TvUBZF3GGvtXSY+ph7m
gtPmFUiCT9rAJJBlVLhVm8z6ItWobgemHfpi4YlxN4nUGJ8tGbD2XRjIOQpEQvUH
Sw22WUYwSv2E1Qf2lXJR
=hpu8
-----END PGP SIGNATURE-----

--j1Wwy33+dU2Jf0xa--

--===============1597985138614728842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1597985138614728842==--
