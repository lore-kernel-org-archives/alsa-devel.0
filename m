From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.15
Date: Wed, 9 Apr 2014 15:39:00 +0100
Message-ID: <20140409143900.GO6518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1288548659627961233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73A9B264F03
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 22:41:22 +0200 (CEST)
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


--===============1288548659627961233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.15-5

for you to fetch changes up to ab5d6fbdb71c183add7431243c7f615c42b643bb:

  Merge remote-tracking branches 'asoc/fix/rt5640', 'asoc/fix/samsung', 'asoc/fix/tlv320aic23' and 'asoc/fix/warn' into asoc-linus (2014-04-08 21:22:14 +0100)

Some extra merges coming in due to the way my script ensures that
previously sent fixes are included in my branch still not interacting
well with signed tags, I'll need to figure that out.

----------------------------------------------------------------

ASoC: Fixes for v3.15

A smattering of device specific fixes, nothing stands out here except
for the multiplatform fixes for Samsung and the device IDs being added
by Stephen Warren - there's no real code changes from those and they
give better robustness to the enumeration with DT.

----------------------------------------------------------------
Axel Lin (3):
      ASoC: cs42xx8: Check return value of regmap_read and report correct chipid value
      ASoC: cs42l52: Fix mask for REVID
      ASoC: da732x: Print correct major id

Christoph Jaeger (1):
      ASoC: alc56(23|32): fix undefined return value of probing code

Mark Brown (6):
      Merge tag 'asoc-v3.15' into asoc-linus
      Merge tag 'asoc-v3.15-2' into asoc-linus
      Merge tag 'asoc-v3.15-3' into asoc-linus
      Merge tag 'asoc-v3.15-4' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/alc5632', 'asoc/fix/cs42l52', 'asoc/fix/cs42xxx8', 'asoc/fix/da732x', 'asoc/fix/davinci', 'asoc/fix/fsl-sai', 'asoc/fix/fsl-ssi' and 'asoc/fix/max98090' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5640', 'asoc/fix/samsung', 'asoc/fix/tlv320aic23' and 'asoc/fix/warn' into asoc-linus

Markus Pargmann (1):
      ASoC: fsl-ssi: Update binding documentation

Nicolin Chen (2):
      ASoC: fsl_sai: Add isr to deal with error flag
      ASoC: fsl_sai: Fix Bit Clock Polarity configurations

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Fix bit clock polarity settings

Sachin Kamat (1):
      ASoC: samsung: Fix build on multiplatform

