From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 6 Dec 2011 10:37:45 +0000
Message-ID: <20111206103745.GG28840@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5D1F103B5C
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 11:37:50 +0100 (CET)
Content-Disposition: inline
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

The following changes since commit fd8f2e496f38264a64c0cc7948217659019a9e8a:

  Merge branch 'for-3.2' into for-3.3 (2011-11-28 23:18:39 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

Lots of mechanical updates here so a large diffstat.

Axel Lin (10):
      ASoC: Convert smdk_wm8994pcm to use module_platform_driver()
      ASoC: cs42l73: Fix clear wrong bits in cs42l73_set_dai_fmt
      ASoC: kirkwood: Make SND_KIRKWOOD_SOC_OPENRD and SND_KIRKWOOD_SOC_T5325 depend on I2C
      ASoC: Make SND_SOC_LITTLEMILL select MFD_WM8994
      ASoC: uda1380: Return proper error in uda1380_modinit failure path
      ASoC: Fix dependency for SND_SOC_RAUMFELD and SND_PXA2XX_SOC_HX4700
      ASoC: Make SND_SOC_MX27VIS_AIC32X4 depend on I2C
      ASoC: Convert e740_wm9705 to use gpio_request_one()
      ASoC: uda1380: Convert to gpio_request_one()
      ASoC: Fix reg_cache_size for stac9766

Lars-Peter Clausen (8):
      firmware: Sigma: Prevent out of bounds memory access
      firmware: Sigma: Skip header during CRC generation
      firmware: Sigma: Fix endianess issues
      ASoC: Move SigmaDSP firmware loader to ASoC
      ASoC: SigmaDSP: Provide diagnostic error messages
      ASoC: SigmaDSP: Move private structs and functions to C file
      ASoC: SigmaDSP: Add regmap support
      ASoC: Drop unused state parameter from CODEC suspend callback

Mark Brown (58):
      Merge branch 'for-3.2' into for-3.3
      ASoC: Ensure SYSCLK is enabled for WM8958 accessory detection
      ASoC: Fix __iomem annotation for IDMA registers
      ASoC: Put WM8958 and WM1811 MICBIAS into bypass mode when no audio
      ASoC: Enhance default WM8958 microphone detection
      ASoC: Rename Speyside WM8962 to Tobermory
      ASoC: Provide debug log of accessory status on WM8958
      ASoC: Don't use control_data to get struct wm8994
      ASoC: Tune down active mode detection rate for WM8958 mic detection
      ASoC: Allow more WM8958/WM1811 button levels with default handler
      ASoC: Rename WM8994 detecting flag to mic_detecting
      ASoC: Implement support for WM1811A jack detection
      ASoC: Ensure we reconfigure WM8958 microphone detection on rate changes
      ASoC: Add platform data for WM8958/WM1811 microphone detection rates
      ASoC: Convert WM8994 to devm_kzalloc()
      ASoC: Add signal generator widget type
      ASoC: Make WM5100 tone generator widgets signal generators
      ASoC: Make WM8962 beep a signal generator
      ASoC: Add missing err label
      ASoC: Add WM8958 based headset detection on Littlemill
      ASoC: Convert WM8994 MICBIASes to supply widgets
      ASoC: Map microphones on Littlemill
      ASoC: Mark WM8994 ADC muxes as virtual
      Merge branch 'for-3.2' into for-3.3
      ASoC: Convert WM8903 to devm_kzalloc()
      ASoC: Use table based control init for WM8903
      ASoC: WM8903 only supports I2C so don't ifdef it
      ASoC: Use a normal cache sync for WM8903
      ASoC: Don't resync WM8903 register cache on reset
      ASoC: Convert WM8903 to direct regmap API usage
      ASoC: Move initial WM8903 identification and reset to I2C probe
      Merge branch 'for-3.2' into for-3.3
      ASoC: Remove unused -codec from Wolfson device driver names
      ASoC: Remove I2C ifdefs from WM8960
      ASoC: Remove unused AUDIO_NAME define from WM8960
      ASoC: Convert WM2000 to devm_kzalloc()
      ASoC: Convert WM8350 to devm_kzalloc()
      ASoC: Convert WM8400 to devm_kzalloc()
      ASoC: Convert WM8741 to devm_kzalloc()
      ASoC: Convert WM8750 to devm_kzalloc()
      ASoC: Convert WM9090 to devm_kzalloc()
      ASoC: Convert WM8350 to table based DAPM and control init
      ASoC: Convert WM8400 to table based DAPM and control init
      ASoC: Convert WM8510 to table based DAPM and control init
      ASoC: Convert WM8580 to table based DAPM and control init
      ASoC: Convert WM8741 to table based DAPM and control init
      ASoC: Convert WM8750 to table based DAPM and control init
      ASoC: Convert WM8711 to table based control init
      ASoC: Convert WM8728 to table based control init
      ASoC: Remove unused struct wm2000_setup_data
      ASoC: Convert wm2000 to use regmap API
      ASoC: Convert WM2000 into a standard CODEC driver
      ASoC: Sort WM9090 in with the CODEC drivers
      Merge branch 'for-3.2' into for-3.3
      ASoC: Remove references to corgi and spitz from machine driver document
      Merge branch 'for-3.2' into for-3.3
      ASoC: Provide a more complete DMA driver stub
      Merge branch 'for-3.2' into for-3.3

Stephen Warren (3):
      ASoC: Tegra I2S: Add device tree binding
      ASoC: WM8903: Disallow all invalid gpio_cfg pdata values
      ASoC: WM8903: Create default platform data structure

Timur Tabi (2):
      ASoC: p1022ds: add support for fsl,P1022 and fsl,P1022DS model names
      ASoC: fsl/powerpc: don't rely on the cell-index property

Vinod Koul (1):
      ASoC: sst_platform: fix the dsp driver interface

 .../devicetree/bindings/sound/tegra20-i2s.txt      |   17 +
 Documentation/sound/alsa/soc/machine.txt           |    6 +-
 MAINTAINERS                                        |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    6 +-
 drivers/firmware/Kconfig                           |   12 -
 drivers/firmware/Makefile                          |    1 -
 drivers/firmware/sigma.c                           |  118 -----
 include/linux/mfd/wm8994/pdata.h                   |   23 +
 include/linux/mfd/wm8994/registers.h               |   16 +
 include/linux/sigma.h                              |   60 ---
 include/sound/soc-dapm.h                           |    4 +
 include/sound/soc.h                                |    3 +-
 sound/soc/codecs/Kconfig                           |   18 +-
 sound/soc/codecs/Makefile                          |   10 +-
 sound/soc/codecs/ac97.c                            |    2 +-
 sound/soc/codecs/ad1836.c                          |    2 +-
 sound/soc/codecs/adau1373.c                        |    2 +-
 sound/soc/codecs/adau1701.c                        |    2 +-
 sound/soc/codecs/adav80x.c                         |    2 +-
 sound/soc/codecs/ak4535.c                          |    2 +-
 sound/soc/codecs/ak4641.c                          |    2 +-
 sound/soc/codecs/alc5623.c                         |    2 +-
 sound/soc/codecs/alc5632.c                         |    2 +-
 sound/soc/codecs/cs4270.c                          |    2 +-
 sound/soc/codecs/cs4271.c                          |    2 +-
 sound/soc/codecs/cs42l73.c                         |    5 +-
 sound/soc/codecs/jz4740.c                          |    2 +-
 sound/soc/codecs/max98088.c                        |    2 +-
 sound/soc/codecs/max98095.c                        |    2 +-
 sound/soc/codecs/max9850.c                         |    2 +-
 sound/soc/codecs/pcm3008.c                         |    2 +-
 sound/soc/codecs/rt5631.c                          |    2 +-
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/sigmadsp.c                        |  246 ++++++++++
 sound/soc/codecs/sigmadsp.h                        |   21 +
 sound/soc/codecs/ssm2602.c                         |    2 +-
 sound/soc/codecs/sta32x.c                          |    2 +-
 sound/soc/codecs/stac9766.c                        |    5 +-
 sound/soc/codecs/tlv320aic23.c                     |    3 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    2 +-
 sound/soc/codecs/tlv320aic3x.c                     |    2 +-
 sound/soc/codecs/tlv320dac33.c                     |    2 +-
 sound/soc/codecs/twl4030.c                         |    2 +-
 sound/soc/codecs/twl6040.c                         |    2 +-
 sound/soc/codecs/uda134x.c                         |    3 +-
 sound/soc/codecs/uda1380.c                         |   34 +-
 sound/soc/codecs/wm2000.c                          |  226 ++++-----
 sound/soc/codecs/wm2000.h                          |    7 -
 sound/soc/codecs/wm5100.c                          |    2 +-
 sound/soc/codecs/wm8350.c                          |   49 +--
 sound/soc/codecs/wm8400.c                          |   40 +-
 sound/soc/codecs/wm8510.c                          |   27 +-
 sound/soc/codecs/wm8523.c                          |    2 +-
 sound/soc/codecs/wm8580.c                          |   24 +-
 sound/soc/codecs/wm8711.c                          |    7 +-
 sound/soc/codecs/wm8727.c                          |    2 +-
 sound/soc/codecs/wm8728.c                          |    7 +-
 sound/soc/codecs/wm8731.c                          |    2 +-
 sound/soc/codecs/wm8737.c                          |    2 +-
 sound/soc/codecs/wm8741.c                          |   40 +-
 sound/soc/codecs/wm8750.c                          |   37 +-
 sound/soc/codecs/wm8753.c                          |    2 +-
 sound/soc/codecs/wm8770.c                          |    2 +-
 sound/soc/codecs/wm8776.c                          |    2 +-
 sound/soc/codecs/wm8804.c                          |    2 +-
 sound/soc/codecs/wm8900.c                          |    6 +-
 sound/soc/codecs/wm8903.c                          |  478 +++++++++---------
 sound/soc/codecs/wm8904.c                          |    4 +-
 sound/soc/codecs/wm8940.c                          |    4 +-
 sound/soc/codecs/wm8955.c                          |    4 +-
 sound/soc/codecs/wm8960.c                          |   12 +-
 sound/soc/codecs/wm8961.c                          |    4 +-
 sound/soc/codecs/wm8962.c                          |    2 +-
 sound/soc/codecs/wm8971.c                          |    4 +-
 sound/soc/codecs/wm8974.c                          |    4 +-
 sound/soc/codecs/wm8978.c                          |    2 +-
 sound/soc/codecs/wm8983.c                          |    2 +-
 sound/soc/codecs/wm8985.c                          |    2 +-
 sound/soc/codecs/wm8988.c                          |    4 +-
 sound/soc/codecs/wm8990.c                          |    4 +-
 sound/soc/codecs/wm8991.c                          |    2 +-
 sound/soc/codecs/wm8993.c                          |    4 +-
 sound/soc/codecs/wm8994.c                          |  517 +++++++++++++++++---
 sound/soc/codecs/wm8994.h                          |   11 +-
 sound/soc/codecs/wm8995.c                          |    2 +-
 sound/soc/codecs/wm9081.c                          |    2 +-
 sound/soc/codecs/wm9090.c                          |    9 +-
 sound/soc/codecs/wm9705.c                          |    2 +-
 sound/soc/codecs/wm9712.c                          |    3 +-
 sound/soc/codecs/wm9713.c                          |    3 +-
 sound/soc/codecs/wm_hubs.c                         |    4 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |   13 +-
 sound/soc/fsl/p1022_ds.c                           |   49 ++-
 sound/soc/imx/Kconfig                              |    2 +-
 sound/soc/kirkwood/Kconfig                         |    3 +-
 sound/soc/mid-x86/Kconfig                          |    1 -
 sound/soc/mid-x86/sst_platform.c                   |  130 ++++--
 sound/soc/mid-x86/sst_platform.h                   |   82 +++-
 sound/soc/pxa/Kconfig                              |    3 +-
 sound/soc/pxa/e740_wm9705.c                        |   20 +-
 sound/soc/samsung/Kconfig                          |    5 +-
 sound/soc/samsung/Makefile                         |    4 +-
 sound/soc/samsung/i2s.c                            |    2 +-
 sound/soc/samsung/idma.c                           |    2 +-
 sound/soc/samsung/idma.h                           |    2 +-
 sound/soc/samsung/littlemill.c                     |   25 +
 sound/soc/samsung/smdk_wm8994pcm.c                 |   14 +-
 .../soc/samsung/{speyside_wm8962.c => tobermory.c} |   66 ++--
 sound/soc/soc-core.c                               |    2 +-
 sound/soc/soc-dapm.c                               |    7 +
 sound/soc/soc-utils.c                              |   31 ++-
 sound/soc/tegra/tegra_i2s.c                        |   27 +-
 112 files changed, 1664 insertions(+), 1065 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra20-i2s.txt
 delete mode 100644 drivers/firmware/sigma.c
 delete mode 100644 include/linux/sigma.h
 create mode 100644 sound/soc/codecs/sigmadsp.c
 create mode 100644 sound/soc/codecs/sigmadsp.h
 rename sound/soc/samsung/{speyside_wm8962.c => tobermory.c} (72%)
