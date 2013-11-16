From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.13
Date: Sat, 16 Nov 2013 09:51:37 +0000
Message-ID: <20131116095137.GE15393@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1087136439649381960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC9D262632
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 10:51:44 +0100 (CET)
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


--===============1087136439649381960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a894bd7fb539d671149fea9420c94c0fbe6baf7a:

  ASoC: generic-dmaengine-pcm: Clear slave_config memory (2013-11-07 11:35:30 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-4

for you to fetch changes up to a190f7867e1830a2d4c890c00b27465b863f5f59:

  Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus (2013-11-15 10:20:16 +0000)

The diffstat is inflated by some of the branches being based on v3.12.
For the next release cycle I think I'm going to start basing most things
on -rc1 to cut down on this.

----------------------------------------------------------------

ASoC: Fixes for v3.13

A few fixes in drivers, the i.MX and wm8962 fixes are for a pretty nasty
issues for users of those drivers if they run into them.

----------------------------------------------------------------
Brian Austin (1):
      ASoC: cs42l52: Correct MIC CTL mask

Charles Keepax (1):
      ASoC: wm8997: Correct typo in ISRC mux routes

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/blackfin' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dma' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus

Nicolin Chen (1):
      ASoC: wm8962: Turn on regcache_cache_only before disabling regulator

Oskar Schirmer (1):
      ASoC: fsl: imx-pcm-fiq: omit fiq counter to avoid harm in unbalanced situations

Richard Fitzgerald (1):
      ASoC: arizona: Fix typo in name of EQ coefficient controls

Takashi Iwai (1):
      ASoC: blackfin: Fix missing break

 Documentation/ABI/stable/sysfs-bus-usb             |   8 +-
 Documentation/ABI/testing/sysfs-devices-power      |  32 +-
 Documentation/ABI/testing/sysfs-power              |  22 +-
 Documentation/acpi/dsdt-override.txt               |   2 +-
 Documentation/connector/ucon.c                     |   2 +-
 Documentation/devicetree/bindings/memory.txt       | 168 ------
 .../devicetree/bindings/sound/cs42l73.txt          |  22 +
 .../bindings/sound/davinci-evm-audio.txt           |  42 ++
 .../bindings/sound/davinci-mcasp-audio.txt         |  41 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |  26 +
 .../devicetree/bindings/sound/tpa6130a2.txt        |  27 +
 Documentation/sound/alsa/soc/DPCM.txt              | 380 +++++++++++++
 Documentation/sound/alsa/soc/codec.txt             |  46 +-
 Documentation/sound/alsa/soc/dapm.txt              |  71 ++-
 Documentation/sound/alsa/soc/machine.txt           |   6 +-
 Documentation/sound/alsa/soc/platform.txt          |  19 +-
 MAINTAINERS                                        | 171 +++---
 Makefile                                           |   2 +-
 arch/arc/mm/fault.c                                |   6 +-
 arch/arm/boot/dts/integratorcp.dts                 |   9 +-
 arch/arm/common/mcpm_entry.c                       |   6 +-
 arch/arm/common/sharpsl_param.c                    |   5 +-
 arch/arm/include/asm/Kbuild                        |   1 -
 arch/arm/include/asm/mcpm.h                        |  14 +-
 arch/arm/include/asm/syscall.h                     |   6 +
 arch/arm/kernel/head.S                             |  21 +-
 arch/arm/mm/dma-mapping.c                          |  43 +-
 arch/arm/mm/init.c                                 |   3 -
 arch/arm/net/bpf_jit_32.c                          |   1 +
 arch/mips/kernel/perf_event_mipsxx.c               |   4 +-
 arch/mips/mti-malta/malta-int.c                    |   9 +-
 arch/mips/ralink/timer.c                           |   2 +-
 arch/parisc/configs/712_defconfig                  |   2 +
 arch/parisc/configs/a500_defconfig                 |   2 +
 arch/parisc/configs/b180_defconfig                 |   3 +
 arch/parisc/configs/c3000_defconfig                |   3 +
 arch/parisc/configs/c8000_defconfig                |   2 +
 arch/parisc/configs/default_defconfig              |   2 +
 arch/parisc/kernel/cache.c                         |   1 -
 arch/parisc/kernel/head.S                          |   4 +
 arch/powerpc/net/bpf_jit_comp.c                    |   1 +
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/include/asm/timex.h                      |  28 +-
 arch/s390/kernel/compat_signal.c                   |   4 +-
 arch/s390/kernel/debug.c                           |   2 +-
 arch/s390/kvm/interrupt.c                          |   6 +-
 arch/s390/lib/delay.c                              |  14 +-
 arch/s390/net/bpf_jit_comp.c                       |   4 +-
 arch/sparc/net/bpf_jit_comp.c                      |   1 +
 arch/um/kernel/exitcode.c                          |   4 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/percpu.h                      |   3 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   2 +-
 arch/x86/kernel/cpu/perf_event.c                   |   6 +-
 arch/x86/kernel/kvm.c                              |  19 +-
 arch/x86/kernel/nmi.c                              |   4 +-
 arch/x86/net/bpf_jit_comp.c                        |  18 +-
 arch/x86/xen/smp.c                                 |   9 +
 arch/xtensa/kernel/entry.S                         |  49 +-
 arch/xtensa/kernel/signal.c                        |   2 +-
 arch/xtensa/platforms/iss/network.c                |   3 +-
 block/partitions/efi.c                             |   7 +-
 drivers/acpi/Kconfig                               |   8 +-
 drivers/acpi/device_pm.c                           |  56 --
 drivers/acpi/power.c                               | 104 +---
 drivers/acpi/scan.c                                |   1 -
 drivers/ata/ahci.c                                 |   2 +-
 drivers/ata/ahci_platform.c                        |   2 +-
 drivers/ata/libahci.c                              |  10 +-
 drivers/ata/libata-acpi.c                          |  14 -
 drivers/ata/libata-eh.c                            |   6 +-
 drivers/ata/libata-scsi.c                          |   3 -
 drivers/ata/libata.h                               |   4 -
 drivers/ata/pata_isapnp.c                          |   2 +-
 drivers/base/memory.c                              |   7 +-
 drivers/base/regmap/internal.h                     |   8 +-
 drivers/base/regmap/regcache.c                     |   3 +-
 drivers/base/regmap/regmap.c                       | 294 ++++++++--
 drivers/char/tpm/xen-tpmfront.c                    |   1 +
 drivers/clk/clk-nomadik.c                          |  21 +
 drivers/clk/mvebu/armada-370.c                     |   4 +-
 drivers/clk/socfpga/clk.c                          |   2 +-
 drivers/clk/versatile/clk-icst.c                   |   2 +-
 drivers/connector/cn_proc.c                        |  18 +
 drivers/connector/connector.c                      |   9 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   8 +-
 drivers/cpufreq/intel_pstate.c                     |  52 +-
 drivers/cpufreq/s3c64xx-cpufreq.c                  |   2 +-
 drivers/dma/edma.c                                 |   2 +
 drivers/gpio/gpio-lynxpoint.c                      |   5 +-
 drivers/gpio/gpiolib.c                             |   6 +-
 drivers/gpu/drm/drm_drv.c                          |  11 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   5 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   8 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                | 109 +++-
 drivers/gpu/drm/i915/i915_reg.h                    |   6 +
 drivers/gpu/drm/i915/intel_crt.c                   |  28 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  21 +-
 drivers/gpu/drm/i915/intel_display.c               | 131 +++--
 drivers/gpu/drm/i915/intel_dp.c                    |  20 +
 drivers/gpu/drm/i915/intel_drv.h                   |   2 +
 drivers/gpu/drm/i915/intel_lvds.c                  |  16 +
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |  54 +-
 drivers/gpu/drm/radeon/cik.c                       |   4 +
 drivers/gpu/drm/radeon/dce6_afmt.c                 |   3 +
 drivers/gpu/drm/radeon/evergreen_hdmi.c            |   4 +
 drivers/gpu/drm/radeon/kv_dpm.c                    |   2 +-
 drivers/gpu/drm/radeon/ni.c                        |   1 +
 drivers/gpu/drm/radeon/r600.c                      |   1 +
 drivers/gpu/drm/radeon/r600_hdmi.c                 |   3 +
 drivers/gpu/drm/radeon/radeon.h                    |   4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  33 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |   4 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   3 +-
 drivers/gpu/drm/radeon/si.c                        |   1 +
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   2 +-
 drivers/hid/hid-core.c                             |  12 +-
 drivers/hid/hid-ids.h                              |   6 +
 drivers/hid/hid-input.c                            |  13 +-
 drivers/hid/hid-wiimote-core.c                     |   5 +-
 drivers/hid/usbhid/hid-quirks.c                    |   3 +
 drivers/iio/frequency/adf4350.c                    |   6 +-
 drivers/iio/industrialio-buffer.c                  |   3 +
 drivers/infiniband/Kconfig                         |  11 +
 drivers/infiniband/core/uverbs.h                   |   2 +
 drivers/infiniband/core/uverbs_cmd.c               |   4 +
 drivers/infiniband/core/uverbs_main.c              |   6 +
 drivers/infiniband/hw/amso1100/c2_ae.c             |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |   2 +
 drivers/infiniband/hw/mlx5/main.c                  |  16 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  70 ++-
 drivers/infiniband/hw/mlx5/qp.c                    |  80 +--
 drivers/infiniband/hw/mlx5/srq.c                   |   4 +-
 drivers/infiniband/hw/mthca/mthca_eq.c             |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   6 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +-
 drivers/input/input.c                              |  10 +-
 drivers/input/keyboard/pxa27x_keypad.c             |  11 +-
 drivers/input/misc/cm109.c                         |  14 +-
 drivers/input/mouse/alps.c                         |   1 +
 drivers/input/serio/i8042.c                        |  23 +-
 drivers/input/tablet/wacom_sys.c                   |   4 +
 drivers/input/tablet/wacom_wac.c                   |   8 +
 drivers/md/bcache/request.c                        |   2 +-
 drivers/md/dm-snap-persistent.c                    |  18 +-
 drivers/md/md.c                                    |   5 +-
 drivers/md/raid1.c                                 |   1 +
 drivers/md/raid10.c                                |   1 +
 drivers/md/raid5.c                                 |  20 +
 drivers/media/dvb-frontends/tda10071.c             |   9 +-
 drivers/media/i2c/ad9389b.c                        |  15 +-
 drivers/media/i2c/adv7511.c                        |  18 +-
 drivers/media/i2c/adv7842.c                        |  30 +-
 drivers/media/i2c/ths8200.c                        |  12 +-
 drivers/media/pci/saa7134/saa7134-video.c          |   1 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |   1 +
 drivers/media/platform/sh_vou.c                    |   2 +-
 drivers/media/platform/soc_camera/mx3_camera.c     |   5 +-
 drivers/media/tuners/e4000.c                       |   3 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |   7 +
 drivers/media/usb/uvc/uvc_driver.c                 |  18 +
 drivers/media/v4l2-core/videobuf2-core.c           |   4 +-
 drivers/media/v4l2-core/videobuf2-dma-contig.c     |  87 ++-
 drivers/mfd/mc13xxx-core.c                         |   5 -
 drivers/mfd/mc13xxx-spi.c                          |   5 +
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   2 +-
 drivers/mtd/nand/pxa3xx_nand.c                     |   7 +-
 drivers/net/can/at91_can.c                         |   4 +-
 drivers/net/can/dev.c                              |  10 +-
 drivers/net/can/flexcan.c                          |  14 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  15 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  40 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h   |  38 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 388 +++++++------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |  29 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c  |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |   2 +-
 drivers/net/ethernet/calxeda/xgmac.c               |  23 +-
 drivers/net/ethernet/davicom/dm9000.c              |  56 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   3 +-
 drivers/net/ethernet/freescale/gianfar.c           |  38 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   2 +
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   7 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  41 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  28 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  21 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |  16 +-
 drivers/net/ethernet/moxa/moxart_ether.c           |  22 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |  13 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   4 +
 drivers/net/ethernet/sfc/ef10.c                    |  87 ++-
 drivers/net/ethernet/sfc/mcdi.c                    |  18 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h               |  56 +-
 drivers/net/ethernet/sfc/nic.c                     |   9 +-
 drivers/net/ethernet/sfc/nic.h                     |  12 +
 drivers/net/ethernet/smsc/smc91x.h                 |   6 +-
 drivers/net/ethernet/ti/cpsw.c                     |  19 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   3 +-
 drivers/net/hamradio/yam.c                         |   1 -
 drivers/net/ieee802154/mrf24j40.c                  |  31 +-
 drivers/net/tun.c                                  |   8 +-
 drivers/net/usb/ax88179_178a.c                     |  23 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/usbnet.c                           |   4 +-
 drivers/net/virtio_net.c                           |  14 +-
 drivers/net/wan/farsync.c                          |   1 +
 drivers/net/wan/wanxl.c                            |   1 +
 drivers/net/wireless/ath/ath9k/main.c              |  23 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   9 +-
 drivers/net/wireless/cw1200/cw1200_spi.c           |   2 +
 drivers/net/wireless/iwlwifi/iwl-6000.c            |   6 +
 drivers/net/wireless/iwlwifi/iwl-config.h          |   1 +
 drivers/net/wireless/iwlwifi/iwl-trans.h           |   6 +-
 drivers/net/wireless/iwlwifi/mvm/power.c           |   5 +-
 drivers/net/wireless/iwlwifi/mvm/scan.c            |  12 +-
 drivers/net/wireless/iwlwifi/pcie/drv.c            |  42 ++
 drivers/net/wireless/iwlwifi/pcie/trans.c          |   8 +-
 drivers/net/wireless/iwlwifi/pcie/tx.c             |   2 +
 drivers/net/wireless/mwifiex/join.c                |  10 +-
 drivers/net/wireless/mwifiex/main.c                |   6 +-
 drivers/net/wireless/mwifiex/sta_event.c           |   3 +-
 drivers/net/wireless/rt2x00/rt2x00pci.c            |   9 +-
 drivers/net/wireless/rtlwifi/rtl8192cu/trx.c       |   3 +-
 drivers/net/xen-netback/xenbus.c                   |   4 +
 drivers/of/Kconfig                                 |   6 -
 drivers/of/Makefile                                |   1 -
 drivers/of/base.c                                  |   4 +-
 drivers/of/fdt.c                                   |  12 -
 drivers/of/of_reserved_mem.c                       | 173 ------
 drivers/of/platform.c                              |   4 -
 drivers/pci/hotplug/acpiphp_glue.c                 |  14 +-
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/sony-laptop.c                 |  26 +-
 drivers/s390/block/dasd_eckd.c                     |  98 +++-
 drivers/s390/char/sclp.c                           |   4 +-
 drivers/s390/char/vmlogrdr.c                       |   2 +-
 drivers/s390/cio/cio.c                             |   4 +-
 drivers/s390/cio/qdio_main.c                       |  10 +-
 drivers/scsi/BusLogic.c                            |  16 +-
 drivers/scsi/aacraid/linit.c                       |   2 +
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   9 +
 drivers/scsi/sd.c                                  |   2 +-
 drivers/scsi/sg.c                                  | 176 +++---
 drivers/staging/bcm/Bcmchar.c                      |   1 +
 drivers/staging/media/msi3101/Kconfig              |   1 +
 drivers/staging/media/msi3101/sdr-msi3101.c        |  10 +-
 drivers/staging/ozwpan/ozcdev.c                    |   3 +
 drivers/staging/sb105x/sb_pci_mp.c                 |   2 +-
 drivers/staging/wlags49_h2/wl_priv.c               |   9 +-
 drivers/target/target_core_pscsi.c                 |   8 +-
 drivers/target/target_core_sbc.c                   |   5 +
 drivers/target/target_core_xcopy.c                 |  53 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |   2 -
 drivers/thermal/samsung/exynos_tmu.c               |  12 +-
 drivers/thermal/samsung/exynos_tmu.h               |   7 +-
 drivers/thermal/samsung/exynos_tmu_data.c          |  30 +-
 drivers/thermal/samsung/exynos_tmu_data.h          |  13 +-
 drivers/thermal/thermal_hwmon.c                    |   2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   1 +
 drivers/thermal/x86_pkg_temp_thermal.c             |  14 +-
 drivers/tty/serial/atmel_serial.c                  |   9 +-
 drivers/tty/serial/imx.c                           |   3 -
 drivers/tty/serial/vt8500_serial.c                 |   5 +-
 drivers/uio/uio.c                                  |  17 +-
 drivers/usb/chipidea/host.c                        |   6 +-
 drivers/usb/core/quirks.c                          |   6 +
 drivers/usb/host/pci-quirks.c                      |   4 +-
 drivers/usb/host/xhci-hub.c                        |  26 -
 drivers/usb/host/xhci-pci.c                        |  25 +
 drivers/usb/host/xhci.c                            |  14 +-
 drivers/usb/host/xhci.h                            |   2 +
 drivers/usb/misc/Kconfig                           |   2 +-
 drivers/usb/musb/musb_core.c                       |  46 ++
 drivers/usb/musb/musb_core.h                       |   1 +
 drivers/usb/musb/musb_gadget.c                     |   3 +
 drivers/usb/musb/musb_virthub.c                    |  46 --
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        | 225 +++++++-
 drivers/usb/serial/pl2303.c                        | 274 ++-------
 drivers/usb/serial/ti_usb_3410_5052.c              |   1 +
 drivers/usb/storage/scsiglue.c                     |   5 +-
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/vfio/vfio_iommu_type1.c                    |  40 +-
 drivers/vhost/scsi.c                               |   2 +-
 drivers/video/au1100fb.c                           |  26 +-
 drivers/video/au1200fb.c                           |  23 +-
 drivers/w1/w1.c                                    |   6 +
 fs/btrfs/inode.c                                   |   1 +
 fs/buffer.c                                        |  14 +-
 fs/cifs/cifsfs.c                                   |   6 +-
 fs/cifs/cifspdu.h                                  |  31 +-
 fs/cifs/cifssmb.c                                  |  40 +-
 fs/cifs/netmisc.c                                  |   4 +-
 fs/cifs/sess.c                                     |   4 +-
 fs/cifs/smb2pdu.c                                  |   6 +
 fs/cifs/smbfsctl.h                                 |  14 +
 fs/cifs/transport.c                                |   9 +-
 fs/dcache.c                                        |  20 +-
 fs/ecryptfs/crypto.c                               |   2 +-
 fs/ecryptfs/keystore.c                             |   3 +-
 fs/eventpoll.c                                     |   4 +-
 fs/ext3/namei.c                                    |   5 +-
 fs/ext4/namei.c                                    |   5 +-
 fs/file_table.c                                    |   4 +-
 fs/jfs/jfs_inode.c                                 |   3 +-
 fs/namei.c                                         |   3 +-
 fs/proc/inode.c                                    |  10 +-
 fs/proc/task_mmu.c                                 |   4 +-
 fs/select.c                                        |   3 +-
 fs/seq_file.c                                      |   2 +
 include/acpi/acpi_bus.h                            |   7 -
 include/linux/filter.h                             |  15 +-
 include/linux/ipc_namespace.h                      |   6 +-
 include/linux/memcontrol.h                         |  50 +-
 include/linux/mfd/mc13xxx.h                        |   7 +
 include/linux/mlx5/device.h                        |   4 +-
 include/linux/mlx5/driver.h                        |   6 +-
 include/linux/netdevice.h                          |   5 +-
 include/linux/of_reserved_mem.h                    |  14 -
 include/linux/percpu.h                             |   8 +-
 include/linux/platform_data/davinci_asp.h          |   2 +
 include/linux/regmap.h                             |  44 ++
 include/linux/sched.h                              |   7 +-
 include/linux/usb/usb_phy_gen_xceiv.h              |   2 +-
 include/linux/usb_usual.h                          |   4 +-
 include/linux/yam.h                                |   2 +-
 include/net/cipso_ipv4.h                           |   6 +-
 include/net/dst.h                                  |  12 +
 include/net/ip6_route.h                            |   6 +-
 include/net/mac802154.h                            |   2 +-
 include/net/sock.h                                 |   6 +-
 include/sound/cs42l52.h                            |   2 +
 include/sound/cs42l73.h                            |  22 +
 include/sound/rcar_snd.h                           |   2 +-
 include/sound/soc-dai.h                            |  10 +
 include/sound/soc-dapm.h                           |   4 +
 include/sound/soc.h                                | 100 ++--
 include/trace/events/asoc.h                        |   1 +
 include/trace/events/target.h                      |   4 +-
 include/uapi/drm/drm_mode.h                        |   2 +
 include/uapi/linux/perf_event.h                    |  12 +-
 include/uapi/linux/tc_act/Kbuild                   |   1 +
 include/{ => uapi}/linux/tc_act/tc_defact.h        |   2 +-
 include/uapi/rdma/ib_user_verbs.h                  |   6 +
 ipc/ipc_sysctl.c                                   |  20 +-
 ipc/sem.c                                          |  42 +-
 ipc/util.c                                         |  27 +-
 kernel/cgroup.c                                    |  14 +-
 kernel/events/core.c                               |   4 +
 kernel/events/ring_buffer.c                        |  31 +-
 kernel/mutex.c                                     |  32 +-
 kernel/power/hibernate.c                           |   2 +-
 kernel/time/clockevents.c                          |  65 ++-
 lib/Kconfig.debug                                  |   2 +-
 lib/percpu-refcount.c                              |   3 +
 lib/scatterlist.c                                  |   3 +-
 mm/filemap.c                                       |  11 +-
 mm/huge_memory.c                                   |  80 ++-
 mm/hugetlb.c                                       |  17 +-
 mm/list_lru.c                                      |   3 +-
 mm/memcontrol.c                                    | 196 +++----
 mm/memory.c                                        |  73 ++-
 mm/migrate.c                                       |  21 +-
 mm/mprotect.c                                      |   9 +-
 mm/mremap.c                                        |   5 +-
 mm/oom_kill.c                                      |   2 +-
 mm/page-writeback.c                                |  10 +-
 mm/pagewalk.c                                      |   2 +-
 mm/slab_common.c                                   |   2 +
 mm/swapfile.c                                      |   4 +-
 mm/vmscan.c                                        |   1 +
 mm/zswap.c                                         |   4 +
 net/8021q/vlan_netlink.c                           |   2 +-
 net/batman-adv/main.c                              |   5 +-
 net/batman-adv/network-coding.c                    |  28 +-
 net/batman-adv/network-coding.h                    |  14 +-
 net/bridge/br_fdb.c                                |   4 +-
 net/bridge/br_mdb.c                                |   2 +-
 net/bridge/br_multicast.c                          |  38 +-
 net/bridge/br_netlink.c                            |   2 +-
 net/bridge/br_private.h                            |   5 +-
 net/bridge/br_stp_if.c                             |   2 +-
 net/bridge/br_vlan.c                               | 125 +++--
 net/compat.c                                       |   2 +
 net/core/dev.c                                     |   3 +-
 net/core/filter.c                                  |   8 +-
 net/core/secure_seq.c                              |   2 +
 net/core/sock.c                                    |   1 +
 net/ieee802154/6lowpan.c                           |   5 +
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/ip_output.c                               |  13 +-
 net/ipv4/ip_vti.c                                  |  14 +-
 net/ipv4/route.c                                   |   2 +-
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_output.c                              |  14 +-
 net/ipv4/xfrm4_policy.c                            |   1 +
 net/ipv6/ah6.c                                     |   3 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/inet6_hashtables.c                        |   2 +-
 net/ipv6/ip6_gre.c                                 |   6 +-
 net/ipv6/ip6_output.c                              |  29 +-
 net/ipv6/ip6_tunnel.c                              |  12 +-
 net/ipv6/ipcomp6.c                                 |   3 +-
 net/ipv6/route.c                                   |  46 +-
 net/ipv6/udp.c                                     |   5 +-
 net/ipv6/xfrm6_policy.c                            |   1 +
 net/key/af_key.c                                   |   3 +-
 net/l2tp/l2tp_core.c                               |  36 +-
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_ppp.c                                |   4 +
 net/mac80211/cfg.c                                 |   2 +-
 net/mac80211/ieee80211_i.h                         |   3 +
 net/mac80211/offchannel.c                          |   2 +
 net/mac80211/rx.c                                  |   3 +
 net/mac80211/scan.c                                |  19 +
 net/mac80211/status.c                              |   3 +
 net/mac80211/tx.c                                  |   3 +-
 net/mac80211/util.c                                |   9 +-
 net/netfilter/nf_conntrack_h323_main.c             |   4 +-
 net/sched/sch_fq.c                                 |  22 +-
 net/sched/sch_netem.c                              |  17 +
 net/sctp/output.c                                  |   3 +-
 net/socket.c                                       |  24 +-
 net/unix/af_unix.c                                 |  10 +
 net/unix/diag.c                                    |   1 +
 net/wireless/core.c                                |  23 +-
 net/wireless/core.h                                |   3 +
 net/wireless/ibss.c                                |   3 +
 net/wireless/nl80211.c                             |   4 +-
 net/wireless/radiotap.c                            |   7 +-
 net/xfrm/xfrm_policy.c                             |  28 +-
 net/xfrm/xfrm_replay.c                             |  54 +-
 net/xfrm/xfrm_user.c                               |   5 +-
 scripts/kallsyms.c                                 |  12 +-
 scripts/link-vmlinux.sh                            |   2 +
 security/apparmor/apparmorfs.c                     |   4 +-
 security/apparmor/policy.c                         |   1 +
 sound/arm/pxa2xx-ac97-lib.c                        |  27 +-
 sound/core/pcm.c                                   |   4 +
 sound/pci/hda/hda_codec.c                          |   4 +-
 sound/pci/hda/hda_generic.c                        |   6 +-
 sound/pci/hda/patch_analog.c                       |  18 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/pci/rme9652/hdsp.c                           |   1 +
 sound/soc/Makefile                                 |   2 +-
 sound/soc/atmel/atmel-pcm.c                        |   2 +-
 sound/soc/atmel/atmel_wm8904.c                     |   8 -
 sound/soc/atmel/sam9g20_wm8731.c                   |   1 +
 sound/soc/blackfin/bf5xx-i2s.c                     |   1 +
 sound/soc/cirrus/Kconfig                           |   2 +-
 sound/soc/codecs/88pm860x-codec.c                  |  75 +--
 sound/soc/codecs/88pm860x-codec.h                  | 117 ++--
 sound/soc/codecs/ab8500-codec.c                    |  92 ++-
 sound/soc/codecs/adau1373.c                        | 298 ++++++++--
 sound/soc/codecs/adav80x.c                         | 147 +++--
 sound/soc/codecs/ak4104.c                          |  11 +-
 sound/soc/codecs/ak4642.c                          |   4 +-
 sound/soc/codecs/arizona.c                         |  23 +-
 sound/soc/codecs/cq93vc.c                          |  46 +-
 sound/soc/codecs/cs4271.c                          |   1 +
 sound/soc/codecs/cs42l52.c                         |  93 +--
 sound/soc/codecs/cs42l52.h                         |   4 +-
 sound/soc/codecs/cs42l73.c                         | 114 ++--
 sound/soc/codecs/cs42l73.h                         | 105 ++--
 sound/soc/codecs/max98088.c                        | 624 +++++++++------------
 sound/soc/codecs/max98095.c                        | 466 ++++++---------
 sound/soc/codecs/max9850.c                         |  39 +-
 sound/soc/codecs/mc13783.c                         | 135 +++--
 sound/soc/codecs/ml26124.c                         |   2 +
 sound/soc/codecs/pcm1681.c                         |   3 +-
 sound/soc/codecs/pcm1792a.c                        |   3 +-
 sound/soc/codecs/rt5640.c                          |  31 +-
 sound/soc/codecs/si476x.c                          |  64 +--
 sound/soc/codecs/sn95031.c                         |  35 +-
 sound/soc/codecs/tas5086.c                         | 171 ++++--
 sound/soc/codecs/tlv320aic23.c                     |  84 ++-
 sound/soc/codecs/tlv320aic26.c                     | 139 +----
 sound/soc/codecs/tlv320aic26.h                     |   5 +-
 sound/soc/codecs/tlv320aic32x4.c                   | 101 +---
 sound/soc/codecs/tlv320aic3x.c                     | 238 ++++----
 sound/soc/codecs/tpa6130a2.c                       |  32 +-
 sound/soc/codecs/twl4030.c                         |  80 ++-
 sound/soc/codecs/twl6040.c                         |  26 +-
 sound/soc/codecs/wm0010.c                          |   8 +-
 sound/soc/codecs/wm5102.c                          |   8 +-
 sound/soc/codecs/wm5110.c                          |  20 +-
 sound/soc/codecs/wm8400.c                          |  95 +---
 sound/soc/codecs/wm8962.c                          | 228 ++++----
 sound/soc/codecs/wm8996.c                          |   2 +
 sound/soc/codecs/wm8997.c                          |  10 +-
 sound/soc/codecs/wm_adsp.c                         |  27 +-
 sound/soc/codecs/wm_hubs.c                         |   1 +
 sound/soc/davinci/Kconfig                          |  18 +-
 sound/soc/davinci/Makefile                         |   1 +
 sound/soc/davinci/davinci-evm.c                    | 188 ++++++-
 sound/soc/davinci/davinci-mcasp.c                  | 169 ++++--
 sound/soc/davinci/davinci-mcasp.h                  |  12 +
 sound/soc/fsl/eukrea-tlv320.c                      |  15 +-
 sound/soc/fsl/fsl_spdif.c                          |  22 +-
 sound/soc/fsl/fsl_ssi.c                            |  22 +-
 sound/soc/fsl/imx-audmux.c                         |   9 +-
 sound/soc/fsl/imx-mc13783.c                        |   3 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |  29 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   4 +-
 sound/soc/fsl/imx-spdif.c                          |   4 +-
 sound/soc/fsl/imx-ssi.c                            |  26 +-
 sound/soc/fsl/imx-ssi.h                            |   2 +
 sound/soc/fsl/imx-wm8962.c                         |   4 +-
 sound/soc/generic/simple-card.c                    |   5 +
 sound/soc/kirkwood/kirkwood-dma.c                  |   6 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  | 108 +++-
 sound/soc/kirkwood/kirkwood-openrd.c               |   2 +-
 sound/soc/kirkwood/kirkwood-t5325.c                |   2 +-
 sound/soc/kirkwood/kirkwood.h                      |   4 +-
 sound/soc/mid-x86/mfld_machine.c                   |  10 +-
 sound/soc/mxs/mxs-saif.c                           |  42 +-
 sound/soc/mxs/mxs-saif.h                           |   5 +
 sound/soc/mxs/mxs-sgtl5000.c                       |  20 +-
 sound/soc/omap/Kconfig                             |   4 +-
 sound/soc/omap/omap-mcpdm.c                        |  12 +-
 sound/soc/omap/omap-twl4030.c                      |   5 +-
 sound/soc/pxa/brownstone.c                         |   1 +
 sound/soc/pxa/corgi.c                              |   1 +
 sound/soc/pxa/e740_wm9705.c                        |   1 +
 sound/soc/pxa/e750_wm9705.c                        |   1 +
 sound/soc/pxa/e800_wm9712.c                        |   1 +
 sound/soc/pxa/imote2.c                             |   1 +
 sound/soc/pxa/mioa701_wm9713.c                     |   1 +
 sound/soc/pxa/mmp-sspa.c                           |   5 +-
 sound/soc/pxa/palm27x.c                            |   1 +
 sound/soc/pxa/poodle.c                             |   1 +
 sound/soc/pxa/pxa2xx-ac97.c                        |  56 +-
 sound/soc/pxa/tosa.c                               |   1 +
 sound/soc/pxa/ttc-dkb.c                            |   1 +
 sound/soc/samsung/bells.c                          |   1 +
 sound/soc/samsung/i2s.c                            |  16 +-
 sound/soc/samsung/smdk_wm8994.c                    |  14 +-
 sound/soc/sh/rcar/adg.c                            |  11 +-
 sound/soc/sh/rcar/core.c                           |  81 +--
 sound/soc/sh/rcar/gen.c                            | 261 +++++----
 sound/soc/sh/rcar/rsnd.h                           |   9 +-
 sound/soc/sh/rcar/scu.c                            |  12 +-
 sound/soc/sh/rcar/ssi.c                            |  52 +-
 sound/soc/soc-cache.c                              | 263 ++-------
 sound/soc/soc-core.c                               | 343 ++++++-----
 sound/soc/soc-dapm.c                               | 124 ++--
 sound/soc/soc-devres.c                             |  86 +++
 sound/soc/soc-io.c                                 |  26 -
 sound/soc/soc-jack.c                               |   7 +-
 sound/soc/soc-pcm.c                                |  60 +-
 sound/soc/soc-utils.c                              |   6 +-
 sound/soc/spear/spdif_in.c                         |  12 +-
 sound/soc/spear/spdif_out.c                        |  14 +-
 sound/soc/tegra/tegra30_ahub.c                     | 115 +++-
 sound/soc/tegra/tegra30_ahub.h                     |  38 +-
 sound/soc/tegra/tegra30_i2s.c                      |  51 +-
 sound/soc/tegra/tegra30_i2s.h                      |   7 +
 sound/soc/tegra/tegra_asoc_utils.c                 |   2 +
 sound/soc/tegra/tegra_asoc_utils.h                 |   1 +
 sound/usb/usx2y/us122l.c                           |   4 +-
 tools/perf/Documentation/perf-record.txt           |  14 +-
 tools/perf/Documentation/perf-top.txt              |  18 +-
 tools/perf/builtin-kvm.c                           |   7 +
 tools/perf/builtin-record.c                        |  73 ++-
 tools/perf/builtin-top.c                           |  33 +-
 tools/perf/builtin-trace.c                         |   8 +-
 tools/perf/tests/code-reading.c                    |   1 +
 tools/perf/tests/keep-tracking.c                   |   1 +
 tools/perf/tests/mmap-basic.c                      |   1 +
 tools/perf/tests/open-syscall-tp-fields.c          |   4 +-
 tools/perf/tests/perf-record.c                     |   2 +
 tools/perf/tests/perf-time-to-tsc.c                |   4 +-
 tools/perf/tests/sw-clock.c                        |   4 +-
 tools/perf/tests/task-exit.c                       |   6 +-
 tools/perf/ui/stdio/hist.c                         |   9 +-
 tools/perf/util/callchain.h                        |   3 +
 tools/perf/util/event.c                            |  32 +-
 tools/perf/util/evlist.c                           |  13 +-
 tools/perf/util/evlist.h                           |   2 +
 tools/perf/util/evsel.c                            |   1 -
 tools/perf/util/hist.h                             |  13 +
 tools/perf/util/probe-finder.c                     |   2 +-
 tools/perf/util/python.c                           |   2 +
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +-
 .../util/scripting-engines/trace-event-python.c    |  37 +-
 tools/testing/selftests/timers/posix_timers.c      |   2 +-
 virt/kvm/kvm_main.c                                |   2 +-
 599 files changed, 8499 insertions(+), 6158 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l73.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tpa6130a2.txt
 create mode 100644 Documentation/sound/alsa/soc/DPCM.txt
 delete mode 100644 drivers/of/of_reserved_mem.c
 delete mode 100644 include/linux/of_reserved_mem.h
 create mode 100644 include/sound/cs42l73.h
 rename include/{ => uapi}/linux/tc_act/tc_defact.h (75%)
 create mode 100644 sound/soc/soc-devres.c

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh0AmAAoJELSic+t+oim9g6MQAIGUefmPQa+StI5qWDT+IqrR
Xe7B8/roKLIoguYQLFGcAjFld9Ujq1/ddErONNnYKnOgVoifmrrrPx3XHQIqZd7Q
JOc/BKktkw1p2WPr0oPpKjjSAlJpgngUy0UB2peD29iCuAu9zhUqInIDcohF0RuP
E9vagoZt5Epo9HvtK90UruB8Ngj1VRp7SZolEYy94IGTcsFHMm0GsK0Av8gr5v0N
B0/DM75mHj7jl3vOyen9vxkXO0mX0K1hgYJewFCkV8yolkNYnGM6cU4zWQFD5JPC
1gFK3aLh5RN6aenbbuekPnZEVt6r3WUZUO1GIiAqgusZ6+EY/9xUF6WS3+EPYYzl
/q1Goc14O9OAp+CqtuDiwCpm+k2rg3stvZZMF+Cfyjy2Z5d3GjfwyEWyMNXR6MRH
X/gwQzQfxKGCbx8Sp/Neg3hiuP8t0dGBtoSGhh/ONOkn5dnRSpihznICzIk8Q0w4
beIdSqfdPYhfZ9K6I5/dZ8Qj9m2FhYwtNW9w15c2GJHW2ZwIy17biPXTH2jyiQ1h
Pityo6I/doDYGrywfhI4XXCWfUU0niDXHIUbkTk+bjCqMxQWMvmBpXASbzpuQR83
QWpedFDm4PmiqCsZt/yMpdRhERU34wUu24r3BnUF9mAmJakpsMptUNOb9lvKgWF1
tL00qMKmHebsFBYpLHtB
=o8KM
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

--===============1087136439649381960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1087136439649381960==--
