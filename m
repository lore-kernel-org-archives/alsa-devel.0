From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Wed, 22 Sep 2010 12:52:56 +0100
Message-ID: <20100922115256.GB30657@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 288AF1038DB
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 13:52:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit da5cabf80e2433131bf0ed8993abc0f7ea618c73:

  Linux 2.6.36-rc1 (2010-08-15 17:41:37 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.37

We've now had a reasonable amount of time with the multi-component
changes in -next and any cross-tree issues would probably have been
resolved by now so it seems like a good time to start pushing this into
the main sound tree again.

As well as the multi-component changes there's also quite a few new
drivers here - it's going to be a busy release for ASoC all round.

Arnaud Patard (3):
      ASoC: OpenRD Client : Fix naming breakage due to multicomponent suppo=
rt
      ASoC: kirkwood: add alias to pcm module
      ASoC: Change my mail address

Axel Lin (5):
      ASoC: e740_wm9705 - free gpio in e740_exit()
      ASoC: remove include of pxa2xx-pcm.h in pxa2xx-ac97.c
      ASoC: pxa-ssp: fix a memory leak in pxa_ssp_remove()
      ASoC: soc-core: fix debugfs_pop_time file permissions
      ASoC: ad1980 - set reg_cache_default to ad1980_reg

Chanwoo Choi (2):
      ASoC: multi-component - Add Aquila sound driver
      ASoC: multi-component - Add Goni sound driver

Dimitris Papastamos (6):
      ARM: S3C64XX: Fix fallthrough bug in i2sv3 gpio configuration, improv=
e logging
      ASoC: Fix incorrect register cache size configuration
      ASoC: Fix off-by-one bug in WM8962 register cache size configuration
      ASoC: WM8985: Initial driver
      ASoC: Fix soc-cache buffer overflow bug
      ASoC: Fix soc-cache buffer overflow bug

Dzianis Kahanovich (1):
      ASoC: Add device table to SH FSI driver

G, Manjunath Kondaiah (1):
      OMAP: McBSP: Fix static function warning

Guennadi Liakhovetski (4):
      ASoC: fix clkdev API usage in sh/migor.c
      ASoC: fix compile breakage of the sh/siu driver
      sh: fix an SIU device name mismatch
      ASoC: fix SIU driver breakage, occurred during the multi-component tr=
ansition

Haojian Zhuang (5):
      ASoC: fix pxa2xx-pcm.h path
      ASoC: update setting for pxa ssp slave mode
      ASoC: add 88pm860x codec driver
      ASoC: add tavorevb3 machine driver for 88pm860x
      ASoC: add saarb machine driver for 88pm860x

Ian Lartey (6):
      ASoC: multi-component: Fix reference to moved header file, which was =
unused anyway.
      ASoC: pxa2xx-i2s is the proper name of the I2S DAI, not pxa-i2s.
      ASoC: Make codec dai naming for WM8741 consistent
      ASoC: Enable autoloading of pxa2xx CPU I2S driver with module alias
      ASoC: Complete supported clock ratios and rate constraints for wm8741
      ASoC: Added a missing 32-bit PCM format, to the wm8994 codec.

Janusz Krzysztofik (1):
      ASoC: Use a more adequate name for the CX20442 codec DAI

Jarkko Nikula (21):
      ASoC: multi-component - Drop board-n8x0.c changes
      ASoC: Fix tlv320aic3x GPIO initialization
      ASoC: omap: rx51: Use gpio_set_value_cansleep for speaker amp control
      omap: rx51: Remove redefinition of rx51_aic3x_data
      ASoC: tlv320aic3x: Fix remaining output pin switch names
      ASoC: tlv320aic3x: Sort output pin control registers in header file
      ASoC: tlv320aic3x: Reimplement output mixers
      ASoC: tlv320aic3x: Sanitize output controls
      ASoC: Swap bias level enumeration
      ASoC: tlv320aic3x: Fix null pointer dereference when pdata is not set
      ASoC: tlv320aic3x: Optimize PLL programming in aic3x_set_bias_level
      ASoC: Remove needless codec->bias_level assignment to SND_SOC_BIAS_OFF
      ASoC: tlv320aic3x: Use snd_soc_read and snd_soc_write
      ASoC: tlv320aic3x: Switch to soc-cache helpers
      ASoC: tlv320aic3x: Complete the soc-cache conversion
      ASoC: tlv320aic3x: Add virtual output pin Detection
      ASoC: tlv320aic3x: Move regulator management from i2c to soc domain
      ASoC: tlv320aic3x: Add runtime regulator control to aic3x_set_bias_le=
vel
      ASoC: tlv320aic3x: Use regulator notifiers for optimizing the cache s=
ync
      ASoC: tlv320aic3x: Let the codec hit SND_SOC_BIAS_OFF when idle
      ASoC: Remove extra rtd->dev.init_name assignment in soc_probe_dai_link

Jassi Brar (3):
      ASoC: S3C: AC97: Remove the -dai suffix
      ASoC: Samsung: Debug PCM platform device name
      ASoC: Samsung: Debug PCM snd_soc_dai_driver registration

Jiri Slaby (1):
      ASoC: wm8753, remove dead code

Julia Lawall (1):
      ASoC: pl022_ds.c: Add of_node_put to avoid memory leak

Kuninori Morimoto (22):
      ASoC: fsi: modify compile error
      ASoC: fsi-ak4642/fsi-da7210: modify dai link settings for card detect
      fbdev: sh-mobile: Add HDMI sound type selection
      ASoC: fsi-codec: Add FSI - HDMI support
      ASoC: Add sh_mobile_hdmi sound support
      ASoC: ak4642: Revive ak4642_snd_controls
      ASoC: fsi-ak4642: modify platform_name
      ASoC: fsi codecs: modify menu attribute on Kconfig
      fbdev: sh_mobile_hdmi: modify noisy comment out
      fbdev: sh_mobile_hdmi: modify flags name to more specific
      fbdev: sh_mobile_hdmi: modify snd_soc_dai_driver settings
      fbdev: sh_mobile_hdmi: add new label for sound error path
      ASoC: fsi-hdmi: remove unneeded header
      fbdev: sh_mobile_hdmi: Add select SND_SOC to Kconfig
      ASoC: fsi codecs: Update card name field
      ASoC: ak4642: code clean up
      ASoC: da7210: code clean up
      ASoC: fsi: Add fsi_dma_get_area
      ASoC: fsi: modify noisy comment out
      ASoC: fsi: Add fsi_dma_soft_push/pop function
      ASoC: fsi: modify variable name to easy to understand
      ASoC: fsi: merge fsi_data_push/pop to fsi_fifo_data_ctrl

Lars-Peter Clausen (1):
      ASoC: Multi-component: JZ4740: QI_LB60 board fixes

Liam Girdwood (7):
      ASoC: multi-component - ASoC Multi-Component Support
      ASoC: core - fix build warning on x86_64
      ASoC: core - fix build warning on x86_64
      Merge remote branch 'broonie-asoc/for-2.6.37' into for-2.6.37
      Merge remote branch 'broonie-asoc/for-2.6.37' into for-2.6.37
      Merge remote branch 'broonie-asoc/for-2.6.37' into for-2.6.37
      Merge remote branch 'asoc/for-2.6.37' into for-2.6.37

Manuel Lauss (1):
      ASoC: fix au1x platform

Mark Brown (57):
      ASoC: Add initial WM8962 CODEC driver
      ASoC: Remove /s from widget names on SMDK64xx WM8580
      ASoC: Document CFG switch settings for SMDK6410 WM8580 usage
      ASoC: Correct WM8580 Capture control names
      ASoC: Remove version display from WM8510 driver
      ASoC: Remove unneeded control_data management from Wolfson drivers
      ASoC: Remove version display from WM8971 driver
      ASoC: Add MODULE_ALIAS to Samsung DAI drivers
      ASoC: Automatically determine control_data for soc-cache users
      Merge branch 'topic/multi-component' of git://git.kernel.org/.../lrg/=
asoc-2.6 into for-2.6.37
      ASoC: Update WM8962 to build with multi-component
      ASoC: Staticise WM8727 codec driver structure
      ASoC: Remove unused driver data from WM8961 probe
      ASoC: Set up debugfs only once per CODEC
      ASoC: Remove redundant device name from debugfs directory
      ASoC: Add a bit of resource unwinding in the S3C IISv4 driver
      ASoC: Convert WM8580 hw_params to use snd_soc_update_bits()
      ASoC: Remove unused rate selection bitmasks from WM8580
      ASoC: Automatically calculate clock ratio for WM8580
      ASoC: Implement BCLK rate selection for WM8580
      ASoC: Fix inverted WM8580 capture mute control
      ASoC: Automatically manage WM8580 DAC OSR
      Merge branch 'for-2.6.36' of git://git.kernel.org/.../broonie/sound-2=
.6 into for-2.6.37
      ASoC: Remove DSP mode support for WM8776
      Merge branch 'for-2.6.36' into for-2.6.37
      ASoC: Fix WM8580 CLKSEL mask selection
      ASoC: Fix argument ordering for snd_soc_update_bits() in WM8580
      ASoC: Remove unused WM8974 private data
      ASoC: Fix a few more PXA build errors
      ASoC: Support non-crystal master clocks for WM8731
      ASoC: Support non-crystal master clocks for WM8731
      ASoC: Fix device name for AT91SAM9G20-EK devices
      ASoC: Add simplfied device registration for Atmel SSC devices
      ASoC: Don't call DAI registration for CODECs with no DAI
      Merge branch 'for-2.6.37' of git://git.kernel.org/.../lrg/asoc-2.6 in=
to for-2.6.37
      ASoC: Log WM8994 separate ADC LRCLKs every time we configure
      ASoC: Add build infrastructure for WL1273
      Merge branch 'for-2.6.36' into for-2.6.37
      Merge remote branch 'broonie-asoc/for-2.6.37' into for-2.6.37
      Merge branch 'for-2.6.36' into for-2.6.37
      ASoC: Implement WM8994 DAC data source muxes
      ASoC: Add event variants of the AIF widgets
      Merge branch 'for-2.6.37' of git://git.kernel.org/.../lrg/asoc-2.6 in=
to for-2.6.37
      ASoC: Fix cut'n'paste comment in WM8994
      ASoC: Staticise WM9712 DAI list
      ASoC: Remove export of CS4270 DAI
      ASoC: Set more meaningful name for SMDK64xx WM8580 audio
      ASoC: Add debugfs listing of registered CODECs
      ASoC: Add DAI list to debugfs
      ASoC: Add platform listing to debugfs
      Merge branch 'for-2.6.36' into for-2.6.37
      ASoC: Fix WM8978/migor driver name conflict
      ASoC: Prototype s3c64xx_i2s_get_clock()
      ASoC: Report error code when failing to add controls
      ASoC: Fix merge issue with WM8962 control addition
      Merge branch 'for-2.6.36' into for-2.6.37
      Merge branch 'for-2.6.37' of git://git.kernel.org/.../lrg/asoc-2.6 in=
to for-2.6.37

Matti J. Aaltonen (2):
      ASoC: TI WL1273 FM Radio Codec.
      ASoC: WL1273 FM Radio: Eliminate unnecessary error return value.

Peter Ujfalusi (1):
      ASoC: multi-component: TWL4030: Restore registers on removal

Randolph Chung (2):
      ASoC: Configure symmetric rates for tlv320aic3x
      ASoC: Add support for tlv320aic3007 to tlv320aic3x codec.

Sascha Hauer (1):
      ASoC: i.MX ssi: use SSI_STCCR in synchronous mode

Seungwhan Youn (2):
      ASoC: S3C: Fix PCM RX FIFO settings
      ASoC: S3C: Fix PCM TXFIFO_DIPSTICK value

Timur Tabi (8):
      powerpc: rename immap_86xx.h to fsl_guts.h, and add 85xx support
      asoc/multi-component: fsl: add support for 36-bit physical addresses
      asoc/multi-component: fsl: fix exit and error paths in DMA and SSI dr=
ivers
      asoc/multi-component: fsl: add support for disabled SSI nodes
      asoc/multi-component: fsl: add support for variable SSI FIFO depth
      ASoC: add support for separate codec DAIs to the fsl_dma driver
      ASoC: add support for the Freescale P1022 DS reference board
      ASoC: mpc8610: replace of_device with platform_device

Uwe Kleine-K=F6nig (1):
      ASoC: ad1980: remove unneeded function declaration

Vasily Khoruzhick (7):
      ASoC: uda1380: make driver more powersave-friendly
      ASoC: Add HP iPAQ RX1950 support
      ARM: S3C24XX: I2S multi-component-related fixes
      ASoC: rx1950: check that machine is rx1950 in glue driver
      ASoC: rx1950: remove unnecessary headers
      ASoC: UDA1380: Add delay between power on and reset
      ASoC: rx1950: Fix clkdiv for 16khz and 48khz

 arch/arm/mach-davinci/devices.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                        |    6 +
 arch/arm/mach-kirkwood/common.c                    |    6 +
 arch/arm/mach-mx3/clock-imx31.c                    |    4 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    4 +-
 arch/arm/mach-mx3/devices.c                        |    4 +-
 arch/arm/mach-omap1/devices.c                      |   26 +
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   17 +-
 arch/arm/mach-omap2/board-zoom2.c                  |   28 +-
 arch/arm/mach-omap2/devices.c                      |   39 +
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    2 +
 arch/arm/mach-pxa/devices.c                        |   25 +
 arch/arm/mach-pxa/devices.h                        |    6 +
 arch/arm/mach-pxa/pxa27x.c                         |    4 +
 arch/arm/mach-pxa/pxa3xx.c                         |    5 +
 arch/arm/mach-pxa/zylonite.c                       |   11 +
 arch/arm/mach-s3c64xx/dev-audio.c                  |   20 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 +
 arch/arm/plat-mxc/audmux-v2.c                      |    4 +-
 arch/arm/plat-omap/include/plat/mcbsp.h            |    7 +
 arch/arm/plat-s3c24xx/devs.c                       |   34 +-
 arch/arm/plat-samsung/include/plat/devs.h          |    2 +
 arch/mips/alchemy/devboards/db1200/platform.c      |    6 +
 arch/powerpc/boot/dts/mpc8610_hpcd.dts             |    1 +
 .../include/asm/{immap_86xx.h =3D> fsl_guts.h}       |  111 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |    2 +-
 drivers/input/misc/twl4030-vibra.c                 |    4 +-
 drivers/mfd/twl-core.c                             |    6 +-
 drivers/mfd/twl4030-codec.c                        |    8 +-
 drivers/staging/xgifb/TODO                         |    2 +-
 drivers/video/Kconfig                              |    1 +
 drivers/video/sh_mobile_hdmi.c                     |   84 +-
 include/linux/i2c/twl.h                            |    6 +-
 include/sound/sh_fsi.h                             |    3 -
 include/sound/soc-dai.h                            |   98 +-
 include/sound/soc-dapm.h                           |   18 +-
 include/sound/soc-of-simple.h                      |   25 -
 include/sound/soc.h                                |  242 +-
 include/sound/tlv320aic3x.h                        |   43 +-
 include/sound/wm8962.h                             |   23 +
 include/video/sh_mobile_hdmi.h                     |   16 +
 sound/soc/atmel/atmel-pcm.c                        |   59 +-
 sound/soc/atmel/atmel-pcm.h                        |    3 -
 sound/soc/atmel/atmel_ssc_dai.c                    |  148 +-
 sound/soc/atmel/atmel_ssc_dai.h                    |    3 +-
 sound/soc/atmel/playpaq_wm8510.c                   |   65 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   59 +-
 sound/soc/atmel/snd-soc-afeb9260.c                 |   35 +-
 sound/soc/au1x/db1200.c                            |   39 +-
 sound/soc/au1x/dbdma2.c                            |   95 +-
 sound/soc/au1x/psc-ac97.c                          |   71 +-
 sound/soc/au1x/psc-i2s.c                           |   53 +-
 sound/soc/au1x/psc.h                               |   10 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |   43 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.h                |    3 -
 sound/soc/blackfin/bf5xx-ac97.c                    |   41 +-
 sound/soc/blackfin/bf5xx-ac97.h                    |    2 -
 sound/soc/blackfin/bf5xx-ad1836.c                  |   23 +-
 sound/soc/blackfin/bf5xx-ad193x.c                  |   23 +-
 sound/soc/blackfin/bf5xx-ad1980.c                  |   19 +-
 sound/soc/blackfin/bf5xx-ad73311.c                 |   22 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |   44 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.h                 |    3 -
 sound/soc/blackfin/bf5xx-i2s.c                     |   45 +-
 sound/soc/blackfin/bf5xx-i2s.h                     |   14 -
 sound/soc/blackfin/bf5xx-ssm2602.c                 |   38 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c                 |   43 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.h                 |    3 -
 sound/soc/blackfin/bf5xx-tdm.c                     |   15 +-
 sound/soc/blackfin/bf5xx-tdm.h                     |    2 -
 sound/soc/codecs/88pm860x-codec.c                  | 1486 +
 sound/soc/codecs/88pm860x-codec.h                  |   97 +
 sound/soc/codecs/Kconfig                           |   16 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/ac97.c                            |  124 +-
 sound/soc/codecs/ac97.h                            |   19 -
 sound/soc/codecs/ad1836.c                          |  191 +-
 sound/soc/codecs/ad1836.h                          |    2 -
 sound/soc/codecs/ad193x.c                          |  217 +-
 sound/soc/codecs/ad193x.h                          |    3 -
 sound/soc/codecs/ad1980.c                          |  113 +-
 sound/soc/codecs/ad1980.h                          |    3 -
 sound/soc/codecs/ad73311.c                         |   66 +-
 sound/soc/codecs/ad73311.h                         |    2 -
 sound/soc/codecs/ads117x.c                         |   72 +-
 sound/soc/codecs/ads117x.h                         |    4 +-
 sound/soc/codecs/ak4104.c                          |  149 +-
 sound/soc/codecs/ak4104.h                          |    7 -
 sound/soc/codecs/ak4535.c                          |  236 +-
 sound/soc/codecs/ak4535.h                          |    8 -
 sound/soc/codecs/ak4642.c                          |  171 +-
 sound/soc/codecs/ak4642.h                          |   20 -
 sound/soc/codecs/ak4671.c                          |  140 +-
 sound/soc/codecs/ak4671.h                          |    3 -
 sound/soc/codecs/cq93vc.c                          |  132 +-
 sound/soc/codecs/cq93vc.h                          |   29 -
 sound/soc/codecs/cs4270.c                          |  394 +-
 sound/soc/codecs/cs4270.h                          |   28 -
 sound/soc/codecs/cs42l51.c                         |  295 +-
 sound/soc/codecs/cs42l51.h                         |    2 -
 sound/soc/codecs/cx20442.c                         |  173 +-
 sound/soc/codecs/cx20442.h                         |    2 -
 sound/soc/codecs/da7210.c                          |  163 +-
 sound/soc/codecs/da7210.h                          |   24 -
 sound/soc/codecs/jz4740.c                          |  116 +-
 sound/soc/codecs/jz4740.h                          |   20 -
 sound/soc/codecs/pcm3008.c                         |   92 +-
 sound/soc/codecs/pcm3008.h                         |    3 -
 sound/soc/codecs/spdif_transciever.c               |  102 +-
 sound/soc/codecs/spdif_transciever.h               |   18 -
 sound/soc/codecs/ssm2602.c                         |  218 +-
 sound/soc/codecs/ssm2602.h                         |    3 -
 sound/soc/codecs/stac9766.c                        |  118 +-
 sound/soc/codecs/stac9766.h                        |    4 -
 sound/soc/codecs/tlv320aic23.c                     |  182 +-
 sound/soc/codecs/tlv320aic23.h                     |    3 -
 sound/soc/codecs/tlv320aic26.c                     |  180 +-
 sound/soc/codecs/tlv320aic26.h                     |    3 -
 sound/soc/codecs/tlv320aic3x.c                     | 1230 +-
 sound/soc/codecs/tlv320aic3x.h                     |  100 +-
 sound/soc/codecs/tlv320dac33.c                     |  248 +-
 sound/soc/codecs/tlv320dac33.h                     |    3 -
 sound/soc/codecs/twl4030.c                         |  228 +-
 sound/soc/codecs/twl4030.h                         |   55 -
 sound/soc/codecs/twl6040.c                         |  170 +-
 sound/soc/codecs/twl6040.h                         |    3 -
 sound/soc/codecs/uda134x.c                         |  154 +-
 sound/soc/codecs/uda134x.h                         |    3 -
 sound/soc/codecs/uda1380.c                         |  331 +-
 sound/soc/codecs/uda1380.h                         |    3 -
 sound/soc/codecs/wl1273.c                          |  528 +
 sound/soc/codecs/wl1273.h                          |  101 +
 sound/soc/codecs/wm2000.h                          |    3 -
 sound/soc/codecs/wm8350.c                          |  231 +-
 sound/soc/codecs/wm8350.h                          |    3 -
 sound/soc/codecs/wm8400.c                          |  181 +-
 sound/soc/codecs/wm8400.h                          |    3 -
 sound/soc/codecs/wm8510.c                          |  289 +-
 sound/soc/codecs/wm8510.h                          |    3 -
 sound/soc/codecs/wm8523.c                          |  177 +-
 sound/soc/codecs/wm8523.h                          |    3 -
 sound/soc/codecs/wm8580.c                          |  325 +-
 sound/soc/codecs/wm8580.h                          |   17 +-
 sound/soc/codecs/wm8711.c                          |  202 +-
 sound/soc/codecs/wm8711.h                          |    3 -
 sound/soc/codecs/wm8727.c                          |  106 +-
 sound/soc/codecs/wm8727.h                          |   21 -
 sound/soc/codecs/wm8728.c                          |  290 +-
 sound/soc/codecs/wm8728.h                          |    9 -
 sound/soc/codecs/wm8731.c                          |  244 +-
 sound/soc/codecs/wm8731.h                          |    7 +-
 sound/soc/codecs/wm8741.c                          |  378 +-
 sound/soc/codecs/wm8741.h                          |    3 -
 sound/soc/codecs/wm8750.c                          |  265 +-
 sound/soc/codecs/wm8750.h                          |    9 -
 sound/soc/codecs/wm8753.c                          |  405 +-
 sound/soc/codecs/wm8753.h                          |    3 -
 sound/soc/codecs/wm8776.c                          |  254 +-
 sound/soc/codecs/wm8776.h                          |    3 -
 sound/soc/codecs/wm8900.c                          |  247 +-
 sound/soc/codecs/wm8900.h                          |    3 -
 sound/soc/codecs/wm8903.c                          |  265 +-
 sound/soc/codecs/wm8903.h                          |    3 -
 sound/soc/codecs/wm8904.c                          |  208 +-
 sound/soc/codecs/wm8904.h                          |    3 -
 sound/soc/codecs/wm8940.c                          |  199 +-
 sound/soc/codecs/wm8940.h                          |    2 -
 sound/soc/codecs/wm8955.c                          |  181 +-
 sound/soc/codecs/wm8955.h                          |    3 -
 sound/soc/codecs/wm8960.c                          |  209 +-
 sound/soc/codecs/wm8960.h                          |    3 -
 sound/soc/codecs/wm8961.c                          |  237 +-
 sound/soc/codecs/wm8961.h                          |    3 -
 sound/soc/codecs/wm8962-tables.c                   |42299 ++++++++++++++++=
++++
 sound/soc/codecs/wm8962.c                          | 1857 +
 sound/soc/codecs/wm8962.h                          | 3787 ++
 sound/soc/codecs/wm8971.c                          |  247 +-
 sound/soc/codecs/wm8971.h                          |    8 -
 sound/soc/codecs/wm8974.c                          |  167 +-
 sound/soc/codecs/wm8974.h                          |    3 -
 sound/soc/codecs/wm8978.c                          |  190 +-
 sound/soc/codecs/wm8978.h                          |    3 -
 sound/soc/codecs/wm8985.c                          | 1195 +
 sound/soc/codecs/wm8985.h                          | 1045 +
 sound/soc/codecs/wm8988.c                          |  262 +-
 sound/soc/codecs/wm8988.h                          |    3 -
 sound/soc/codecs/wm8990.c                          |  223 +-
 sound/soc/codecs/wm8990.h                          |    8 -
 sound/soc/codecs/wm8993.c                          |  304 +-
 sound/soc/codecs/wm8993.h                          |    3 -
 sound/soc/codecs/wm8994.c                          |  266 +-
 sound/soc/codecs/wm8994.h                          |    3 -
 sound/soc/codecs/wm9081.c                          |  208 +-
 sound/soc/codecs/wm9081.h                          |    3 -
 sound/soc/codecs/wm9090.c                          |  183 +-
 sound/soc/codecs/wm9090.h                          |    2 -
 sound/soc/codecs/wm9705.c                          |  116 +-
 sound/soc/codecs/wm9705.h                          |    3 -
 sound/soc/codecs/wm9712.c                          |  124 +-
 sound/soc/codecs/wm9712.h                          |    3 -
 sound/soc/codecs/wm9713.c                          |  131 +-
 sound/soc/codecs/wm9713.h                          |    3 -
 sound/soc/davinci/davinci-evm.c                    |  109 +-
 sound/soc/davinci/davinci-i2s.c                    |   44 +-
 sound/soc/davinci/davinci-i2s.h                    |    2 -
 sound/soc/davinci/davinci-mcasp.c                  |   32 +-
 sound/soc/davinci/davinci-mcasp.h                  |    2 -
 sound/soc/davinci/davinci-pcm.c                    |   45 +-
 sound/soc/davinci/davinci-pcm.h                    |    3 -
 sound/soc/davinci/davinci-sffsdr.c                 |   27 +-
 sound/soc/davinci/davinci-vcif.c                   |   25 +-
 sound/soc/davinci/davinci-vcif.h                   |   28 -
 sound/soc/ep93xx/ep93xx-i2s.c                      |   34 +-
 sound/soc/ep93xx/ep93xx-i2s.h                      |   18 -
 sound/soc/ep93xx/ep93xx-pcm.c                      |   37 +-
 sound/soc/ep93xx/ep93xx-pcm.h                      |    2 -
 sound/soc/ep93xx/snappercl15.c                     |   24 +-
 sound/soc/fsl/Kconfig                              |   27 +-
 sound/soc/fsl/Makefile                             |   11 +-
 sound/soc/fsl/efika-audio-fabric.c                 |   20 +-
 sound/soc/fsl/fsl_dma.c                            |  458 +-
 sound/soc/fsl/fsl_dma.h                            |   20 -
 sound/soc/fsl/fsl_ssi.c                            |  298 +-
 sound/soc/fsl/fsl_ssi.h                            |   26 -
 sound/soc/fsl/mpc5200_dma.c                        |   66 +-
 sound/soc/fsl/mpc5200_dma.h                        |    5 -
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   34 +-
 sound/soc/fsl/mpc5200_psc_ac97.h                   |    2 -
 sound/soc/fsl/mpc5200_psc_i2s.c                    |   19 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |  660 +-
 sound/soc/fsl/p1022_ds.c                           |  591 +
 sound/soc/fsl/pcm030-audio-fabric.c                |   21 +-
 sound/soc/fsl/soc-of-simple.c                      |  172 -
 sound/soc/imx/Kconfig                              |   16 +
 sound/soc/imx/Makefile                             |   10 +-
 sound/soc/imx/eukrea-tlv320.c                      |   16 +-
 sound/soc/imx/imx-pcm-dma-mx2.c                    |   43 +-
 sound/soc/imx/imx-pcm-fiq.c                        |   68 +-
 sound/soc/imx/imx-ssi.c                            |  151 +-
 sound/soc/imx/imx-ssi.h                            |    7 +-
 sound/soc/imx/phycore-ac97.c                       |   19 +-
 sound/soc/imx/wm1133-ev1.c                         |   27 +-
 sound/soc/jz4740/jz4740-i2s.c                      |  104 +-
 sound/soc/jz4740/jz4740-i2s.h                      |    2 -
 sound/soc/jz4740/jz4740-pcm.c                      |   18 +-
 sound/soc/jz4740/jz4740-pcm.h                      |    2 -
 sound/soc/jz4740/qi_lb60.c                         |   25 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |   69 +-
 sound/soc/kirkwood/kirkwood-dma.h                  |   17 -
 sound/soc/kirkwood/kirkwood-i2s.c                  |   55 +-
 sound/soc/kirkwood/kirkwood-i2s.h                  |   17 -
 sound/soc/kirkwood/kirkwood-openrd.c               |   24 +-
 sound/soc/nuc900/nuc900-ac97.c                     |   12 +-
 sound/soc/nuc900/nuc900-audio.c                    |   16 +-
 sound/soc/nuc900/nuc900-audio.h                    |    4 -
 sound/soc/nuc900/nuc900-pcm.c                      |   38 +-
 sound/soc/omap/am3517evm.c                         |   25 +-
 sound/soc/omap/ams-delta.c                         |   98 +-
 sound/soc/omap/igep0020.c                          |   22 +-
 sound/soc/omap/mcpdm.c                             |   19 +-
 sound/soc/omap/mcpdm.h                             |    2 +
 sound/soc/omap/n810.c                              |   42 +-
 sound/soc/omap/omap-mcbsp.c                        |  125 +-
 sound/soc/omap/omap-mcbsp.h                        |    2 -
 sound/soc/omap/omap-mcpdm.c                        |   71 +-
 sound/soc/omap/omap-mcpdm.h                        |   29 -
 sound/soc/omap/omap-pcm.c                          |   47 +-
 sound/soc/omap/omap-pcm.h                          |    2 -
 sound/soc/omap/omap2evm.c                          |   25 +-
 sound/soc/omap/omap3beagle.c                       |   23 +-
 sound/soc/omap/omap3evm.c                          |   30 +-
 sound/soc/omap/omap3pandora.c                      |   36 +-
 sound/soc/omap/osk5912.c                           |   24 +-
 sound/soc/omap/overo.c                             |   22 +-
 sound/soc/omap/rx51.c                              |   41 +-
 sound/soc/omap/sdp3430.c                           |   56 +-
 sound/soc/omap/sdp4430.c                           |   23 +-
 sound/soc/omap/zoom2.c                             |   64 +-
 sound/soc/pxa/Kconfig                              |   18 +
 sound/soc/pxa/Makefile                             |    4 +
 sound/soc/pxa/corgi.c                              |   28 +-
 sound/soc/pxa/e740_wm9705.c                        |   29 +-
 sound/soc/pxa/e750_wm9705.c                        |   26 +-
 sound/soc/pxa/e800_wm9712.c                        |   26 +-
 sound/soc/pxa/em-x270.c                            |   22 +-
 sound/soc/pxa/imote2.c                             |   20 +-
 sound/soc/pxa/magician.c                           |   35 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   33 +-
 sound/soc/pxa/palm27x.c                            |   27 +-
 sound/soc/pxa/poodle.c                             |   29 +-
 sound/soc/pxa/pxa-ssp.c                            |  174 +-
 sound/soc/pxa/pxa-ssp.h                            |    2 -
 sound/soc/pxa/pxa2xx-ac97.c                        |   46 +-
 sound/soc/pxa/pxa2xx-ac97.h                        |    2 -
 sound/soc/pxa/pxa2xx-i2s.c                         |   91 +-
 sound/soc/pxa/pxa2xx-i2s.h                         |    2 -
 sound/soc/pxa/pxa2xx-pcm.c                         |   46 +-
 sound/soc/pxa/pxa2xx-pcm.h                         |   19 -
 sound/soc/pxa/raumfeld.c                           |  114 +-
 sound/soc/pxa/saarb.c                              |  200 +
 sound/soc/pxa/spitz.c                              |   26 +-
 sound/soc/pxa/tavorevb3.c                          |  200 +
 sound/soc/pxa/tosa.c                               |   27 +-
 sound/soc/pxa/z2.c                                 |   26 +-
 sound/soc/pxa/zylonite.c                           |   40 +-
 sound/soc/s3c24xx/Kconfig                          |   26 +
 sound/soc/s3c24xx/Makefile                         |    6 +
 sound/soc/s3c24xx/aquila_wm8994.c                  |  295 +
 sound/soc/s3c24xx/goni_wm8994.c                    |  298 +
 sound/soc/s3c24xx/jive_wm8750.c                    |   23 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c               |   17 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c           |   58 +-
 sound/soc/s3c24xx/neo1973_wm8753.c                 |   37 +-
 sound/soc/s3c24xx/rx1950_uda1380.c                 |  333 +
 sound/soc/s3c24xx/s3c-ac97.c                       |   22 +-
 sound/soc/s3c24xx/s3c-ac97.h                       |    2 -
 sound/soc/s3c24xx/s3c-dma.c                        |   46 +-
 sound/soc/s3c24xx/s3c-dma.h                        |    1 -
 sound/soc/s3c24xx/s3c-i2s-v2.c                     |   50 +-
 sound/soc/s3c24xx/s3c-i2s-v2.h                     |   13 +-
 sound/soc/s3c24xx/s3c-pcm.c                        |   54 +-
 sound/soc/s3c24xx/s3c-pcm.h                        |    3 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                    |   54 +-
 sound/soc/s3c24xx/s3c2412-i2s.h                    |    2 -
 sound/soc/s3c24xx/s3c24xx-i2s.c                    |   40 +-
 sound/soc/s3c24xx/s3c24xx-i2s.h                    |    2 -
 sound/soc/s3c24xx/s3c24xx_simtec.c                 |   15 +-
 sound/soc/s3c24xx/s3c24xx_simtec.h                 |    4 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c          |   25 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c     |   21 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c                |   21 +-
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c                 |  135 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |  206 +-
 sound/soc/s3c24xx/s3c64xx-i2s.h                    |    3 +-
 sound/soc/s3c24xx/smartq_wm8987.c                  |   15 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c                |   17 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c                |   68 +-
 sound/soc/s3c24xx/smdk_wm9713.c                    |   38 +-
 sound/soc/s6000/s6000-i2s.c                        |   56 +-
 sound/soc/s6000/s6000-i2s.h                        |    2 -
 sound/soc/s6000/s6000-pcm.c                        |  100 +-
 sound/soc/s6000/s6000-pcm.h                        |    2 -
 sound/soc/s6000/s6105-ipcam.c                      |   31 +-
 sound/soc/sh/Kconfig                               |   11 +-
 sound/soc/sh/Makefile                              |    2 +
 sound/soc/sh/dma-sh7760.c                          |   53 +-
 sound/soc/sh/fsi-ak4642.c                          |   31 +-
 sound/soc/sh/fsi-da7210.c                          |   24 +-
 sound/soc/sh/fsi-hdmi.c                            |   60 +
 sound/soc/sh/fsi.c                                 |  475 +-
 sound/soc/sh/hac.c                                 |   46 +-
 sound/soc/sh/migor.c                               |   44 +-
 sound/soc/sh/sh7760-ac97.c                         |   25 +-
 sound/soc/sh/siu.h                                 |    6 +-
 sound/soc/sh/siu_dai.c                             |   97 +-
 sound/soc/sh/siu_pcm.c                             |   32 +-
 sound/soc/sh/ssi.c                                 |   55 +-
 sound/soc/soc-cache.c                              |   47 +-
 sound/soc/soc-core.c                               | 1778 +-
 sound/soc/soc-dapm.c                               |   88 +-
 sound/soc/soc-jack.c                               |   10 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |   55 +-
 sound/soc/txx9/txx9aclc-generic.c                  |   24 +-
 sound/soc/txx9/txx9aclc.c                          |  141 +-
 sound/soc/txx9/txx9aclc.h                          |   13 +-
 365 files changed, 64892 insertions(+), 14388 deletions(-)
 rename arch/powerpc/include/asm/{immap_86xx.h =3D> fsl_guts.h} (66%)
 delete mode 100644 include/sound/soc-of-simple.h
 create mode 100644 include/sound/wm8962.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.h
 create mode 100644 sound/soc/codecs/88pm860x-codec.c
 create mode 100644 sound/soc/codecs/88pm860x-codec.h
 delete mode 100644 sound/soc/codecs/ac97.h
 delete mode 100644 sound/soc/codecs/ak4104.h
 delete mode 100644 sound/soc/codecs/ak4642.h
 delete mode 100644 sound/soc/codecs/cq93vc.h
 delete mode 100644 sound/soc/codecs/cs4270.h
 delete mode 100644 sound/soc/codecs/da7210.h
 delete mode 100644 sound/soc/codecs/jz4740.h
 delete mode 100644 sound/soc/codecs/spdif_transciever.h
 delete mode 100644 sound/soc/codecs/twl4030.h
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h
 delete mode 100644 sound/soc/codecs/wm8727.h
 create mode 100644 sound/soc/codecs/wm8962-tables.c
 create mode 100644 sound/soc/codecs/wm8962.c
 create mode 100644 sound/soc/codecs/wm8962.h
 create mode 100644 sound/soc/codecs/wm8985.c
 create mode 100644 sound/soc/codecs/wm8985.h
 delete mode 100644 sound/soc/davinci/davinci-vcif.h
 delete mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/fsl/p1022_ds.c
 delete mode 100644 sound/soc/fsl/soc-of-simple.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-dma.h
 delete mode 100644 sound/soc/kirkwood/kirkwood-i2s.h
 delete mode 100644 sound/soc/omap/omap-mcpdm.h
 delete mode 100644 sound/soc/pxa/pxa2xx-pcm.h
 create mode 100644 sound/soc/pxa/saarb.c
 create mode 100644 sound/soc/pxa/tavorevb3.c
 create mode 100644 sound/soc/s3c24xx/aquila_wm8994.c
 create mode 100644 sound/soc/s3c24xx/goni_wm8994.c
 create mode 100644 sound/soc/s3c24xx/rx1950_uda1380.c
 create mode 100644 sound/soc/sh/fsi-hdmi.c
