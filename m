From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Wed, 16 May 2012 10:27:00 +0100
Message-ID: <20120516092659.GA24029@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0239073030103932275=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 820822451D
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 11:36:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0239073030103932275==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:

  Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.5

for you to fetch changes up to fe33d4c5e2b27a4b82aa479a58f2621eec103d1b:

  ASoC: don't flip master of DT-instantiated DAI links (2012-05-16 09:44:18 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.5

The big things here in framework terms are the first two, otherwise it's
just a large number of incremental and driver specific updates:

- Dynamic PCM support, allowing support for SoCs with internal routing
  through components with tight sequencing and formatting constraints
  within their internal paths or where there are multiple components
  connected with CPU managed DMA controllers inside the SoC.
- Greatly improved support for direct digital links between off-SoC
  devices, providing a much simpler way of connecting things like digital
  basebands to CODECs.
- Much more fine grained and robust locking, cleaning up some of the
  confusion that crept in with multi-component.
- CPU support for nVidia Tegra 30 I2S and audio hub controllers and
  ST-Ericsson MSP I2S controolers
- New CODEC drivers for Cirrus CS42L52, LAPIS Semiconductor ML26124, Texas
  Instruments LM49453.

There's also some regmap changes needed by the Tegra I2S driver.

----------------------------------------------------------------
Ashish Chavan (5):
      ASoC: da7210: Add support for spi regmap
      ASoC: da7210: Add support for PLL and SRM
      ASoC: da7210: Minor update for PLL and SRM
      ASoC: da7210: Minor bugfix for non pll slave mode
      ASoC: da7210: Minor improvements and a bugfix

Axel Lin (3):
      ASoC: alc5623: Convert to module_i2c_driver()
      ASoC: alc5632: Convert to module_i2c_driver()
      ASoC: alc5632: Convert to devm_regmap_init_i2c()

Brian Austin (6):
      ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV
      ASoC: core: Initialize err for snd_soc_put_volsw_sx
      ASoC: Add support for CS42L52 Codec
      ASoC: cs42l73: Convert to module_i2c_driver()
      ASoC: cs42l73: Remove Chip ID's from reg_default
      ASoC: cs42l73: Use DAPM routes to hook AIF widgets to DAI's

Dan Carpenter (1):
      ASoC: dapm: release lock on error paths

Fabio Estevam (6):
      ASoC: sgtl5000: Fix warning due to the lack of REGULATOR_CHANGE_VOLTAGE
      ASoC: wm9712: Fix build due to missing definition of "runtime"
      ASoC: ac97: Fix build due to removal of 'runtime' definition
      ASoC: wm9705: Fix build due to removal of 'runtime' definition
      ASoC: soc-dapm: Use '%llx' with 'u64' type.
      ASoC: core: Remove unused variable 'min'

H Hartley Sweeten (2):
      ASoC: ep93xx-ac97: use devm_* helpers to cleanup probe
      ASoC: ep93xx-i2s: use devm_* helpers to cleanup probe

Jesper Juhl (2):
      ASoC: wm8994: Don't test for NULL before release_firmware()
      ASoC: wm8994: Delete trailing whitespace from sound/soc/codecs/wm8994.c

Kristoffer KARLSSON (2):
      ASoC: core: Add signed multi register control
      ASoC: core: Add strobe control

Kuninori Morimoto (5):
      ASoC: add generic simple-card support
      ASoC: sh: fsi: use simple-card instead of fsi-ak4642
      ASoC: sh: fsi: use simple-card instead of fsi-hdmi
      ASoC: sh: fsi: use simple-card instead of fsi-da7210
      ASoC: sh: fsi: select simple-card on Kconfig

Kyung-Kwee Ryu (1):
      ASoC: wm8994: Make sure we disable FLL bypass when stopping the FLL

Lars-Peter Clausen (4):
      ASoC: bf5xx-ssm2602: Setup sysclock in init callback
      ASoC: SSM2602: Add sysclk based rate constraints
      ASoC: SSM2602: Remove driver specific version
      ASoC: SSM2602: Convert to direct regmap API usage

