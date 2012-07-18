From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Wed, 18 Jul 2012 22:23:35 +0100
Message-ID: <20120718212334.GH4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8594833474231912711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A6CF264F15
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 23:23:34 +0200 (CEST)
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


--===============8594833474231912711==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.6

for you to fetch changes up to 409b78cc17a4a3d07a541037575da648ced99437:

  ASoC imx-audmux: add MX31_AUDMUX_PORT7_SSI_PINS_7 define (2012-07-18 22:0=
9:40 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.6

This has been a pretty quiet release - very little activity in framework
terms, mostly just a few new drivers and updates:

- Added the ability to add and remove DAPM paths dynamically, mostly for
  reparenting on clock changes.
- New machine drivers for Marvell Brownstone, ST-Ericsson Ux500
  reference platform and ttc-dkp.
- New CPU drivers for Blackfin BF6xx SPORTs in I2S mode, Marvell MMP,
  Synopsis Designware I2S controllers, and SPEAr DMA and S/PDIF
- New CODEC drivers for Dialog DA732x, ST STA529, ST-Ericsson AB8500, TI
  Isabelle and Wolfson Microelectronics WM5102 and WM5110

----------------------------------------------------------------
Adam Thomson (2):
      ASoC: core: Add single controls with specified range of values
      ASoC: codecs: Add DA732x codec driver

Axel Lin (1):
      ASoC: ml26124: Convert to devm_regmap_init_i2c

Beno=EEt Th=E9baudeau (2):
      ASoC: dapm: Fix snd_soc_dapm_put_volsw() connect
      ASoC: dapm: Remove incomplete stereo code

Brian Austin (2):
      ASoC: cs42l73: Convert to devm_regmap_init_i2c()
      ASoC: cs42l52: Convert to devm_regmap_init_i2c()

Dan Carpenter (3):
      ASoC: isabelle: using an uninitialized variable
      ASoC: Ux500: unlock on an error path
      ASoC: STA529: fix an error message

Fabio Estevam (1):
      ASoC: imx-mc13783: Add audmux settings for mx27pdk

Hui Wang (1):
      ASoC: fsl: remove unneeded AUDMUX register setting from imx-sgtl5000

Jarkko Nikula (1):
      ASoC: tlv320aic3x: Change Class-D amplifier gain control name

Jiri Prchal (5):
      ASoC: tlv320aic3x: add missing registers and bits
      ASoC: tlv320aic3x: extending registers cache
      ASoC: tlv320aic3x: add deemphasis switch
      ASoC: tlv320aic3x: add AGC settings
      ASoC: tlv320aic3x: add input clock selection

Kuninori Morimoto (2):
      ASoC: fsi: use dmaengine helper functions
      ASoC: fsi: use PIO handler if DMA handler was invalid

Lars-Peter Clausen (3):
      dmaengine: Add wrapper for device_tx_status callback
      ASoC: dmaengine-pcm: Rename and deprecate snd_dmaengine_pcm_pointer
      ASoC: dmaengine-pcm: Add support for querying stream position from DM=
A driver

Laxman Dewangan (1):
      ASoC: tegra: use dmaengine based dma driver

Liam Girdwood (2):
      ASoC: pcm: Clean up logging in soc_new_pcm()
      ASoC: dpcm: Allow FE to be opened without valid BE routes.

M R Swami Reddy (2):
      ASoC: Support TI Isabelle Audio driver
      ASoC: MAINTAINERS: Add maintainer for TI Isabelle Audio driver

MR Swami Reddy (1):
      ASoC: isabelle: Remove regmap_exit()

Marek Belisko (1):
      ASoC: dapm: Fix compilation warning

Mark Brown (61):
      ASoC: codecs: Refresh copyrights for Wolfson drivers
      ASoC: ac97: Remove empty remove() function
      ASoC: wm2000: Add register readability information
      ASoC: io: Use dev_get_regmap() if driver doesn't provide a regmap
      ASoC: wm8350: Convert to direct regmap API usage
      ASoC: dapm: Use devm_clk_get()
      ASoC: dapm: Bodge for lack of a widely available clk API
      ASoC: dapm: The clock API is even less consistent than thought
      Revert "ASoC: fsl_ssi: convert to use devm_clk_get"
      ASoC: lm59453: Unconstify dai_driver
      ASoC: max98095: Staticise non-exported functions and export jack dete=
ct
      ASoC: wm8903: Convert to devm_regmap_init_i2c()
      ASoC: wm8904: Convert to module_i2c_driver()
      ASoC: wm8904: Convert to devm_regmap_init_i2c()
      ASoC: wm8996: Remove write sequencer registers from the defaults table
      ASoC: wm8996: Convert to devm_regmap_init_i2c()
      ASoC: wm8903: Move pin configuration into I2C probe() function
      ASoC: wm8903: Make interrupt handler use regmap directly
      ASoC: wm8903: Move interrupt request to I2C probe
      ASoC: wm8903: Move register default changes to I2C probe
      Merge branch 'asoc-ab8500' into for-3.6
      ASoC: wm5100: Remove stubs of ASoC-level register map code
      ASoC: da732x: Staticise non-exported symbol soc_codec_dev_da732x
      ASoC: isabelle: Staticise non-exported isabelle_dai
      ASoC: core: Add DOUBLE_R variants of the _RANGE controls
      ASoC: dapm: Try to add all routes even if one fails
      ASoC: io: Don't dereference regmap if we failed to get one
      ASoC: Add shared code for Wolfson Arizona class devices
      ASoC: wm5102: Initial driver
      Merge tag 'v3.5-rc4' into for-3.6
      ASoC: wm8904: Rely entirely on the core for bias level management
      ASoC: wm8904: Move regulator acquisition and device identification to=
 I2C
      ASoC: wm8904: Move register default setup into I2C probe()
      ASoC: wm8996: Move regulator notifier callbacks into I2C level
      ASoC: wm8996: Inline wm8996_reset() and optimise cache-only usage
      ASoC: wm8996: Move register default configuration to I2C probe
      ASoC: dwc: Bodge around continuing absence of clock API stubs
      ASoC: wm5102: Remove unused platform data header
      ASoC: dwc: Add missing __iomem annotations
      ASoC: spdif: Build separate RX and TX objects
      ASoC: wm8962: Log AIF configuration requested by hw_params()
      ASoC: core: Try to use regmap if the driver doesn't set up any I/O
      ASoC: wm8994: Don't suspend accessory detection
      ASoC: dwc: Staticise non-exported i2s_start()
      ASoC: arizona: Rename current rates tables to bclk_rates
      ASoC: arizona: Implement AIF clock configuration
      ASoC: arizona: Be more forgiving in BCLK selection
      ASoC: arizona: Enable ASYNCCLK domain for audio interfaces
      ASoC: wm5102: Allow routing through the ASRCs
      ASoC: wm1250-ev1: Flag all supported rates in the DAI
      ASoC: dapm: Mark widgets as dirty when a route is added
      ASoC: dapm: Allow routes to be deleted at runtime
      ASoC: arizona: Change DAPM routes for AIF clocks when we change them
      ASoC: arizona: Export dai_ops
      ASoC: arizona: Add IN4 to the mixer tables
      ASoC: wm5102: Fix cut'n'paste for digital volume registers
      ASoC: arizona: Support variable FLL VCO multipliers
      ASoC: wm5110: Add audio CODEC driver
      ASoC: wm8962: Redo early init of the part on resume
      ASoC: wm8994: Update micdet for irqdomain conversion
      ASoC: littlemill: Add userspace control of the WM1250 I/O

Matthias Kaehlcke (1):
      ASoC: Free memory in the error paths of soc_of_parse_audio_routing()

Ola Lilja (7):
      ALSA: pcm: Add debug-print helper function
      ASoC: core: Add widget SND_SOC_DAPM_CLOCK_SUPPLY
      ASoC: Ux500: Add platform-driver
      ASoC: codecs: Add AB8500 codec-driver
      mfd/ab8500: Move platform-data for ab8500-codec into mfd-driver
      ASoC: Ux500: Correct license strings
      ASoC: Ux500: Add machine-driver

Qiao Zhou (1):
      ASoC: add ttc-dkb machine support

Rajeev Kumar (3):
      ASoC: Add support for synopsys i2s controller as per ASoC framework.
      ASoC: Add support for SPEAr ASoC pcm layer.
      ASoC: STA529: Add support for STA529 Audio Codec

Richard Zhao (1):
      ASoC: fsl_ssi: convert to use devm_clk_get

Sachin Kamat (3):
      ASoC: cs42l52: Remove version.h header file inclusion
      ASoC: lm49453: Remove version.h header file inclusion
      ASoC: smdk_wm8994: Convert to use snd_soc_register_card()

Scott Jiang (3):
      ASoC: add sport driver for bf6xx soc
      ASoC: add i2s dai driver for bf6xx soc
      ASoC: bfin: use dev_err to print error log instead of dev_dbg

Simon Wilson (1):
      ASoC: twl6040: fix spelling mistake

Stephen Warren (18):
      ASoC: wm8903: init GPIOs during I2C probe not codec probe
      ASoC: tegra+wm8903: move all GPIO setup into probe
      ASoC: tegra+wm8903: Use devm_gpio_request_one
      ASoC: tegra+wm8903: unconditionally free jack GPIOs in remove
      ASoC: tegra+alc5632: move all GPIO setup into probe
      ASoC: tegra+alc5632: unconditionally free jack GPIOs in remove
      ASoC: tegra+wm8903: simplify gpio tests in widget callbacks
      ASoC: tegra+wm8903: remove non-DT support for Seaboard
      ASoC: make snd_soc_dai_link more symmetrical
      ASoC: tegra: add .stream_name to CPU DAIs
      ASoC: tegra: statically define DAI link format
      ASoC: tegra: remove usage of rtd->codec
      ASoC: tegra: use DAI's not card's dev for dev_err
      ASoC: tegra: use regmap more directly
      ASoC: when initializing CPU DAI, don't duplicate any CODEC init
      ASoC: when removing a CPU DAI, clean up its DAPM context
      ASoC: factor out soc_remove_platform()
      ASoC: probe CODECs and platforms before DAIs and links

Sylwester Nawrocki (2):
      ASoC: Convert S3C24XX I2S driver to gpiolib API
      ASoC: Convert S3C2412 I2S driver to gpiolib API

Torben Hohn (1):
      ASoC imx-audmux: add MX31_AUDMUX_PORT7_SSI_PINS_7 define

Uwe Kleine-K=F6nig (1):
      ASoC: dmaengine_pcm: fix typo in comment

Vipin Kumar (3):
      ASoC: SPEAr spdif_in: Add spdif IN support
      ASoC: spdif_receiver: Add support for spdif in Audio Codec
      ASoC: SPEAr spdif_out: Add spdif out support

Zhangfei Gao (3):
      ASoC: mmp: add audio dma support
      ASoC: mmp: add sspa support
      ASoC: add mmp brownstone support

 MAINTAINERS                             |    2 +
 arch/arm/mach-ux500/board-mop500.c      |   14 +
 include/linux/dmaengine.h               |    6 +
 include/linux/mfd/abx500/ab8500-codec.h |   52 +
 include/linux/mfd/abx500/ab8500.h       |    2 +
 include/linux/platform_data/mmp_audio.h |   22 +
 include/sound/designware_i2s.h          |   69 +
 include/sound/dmaengine_pcm.h           |    1 +
 include/sound/pcm.h                     |   11 +
 include/sound/soc-dapm.h                |   12 +
 include/sound/soc.h                     |   77 +-
 include/sound/spear_dma.h               |   35 +
 include/sound/spear_spdif.h             |   29 +
 sound/soc/Kconfig                       |    1 +
 sound/soc/Makefile                      |    1 +
 sound/soc/blackfin/Kconfig              |   21 +-
 sound/soc/blackfin/Makefile             |    4 +
 sound/soc/blackfin/bf6xx-i2s.c          |  234 +++
 sound/soc/blackfin/bf6xx-sport.c        |  422 ++++++
 sound/soc/blackfin/bf6xx-sport.h        |   82 +
 sound/soc/codecs/Kconfig                |   31 +
 sound/soc/codecs/Makefile               |   19 +-
 sound/soc/codecs/ab8500-codec.c         | 2522 +++++++++++++++++++++++++++=
++++
 sound/soc/codecs/ab8500-codec.h         |  590 ++++++++
 sound/soc/codecs/ac97.c                 |    6 -
 sound/soc/codecs/arizona.c              |  937 ++++++++++++
 sound/soc/codecs/arizona.h              |  159 ++
 sound/soc/codecs/cs42l52.c              |   19 +-
 sound/soc/codecs/cs42l73.c              |   20 +-
 sound/soc/codecs/da732x.c               | 1627 ++++++++++++++++++++
 sound/soc/codecs/da732x.h               |  133 ++
 sound/soc/codecs/da732x_reg.h           |  654 ++++++++
 sound/soc/codecs/isabelle.c             | 1176 ++++++++++++++
 sound/soc/codecs/isabelle.h             |  143 ++
 sound/soc/codecs/lm49453.c              |    3 +-
 sound/soc/codecs/max98095.c             |    5 +-
 sound/soc/codecs/ml26124.c              |    5 +-
 sound/soc/codecs/spdif_receiver.c       |   67 +
 sound/soc/codecs/sta529.c               |  442 ++++++
 sound/soc/codecs/tlv320aic3x.c          |   40 +-
 sound/soc/codecs/tlv320aic3x.h          |   27 +-
 sound/soc/codecs/twl6040.c              |    2 +-
 sound/soc/codecs/wm1250-ev1.c           |    7 +-
 sound/soc/codecs/wm2000.c               |   32 +-
 sound/soc/codecs/wm5100-tables.c        |    2 +-
 sound/soc/codecs/wm5100.c               |   11 +-
 sound/soc/codecs/wm5102.c               |  903 +++++++++++
 sound/soc/codecs/wm5102.h               |   21 +
 sound/soc/codecs/wm5110.c               |  950 ++++++++++++
 sound/soc/codecs/wm5110.h               |   21 +
 sound/soc/codecs/wm8350.c               |   22 +-
 sound/soc/codecs/wm8400.c               |    2 +-
 sound/soc/codecs/wm8580.c               |    2 +-
 sound/soc/codecs/wm8731.c               |    1 +
 sound/soc/codecs/wm8741.c               |    2 +-
 sound/soc/codecs/wm8753.c               |    2 +-
 sound/soc/codecs/wm8776.c               |    2 +-
 sound/soc/codecs/wm8804.c               |    2 +-
 sound/soc/codecs/wm8903.c               |  316 ++--
 sound/soc/codecs/wm8904.c               |  272 ++--
 sound/soc/codecs/wm8960.c               |    2 +
 sound/soc/codecs/wm8961.c               |    2 +
 sound/soc/codecs/wm8962.c               |    8 +-
 sound/soc/codecs/wm8993.c               |    2 +-
 sound/soc/codecs/wm8994.c               |   46 +-
 sound/soc/codecs/wm8996.c               |  587 +++----
 sound/soc/codecs/wm9081.c               |    2 +-
 sound/soc/codecs/wm9090.c               |    2 +-
 sound/soc/codecs/wm9712.c               |    2 +-
 sound/soc/codecs/wm9713.c               |    2 +-
 sound/soc/codecs/wm_hubs.c              |    2 +-
 sound/soc/dwc/Kconfig                   |    9 +
 sound/soc/dwc/Makefile                  |    3 +
 sound/soc/dwc/designware_i2s.c          |  455 ++++++
 sound/soc/ep93xx/ep93xx-pcm.c           |    2 +-
 sound/soc/fsl/imx-audmux.c              |    2 +-
 sound/soc/fsl/imx-audmux.h              |    1 +
 sound/soc/fsl/imx-mc13783.c             |   49 +-
 sound/soc/fsl/imx-pcm-dma.c             |    2 +-
 sound/soc/fsl/imx-sgtl5000.c            |    3 +-
 sound/soc/mxs/mxs-pcm.c                 |    2 +-
 sound/soc/mxs/mxs-sgtl5000.c            |    2 +-
 sound/soc/pxa/Kconfig                   |   42 +
 sound/soc/pxa/Makefile                  |    8 +
 sound/soc/pxa/brownstone.c              |  174 +++
 sound/soc/pxa/mmp-pcm.c                 |  297 ++++
 sound/soc/pxa/mmp-sspa.c                |  480 ++++++
 sound/soc/pxa/mmp-sspa.h                |   92 ++
 sound/soc/pxa/ttc-dkb.c                 |  173 +++
 sound/soc/samsung/littlemill.c          |    7 +
 sound/soc/samsung/s3c2412-i2s.c         |   10 +-
 sound/soc/samsung/s3c24xx-i2s.c         |   10 +-
 sound/soc/samsung/smdk_wm8994.c         |   36 +-
 sound/soc/sh/fsi.c                      |   48 +-
 sound/soc/soc-core.c                    |  328 +++-
 sound/soc/soc-dapm.c                    |  164 +-
 sound/soc/soc-dmaengine-pcm.c           |   33 +-
 sound/soc/soc-io.c                      |   15 +-
 sound/soc/soc-pcm.c                     |   12 +-
 sound/soc/spear/spdif_in.c              |  297 ++++
 sound/soc/spear/spdif_in_regs.h         |   60 +
 sound/soc/spear/spdif_out.c             |  389 +++++
 sound/soc/spear/spdif_out_regs.h        |   79 +
 sound/soc/spear/spear_pcm.c             |  214 +++
 sound/soc/tegra/Kconfig                 |    3 +-
 sound/soc/tegra/tegra20_i2s.c           |   94 +-
 sound/soc/tegra/tegra20_i2s.h           |    1 -
 sound/soc/tegra/tegra20_spdif.c         |   36 +-
 sound/soc/tegra/tegra20_spdif.h         |    1 -
 sound/soc/tegra/tegra30_i2s.c           |   85 +-
 sound/soc/tegra/tegra30_i2s.h           |    1 -
 sound/soc/tegra/tegra_alc5632.c         |   32 +-
 sound/soc/tegra/tegra_pcm.c             |  115 ++
 sound/soc/tegra/tegra_pcm.h             |    2 +
 sound/soc/tegra/tegra_wm8753.c          |    8 +-
 sound/soc/tegra/tegra_wm8903.c          |  259 ++--
 sound/soc/tegra/trimslice.c             |   30 +-
 sound/soc/ux500/Kconfig                 |   18 +
 sound/soc/ux500/Makefile                |    6 +
 sound/soc/ux500/mop500.c                |  113 ++
 sound/soc/ux500/mop500_ab8500.c         |  431 ++++++
 sound/soc/ux500/mop500_ab8500.h         |   22 +
 sound/soc/ux500/ux500_msp_dai.c         |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c         |    2 +-
 sound/soc/ux500/ux500_pcm.c             |  318 ++++
 sound/soc/ux500/ux500_pcm.h             |   35 +
 126 files changed, 16719 insertions(+), 1344 deletions(-)
 create mode 100644 include/linux/mfd/abx500/ab8500-codec.h
 create mode 100644 include/linux/platform_data/mmp_audio.h
 create mode 100644 include/sound/designware_i2s.h
 create mode 100644 include/sound/spear_dma.h
 create mode 100644 include/sound/spear_spdif.h
 create mode 100644 sound/soc/blackfin/bf6xx-i2s.c
 create mode 100644 sound/soc/blackfin/bf6xx-sport.c
 create mode 100644 sound/soc/blackfin/bf6xx-sport.h
 create mode 100644 sound/soc/codecs/ab8500-codec.c
 create mode 100644 sound/soc/codecs/ab8500-codec.h
 create mode 100644 sound/soc/codecs/arizona.c
 create mode 100644 sound/soc/codecs/arizona.h
 create mode 100644 sound/soc/codecs/da732x.c
 create mode 100644 sound/soc/codecs/da732x.h
 create mode 100644 sound/soc/codecs/da732x_reg.h
 create mode 100644 sound/soc/codecs/isabelle.c
 create mode 100644 sound/soc/codecs/isabelle.h
 create mode 100644 sound/soc/codecs/spdif_receiver.c
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/codecs/wm5102.c
 create mode 100644 sound/soc/codecs/wm5102.h
 create mode 100644 sound/soc/codecs/wm5110.c
 create mode 100644 sound/soc/codecs/wm5110.h
 create mode 100644 sound/soc/dwc/Kconfig
 create mode 100644 sound/soc/dwc/Makefile
 create mode 100644 sound/soc/dwc/designware_i2s.c
 create mode 100644 sound/soc/pxa/brownstone.c
 create mode 100644 sound/soc/pxa/mmp-pcm.c
 create mode 100644 sound/soc/pxa/mmp-sspa.c
 create mode 100644 sound/soc/pxa/mmp-sspa.h
 create mode 100644 sound/soc/pxa/ttc-dkb.c
 create mode 100644 sound/soc/spear/spdif_in.c
 create mode 100644 sound/soc/spear/spdif_in_regs.h
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h
 create mode 100644 sound/soc/spear/spear_pcm.c
 create mode 100644 sound/soc/ux500/mop500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJQBylPAAoJEBus8iNuMP3dhzEP+M9xb7k8mUkP5hf063pGbc9L
5lZ2gF+eMZyaZzJJ79cWTB1nqyjln7diiPqzOwclDAjKIqFQ5zMWMS5ITdfht8kT
TPjA8EMMKPZqx/oIbigCXIuCCL2InLK+60w+mdMvLxt8W/00/wUAtzqj1tqZrhbB
gleD8rJWi9WeLeQbSEz+iTtKAeFBXVrFcxRF5n/nt/v6QWF/De8UAFyEPwKcJVWo
jLf1fauthWBUxoBIUEtiyYf/wMmjJhtQ820iNvo6V65mDvqiW0/VIWQNXb/j9zSI
otdor+ROgoSVne3rmiyL/1SiWobvOjortDmrSRhlJ9n/UBNmycj81RUg/L0mN2cs
cLZ/cgKAUWzjVc/AW756G+0QVc85ukVrWPXyQrI54Q0GrmUBdN2AIFtXCjF83MeZ
TY27M67VvsOD+ezhM234vefEoX4SqUwaRh5K13p/gnwPAw80DaNEVtBHFumiKSyL
sUFjsbsJCK5PC1T+Owk312odJH5tYnkHrV4B+3wqeio+5vV3Obo25Y/3Jnw8Dd2h
D+9OrDo0d9IBJVAoArezreGsIXL+PL17wXrtCfKkgRVdtRnOAOPZoRPOuUvy1B5E
U7yex2NimxlFMgSmF94hy3VAZb3h8EHI6Spde7t5nciIgwdwc3BzzeH/VKa5AGVt
QDFcfI5dDPjlR1uFLFE=
=NORx
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--

--===============8594833474231912711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8594833474231912711==--