Stephen Warren (5):
      ASoC: rt5640: add an of_match table
      ASoC: alc5632: fix uninit var in alc5632_probe()
      ASoC: alc5632: add an of_match table
      ASoC: max98090: add an of_match table
      ASoC: tlv320aic23: add an of_match table

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/misc/atmel-ssc.txt         |    8 +
 .../bindings/sound/armada-370db-audio.txt          |   27 +
 .../devicetree/bindings/sound/cs42xx8.txt          |   28 +
 Documentation/devicetree/bindings/sound/da9055.txt |   22 +
 .../bindings/sound/davinci-evm-audio.txt           |    9 +-
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   21 +
 .../devicetree/bindings/sound/fsl,esai.txt         |    5 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |    5 +
 .../devicetree/bindings/sound/fsl,ssi.txt          |   21 +-
 .../devicetree/bindings/sound/mvebu-audio.txt      |    1 +
 .../devicetree/bindings/sound/pcm512x.txt          |   30 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  105 ++
 .../devicetree/bindings/sound/simple-card.txt      |   65 +-
 .../devicetree/bindings/sound/sirf-audio-codec.txt |   17 +
 .../devicetree/bindings/sound/sirf-audio-port.txt  |   20 +
 .../devicetree/bindings/sound/sirf-audio.txt       |   41 +
 .../devicetree/bindings/sound/tdm-slot.txt         |   20 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   61 +
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |   30 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    1 -
 .../devicetree/bindings/sound/widgets.txt          |   20 +
 MAINTAINERS                                        |    7 +
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-bockw.c               |   16 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c            |    6 +-
 arch/sh/boards/mach-ecovec24/setup.c               |    4 +-
 arch/sh/boards/mach-se/7724/setup.c                |    4 +-
 drivers/base/regmap/regmap.c                       |   12 +
 drivers/misc/atmel-ssc.c                           |    6 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    8 +
 include/linux/atmel-ssc.h                          |    1 +
 include/linux/mfd/arizona/registers.h              |    6 +-
 include/linux/platform_data/adau1977.h             |   45 +
 include/linux/platform_data/asoc-s3c.h             |    3 +-
 include/linux/platform_data/asoc-s3c24xx_simtec.h  |    3 +-
 include/linux/platform_data/davinci_asp.h          |    4 +-
 include/linux/regmap.h                             |    9 +
 include/sound/rcar_snd.h                           |   36 +-
 include/sound/simple_card.h                        |    6 +-
 include/sound/soc-dai.h                            |    3 +
 include/sound/soc-dapm.h                           |   40 +-
 include/sound/soc.h                                |  152 +-
 include/trace/events/hswadsp.h                     |  384 +++++
 include/trace/events/intel-sst.h                   |  148 ++
 sound/core/pcm_lib.c                               |    1 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/Kconfig                            |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   13 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   20 +-
 sound/soc/blackfin/Kconfig                         |    9 +-
 sound/soc/cirrus/Kconfig                           |    4 +-
 sound/soc/cirrus/snappercl15.c                     |   18 +-
 sound/soc/codecs/88pm860x-codec.c                  |  119 +-
 sound/soc/codecs/Kconfig                           |  195 ++-
 sound/soc/codecs/Makefile                          |   39 +-
 sound/soc/codecs/ad1836.c                          |    4 +-
 sound/soc/codecs/ad193x-i2c.c                      |   54 +
 sound/soc/codecs/ad193x-spi.c                      |   48 +
 sound/soc/codecs/ad193x.c                          |  154 +-
 sound/soc/codecs/ad193x.h                          |    7 +
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
 sound/soc/codecs/alc5623.c                         |  123 +-
 sound/soc/codecs/alc5632.c                         |   58 +-
 sound/soc/codecs/arizona.c                         |  325 ++--
 sound/soc/codecs/cq93vc.c                          |    3 +-
 sound/soc/codecs/cs4270.c                          |    9 -
 sound/soc/codecs/cs4271.c                          |   63 +-
 sound/soc/codecs/cs42l51.c                         |   99 +-
 sound/soc/codecs/cs42l52.c                         |  111 +-
 sound/soc/codecs/cs42l52.h                         |    2 +-
 sound/soc/codecs/cs42l73.c                         |   72 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |   64 +
 sound/soc/codecs/cs42xx8.c                         |  601 +++++++
 sound/soc/codecs/cs42xx8.h                         |  238 +++
 sound/soc/codecs/da7210.c                          |   28 +-
 sound/soc/codecs/da7213.c                          |  159 +-
 sound/soc/codecs/da732x.c                          |  199 +--
 sound/soc/codecs/da732x.h                          |    3 -
 sound/soc/codecs/da9055.c                          |  100 +-
 sound/soc/codecs/isabelle.c                        |   19 +-
 sound/soc/codecs/lm4857.c                          |    3 +-
 sound/soc/codecs/lm49453.c                         |   47 +-
 sound/soc/codecs/max9768.c                         |    5 -
 sound/soc/codecs/max98088.c                        |   47 +-
 sound/soc/codecs/max98090.c                        |  188 ++-
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
 sound/soc/codecs/rt5640.c                          |   95 +-
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
 sound/soc/codecs/sta32x.c                          |   14 -
 sound/soc/codecs/sta529.c                          |   15 +-
 sound/soc/codecs/stac9766.c                        |   38 +-
 sound/soc/codecs/tlv320aic23-i2c.c                 |   66 +
 sound/soc/codecs/tlv320aic23-spi.c                 |   56 +
 sound/soc/codecs/tlv320aic23.c                     |   79 +-
 sound/soc/codecs/tlv320aic23.h                     |    6 +
 sound/soc/codecs/tlv320aic26.c                     |    7 +-
 sound/soc/codecs/tlv320aic31xx.c                   | 1280 ++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  258 +++
 sound/soc/codecs/tlv320aic32x4.c                   |  234 ++-
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
 sound/soc/codecs/wm8400.c                          |    3 +-
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
 sound/soc/codecs/wm8770.c                          |    6 -
 sound/soc/codecs/wm8776.c                          |    6 -
 sound/soc/codecs/wm8804.c                          |   10 +-
 sound/soc/codecs/wm8900.c                          |    8 +-
 sound/soc/codecs/wm8903.c                          |  118 +-
 sound/soc/codecs/wm8904.c                          |   86 +-
 sound/soc/codecs/wm8940.c                          |   26 +-
 sound/soc/codecs/wm8955.c                          |   19 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    8 +-
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
 sound/soc/codecs/wm8993.c                          |   73 +-
 sound/soc/codecs/wm8994.c                          |   55 +-
 sound/soc/codecs/wm8995.c                          |   50 +-
 sound/soc/codecs/wm8996.c                          |   87 +-
 sound/soc/codecs/wm8997.c                          |   29 +-
 sound/soc/codecs/wm9081.c                          |   34 +-
 sound/soc/codecs/wm9090.c                          |   10 -
 sound/soc/codecs/wm9705.c                          |   12 +-
 sound/soc/codecs/wm_adsp.c                         |   50 +-
 sound/soc/codecs/wm_hubs.c                         |   16 +-
 sound/soc/davinci/davinci-evm.c                    |   80 +-
 sound/soc/davinci/davinci-mcasp.c                  |  219 ++-
 sound/soc/davinci/edma-pcm.c                       |   57 +
 sound/soc/davinci/edma-pcm.h                       |   25 +
 sound/soc/fsl/Kconfig                              |   14 +-
 sound/soc/fsl/eukrea-tlv320.c                      |  108 +-
 sound/soc/fsl/fsl_esai.c                           |   34 +-
 sound/soc/fsl/fsl_sai.c                            |  397 +++--
 sound/soc/fsl/fsl_sai.h                            |   63 +-
 sound/soc/fsl/fsl_spdif.c                          |    9 +-
 sound/soc/fsl/fsl_utils.c                          |   27 +
 sound/soc/fsl/fsl_utils.h                          |    4 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |    7 +-
 sound/soc/fsl/imx-ssi.c                            |    2 +
 sound/soc/fsl/wm1133-ev1.c                         |   11 +-
 sound/soc/generic/simple-card.c                    |  385 +++--
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
 sound/soc/intel/sst-haswell-ipc.c                  | 1785 ++++++++++++++++++++
 sound/soc/intel/sst-haswell-ipc.h                  |  488 ++++++
 sound/soc/intel/sst-haswell-pcm.c                  |  872 ++++++++++
 sound/soc/intel/{sst_dsp.h => sst-mfld-dsp.h}      |    8 +-
 .../intel/{sst_platform.c => sst-mfld-platform.c}  |    8 +-
 .../intel/{sst_platform.h => sst-mfld-platform.h}  |    4 +-
 sound/soc/kirkwood/Kconfig                         |   11 +-
 sound/soc/kirkwood/Makefile                        |    2 +
 sound/soc/kirkwood/armada-370-db.c                 |  148 ++
 sound/soc/kirkwood/kirkwood-i2s.c                  |    1 +
 sound/soc/omap/Kconfig                             |    4 +-
 sound/soc/omap/ams-delta.c                         |   55 +-
 sound/soc/omap/n810.c                              |   22 +-
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
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/ac97.c                           |    6 +-
 sound/soc/samsung/dma.h                            |    6 +-
 sound/soc/samsung/h1940_uda1380.c                  |    7 +-
 sound/soc/samsung/i2s.c                            |    6 +-
 sound/soc/samsung/neo1973_wm8753.c                 |  168 +-
 sound/soc/samsung/pcm.c                            |    5 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    5 -
 sound/soc/samsung/s3c2412-i2s.c                    |    4 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    4 +-
 sound/soc/samsung/smdk_wm8994.c                    |    2 +-
 sound/soc/samsung/spdif.c                          |    3 +-
 sound/soc/samsung/tobermory.c                      |    2 +
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/migor.c                               |   19 +-
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/adg.c                            |  229 ++-
 sound/soc/sh/rcar/core.c                           |  426 +++--
 sound/soc/sh/rcar/gen.c                            |  113 +-
 sound/soc/sh/rcar/rsnd.h                           |  206 ++-
 sound/soc/sh/rcar/scu.c                            |  384 -----
 sound/soc/sh/rcar/src.c                            |  727 ++++++++
 sound/soc/sh/rcar/ssi.c                            |  388 ++---
 sound/soc/sirf/Kconfig                             |   14 +
 sound/soc/sirf/Makefile                            |    5 +
 sound/soc/sirf/sirf-audio-port.c                   |  194 +++
 sound/soc/sirf/sirf-audio-port.h                   |   62 +
 sound/soc/sirf/sirf-audio.c                        |  156 ++
 sound/soc/soc-cache.c                              |   13 +-
 sound/soc/soc-compress.c                           |   65 +-
 sound/soc/soc-core.c                               |  603 ++++---
 sound/soc/soc-dapm.c                               |  465 ++---
 sound/soc/soc-io.c                                 |   99 +-
 sound/soc/soc-jack.c                               |    5 +-
 sound/soc/soc-pcm.c                                |  112 +-
 sound/soc/spear/spdif_out.c                        |   10 +-
 sound/soc/tegra/Kconfig                            |    2 +-
 sound/soc/tegra/tegra20_ac97.c                     |   17 +-
 sound/soc/tegra/tegra20_ac97.h                     |    1 -
 sound/soc/tegra/tegra20_das.c                      |    2 +-
 sound/soc/tegra/tegra20_i2s.c                      |    2 +-
 sound/soc/tegra/tegra20_spdif.c                    |    2 +-
 sound/soc/tegra/tegra30_ahub.c                     |    4 +-
 sound/soc/tegra/tegra30_i2s.c                      |    2 +-
 sound/soc/tegra/tegra_wm9712.c                     |   17 +-
 292 files changed, 21319 insertions(+), 5575 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/armada-370db-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs42xx8.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
 create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm512x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-port.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
 create mode 100644 Documentation/devicetree/bindings/sound/widgets.txt
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 include/linux/platform_data/adau1977.h
 create mode 100644 include/trace/events/hswadsp.h
 create mode 100644 include/trace/events/intel-sst.h
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
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h
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
 rename sound/soc/intel/{sst_dsp.h => sst-mfld-dsp.h} (96%)
 rename sound/soc/intel/{sst_platform.c => sst-mfld-platform.c} (99%)
 rename sound/soc/intel/{sst_platform.h => sst-mfld-platform.h} (97%)
 create mode 100644 sound/soc/kirkwood/armada-370-db.c
 delete mode 100644 sound/soc/sh/rcar/scu.c
 create mode 100644 sound/soc/sh/rcar/src.c
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio-port.c
 create mode 100644 sound/soc/sirf/sirf-audio-port.h
 create mode 100644 sound/soc/sirf/sirf-audio.c

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRVuBAAoJELSic+t+oim9cFAP/1vvBdax/uPiVSfbuVNg6Tn9
zWepwCKqBFwonV8y2twtxG1K3IolLkDrOqvxXgVLA9ah0j+S6ulKrir2RKMIlvhn
LRtCYcoMkZGLouaZbeT+zAYHx08kweC4RN9IRjhReLkxre+1uyId7LAFXuQr9gss
mN/KMzNA5l9s9R9dC5vXphK+nwvqcQa/plSjnfSDsQftulFKoJn9wdMZTUrX3Al0
VzuacbeZkC4D+5mwO6ONUgQbNSbL1PCTZdS9cNnNRTKcA5YSB8/KgvSDHm9Wti2G
HZDB1AAMjfa+sHMy/HezAlukFLUgIGlg3cXs22dKBURH6K/WG/OJEFCNtQDdL4tS
Zkh5dZQnUqR0eZrivez3Pe/+u/X+Lhnr6PHW4/3eMdHMlabkrLB+t4G8kQHRBGUU
LEI/8ycl+H9Ckfz2L09g860noMo9SlIXqppddVvg43F4sVv+OEYH1Ij+z5eCsdf5
M/WocZQyWx0DgaSML3vqvcXnX4PbEw5+UfVzYBL1ah51bQCTNk31iqkCGzuWOnjn
ocJKnGsgG4YVHbrEWAJudO5u/E9o9nCd9Q6m1yaeHm/Wjz15l6AlKLsrljC2rd7Z
3tMugwOmbIq8bFtd15gXRWaoHSf4vTOUhLQ9Nir5CBwOQbSMexw7Lw+8waxfYlnM
2xhQvqBvi+AAlngA4Ecj
=/x2w
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--

--===============1288548659627961233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1288548659627961233==--
