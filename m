From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.11
Date: Fri, 5 Jul 2013 10:48:30 +0100
Message-ID: <20130705094830.GS27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0188858803567285754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A67126586C
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:48:36 +0200 (CEST)
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


--===============0188858803567285754==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIACWvcN4zbvddwE"
Content-Disposition: inline


--lIACWvcN4zbvddwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376:

  Linux 3.10 (2013-06-30 15:13:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.11-4

for you to fetch changes up to 70a9f8797ce298544cfd07328ff59f00488bc491:

  Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus (2013-07-04 18:30:03 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.11

A few small fixes, all driver specific.  The removal of the GPIO based
pinmuxing is a bug fix, since the obsolete nodes had been removed from
the DT it stopped the driver loading.

----------------------------------------------------------------
Arnaud Patard (1):
      ASoC: imx-sgtl5000: return E_PROBE_DEFER if ssi/codec not found

Mark Brown (5):
      ASoC: samsung: Remove obsolete GPIO based DT pinmuxing
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/mxs' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus

Sachin Kamat (1):
      ASoC: Samsung: Remove redundant comment

Shawn Guo (2):
      ASoC: mxs: register saif mclk to clock framework
      ASoC: wm8962: fix NULL pdata pointer

 Documentation/devicetree/bindings/mfd/arizona.txt  |   62 +
 .../devicetree/bindings/sound/adi,adau1701.txt     |   23 +
 .../devicetree/bindings/sound/imx-audio-wm8962.txt |   46 +
 .../devicetree/bindings/sound/mxs-saif.txt         |   17 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |   71 +
 Documentation/devicetree/bindings/sound/rt5640.txt |   30 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    3 +
 .../devicetree/bindings/sound/spdif-receiver.txt   |   10 +
 .../bindings/sound/spdif-transmitter.txt           |   10 +
 .../devicetree/bindings/sound/ssm2518.txt          |   20 +
 Documentation/devicetree/bindings/sound/wm8962.txt |   23 +
 arch/blackfin/mach-bf527/boards/ad7160eval.c       |   12 -
 arch/blackfin/mach-bf527/boards/ezkit.c            |   32 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |   12 -
 arch/blackfin/mach-bf533/boards/stamp.c            |   35 +-
 arch/blackfin/mach-bf537/boards/stamp.c            |   30 +-
 arch/blackfin/mach-bf548/boards/ezkit.c            |   28 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |   14 +-
 arch/blackfin/mach-bf609/boards/ezkit.c            |    2 +-
 drivers/mfd/arizona-core.c                         |  234 ++-
 drivers/mfd/arizona-i2c.c                          |   10 +-
 drivers/mfd/arizona-spi.c                          |   10 +-
 drivers/mfd/arizona.h                              |   12 +
 drivers/mfd/wm5102-tables.c                        |    9 +-
 drivers/mfd/wm5110-tables.c                        |    8 +
 drivers/misc/atmel-ssc.c                           |    8 +-
 include/linux/mfd/arizona/core.h                   |    2 +
 include/linux/mfd/arizona/pdata.h                  |    2 +-
 include/linux/mfd/arizona/registers.h              |   47 +
 include/linux/mfd/wm8994/pdata.h                   |    5 +
 include/linux/mfd/wm8994/registers.h               |    8 +
 include/linux/platform_data/ssm2518.h              |   22 +
 include/sound/rt5640.h                             |   22 +
 include/sound/soc-dapm.h                           |    3 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/sam9g20_wm8731.c                   |    9 -
 sound/soc/blackfin/Kconfig                         |   47 +-
 sound/soc/blackfin/Makefile                        |    4 -
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |    1 -
 sound/soc/blackfin/bf5xx-ac97-pcm.h                |   26 -
 sound/soc/blackfin/bf5xx-ac97.c                    |    8 +-
 sound/soc/blackfin/bf5xx-ad1836.c                  |   19 +-
 sound/soc/blackfin/bf5xx-ad193x.c                  |   40 +-
 sound/soc/blackfin/bf5xx-ad1980.c                  |    1 -
 sound/soc/blackfin/bf5xx-ad73311.c                 |    1 -
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |  183 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.h                 |   21 +-
 sound/soc/blackfin/bf5xx-i2s.c                     |  129 +-
 sound/soc/blackfin/bf5xx-sport.c                   |   10 +-
 sound/soc/blackfin/bf5xx-sport.h                   |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c                 |    1 -
 sound/soc/blackfin/bf5xx-tdm-pcm.c                 |  345 ----
 sound/soc/blackfin/bf5xx-tdm-pcm.h                 |   18 -
 sound/soc/blackfin/bf5xx-tdm.c                     |  328 ---
 sound/soc/blackfin/bf5xx-tdm.h                     |   23 -
 sound/soc/cirrus/Kconfig                           |    2 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |   16 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |   16 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |  138 +-
 sound/soc/codecs/88pm860x-codec.c                  |    9 +-
 sound/soc/codecs/Kconfig                           |   18 +-
 sound/soc/codecs/Makefile                          |   14 +-
 sound/soc/codecs/ab8500-codec.c                    |   85 +-
 sound/soc/codecs/ab8500-codec.h                    |   42 +-
 sound/soc/codecs/adau1701.c                        |   69 +-
 sound/soc/codecs/arizona.c                         |    7 +
 sound/soc/codecs/arizona.h                         |    3 +-
 sound/soc/codecs/{dfbmcs320.c => bt-sco.c}         |   37 +-
 sound/soc/codecs/{omap-hdmi.c => hdmi.c}           |   26 +-
 sound/soc/codecs/jz4740.c                          |    2 -
 sound/soc/codecs/max98090.c                        |   24 +-
 sound/soc/codecs/rt5640.c                          | 2128 ++++++++++++++++++++
 sound/soc/codecs/rt5640.h                          | 2092 +++++++++++++++++++
 sound/soc/codecs/sgtl5000.c                        |  267 ++-
 sound/soc/codecs/sgtl5000.h                        |    2 +-
 sound/soc/codecs/sn95031.c                         |    2 +-
 sound/soc/codecs/spdif_receiver.c                  |   10 +
 .../{spdif_transciever.c => spdif_transmitter.c}   |   10 +
 sound/soc/codecs/ssm2518.c                         |  856 ++++++++
 sound/soc/codecs/ssm2518.h                         |   20 +
 sound/soc/codecs/wm0010.c                          |   10 +
 sound/soc/codecs/wm5102.c                          |  205 +-
 sound/soc/codecs/wm5110.c                          |  192 ++
 sound/soc/codecs/wm8962.c                          |  145 +-
 sound/soc/codecs/wm8994.c                          |  188 +-
 sound/soc/codecs/wm8994.h                          |    3 +
 sound/soc/codecs/wm_adsp.c                         |  461 ++++-
 sound/soc/codecs/wm_adsp.h                         |    3 +
 sound/soc/davinci/Kconfig                          |   10 -
 sound/soc/davinci/Makefile                         |    2 -
 sound/soc/davinci/davinci-mcasp.c                  |    4 +-
 sound/soc/davinci/davinci-sffsdr.c                 |  181 --
 sound/soc/dwc/designware_i2s.c                     |    6 +-
 sound/soc/fsl/Kconfig                              |   17 +-
 sound/soc/fsl/Makefile                             |   13 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |   13 +-
 sound/soc/fsl/imx-audmux.c                         |    8 -
 sound/soc/fsl/imx-mc13783.c                        |    2 +-
 sound/soc/fsl/imx-pcm-dma.c                        |    2 +
 sound/soc/fsl/imx-pcm-fiq.c                        |   92 +
 sound/soc/fsl/imx-pcm.c                            |  145 --
 sound/soc/fsl/imx-pcm.h                            |   10 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   43 +-
 sound/soc/fsl/imx-ssi.c                            |   44 +-
 sound/soc/fsl/imx-ssi.h                            |    3 -
 sound/soc/fsl/imx-wm8962.c                         |  323 +++
 sound/soc/fsl/mx27vis-aic32x4.c                    |    2 +-
 sound/soc/fsl/phycore-ac97.c                       |    2 +-
 sound/soc/fsl/wm1133-ev1.c                         |    2 +-
 sound/soc/jz4740/jz4740-i2s.c                      |   17 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    2 +-
 sound/soc/mid-x86/mfld_machine.c                   |    1 -
 sound/soc/mxs/mxs-pcm.c                            |   18 -
 sound/soc/mxs/mxs-pcm.h                            |    7 -
 sound/soc/mxs/mxs-saif.c                           |   72 +-
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   10 +-
 sound/soc/omap/Makefile                            |    1 -
 sound/soc/omap/omap-hdmi-card.c                    |    2 +-
 sound/soc/omap/omap-mcbsp.c                        |    2 -
 sound/soc/pxa/Kconfig                              |   20 -
 sound/soc/pxa/Makefile                             |    4 -
 sound/soc/pxa/mmp-pcm.c                            |    6 +-
 sound/soc/pxa/mmp-sspa.c                           |    2 +-
 sound/soc/pxa/saarb.c                              |  190 --
 sound/soc/pxa/tavorevb3.c                          |  189 --
 sound/soc/pxa/zylonite.c                           |    1 -
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/bells.c                          |   14 +
 sound/soc/samsung/i2s.c                            |   66 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    2 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    4 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |    1 -
 sound/soc/samsung/smdk_wm8994pcm.c                 |    1 -
 sound/soc/sh/fsi.c                                 |   10 +-
 sound/soc/soc-core.c                               |  106 +-
 sound/soc/soc-dapm.c                               |  110 +-
 sound/soc/soc-pcm.c                                |   91 +-
 sound/soc/soc-utils.c                              |   13 +-
 sound/soc/spear/Kconfig                            |    9 +
 sound/soc/spear/Makefile                           |    8 +
 sound/soc/spear/spdif_in.c                         |   31 +-
 sound/soc/spear/spdif_out.c                        |   43 +-
 sound/soc/spear/spear_pcm.c                        |  152 +-
 sound/soc/tegra/Kconfig                            |   10 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra30_ahub.c                     |   25 +
 sound/soc/tegra/tegra30_i2s.c                      |   26 +
 sound/soc/tegra/tegra_asoc_utils.c                 |   23 +-
 sound/soc/tegra/tegra_rt5640.c                     |  257 +++
 sound/soc/ux500/mop500.c                           |    2 +-
 sound/soc/ux500/mop500_ab8500.c                    |   62 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   11 +-
 sound/soc/ux500/ux500_msp_dai.h                    |    4 -
 sound/soc/ux500/ux500_msp_i2s.c                    |   88 +-
 sound/soc/ux500/ux500_msp_i2s.h                    |   74 +-
 sound/soc/ux500/ux500_pcm.c                        |   30 +
 159 files changed, 8829 insertions(+), 3121 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1701.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm8962.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ssm2518.txt
 create mode 100644 include/linux/platform_data/ssm2518.h
 create mode 100644 include/sound/rt5640.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.h
 rename sound/soc/codecs/{dfbmcs320.c => bt-sco.c} (53%)
 rename sound/soc/codecs/{omap-hdmi.c => hdmi.c} (69%)
 create mode 100644 sound/soc/codecs/rt5640.c
 create mode 100644 sound/soc/codecs/rt5640.h
 rename sound/soc/codecs/{spdif_transciever.c => spdif_transmitter.c} (88%)
 create mode 100644 sound/soc/codecs/ssm2518.c
 create mode 100644 sound/soc/codecs/ssm2518.h
 delete mode 100644 sound/soc/davinci/davinci-sffsdr.c
 delete mode 100644 sound/soc/fsl/imx-pcm.c
 create mode 100644 sound/soc/fsl/imx-wm8962.c
 delete mode 100644 sound/soc/pxa/saarb.c
 delete mode 100644 sound/soc/pxa/tavorevb3.c
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/tegra/tegra_rt5640.c

--lIACWvcN4zbvddwE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pZrAAoJELSic+t+oim9wuwQAI9jvoto+iNl2qopa8tt2znW
VvmB9TM1Q5dQLBM1Vt37AOmhVu7A0RvQIBx0MnRA+f7Nrbz80A0vu6Q5MuAE0Fvg
eipR+nTZ7C3fxGjPj6E2271sVFWh4fh+cgy+6U9SkkyfSlVVc7FGpswNMcXD81V6
3qC22dAy+eYVqnv69Egtptvhxyda+yb/GPuieXOMR4xKjx9XoEF80P1bYPYX3Kr9
T5vKAC/jOR4lChznRqyZ8InGCD24ijYr7Cip8K/wrJZzeLwXQng57ezbMZZva+YZ
PTJnoQQy7foH8J8jTDrFO3Isg8cGBxoCbc++m+apfujceLR3BBTrzKcoTKYKlKuZ
ODd1Hkxxo1hlnHBDUFmFxw4VE6N6FQms8NR9Ns3QlNb/ikOuyBqtnSfJIF+3WZ1U
w2GXYdG4FTJBxR5/Batk9GxUA0O/R8Hw5/sayyggsnDofsVrHNL3doHKJfSG7kr4
Zm2pxesi4nuNw9In3jpuwu2E0LwJseIMtx4VaKXkhEEUC4AVOdj+Up6Fxy8Gowwl
G+EitRj4deH/Y6uL0oAro2zVJ+N2nrzTFGqxkOCDAw/QShaM1jDzs8XMo3UCh1rd
Of0xpHMmRttZsTg/CRkN9wyHW3SdeBtA70qDmKEbMXjydSEkod56THDJBaH1esVd
uHRON/JR7y6y7bEvt3ya
=lWsz
-----END PGP SIGNATURE-----

--lIACWvcN4zbvddwE--

--===============0188858803567285754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0188858803567285754==--