Liam Girdwood (19):
      ASoC: core: Add card mutex locking subclasses
      ASoC: dapm: Use DAPM mutex for DAPM ops instead of codec mutex
      ASoC: dapm: lock mixer & mux update power with DAPM mutex
      ASoC: core: Add platform DAI widget mapping
      ASoC: dapm: Add platform stream event support
      ASoC: core: Rename card mutex subclass to better align with usage
      ASoC: dapm: Rename dapm mutex subclass to better match usage
      ASoC: dapm: Add regulator member to struct dapm_widget
      ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex
      ASoC: dapm: Add API call to query valid DAPM paths
      ASoC: dapm: Fix x86_64 build warning.
      ASoC: dpcm: Add Dynamic PCM core operations.
      ASoC: dpcm: Add debugFS support for DPCM
      ASoC: dpcm: Add runtime dynamic route update
      ASoC: dpcm: Add API for DAI link substream and runtime lookup
      ASoC: dpcm: Add bespoke trigger()
      ASoC: pcm: Add pcm operation for pcm ioctl.
      ASoC: dpcm: Fixup debugFS for DPCM state.
      ASoC: core: Fix dai_link dereference.

M R Swami Reddy (3):
      ASoC: Support TI LM49453 Audio driver
      ASoC: MAINTAINERS: Add maintainer for TI LM49453 Audio codec driver
      ASoC: lm49453: fix build warnings

Maarten ter Huurne (1):
      ASoC: JZ4740: Replaced comma operators with semicolons.

Marc Reilly (2):
      regmap: Add support for device with 24 data bits.
      regmap: Use pad_bits and reg_bits when determining register format.

