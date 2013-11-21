From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.13
Date: Thu, 21 Nov 2013 14:04:56 +0000
Message-ID: <20131121140456.GS2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4548267381062769981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D2FCC2602F3
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:04:59 +0100 (CET)
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


--===============4548267381062769981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWhAmKkHIJcC5HOx"
Content-Disposition: inline


--MWhAmKkHIJcC5HOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3d800c6d75b8c92fa928a0bcaf95cd7ac5fd1ce5:

  ASoC: cs42l52: Correct MIC CTL mask (2013-11-15 10:16:53 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-5

for you to fetch changes up to 9a5c543dd71952719d40429b6ef252a46c9b2246:

  Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus (2013-11-20 15:20:38 +0000)

Not sure why the diffstat is still going crazy here...   :/

----------------------------------------------------------------

ASoC: Fixes for v3.13

A bunch of device specific fixes, nothing with a general impact here.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: wm5110: Add post SYSCLK register patch for rev D chip

Dan Carpenter (1):
      ASoC: rcar: off by one in rsnd_scu_set_route()

Kuninori Morimoto (2):
      ASoC: rcar: fixup mod access before checking
      ASoC: rcar: fixup dma_async_issue_pending() timing

Lee Jones (1):
      ASoC: ab8500: Revert to using custom I/O functions

Mark Brown (8):
      Merge remote-tracking branch 'asoc/fix/ab8500' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/blackfin' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dma' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus

Richard Fitzgerald (1):
      ASoC: arizona: Set FLL to free-run before disabling

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
 drivers/base/regmap/internal.h                     |   8 +-
 drivers/base/regmap/regcache.c                     |   3 +-
 drivers/base/regmap/regmap.c                       | 294 ++++++++--
 drivers/mfd/mc13xxx-core.c                         |   5 -
 drivers/mfd/mc13xxx-spi.c                          |   5 +
 include/linux/mfd/mc13xxx.h                        |   7 +
 include/linux/platform_data/davinci_asp.h          |   2 +
 include/linux/regmap.h                             |  44 ++
 include/sound/cs42l52.h                            |   2 +
 include/sound/cs42l73.h                            |  22 +
 include/sound/dmaengine_pcm.h                      |   8 +
 include/sound/rcar_snd.h                           |   1 -
 include/sound/soc-dai.h                            |  17 +
 include/sound/soc-dapm.h                           |   4 +
 include/sound/soc.h                                | 100 ++--
 include/trace/events/asoc.h                        |   1 +
 sound/arm/pxa2xx-ac97-lib.c                        |  27 +-
 sound/soc/Makefile                                 |   2 +-
 sound/soc/atmel/atmel-pcm.c                        |   2 +-
 sound/soc/atmel/atmel_wm8904.c                     |   8 -
 sound/soc/atmel/sam9g20_wm8731.c                   |   1 +
 sound/soc/blackfin/bf5xx-i2s.c                     |   1 +
 sound/soc/cirrus/Kconfig                           |   2 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |  13 +
 sound/soc/codecs/88pm860x-codec.c                  |  75 +--
 sound/soc/codecs/88pm860x-codec.h                  | 117 ++--
 sound/soc/codecs/ab8500-codec.c                    |  26 +-
 sound/soc/codecs/adau1373.c                        | 298 ++++++++--
 sound/soc/codecs/adav80x.c                         | 147 +++--
 sound/soc/codecs/ak4104.c                          |  11 +-
 sound/soc/codecs/ak4642.c                          |   4 +-
 sound/soc/codecs/arizona.c                         |  27 +-
 sound/soc/codecs/cq93vc.c                          |  46 +-
 sound/soc/codecs/cs4271.c                          |   1 +
 sound/soc/codecs/cs42l52.c                         |  93 +--
 sound/soc/codecs/cs42l52.h                         |   2 +-
 sound/soc/codecs/cs42l73.c                         | 114 ++--
 sound/soc/codecs/cs42l73.h                         | 105 ++--
 sound/soc/codecs/max98088.c                        | 624 +++++++++------------
 sound/soc/codecs/max98095.c                        | 466 ++++++---------
 sound/soc/codecs/max9850.c                         |  39 +-
 sound/soc/codecs/mc13783.c                         | 135 +++--
 sound/soc/codecs/ml26124.c                         |   2 +
 sound/soc/codecs/pcm1681.c                         |   1 +
 sound/soc/codecs/pcm1792a.c                        |   1 +
 sound/soc/codecs/rt5640.c                          |  31 +-
 sound/soc/codecs/si476x.c                          |  64 +--
 sound/soc/codecs/sn95031.c                         |  35 +-
 sound/soc/codecs/tas5086.c                         | 171 ++++--
 sound/soc/codecs/tlv320aic23.c                     |  84 ++-
 sound/soc/codecs/tlv320aic26.c                     | 139 +----
 sound/soc/codecs/tlv320aic26.h                     |   5 +-
 sound/soc/codecs/tlv320aic32x4.c                   | 101 +---
 sound/soc/codecs/tlv320aic3x.c                     | 234 ++++----
 sound/soc/codecs/tpa6130a2.c                       |  32 +-
 sound/soc/codecs/twl4030.c                         |  80 ++-
 sound/soc/codecs/twl6040.c                         |  26 +-
 sound/soc/codecs/wm0010.c                          |   8 +-
 sound/soc/codecs/wm5110.c                          |  55 +-
 sound/soc/codecs/wm8400.c                          |  95 +---
 sound/soc/codecs/wm8962.c                          | 228 ++++----
 sound/soc/codecs/wm8996.c                          |   2 +
 sound/soc/codecs/wm_adsp.c                         |  27 +-
 sound/soc/davinci/Kconfig                          |  18 +-
 sound/soc/davinci/Makefile                         |   1 +
 sound/soc/davinci/davinci-evm.c                    | 188 ++++++-
 sound/soc/davinci/davinci-mcasp.c                  | 169 ++++--
 sound/soc/davinci/davinci-mcasp.h                  |  12 +
 sound/soc/fsl/eukrea-tlv320.c                      |  15 +-
 sound/soc/fsl/fsl_spdif.c                          |  22 +-
 sound/soc/fsl/fsl_ssi.c                            |  22 +-
 sound/soc/fsl/imx-audmux.c                         |   9 +-
 sound/soc/fsl/imx-mc13783.c                        |   1 +
 sound/soc/fsl/imx-pcm-dma.c                        |   4 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |  29 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   4 +-
 sound/soc/fsl/imx-spdif.c                          |   4 +-
 sound/soc/fsl/imx-ssi.c                            |   3 -
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
 sound/soc/samsung/i2s.c                            |  25 +-
 sound/soc/samsung/smdk_wm8994.c                    |  14 +-
 sound/soc/sh/rcar/adg.c                            |  11 +-
 sound/soc/sh/rcar/core.c                           |  94 +---
 sound/soc/sh/rcar/gen.c                            | 261 +++++----
 sound/soc/sh/rcar/rsnd.h                           |   5 +-
 sound/soc/sh/rcar/scu.c                            |  14 +-
 sound/soc/sh/rcar/ssi.c                            |  52 +-
 sound/soc/soc-cache.c                              | 263 ++-------
 sound/soc/soc-core.c                               | 343 ++++++-----
 sound/soc/soc-dapm.c                               | 120 ++--
 sound/soc/soc-devres.c                             |  86 +++
 sound/soc/soc-generic-dmaengine-pcm.c              | 105 +++-
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
 sound/soc/tegra/tegra_pcm.c                        |   1 -
 141 files changed, 4424 insertions(+), 3118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l73.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tpa6130a2.txt
 create mode 100644 Documentation/sound/alsa/soc/DPCM.txt
 create mode 100644 include/sound/cs42l73.h
 create mode 100644 sound/soc/soc-devres.c

--MWhAmKkHIJcC5HOx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjhMFAAoJELSic+t+oim9kScQAIrxGe/aOlC9LZtDbhc5DPN3
hCEnuGKYmL1hhk5eoxqO9omnwg1SUPZBrgZGr56h4XzTSHkICdlGfTD02zJWQBUV
5R1NgahY9r7CN/CONoSxoA9ZYa8K2A3RFghcGM8Tk78yIyVYX+McnQCKgUcmR/pW
A6DS4m+C3W3rzM3ekNa6EZ7QTePzSWMkEHwxaPwk2BI9OYJ+nLl1Ey9B7Pggk5oQ
l66nLTnpvS6vgYQ4Xyw9csyV44qQkYIK4ZCXiriV+iqWIBNM9LEkmixKETwTMZNo
LnzqsFlWMCQPalVNqcFaA5eE8cbXfbAX3vnT5oyBGScU92L/0DToR62B7/b9IBEy
Y4lE0mJOpyoiaH1ru1+M2Ab3MuuiqNQ/eRmh28LRH4BKbTTdheIwd/fWj999VrTK
35B4tQbrdUMy0Xth9R6xHVnactm7TMfIalrh4HEkTC7HXjJLXMblB4mAJU5cz2Up
roy/UyCory1pIZO0WfdKRQXjFUFkMXAcOYcwWBaYuFk5bMWnB8Gu6fksiRBaEbbs
k8i5gn1bN3K1Wc7oHAMxNv0xjMWBIFORiG0G0Sz4s3Fazw+c65pqSxxHESs9rYk/
dR1zkB3DyHhZBcgzoUGU4UOzOxMHW6FIJ66U1RcpFpQM8E1qsFUVixI6pTXjib9u
ALjv/v9aa3NLYpMMAaCy
=pnKh
-----END PGP SIGNATURE-----

--MWhAmKkHIJcC5HOx--

--===============4548267381062769981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4548267381062769981==--
