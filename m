From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.14
Date: Thu, 16 Jan 2014 12:53:48 +0000
Message-ID: <20140116125348.GR15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2865617419957476503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7698D26167D
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 13:54:00 +0100 (CET)
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


--===============2865617419957476503==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtBqmokgY1evbO3C"
Content-Disposition: inline


--vtBqmokgY1evbO3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cdef2e5f358db5fd27eec4c72eb295c232287813:

  sound: oss: remove last sleep_on users (2014-01-14 16:12:07 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-2

for you to fetch changes up to 701caa51a2ce74182d39380ca11defeb163d98c1:

  Merge remote-tracking branches 'asoc/topic/adsp', 'asoc/topic/atmel', 'asoc/topic/bcm2835', 'asoc/topic/docs', 'asoc/topic/fsl', 'asoc/topic/generic', 'asoc/topic/kirkwood', 'asoc/topic/mc13783', 'asoc/topic/mxs', 'asoc/topic/nuc900', 'asoc/topic/sai', 'asoc/topic/sh', 'asoc/topic/ssm2602', 'asoc/topic/tlv320aic3x', 'asoc/topic/twl4030', 'asoc/topic/ux500', 'asoc/topic/width' and 'asoc/topic/x86' into for-tiwai (2014-01-16 12:44:01 +0000)

----------------------------------------------------------------

ASoC: More updates for v3.14

A few more updates for v3.14 since the last set, highlights include:

 - Lots of DMA updates from Lars-Peter
 - Improvements to the constraints handling code from Lars-Peter
 - A very helpful conversion of the TWL4030 driver to regmap from Peter
 - A new driver for the Freescale ESAI controller from Nicolin Chen
 - Conversion of some of the drivers to use params_width()

----------------------------------------------------------------
Alexander Shiyan (5):
      ASoC: fsl_ssi: Fix printing return code on clk error
      ASoC: mc13783: Use module_platform_driver_probe()
      ASoC: mc13783: Use core error messages if registration fails
      ASoC: mc13783: Drop fixed ADC & DAC ports usage
      ASoC: mc13783: trivial: Cleanup module

Andreas Pretzsch (1):
      ASoC: ssm2602: add 16kHz sampling rate support

Arun Shamanna Lakshmi (1):
      ASoC: dapm: Change prototype of soc_widget_read

Charles Keepax (5):
      ASoC: wm_adsp: Factor out ADSP2 boot proceedure
      ASoC: wm_adsp: Start DSP booting earlier in the DAPM process
      ASoC: wm_adsp: Mark wm_adsp2_boot_work as static
      mfd: wm5110: Add registers for headphone short circuit control
      ASoC: wm5110: Add controls for headphone short circuit protection

Fabio Estevam (1):
      ASoC: fsl: fsl_ssi: Use '%ld' to print 'long int'

Jean-Francois Moine (1):
      ASoC: pcm: Fix lack of platform bespoke_trigger() call

Lars-Peter Clausen (24):
      ASoC: atmel: Don't set unused struct snd_pcm_hardware fields
      ASoC: dpcm: Add helper function for initializing runtime pcm
      ASoC: dpcm: Allow PCMs to omit the set of supported formats
      ASoC: fsl: Don't set unused struct snd_pcm_hardware fields
      ASoC: mxs: Don't set unused struct snd_pcm_hardware fields
      ASoC: mxs: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
      ASoC: adau1701: Fix ADAU1701_SEROCTL_WORD_LEN_16 constant
      ASoC: intel: Don't set unused struct snd_pcm_hardware fields
      ASoC: kirkwood: Don't set unused struct snd_pcm_hardware fields
      ASoC: nuc900: Don't set unused struct snd_pcm_hardware fields
      ASoC: sh: Don't set unused struct snd_pcm_hardware fields
      ASoC: ux500: Don't set unused struct snd_pcm_hardware fields
      ASoC: Allow PCMs to restrict the supported formats
      ASoC: pcm: Properly initialize hw->rate_max
      ASoC: fsl: Don't mix SNDRV_PCM_RATE_CONTINUOUS with specific rates
      ASoC: s6000: Don't mix SNDRV_PCM_RATE_CONTINUOUS with specific rates
      ALSA: Add helper function for intersecting two rate masks
      ASoC: pcm: Use snd_pcm_rate_mask_intersect() helper
      dma: Indicate residue granularity in dma_slave_caps
      dma: pl330: Set residue_granularity
      ASoC: generic-dmaengine-pcm: Check NO_RESIDUE flag at runtime
      ASoC: generic-dmaengine-pcm: Check DMA residue granularity
      ASoC: axi-{spdif,i2s}: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
      ASoC: samsung: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag

Lee Jones (10):
      ARM: ux500: Don't use enums for MSP IDs - for easy DT conversion
      ASoC: ux500: Provide better checking for Device Tree and/or Platform Data
      ASoC: Ux500: Match platform by device node when booting Device Tree
      ASoC: ux500_pcm: Stop pretending that we support varying address widths
      ASoC: ux500_pcm: Expect different saved DMA data when obtaining from DAI store
      ASoC: ux500_pcm: Extend Device Tree support to deal with DMA data
      ASoC: ux500: Store DMA data in the DAI differently in the pdata and DT case
      ASoC: ux500_pcm: Take out pointless dev_dbg() call
      ASoC: ux500_pcm: Differentiate between pdata and DT initialisation
      ASoC: ux500: Dramatically reduce the size of the DAI driver data struct

Liam Girdwood (4):
      ASoC: docs: Update the Overview document
      ASoC: dpcm: Explicitly set BE DAI link supported stream directions
      ASoC: utils: Add internal call to determine if DAI is dummy.
      ASoC: sapm: Automatically connect DAI link widgets in DAPM graph.

Mark Brown (30):
      Merge tag 'ib-asoc-3.14.2' of git://git.linaro.org/people/ljones/mfd into asoc-tlw4030
      ASoC: ad1836: Use params_width() rather than explicit memory format
      ASoC: ad193x: Use params_width() rather than memory format
      ASoC: adau1373: Use params_width() rather than memory format
      ASoC: adau1701: Use params_width() rather than memory format
      ASoC: adav80x: Use params_width() rather than memory format
      Merge tag 'v3.13-rc3' into asoc-arizona
      ASoC: alc5623: Use params_width() rather than memory format
      ASoC: alc5632: Use params_width() rather than memory format
      ASoC: cs42l51: Use params_width() rather than memory format
      ASoC: da7210: Use params_width() rather than memory format
      ASoC: da7213: Use params_width() rather than memory format
      ASoC: da732x: Use params_width() rather than memory format
      ASoC: da9055: Use params_width() rather than memory format
      ASoC: isabelle: Use params_width() rather than memory format
      ASoC: max98088: Use params_width() rather than memory format
      ASoC: max98090: Use params_width() rather than memory format
      ASoC: max98095: Use params_width() rather than memory format
      ASoC: max9850: Use params_width() rather than memory format
      Merge tag 'v3.13-rc3' into asoc-pcm
      Merge branch 'topic/axi' of git://git.kernel.org/.../broonie/sound into asoc-dma
      Merge branch 'topic/samsung' of git://git.kernel.org/.../broonie/sound into asoc-dma
      ASoC: core: Return -ENOTSUPP from set_sysclk() if no operation provided
      Merge remote-tracking branches 'asoc/fix/adau1701' and 'asoc/fix/tlv320aic32x4' into for-tiwai
      Merge remote-tracking branch 'asoc/topic/core' into for-tiwai
      Merge remote-tracking branch 'asoc/topic/dapm' into for-tiwai
      Merge remote-tracking branch 'asoc/topic/dma' into for-tiwai
      Merge remote-tracking branch 'asoc/topic/pcm' into for-tiwai
      Merge remote-tracking branch 'asoc/topic/arizona' into for-tiwai
      Merge remote-tracking branches 'asoc/topic/adsp', 'asoc/topic/atmel', 'asoc/topic/bcm2835', 'asoc/topic/docs', 'asoc/topic/fsl', 'asoc/topic/generic', 'asoc/topic/kirkwood', 'asoc/topic/mc13783', 'asoc/topic/mxs', 'asoc/topic/nuc900', 'asoc/topic/sai', 'asoc/topic/sh', 'asoc/topic/ssm2602', 'asoc/topic/tlv320aic3x', 'asoc/topic/twl4030', 'asoc/topic/ux500', 'asoc/topic/width' and 'asoc/topic/x86' into for-tiwai

Markus Pargmann (13):
      ASoC: fsl-ssi: Fix probe error handling
      ASoC: fsl-ssi: Move sysfs stats to debugfs
      ASoC: fsl-ssi: Add imx51-ssi and of_device_id matching
      ASoC: fsl-ssi: Fix interrupt stats for imx
      ASoC: fsl-ssi: Add offline_config flag
      ASoC: fsl-ssi: Add configuration helper functions
      ASoC: fsl-ssi: Move RX/TX configuration to seperate functions
      ASoC: fsl-ssi: Drop ac97 specific trigger function
      ASoC: fsl-ssi doc: Add list of supported compatibles
      ASoC: fsl-ssi: Fix stats compile warning
      ASoC: codec: tlv320aic32x4: Fix regmap range config
      ASoC: tlv320aic3x: Add tlv320aic32x4 as compatible
      ASoC: tlv320aic32x4: Fix regmap range_min

Nicolin Chen (2):
      ASoC: fsl_ssi: Set default slot number for common cases
      ASoC: fsl_esai: Add ESAI CPU DAI driver

Peter Ujfalusi (11):
      mfd: twl-core: Simplify IO wrapper functions by moving common code out
      mfd: twl-core: API to set the regcache bypass for a given regmap in twl
      mfd: twl-core: Enable regcache for audio registers
      ASoC: twl4030: Separate write condition checking from I/O function
      ASoC: twl4030: Remove check defaults functionality
      ASoC: twl4030: Remove reset registers functionality
      ASoC: twl4030: Introduce local ctl register cache
      ASoC: twl4030: Remove local reg cache
      ASoC: twl4030: Parameter alignment fixes (for code consistency)
      ASoC: twl4030: Move the ctl cache update local to twl4030_write() function
      ASoC: twl4030: Pass the twl4030_priv directly to twl4030_can_write_to_chip()

Takashi Iwai (1):
      ASoC: bcm: Remove obsoleted Kconfig dependency

Wei Yongjun (2):
      ASoC: ux500: Fix sparse non static symbol warning
      ASoC: fsl-ssi: Add missing clk_disable_unprepare() on error in fsl_ssi_probe()

Xiubo Li (8):
      ASoC: simple-card: Fix the sysclk selection.
      ASoC: simple-card: fix the DAPM routes map parsing
      ASoC: simple-card: keep the property's name the same pattern
      ASoC: fsl-sai: Clean up the code
      ASoC: simple-card: fix a bug where cinfo will be NULL before using it
      ASoC: simple-card: fix the cinfo error check
      ASoC: simple-card: use snd_soc_card_set/get_drvdata
      ASoC: simple-card: fix one bug to writing to the platform data

 .../devicetree/bindings/sound/fsl,esai.txt         |  50 ++
 .../devicetree/bindings/sound/fsl,ssi.txt          |   7 +-
 .../devicetree/bindings/sound/simple-card.txt      |   2 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   1 +
 Documentation/sound/alsa/soc/overview.txt          |  27 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   8 +-
 drivers/dma/pl330.c                                |   1 +
 drivers/mfd/twl-core.c                             | 190 ++++-
 drivers/mfd/wm5110-tables.c                        |   6 +
 include/linux/dmaengine.h                          |  28 +
 include/linux/i2c/twl.h                            |   5 +-
 include/linux/mfd/arizona/registers.h              |  27 +
 include/linux/platform_data/asoc-ux500-msp.h       |   9 +-
 include/sound/pcm.h                                |   2 +
 include/sound/soc-dai.h                            |   2 +
 include/sound/soc-dapm.h                           |   1 +
 include/sound/soc.h                                |   4 +
 sound/core/pcm_misc.c                              |  39 +
 sound/soc/adi/axi-i2s.c                            |   3 +-
 sound/soc/adi/axi-spdif.c                          |   3 +-
 sound/soc/atmel/atmel-pcm-dma.c                    |   1 -
 sound/soc/atmel/atmel-pcm-pdc.c                    |   1 -
 sound/soc/bcm/Kconfig                              |   1 -
 sound/soc/codecs/ad1836.c                          |  10 +-
 sound/soc/codecs/ad193x.c                          |  10 +-
 sound/soc/codecs/adau1373.c                        |  10 +-
 sound/soc/codecs/adau1701.c                        |  36 +-
 sound/soc/codecs/adav80x.c                         |  30 +-
 sound/soc/codecs/alc5623.c                         |  10 +-
 sound/soc/codecs/alc5632.c                         |   8 +-
 sound/soc/codecs/arizona.h                         |  17 +-
 sound/soc/codecs/cs42l51.c                         |  14 +-
 sound/soc/codecs/da7210.c                          |  10 +-
 sound/soc/codecs/da7213.c                          |  10 +-
 sound/soc/codecs/da732x.c                          |  10 +-
 sound/soc/codecs/da9055.c                          |  10 +-
 sound/soc/codecs/isabelle.c                        |   6 +-
 sound/soc/codecs/max98088.c                        |   6 +-
 sound/soc/codecs/max98090.c                        |   4 +-
 sound/soc/codecs/max98095.c                        |   6 +-
 sound/soc/codecs/max9850.c                         |   8 +-
 sound/soc/codecs/mc13783.c                         |  34 +-
 sound/soc/codecs/ssm2602.c                         |  14 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   4 +-
 sound/soc/codecs/twl4030.c                         | 376 ++++------
 sound/soc/codecs/wm5110.c                          |   7 +
 sound/soc/codecs/wm_adsp.c                         | 199 +++--
 sound/soc/codecs/wm_adsp.h                         |  12 +-
 sound/soc/fsl/Kconfig                              |   3 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_dma.c                            |   7 -
 sound/soc/fsl/fsl_esai.c                           | 815 +++++++++++++++++++++
 sound/soc/fsl/fsl_esai.h                           | 354 +++++++++
 sound/soc/fsl/fsl_sai.c                            |   7 +-
 sound/soc/fsl/fsl_ssi.c                            | 586 ++++++++++-----
 sound/soc/fsl/imx-pcm-dma.c                        |   3 -
 sound/soc/fsl/imx-pcm-fiq.c                        |   3 -
 sound/soc/fsl/mpc5200_dma.c                        |   4 -
 sound/soc/fsl/mpc5200_psc_i2s.c                    |   3 +-
 sound/soc/generic/simple-card.c                    |  70 +-
 sound/soc/intel/sst_platform.c                     |  10 -
 sound/soc/intel/sst_platform.h                     |   4 -
 sound/soc/kirkwood/kirkwood-dma.c                  |  16 -
 sound/soc/mxs/mxs-pcm.c                            |   6 -
 sound/soc/nuc900/nuc900-pcm.c                      |   3 -
 sound/soc/s6000/s6000-i2s.c                        |   3 +-
 sound/soc/samsung/dmaengine.c                      |   1 -
 sound/soc/sh/dma-sh7760.c                          |  17 -
 sound/soc/sh/fsi.c                                 |   6 -
 sound/soc/sh/rcar/core.c                           |   6 -
 sound/soc/soc-core.c                               |   5 +-
 sound/soc/soc-dapm.c                               |  75 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |  66 +-
 sound/soc/soc-pcm.c                                |  58 +-
 sound/soc/soc-utils.c                              |   7 +
 sound/soc/ux500/mop500.c                           |   2 +
 sound/soc/ux500/ux500_msp_dai.c                    | 146 ++--
 sound/soc/ux500/ux500_msp_i2s.c                    |  56 +-
 sound/soc/ux500/ux500_msp_i2s.h                    |   2 +-
 sound/soc/ux500/ux500_pcm.c                        |  65 +-
 80 files changed, 2656 insertions(+), 1034 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
 create mode 100644 sound/soc/fsl/fsl_esai.c
 create mode 100644 sound/soc/fsl/fsl_esai.h

--vtBqmokgY1evbO3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS19ZZAAoJELSic+t+oim96KsP+gPNZ+60BUQ98Q5DEqsDSyKj
kv5jv4RU99wK2woDTKIIwR/mLumUPkC606BJ4yhaGJ7sA3FbxdXxdE6p2hDmkEGq
19THS7Z1YPkYVnrLYfaOcHTf+2nxpvijKHdsRxCC1BcZhdyoIOQ44yDHk+CzEu9B
AY5n+bUdc6iFVQIOHzpxQUFBmROlViMZFZeujbBgSymnqylDryiQqXs2vzNnUmT1
Qq9EHe/SdIg0LuvKdHG9vdZWs0Fk7NoIYRQH91CdSHoxYIefdngiKzAGuU/bOQTD
xKMTAf+Ypo3MB0Trlr2XQCstow1EjRYpwLcKgiE1nSIUvU73S1a1sPCgFMQ50SKV
UJ4R2VLZeK+TCtSoC9lE8E94vHpKCyqp8jac1plZO1VlaUZOa+mwtcs5nak3VLsn
VyUqfh5WfRcPlKCH0GnMIgOY+girkELPpFwJLAUGwpeEwM0sgTkGg7rBvDA2A48H
yJ+qe3DVk2QKAsQgTqEaqbh8RzoBEvFLyfPWqd6THtdwDaJLkUuGhIqvJkj3JI6F
8Vycab0Xfnl6blnYk+GhDfSzRnSm4FTGJhSSFIt1zdp/zPmZrsFInXwJ6nc3DD7h
XVHghxE4EJaPFUAPNuUGuCX/B1IJtrGM6Q3Y0oXr7LdDwqoiHSszItkcNFne2VZP
evkA/lUOjkyIsuRpFl3t
=ZuSr
-----END PGP SIGNATURE-----

--vtBqmokgY1evbO3C--

--===============2865617419957476503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2865617419957476503==--
