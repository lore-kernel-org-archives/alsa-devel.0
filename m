From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.11
Date: Fri, 21 Jun 2013 16:42:54 +0100
Message-ID: <20130621154254.GE27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8734592311635367478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 02B57261612
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 17:42:59 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8734592311635367478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIK88BWnNPSddvdK"
Content-Disposition: inline


--oIK88BWnNPSddvdK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.11

for you to fetch changes up to 84bbc4aa2de97143db0f6ef0c3fa0bd84f73b207:

  Merge remote-tracking branch 'asoc/topic/x86' into asoc-next (2013-06-17 =
17:20:33 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.11

Not a big release subsystem wise, the main changes have been some nice
improvements on the driver side:

- Lots of cleanups and fixes for Blackfin, SGTL5000 and UX500.
- Generalisation of the Bluetooth and HDMI stub drivers.
- New CODEC drivers for SSM2518 and RT5640.
- New machine driver for Tegra CPUs with RT5640.

----------------------------------------------------------------
Andrew Bresticker (1):
      ASoC: max98090: add digital mic mux to record path

Axel Lin (2):
      ASoC: ssm2518: Fix trivial typo in checking tx_mask and rx_mask values
      ASoC: adav80x: Select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI

Bard Liao (1):
      ASoC: add RT5640 CODEC driver

Barry Song (2):
      ASoC: dfbmcs320: make the driver common for other BT modules
      ASoC: omap-hdmi-codec: make the driver common for other SoCs

Boris BREZILLON (1):
      ASoC: atmel-ssc: prepare clk before calling enable

Charles Keepax (10):
      ASoC: wm5102: Correct OSR control name for EPOUT
      mfd: wm5102: Manually apply register patch
      mfd: arizona: Change fast_start pdata name to better reflect function=
ality
      ASoC: bells: Hookup DMICs for Bells
      ASoC: wm0010: Set IRQ as a wake source
      ASoC: wm0010: Clear IRQ as wake source and include missing header
      ASoC: arizona: Hookup SYSCLK to inputs and noise generators
      mfd: wm5102: Expose DRE control registers
      ASoC: wm5102: Expose controls for DRE
      ASoC: wm5110: Correct rate control for DSP4

Dan Carpenter (2):
      ASoC: wm_adsp: memory leak in wm_adsp_create_control()
      ASoC: wm8994: missing break in wm8994_get_fll_config()

Daniel Mack (3):
      ASoC: adau1701: refactor firmware loading function
      ASoC: codecs: adau1701: add DT bindings
      ASoC: codecs: adau1701: factor out firmware reset

Dimitris Papastamos (2):
      ASoC: wm_adsp: Expose coefficient blocks as ALSA binary controls
      ASoC: wm_adsp: Ensure set controls are synced on each boot

Emil Goode (1):
      ASoC: Fix double assignment of .owner in struct snd_soc_card

Fabio Baltieri (15):
      ASoC: ux500: register controls to card instead of codec
      ASoC: ux500: drop clock gating widgets from machine driver
      ASoC: ab8500-codec: Add missing ad_to_slot definitions
      ASoC: ab8500-codec: Set tx dai slots from tx_mask
      ASoC: ab8500-codec: Set rx dai slots from rx_mask
      ASoC: ux500: Drop pinctrl sleep support
      ASoC: ab8500-codec: Move codec ops on a separate structure
      ASoC: ux500: Drop dangling struct i2s_controller
      ASoC: ux500: Drop unused code from msp headers
      ASoC: ux500: Add missing mop500_ab8500.h include
      ASoC: ux500: Drop redundant msp id enumerations
      ASoC: ux500: Ensure consistent configuration between DAIs
      ASoC: ux500: Move DMA parameters into ux500_msp
      ASoC: ux500: Set DMA address during device init
      ASoC: ux500: Add DMA slave config prepare routine

Fabio Estevam (15):
      ASoC: imx-sgtl5000: Do not enter the error path on success
      ASoC: mxs-sgtl5000: Remove unneeded 'ret' variable
      ASoC: mxs-sgtl5000: Remove unneeded fields from snd_soc_dai_link
      ASoC: fsl: imx-audmux: Let device core handle pinctrl
      ASoC: mxs: mxs-saif: Let device core handle pinctrl
      ASoC: sgtl5000: Fix comment about register addresses
      ASoC: sgtl5000: Convert to use regmap directly
      ASoC: mxs-sgtl5000: Remove unneeded 'ret' variable
      ASoC: mxs-sgtl5000: Remove unneeded fields from snd_soc_dai_link
      ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe()
      ASoC: sgtl5000: Fix driver probe after reset
      ASoC: sgtl5000: Let the codec acquire its clock
      ASoC: sgtl5000: Use i2c_get_clientdata()
      ASoC: sgtl5000: Add 'clocks' entry as a required propery
      ASoC: imx-sgtl5000: Use devm_clk_get()

Geert Uytterhoeven (1):
      blackfin: bf533-stamp: Remove bogus "||"

Kuninori Morimoto (1):
      ASoC: fsi: fixup sparse errors

Lars-Peter Clausen (36):
      ASoC: spear: Setup dma data in DAI probe
      ASoC: spear: Use generic dmaengine PCM
      ASoC: jz4740-i2s: Use clk_prepare_enable/clk_disable_unprepare
      ASoC: ep93xx: Setup dma data in DAI probe
      ASoC: ep93xx: Use generic dmaengine PCM
      ASoC: core: Move snd_soc_set_runtime_hwparams() to soc-pcm.c
      ASoC: core: Add helper function to initialize the runtime pcm
      ASoC: core: Use kasprintf instead of opencoding it
      ASoC: ep93xx-i2s: Staticize non exported struct
      ASoC: kirkwood-dma: Staticize non exported struct
      ASoC: spear: spdif_in: Staticize non exported struct
      ASoC: spear: spdif_out: Staticize unexported function
      ASoC: mmp-pcm: Staticize non exported structs and functions
      ASoC: mmp-sspa: Staticize non exported struct
      ASoC: bf5xx-tdm-pcm: Staticize non exported struct
      ASoC: mop500_ab8500: Staticize non exported functions
      ASoC: mop500: Staticize non exported struct
      ASoC: sn95031: Staticize non exported struct
      ASoC: davinci-sffsdr: Staticize non exported struct
      ASoC: Fix early event callback list iteration
      ASoC: Add ssm2518 support
      ASoC: blackfin: Remove unused bf5xx-{i2s, tdm, ac97}-pcm.h
      ASoC: blackfin: bf5xx-i2s: Use dev_{err, dbg} instead of pr_{error, d=
ebug}
      ASoC: blackfin: bf5xx-sport: Allow setting rx and tx mask independent=
ly
      ASoC: blackfin: bf5xx-i2s: Allocate buffer only as large as requested
      ASoC: blackfin: bf5xx-i2s-pcm: Use snd_pcm_lib_preallocate_pages_for_=
all()
      ASoC: blackfin: bf5xx-i2s: Add support for TDM mode
      ASoC: blackfin: Switch bf5xx-ad193x from bf5xx-tdm to bf5xx-i2s
      ASoC: blackfin: Switch bf5xx-ad1836 from bf5xx-tdm to bf5xx-i2s
      ASoC: blackfin: Remove bf5xx-tdm driver
      blackfin: Remove references to the bf5x_tdm driver
      ASoC: dapm: Setup private_free callback for dapm kcontrols
      ASoC: dapm: Remove unnecessary loop
      ASoC: dapm: Add a helper function to free a DAPM path
      ASoC: dapm: Remove unused long_name field from snd_soc_dapm_path stru=
ct
      ASoC: dapm: Add snd_soc_dapm_switch to the power up/down sequence tab=
le

Marek Belisko (3):
      ASoC: spdif_transceiver: Change driver filename to spdif_transmitter.=
c.
      ASoC: spdif_transmitter: Add DT support.
      ASoC: spdif_receiver: Add DT support.

Marek Vasut (1):
      ASoC: sgtl5000: Fix VAG_POWER enabling/disabling order

Mark Brown (68):
      ASoC: sam9g20ek: Let device core handle pinctrl
      ASoC: dapm: Provide early event callbacks for power up and down
      ASoC: wm8994: Support EFS mode for FLL
      mfd: arizona: Read the device identification information after boot
      mfd: arizona: Add missing cleanup on remove
      mfd: arizona: Disable interrupts during suspend
      mfd: Add device tree bindings for Arizona class devices
      mfd: arizona: Support use of external DCVDD
      ASoC: wm8994: Handle LRCLK inversion for WM8958 and WM1811A
      ASoC: arizona: Provide simple DAI ops for autoconfiguring interfaces
      ASoC: wm5102: Stub hookup for Slimbus interface
      ASoC: wm5110: Stub hookup for Slimbus interface
      Merge tag 'v3.10-rc2' into asoc-ux500
      mfd: wm5110: Make DSPn_STATUS_3 readable
      Merge tag 'mfd-arizona-v3.10-rc2' of git://git.kernel.org/.../broonie=
/misc into asoc-arizona
      ASoC: wm8994: Remove restore of DAC enable state
      ASoC: wm8994: Ensure lambda is zeroed for WM8994
      ASoC: wm8994: Defer declaration of open circuit microphones
      ASoC: wm8994: Add digital loopback paths
      ASoC: wm8994: Remove unused variable
      ASoC: wm8994: Allow debounce before MICDET identification
      ASoC: sgtl5000: Make device cache only when powered off
      ASoC: max98090: Guard runtime PM callbacks
      Merge branch 'topic/fsl' of git://git.kernel.org/.../broonie/sound in=
to asoc-sgtl5000
      ASoC: wm8962: Restore device state after reset in runtime resume
      Merge branch 'fix/wm8962' of git://git.kernel.org/.../broonie/sound i=
nto asoc-wm8962
      ASoC: SPEAr: Add dependency on dmaengine helpers
      ASoC: SPEAr: Hide component drivers in Kconfig
      ASoC: spear: Remove nonexistant EVM options
      ASoC: spear: Normalise module names
      Merge remote-tracking branch 'asoc/fix/adav80x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/88pm860x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adau1701' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/blackfin' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dfmbcs320' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dwc' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ep93xx' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/hdmi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/jz4740' into asoc-next
      Merge remote-tracking branch 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/topic/mxs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5640' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sgtl5000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sn95031' into asoc-next
      Merge remote-tracking branch 'asoc/topic/spdif' into asoc-next
      Merge remote-tracking branch 'asoc/topic/spear' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ssm2518' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm0010' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next
      Merge remote-tracking branch 'asoc/topic/x86' into asoc-next

Micha=C5=82 Miros=C5=82aw (1):
      ASoC: fix kernel message grepability

Nicolin Chen (5):
      ASoC: WM8962: Create default platform data structure
      ASoC: wm8962: Add device tree binding
      ASoC: fsl: add imx-wm8962 machine driver
      ASoC: wm8962: Remove remaining direct register cache accesses
      ASoC: wm8962: Enable start-up and normal bias after reset in runtime =
resume

Paul Bolle (2):
      ASoC: remove saarb and tavorevb3 machine drivers
      ASoC: OMAP: Remove obsolete Makefile line

Rajeev Kumar (3):
      ASoC: dwc: debug message correction.
      ASoC: dwc: Folder path correction in file header.
      ASoC: Add Kconfig and Makefile to support SPEAr audio driver

Sachin Kamat (7):
      ASoC: 88pm860x: Remove redundant platform_set_drvdata()
      ASoC: ep93xx: Remove redundant platform_set_drvdata()
      ASoC: jz4740: Remove redundant platform_set_drvdata()
      ASoC: omap-mcbsp: Remove redundant platform_set_drvdata()
      ASoC: Samsung: Remove redundant platform_set_drvdata()
      ASoC: mid-x86: Remove redundant platform_set_drvdata()
      ASoC: davinci: Remove redundant use of of_match_ptr macro

Sekhar Nori (1):
      ASoC: davinci: remove sffsdr machine support

Shawn Guo (6):
      ASoC: mxs: move to use generic DMA helper
      ASoC: fsl: remove use of imx-pcm-audio from fsl_ssi
      ASoC: fsl: remove use of imx-pcm-audio from imx-ssi
      ASoC: fsl: create function imx_pcm_fiq_exit()
      ASoC: fsl: remove use of imx-fiq-pcm-audio from imx-ssi
      ASoC: fsl: remove imx-pcm driver

Stephen Warren (7):
      ASoC: tegra: always use clk_get() in utility code
      ASoC: tegra: implement suspend/resume for Tegra30 AHUB
      ASoC: tegra: implement suspend/resume for Tegra30 I2S
      ASoC: tegra: add runtime PM to resume functions
      ASoC: rt5640: add device tree support
      ASoC: tegra: add tegra+RT5640 machine driver
      ASoC: rt5640: fix sparse warnings

Tushar Behera (1):
      ASoC: spear: Convert to use devm_ioremap_resource

Uwe Kleine-K=C3=B6nig (3):
      ASoC: SPEAr spdif_{in,out}: use devm for clk and a few more cleanups
      ASoC: simplify registration of snd-soc-dummy device
      ASoC: SPEAr spdif_{in,out}: fix fallout of previous cleanup

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
 sound/soc/codecs/{dfbmcs320.c =3D> bt-sco.c}         |   37 +-
 sound/soc/codecs/{omap-hdmi.c =3D> hdmi.c}           |   26 +-
 sound/soc/codecs/jz4740.c                          |    2 -
 sound/soc/codecs/max98090.c                        |   24 +-
 sound/soc/codecs/rt5640.c                          | 2128 ++++++++++++++++=
++++
 sound/soc/codecs/rt5640.h                          | 2092 ++++++++++++++++=
+++
 sound/soc/codecs/sgtl5000.c                        |  267 ++-
 sound/soc/codecs/sgtl5000.h                        |    2 +-
 sound/soc/codecs/sn95031.c                         |    2 +-
 sound/soc/codecs/spdif_receiver.c                  |   10 +
 .../{spdif_transciever.c =3D> spdif_transmitter.c}   |   10 +
 sound/soc/codecs/ssm2518.c                         |  856 ++++++++
 sound/soc/codecs/ssm2518.h                         |   20 +
 sound/soc/codecs/wm0010.c                          |   10 +
 sound/soc/codecs/wm5102.c                          |  205 +-
 sound/soc/codecs/wm5110.c                          |  192 ++
 sound/soc/codecs/wm8962.c                          |  143 +-
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
 sound/soc/fsl/imx-sgtl5000.c                       |   39 +-
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
 sound/soc/mxs/mxs-saif.c                           |   37 +-
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
 sound/soc/samsung/neo1973_wm8753.c                 |    2 +-
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
 157 files changed, 8786 insertions(+), 3053 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1701.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm896=
2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-au=
dio-rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitt=
er.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ssm2518.txt
 create mode 100644 include/linux/platform_data/ssm2518.h
 create mode 100644 include/sound/rt5640.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm.h
 rename sound/soc/codecs/{dfbmcs320.c =3D> bt-sco.c} (53%)
 rename sound/soc/codecs/{omap-hdmi.c =3D> hdmi.c} (69%)
 create mode 100644 sound/soc/codecs/rt5640.c
 create mode 100644 sound/soc/codecs/rt5640.h
 rename sound/soc/codecs/{spdif_transciever.c =3D> spdif_transmitter.c} (88=
%)
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

--oIK88BWnNPSddvdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxHR6AAoJELSic+t+oim9Ek0P/3uePS65qvfgKhSmscsS40xs
J9HOdUHlKucHDHPDq9Q9tPhH8O1YFxPNGIpFWn8BfjEsg2E979la+GBBfJAAYEEb
q1mtzM16MtnnfbuZFmyST8Qa9KV/3dkgrK6PMRwQUAiDHVQQOire8XfEE67DncGg
/vkUihCDhrRQr8sJ/cIkB3IXyZfJ5CiZQmjuAj9vSybq9+fZwLr8Ezih54lkdiyQ
ktWCzNhjdQvXlxFBHRAffWEoDBMg4sH8km1KiHTCfbzilHPV2n3pTZKN48z0QBQq
ysgWFpVlAn6HYK9Hu/XNHQ2xlUZ1Yw/HVc6DjreQFZmSxDYgQZsIog7Uw0yc3IMQ
css79EqFEkBiASu9hlAop8VMuozNXlL55Q5O0f9Prvzch/FCFul0VpYhe2wGGMTN
ZQLisrSOO1/TGD0fJ2dx106u0xEP74VYyWW7OnUb+U7VrGUxHHo59aadABfLcPdB
/d7fVkMl4vC8mNQI+35QPhV2B17mY7QpSEMlbeJg0PqKs7ZobTvSP88IkGW+INSp
1FnBgIxAGMWBEm8FhCMKZb69R5votkA3V56R9R75nF+CJ3GlbjQgUQdO38N/mIHB
tq5ieH2T/d0gXITpMiuJJPY0P2jY4ZUfiKAtQNWENTcrdjt4HPUYuRWt8chAYIDQ
v7WH2nNURntyD2tRIo62
=tsmG
-----END PGP SIGNATURE-----

--oIK88BWnNPSddvdK--

--===============8734592311635367478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8734592311635367478==--
