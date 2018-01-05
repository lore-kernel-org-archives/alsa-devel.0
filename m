From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.16
Date: Fri, 5 Jan 2018 17:21:35 +0000
Message-ID: <20180105172135.GG9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5188175401375326387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CFE6266DE0
 for <alsa-devel@Alsa-project.org>; Fri,  5 Jan 2018 18:21:37 +0100 (CET)
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
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5188175401375326387==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.16

for you to fetch changes up to b762408d596c9c6861bf9b0d7208a63b1a4b4b8d:

  Merge remote-tracking branches 'asoc/topic/wm8997' and 'asoc/topic/wm8998' into asoc-next (2018-01-05 12:44:23 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.16

Quite a big update here, mostly in new device support and some big
updates for older drivers too.  The main core work continues to be
Morimoto-san's efforts on modernising drivers to use the component
layer.

 - Lots more updates from Morimoto-san to move more things into the
   component level.
 - Large cleanups of some of the TI CODEC drivers from Andrew F. Davis.
 - Even more quirks and cleanups of quirks for x86 systems.
 - Refactoring of the Freescale SSI driver from Nicolin Chen in
   preparation for some more substantive improvements which are
   currently in review.
 - New drivers for Allwinner A83T, Maxim MAX89373, SocioNext UiniPhier
   EVEA Tempo Semiconductor TSCS42xx and TI PCM816x, TAS5722 and TAS6424
   devices.

----------------------------------------------------------------
Akshu Agrawal (1):
      ASoC: AMD: Make the driver name consistent across files

Andrea Bondavalli (1):
      ASoC: sun4i-codec: enable 12Khz and 24Khz audio sample rates

Andreas Dannenberg (4):
      ASoC: tas6424: Add support for TAS6424 digital amplifier
      ASoC: pcm186x: Add initial PCM1862/63/64/65 universal ADC driver
      ASoC: tas5720: add basic support for TAS5722 devices
      ASoC: tas5720: add TAS5722 register support

Andrew F. Davis (27):
      ASoC: tlv320aic31xx: Rename property for reset GPIO
      ASoC: tlv320aic31xx: Use standard reset GPIO OF name
      ASoC: tlv320aic3x: Rename property for reset GPIO
      ASoC: tlv320aic3x: Use standard reset GPIO OF name
      ASoC: tlv320aic31xx: File header and copyright cleanup
      ASoC: tlv320aic31xx: Change aic31xx_power_off return type to void
      ASoC: tlv320aic31xx: Move ACPI table next to OF table
      ASoC: tlv320aic31xx: General source formatting cleanup
      ASoC: tlv320aic31xx: Reformat header file using GENMASK and BIT macros
      ASoC: tlv320aic31xx: Merge init function into probe
      ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API
      ASoC: tlv320aic31xx: Check clock and divider before division
      ASoC: tlv320aic31xx: Add CODEC clock slave support
      ASoC: tlv320aic31xx: Handle inverted BCLK in non-DSP modes
      ASoC: pcm186x: Add PCM186x binding documentation
      ASoC: tlv320aic31xx: Fix GPIO header includes
      ASoC: tlv320aic31xx: Use fwnode APIs over raw OF calls
      ASoC: tlv320aic31xx: Reset registers during power up
      ASoC: tlv320aic32x4: Use AIC32X4_REG macro for all register definitions
      ASoC: tlv320aic32x4: Drop define mapping from number to number
      ASoC: tlv320aic32x4: Use correct shift definition for DATATYPE bits
      ASoC: tlv320aic32x4: Use correct shift definition for DATALEN bits
      ASoC: tlv320aic32x4: Use BIT and GENMASK for bit field definitions
      ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_mute()
      ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_hw_params()
      ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_set_dai_fmt()
      ASoC: tlv320aic32x4: Make driver selectable in Kconfig

Arnd Bergmann (1):
      ASoC: intel: initialize return value properly

Arvind Yadav (5):
      ASoC: ep93xx-ac97: Fix platform_get_irq's error checking
      ASoC: mt8173: Fix platform_get_irq's error checking
      ASoC: nuc900: Fix platform_get_irq's error checking
      ASoC: intel: sst: Handle return value of platform_get_irq
      ASoC: intel: mfld: Handle return value of platform_get_irq

Banajit Goswami (1):
      ASoC: change mask in snd_soc_get/put_volsw_sx to unsigned int

Bard Liao (4):
      ASoC: rl6231: get better PLL parameters
      ASoC: rl6231: remove never matched if condition
      ASoC: rt5645: change micbias widget type to supply.
      ASoC: rt5645: add micbias power control select.

Benson Leung (5):
      ASoC: ts3a227e: Map BTN_0 to KEY_PLAYPAUSE
      ASoC: rk3399_gru_sound: Map BTN_0 to KEY_PLAYPAUSE
      ASoC: qcom: apq8016-sbc: Map BTN_0 to KEY_PLAYPAUSE
      ASoC: Intel: kbl_rt5663_rt5514_max98927: Map BTN_0 to KEY_PLAYPAUSE
      ASoC: Intel: kbl_rt5663_max98927: Map BTN_0 to KEY_PLAYPAUSE

Biju Das (1):
      ASoC: rsnd: Add device tree support for r8a774[35]

Carlo Caione (2):
      ASoC: intel: byt: Introduce new map for dual mics
      ASoC: intel: byt: Fix quirk for KIANO laptop

Chen-Yu Tsai (2):
      ASoC: sun4i-i2s: Add support for A83T
      ASoC: sun4i-i2s: Show detailed error when DAI configuration callbacks fail

Colin Ian King (1):
      ASoC: pcm186x: make pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value static

Dan Carpenter (3):
      ASoC: nuc900: Fix platform_get_irq() error checking some more
      ASoC: nuc900: Fix a loop timeout test
      ASoC: Intel: Skylake: Re-order some code to silence a warning

Fabio Estevam (1):
      ASoC: simple-card: Pass 'reg' property in the examples

Guneshwor Singh (3):
      ASoC: Intel: Skylake: Make local functions static
      ASoC: Intel: Skylake: Fix descriptions for exported function args
      ASoC: hdac_hdmi: Add vendor id for Cannonlake HDMI codec

Hans de Goede (5):
      ASoC: rt5645: Set card long_name for GPD win / pocket
      ASoC: rt5645: set in2_diff flag for GPD win and pocket devices
      ASoC: rt5645: cleanup DMI matching code
      ASoC: rt5645: add platform data for the Teclast X80 Pro tablet
      ASoC: Intel: cht_bsw_rt5645: Analog Mic support

Javier Martinez Canillas (1):
      ASoC: tfa9879: Export OF device ID as module alias

Jesse Chan (1):
      ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jiada Wang (1):
      ASoC: rsnd: ssi: remove unnesessary period_pos

John Hsu (11):
      ASoC: nau8540: reset state machine for channel phase sync
      ASoC: nau8540: PGA short to ground
      ASoC: nau8540: fix the record pop noise
      ASoC: nau8824: move key irq after jd done
      ASoC: nau8824: condition for clock disable
      ASoC: nau8540: improve FLL performance
      ASoC: nau8824: change FVCO maximum threshold
      ASoC: nau8825: disable crosstalk by default
      ASoC: nau8825: set clear_irq when imm IRQ happened
      ASoC: nau8825: improve semaphore control
      ASoC: nau8825: improve crosstalk measurement protection

Katsuhiro Suzuki (4):
      ASoC: spdif: Add S32_LE support for S/PDIF dummy codec drivers
      ASoC: uniphier: add DT bindings documentation for UniPhier EVEA
      ASoC: uniphier: add support for UniPhier EVEA codec
      MAINTAINERS: add entries for UniPhier ASoC sound drivers

Kuninori Morimoto (50):
      ASoC: don't use codec hw_write on uda1380
      ASoC: don't use codec hw_write on tlv320dac33
      ASoC: don't use codec hw_write on cx20442/omap-ams-delta
      ASoC: don't use codec hw_write on twl6040
      ASoC: don't use codec hw_write on max98926
      ASoC: don't use codec hw_write on max98927
      ASoC: use internal reg_cache on uda1380
      ASoC: use internal reg_cache on tlv320dac33
      ASoC: cx20442: don't use reg_cache
      ASoC: don't use snd_soc_write/read on twl6040
      ASoC: don't use snd_soc_write/read on twl4030
      ASoC: add snd_soc_disconnect_sync()
      ASoC: rsnd: call snd_soc_disconnect_sync() when remove
      ASoC: soc-core: add missing EXPORT_SYMBOL_GPL() for snd_soc_disconnect_sync
      ASoC: rsnd: TDM 6ch needs 8ch clock for hw refine
      ASoC: rsnd: dma.c: spin lock is no longer needed in IRQ handler
      ASoC: soc-utils: add const to dummy_codec
      ASoC: use snd_soc_component_init_regmap() on wm8998
      ASoC: use snd_soc_component_init_regmap() on wm8997
      ASoC: use snd_soc_component_init_regmap() on wm8994
      ASoC: use snd_soc_component_init_regmap() on wm8400
      ASoC: use snd_soc_component_init_regmap() on wm8350
      ASoC: use snd_soc_component_init_regmap() on wm5110
      ASoC: use snd_soc_component_init_regmap() on wm5102
      ASoC: use snd_soc_component_init_regmap() on si476x
      ASoC: use snd_soc_component_init_regmap() on mc13783
      ASoC: use snd_soc_component_init_regmap() on cq93vc
      ASoC: use snd_soc_component_init_regmap() on cs47l24
      ASoC: use snd_soc_component_init_regmap() on 88pm860x
      ASoC: use snd_soc_component_init_regmap() on msm8916
      ASoC: use snd_soc_component_init_regmap() on atmel-classd
      ASoC: don't use rtd->codec on soc_dev_attr_is_visible()
      ASoC: don't use rtd->codec on snd_soc_new_compress()
      ASoC: don't use rtd->codec on fsl-asoc-card
      ASoC: don't use rtd->codec on intel/skylake
      ASoC: don't use rtd->codec on Intel/haswell
      ASoC: don't use rtd->codec on qcom/apq8016_sbc
      ASoC: don't use rtd->codec on samsung/bells
      ASoC: rsnd: more clear rsnd_get_dalign() for DALIGN
      ASoC: rsnd: don't use runtime->sample_bits
      ASoC: rsnd: PIO related function cleanup
      ASoC: rsnd: remove unneeded "is_graph" from __rsnd_dai_probe()
      ASoC: soc-core: care Codec <-> Codec case by non_legacy_dai_naming
      ASoC: hdac_hdmi: keep DAI driver pointer in private data
      ASoC: soc-core: remove dai_drv from snd_soc_component
      ASoC: soc.h: Arrange DAI related parameter
      ASoC: wm2200: use snd_soc_codec_get_drvdata()
      ASoC: wm2200: don't use snd_soc_dai::symmetric_rates
      ASoC: soc-dai.h: remove symmetric_xxx from snd_soc_dai
      ASoC: rcar: tidyup simple-card example for CPU node

Maciej S. Szmigiero (5):
      ASoC: fsl_ssi: remove duplicated flag setting in fsl_ssi_setup_reg_vals()
      ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20
      ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt() just once in AC'97 mode
      ASoC: fsl_ssi: only enable proper channel slots in AC'97 mode
      ASoC: fsl_ssi: add 20-bit sample format for AC'97 and use it for capture

Mark Brown (29):
      Merge branch 'topic/disconnect' of https://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge branch 'topic/pcm-20bit' of https://git.kernel.org/.../tiwai/sound into asoc-fsl-ssi
      Merge branch 'fix/tlv320aic31xx' of https://git.kernel.org/.../broonie/sound into asoc-tlv320aic31xx
      Merge branch 'fix/amd' of https://git.kernel.org/.../broonie/sound into asoc-amd
      Merge branch 'fix/rcar' of https://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/mtk' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm186x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/amd', 'asoc/topic/atmel' and 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cq93vc', 'asoc/topic/cs35l32', 'asoc/topic/cs35l34', 'asoc/topic/cs42l52' and 'asoc/topic/cs42l56' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l73', 'asoc/topic/cs47l24', 'asoc/topic/cx20442', 'asoc/topic/da7213' and 'asoc/topic/da7218' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dai-drv', 'asoc/topic/davinci', 'asoc/topic/disconnect', 'asoc/topic/ep93xx' and 'asoc/topic/eukrea-tlv320' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl', 'asoc/topic/fsl-ssi', 'asoc/topic/fsl_asrc' and 'asoc/topic/hdac_hdmi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hisilicon', 'asoc/topic/max98373', 'asoc/topic/max98926' and 'asoc/topic/max98927' into asoc-next
      Merge remote-tracking branches 'asoc/topic/mc13783', 'asoc/topic/msm8916', 'asoc/topic/mt8173', 'asoc/topic/mtk' and 'asoc/topic/nau8540' into asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8824', 'asoc/topic/nau8825' and 'asoc/topic/nuc900' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231', 'asoc/topic/rt5514' and 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/si476x', 'asoc/topic/simple', 'asoc/topic/spdif' and 'asoc/topic/stm32' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sun4i-i2s', 'asoc/topic/sunxi', 'asoc/topic/symmetry', 'asoc/topic/tas5720' and 'asoc/topic/tas6424' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tfa9879', 'asoc/topic/tlv320aic31xx', 'asoc/topic/tlv320aic32x4', 'asoc/topic/tlv320aic3x' and 'asoc/topic/tlv320dac33' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ts3a227e', 'asoc/topic/tsc42xx', 'asoc/topic/twl4030', 'asoc/topic/twl6040' and 'asoc/topic/uda1380' into asoc-next
      Merge remote-tracking branches 'asoc/topic/uniphier', 'asoc/topic/utils', 'asoc/topic/wm0010', 'asoc/topic/wm2000' and 'asoc/topic/wm5102' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm5110', 'asoc/topic/wm8350', 'asoc/topic/wm8400', 'asoc/topic/wm8903' and 'asoc/topic/wm8994' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8997' and 'asoc/topic/wm8998' into asoc-next

Markus Elfring (21):
      ASoC: wm2000: Delete an error message for a failed memory allocation in wm2000_i2c_probe()
      ASoC: wm2000: Fix a typo in a comment line
      ASoC: wm2000: Improve a size determination in wm2000_i2c_probe()
      ASoC: wm8903: Delete an error message for a failed memory allocation in wm8903_i2c_probe()
      ASoC: wm8903: Improve two size determinations in wm8903_i2c_probe()
      ASoC: twl4030: Delete an error message for a failed memory allocation in twl4030_get_pdata()
      ASoC: da7218: Delete two error messages for a failed memory allocation in da7218_of_to_pdata()
      ASoC: da7218: Improve a size determination in da7218_i2c_probe()
      ASoC: da7213: Delete an error message for a failed memory allocation in da7213_fw_to_pdata()
      ASoC: da7213: Improve a size determination in da7213_i2c_probe()
      ASoC: cs42l56: Delete an error message for a failed memory allocation in cs42l56_i2c_probe()
      ASoC: cs42l56: Improve two size determinations in cs42l56_i2c_probe()
      ASoC: cs42l52: Delete an error message for a failed memory allocation in cs42l52_i2c_probe()
      ASoC: cs42l52: Improve two size determinations in cs42l52_i2c_probe()
      ASoC: cs42l73: Delete an error message for a failed memory allocation in cs42l73_i2c_probe()
      ASoC: cs42l73: Improve two size determinations in cs42l73_i2c_probe()
      ASoC: wm0010: Delete an error message for a failed memory allocation in wm0010_boot()
      ASoC: cs35l32: Delete two error messages for a failed memory allocation in cs35l32_i2c_probe()
      ASoC: cs35l32: Improve two size determinations in cs35l32_i2c_probe()
      ASoC: cs35l34: Delete two error messages for a failed memory allocation in cs35l34_i2c_probe()
      ASoC: cs35l34: Improve two size determinations in cs35l34_i2c_probe()

Michael Stecklein (1):
      ASoC: tas6424: add bindings for TAS6424

Mukunda, Vijendar (1):
      ASoC: amd: added error checks in dma driver

Nicolin Chen (12):
      ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h
      ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
      ASoC: fsl_ssi: Cache pdev->dev pointer
      ASoC: fsl_ssi: Refine all comments
      ASoC: fsl_ssi: Rename registers and fields macros
      ASoC: fsl_ssi: Refine indentations and wrappings
      ASoC: fsl_ssi: Refine printk outputs
      ASoC: fsl_ssi: Rename cpu_dai parameter to dai
      ASoC: fsl_ssi: Rename scr_val to scr
      ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
      ASoC: fsl_ssi: Rename i2smode to i2s_net
      ASoC: fsl_ssi: Define ternary macros to simplify code

Pankaj Bharadiya (1):
      ASoC: Intel: Skylake: Ensure dai and dailink registration happens in sequence.

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Disable clock gating during firmware and library download

Peter Rosin (2):
      ASoC: tfa9879: clean up bindings
      ASoC: tfa9879: add DT bindings to MAINTAINERS

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Add rule to constrain the minimum period size

Pradeep Tewani (2):
      ASoC: Intel: Skylake: Parse vendor tokens to build A-State table
      ASoC: Intel: Skylake: Configure DSP clock source

Pravin Shedge (1):
      ASoC: hisilicon: remove duplicate includes

Puneeth Prabhu (2):
      ASoC: hdac_hdmi: Refresh sysfs during hdmi device probe
      ASoC: hdac_hdmi: Remove redundant assignments

Ryan Lee (2):
      ASoC: Added device tree binding for max98373 amplifier
      ASoC: max98373: Added Amplifier Driver

Ryder Lee (7):
      ASoC: mediatek: fix error handling in mt2701_afe_pcm_dev_probe()
      ASoC: mediatek: rework clock functions for MT2701
      ASoC: mediatek: cleanup audio driver for MT2701
      ASoC: mediatek: update clock related properties of MT2701 AFE
      ASoC: mediatek: add some core clocks for MT2701 AFE
      ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device
      ASoC: mediatek: update MT2701 AFE documentation to adapt mfd device

Sriram Periyasamy (1):
      ASoC: Intel: Skylake: Parse nhlt and register clock device

Stefan Agner (1):
      ASoC: fsl_asrc: protect macro argument

Steven Eckhoff (1):
      ASoC: TSCS42xx: Add support for Tempo Semiconductor's TSCS42xx audio CODEC

Subhransu S. Prusty (2):
      ASoC: Intel: Skylake: Remove second shim read in register_poll
      ASoC: Intel: Skylake: Request IRQ late only after all context are initialized

Takashi Iwai (1):
      ASoC: skl: Fix kernel warning due to zero NHTL entry

Ughreja, Rakesh A (3):
      ASoC: hdac_hdmi: introduce macro to access HDMI private data
      ASoC: hdac_hdmi: clean up hdac_ext_device variable names
      ASoC: hdac_hdmi: clean up hdac_device variable names

oder_chiou@realtek.com (1):
      ASoC: rt5514: The DSP clock can be calibrated by the other clock source

olivier moysan (3):
      ASoC: stm32: fix sync property description in SAI bindings
      ASoC: stm32: sai: simplify sync modes management
      ASoC: stm32: sai: use devm_of_platform_populate()

 .../devicetree/bindings/sound/max98373.txt         |   40 +
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  266 +-
 .../devicetree/bindings/sound/nau8825.txt          |    4 +-
 .../devicetree/bindings/sound/pcm186x.txt          |   42 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   15 +-
 .../devicetree/bindings/sound/simple-card.txt      |    3 +
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   12 +-
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    2 +
 .../devicetree/bindings/sound/tas5720.txt          |    4 +-
 .../devicetree/bindings/sound/tfa9879.txt          |    8 +-
 .../devicetree/bindings/sound/ti,tas6424.txt       |   20 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |    9 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   10 +-
 .../devicetree/bindings/sound/tscs42xx.txt         |   16 +
 .../devicetree/bindings/sound/uniphier,evea.txt    |   26 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |   14 +
 include/sound/hdaudio_ext.h                        |    4 +-
 include/sound/pcm.h                                |    8 +
 include/sound/rt5514.h                             |    2 +
 include/sound/rt5645.h                             |    3 +
 include/sound/soc-dai.h                            |    5 +-
 include/sound/soc.h                                |    6 +-
 include/uapi/sound/asound.h                        |    9 +
 include/uapi/sound/snd_sst_tokens.h                |   17 +-
 sound/core/pcm_misc.c                              |   19 +-
 sound/hda/ext/hdac_ext_bus.c                       |    2 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/amd/acp-pcm-dma.c                        |   35 +-
 sound/soc/atmel/atmel-classd.c                     |    6 -
 sound/soc/cirrus/ep93xx-ac97.c                     |    6 +-
 sound/soc/codecs/88pm860x-codec.c                  |    9 +-
 sound/soc/codecs/Kconfig                           |   42 +-
 sound/soc/codecs/Makefile                          |   12 +
 sound/soc/codecs/cq93vc.c                          |   10 +-
 sound/soc/codecs/cs35l32.c                         |   18 +-
 sound/soc/codecs/cs35l34.c                         |   19 +-
 sound/soc/codecs/cs42l52.c                         |   13 +-
 sound/soc/codecs/cs42l56.c                         |   13 +-
 sound/soc/codecs/cs42l73.c                         |   13 +-
 sound/soc/codecs/cs47l24.c                         |   12 +-
 sound/soc/codecs/cx20442.c                         |   44 +-
 sound/soc/codecs/da7213.c                          |    7 +-
 sound/soc/codecs/da7218.c                          |    9 +-
 sound/soc/codecs/hdac_hdmi.c                       |  358 ++-
 sound/soc/codecs/max98373.c                        |  971 +++++++
 sound/soc/codecs/max98373.h                        |  212 ++
 sound/soc/codecs/max98926.c                        |    2 +-
 sound/soc/codecs/max98927.c                        |    1 -
 sound/soc/codecs/mc13783.c                         |    9 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    8 +-
 sound/soc/codecs/nau8540.c                         |   98 +-
 sound/soc/codecs/nau8540.h                         |   20 +
 sound/soc/codecs/nau8824.c                         |   18 +-
 sound/soc/codecs/nau8825.c                         |  101 +-
 sound/soc/codecs/nau8825.h                         |    3 +-
 sound/soc/codecs/pcm186x-i2c.c                     |   69 +
 sound/soc/codecs/pcm186x-spi.c                     |   69 +
 sound/soc/codecs/pcm186x.c                         |  719 ++++++
 sound/soc/codecs/pcm186x.h                         |  220 ++
 sound/soc/codecs/pcm512x-spi.c                     |    4 +
 sound/soc/codecs/rl6231.c                          |   93 +-
 sound/soc/codecs/rt5514-spi.c                      |    1 +
 sound/soc/codecs/rt5514.c                          |   85 +
 sound/soc/codecs/rt5514.h                          |    5 +-
 sound/soc/codecs/rt5645.c                          |  192 +-
 sound/soc/codecs/rt5645.h                          |    6 +
 sound/soc/codecs/si476x.c                          |    9 +-
 sound/soc/codecs/spdif_receiver.c                  |    5 +-
 sound/soc/codecs/spdif_transmitter.c               |    5 +-
 sound/soc/codecs/tas5720.c                         |   61 +-
 sound/soc/codecs/tas5720.h                         |   31 +
 sound/soc/codecs/tas6424.c                         |  707 +++++
 sound/soc/codecs/tas6424.h                         |  144 ++
 sound/soc/codecs/tfa9879.c                         |    1 +
 sound/soc/codecs/tlv320aic31xx.c                   |  310 +--
 sound/soc/codecs/tlv320aic31xx.h                   |  335 +--
 sound/soc/codecs/tlv320aic32x4.c                   |  182 +-
 sound/soc/codecs/tlv320aic32x4.h                   |  308 ++-
 sound/soc/codecs/tlv320aic3x.c                     |   15 +-
 sound/soc/codecs/tlv320dac33.c                     |   45 +-
 sound/soc/codecs/ts3a227e.c                        |    2 +-
 sound/soc/codecs/tscs42xx.c                        | 1456 +++++++++++
 sound/soc/codecs/tscs42xx.h                        | 2693 ++++++++++++++++++++
 sound/soc/codecs/twl4030.c                         |   11 +-
 sound/soc/codecs/twl6040.c                         |   20 +-
 sound/soc/codecs/uda1380.c                         |   44 +-
 sound/soc/codecs/wm0010.c                          |    5 +-
 sound/soc/codecs/wm2000.c                          |    6 +-
 sound/soc/codecs/wm2200.c                          |    9 +-
 sound/soc/codecs/wm5102.c                          |   11 +-
 sound/soc/codecs/wm5110.c                          |   12 +-
 sound/soc/codecs/wm8350.c                          |   10 +-
 sound/soc/codecs/wm8400.c                          |    9 +-
 sound/soc/codecs/wm8903.c                          |   12 +-
 sound/soc/codecs/wm8994.c                          |   10 +-
 sound/soc/codecs/wm8997.c                          |   11 +-
 sound/soc/codecs/wm8998.c                          |   12 +-
 sound/soc/davinci/davinci-mcasp.c                  |   19 +
 sound/soc/fsl/eukrea-tlv320.c                      |    1 -
 sound/soc/fsl/fsl-asoc-card.c                      |    4 +-
 sound/soc/fsl/fsl_asrc.h                           |    2 +-
 sound/soc/fsl/fsl_ssi.c                            | 1367 +++++-----
 sound/soc/fsl/fsl_ssi.h                            |  427 ++--
 sound/soc/fsl/fsl_ssi_dbg.c                        |   59 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    1 -
 sound/soc/intel/atom/sst/sst_acpi.c                |    3 +
 sound/soc/intel/boards/bytcr_rt5651.c              |   14 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    7 +
 sound/soc/intel/boards/haswell.c                   |    2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    2 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    2 +-
 sound/soc/intel/boards/mfld_machine.c              |    2 +
 sound/soc/intel/common/sst-dsp.c                   |    4 +-
 sound/soc/intel/skylake/bxt-sst.c                  |    2 +-
 sound/soc/intel/skylake/cnl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-i2s.h                  |   64 +
 sound/soc/intel/skylake/skl-messages.c             |   22 +
 sound/soc/intel/skylake/skl-nhlt.c                 |  158 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   14 +-
 sound/soc/intel/skylake/skl-ssp-clk.h              |   79 +
 sound/soc/intel/skylake/skl-sst-dsp.c              |   14 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |    4 +
 sound/soc/intel/skylake/skl-sst-utils.c            |    6 +-
 sound/soc/intel/skylake/skl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |   44 +-
 sound/soc/intel/skylake/skl.c                      |  150 +-
 sound/soc/intel/skylake/skl.h                      |   22 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  552 ++--
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   15 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |   87 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |  215 +-
 sound/soc/mediatek/mt2701/mt2701-reg.h             |   42 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    6 +-
 sound/soc/nuc900/nuc900-ac97.c                     |   11 +-
 sound/soc/omap/ams-delta.c                         |    4 +-
 sound/soc/qcom/apq8016_sbc.c                       |   10 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |    3 +-
 sound/soc/samsung/bells.c                          |   40 +-
 sound/soc/sh/rcar/core.c                           |  143 +-
 sound/soc/sh/rcar/dma.c                            |   18 -
 sound/soc/sh/rcar/rsnd.h                           |   15 +-
 sound/soc/sh/rcar/ssi.c                            |  163 +-
 sound/soc/soc-compress.c                           |    4 +-
 sound/soc/soc-core.c                               |   31 +-
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/stm/stm32_sai.c                          |  114 +-
 sound/soc/sunxi/sun4i-codec.c                      |   29 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   57 +-
 sound/soc/uniphier/Kconfig                         |   19 +
 sound/soc/uniphier/Makefile                        |    3 +
 sound/soc/uniphier/evea.c                          |  567 +++++
 154 files changed, 11926 insertions(+), 3319 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/max98373.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tscs42xx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
 create mode 100644 sound/soc/codecs/max98373.c
 create mode 100644 sound/soc/codecs/max98373.h
 create mode 100644 sound/soc/codecs/pcm186x-i2c.c
 create mode 100644 sound/soc/codecs/pcm186x-spi.c
 create mode 100644 sound/soc/codecs/pcm186x.c
 create mode 100644 sound/soc/codecs/pcm186x.h
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h
 create mode 100644 sound/soc/codecs/tscs42xx.c
 create mode 100644 sound/soc/codecs/tscs42xx.h
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h
 create mode 100644 sound/soc/uniphier/Kconfig
 create mode 100644 sound/soc/uniphier/Makefile
 create mode 100644 sound/soc/uniphier/evea.c

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPtB8ACgkQJNaLcl1U
h9Bdtgf8CM2Ha71/R3Am4hvNg4LFeGWwwja4B3EA4XYAhznthOvhNPxxDgv41148
POkLVLHqaXuSeRbBlCTN7V8GCGHwtTKrdDUb6gEH7iYjf8UrJklEvz2Um/jlHraU
MlK2zXxZ6hRIvML2h3nph6IibmbRHRwhx2itBlZ4MzGAvMu6i2NHcen7mAPZBJzM
u1GP2VyYfALiEIDaCIGfX0kXydLPUcifpDE1xAjFGhck0AsZ8+XF3EPPnGIEYO2a
fSGSXEJVmafKiudodWRnyYpo8yuKv2hX1YaisrvElrIQiRrskCvGJzvoXsc4zX0k
VMO1xQgwudMCSpPPf46EYClpVfIU3Q==
=bFpj
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--

--===============5188175401375326387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5188175401375326387==--
