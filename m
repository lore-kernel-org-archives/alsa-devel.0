From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.1
Date: Fri, 6 Mar 2015 13:23:23 +0000
Message-ID: <20150306132323.GO21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3035103657213717649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C26265DD2
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 14:23:29 +0100 (CET)
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


--===============3035103657213717649==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmJeD4q/N7j8p7mk"
Content-Disposition: inline


--cmJeD4q/N7j8p7mk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.1

for you to fetch changes up to d7e3281b52fea8917fb4a7a5b09df5e6a9d2850c:

  Merge remote-tracking branch 'asoc/topic/wm8804' into asoc-next (2015-03-=
05 01:07:27 +0000)

----------------------------------------------------------------
ASoC: Changes for v4.1

A selection of changes for v4.1 so far.  The main things are:

 - Move of jack registration to the card where it belongs.
 - Support for DAPM routes specified by both the machine driver and DT.

----------------------------------------------------------------
Alexandre Belloni (1):
      ASoC: sam9g20_wm8731: drop machine_is_xxx

Arnd Bergmann (2):
      ASoC: Samsung: add missing I2C/SPI dependencies
      ASoC: cirrus: tlv320aic23 needs I2C

Bard Liao (8):
      ASoC: rt5670: Add disabled item in dmic pin enum
      ASoC: rt5670: Fix the speaker mono output issue
      ASoC: rt5670: Set RT5670_IRQ_CTRL1 non volatile
      ASoC: rt5670: set platform data by dmi
      ASoC: rt5670: Add runtime PM support
      ASoC: rt5670: Keep sysclk on if JD func is used
      ASoC: rt5670: redefine ASRC control registers 0x84 and 0x85
      ASoC: rt5670: Fix the speaker mono output issue

Charles Keepax (3):
      ASoC: wm_adsp: Improve round to next 4-byte boundary
      ASoC: wm8804: Split out bus drivers
      ASoC: wm8804: Merge CODEC probe and bus probe

Fang, Yang A (2):
      ALSA: Add params_set_format helper
      ASoC: Intel: fix machine driver warnings

Guenter Roeck (1):
      ASoC: Fix MAX98357A codec driver dependencies

Jie Yang (1):
      ASoC: rt286: add jack detection disable with NULL jack passed

Jyri Sarha (1):
      ASoC: omap-pcm: Allow only formats with 1, 2, and 4 byte physical size

Kenneth Westfield (3):
      ASoC: max98357a: Add missing header files
      ASoC: max98357a: Remove use of DRV_NAME
      ASoC: max98357a: Use standard DAI names

Kiran Padwal (1):
      ASoC: omap-hdmi-audio: Add missing error check for devm_kzalloc

Kuninori Morimoto (1):
      ASoC: rsnd: set device data before snd_soc_register_platform/component

Lars-Peter Clausen (30):
      ASoC: sn95031: Pass CODEC to sn95031_jack_detection()
      ASoC: Allow to register jacks at the card level
      ASoC: simple-card: Register jacks at the card level
      ASoC: imx-es8328: Register jacks at the card level
      ASoC: wm1133-ev: Register jacks at the card level
      ASoC: broadwell: Register jacks at the card level
      ASoC: byt-max98090: Register jacks at the card level
      ASoC: cht_bsw_rt5645: Register jacks at the card level
      ASoC: mfld_machine: Register jacks at the card level
      ASoC: ams-deltea: Register jacks at the card level
      ASoC: omap-abe-twl6040: Register jacks at the card level
      ASoC: omap-twl4030: Register jacks at the card level
      ASoC: rx51: Register jacks at the card level
      ASoC: hx4700: Register jacks at the card level
      ASoC: palm27x: Register jacks at the card level
      ASoC: ttc-dkb: Register jacks at the card level
      ASoC: z2: Register jacks at the card level
      ASoC: h1980_uda1380: Register jacks at the card level
      ASoC: littlemill: Register jacks at the card level
      ASoC: lowland: Register jacks at the card level
      ASoC: rx1950_uda1380: Register jacks at the card level
      ASoC: smartq: Register jacks at the card level
      ASoC: speyside: Register jacks at the card level
      ASoC: tobermory: Register jacks at the card level
      ASoC: tegra_alc5632: Register jacks at the card level
      ASoC: tegra_max98090: Register jacks at the card level
      ASoC: tegra_rt5640: Register jacks at the card level
      ASoC: tegra_rt5677: Register jacks at the card level
      ASoC: tegra_wm8903: Register jacks at the card level
      ASoC: Remove snd_soc_jack_new()