Mark Brown (78):
      ASoC: ak4641: Convert to module_i2c_driver()
      ASoC: ak4641: Push GPIO allocation out into the I2C probe
      ASoC: dapm: Only lock CODEC for I/O if not using regmap
      ASoC: wm5100: Convert to devm_regmap_init_i2c()
      ASoC: wm8994: Don't lock CODEC mutex to do DAPM sync
      ASoC: jack: Push locking for jacks down to the jack
      ASoC: core: Use driver core probe deferral
      ASoC: wm8962: Implement DSP2 configuration initialisation
      ASoC: wm8962: Add 3D enhancement support
      ASoC: wm8962: Add Direct-Form 1 filter support
      ASoC: wm8962: Add Dynamic Range Control support
      ASoC: wm8962: Add HD Bass and VSS coefficient configuration
      ASoC: wm8962: Add HPF coefficient configuration support
      ASoC: dapm: Remove bodges for no-widget CODECs
      ASoC: cs4270: Check that we can enable regulators on resume
      ASoC: wm8994: Don't allow reconfiguration of FLL when it provides SYSCLK
      ASoC: sgtl5000: Convert mic bias to a supply widget
      ASoC: dapm: Remove SND_SOC_DAPM_MICBIAS_E()
      ASoC: wm8994: Don't bother lowering clock dividers inside idle AIFs
      ASoC: max98095: Fix build failure
      ASoC: sgtl5000: Convert to module_i2c_driver()
      ASoC: dapm: Allow DAPM registers to be 31 bit
      ASoC: wm8994: Don't bother updating the jackdet mode needlessly
      ASoC: tlv320aic23: Remove driver-specific version number
      ASoC: codecs: Remove rtd->codec usage from CODEC drivers
      ASoC: wm8400: Use snd_soc_write() and snd_soc_read()
      Merge tag 'v3.4-rc2' into for-3.5
      ASoC: wm1250-ev1: Convert to module_i2c_driver
      ASoC: wm8994: Implement FLL bypass support
      ASoC: core: Return -ENOTSUPP instead of -EINVAL if mute is not supported
      ASoC: dapm: Allow DAI widgets to be routed through
      ASoC: core: Flip master for CODECs in the CPU slot of a CODEC<->CODEC link
      ASoC: core: Bind DAIs to CODECs at registration time
      ASoC: core: Support transparent CODEC<->CODEC DAI links
      ASoC: Merge tag 'v3.4-rc3' into for-3.5
      ASoC: Use dai_fmt in Speyside
      ASoC: wm8994: Keep AIF3 tristated when not in use
      ASoC: samsung: Hook up AIF2 to the CODEC on Littlemill
      ASoC: wm1250-ev1: Support stereo
      ASoC: wm1250-ev1: Support sample rate configuration
      ASoC: Update regmap access for WM5100 DSP control registers
      ASoC: wm8996: Put the microphone biases into bypass mode when idle
      ASoC: wm8994: Tune debounce rates for jack detect mode
      ASoC: wm8994: Allow rate configuration with custom mic callback
      ASoC: wm8994: Add trace showing wm8958_micd_set_rate()
      ASoC: dapm: Move CODEC<->CODEC params off stack
      ASoC: wm_hubs: Special case headphones for digital paths in more use cases
      ASoC: wm_hubs: Factor out class W management
      ASoC: wm_hubs: Enable class W for output mixer paths
      ASoC: cs42l52: Remove duplicate module exit code
      ASoC: wm8350: Remove check for clocks in trigger()
      ASoC: wm8350: Replace use of custom I/O with snd_soc_read()/write()
      ASoC: wm_hubs: Cache multiple DCS offsets
      ASoC: core: Allow DAIs to specify a base address
      ASoC: wm5100: Set the DAI base address in the DAI drivers
      ASoC: pcm: Fix DPCM for aux_devs
      ASoC: lowland: Convert to dai_fmt
      ASoC: lowland: Support digital link for WM9081
      ASoC: wm9081: Hook DAC up via DAPM rather than stream
      ASoC: rt5631: Convert to module_i2c_driver()
      ASoC: rt5631: Convert to direct regmap API usage
      ASoC: wm8994: Fix sparse warning due to use of 0 as NULL
      ASoC: wm8994: Add debounce to wm8994 mic detection
      ASoC: wm8994: Use regmap directly for wm8994_mic_work
      ASoC: cs42l52: Staticise non-exported symbols
      ASoC: ux500: Fix dependencies
      ASoC: ux500: Don't make the CPU I2S driver user selectable
      ASoC: pcm: Staticise non-exported functions
      ASoC: littlemill: Use a widget to keep track of AIF2 clocking
      ASoC: wm5100: Convert to module_i2c_driver()
      ASoC: wm8731: Convert to devm_ functions
      Merge tag 'v3.4-rc7' into for-3.5
      ASoC: lm49453: Staticise non-exported symbol lm45453_dai
      ASoC: lm49453: Fix author e-mail address
      ASoC: max98095: Single bit bitfields should be unsigned
      ASoC: wm8350: Don't use irq_base
      ASoC: tlv320aic3x: Remove unused, non-standard headset detection
      ASoC: wm8350: Remove direct usage of codec->control_data

Ola Lilja (1):
      ASoC: Ux500: Add MSP I2S-driver

Peter Ujfalusi (1):
      ASoC: twl6040: Remove HS/HF gain ramp feature

Philipp Zabel (1):
      ASoC: pxa2xx-i2s: Add clk_prepare/clk_unprepare calls

Rhyland Klein (1):
      ASoC: max98095: add jack detection

Richard Zhao (2):
      ASoC: imx-sgtl5000: add of_node_put when probe fail.
      ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000

Shawn Guo (18):
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: rename imx-pcm Kconfig options and filename
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
      ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
      ASoC: fsl: add imx-sgtl5000 machine driver
      ASoC: fsl: assign dma peripheral type according to bus topology
      ASoC: fsl: enable ssi clock in probe function
      ASoC: fsl: add audio routing for imx-sgtl5000
      ASoC: fsl: remove redundant Kconfig option SND_SOC_FSL_SSI
      ASoC: fsl: remove redundant Kconfig dependency on SND_SOC_POWERPC_DMA
      ASoC: mxs: add __devinit for mxs_saif_probe
      ASoC: fsl: fix the binding of imx-sgtl5000
      ASoC: mxs: mxs-pcm does not need to be a plaform_driver
      ASoC: mxs: add device tree support for mxs-saif
      ASoC: mxs: add device tree support for mxs-sgtl5000

