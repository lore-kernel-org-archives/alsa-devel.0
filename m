From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.18
Date: Mon, 6 Oct 2014 12:51:05 +0100
Message-ID: <20141006115105.GL4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4765190599662647082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAC422604A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 13:51:20 +0200 (CEST)
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


--===============4765190599662647082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S6vg04ofUPzW4qJg"
Content-Disposition: inline


--S6vg04ofUPzW4qJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9:

  Linux 3.17 (2014-10-05 12:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.18

for you to fetch changes up to a5448c88b812390a3622e76d774e10c0da1fb970:

  Merge remote-tracking branches 'asoc/topic/txx9', 'asoc/topic/wm8978' and 'asoc/topic/wm8994' into asoc-next (2014-10-06 12:49:09 +0100)

----------------------------------------------------------------
ASoC: Updates for v3.18

 - More componentisation work from Lars-Peter, this time mainly
   cleaning up the suspend and bias level transition callbacks.
 - Real system support for the Intel drivers and a bunch of fixes and
   enhancements for the associated CODEC drivers, this is going to need
   a lot quirks over time due to the lack of any firmware description of
   the boards.
 - Jack detect support for simple card from Dylan Reid.
 - A bunch of small fixes and enhancements for the Freescale drivers.
 - New drivers for Analog Devices SSM4567, Cirrus Logic CS35L32, Everest
   Semiconductor ES8328 and Freescale cards using the ASRC in newer i.MX
   processors.

----------------------------------------------------------------
Anatol Pomozov (6):
      ASoC: rt5677: Add a configuration option for LDO2_POW pin
      ASoC: trace: Remove trailing new-lines in trace messages
      ASoC: rt5677: Add gpio-controller DTS documentation
      ASoC: ssm4567: Add driver for Analog Devices SSM4567 amplifier
      ASoC: rt5677: Add dts properties for input/output differential configuration
      ASoC: ssm4567: Remove duplicated else-if branch

Arnd Bergmann (2):
      ASoC: simple-card: fix regression in clock rate lookup
      ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC is

Axel Lin (4):
      ASoC: cs35l32: Remove unneeded regulator_bulk_free call in cs35l32_i2c_remove
      ASoC: cs42l56: Remove unneeded regulator_bulk_free call in cs42l56_remove
      ASoC: cs35l32: Simplify implementation of cs35l32_codec_set_sysclk
      ASoC: Remove return value checking for gpiochip_remove()

Bard Liao (2):
      ASoC: rt5677: Add DMIC2 clock selection
      ASoC: rt286: Add depends on I2C

Brian Austin (6):
      ASoC: cs35l32: Add support for CS35L32 Boosted Amplifier
      ASoC: cs35l32: Add bindings for CS35L32
      ASoC: cs35l32: fix compile warning for i2c_probe
      ASoC: cs35l32: use true/false returns for bool functions
      ASoC: cs42l52: use true/false returns for bool functions
      ASoC: cs42l56: use true/false returns for bool functions

Dan Murphy (1):
      ASoC: tas2552: Add DAPM calls for amp and PLL

Dmitry Lavnikevich (1):
      ASoC: tlv320aic3x: fix PLL D configuration

Dylan Reid (3):
      ASoC: simple-card: Add mic and hp detect gpios.
      ASoC: tegra: add mic detect gpio to tegra_max98090
      ASoC: simple-card: Fix detect gpio documentation.

Fabian Frederick (1):
      ASoC: cs35l32: remove second linux/slab.h inclusion

Fabio Estevam (6):
      ASoC: fsl_ssi: Remove unneeded 'i2s-slave' property
      ASoC: fsl ssi doc: Remove unused properties
      ASoC: fsl: Do not force codecs selection by SND_SOC_FSL_ASOC_CARD
      ASoC: sgtl5000: Improve the error message on slave mode setting
      ASoC: sgtl5000: Do a sanity check on SYS_MCLK
      ASoC: fsl_esai doc: Add "fsl,vf610-esai" as compatible string

Fabio Falzoi (1):
      ASoC: fsl-ssi: Support for SND_SOC_DAIFMT_CBM_CFS

Fengguang Wu (1):
      ASoC: Intel: byt-rt5640: fix coccinelle warnings

Geert Uytterhoeven (2):
      regmap: Split regmap_get_endian() in two functions
      ASoC: Allow SND_SOC_WM8978 to be selected manually

Howard Mitchell (1):
      ASoC: core: Fix volsw_range funcs so SOC_DOUBLE_R_RANGE_TLV works.

Jarkko Nikula (16):
      ASoC: Remove unused cache_only from struct snd_soc_codec
      ASoC: max98090: Add recovery for PLL lock failure
      ASoC: max98090: Move interrupt request from codec probe to i2c probe
      ASoC: max98090: Remove structure member irq from private data
      ASoC: max98090: Remove structure member extmic_mux from private data
      ASoC: max98090: Remove unused version define
      ASoC: max98090: Remove unused byte access macros
      ASoC: max98090: Enable both DMIC channels also when using mono configuration
      ASoC: Intel: byt-max98090: Set card as fully routed
      ASoC: Intel: byt-rt5640: Remove IN2N pin from DAPM route table
      ASoC: Intel: byt-rt5640: Add quirk for Asus T100
      ASoC: rt5640: Add function for enabling DMIC from ACPI probed machine
      ASoC: Intel: byt-rt5640: Enable DMIC interface for default DAPM route
      ASoC: Intel: byt-rt5640: Add quirk for Dell Venue 8 Pro tablet
      ASoC: Intel: byt-rt5640: Set card as fully routed
      ASoC: dapm: Fix NULL pointer dereference when registering card with widgets

Javier Martinez Canillas (1):
      regmap: Fix DT endianess parsing logic

Jianqun (3):
      ASoC: rockchip-i2s: enable "hclk" for rockchip I2S controller
      ASoC: rockchip-i2s: fix rockchip i2s defination more reasonable
      ASoC: rockchip-i2s: add dma data to snd_soc_dai

Julia Lawall (1):
      ASoC: rsnd: delete unneeded test before of_node_put

Jyri Sarha (1):
      ASoC: tlv320aic31xx: Choose PLL p divider automatically

Kuninori Morimoto (7):
      ASoC: simple-card: use asoc_simple_xxx prefix
      ASoC: simple-card: remove dai_link->cpu_dai_name when DT
      ASoC: simple-card: dai_link->init should be cared when multi DAI
      ASoC: simple-card: use common for_each_child_of_node() for loop
      ASoC: simple-card: fixup cpu_dai_name clear case
      ASoC: simple-card: tidyup use priv in parameter
      ASoC: simple-card: tidyup get dai_link/dai_props from priv

Lars-Peter Clausen (59):
      ASoC: dmic: Add to SND_SOC_ALL_CODECS
      ASoC: edma-pcm: Include edma-pcm.h
      ASoC: odrodix2_max98090: Make non exported symbols static
      ASoC: sh: Fix dma direction type
      ASoC: samsung idma: Add proper annotation for casting iomem pointers
      ASoC: ab8500-codec: Drop bank prefix from AB8500_GPIO_DIR4_REG register define
      ASoC: Move debugfs registration to the component level
      ASoC: Consolidate platform and CODEC probe/remove
      ASoC: Make rtd->codec optional
      ASoC: Add component level probe/remove support
      ASoC: Move AUX dev support to the component level
      ASoC: Pass component instead of DAPM context to AUX dev init callback
      ASoC: Move component->probed check into soc_{remove,probe}_component()
      ASoC: Cleanup DAI module reference counting
      ASoC: Consolidate CPU and CODEC DAI removal
      ASoC: Consolidate CPU and CODEC DAI lookup
      ASoC: Automatically initialize regmap for all components
      ASoC: Remove support for legacy snd_soc_platform IO
      ASoC: Replace list_empty(&card->codec_dev_list) with !card->instantiated
      ASoC: sh: Don't opencode DMAengine API calls
      ASoC: txx9: Don't opencode DMAengine API calls
      ASoC: ac97-codec: Remove ASoC level IO support
      ASoC: Restore idle_bias_off initialization
      ASoC: ab8500-codec: Revert back to regmap
      ASoC: adau1373: Remove unnecessary suspend/resume bias level changes
      ASoC: lm49453: Remove unnecessary suspend/resume bias level changes
      ASoC: tlv320aic3x: Remove unnecessary suspend/resume bias level changes
      ASoC: wm8804: Remove unnecessary suspend/resume bias level changes
      ASoC: wm8995: Remove unnecessary suspend/resume bias level changes
      ASoC: Set card->instantiated to false when removing the card
      ASoC: Shutdown DAPM contexts when removing a card
      ASoC: Add support for automatically going to BIAS_OFF on suspend
      ASoC: Always run default suspend/resume code
      ASoC: adau1373: Cleanup manual bias level transitions
      ASoC: adau17x1: Cleanup manual bias level transitions
      ASoC: adav80x: Cleanup manual bias level transitions
      ASoC: ssm2518: Cleanup manual bias level transitions
      ASoC: ssm2602: Cleanup manual bias level transitions
      ASoC: 88pm860x-codec: Cleanup manual bias level transitions
      ASoC: jz4740: Cleanup manual bias level transitions
      ASoC: ml26124: Cleanup manual bias level transitions
      ASoC: sgtl5000: Cleanup bias level transitions
      ASoC: es8328: Cleanup manual bias level transitions
      ASoC: Add snd_soc_component_{get,set}_drvdata()
      ASoC: sst-haswell-pcm: Alloc state struct in driver probe()
      ASoC: sst-haswell-pcm: Move controls and DAPM elements to component
      ASoC: Remove table based DAPM/control setup support from snd_soc_platform_driver
      ASoC: cs42l52: Cleanup manual bias level transitions
      ASoC: cs42l56: Cleanup manual bias level transitions
      ASoC: cs42l73: Cleanup manual bias level transitions
      ASoC: da732x: Remove unnecessary idle_bias_off initialization
      ASoC: da732x: Remove unused codec field form da732x_priv struct
      ASoC: da732x: Cleanup manual bias level transitions
      ASoC: Remove locking in snd_soc_{new,free}_ac97_codec()
      ASoC: Fix snd_soc_{new,free}_ac97_codec() locking removal
      ASoC: wm8741: Remove unused wm8741_suspend define
      ASoC: wm8{350,753,971}: Use snd_soc_dapm_to_codec() instead of dapm->codec
      ASoC: rx51: Use snd_soc_dapm_to_codec() instead of dapm->codec
      ASoC: Remove CODEC pointer from snd_soc_dapm_context

Mark Brown (31):
      Merge branch 'topic/es8328' of git://git.kernel.org/.../broonie/sound into asoc-fsl
      Merge branch 'fix/fsl-esai' of git://git.kernel.org/.../broonie/sound into asoc-fsl-esai
      Merge tag 'dt-endian' of git://git.kernel.org/.../broonie/regmap into asoc-fsl
      Merge branch 'topic/fsl' of git://git.kernel.org/.../broonie/sound into asoc-fsl-esai
      Merge branch 'topic/fsl' of git://git.kernel.org/.../broonie/sound into asoc-fsl-sai
      Merge branch 'fix/tlv320aic31xx' of git://git.kernel.org/.../broonie/sound into asoc-tlv320aic31xx
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/sound into asoc-suspend
      Merge branch 'topic/suspend' of git://git.kernel.org/.../broonie/sound into asoc-es8328
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge branch 'topic/cs42l56' of git://git.kernel.org/.../broonie/sound into asoc-suspend
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/max98090', 'asoc/fix/samsung' and 'asoc/fix/tlv320aic31xx' into asoc-linus
      Merge branch 'fix/max98090' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge branch 'topic/rt5640' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge tag 'v3.17-rc4' into asoc-simple
      Merge tag 'asoc-v3.17-rc4' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/davinci' and 'asoc/fix/max98090' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl-esai' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ab8500', 'asoc/topic/ac97' and 'asoc/topic/cs35l32' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs4265', 'asoc/topic/cs42l52', 'asoc/topic/cs42l56' and 'asoc/topic/da732x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/dmic', 'asoc/topic/drivers', 'asoc/topic/es8328' and 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-easi', 'asoc/topic/fsl-sai', 'asoc/topic/fsl-ssi' and 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98090', 'asoc/topic/rockchip', 'asoc/topic/rsnd' and 'asoc/topic/rt286' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/rt5677', 'asoc/topic/samsung', 'asoc/topic/sgtl5000' and 'asoc/topic/sh' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple', 'asoc/topic/sirf', 'asoc/topic/spdif', 'asoc/topic/ssm2602' and 'asoc/topic/ssm4567' into asoc-next
      Merge remote-tracking branches 'asoc/topic/suspend', 'asoc/topic/tas2552', 'asoc/topic/tegra', 'asoc/topic/tlv320aic31xx' and 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/txx9', 'asoc/topic/wm8978' and 'asoc/topic/wm8994' into asoc-next

Masanari Iida (1):
      ASoC: da732x: Remove unnecessary KERN_ERR in pr_err()

Nicolin Chen (6):
      ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support
      ASoC: fsl_sai: Initialize with software reset
      ASoC: fsl_sai: Set SYNC bit of TCR2 to Asynchronous Mode
      ASoC: fsl_sai: Add asynchronous mode support
      ASoC: fsl_sai: Make Synchronous and Asynchronous modes exclusive
      ASoC: fsl_sai: Set SYNC bit of TCR2 to Asynchronous Mode

Nikesh Oswal (1):
      ASoC: wm8994: Demux the microphone detection IRQ

Oder Chiou (5):
      ASoC: rt5677: Revise the wrong name in the header file
      ASoC: rt5677: Add the GPIO function
      ASoC: rt5677: Add the TDM function
      ASoC: rt5677: Add sidetone function
      ASoC: rt5645: Add headset detect function

Paul Handrigan (1):
      ASoC: cs4265: Add CHIP_ID as a readable register

Peter Ujfalusi (4):
      ASoC: tlv320aic31xx: Correct interface register 2 variable name
      ASoC: tlv320aic31xx: Enable support for S24_LE format
      ASoC: davinci-mcasp: Convert the context save/restore to use array
      ASoC: davinvi-mcasp: Proper suspend/resume support while audio is active

Rongjun Ying (1):
      ASoC: sirf: usp: Add bitclock inversion support

Sean Cross (4):
      devicetree: bindings: Add Everest Semicodunctor
      ASoC: add es8328 codec driver
      ASoC: fsl: add imx-es8328 machine driver
      ASoC: fsl: Fix building of imx-es8328 on PPC

Shengjiu Wang (6):
      ASoC: fsl_esai: refine esai for TDM support
      ASoC: fsl_esai: refine esai for TDM support
      ASoC: fsl-asoc-card: Fix build warning for maybe-uninitialized
      ASoC: fsl: fsl-asoc-card: Select SND_SOC_IMX_AUDMUX
      ASoC: fsl-asoc-card: move 'config SND_SOC_FSL_ASOC_CARD' to 'if SND_IMX_SOC'
      ASoC: fsl_ssi: refine ipg clock usage in this module

Stefan Kristiansson (2):
      ASoC: ssm2602: add device tree bindings
      ASoC: ssm2602: add support for 11.025kHz and 22.5kHz sample rates

Stephen Warren (1):
      regmap: of_regmap_get_endian() cleanup

Subhransu S. Prusty (6):
      ASoC: Intel: mfld-pcm: Use function instead of ioctl
      ASoC: Intel: mfld-pcm: Change sst_ops prototypes to take dev parameter
      ASoC: mfld-compress: Use dedicated function instead of ioctl
      ASoC: mfld: pcm: Replace pr_ with dev_
      ASoC: Intel: mrfld: Use snd_soc_dai_get_drvdata to derive drv data
      ASoC: Export dapm_kcontrol_get_value

Sylwester Nawrocki (1):
      ASoC: Drop const from struct snd_soc_dai_link *of_node members

Thierry Reding (2):
      ASoC: tas2552: Fix compilation warning for !PM_RUNTIME
      ASoC: rt286: Fix compilation warning for !PM

Tomeu Vizoso (1):
      ASoC: fsl_spdif: Remove unused includes of linux/clk-private.h

Vinod Koul (5):
      ASoC: Intel: Fix to use byte control interface
      ASoC: Intel: add mrfld DSP defines
      ASoC: Intel: mfld-pcm: don't call trigger ops to DSP for internal streams
      ASoC: Intel: mrfld: add bytes control for modules
      ASoC: Intel: mfld-pcm: add control for powering up/down dsp

Wei Yongjun (1):
      ASoC: es8328: fix error return code in es8328_codec_probe()

Xiubo Li (10):
      regmap: add DT endianness binding support.
      regmap: Add the DT binding documentation for endianness
      ASoC: simple-card: Fix the compile warning.
      ASoC: fsl-asrc: Convert to use regmap framework's endianness method.
      ASoC: fsl-esai: Convert to use regmap framework's endianness method.
      ASoC: fsl-spdif: Convert to use regmap framework's endianness method.
      ASoC: fsl-sai: Convert to use regmap framework's endianness method.
      ASoC: fsl-sai: using 'lsb-first' property instead of 'big-endian-data'.
      ASoC: simple-card: Merge single and muti DAI link(s) code.
      ASoC: simple-card: Adjust the comments of simple card.

 .../devicetree/bindings/regmap/regmap.txt          |  47 ++
 .../devicetree/bindings/sound/adi,ssm2602.txt      |  19 +
 .../devicetree/bindings/sound/cs35l32.txt          |  62 ++
 Documentation/devicetree/bindings/sound/es8328.txt |  38 ++
 .../devicetree/bindings/sound/fsl,esai.txt         |   3 +-
 .../devicetree/bindings/sound/fsl,ssi.txt          |   8 +-
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  82 +++
 .../devicetree/bindings/sound/fsl-sai.txt          |  30 +-
 .../devicetree/bindings/sound/imx-audio-es8328.txt |  60 ++
 .../bindings/sound/nvidia,tegra-audio-max98090.txt |   1 +
 Documentation/devicetree/bindings/sound/rt5677.txt |  59 ++
 .../devicetree/bindings/sound/simple-card.txt      |   4 +
 .../devicetree/bindings/sound/ssm4567.txt          |  15 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/base/regmap/regmap-i2c.c                   |   2 +
 drivers/base/regmap/regmap-spi.c                   |   2 +
 drivers/base/regmap/regmap.c                       |  74 +-
 include/dt-bindings/sound/cs35l32.h                |  26 +
 include/sound/rt5645.h                             |   3 +
 include/sound/rt5677.h                             |  13 +-
 include/sound/soc-dapm.h                           |   5 +-
 include/sound/soc.h                                | 101 +--
 include/trace/events/asoc.h                        |   6 +-
 sound/soc/codecs/88pm860x-codec.c                  |   3 -
 sound/soc/codecs/Kconfig                           |  36 +-
 sound/soc/codecs/Makefile                          |  10 +
 sound/soc/codecs/ab8500-codec.c                    |  73 +-
 sound/soc/codecs/ac97.c                            |  15 -
 sound/soc/codecs/adau1373.c                        |  21 -
 sound/soc/codecs/adau1761.c                        |   2 +-
 sound/soc/codecs/adau1781.c                        |   2 +-
 sound/soc/codecs/adau17x1.c                        |   8 -
 sound/soc/codecs/adau17x1.h                        |   1 -
 sound/soc/codecs/adav80x.c                         |  23 +-
 sound/soc/codecs/cs35l32.c                         | 631 +++++++++++++++++
 sound/soc/codecs/cs35l32.h                         |  93 +++
 sound/soc/codecs/cs4265.c                          |   1 +
 sound/soc/codecs/cs42l52.c                         |  24 +-
 sound/soc/codecs/cs42l56.c                         |  27 +-
 sound/soc/codecs/cs42l73.c                         |  25 +-
 sound/soc/codecs/da732x.c                          |  27 +-
 sound/soc/codecs/es8328-i2c.c                      |  60 ++
 sound/soc/codecs/es8328-spi.c                      |  49 ++
 sound/soc/codecs/es8328.c                          | 756 +++++++++++++++++++++
 sound/soc/codecs/es8328.h                          | 314 +++++++++
 sound/soc/codecs/jz4740.c                          |  30 +-
 sound/soc/codecs/lm49453.c                         |  14 -
 sound/soc/codecs/max98090.c                        | 146 +++-
 sound/soc/codecs/max98090.h                        |  13 +-
 sound/soc/codecs/ml26124.c                         |  24 +-
 sound/soc/codecs/rt286.c                           |   2 +
 sound/soc/codecs/rt5640.c                          |  49 +-
 sound/soc/codecs/rt5640.h                          |   3 +
 sound/soc/codecs/rt5645.c                          |  99 +++
 sound/soc/codecs/rt5645.h                          |   5 +
 sound/soc/codecs/rt5677.c                          | 327 ++++++++-
 sound/soc/codecs/rt5677.h                          | 171 ++++-
 sound/soc/codecs/sgtl5000.c                        |  42 +-
 sound/soc/codecs/ssm2518.c                         |  13 -
 sound/soc/codecs/ssm2602-i2c.c                     |   9 +
 sound/soc/codecs/ssm2602-spi.c                     |   7 +
 sound/soc/codecs/ssm2602.c                         |  39 +-
 sound/soc/codecs/ssm4567.c                         | 343 ++++++++++
 sound/soc/codecs/tas2552.c                         |  70 +-
 sound/soc/codecs/tlv320aic31xx.c                   | 107 ++-
 sound/soc/codecs/tlv320aic31xx.h                   |   3 +-
 sound/soc/codecs/tlv320aic3x.c                     |  29 +-
 sound/soc/codecs/wm5100.c                          |   5 +-
 sound/soc/codecs/wm8350.c                          |   2 +-
 sound/soc/codecs/wm8741.c                          |   1 -
 sound/soc/codecs/wm8753.c                          |   2 +-
 sound/soc/codecs/wm8804.c                          |  19 -
 sound/soc/codecs/wm8903.c                          |   6 +-
 sound/soc/codecs/wm8962.c                          |   5 +-
 sound/soc/codecs/wm8971.c                          |   2 +-
 sound/soc/codecs/wm8994.c                          |  18 +-
 sound/soc/codecs/wm8995.c                          |  19 -
 sound/soc/codecs/wm8996.c                          |   6 +-
 sound/soc/davinci/Kconfig                          |   3 +-
 sound/soc/davinci/davinci-mcasp.c                  |  79 ++-
 sound/soc/davinci/edma-pcm.c                       |   2 +
 sound/soc/fsl/Kconfig                              |  26 +
 sound/soc/fsl/Makefile                             |   4 +
 sound/soc/fsl/fsl-asoc-card.c                      | 574 ++++++++++++++++
 sound/soc/fsl/fsl_asrc.c                           |   6 +-
 sound/soc/fsl/fsl_esai.c                           |  19 +-
 sound/soc/fsl/fsl_esai.h                           |   8 +-
 sound/soc/fsl/fsl_sai.c                            |  58 +-
 sound/soc/fsl/fsl_sai.h                            |   8 +-
 sound/soc/fsl/fsl_spdif.c                          |   6 +-
 sound/soc/fsl/fsl_ssi.c                            |  89 ++-
 sound/soc/fsl/imx-es8328.c                         | 232 +++++++
 sound/soc/generic/simple-card.c                    | 226 ++++--
 sound/soc/intel/Makefile                           |   3 +-
 sound/soc/intel/byt-max98090.c                     |   1 +
 sound/soc/intel/byt-rt5640.c                       |  83 ++-
 sound/soc/intel/sst-atom-controls.c                | 218 ++++++
 sound/soc/intel/sst-atom-controls.h                | 416 +++++++++++-
 sound/soc/intel/sst-haswell-pcm.c                  |  56 +-
 sound/soc/intel/sst-mfld-platform-compress.c       |  38 +-
 sound/soc/intel/sst-mfld-platform-pcm.c            | 106 +--
 sound/soc/intel/sst-mfld-platform.h                |  58 +-
 sound/soc/omap/rx51.c                              |   2 +-
 sound/soc/rockchip/Kconfig                         |   3 +-
 sound/soc/rockchip/Makefile                        |   2 +-
 sound/soc/rockchip/rockchip_i2s.c                  |  28 +-
 sound/soc/samsung/idma.c                           |   4 +-
 sound/soc/samsung/odroidx2_max98090.c              |   4 +-
 sound/soc/samsung/speyside.c                       |   6 +-
 sound/soc/sh/fsi.c                                 |   7 +-
 sound/soc/sh/rcar/core.c                           |   6 +-
 sound/soc/sh/siu_pcm.c                             |   4 +-
 sound/soc/sirf/sirf-usp.c                          |  24 +-
 sound/soc/soc-core.c                               | 669 ++++++++----------
 sound/soc/soc-dapm.c                               |  26 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   4 +-
 sound/soc/soc-io.c                                 |  28 -
 sound/soc/tegra/tegra_max98090.c                   |  40 ++
 sound/soc/txx9/txx9aclc.c                          |  14 +-
 119 files changed, 6323 insertions(+), 1359 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regmap/regmap.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l32.txt
 create mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ssm4567.txt
 create mode 100644 include/dt-bindings/sound/cs35l32.h
 create mode 100644 sound/soc/codecs/cs35l32.c
 create mode 100644 sound/soc/codecs/cs35l32.h
 create mode 100644 sound/soc/codecs/es8328-i2c.c
 create mode 100644 sound/soc/codecs/es8328-spi.c
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h
 create mode 100644 sound/soc/codecs/ssm4567.c
 create mode 100644 sound/soc/fsl/fsl-asoc-card.c
 create mode 100644 sound/soc/fsl/imx-es8328.c
 create mode 100644 sound/soc/intel/sst-atom-controls.c

--S6vg04ofUPzW4qJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUMoIoAAoJECTWi3JdVIfQTbkH/1jB0zMzvyBYivWqKns8ILde
B9wi2TJr5XQJfU/+5g/v5ve7nldsgCEHVDFM55BIWRJJ4yTMtW8852hR6CYLUb1Z
BH3tpFV6JncM4icsvFWMas04OZjwiKmu1Whq5uVJ3vDUZV1DIMMsvZWDvOyZLBHE
HughZmjnWf2CN39wRaxgiUxrFs5pRfyHS8SEqxF7kQn2xRj1h79oYj1dEh69u3yk
Uiu2jktbXKPxu4lEdxfSs7XdEF0wrNLSjiFxpBbon1ul9pfgmt5bQFfjkxoOdKBx
D/NRf+162FN/f8P1VZdVFkBQu0jVzMoG0Qi08dtiNnR0cfoSZvZ2HAPbfY4+tTs=
=aMP0
-----END PGP SIGNATURE-----

--S6vg04ofUPzW4qJg--

--===============4765190599662647082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4765190599662647082==--
