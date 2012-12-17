From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.8
Date: Mon, 17 Dec 2012 22:14:10 +0900
Message-ID: <20121217131410.GB4985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3088881284457619486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 334DD2616F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 14:22:36 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3088881284457619486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 29594404d7fe73cd80eaa4ee8c43dcc53970c60e:

  Linux 3.7 (2012-12-10 19:30:57 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

for you to fetch changes up to 8246b5b03ef4ab6f29ad8edad859c74b124323cb:

  Merge remote-tracking branch 'asoc/topic/tpa6130a2' into asoc-next (2012-12-15 23:56:46 +0900)

----------------------------------------------------------------

ASoC: More updates for v3.8

Nothing terribly exciting here, just small localised changes.

As well as fixes there are a couple of Cirrus changes and one devm_
change which were in prior to the merge window but got missed from the
original pull to Takashi.

----------------------------------------------------------------

(Diff inflated by other changes in Linus' tree AFAICT)

Bo Shen (1):
      ASoC: atmel-ssc: change disable to disable in dts node

Lars-Peter Clausen (1):
      ASoC: sigmadsp: Fix endianness conversion issue

Mark Brown (7):
      ASoC: core: Fix splitting of log messages
      Merge remote-tracking branch 'asoc/fix/sigmadsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l73' into asoc-next
      Merge remote-tracking branch 'asoc/topic/log' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tpa6130a2' into asoc-next

Misael Lopez Cruz (1):
      ASoC: Prevent pop_wait overwrite

Paul Handrigan (3):
      ASoC: cs42l73: Add DMIC's as DAPM inputs.
      ASoC: cs42l73: Add DAPM events for power down.
      ASoC: cs42l73: Change VSPIN/VSPOUT to VSPINOUT

Sachin Kamat (1):
      ASoC: tpa6130a2: Use devm_* APIs

 .../devicetree/bindings/misc/atmel-ssc.txt         |   15 +
 Documentation/devicetree/bindings/sound/ak4104.txt |   22 +
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 +
 Documentation/devicetree/bindings/sound/cs4271.txt |    2 +
 .../devicetree/bindings/sound/omap-abe-twl6040.txt |    4 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    8 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   16 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   32 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    8 +
 arch/arm/mach-at91/at91rm9200.c                    |    9 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |    6 +-
 arch/arm/mach-at91/at91sam9260.c                   |    3 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |    2 +-
 arch/arm/mach-at91/at91sam9261.c                   |    9 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |    6 +-
 arch/arm/mach-at91/at91sam9263.c                   |    6 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |    4 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    6 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |    4 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    6 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |    4 +-
 arch/arm/mach-at91/at91sam9x5.c                    |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c               |   11 +
 arch/arm/mach-davinci/board-da850-evm.c            |   24 +-
 arch/arm/mach-exynos/mach-armlex4210.c             |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c               |    1 -
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    1 -
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c              |    1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    1 -
 arch/arm/plat-samsung/devs.c                       |    9 -
 arch/arm/plat-samsung/include/plat/devs.h          |    1 -
 drivers/base/regmap/internal.h                     |    2 +
 drivers/base/regmap/regmap-debugfs.c               |   50 +-
 drivers/base/regmap/regmap.c                       |  154 +++--
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/arizona-haptics.c               |  255 +++++++
 drivers/mfd/arizona-core.c                         |    2 +
 drivers/mfd/wm8994-core.c                          |   35 +-
 drivers/misc/atmel-ssc.c                           |  135 ++--
 include/linux/atmel-ssc.h                          |    6 +
 include/linux/mfd/arizona/core.h                   |    4 +
 include/linux/mfd/arizona/pdata.h                  |    6 +
 include/linux/mfd/wm8994/core.h                    |    4 +
 include/linux/mfd/wm8994/pdata.h                   |    5 +
 include/linux/platform_data/asoc-s3c.h             |    6 -
 include/linux/platform_data/davinci_asp.h          |    4 +-
 include/linux/platform_data/omap-twl4030.h         |   26 +
 include/linux/regmap.h                             |    6 +-
 include/sound/cs4271.h                             |    1 +
 include/sound/sh_fsi.h                             |    6 +
 include/sound/soc-dai.h                            |    1 -
 include/sound/soc.h                                |    1 +
 include/sound/tlv320aic32x4.h                      |    1 +
 sound/soc/atmel/Kconfig                            |   13 +-
 sound/soc/atmel/Makefile                           |    4 +
 sound/soc/atmel/atmel-pcm-dma.c                    |  240 +++++++
 sound/soc/atmel/atmel-pcm-pdc.c                    |  401 +++++++++++
 sound/soc/atmel/atmel-pcm.c                        |  401 +----------
 sound/soc/atmel/atmel-pcm.h                        |   34 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  168 ++---
 sound/soc/atmel/atmel_ssc_dai.h                    |    3 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |  116 +++-
 sound/soc/au1x/ac97c.c                             |    6 +-
 sound/soc/au1x/db1000.c                            |    6 +-
 sound/soc/au1x/db1200.c                            |    8 +-
 sound/soc/au1x/dbdma2.c                            |    6 +-
 sound/soc/au1x/dma.c                               |    6 +-
 sound/soc/au1x/i2sc.c                              |    6 +-
 sound/soc/au1x/psc-ac97.c                          |    6 +-
 sound/soc/au1x/psc-i2s.c                           |    6 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |    6 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |    6 +-
 sound/soc/blackfin/bf5xx-ad1836.c                  |    6 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |    6 +-
 sound/soc/blackfin/bf5xx-i2s.c                     |    6 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c                 |    6 +-
 sound/soc/blackfin/bf5xx-tdm.c                     |    6 +-
 sound/soc/blackfin/bf6xx-i2s.c                     |    6 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |    4 +-
 sound/soc/blackfin/bfin-eval-adau1701.c            |    4 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |    4 +-
 sound/soc/cirrus/edb93xx.c                         |    6 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |    6 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |    4 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |    6 +-
 sound/soc/cirrus/simone.c                          |    6 +-
 sound/soc/cirrus/snappercl15.c                     |    6 +-
 sound/soc/codecs/88pm860x-codec.c                  |    6 +-
 sound/soc/codecs/Kconfig                           |   16 +
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/ab8500-codec.c                    |    8 +-
 sound/soc/codecs/ac97.c                            |    6 +-
 sound/soc/codecs/ad1836.c                          |    6 +-
 sound/soc/codecs/ad193x.c                          |   14 +-
 sound/soc/codecs/ad1980.c                          |    6 +-
 sound/soc/codecs/ad73311.c                         |    4 +-
 sound/soc/codecs/adau1373.c                        |    8 +-
 sound/soc/codecs/adau1701.c                        |    8 +-
 sound/soc/codecs/adav80x.c                         |   20 +-
 sound/soc/codecs/ads117x.c                         |    6 +-
 sound/soc/codecs/ak4104.c                          |   69 +-
 sound/soc/codecs/ak4535.c                          |   15 +-
 sound/soc/codecs/ak4641.c                          |    8 +-
 sound/soc/codecs/ak4642.c                          |   31 +-
 sound/soc/codecs/ak4671.c                          |    8 +-
 sound/soc/codecs/alc5623.c                         |    8 +-
 sound/soc/codecs/alc5632.c                         |    8 +-
 sound/soc/codecs/arizona.c                         |   53 +-
 sound/soc/codecs/arizona.h                         |   71 +-
 sound/soc/codecs/cq93vc.c                          |    2 +-
 sound/soc/codecs/cs4271.c                          |   35 +-
 sound/soc/codecs/cs42l52.c                         |    2 +-
 sound/soc/codecs/cs42l73.c                         |  124 +++-
 sound/soc/codecs/da7210.c                          |   38 +-
 sound/soc/codecs/da732x.c                          |    8 +-
 sound/soc/codecs/da9055.c                          |   51 +-
 sound/soc/codecs/dfbmcs320.c                       |    6 +-
 sound/soc/codecs/dmic.c                            |    6 +-
 sound/soc/codecs/isabelle.c                        |    8 +-
 sound/soc/codecs/jz4740.c                          |  148 ++---
 sound/soc/codecs/lm4857.c                          |    8 +-
 sound/soc/codecs/lm49453.c                         |   18 +-
 sound/soc/codecs/max9768.c                         |   15 +-
 sound/soc/codecs/max98088.c                        |   16 +-
 sound/soc/codecs/max98090.c                        |  577 ++++++++++++++++
 sound/soc/codecs/max98095.c                        |    4 +-
 sound/soc/codecs/max9850.c                         |    8 +-
 sound/soc/codecs/max9877.c                         |    8 +-
 sound/soc/codecs/mc13783.c                         |    2 +-
 sound/soc/codecs/ml26124.c                         |    8 +-
 sound/soc/codecs/omap-hdmi.c                       |    6 +-
 sound/soc/codecs/pcm3008.c                         |    6 +-
 sound/soc/codecs/rt5631.c                          |    6 +-
 sound/soc/codecs/sgtl5000.c                        |    8 +-
 sound/soc/codecs/si476x.c                          |  255 +++++++
 sound/soc/codecs/sigmadsp.c                        |    2 +-
 sound/soc/codecs/sn95031.c                         |    6 +-
 sound/soc/codecs/ssm2602.c                         |   12 +-
 sound/soc/codecs/sta32x.c                          |    8 +-
 sound/soc/codecs/sta529.c                          |    8 +-
 sound/soc/codecs/stac9766.c                        |    6 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   32 +-
 sound/soc/codecs/tlv320aic32x4.h                   |    3 +
 sound/soc/codecs/tlv320dac33.c                     |    8 +-
 sound/soc/codecs/tpa6130a2.c                       |   31 +-
 sound/soc/codecs/twl4030.c                         |    6 +-
 sound/soc/codecs/twl6040.c                         |    6 +-
 sound/soc/codecs/uda134x.c                         |    6 +-
 sound/soc/codecs/uda1380.c                         |    8 +-
 sound/soc/codecs/wl1273.c                          |    6 +-
 sound/soc/codecs/wm0010.c                          |  425 +++++++-----
 sound/soc/codecs/wm1250-ev1.c                      |   10 +-
 sound/soc/codecs/wm2000.c                          |   10 +-
 sound/soc/codecs/wm2200.c                          |  277 ++++++--
 sound/soc/codecs/wm5100.c                          |   10 +-
 sound/soc/codecs/wm5102.c                          |  144 ++--
 sound/soc/codecs/wm5110.c                          |   75 ++-
 sound/soc/codecs/wm8350.c                          |   10 +-
 sound/soc/codecs/wm8400.c                          |   20 +-
 sound/soc/codecs/wm8510.c                          |   17 +-
 sound/soc/codecs/wm8523.c                          |    8 +-
 sound/soc/codecs/wm8711.c                          |   14 +-
 sound/soc/codecs/wm8727.c                          |    6 +-
 sound/soc/codecs/wm8728.c                          |   14 +-
 sound/soc/codecs/wm8731.c                          |   14 +-
 sound/soc/codecs/wm8737.c                          |   14 +-
 sound/soc/codecs/wm8741.c                          |   10 +-
 sound/soc/codecs/wm8750.c                          |  100 ++-
 sound/soc/codecs/wm8753.c                          |   47 +-
 sound/soc/codecs/wm8770.c                          |  223 +++----
 sound/soc/codecs/wm8776.c                          |   14 +-
 sound/soc/codecs/wm8782.c                          |    6 +-
 sound/soc/codecs/wm8804.c                          |   31 +-
 sound/soc/codecs/wm8900.c                          |   14 +-
 sound/soc/codecs/wm8903.c                          |    8 +-
 sound/soc/codecs/wm8904.c                          |    8 +-
 sound/soc/codecs/wm8940.c                          |    8 +-
 sound/soc/codecs/wm8955.c                          |   19 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   79 +--
 sound/soc/codecs/wm8960.c                          |   10 +-
 sound/soc/codecs/wm8961.c                          |    8 +-
 sound/soc/codecs/wm8962.c                          |   32 +-
 sound/soc/codecs/wm8971.c                          |   88 ++-
 sound/soc/codecs/wm8974.c                          |    8 +-
 sound/soc/codecs/wm8978.c                          |   24 +-
 sound/soc/codecs/wm8983.c                          |   14 +-
 sound/soc/codecs/wm8985.c                          |   44 +-
 sound/soc/codecs/wm8988.c                          |   28 +-
 sound/soc/codecs/wm8990.c                          |    8 +-
 sound/soc/codecs/wm8991.c                          |    8 +-
 sound/soc/codecs/wm8993.c                          |   22 +-
 sound/soc/codecs/wm8994.c                          |  349 ++++++----
 sound/soc/codecs/wm8994.h                          |   13 +-
 sound/soc/codecs/wm8995.c                          |   54 +-
 sound/soc/codecs/wm8996.c                          |    8 +-
 sound/soc/codecs/wm9081.c                          |   30 +-
 sound/soc/codecs/wm9090.c                          |   24 +-
 sound/soc/codecs/wm9705.c                          |    6 +-
 sound/soc/codecs/wm9712.c                          |    6 +-
 sound/soc/codecs/wm9713.c                          |    6 +-
 sound/soc/codecs/wm_adsp.c                         |  699 ++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h                         |   59 ++
 sound/soc/codecs/wmfw.h                            |  128 ++++
 sound/soc/davinci/davinci-evm.c                    |    5 +
 sound/soc/davinci/davinci-mcasp.c                  |  152 +++--
 sound/soc/davinci/davinci-mcasp.h                  |   15 +-
 sound/soc/davinci/davinci-pcm.c                    |   53 +-
 sound/soc/davinci/davinci-pcm.h                    |    2 +
 sound/soc/fsl/Kconfig                              |   20 +-
 sound/soc/fsl/Makefile                             |   14 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    6 +-
 sound/soc/fsl/fsl_dma.c                            |    6 +-
 sound/soc/fsl/fsl_ssi.c                            |    2 +-
 sound/soc/fsl/imx-audmux.c                         |    8 +-
 sound/soc/fsl/imx-mc13783.c                        |    6 +-
 sound/soc/fsl/imx-pcm-dma.c                        |    6 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |    6 +-
 sound/soc/fsl/imx-pcm.c                            |    4 +
 sound/soc/fsl/imx-sgtl5000.c                       |    7 +-
 sound/soc/fsl/imx-ssi.c                            |    4 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    8 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    8 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |    4 +-
 sound/soc/fsl/mx27vis-aic32x4.c                    |    6 +-
 sound/soc/fsl/p1022_ds.c                           |    4 +-
 sound/soc/fsl/p1022_rdk.c                          |  392 +++++++++++
 sound/soc/fsl/pcm030-audio-fabric.c                |    8 +-
 sound/soc/jz4740/jz4740-i2s.c                      |    6 +-
 sound/soc/jz4740/jz4740-pcm.c                      |    6 +-
 sound/soc/jz4740/qi_lb60.c                         |    6 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |   22 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |  241 ++++---
 sound/soc/kirkwood/kirkwood-openrd.c               |    6 +-
 sound/soc/kirkwood/kirkwood-t5325.c                |    6 +-
 sound/soc/kirkwood/kirkwood.h                      |   11 +-
 sound/soc/mid-x86/mfld_machine.c                   |    6 +-
 sound/soc/mxs/mxs-pcm.c                            |    4 +-
 sound/soc/mxs/mxs-saif.c                           |    8 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    8 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    6 +-
 sound/soc/nuc900/nuc900-pcm.c                      |    6 +-
 sound/soc/omap/ams-delta.c                         |    6 +-
 sound/soc/omap/mcbsp.c                             |   11 +-
 sound/soc/omap/mcbsp.h                             |   10 +-
 sound/soc/omap/omap-abe-twl6040.c                  |   10 +-
 sound/soc/omap/omap-dmic.c                         |    6 +-
 sound/soc/omap/omap-hdmi-card.c                    |    6 +-
 sound/soc/omap/omap-hdmi.c                         |    6 +-
 sound/soc/omap/omap-mcbsp.c                        |   11 +-
 sound/soc/omap/omap-mcpdm.c                        |    6 +-
 sound/soc/omap/omap-pcm.c                          |    6 +-
 sound/soc/omap/omap-twl4030.c                      |    6 +-
 sound/soc/omap/zoom2.c                             |    7 -
 sound/soc/pxa/brownstone.c                         |    6 +-
 sound/soc/pxa/corgi.c                              |    6 +-
 sound/soc/pxa/e740_wm9705.c                        |    6 +-
 sound/soc/pxa/e750_wm9705.c                        |    6 +-
 sound/soc/pxa/e800_wm9712.c                        |    6 +-
 sound/soc/pxa/hx4700.c                             |    6 +-
 sound/soc/pxa/imote2.c                             |    6 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    6 +-
 sound/soc/pxa/mmp-pcm.c                            |    6 +-
 sound/soc/pxa/mmp-sspa.c                           |    6 +-
 sound/soc/pxa/palm27x.c                            |    4 +-
 sound/soc/pxa/poodle.c                             |    6 +-
 sound/soc/pxa/pxa-ssp.c                            |    6 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    8 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    4 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    6 +-
 sound/soc/pxa/tosa.c                               |    6 +-
 sound/soc/pxa/ttc-dkb.c                            |    6 +-
 sound/soc/s6000/s6000-i2s.c                        |    6 +-
 sound/soc/s6000/s6000-pcm.c                        |    6 +-
 sound/soc/samsung/ac97.c                           |   22 +-
 sound/soc/samsung/bells.c                          |  228 +++++--
 sound/soc/samsung/dma.c                            |   24 +-
 sound/soc/samsung/dma.h                            |    3 +
 sound/soc/samsung/goni_wm8994.c                    |    2 +-
 sound/soc/samsung/h1940_uda1380.c                  |    2 +-
 sound/soc/samsung/i2s.c                            |   33 +-
 sound/soc/samsung/idma.c                           |    6 +-
 sound/soc/samsung/jive_wm8750.c                    |    2 +-
 sound/soc/samsung/littlemill.c                     |   10 +-
 sound/soc/samsung/ln2440sbc_alc650.c               |    2 +-
 sound/soc/samsung/lowland.c                        |    8 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    2 +-
 sound/soc/samsung/pcm.c                            |   27 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   26 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   26 +-
 sound/soc/samsung/s3c24xx_simtec.c                 |    6 +-
 sound/soc/samsung/s3c24xx_simtec_hermes.c          |    6 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c     |    6 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |    2 +-
 sound/soc/samsung/smartq_wm8987.c                  |    2 +-
 sound/soc/samsung/smdk2443_wm9710.c                |    2 +-
 sound/soc/samsung/smdk_spdif.c                     |    2 +-
 sound/soc/samsung/smdk_wm8580.c                    |    6 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |    8 +-
 sound/soc/samsung/smdk_wm8994.c                    |   10 +-
 sound/soc/samsung/smdk_wm8994pcm.c                 |    8 +-
 sound/soc/samsung/smdk_wm9713.c                    |    2 +-
 sound/soc/samsung/spdif.c                          |   28 +-
 sound/soc/samsung/speyside.c                       |    8 +-
 sound/soc/samsung/tobermory.c                      |    8 +-
 sound/soc/sh/dma-sh7760.c                          |    6 +-
 sound/soc/sh/fsi.c                                 |  550 +++++++++++++--
 sound/soc/sh/hac.c                                 |    6 +-
 sound/soc/sh/siu_dai.c                             |    6 +-
 sound/soc/sh/ssi.c                                 |    6 +-
 sound/soc/soc-cache.c                              |   10 +-
 sound/soc/soc-compress.c                           |    2 +-
 sound/soc/soc-core.c                               |  237 +++----
 sound/soc/soc-dapm.c                               |  134 ++--
 sound/soc/soc-dmaengine-pcm.c                      |    2 +
 sound/soc/soc-jack.c                               |   16 +-
 sound/soc/soc-pcm.c                                |  207 +++---
 sound/soc/soc-utils.c                              |    6 +-
 sound/soc/spear/spear_pcm.c                        |    6 +-
 sound/soc/tegra/tegra20_das.c                      |    8 +-
 sound/soc/tegra/tegra20_i2s.c                      |   10 +-
 sound/soc/tegra/tegra20_spdif.c                    |    8 +-
 sound/soc/tegra/tegra30_ahub.c                     |   14 +-
 sound/soc/tegra/tegra30_i2s.c                      |   10 +-
 sound/soc/tegra/tegra_alc5632.c                    |    8 +-
 sound/soc/tegra/tegra_pcm.c                        |    4 +-
 sound/soc/tegra/tegra_wm8753.c                     |    8 +-
 sound/soc/tegra/tegra_wm8903.c                     |    8 +-
 sound/soc/tegra/trimslice.c                        |    8 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    6 +-
 sound/soc/txx9/txx9aclc.c                          |    6 +-
 sound/soc/ux500/mop500.c                           |   14 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   59 +-
 sound/soc/ux500/ux500_msp_dai.h                    |    1 +
 sound/soc/ux500/ux500_pcm.c                        |   19 +-
 sound/soc/ux500/ux500_pcm.h                        |    3 +
 346 files changed, 7663 insertions(+), 3286 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/atmel-ssc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
 create mode 100644 drivers/input/misc/arizona-haptics.c
 create mode 100644 sound/soc/atmel/atmel-pcm-dma.c
 create mode 100644 sound/soc/atmel/atmel-pcm-pdc.c
 create mode 100644 sound/soc/codecs/max98090.c
 create mode 100644 sound/soc/codecs/si476x.c
 create mode 100644 sound/soc/codecs/wm_adsp.c
 create mode 100644 sound/soc/codecs/wm_adsp.h
 create mode 100644 sound/soc/codecs/wmfw.h
 create mode 100644 sound/soc/fsl/p1022_rdk.c

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzxp3AAoJELSic+t+oim9mCEP/1NJCNhdmMAhKhhUK9fk38je
xtE8i4CPFeLCvwu4WHui5H3u3k5VQ5k0OtUrdgKeeOf20vNFv3zkr66i3NctAPn8
ryTH+AwIPrqyZTSDXl31vA4+tQ1n9MOgJMtpgjtLSg9Qb44S3FArJwzet299hxHz
gd7Xy1DsXF6v//F3iH7LQP7dGuHm5T2rL8GBgj1CLhMK8dZwiVIdV6hGLRdY13tS
vikZZraaCrQoSo11MJRrmD55OJ/8nncRUP7tcja5JAy2/2cr5t+mD1zQmvPXijr1
9hIBGby1crYOlbLiIHFp4gaAEZTvSyqoLgL4bY4pIrXsYfMtkYwudp5lOvOuaS19
LFr5Sm18USZUxe0HoqgeL4nFN+X6Csq6s0Icy4nWL+KQsdv9DmxovYURggvOPeF8
CJCg++fcF2joYb8rQrslflbiuBtFBdqZFW6SEtRVhZSMbuI9vSvicmQueFT6UXuH
pXTKTbKj/HlvLsspIq4RsLJkmmrI5uta3D6EL1l3zb8tq1yVQFzWYug65Fw4l/c3
UMSGh4AQMMFtnPrWAgjVSvIi3ELDmiSKWu9jhsQCJnRhPCP/e2ovOf4CvvJJrfNC
akNjufq6ttvufENL3cEzVeurYr3bML/9LRPb/tXEAUMU/QWprm+GlHoSmI0tXYnE
QdGXfR/n5WGRu/g46x63
=QSJF
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

--===============3088881284457619486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3088881284457619486==--