Mark Brown (20):
      Merge branch 'fix/rt5677' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5677
      Merge remote-tracking branch 'asoc/fix/atmel-build' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cirrus' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl-ssi' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/max98357a' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/omap' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rsnd' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5670' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5677' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/simple' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sta32x' into asoc-linus
      Merge tag 'asoc-fix-v4.0-rc2' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm-dt' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/atmel', 'asoc/topic/davinc=
i', 'asoc/topic/gpiod' and 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/jack', 'asoc/topic/max9835=
7a', 'asoc/topic/omap' and 'asoc/topic/rt286' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5670', 'asoc/topic/rt567=
7', 'asoc/topic/simple', 'asoc/topic/tegra' and 'asoc/topic/wm-adsp' into a=
soc-next
      Merge remote-tracking branch 'asoc/topic/wm8804' into asoc-next

Mengdong Lin (2):
      ASoC: Intel: set initial runtime PM status to active for ACPI-enumera=
ted ADSP
      ASoC: rt5670: add API to select ASRC clock source

Nicolin Chen (3):
      ASoC: fsl_ssi: Fix the incorrect limitation of the bit clock rate
      ASoC: core: Add extra dapm properties for Device Tree
      ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()

Nikesh Oswal (1):
      ASoC: wm_adsp: Ensure DSP controls are always persistent

Oder Chiou (3):
      ASoC: rt5677: Correct the routing paths of that after IF1/2 DACx Mux
      ASoC: rt5677: Add the chip type to distinguish the setting of the clo=
ck source
      ASoC: rt5677: Keep the LDO2 powered while used in the suspend mode

Peter Rosin (3):
      ASoC: atmel_ssc_dai: Allow more rates
      ASoC: pcm512x: Rearrange to not repeat dacsrc_rate / dac_div
      ASoC: pcm512x: Allow independently overclocking PLL, DAC and DSP

Peter Ujfalusi (8):
      ASoC: omap: Kconfig: Support for omap5-uevm analog audio
      ASoC: davinci-mcasp: Add support for CBS_CFM mode
      ASoC: omap-pcm: Correct dma mask
      ASoC: davinci: Select SND_EDMA_SOC when SND_DAVINCI_SOC is enabled
      ASoC: davinci-i2s: Convert to use edma-pcm
      ASoC: davinci-vcif: Convert to use edma-pcm
      ASoC: davinci-mcasp: Deprecate the use of davinci-pcm in favor of edm=
a-pcm
      ASoC: davinci: Remove unused davinci-pcm platform driver

Subhransu S. Prusty (3):
      ASoC: Intel: Add memcpy32_fromio as well
      ASoC: Intel: Remove ignore suspend support
      ASoC: Intel: Remove soc pm handling to allow platform driver handle it

Thomas Niederpr=FCm (2):
      ASoC: sta32x: fix register range in regmap.
      ASoC: OMAP: mcbsp: Fix CLKX and CLKR pinmux when used as inputs

Tomeu Vizoso (3):
      ASoC: tegra: Expose Headphones pin to userspace
      ASoC: tegra: Add sink for the internal mic to tegra_max98090
      ASoC: tegra: Add control for the Mic Jack pin

Uwe Kleine-K=F6nig (1):
      ASoC: improve usage of gpiod API

Vincent Stehl=E9 (1):
      ASoC: max98357a: Fix missing include