Stephen Warren (38):
      ASoC: tegra: fix comment indentation in ALC5632 machine
      ASoC: tegra: register 'platform' from DAIs, get rid of pdev
      ARM: tegra: remove tegra_pcm_device
      ASoC: tegra: remove unnecessary includes
      ASoC: tegra: fix Kconfig SND_SOC_TEGRA_ALC5632 indentation
      ASoC: tegra: fix some checkpatch warnings
      ASoC: tegra: introduce separate Kconfig variable for DAS driver
      ASoC: tegra: sort Makefile into common and per-SoC files
      ASoC: tegra: remove open-coded clk reference counting
      ASoC: tegra: drop Kconfig description for SND_SOC_TEGRA_DAS
      ASoC: tegra: make Tegra20 drivers depend on Tegra20 support
      ASoC: tegra: rename Tegra20-specific driver files
      ASoC: tegra: complete Tegra->Tegra20 renaming
      ASoC: tegra: sort includes, remove mach/iomap.h
      ASoC: tegra: use devm_ APIs in SPDIF driver
      ASoC: tegra: set a sensible initial clock rate
      ASoC: tegra: utils: add support for Tegra30 devices
      ASoC: tegra: add runtime PM support
      ASoC: tegra: utils: Don't use of_have_populated_dt()
      regmap: introduce explicit bus_context for bus callbacks
      regmap: introduce fast_io busses, and use a spinlock for them
      regmap: add MMIO bus support
      regmap: mmio: convert some error returns to BUG()
      regmap: mmio: remove some error checks now in the core
      regmap: validate regmap_raw_read/write val_len
      regmap: allow regmap instances to be named
      regmap: fix compilation when !CONFIG_DEBUG_FS
      regmap: implement register striding
      regmap: fix compile errors in regmap-irq.c due to stride changes
      ASoC: tegra: add tegra30-ahub driver
      ASoC: tegra: add tegra30-i2s driver
      ASoC: tegra: add Kconfig and Makefile support for Tegra30
      ASoC: tegra: select REGMAP_MMIO
      ASoC: convert Tegra20 I2S driver to regmap
      ASoC: convert Tegra20 SPDIF driver to regmap
      ASoC: convert Tegra20 DAS driver to regmap
      ASoC: tegra: add device tree support for TrimSlice
      ASoC: don't flip master of DT-instantiated DAI links

Tomoya MORINAGA (1):
      ASoC: Add LAPIS Semiconductor ML26124 driver

