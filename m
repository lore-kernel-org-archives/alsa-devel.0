From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.16
Date: Tue, 3 Jun 2014 10:46:45 +0100
Message-ID: <20140603094645.GR31751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537984228122278728=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B03F2610A1
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 11:47:09 +0200 (CEST)
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


--===============1537984228122278728==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9lPOKfY2vCV97ybw"
Content-Disposition: inline


--9lPOKfY2vCV97ybw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cee429e5c53f7ffc1dd500001d9dff567833c23d:

  Merge remote-tracking branches 'asoc/topic/ux500', 'asoc/topic/wm8731', 'asoc/topic/wm8804', 'asoc/topic/wm8955' and 'asoc/topic/wm8985' into asoc-next (2014-05-22 00:24:04 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.16-2

for you to fetch changes up to e1d4d3c854f25cff6c6c139588570e124d5e8fa4:

  ASoC: free jack GPIOs before the sound card is freed (2014-06-03 10:41:16 +0100)

----------------------------------------------------------------
ASoC: Final updates for v3.16

A few more updates from the last week of development, nothing too
exciting.  Highlights include:

- GPIO descriptor support for jacks
- More updates and fixes to the Freescale SSI, Intel and rsnd drivers.
- New drivers for Analog Devices ADAU1361, ADAU1381, ADAU1761 and
  ADAU1781, and Realtek RT5677.

----------------------------------------------------------------
Alexander Shiyan (1):
      ASoC: fsl: Remove dependencies of boards for SND_SOC_EUKREA_TLV320

Andrew Lunn (1):
      ASoC: simple-card: Support setting mclk via a fixed factor

Andy Shevchenko (1):
      ASoC: Intel: remove duplicate headers

Axel Lin (2):
      ASoC: sirf-audio-codec: Simplify the new bitmask value in regmap_update_bits
      ASoC: cs42l56: Fix new value argument in snd_soc_update_bits calls

Charles Keepax (1):
      ASoC: wm_adsp: Use adsp_err/warn instead of dev_err/warn

Chen Zhen (1):
      ASoC: max98090: Add NI/MI values for user pclk 19.2 MHz

Daniel Matuschek (1):
      ASoC: wm8804: Allow control of master clock divider in PLL generation

Fabio Estevam (2):
      ASoC: fsl_ssi: Add suspend/resume support
      ASoC: sgtl5000: Fix the cache handling

Imre Deak (1):
      ASoC: Intel: byt/hsw: Add missing kthread_stop to error/cleanup path

Jarkko Nikula (8):
      ASoC: jack: Basic GPIO descriptor conversion
      ASoC: jack: Add support for GPIO descriptor defined jack pins
      ASoC: jack: Clarify GPIO descriptor lookup in struct snd_soc_jack_gpio doc
      ASoC: jack: Fix multiple definition of `snd_soc_jack_add_gpiods'
      ASoC: Intel: Add Baytrail byt-max98090 machine driver
      ASoC: Intel: Clear stored Baytrail DSP DMA pointer before stream start
      ASoC: Intel: Use devm_snd_soc_register_card
      ASoC: Intel: byt-rt5640: Use card PM ops from core

Jyri Sarha (2):
      ASoC: simple-card: is_top_level_node parameter to simple_card_dai_link_of()
      ASoC: omap-pcm: Move omap-pcm under include/sound

Kees Cook (1):
      ASoC: Intel: avoid format string leak to thread name

Kuninori Morimoto (6):
      ASoC: rsnd: DT node clean up by using the of_node_put()
      ASoC: rsnd: save platform_device instead of device
      ASoC: rsnd: remove rsnd_src_non_ops
      ASoC: rsnd: module name is unified
      ASoC: rsnd: care DMA slave channel name for DT
      ASoC: rsnd: add rsnd_gen_dma_addr() for DMAC addr

Lars-Peter Clausen (7):
      ASoC: davinci-evm: Replace instances of rtd->codec->card with rtd->card
      ASoC: Add ADAU1X61 and ADAU1X81 CODECs common code
      ASoC: Add ADAU1361/ADAU1761 audio CODEC support
      ASoC: Add ADAU1381/ADAU1781 audio CODEC support
      ASoC: Blackfin: ADAU1X61 eval board support
      ASoC: Blackfin: ADAU1X81 eval board support
      ASoC: Add helper functions to cast from DAPM context to CODEC/platform

Mark Brown (19):
      Merge branch 'topic/davinci' of git://git.kernel.org/.../broonie/sound into asoc-omap
      Merge branch 'topic/fsl' of git://git.kernel.org/.../broonie/sound into asoc-fsl-ssi
      Merge branches 'topic/rt5640', 'topic/rt5645' and 'topic/rt5651' of git://git.kernel.org/.../broonie/sound into asoc-rl6231
      ASoC: intel: The Baytrail/MAX98090 driver depends on I2C
      ASoC: cache: Fix error code when not using ASoC level cache
      Merge remote-tracking branches 'asoc/fix/pxa' and 'asoc/fix/tlv320aic3x' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adau' and 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/alc5623' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l56' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl-ssi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/gpio' and 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98090' and 'asoc/topic/max98095' into asoc-next
      Merge remote-tracking branches 'asoc/topic/omap' and 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231' and 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sgtl5000', 'asoc/topic/simple' and 'asoc/topic/sirf' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8804' and 'asoc/topic/wm9713' into asoc-next

Markus Pargmann (4):
      ASoC: fsl-ssi: make fsl,mode property optional
      ASoC: fsl-ssi: Fix baudclock handling
      ASoC: fsl-ssi: reorder and document fsl_ssi_private
      ASoC: fsl-ssi: Use regmap

Matt Reimer (1):
      ASoC: wm9713: correct mono out PGA sources

Oder Chiou (4):
      ASoC: rt5640: Add RL6231 class device shared support for RT5640, RT5645 and RT5651
      ASoC: rt5640: Add the function of the PLL clock calculation to RL6231 shared support
      ASoC: rt5640: Add the function "get_clk_info" to RL6231 shared support
      ASoC: add RT5677 CODEC driver

Peter Ujfalusi (1):
      ASoC: tlv320aci3x: Fix custom snd_soc_dapm_put_volsw_aic3x() function

Sascha Hauer (4):
      ASoC: fsl-ssi: introduce SoC specific data
      ASoC: fsl-ssi: set bitclock in master mode from hw_params
      ASoC: fsl-ssi: remove unnecessary spinlock
      ASoC: fsl-ssi: Set framerate divider correctly for i2s master mode

Stephen Boyd (1):
      ASoC: pxa: pxa-ssp: Terminate of match table

Stephen Warren (2):
      ASoC: tegra: free jack GPIOs before the sound card is freed
      ASoC: free jack GPIOs before the sound card is freed

Sylwester Nawrocki (1):
      ASoC: samsung: Handle errors when getting the op_clk clock

Takashi Iwai (1):
      ASoC: alc5623: Fix Kconfig dependency

Tushar Behera (3):
      ASoC: max98090: Add master clock handling
      ASoC: max98095: Add master clock handling
      ASoC: samsung: Use params_width()

Xiubo Li (1):
      ASoC: cache: Fix possible ZERO_SIZE_PTR pointer dereferencing error.

 .../devicetree/bindings/sound/max98090.txt         |    6 +
 .../devicetree/bindings/sound/max98095.txt         |    6 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    1 +
 .../devicetree/bindings/sound/simple-card.txt      |    3 +
 include/linux/platform_data/adau17x1.h             |  109 +
 {sound/soc/omap => include/sound}/omap-pcm.h       |    0
 include/sound/rt5677.h                             |   21 +
 include/sound/soc.h                                |   49 +-
 sound/soc/blackfin/Kconfig                         |   26 +
 sound/soc/blackfin/Makefile                        |    4 +
 sound/soc/blackfin/bfin-eval-adau1x61.c            |  142 +
 sound/soc/blackfin/bfin-eval-adau1x81.c            |  130 +
 sound/soc/codecs/Kconfig                           |   52 +-
 sound/soc/codecs/Makefile                          |   22 +-
 sound/soc/codecs/adau1761-i2c.c                    |   60 +
 sound/soc/codecs/adau1761-spi.c                    |   77 +
 sound/soc/codecs/adau1761.c                        |  803 +++++
 sound/soc/codecs/adau1761.h                        |   23 +
 sound/soc/codecs/adau1781-i2c.c                    |   58 +
 sound/soc/codecs/adau1781-spi.c                    |   75 +
 sound/soc/codecs/adau1781.c                        |  511 +++
 sound/soc/codecs/adau1781.h                        |   23 +
 sound/soc/codecs/adau17x1.c                        |  866 +++++
 sound/soc/codecs/adau17x1.h                        |  124 +
 sound/soc/codecs/cs42l56.c                         |   70 +-
 sound/soc/codecs/cs42l56.h                         |   10 +-
 sound/soc/codecs/max98090.c                        |   31 +-
 sound/soc/codecs/max98090.h                        |    1 +
 sound/soc/codecs/max98095.c                        |   24 +
 sound/soc/codecs/rl6231.c                          |  152 +
 sound/soc/codecs/rl6231.h                          |   34 +
 sound/soc/codecs/rt5640.c                          |  108 +-
 sound/soc/codecs/rt5640.h                          |    8 -
 sound/soc/codecs/rt5645.c                          |  111 +-
 sound/soc/codecs/rt5645.h                          |    7 -
 sound/soc/codecs/rt5651.c                          |  107 +-
 sound/soc/codecs/rt5651.h                          |    1 -
 sound/soc/codecs/rt5677.c                          | 3498 ++++++++++++++++++++
 sound/soc/codecs/rt5677.h                          | 1451 ++++++++
 sound/soc/codecs/sgtl5000.c                        |   75 +-
 sound/soc/codecs/sirf-audio-codec.c                |    8 +-
 sound/soc/codecs/tlv320aic3x.c                     |    2 +-
 sound/soc/codecs/wm8804.c                          |   17 +-
 sound/soc/codecs/wm8804.h                          |    4 +
 sound/soc/codecs/wm9713.c                          |    3 +-
 sound/soc/codecs/wm_adsp.c                         |   37 +-
 sound/soc/davinci/davinci-evm.c                    |    9 +-
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 sound/soc/fsl/Kconfig                              |    8 +-
 sound/soc/fsl/fsl_ssi.c                            |  576 ++--
 sound/soc/fsl/fsl_ssi.h                            |   50 +-
 sound/soc/generic/simple-card.c                    |   39 +-
 sound/soc/intel/Kconfig                            |    9 +
 sound/soc/intel/Makefile                           |    2 +
 sound/soc/intel/byt-max98090.c                     |  203 ++
 sound/soc/intel/byt-rt5640.c                       |   27 +-
 sound/soc/intel/haswell.c                          |    9 +-
 sound/soc/intel/sst-acpi.c                         |    1 +
 sound/soc/intel/sst-baytrail-ipc.c                 |    8 +-
 sound/soc/intel/sst-baytrail-pcm.c                 |    1 +
 sound/soc/intel/sst-haswell-ipc.c                  |   15 +-
 sound/soc/intel/sst-haswell-pcm.c                  |    1 -
 sound/soc/omap/ams-delta.c                         |   14 +-
 sound/soc/omap/omap-dmic.c                         |    2 +-
 sound/soc/omap/omap-hdmi.c                         |    2 +-
 sound/soc/omap/omap-mcbsp.c                        |    2 +-
 sound/soc/omap/omap-mcpdm.c                        |    2 +-
 sound/soc/omap/omap-twl4030.c                      |   28 +-
 sound/soc/omap/rx51.c                              |   18 +-
 sound/soc/pxa/hx4700.c                             |    9 +-
 sound/soc/pxa/pxa-ssp.c                            |    1 +
 sound/soc/samsung/h1940_uda1380.c                  |   11 +-
 sound/soc/samsung/i2s.c                            |   14 +-
 sound/soc/samsung/pcm.c                            |    4 +-
 sound/soc/samsung/rx1950_uda1380.c                 |   12 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    8 +-
 sound/soc/samsung/s3c2412-i2s.c                    |    6 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    6 +-
 sound/soc/samsung/smartq_wm8987.c                  |   11 +-
 sound/soc/samsung/smdk_wm8580.c                    |    8 +-
 sound/soc/samsung/smdk_wm8994.c                    |    2 +-
 sound/soc/samsung/spdif.c                          |    4 +-
 sound/soc/sh/rcar/core.c                           |   87 +-
 sound/soc/sh/rcar/dvc.c                            |   20 +-
 sound/soc/sh/rcar/gen.c                            |   95 +
 sound/soc/sh/rcar/rsnd.h                           |   10 +-
 sound/soc/sh/rcar/src.c                            |   50 +-
 sound/soc/sh/rcar/ssi.c                            |   28 +-
 sound/soc/soc-cache.c                              |    3 +
 sound/soc/soc-jack.c                               |   88 +-
 sound/soc/tegra/tegra_alc5632.c                    |   16 +-
 sound/soc/tegra/tegra_max98090.c                   |   16 +-
 sound/soc/tegra/tegra_rt5640.c                     |   16 +-
 sound/soc/tegra/tegra_wm8903.c                     |   11 +-
 94 files changed, 9610 insertions(+), 904 deletions(-)
 create mode 100644 include/linux/platform_data/adau17x1.h
 rename {sound/soc/omap => include/sound}/omap-pcm.h (100%)
 create mode 100644 include/sound/rt5677.h
 create mode 100644 sound/soc/blackfin/bfin-eval-adau1x61.c
 create mode 100644 sound/soc/blackfin/bfin-eval-adau1x81.c
 create mode 100644 sound/soc/codecs/adau1761-i2c.c
 create mode 100644 sound/soc/codecs/adau1761-spi.c
 create mode 100644 sound/soc/codecs/adau1761.c
 create mode 100644 sound/soc/codecs/adau1761.h
 create mode 100644 sound/soc/codecs/adau1781-i2c.c
 create mode 100644 sound/soc/codecs/adau1781-spi.c
 create mode 100644 sound/soc/codecs/adau1781.c
 create mode 100644 sound/soc/codecs/adau1781.h
 create mode 100644 sound/soc/codecs/adau17x1.c
 create mode 100644 sound/soc/codecs/adau17x1.h
 create mode 100644 sound/soc/codecs/rl6231.c
 create mode 100644 sound/soc/codecs/rl6231.h
 create mode 100644 sound/soc/codecs/rt5677.c
 create mode 100644 sound/soc/codecs/rt5677.h
 create mode 100644 sound/soc/intel/byt-max98090.c

--9lPOKfY2vCV97ybw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjZmCAAoJELSic+t+oim9dkIQAIqJ0nXFId08vGCPkJC5T+75
IVMFpwQotU1iLs/V72OB6lgxHzXRHiCopHkO7mHm5ArxQOtWCAjzG7kJSIZB3rao
5tPrX1ympdzx1ZqdTwESzcIQxpmQiQ4TnjovC+idE/1NsOpoCdHkIVXQM0IxfaR8
KfvWATnZpWTJazD/FEr8RbGS2OngB4oJJjUur9Yb8josHwRC6fizS7sk3Ls33e5B
LaSVEKs5//Ni1H/QcDp/cwvb1IYWAGdjLaXF51UKwidM7wQNezizqg4N1L+p5gc/
o4Wm8eacEuKnxLrbC0dHQAjI+WGYJurucftRAvm26s9GldsX3A0RZOEux0rxuIpq
wTD8DcWuvBSe/wBnVsspGWdQOE3NcMrh2kjpSdKqNCtS/wBGpDo9HdX7awpQIAC+
65qmpYOmdCK99EcGfP8bD/5T1BErSV580EFV2umjOPDYCTqJzOW9pwPuXC6Oq23d
hQLRSUnUB8c5vnX5s5NE4BZKR5FndMyHYXH87anb6MrgFY0ZSpxlb85sFp/4U0Bb
9WM163tJIMAercM2059G9gAHWRqDRK1v5Xaq10Qab0GyxxIK71YtH6MhADzJCOf2
mIt7VThJ9CNLOoje6z9i05KwAFpA6cQdAQYoWCKaIYHJ6LIc1UObZkT3l23C3Wgf
WbV3EFOFX+npXNj7PB7P
=s39b
-----END PGP SIGNATURE-----

--9lPOKfY2vCV97ybw--

--===============1537984228122278728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1537984228122278728==--