Vinod Koul (12):
      ASoC: Intel: update MMX ID to 3
      ASoC: Intel: save and restore the CSR register
      ASoC: Intel: reset the DSP while suspending
      ASoC: core: allow pcms to be registered as nonatomic
      ASoC: Intel: mark cht machine driver with nonatomic trigger
      ASoC: Intel: update MMX ID to 3
      ASoC: Intel: add support for pause and resume in sst
      ASoC: Intel: add support for pcm stream suspend/resume
      ASoC: Intel: add support for platform suspend
      ASoC: Intel: add pm support in sst ipc driver
      ASoC: Intel: Move the fw download to power_control
      ASoC: Intel: wrap runtime_pm usage count under CONFIG_PM

Vishal Thanki (2):
      ASoC: simple-card: Add a NULL pointer check in asoc_simple_card_dai_l=
ink_of
      ASoC: simple-card: Add a NULL pointer check in asoc_simple_card_dai_l=
ink_of

 .../bindings/sound/nvidia,tegra-audio-max98090.txt |   1 +
 include/sound/pcm_params.h                         |   7 +
 include/sound/soc.h                                |  16 +-
 sound/soc/atmel/atmel_ssc_dai.c                    | 111 ++-
 sound/soc/atmel/atmel_ssc_dai.h                    |   1 +
 sound/soc/atmel/sam9g20_wm8731.c                   |  68 +-
 sound/soc/cirrus/Kconfig                           |   2 +-
 sound/soc/codecs/Kconfig                           |  20 +-
 sound/soc/codecs/Makefile                          |   4 +
 sound/soc/codecs/adau1977.c                        |  17 +-
 sound/soc/codecs/cs35l32.c                         |  19 +-
 sound/soc/codecs/cs4265.c                          |  19 +-
 sound/soc/codecs/max98357a.c                       |  23 +-
 sound/soc/codecs/pcm512x.c                         | 178 ++++-
 sound/soc/codecs/rt286.c                           |  17 +-
 sound/soc/codecs/rt5670.c                          |   7 +-
 sound/soc/codecs/rt5670.h                          |   3 +
 sound/soc/codecs/rt5677.c                          |  76 +-
 sound/soc/codecs/rt5677.h                          |   6 +
 sound/soc/codecs/sn95031.c                         |  14 +-
 sound/soc/codecs/sn95031.h                         |   3 +-
 sound/soc/codecs/sta32x.c                          |   6 +-
 sound/soc/codecs/sta350.c                          |  30 +-
 sound/soc/codecs/tas2552.c                         |  13 +-
 sound/soc/codecs/wm8804-i2c.c                      |  64 ++
 sound/soc/codecs/wm8804-spi.c                      |  56 ++
 sound/soc/codecs/wm8804.c                          | 281 ++-----
 sound/soc/codecs/wm8804.h                          |   7 +
 sound/soc/codecs/wm_adsp.c                         |  13 +-
 sound/soc/davinci/Kconfig                          |  18 +-
 sound/soc/davinci/Makefile                         |   2 -
 sound/soc/davinci/davinci-i2s.c                    |  67 +-
 sound/soc/davinci/davinci-mcasp.c                  |  99 +--
 sound/soc/davinci/davinci-pcm.c                    | 861 -----------------=