guoyh (1):
      ASoC: pxa: allocate the SSP DMA parameters in startup

 .../bindings/sound/imx-audio-sgtl5000.txt          |   49 +
 .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 +
 .../devicetree/bindings/sound/mxs-saif.txt         |   36 +
 .../bindings/sound/nvidia,tegra30-ahub.txt         |   32 +
 .../bindings/sound/nvidia,tegra30-i2s.txt          |   15 +
 .../bindings/sound/tegra-audio-trimslice.txt       |   14 +
 MAINTAINERS                                        |    6 +
 arch/arm/mach-shmobile/Kconfig                     |    2 +
 arch/arm/mach-shmobile/board-ap4evb.c              |   35 +-
 arch/arm/mach-shmobile/board-mackerel.c            |   35 +-
 arch/arm/mach-tegra/board-dt-tegra20.c             |    6 +-
 arch/arm/mach-tegra/board-harmony.c                |    1 -
 arch/arm/mach-tegra/board-seaboard.c               |    1 -
 arch/arm/mach-tegra/board-trimslice.c              |    1 -
 arch/arm/mach-tegra/devices.c                      |   11 +-
 arch/arm/mach-tegra/devices.h                      |    1 -
 arch/arm/mach-tegra/tegra2_clocks.c                |    4 +-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |    1 +
 arch/powerpc/configs/mpc85xx_defconfig             |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 +
 arch/sh/boards/Kconfig                             |    2 +
 arch/sh/boards/mach-ecovec24/setup.c               |   26 +
 arch/sh/boards/mach-se/7724/setup.c                |   15 +-
 drivers/base/regmap/Kconfig                        |    3 +
 drivers/base/regmap/Makefile                       |    1 +
 drivers/base/regmap/internal.h                     |   22 +-
 drivers/base/regmap/regcache-lzo.c                 |   11 +-
 drivers/base/regmap/regcache-rbtree.c              |   44 +-
 drivers/base/regmap/regcache.c                     |   34 +-
 drivers/base/regmap/regmap-debugfs.c               |   18 +-
 drivers/base/regmap/regmap-i2c.c                   |   13 +-
 drivers/base/regmap/regmap-irq.c                   |   37 +-
 drivers/base/regmap/regmap-mmio.c                  |  224 +++
 drivers/base/regmap/regmap-spi.c                   |   13 +-
 drivers/base/regmap/regmap.c                       |  169 +-
 include/linux/regmap.h                             |   28 +-
 include/sound/cs42l52.h                            |   36 +
 include/sound/max98095.h                           |   12 +
 include/sound/sh_fsi.h                             |   12 -
 include/sound/simple_card.h                        |   38 +
 include/sound/soc-dai.h                            |    4 +
 include/sound/soc-dapm.h                           |   28 +-
 include/sound/soc-dpcm.h                           |  138 ++
 include/sound/soc.h                                |  118 +-
 include/trace/events/asoc.h                        |   80 +
 sound/soc/Kconfig                                  |    5 +-
 sound/soc/Makefile                                 |    3 +-
 sound/soc/blackfin/bf5xx-ssm2602.c                 |   37 +-
 sound/soc/codecs/Kconfig                           |   12 +
 sound/soc/codecs/Makefile                          |    8 +-
 sound/soc/codecs/ac97.c                            |    6 +-
 sound/soc/codecs/ad1836.c                          |    4 +-
 sound/soc/codecs/ad193x.c                          |    4 +-
 sound/soc/codecs/adau1701.c                        |    3 +-
 sound/soc/codecs/ak4104.c                          |    3 +-
 sound/soc/codecs/ak4535.c                          |    3 +-
 sound/soc/codecs/ak4641.c                          |  113 +-
 sound/soc/codecs/alc5623.c                         |   23 +-
 sound/soc/codecs/alc5632.c                         |   31 +-
 sound/soc/codecs/cs4270.c                          |   11 +-
 sound/soc/codecs/cs4271.c                          |    3 +-
 sound/soc/codecs/cs42l51.c                         |    9 +-
 sound/soc/codecs/cs42l52.c                         | 1295 ++++++++++++++
 sound/soc/codecs/cs42l52.h                         |  274 +++
 sound/soc/codecs/cs42l73.c                         |   93 +-
 sound/soc/codecs/da7210.c                          |  379 ++++-
 sound/soc/codecs/jz4740.c                          |    3 +-
 sound/soc/codecs/lm49453.c                         | 1550 +++++++++++++++++
 sound/soc/codecs/lm49453.h                         |  380 +++++
 sound/soc/codecs/max98095.c                        |  158 +-
 sound/soc/codecs/max98095.h                        |   22 +
 sound/soc/codecs/ml26124.c                         |  681 ++++++++
 sound/soc/codecs/ml26124.h                         |  184 ++
 sound/soc/codecs/rt5631.c                          |  110 +-
 sound/soc/codecs/sgtl5000.c                        |   25 +-
 sound/soc/codecs/ssm2602.c                         |  138 +-
 sound/soc/codecs/sta32x.c                          |    3 +-
 sound/soc/codecs/tlv320aic23.c                     |   13 +-
 sound/soc/codecs/tlv320aic26.c                     |    3 +-
 sound/soc/codecs/tlv320aic3x.c                     |   21 +-
 sound/soc/codecs/tlv320dac33.c                     |   35 +-
 sound/soc/codecs/twl4030.c                         |   18 +-
 sound/soc/codecs/twl6040.c                         |  450 +----
 sound/soc/codecs/uda134x.c                         |    6 +-
 sound/soc/codecs/uda1380.c                         |    6 +-
 sound/soc/codecs/wl1273.c                          |    6 +-
 sound/soc/codecs/wm1250-ev1.c                      |   65 +-
 sound/soc/codecs/wm5100-tables.c                   |  125 +-
 sound/soc/codecs/wm5100.c                          |   47 +-
 sound/soc/codecs/wm5100.h                          |  159 ++
 sound/soc/codecs/wm8350.c                          |  187 +--
 sound/soc/codecs/wm8400.c                          |  135 +-
 sound/soc/codecs/wm8510.c                          |    3 +-
 sound/soc/codecs/wm8523.c                          |    3 +-
 sound/soc/codecs/wm8728.c                          |    3 +-
 sound/soc/codecs/wm8731.c                          |   37 +-
 sound/soc/codecs/wm8737.c                          |    3 +-
 sound/soc/codecs/wm8741.c                          |    3 +-
 sound/soc/codecs/wm8750.c                          |    3 +-
 sound/soc/codecs/wm8753.c                          |    6 +-
 sound/soc/codecs/wm8900.c                          |    3 +-
 sound/soc/codecs/wm8903.c                          |    3 +-
 sound/soc/codecs/wm8940.c                          |    3 +-
 sound/soc/codecs/wm8960.c                          |    3 +-
 sound/soc/codecs/wm8962.c                          |   18 +-
 sound/soc/codecs/wm8971.c                          |    3 +-
 sound/soc/codecs/wm8978.c                          |    3 +-
 sound/soc/codecs/wm8988.c                          |    3 +-
 sound/soc/codecs/wm8990.c                          |    3 +-
 sound/soc/codecs/wm8993.c                          |   86 +-
 sound/soc/codecs/wm8994.c                          |  290 ++--
 sound/soc/codecs/wm8994.h                          |    3 +
 sound/soc/codecs/wm8996.c                          |   12 +
 sound/soc/codecs/wm9081.c                          |    5 +-
 sound/soc/codecs/wm9705.c                          |    6 +-
 sound/soc/codecs/wm9712.c                          |   10 +-
 sound/soc/codecs/wm_hubs.c                         |  220 ++-
 sound/soc/codecs/wm_hubs.h                         |   12 +-
 sound/soc/ep93xx/ep93xx-ac97.c                     |   74 +-
 sound/soc/ep93xx/ep93xx-i2s.c                      |   49 +-
 sound/soc/fsl/Kconfig                              |  121 +-
 sound/soc/fsl/Makefile                             |   29 +-
 sound/soc/{imx => fsl}/eukrea-tlv320.c             |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |  167 +-
 sound/soc/fsl/fsl_utils.c                          |   91 +
 sound/soc/fsl/fsl_utils.h                          |   26 +
 sound/soc/{imx => fsl}/imx-audmux.c                |    0
 sound/soc/{imx => fsl}/imx-audmux.h                |    0
 .../{imx/imx-pcm-dma-mx2.c => fsl/imx-pcm-dma.c}   |    3 +-
 sound/soc/{imx => fsl}/imx-pcm-fiq.c               |    0
 sound/soc/{imx => fsl}/imx-pcm.c                   |    0
 sound/soc/{imx => fsl}/imx-pcm.h                   |    1 +
 sound/soc/fsl/imx-sgtl5000.c                       |  221 +++
 sound/soc/{imx => fsl}/imx-ssi.c                   |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h                   |    0
 sound/soc/fsl/mpc8610_hpcd.c                       |  166 +-
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c           |    0
 sound/soc/fsl/p1022_ds.c                           |  158 +-
 sound/soc/{imx => fsl}/phycore-ac97.c              |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c                |    0
 sound/soc/generic/Kconfig                          |    4 +
 sound/soc/generic/Makefile                         |    3 +
 sound/soc/generic/simple-card.c                    |  114 ++
 sound/soc/imx/Kconfig                              |   79 -
 sound/soc/imx/Makefile                             |   22 -
 sound/soc/jz4740/jz4740-i2s.c                      |    4 +-
 sound/soc/mxs/mxs-pcm.c                            |   24 +-
 sound/soc/mxs/mxs-pcm.h                            |    3 +
 sound/soc/mxs/mxs-saif.c                           |   92 +-
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   50 +-
 sound/soc/pxa/pxa-ssp.c                            |   28 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    4 +-
 sound/soc/samsung/littlemill.c                     |  102 +-
 sound/soc/samsung/lowland.c                        |   75 +-
 sound/soc/samsung/speyside.c                       |   33 +-
 sound/soc/sh/Kconfig                               |   24 +-
 sound/soc/sh/Makefile                              |    6 -
 sound/soc/sh/fsi-ak4642.c                          |  108 --
 sound/soc/sh/fsi-da7210.c                          |   81 -
 sound/soc/sh/fsi-hdmi.c                            |  118 --
 sound/soc/soc-core.c                               |  690 +++++---
 sound/soc/soc-dapm.c                               |  562 +++++--
 sound/soc/soc-jack.c                               |    5 +-
 sound/soc/soc-pcm.c                                | 1772 +++++++++++++++++++-
 sound/soc/tegra/Kconfig                            |   58 +-
 sound/soc/tegra/Makefile                           |   18 +-
 sound/soc/tegra/tegra20_das.c                      |  233 +++
 sound/soc/tegra/tegra20_das.h                      |  134 ++
 sound/soc/tegra/tegra20_i2s.c                      |  494 ++++++
 sound/soc/tegra/tegra20_i2s.h                      |  164 ++
 sound/soc/tegra/tegra20_spdif.c                    |  404 +++++
 sound/soc/tegra/tegra20_spdif.h                    |  471 ++++++
 sound/soc/tegra/tegra30_ahub.c                     |  631 +++++++
 sound/soc/tegra/tegra30_ahub.h                     |  483 ++++++
 sound/soc/tegra/tegra30_i2s.c                      |  536 ++++++
 sound/soc/tegra/tegra30_i2s.h                      |  242 +++
 sound/soc/tegra/tegra_alc5632.c                    |   48 +-
 sound/soc/tegra/tegra_asoc_utils.c                 |   37 +-
 sound/soc/tegra/tegra_asoc_utils.h                 |    9 +-
 sound/soc/tegra/tegra_das.c                        |  261 ---
 sound/soc/tegra/tegra_das.h                        |  135 --
 sound/soc/tegra/tegra_i2s.c                        |  459 -----
 sound/soc/tegra/tegra_i2s.h                        |  166 --
 sound/soc/tegra/tegra_pcm.c                        |   28 +-
 sound/soc/tegra/tegra_pcm.h                        |    5 +-
 sound/soc/tegra/tegra_spdif.c                      |  364 ----
 sound/soc/tegra/tegra_spdif.h                      |  473 ------
 sound/soc/tegra/tegra_wm8903.c                     |   29 +-
 sound/soc/tegra/trimslice.c                        |   41 +-
 sound/soc/ux500/Kconfig                            |   14 +
 sound/soc/ux500/Makefile                           |    4 +
 sound/soc/ux500/ux500_msp_dai.c                    |  843 ++++++++++
 sound/soc/ux500/ux500_msp_dai.h                    |   79 +
 sound/soc/ux500/ux500_msp_i2s.c                    |  742 ++++++++
 sound/soc/ux500/ux500_msp_i2s.h                    |  553 ++++++
 196 files changed, 17192 insertions(+), 5071 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt
 create mode 100644 drivers/base/regmap/regmap-mmio.c
 create mode 100644 include/sound/cs42l52.h
 create mode 100644 include/sound/simple_card.h
 create mode 100644 include/sound/soc-dpcm.h
 create mode 100644 sound/soc/codecs/cs42l52.c
 create mode 100644 sound/soc/codecs/cs42l52.h
 create mode 100644 sound/soc/codecs/lm49453.c
 create mode 100644 sound/soc/codecs/lm49453.h
 create mode 100644 sound/soc/codecs/ml26124.c
 create mode 100644 sound/soc/codecs/ml26124.h
 rename sound/soc/{imx => fsl}/eukrea-tlv320.c (99%)
 create mode 100644 sound/soc/fsl/fsl_utils.c
 create mode 100644 sound/soc/fsl/fsl_utils.h
 rename sound/soc/{imx => fsl}/imx-audmux.c (100%)
 rename sound/soc/{imx => fsl}/imx-audmux.h (100%)
 rename sound/soc/{imx/imx-pcm-dma-mx2.c => fsl/imx-pcm-dma.c} (97%)
 rename sound/soc/{imx => fsl}/imx-pcm-fiq.c (100%)
 rename sound/soc/{imx => fsl}/imx-pcm.c (100%)
 rename sound/soc/{imx => fsl}/imx-pcm.h (93%)
 create mode 100644 sound/soc/fsl/imx-sgtl5000.c
 rename sound/soc/{imx => fsl}/imx-ssi.c (99%)
 rename sound/soc/{imx => fsl}/imx-ssi.h (100%)
 rename sound/soc/{imx => fsl}/mx27vis-aic32x4.c (100%)
 rename sound/soc/{imx => fsl}/phycore-ac97.c (100%)
 rename sound/soc/{imx => fsl}/wm1133-ev1.c (100%)
 create mode 100644 sound/soc/generic/Kconfig
 create mode 100644 sound/soc/generic/Makefile
 create mode 100644 sound/soc/generic/simple-card.c
 delete mode 100644 sound/soc/imx/Kconfig
 delete mode 100644 sound/soc/imx/Makefile
 delete mode 100644 sound/soc/sh/fsi-ak4642.c
 delete mode 100644 sound/soc/sh/fsi-da7210.c
 delete mode 100644 sound/soc/sh/fsi-hdmi.c
 create mode 100644 sound/soc/tegra/tegra20_das.c
 create mode 100644 sound/soc/tegra/tegra20_das.h
 create mode 100644 sound/soc/tegra/tegra20_i2s.c
 create mode 100644 sound/soc/tegra/tegra20_i2s.h
 create mode 100644 sound/soc/tegra/tegra20_spdif.c
 create mode 100644 sound/soc/tegra/tegra20_spdif.h
 create mode 100644 sound/soc/tegra/tegra30_ahub.c
 create mode 100644 sound/soc/tegra/tegra30_ahub.h
 create mode 100644 sound/soc/tegra/tegra30_i2s.c
 create mode 100644 sound/soc/tegra/tegra30_i2s.h
 delete mode 100644 sound/soc/tegra/tegra_das.c
 delete mode 100644 sound/soc/tegra/tegra_das.h
 delete mode 100644 sound/soc/tegra/tegra_i2s.c
 delete mode 100644 sound/soc/tegra/tegra_i2s.h
 delete mode 100644 sound/soc/tegra/tegra_spdif.c
 delete mode 100644 sound/soc/tegra/tegra_spdif.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPs3LKAAoJEBus8iNuMP3d6N8P/0HxNqGG5bcNQtv3tEW43Bol
