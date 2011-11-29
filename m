From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 29 Nov 2011 11:38:53 +0000
Message-ID: <20111129113852.GI2851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F4892432E
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 12:38:55 +0100 (CET)
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

The following changes since commit 12a7a709a09aac117b630264cdd526e20d4d0ce2:

  ASoC: Remove conditional I2C usage from tlv320aic3x driver (2011-11-22 11:59:50 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

A very big update but mostly consisting of lots of small changes that
clean up many different drivers.

Axel Lin (23):
      ASoC: cs42l73: Unify the way to define bits of register
      ASoC: cs42l73: Make inv and format to be unsigned int
      ASoC: Fix wrong define for AD1836_ADC_WORD_OFFSET
      ASoC: max9877: Update register if either val or val2 is changed
      ASoC: cs42l51: Fix off-by-one for reg_cache_size
      ASoC: Convert ep93xx directory to module_platform_driver
      ASoC: Convert s6000 directory to module_platform_driver
      ASoC: Convert mxs directory to module_platform_driver
      ASoC: Convert blackfin directory to module_platform_driver
      ASoC: Convert imx directory to module_platform_driver
      ASoC: Convert jz4740 directory to module_platform_driver
      ASoC: Convert nuc900 directory to module_platform_driver
      ASoC: Convert kirkwood directory to module_platform_driver
      ASoC: Convert mid-x86 directory to module_platform_driver
      ASoC: Convert atmel directory to module_platform_driver
      ASoC: Convert au1x directory to module_platform_driver
      ASoC: Convert pxa directory to module_platform_driver
      ASoC: Convert sh directory to module_platform_driver
      ASoC: Convert txx9 directory to module_platform_driver
      ASoC: Convert davinci directory to module_platform_driver
      ASoC: Convert omap directory to module_platform_driver
      ASoC: Convert fsl directory to module_platform_driver
      ASoC: Convert tegra_spdif to use module_platform_driver()

Boojin Kim (1):
      ASoC: SAMSUNG: Fix build error

Brian Austin (1):
      ASoC: Convert CS42L73 to devm_kzalloc()

Daniel Mack (1):
      ASoC: cs4720: use snd_soc_cache_sync()

Eric Miao (1):
      ASoC: skip resume of soc-audio devices without codecs

Kuninori Morimoto (1):
      ASoC: fsi-ak4642: modify specification method of FSI / ak464x

Lars-Peter Clausen (9):
      ASoC: Constify snd_soc_dai_ops structs
      ASoC: Cleanup duplicated const
      ASoC: ad193x: Use table based DAPM and controls setup
      ASoC: ad193x: Provide dB ranges for the volume controls
      ASoC: ad193x: Make enum items const char * const
      ASoC: ad193x: Remove non-functional DAPM route controls
      ASoC: ad193x: Add sysclk DAPM supply
      ASoC: ad193x: Use snd_soc_update_bits where appropriate
      ASoC: ad193x: Convert to direct regmap API usage

Mark Brown (30):
      Merge branch 'for-3.2' into for-3.3
      Merge branch 'for-3.2' into for-3.3
      Merge branch 'for-3.2' into for-3.3
      ASoC: Staticise and constify cs42l73_reg_defaults
      ASoC: Convert wm8776 to table based control and DAPM init
      Merge branch 'for-3.2' into for-3.3
      Merge branch 'for-3.2' into for-3.3
      Merge branch 'for-3.2' into for-3.3
      ASoC: Remove unused variable in wm8776 driver
      ASoC: Add fully_routed flag to Speyside machines
      ASoC: Convert Samsung directory to module_platform_driver
      ASoC: Staticise non-exported symbols in sta32x
      ASoC: Use devm_kzalloc() in wm5100
      ASoC: Remove driver versioning from ak4642
      ASoC: Remove unneeded platform_device.h inclusions from CODECs
      ASoC: Correct name of Speyside Main Speaker widget
      ASoC: Convert wm1250-ev1 driver to use devm_kzalloc()
      ASoC: Convert wm9081 driver to use devm_kzalloc()
      ASoC: Convert wm8996 to use devm_kzalloc()
      Merge branch 'for-3.2' into for-3.3
      ASoC: Fix CODEC enumeration for auto_nc_codec_pins
      ASoC: Log automatic pin disconnection per CODEC rather than per card
      ASoC: Convert WM8962 to devm_kzalloc()
      ASoC: Convert CODEC drivers to module_platform_driver
      ASoC: Convert WM8903 MICBIAS to a supply widget
      ASoC: Error out if we can't generate a LRCLK at all for WM8994
      ASoC: Add basic 1277-EV1 Littlemill audio driver
      Merge branch 'for-3.2' into for-3.3
      ASoC: Supply dcs_codes for newer WM1811 revisions
      Merge branch 'for-3.2' into for-3.3

Paul Bolle (1):
      ASoC: drop support for PlayPaq with WM8510

Peter Ujfalusi (2):
      ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
      ASoC: sdp4430: Add support for digital microphones

Stephen Warren (11):
      ASoC: Tegra PCM: Use module_platform_driver
      ASoC: Tegra DAS: Use devm_ APIs and module_platform_driver
      ASoC: Tegra: Move DAS configuration into machine drivers
      ASoC: Tegra I2S: Use devm_ APIs and module_platform_driver
      ASoC: Tegra DAS: Add device tree binding
      ASoC: Tegra+WM8903 machine: Use devm_ APIs and module_platform_driver
      ASoC: Tegra TrimSlice machine: Use devm_ APIs and module_platform_driver
      ASoC: Tegra I2S: Remove dependency on pdev->id
      ASoC: Implement fully_routed card property
      ASoC: Tegra+WM903 machine: Set the new fully_routed flag
      ASoC: TrimSlice machine: Set the new fully_routed flag

Timur Tabi (1):
      ASoC: mpc8610: tell the CS4270 codec that it's the master

 .../devicetree/bindings/sound/tegra20-das.txt      |   12 +
 arch/arm/mach-shmobile/board-ap4evb.c              |   15 +-
 arch/arm/mach-shmobile/board-mackerel.c            |   14 +-
 arch/sh/boards/mach-se/7724/setup.c                |   14 +-
 include/sound/sh_fsi.h                             |   12 +
 include/sound/soc-dapm.h                           |    1 +
 include/sound/soc.h                                |    1 +
 sound/soc/atmel/Kconfig                            |   21 +-
 sound/soc/atmel/Makefile                           |    4 -
 sound/soc/atmel/atmel-pcm.c                        |   12 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   14 +-
 sound/soc/atmel/playpaq_wm8510.c                   |  473 -----------------
 sound/soc/au1x/ac97c.c                             |    2 +-
 sound/soc/au1x/db1000.c                            |   13 +-
 sound/soc/au1x/db1200.c                            |   13 +-
 sound/soc/au1x/dbdma2.c                            |   13 +-
 sound/soc/au1x/dma.c                               |   13 +-
 sound/soc/au1x/i2sc.c                              |   13 +-
 sound/soc/au1x/psc-ac97.c                          |    2 +-
 sound/soc/au1x/psc-i2s.c                           |   15 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |   12 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |   13 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |   12 +-
 sound/soc/blackfin/bf5xx-i2s.c                     |   15 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c                 |   12 +-
 sound/soc/blackfin/bf5xx-tdm.c                     |   14 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |   12 +-
 sound/soc/blackfin/bfin-eval-adau1701.c            |   12 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |   12 +-
 sound/soc/codecs/88pm860x-codec.c                  |   16 +-
 sound/soc/codecs/ac97.c                            |   14 +-
 sound/soc/codecs/ad1836.c                          |    2 +-
 sound/soc/codecs/ad1836.h                          |    2 +-
 sound/soc/codecs/ad193x.c                          |  190 ++++----
 sound/soc/codecs/ad193x.h                          |   17 +-
 sound/soc/codecs/ad1980.c                          |   12 +-
 sound/soc/codecs/ad73311.c                         |   12 +-
 sound/soc/codecs/ads117x.c                         |   12 +-
 sound/soc/codecs/ak4104.c                          |    2 +-
 sound/soc/codecs/ak4535.c                          |    3 +-
 sound/soc/codecs/ak4641.c                          |    5 +-
 sound/soc/codecs/ak4642.c                          |    7 +-
 sound/soc/codecs/ak4671.c                          |    2 +-
 sound/soc/codecs/alc5623.c                         |    3 +-
 sound/soc/codecs/alc5632.c                         |    2 +-
 sound/soc/codecs/cq93vc.c                          |   14 +-
 sound/soc/codecs/cs4270.c                          |   13 +-
 sound/soc/codecs/cs4271.c                          |    2 +-
 sound/soc/codecs/cs42l51.c                         |    5 +-
 sound/soc/codecs/cs42l73.c                         |   16 +-
 sound/soc/codecs/cs42l73.h                         |   18 +-
 sound/soc/codecs/cx20442.c                         |   12 +-
 sound/soc/codecs/da7210.c                          |    3 +-
 sound/soc/codecs/dfbmcs320.c                       |   12 +-
 sound/soc/codecs/dmic.c                            |   12 +-
 sound/soc/codecs/jz4740.c                          |   14 +-
 sound/soc/codecs/max98088.c                        |    5 +-
 sound/soc/codecs/max98095.c                        |    7 +-
 sound/soc/codecs/max9850.c                         |    2 +-
 sound/soc/codecs/max9877.c                         |   10 +-
 sound/soc/codecs/pcm3008.c                         |   12 +-
 sound/soc/codecs/rt5631.c                          |    3 +-
 sound/soc/codecs/sgtl5000.c                        |    3 +-
 sound/soc/codecs/sn95031.c                         |   22 +-
 sound/soc/codecs/spdif_transciever.c               |   13 +-
 sound/soc/codecs/ssm2602.c                         |    3 +-
 sound/soc/codecs/sta32x.c                          |    7 +-
 sound/soc/codecs/stac9766.c                        |   16 +-
 sound/soc/codecs/tlv320aic23.c                     |    3 +-
 sound/soc/codecs/tlv320aic26.c                     |    2 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    3 +-
 sound/soc/codecs/tlv320aic3x.c                     |    3 +-
 sound/soc/codecs/tlv320dac33.c                     |    3 +-
 sound/soc/codecs/twl4030.c                         |   16 +-
 sound/soc/codecs/twl6040.c                         |   14 +-
 sound/soc/codecs/uda134x.c                         |   14 +-
 sound/soc/codecs/uda1380.c                         |    6 +-
 sound/soc/codecs/wl1273.c                          |   14 +-
 sound/soc/codecs/wm1250-ev1.c                      |   10 +-
 sound/soc/codecs/wm2000.c                          |    1 -
 sound/soc/codecs/wm5100.c                          |   12 +-
 sound/soc/codecs/wm8350.c                          |   14 +-
 sound/soc/codecs/wm8400.c                          |   14 +-
 sound/soc/codecs/wm8510.c                          |    3 +-
 sound/soc/codecs/wm8523.c                          |    3 +-
 sound/soc/codecs/wm8580.c                          |    5 +-
 sound/soc/codecs/wm8711.c                          |    3 +-
 sound/soc/codecs/wm8727.c                          |   12 +-
 sound/soc/codecs/wm8728.c                          |    2 +-
 sound/soc/codecs/wm8731.c                          |    3 +-
 sound/soc/codecs/wm8737.c                          |    3 +-
 sound/soc/codecs/wm8741.c                          |    3 +-
 sound/soc/codecs/wm8750.c                          |    3 +-
 sound/soc/codecs/wm8753.c                          |    5 +-
 sound/soc/codecs/wm8770.c                          |    3 +-
 sound/soc/codecs/wm8776.c                          |   19 +-
 sound/soc/codecs/wm8782.c                          |   12 +-
 sound/soc/codecs/wm8804.c                          |    2 +-
 sound/soc/codecs/wm8900.c                          |    3 +-
 sound/soc/codecs/wm8903.c                          |    7 +-
 sound/soc/codecs/wm8904.c                          |    3 +-
 sound/soc/codecs/wm8940.c                          |    3 +-
 sound/soc/codecs/wm8955.c                          |    3 +-
 sound/soc/codecs/wm8960.c                          |    3 +-
 sound/soc/codecs/wm8961.c                          |    3 +-
 sound/soc/codecs/wm8962.c                          |   12 +-
 sound/soc/codecs/wm8971.c                          |    3 +-
 sound/soc/codecs/wm8974.c                          |    3 +-
 sound/soc/codecs/wm8978.c                          |    3 +-
 sound/soc/codecs/wm8983.c                          |    2 +-
 sound/soc/codecs/wm8985.c                          |    2 +-
 sound/soc/codecs/wm8988.c                          |    3 +-
 sound/soc/codecs/wm8990.c                          |    3 +-
 sound/soc/codecs/wm8991.c                          |    3 +-
 sound/soc/codecs/wm8993.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |   26 +-
 sound/soc/codecs/wm8995.c                          |    6 +-
 sound/soc/codecs/wm8996.c                          |    7 +-
 sound/soc/codecs/wm9081.c                          |    8 +-
 sound/soc/codecs/wm9705.c                          |   14 +-
 sound/soc/codecs/wm9712.c                          |   16 +-
 sound/soc/codecs/wm9713.c                          |   18 +-
 sound/soc/codecs/wm_hubs.c                         |    1 -
 sound/soc/davinci/davinci-i2s.c                    |   14 +-
 sound/soc/davinci/davinci-mcasp.c                  |   14 +-
 sound/soc/davinci/davinci-pcm.c                    |   12 +-
 sound/soc/davinci/davinci-vcif.c                   |   14 +-
 sound/soc/ep93xx/edb93xx.c                         |   12 +-
 sound/soc/ep93xx/ep93xx-ac97.c                     |   14 +-
 sound/soc/ep93xx/ep93xx-i2s.c                      |   15 +-
 sound/soc/ep93xx/ep93xx-pcm.c                      |   13 +-
 sound/soc/ep93xx/simone.c                          |   12 +-
 sound/soc/ep93xx/snappercl15.c                     |   13 +-
 sound/soc/fsl/fsl_dma.c                            |   15 +-
 sound/soc/fsl/fsl_ssi.c                            |   17 +-
 sound/soc/fsl/mpc5200_dma.c                        |   12 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   20 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |   18 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |   24 +-
 sound/soc/imx/imx-pcm-dma-mx2.c                    |   12 +-
 sound/soc/imx/imx-pcm-fiq.c                        |   12 +-
 sound/soc/imx/imx-ssi.c                            |   15 +-
 sound/soc/jz4740/jz4740-i2s.c                      |   14 +-
 sound/soc/jz4740/jz4740-pcm.c                      |   12 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |   12 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   14 +-
 sound/soc/mid-x86/mfld_machine.c                   |   14 +-
 sound/soc/mid-x86/sst_platform.c                   |   14 +-
 sound/soc/mxs/mxs-pcm.c                            |   12 +-
 sound/soc/mxs/mxs-saif.c                           |   14 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |   12 +-
 sound/soc/nuc900/nuc900-ac97.c                     |   15 +-
 sound/soc/nuc900/nuc900-pcm.c                      |   12 +-
 sound/soc/omap/Kconfig                             |    5 +
 sound/soc/omap/Makefile                            |    2 +
 sound/soc/omap/ams-delta.c                         |    2 +-
 sound/soc/omap/omap-dmic.c                         |  549 ++++++++++++++++++++
 sound/soc/omap/omap-dmic.h                         |   69 +++
 sound/soc/omap/omap-hdmi.c                         |   14 +-
 sound/soc/omap/omap-mcbsp.c                        |   14 +-
 sound/soc/omap/omap-mcpdm.c                        |   14 +-
 sound/soc/omap/omap-pcm.c                          |   12 +-
 sound/soc/omap/omap4-hdmi-card.c                   |   12 +-
 sound/soc/omap/sdp4430.c                           |   85 +++-
 sound/soc/pxa/hx4700.c                             |   13 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   13 +-
 sound/soc/pxa/palm27x.c                            |   13 +-
 sound/soc/pxa/pxa-ssp.c                            |   14 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   18 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |   12 +-
 sound/soc/s6000/s6000-i2s.c                        |   14 +-
 sound/soc/s6000/s6000-pcm.c                        |   12 +-
 sound/soc/samsung/Kconfig                          |    6 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/ac97.c                           |   16 +-
 sound/soc/samsung/dma.c                            |   12 +-
 sound/soc/samsung/i2s.c                            |   14 +-
 sound/soc/samsung/idma.c                           |   12 +-
 sound/soc/samsung/littlemill.c                     |  227 ++++++++
 sound/soc/samsung/lowland.c                        |   12 +-
 sound/soc/samsung/pcm.c                            |   14 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   14 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   14 +-
 sound/soc/samsung/s3c24xx_simtec_hermes.c          |   16 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c     |   16 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |   14 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |   14 +-
 sound/soc/samsung/smdk_wm8994.c                    |    1 +
 sound/soc/samsung/spdif.c                          |   14 +-
 sound/soc/samsung/speyside.c                       |   17 +-
 sound/soc/samsung/speyside_wm8962.c                |   13 +-
 sound/soc/sh/dma-sh7760.c                          |   12 +-
 sound/soc/sh/fsi-ak4642.c                          |  127 +----
 sound/soc/sh/fsi-hdmi.c                            |   13 +-
 sound/soc/sh/fsi.c                                 |   15 +-
 sound/soc/sh/hac.c                                 |   14 +-
 sound/soc/sh/siu_dai.c                             |   15 +-
 sound/soc/sh/ssi.c                                 |   14 +-
 sound/soc/soc-core.c                               |   12 +-
 sound/soc/soc-dapm.c                               |   73 +++
 sound/soc/tegra/tegra_das.c                        |   53 +--
 sound/soc/tegra/tegra_i2s.c                        |  137 ++----
 sound/soc/tegra/tegra_i2s.h                        |    1 +
 sound/soc/tegra/tegra_pcm.c                        |   13 +-
 sound/soc/tegra/tegra_spdif.c                      |   14 +-
 sound/soc/tegra/tegra_wm8903.c                     |   79 ++--
 sound/soc/tegra/trimslice.c                        |   45 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |   13 +-
 sound/soc/txx9/txx9aclc.c                          |   12 +-
 210 files changed, 1629 insertions(+), 2476 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra20-das.txt
 delete mode 100644 sound/soc/atmel/playpaq_wm8510.c
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h
 create mode 100644 sound/soc/samsung/littlemill.c