----
 sound/soc/davinci/davinci-pcm.h                    |  41 -
 sound/soc/davinci/davinci-vcif.c                   |  55 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   6 +
 sound/soc/fsl/fsl_ssi.c                            |  11 +-
 sound/soc/fsl/imx-es8328.c                         |   6 +-
 sound/soc/fsl/wm1133-ev1.c                         |  12 +-
 sound/soc/generic/simple-card.c                    |  25 +-
 sound/soc/intel/broadwell.c                        |  16 +-
 sound/soc/intel/byt-max98090.c                     |  11 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c                |   4 +-
 sound/soc/intel/cht_bsw_rt5645.c                   |  16 +-
 sound/soc/intel/cht_bsw_rt5672.c                   |   9 +-
 sound/soc/intel/haswell.c                          |   4 +-
 sound/soc/intel/mfld_machine.c                     |  24 +-
 sound/soc/intel/sst-atom-controls.h                |   2 +-
 sound/soc/intel/sst-mfld-platform-pcm.c            |  60 ++
 sound/soc/intel/sst-mfld-platform.h                |   1 +
 sound/soc/intel/sst/sst.c                          | 138 +++-
 sound/soc/intel/sst/sst.h                          |  12 +
 sound/soc/intel/sst/sst_drv_interface.c            |  65 +-
 sound/soc/intel/sst/sst_loader.c                   |  10 +-
 sound/soc/omap/Kconfig                             |   4 +-
 sound/soc/omap/ams-delta.c                         |   4 +-
 sound/soc/omap/omap-abe-twl6040.c                  |  10 +-
 sound/soc/omap/omap-hdmi-audio.c                   |   3 +
 sound/soc/omap/omap-mcbsp.c                        |  11 +
 sound/soc/omap/omap-pcm.c                          |  23 +-
 sound/soc/omap/omap-twl4030.c                      |  12 +-
 sound/soc/omap/rx51.c                              |   6 +-
 sound/soc/pxa/hx4700.c                             |  11 +-
 sound/soc/pxa/palm27x.c                            |  11 +-
 sound/soc/pxa/ttc-dkb.c                            |  15 +-
 sound/soc/pxa/z2.c                                 |  10 +-
 sound/soc/samsung/Kconfig                          |  10 +-
 sound/soc/samsung/h1940_uda1380.c                  |   9 +-
 sound/soc/samsung/littlemill.c                     |  12 +-
 sound/soc/samsung/lowland.c                        |  14 +-
 sound/soc/samsung/rx1950_uda1380.c                 |   9 +-
 sound/soc/samsung/smartq_wm8987.c                  |  11 +-
 sound/soc/samsung/speyside.c                       |  14 +-
 sound/soc/samsung/tobermory.c                      |  13 +-
 sound/soc/sh/rcar/core.c                           |   4 +-
 sound/soc/soc-core.c                               |  16 +-
 sound/soc/soc-jack.c                               |  42 +-
 sound/soc/soc-pcm.c                                |   1 +
 sound/soc/tegra/tegra_alc5632.c                    |   9 +-
 sound/soc/tegra/tegra_max98090.c                   |  26 +-
 sound/soc/tegra/tegra_rt5640.c                     |  10 +-
 sound/soc/tegra/tegra_rt5677.c                     |  14 +-
 sound/soc/tegra/tegra_wm8903.c                     |  18 +-
 84 files changed, 1282 insertions(+), 1727 deletions(-)
 create mode 100644 sound/soc/codecs/wm8804-i2c.c
 create mode 100644 sound/soc/codecs/wm8804-spi.c
 delete mode 100644 sound/soc/davinci/davinci-pcm.c
 delete mode 100644 sound/soc/davinci/davinci-pcm.h

--cmJeD4q/N7j8p7mk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+apLAAoJECTWi3JdVIfQGRAIAIFRmIJP2YYrDG9kTr+VHfpn
3ZVeELT5+56OguV+LoprOYFWsTwD964qWM03KAlcxF0JKG2INmlo7fBghvCLQN2Y
0AUc4xrRHSSjtmfKLTFzz4exIFoDdHIuV4NnFbJah1q3kL8ixkzOU/UoD+OtHvTK
q9rDx6t3rfNAR+/Kmdbe5S4WjOnXnIbEbzlsdj36m/kcCbRZECX/VXfw/MabnFzW
9RYSRJzmasQPPOP6L/K8yo+aY173NMlJ1MMSoTwTniDZGMvXGyRZ+njmTlsnBkXg
Iefjy5HsggamKPwB5c8GEHXaE+EiGUTD0zc6Nht2SvuEhU7ZAqTo7GQ0I7csA/Y=
=pza+
-----END PGP SIGNATURE-----

--cmJeD4q/N7j8p7mk--

--===============3035103657213717649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3035103657213717649==--