wAfr3nB5Wy5etoDRAoAxWB7gOs0PUlf9sazsM4HqDv5QmJglGfImasGfhaUmJxYu
ukjecHwDcBacf2Z/vfBL1ev1igoCtcdWES7DAN1J981tY4+Bi12Mo/ScNUb11N2C
K7au89c6xQmTo5hBVlAIlq0pDu0Ik/MU/fOK9QVwu3A8oOo6rSYkGxznlzvhAiY1
9zoB6wgr5bHCwSyx6Utp30GEjli6l6Kmwvlx2oiAWB60UIU8adiT1bTUVQcc289e
PJ+VGkF42XhyqWmXPI9FMkBrJ9anG8g7xyo1XERWBP9u5e7zNxiDGHLMFzsGT+N8
D7mg8awFf7uo3YexzvE/P7dIkklsz5vE2GWEnhlSyPi4GSsz3kq+pb/zaoRMB07n
wuyYCgjyAtdJS51BzdTxtTN6pYRwSn+YVH5TzrckpCleoVrJJNzrHr54EUJ4042Z
2o0Qu6l15O3XhEhLK1vlby0UepdstBEv6JoaFwNEaWZrhZoZQmzlaL764zAvKl20
od++ol7VLwQQuHpBVvZb2oM3JGjA28QVl1b5q0X1KRh8WhthxjaUeg862bT11P8L
jhie42EnPHD3pEgvEnX0pkdNOKEMQh2bn6sKdoy6zmjKxmaFzlmseveSqh9yhIL5
sy06k48+/v0OYvg2dawB
=86Cs
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============0239073030103932275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0239073030103932275==--
