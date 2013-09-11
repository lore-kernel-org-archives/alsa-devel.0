From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.12
Date: Wed, 11 Sep 2013 11:30:28 +0100
Message-ID: <20130911103028.GL29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2727179824773825308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DFA5A261717
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 12:30:33 +0200 (CEST)
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


--===============2727179824773825308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WzkhdTkdDruxPGXI"
Content-Disposition: inline


--WzkhdTkdDruxPGXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6e4664525b1db28f8c4e1130957f70a94c19213e:

  Linux 3.11 (2013-09-02 13:46:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.12-4

for you to fetch changes up to 2ae2caff8348378c9e464353e9860ee97583c00b:

  Merge remote-tracking branch 'asoc/fix/rsnd' into asoc-linus (2013-09-11 11:17:17 +0100)

No idea what git thinks it's doing with the diffstat here...

----------------------------------------------------------------

ASoC: Fixes for v3.12

A few small fixes, nothing with any broad impact but all useful for the
affected systems.  The Kirkwood compatible string change is fixing up a
string just added in the merge window so that we don't get any changes
in released kernels.

----------------------------------------------------------------
Bo Shen (1):
      ASoC: atmel: disable error interrupt

Fabio Estevam (1):
      ASoC: fsl: imx-audmux: Do not call imx_audmux_parse_dt_defaults() on non-dt kernel

Kuninori Morimoto (1):
      ASoC: rsnd: fixup flag name of rsnd_scu_platform_info

Mark Brown (6):
      ASoC: fsl_spdif: Select regmap-mmio
      Merge remote-tracking branch 'asoc/fix/atmel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/kirkwood' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/mc13783' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rsnd' into asoc-linus

Steffen Trumtrar (1):
      ASoC: mc13783: add spi errata fix

Thomas Petazzoni (1):
      ASoC: kirkwood: change the compatible string of the kirkwood-i2s driver

 .../devicetree/bindings/misc/atmel-ssc.txt         |   23 +-
 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |   65 +
 Documentation/devicetree/bindings/sound/ak4554.c   |   11 +
 .../devicetree/bindings/sound/alc5632.txt          |   19 +
 .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   35 +
 .../devicetree/bindings/sound/atmel-wm8904.txt     |   55 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |   54 +
 .../{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt}     |   12 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   34 +
 .../devicetree/bindings/sound/imx-audmux.txt       |    9 +
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |   28 +
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt  |   15 +
 .../devicetree/bindings/sound/mvebu-audio.txt      |   33 +
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |   24 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |   26 +-
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |   27 +-
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   |   24 +-
 .../devicetree/bindings/sound/pcm1792a.txt         |   18 +
 Documentation/devicetree/bindings/sound/rt5640.txt |   20 +
 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 +-
 .../devicetree/bindings/sound/soc-ac97link.txt     |   28 +
 .../devicetree/bindings/sound/ti,pcm1681.txt       |   15 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    9 +-
 Documentation/devicetree/bindings/sound/wm8731.txt |    9 +
 Documentation/devicetree/bindings/sound/wm8753.txt |   24 +-
 Documentation/devicetree/bindings/sound/wm8903.txt |   19 +
 Documentation/devicetree/bindings/sound/wm8994.txt |    4 +
 Documentation/sound/alsa/HD-Audio-Models.txt       |    1 +
 Documentation/sound/alsa/HD-Audio.txt              |    2 +
 MAINTAINERS                                        |   13 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    9 +-
 arch/arm/mach-dove/common.c                        |    4 +-
 arch/arm/mach-kirkwood/common.c                    |   24 +-
 arch/arm/plat-pxa/ssp.c                            |  171 +-
 arch/arm/plat-samsung/s3c-dma-ops.c                |   13 +-
 include/dt-bindings/sound/fsl-imx-audmux.h         |   56 +
 include/linux/atmel-ssc.h                          |    2 +-
 include/linux/mfd/arizona/gpio.h                   |   96 +
 include/linux/platform_data/asoc-s3c.h             |    1 +
 include/linux/platform_data/omap-abe-twl6040.h     |   49 -
 include/linux/pxa2xx_ssp.h                         |   11 +
 include/sound/core.h                               |    8 +
 include/sound/pxa2xx-lib.h                         |    7 -
 include/sound/rcar_snd.h                           |   84 +
 include/sound/soc-dapm.h                           |  201 +-
 include/sound/soc-dpcm.h                           |    2 +-
 include/sound/soc.h                                |   47 +-
 include/uapi/sound/hdspm.h                         |    2 +-
 sound/arm/pxa2xx-ac97.c                            |   26 +-
 sound/arm/pxa2xx-pcm-lib.c                         |   52 +-
 sound/arm/pxa2xx-pcm.c                             |    5 +-
 sound/arm/pxa2xx-pcm.h                             |    6 +-
 sound/core/Kconfig                                 |    3 +
 sound/core/Makefile                                |    3 +
 .../soc-dmaengine-pcm.c => core/pcm_dmaengine.c}   |    0
 sound/core/pcm_lib.c                               |    4 +-
 sound/drivers/dummy.c                              |    2 +-
 sound/firewire/speakers.c                          |    4 +-
 sound/isa/gus/interwave.c                          |    3 +-
 sound/oss/dmabuf.c                                 |    3 +-
 sound/pci/hda/Kconfig                              |    9 +-
 sound/pci/hda/hda_codec.c                          |   64 +-
 sound/pci/hda/hda_codec.h                          |   21 +
 sound/pci/hda/hda_generic.c                        |   79 +-
 sound/pci/hda/hda_generic.h                        |    1 +
 sound/pci/hda/hda_hwdep.c                          |    6 +-
 sound/pci/hda/hda_intel.c                          |   34 +-
 sound/pci/hda/hda_jack.c                           |   22 +-
 sound/pci/hda/hda_jack.h                           |   13 +-
 sound/pci/hda/hda_proc.c                           |   33 +
 sound/pci/hda/patch_analog.c                       | 4662 +-------------------
 sound/pci/hda/patch_conexant.c                     |   79 +-
 sound/pci/hda/patch_hdmi.c                         |    9 +-
 sound/pci/hda/patch_realtek.c                      |  190 +-
 sound/pci/hda/patch_sigmatel.c                     |   14 +-
 sound/pci/hda/patch_via.c                          |    2 +-
 sound/pci/rme96.c                                  |  307 +-
 sound/pci/rme9652/hdspm.c                          |  779 +++-
 sound/soc/Kconfig                                  |    5 +-
 sound/soc/Makefile                                 |    4 -
 sound/soc/atmel/Kconfig                            |   21 +
 sound/soc/atmel/Makefile                           |    4 +
 sound/soc/atmel/atmel-pcm-dma.c                    |  118 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   36 +-
 sound/soc/atmel/atmel_wm8904.c                     |  254 ++
 sound/soc/atmel/sam9x5_wm8731.c                    |  208 +
 sound/soc/au1x/db1200.c                            |    4 +
 sound/soc/au1x/psc-ac97.c                          |    3 -
 sound/soc/blackfin/bf5xx-ac97.h                    |    1 -
 sound/soc/cirrus/ep93xx-ac97.c                     |    3 -
 sound/soc/cirrus/ep93xx-i2s.c                      |    5 -
 sound/soc/codecs/Kconfig                           |   19 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/ac97.c                            |   15 +
 sound/soc/codecs/ad1980.c                          |   43 +
 sound/soc/codecs/ad73311.c                         |   22 +-
 sound/soc/codecs/adau1701.c                        |   25 +-
 sound/soc/codecs/adav80x.c                         |   13 +-
 sound/soc/codecs/ads117x.c                         |   29 +-
 sound/soc/codecs/ak4104.c                          |   34 +-
 sound/soc/codecs/ak4554.c                          |  106 +
 sound/soc/codecs/ak5386.c                          |   17 +-
 sound/soc/codecs/arizona.c                         |   69 +-
 sound/soc/codecs/arizona.h                         |    5 +-
 sound/soc/codecs/bt-sco.c                          |   22 +-
 sound/soc/codecs/cs4270.c                          |   20 +
 sound/soc/codecs/cs4271.c                          |   30 +-
 sound/soc/codecs/dmic.c                            |   17 +-
 sound/soc/codecs/hdmi.c                            |   30 +-
 sound/soc/codecs/lm4857.c                          |  107 +-
 sound/soc/codecs/max9768.c                         |   16 +
 sound/soc/codecs/max98090.c                        |   10 +-
 sound/soc/codecs/max9877.c                         |  294 +-
 sound/soc/codecs/mc13783.c                         |    5 +-
 sound/soc/codecs/pcm1681.c                         |  339 ++
 sound/soc/codecs/pcm1792a.c                        |  257 ++
 sound/soc/codecs/pcm1792a.h                        |   26 +
 sound/soc/codecs/pcm3008.c                         |  150 +-
 sound/soc/codecs/rt5640.c                          |  235 +-
 sound/soc/codecs/rt5640.h                          |   12 +
 sound/soc/codecs/sgtl5000.c                        |   10 +-
 sound/soc/codecs/si476x.c                          |   14 +
 sound/soc/codecs/spdif_receiver.c                  |   17 +-
 sound/soc/codecs/spdif_transmitter.c               |   18 +-
 sound/soc/codecs/ssm2602.c                         |    3 +-
 sound/soc/codecs/sta32x.c                          |   10 +-
 sound/soc/codecs/tlv320aic26.c                     |   51 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   22 +-
 sound/soc/codecs/tlv320aic3x.c                     |   56 +-
 sound/soc/codecs/twl4030.c                         |    2 -
 sound/soc/codecs/twl6040.c                         |    7 +-
 sound/soc/codecs/uda134x.c                         |   88 +-
 sound/soc/codecs/wl1273.c                          |   17 +
 sound/soc/codecs/wm0010.c                          |   12 +-
 sound/soc/codecs/wm5102.c                          |   53 +-
 sound/soc/codecs/wm5110.c                          |   35 +-
 sound/soc/codecs/wm8350.c                          |    6 +-
 sound/soc/codecs/wm8727.c                          |   17 +-
 sound/soc/codecs/wm8731.c                          |   60 +-
 sound/soc/codecs/wm8753.c                          |    5 +-
 sound/soc/codecs/wm8782.c                          |   17 +-
 sound/soc/codecs/wm8903.c                          |    4 +-
 sound/soc/codecs/wm8904.c                          |    3 +-
 sound/soc/codecs/wm8960.c                          |   10 +-
 sound/soc/codecs/wm8962.c                          |    9 +-
 sound/soc/codecs/wm8994.c                          |   39 +-
 sound/soc/codecs/wm8995.c                          |    5 +-
 sound/soc/codecs/wm8997.c                          | 1175 +++++
 sound/soc/codecs/wm8997.h                          |   23 +
 sound/soc/codecs/wm_adsp.c                         |  124 +-
 sound/soc/codecs/wm_adsp.h                         |    3 +-
 sound/soc/codecs/wm_hubs.c                         |    8 +-
 sound/soc/dwc/designware_i2s.c                     |    5 +-
 sound/soc/fsl/Kconfig                              |   24 +-
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1225 +++++
 sound/soc/fsl/fsl_spdif.h                          |  191 +
 sound/soc/fsl/fsl_ssi.c                            |  501 ++-
 sound/soc/fsl/imx-audmux.c                         |   79 +-
 sound/soc/fsl/imx-audmux.h                         |   52 +-
 sound/soc/fsl/imx-mc13783.c                        |    1 +
 sound/soc/fsl/imx-pcm-dma.c                        |    4 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |   20 +-
 sound/soc/fsl/imx-pcm.h                            |   26 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    4 +-
 sound/soc/fsl/imx-spdif.c                          |  148 +
 sound/soc/fsl/imx-ssi.c                            |   11 +-
 sound/soc/fsl/imx-ssi.h                            |    1 +
 sound/soc/fsl/imx-wm8962.c                         |    3 +-
 sound/soc/generic/simple-card.c                    |    2 +
 sound/soc/kirkwood/Kconfig                         |   13 +-
 sound/soc/kirkwood/Makefile                        |    4 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |  108 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   94 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |    6 +-
 sound/soc/kirkwood/kirkwood-t5325.c                |    6 +-
 sound/soc/kirkwood/kirkwood.h                      |   11 +-
 sound/soc/mxs/Kconfig                              |    3 +-
 sound/soc/mxs/mxs-saif.c                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   32 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    3 -
 sound/soc/omap/Kconfig                             |    8 +-
 sound/soc/omap/mcbsp.c                             |    2 +-
 sound/soc/omap/omap-abe-twl6040.c                  |  133 +-
 sound/soc/omap/omap-dmic.c                         |    9 +-
 sound/soc/omap/omap-mcbsp.c                        |    5 +
 sound/soc/omap/omap-mcpdm.c                        |    3 -
 sound/soc/pxa/Kconfig                              |    2 +-
 sound/soc/pxa/brownstone.c                         |    1 +
 sound/soc/pxa/mioa701_wm9713.c                     |    7 +-
 sound/soc/pxa/mmp-pcm.c                            |    7 +-
 sound/soc/pxa/mmp-sspa.c                           |   15 +-
 sound/soc/pxa/pxa-ssp.c                            |   76 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   67 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |   28 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |   21 +-
 sound/soc/pxa/ttc-dkb.c                            |    1 +
 sound/soc/s6000/s6105-ipcam.c                      |    2 +-
 sound/soc/samsung/ac97.c                           |   11 +-
 sound/soc/samsung/dma.c                            |   19 +-
 sound/soc/samsung/dma.h                            |    4 +-
 sound/soc/samsung/i2s-regs.h                       |   51 +-
 sound/soc/samsung/i2s.c                            |  193 +-
 sound/soc/samsung/pcm.c                            |    4 +-
 sound/soc/samsung/s3c2412-i2s.c                    |    4 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    4 +-
 sound/soc/samsung/smdk_wm8994.c                    |   58 +-
 sound/soc/samsung/spdif.c                          |   12 +-
 sound/soc/sh/Kconfig                               |    7 +
 sound/soc/sh/Makefile                              |    3 +
 sound/soc/sh/fsi.c                                 |   51 +-
 sound/soc/sh/rcar/Makefile                         |    2 +
 sound/soc/sh/rcar/adg.c                            |  234 +
 sound/soc/sh/rcar/core.c                           |  861 ++++
 sound/soc/sh/rcar/gen.c                            |  280 ++
 sound/soc/sh/rcar/rsnd.h                           |  302 ++
 sound/soc/sh/rcar/scu.c                            |  236 +
 sound/soc/sh/rcar/ssi.c                            |  728 +++
 sound/soc/soc-compress.c                           |   13 +-
 sound/soc/soc-core.c                               |  253 +-
 sound/soc/soc-dapm.c                               |  819 ++--
 sound/soc/soc-jack.c                               |    4 +-
 sound/soc/soc-pcm.c                                |   25 +-
 sound/soc/spear/Kconfig                            |    2 +-
 sound/soc/tegra/Kconfig                            |   14 +-
 sound/soc/tegra/tegra20_ac97.c                     |    8 -
 sound/soc/tegra/tegra_alc5632.c                    |    2 -
 sound/soc/tegra/tegra_rt5640.c                     |    1 +
 sound/soc/tegra/tegra_wm8753.c                     |    2 -
 sound/soc/tegra/trimslice.c                        |    2 -
 sound/soc/txx9/txx9aclc-ac97.c                     |    3 -
 sound/soc/ux500/mop500.c                           |    1 +
 sound/usb/6fire/firmware.c                         |    4 +-
 sound/usb/endpoint.c                               |    3 +
 sound/usb/pcm.c                                    |  243 +-
 sound/usb/usx2y/usbusx2y.c                         |    8 +-
 236 files changed, 12494 insertions(+), 7410 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ak4554.c
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-wm8904.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (87%)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mvebu-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
 create mode 100644 include/dt-bindings/sound/fsl-imx-audmux.h
 create mode 100644 include/linux/mfd/arizona/gpio.h
 delete mode 100644 include/linux/platform_data/omap-abe-twl6040.h
 create mode 100644 include/sound/rcar_snd.h
 rename sound/{soc/soc-dmaengine-pcm.c => core/pcm_dmaengine.c} (100%)
 create mode 100644 sound/soc/atmel/atmel_wm8904.c
 create mode 100644 sound/soc/atmel/sam9x5_wm8731.c
 create mode 100644 sound/soc/codecs/ak4554.c
 create mode 100644 sound/soc/codecs/pcm1681.c
 create mode 100644 sound/soc/codecs/pcm1792a.c
 create mode 100644 sound/soc/codecs/pcm1792a.h
 create mode 100644 sound/soc/codecs/wm8997.c
 create mode 100644 sound/soc/codecs/wm8997.h
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
 create mode 100644 sound/soc/sh/rcar/Makefile
 create mode 100644 sound/soc/sh/rcar/adg.c
 create mode 100644 sound/soc/sh/rcar/core.c
 create mode 100644 sound/soc/sh/rcar/gen.c
 create mode 100644 sound/soc/sh/rcar/rsnd.h
 create mode 100644 sound/soc/sh/rcar/scu.c
 create mode 100644 sound/soc/sh/rcar/ssi.c

--WzkhdTkdDruxPGXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMEZBAAoJELSic+t+oim970wP/3w2PWWPl++isIk8a4aytCYW
T2Pk5z7j4tX8hyAIxrIDqMXz3zAX0aAEzirDI8d+17POJ2iYo12t1HO9Nvi7smIQ
dFCjJ545kIpzjperlq4pXU75zHFZdGhNk0QrOugBjgGUN9NiPsd4af3tgb8qsgso
6kb9eyFfKknuUWEPjtV0Pls4LUcTs9cLo619H+YvdwRsl0wKkJYgF6hC0LkR01OD
Jkvreo17C8Jessby3Pem8qKK7yxcOeHQ3YG/wnpmI7nw3iCqlh8zqD434t2XD9dS
ujZaijPNmRIBu+bao1FpUBTliX7weGaUPr0EPZejcRZvNo4A3ksweN202U5vdEHw
EKqQ27+aj5FbN830hwn1xYGqW7xcqsHmIfdPpP3O7yzF5UPYzpj8d0zV6bLnaalk
K9hEVyWAVeJJ4KhrR3bMr/oroL9/49FitZWRVg9qg/49T4y6MeAJvRmBZwM8+o47
bX2csgK+UTcgnZcuua8y2vL2F+j19drBEZWcvcXZPMpPuugmJmSZBWF1tiSuhXXw
VvkRgtSryDx/ujiQBVFewh3CTz6fNM+ZDJrKCoxijeLjQq5+GMG131GIdzjjEI7J
yGF113Xy/bwYPvfmCDNe3eoocZwtJQllligLYCMpnvpM5W77SBoWKrGRoBs4xw0K
qG9rjmr4f4KlLyY32kTj
=Zxla
-----END PGP SIGNATURE-----

--WzkhdTkdDruxPGXI--

--===============2727179824773825308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2727179824773825308==--
