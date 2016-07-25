From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.8
Date: Mon, 25 Jul 2016 16:26:14 +0100
Message-ID: <20160725152614.GA11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5178344442125083376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1EDC265837
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2016 17:26:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5178344442125083376==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.8

for you to fetch changes up to e7ca8fcd15049b1e48ae2ef1434a68a51ef0ead5:

  Merge remote-tracking branches 'asoc/topic/wm8753' and 'asoc/topic/wm8985' into asoc-next (2016-07-24 22:07:48 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.8

Not really any framework work this time around (though we have seen one
of the Analog Devices drivers move more to the clock API which is good
to see) but rather a lot of new drivers:

 - Lots of updates for the Intel drivers, mostly board support and bug
   fixing, and to the NAU8825 driver.
 - Work on generalizing bits of simple-card to allow more code sharing
   with the Renesas rsrc-card (which can't use simple-card due to DPCM).
 - Removal of the Odroid X2 driver due to replacement with simple-card.
 - Support for several new Mediatek platforms and associated boards.
 - New drivers for Allwinner A10, Analog Devices ADAU7002, Broadcom
   Cygnus, Cirrus Logic CS35L33 and CS53L30, Maxim MAX8960 and MAX98504,
   Realtek RT5514 and Wolfson WM8758

----------------------------------------------------------------
Adam Thomson (2):
      device property: Add function to search for named child of device
      ASoC: da7219: Convert driver to use generic device/fwnode functions

Alan Cox (2):
      ASoC: Intel: atom: fix missing breaks that would cause the wrong operation to execute
      ASoC: Intel: atom: fix missing breaks that would cause the wrong operation to execute

Alexander Shiyan (1):
      ASoC: wm8753: Replace magic number

Amitoj Kaur Chawla (3):
      ASoC: wm8753: Remove unneeded header file
      ASoC: Atmel: ClassD: Simplify use of devm_ioremap_resource
      ASoC: atmel-pdmic: Simplify use of devm_ioremap_resource

Andrea Gelmini (2):
      ASoC: dt: Fix typo
      ASoC: fsl: Fix typo

Arnd Bergmann (10):
      ASoC: wm8985: add i2c dependency
      ASoC: fix ABE_TWL6040 dependency
      ASoC: cs53l30: include gpio/consumer.h
      ASoC: pcm1681/pcm1791: fix typo in declaration
      ASoC: rcar: fix 'const static' variables
      ASoC: remove one extraneous 'const'
      ASoC: nau8825: mark pm functions __maybe_unused
      ASoC fix up SND_SOC_WM8985 dependency
      ASoC: dwc: make pcm support built-in when necessary
      ASoC: cs35l33: mark PM functions as __maybe_unused

Axel Lin (5):
      ASoC: cs35l33: Remove unnecessary free_irq call
      ASoC: cs35l33: Remove setting dapm->bias_level in cs35l33_set_bias_level
      ASoC: cs35l33: Fix testing return value of devm_gpiod_get_optional
      ASoC: cs35l33: Fix display revision id
      ASoC: rt5514-spi: Convert to use devm_* API

Bard Liao (5):
      ASoC: rt5670: fix HP Playback Volume control
      ASoC: rt5670: patch reg-0x8a
      ASoC: rt5645: patch reg-0x8a
      ASoC: rt5645: set RT5645_PRIV_INDEX as volatile
      ASoC: rt5645: add DAC1 soft volume func control

Bastien Nocera (1):
      ASoC: tlv320aix31xx: Add ACPI match for Lenovo 100S

Ben Zhang (1):
      ASoC: Intel: Fix conflicting pcm dev drvdata on haswell

Charles Keepax (12):
      ASoC: arizona: Add a notifier chain for CODEC events
      ASoC: arizona: Add event notification on voice trigger events
      ASoC: arizona: Tie SYSCLK to DRC signal activity widgets
      ASoC: arizona: Add voice trigger output widget
      ASoC: wm_adsp: Specifically propagate voice trigger event to caller
      ASoC: arizona: Add data structure for voice trigger notifier
      ASoC: arizona: Add a couple of missing consts
      ASoC: wm5102: Revert manual speaker enable
      ALSA: compress: Add function to indicate the stream has gone bad
      ASoC: wm_adsp: Use new snd_compr_stop_error to signal stream failure
      ASoC: wm_adsp: Treat missing compressed buffer as a fatal error
      ASoC: compress: Pass error out of soc_compr_pointer

Chris Zhong (1):
      ASoC: rockchip: correct the spdif clk

Clemens Gruber (1):
      ASoC: sgtl5000: Remove misleading comment

Colin Ian King (3):
      SoC: dwc: trivial fix of spelling mistake "unsuppted" -> "unsupported"
      ASoC: samsung: fix spelling mistake: "unknwon" -> "unknown"
      ASoC: fsl_spdif: fix spelling mistake: "receivce" -> "receive"

Dan Carpenter (1):
      ASoC: mediatek: mt2701: fix some error handling in probe

Dharageswari R (5):
      ASoC: Intel: Skylake: Don't pause stopped pipeline while deleting
      ASoC: Intel: Skylake: Disable SRAM Retention before D3
      ASoC: Intel: Skylake: Avoid freeing up of unallocated memory/mcps
      ASoC: Intel: Skylake: Clean up of driver resources in suspend
      ASoC: Intel: Skylake: Fix to use the actual size for TLV control

Enric Balletbo i Serra (4):
      ASoC: rockchip-max98090: Fix NULL pointer dereference while accessing to jack.
      ASoC: rockchip-max98090: Fix the Headset Mic route.
      ASoC: rockchip-max98090: Fix jack detection and event reporting.
      ASoC: max9867: Fix unix permissions for source files.

Eric Nelson (5):
      ASoC: sgtl5000: Fix regulator support
      ASoC: sgtl5000: Write all default registers
      ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults
      ASoC: sgtl5000: Disable internal PLL early
      ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF

Fabio Estevam (2):
      ASoC: pcm5102a: Remove owner assignment from platform_driver
      ASoC: sgtl5000: Place optional properties in the correct section

Garlic Tseng (10):
      ASoC: mediatek: Refine mt8173 driver and change config option
      ASoC: mediatek: implement mediatek common structure
      ASoC: mediatek: let mt8173 use mediatek common structure
      ASoC: mediatek: add documents for mt2701
      ASoC: mediatek: add structure define and clock control for 2701
      ASoC: bt-sco: add config prompt
      ASoC: bt-sco: extend rate and add a general compatible string
      ASoC: mediatek: add mt2701 platform driver implementation.
      ASoC: mediatek: Add mt2701-cs42448 driver and config option.
      ASoC: mediatek: add BT implementation

Geert Uytterhoeven (2):
      ASoC: Add file patterns for sound device tree bindings
      ASoC: ak4613: Implement suspend callback

Helen Koike (6):
      ASoC: max9877: Remove unused function declaration
      ASoC: tpa6130a2: Register component
      ASoC: tap6130a2: Use regmap
      ASoC: tpa6130a2: Use snd soc volsw functions
      ASoC: tpa6130a2: Add DAPM support
      ASoC: tpa6130a2: Remove goto err_gpio

Javier Martinez Canillas (1):
      ASoC: nau8825: Export I2C module alias information

Jayachandran B (5):
      ASoC: Intel: Skylake: Enable firmware reload in suspend
      ASoC: Intel: Skylake: Update DSP stall bits
      ASoC: Intel: Skylake: Add DSP muti-core infrastructure
      ASoC: Intel: Skylake: Support multi-core in Skylake
      ASoC: Intel: Skylake: Support multi-core in Broxton

Jeeja KP (8):
      ASoC: Intel: Skylake: Reset DSP pipe when host/link DMA is reset
      ASoC: Intel: Skylake: Set the pipe state to paused when paused
      ASoC: Intel: Skylake: Create Pipe to widget list in soc probe
      ASoC: Intel: Skylake: Set the DSP pipe type
      ASoC: Intel: Skylake: Copy the pipe parameter by pipe type
      ASoC: Intel: Skylake: Report position in pointer query
      ASoC: Intel: Add support for PM ops in bxt-rt298
      ASoC: dapm: Fix to return correct path list in is_connected_ep.

John Hsu (11):
      ASoC: nau8825: support different clock source for FLL function
      ASoC: nau8825: improve FLL function for better performance
      ASoC: nau8825: reduce standby power consumption
      ASoC: nau8825: change output power for interrupt
      ASoC: nau8825: assign DAC Ch to match headset L/R
      ASoC: nau8825: add programmable biquad filter control
      ASoC: nau8825: non-clock jack detection for power saving at standby
      ASoC: nau8825: correct typo in biquad filter coefficients
      ASoC: nau8825: cross talk suppression measurement function
      ASoC: nau8825: jack connection decision with different insertion logic
      ASoC: nau8825: drop redundant idiom when converting integer to boolean

Jose Abreu (3):
      ASoC: dwc: Add helper functions to disable/enable irqs
      ASoC: dwc: Add PIO PCM extension
      ASoC: dwc: Add irq parameter to DOCUMENTATION

Kalle Kankare (1):
      sgtl5000: add Lineout volume control

Krzysztof Kozlowski (1):
      MAINTAINERS: ASoC: samsung: Add Sylwester Nawrocki and Krzysztof Kozlowski

Kuninori Morimoto (16):
      ASoC: rsrc-card: remove unused dai_num
      ASoC: simple-card: platform also uses asoc_simple_card_sub_parse_of()
      ASoC: rsnd: adg :: AUDIO-CLKOUTn asynchronizes support
      ASoC: simple-card: use common PREFIX for each DT property
      ASoC: hdmi-codec: callback function will be called with private data
      ASoC: simple-card: add new asoc_simple_jack and use it
      ASoC: add new simple-card-utils.c
      ASoC: simple-card: use asoc_simple_card_parse_daifmt()
      ASoC: rsrc-card: use asoc_simple_card_parse_daifmt()
      ASoC: simple-card-utils: add asoc_simple_card_set_dailink_name()
      ASoC: simple-card: use asoc_simple_card_parse_dailink_name()
      ASoC: simple-card-utils: add asoc_simple_card_parse_card_name()
      ASoC: simple-card: use asoc_simple_card_parse_card_name()
      ASoC: rsrc-card: use asoc_simple_card_parse_dailink_name()
      ASoC: rsrc-card: use asoc_simple_dai instead of rsrc_card_dai
      ASoC: rsrc-card: use asoc_simple_card_parse_card_name()

Lars-Peter Clausen (4):
      ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter DT bindings
      ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter driver
      ASoC: adau: Factor out shared PLL configuration code
      ASoC: adau17x1: Add support for specifying the MCLK using the CCF

Mark Brown (20):
      Merge branch 'topic/compress' of git://git.kernel.org/.../broonie/sound into asoc-adsp
      Merge branch 'topic/simple' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1681' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm5102a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adau', 'asoc/topic/adau7002', 'asoc/topic/adsp', 'asoc/topic/ak4613' and 'asoc/topic/ak4642' into asoc-next
      Merge remote-tracking branches 'asoc/topic/arizona', 'asoc/topic/atmel', 'asoc/topic/bt-sco', 'asoc/topic/compress' and 'asoc/topic/cs35l33' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs53l30', 'asoc/topic/cygnus', 'asoc/topic/da7219' and 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dpcm', 'asoc/topic/dt', 'asoc/topic/dwc' and 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-spdif', 'asoc/topic/hdmi', 'asoc/topic/maintainers' and 'asoc/topic/max8960' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98504', 'asoc/topic/max9867', 'asoc/topic/max9877', 'asoc/topic/mtk' and 'asoc/topic/nau8825' into asoc-next
      Merge remote-tracking branches 'asoc/topic/omap', 'asoc/topic/rcar' and 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5514', 'asoc/topic/rt5614', 'asoc/topic/rt5670' and 'asoc/topic/s8' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sgtl5000', 'asoc/topic/sti' and 'asoc/topic/sunxi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas571x', 'asoc/topic/tlv320aic31xx', 'asoc/topic/tpa6130a2', 'asoc/topic/twl6040' and 'asoc/topic/wm8731' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8753' and 'asoc/topic/wm8985' into asoc-next

Markus Elfring (1):
      ASoC: Intel: Skylake: Delete an unnecessary check before the function call "release_firmware"

Matt Flax (1):
      ASoc: wm8731: add 32bit mode.

Maxime Ripard (2):
      ASoC: sunxi: Add A10 I2S controller binding documentation
      ASoC: sunxi: Add Allwinner A10 Digital Audio driver

Nicolin Chen (8):
      ASoC: cs53l30: Add codec driver support for Cirrus CS53L30
      ASoC: cs53l30: Rename the volume controls for preamplifier
      ASoC: cs53l30: Check return value of regcache_sync()
      ASoC: cs53l30: Correct clock inversion check
      ASoC: cs53l30: Set idle_bias_off true
      ASoC: cs53l30: Add MUTE pin control support via GPIO
      ASoC: cs53l30: Fix a bug for TDM slot location validation
      ASoC: cs53l30: Fix bit shift issue of TDM mode

Oder Chiou (3):
      ASoC: rt5514: add rt5514 SPI driver
      ASoC: rt5514: Add the MCLK handling
      ASoC: rt5514: Fix the issue that the variable dereferenced before checking

PC Liao (3):
      ASoC: mediatek: Change the order of MCLK clock configuration
      ASoC: mediatek: add MCLK source selection
      ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650 machine driver

Paul Handrigan (2):
      ASoC: cs35l33: Initial commit of the cs35l33 CODEC driver.
      ASoC: cs35l33: Add device tree bindings file for cs35l33

Peter Griffin (1):
      ASoC: sti: Update DT example to match the driver code

Peter Meerwald (1):
      ASoC: atmel_ssc_dai: Fix DMA params for different SSC

Peter Rosin (2):
      ASoC: max8960: add bindings for the max9860 codec
      ASoC: max9860: new driver

Peter Ujfalusi (8):
      ASoC: omap: Kconfig: SND_OMAP_SOC_OMAP_ABE_TWL6040 to select CLK_TWL6040
      ASoC: omap-mcpdm: Move the WD enable write inside omap_mcpdm_open_streams()
      ASoC: omap-mcpdm: Support for suspend resume
      ASoC: omap-mcpdm: Add support for pdmclk clock handling
      ASoC: tlv320aic31xx: Make the register values human readable
      ASoC: ak4642: Implement suspend callback
      ASoC: davinci-mcasp: Fix dra7 DMA offset when using CFG port
      ASoC: davinci-mcasp: Use a copy of pdata per instance during DT boot

Petr Kulhavy (5):
      ASoC: tas571x: add biquad registers for TAS5717/19
      ASoC: tas571x: add biquads for TAS5717/19
      ASoC: wm8985: add register definitions for WM8758
      ASoC: wm8985: add support for WM8758
      ASoC: tas571x: add input channel mixer for TAS5717/19

Piotr Stankiewicz (2):
      ASoC: dapm: support user-defined stop condition in dai_get_connected_widgets
      ASoC: dpcm: play nice with CODEC<->CODEC links

Ramesh Babu (1):
      ASoC: Intel: Skylake: Add strip extended manifest utility

Randy Dunlap (1):
      ASoC: intel: make function stub static

Sathyanarayana Nujella (2):
      ASoC: Intel: Add Broxton-P Dialog Maxim machine driver
      ASoC: Intel: Add Broxton-P Dialog+Maxim machine driver entry

Senthilnathan Veppur (5):
      ASoC: Intel: Add DMIC 4 channel support for bxt machine
      ASoC: Intel: Add FE rate & channel constraints for bxt-rt298
      ASoC: Intel: Update ignore suspend for bxt-rt298
      ASoC: Intel: Skylake: Update FW purge for Broxton
      ASoC: Intel: Skylake: Fix fw reload failure

Shreyas NC (2):
      ASoC: Intel: Skylake: Add DSP firmware manifest parsing
      ASoC: hdac_hdmi: Add device id for Kabylake

Simon Trimmer (1):
      ASoC: wm_adsp: Disable DMAs before clearing the transfer length

Simran Rai (3):
      ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
      ASoC: cygnus: Add Cygnus audio DAI driver
      ASoC: cygnus: Add Cygnus audio DMA driver

Srinivas Kandagatla (1):
      ASoC: Introduce SOC_SINGLE_S8_TLV() macro

Subhransu S. Prusty (1):
      ASoC: dapm: Export snd_soc_dapm_new_control

Sudip Mukherjee (2):
      ASoC: fsl: fix build failure
      ASoC: atmel: fix build failure

Sugar Zhang (2):
      ASoC: rockchip: i2s: configure the sdio pins' iomux mode
      ASoC: rockchip: i2s: rename I2S_CKR_TRCM_TX/RXSHARE to I2S_CKR_TRCM_TX/RXONLY

Sylwester Nawrocki (8):
      ASoC: samsung: Remove unused "samsung-i2sv4" platform_device_id entry
      ASoC: samsung: Remove definition of an unused data structure
      ASoC: samsung: Use of_device_get_match_data() helper
      ASoC: samsung: Remove unused Odroid x2/u3 machine driver
      ASoC: max98504: Add max98504 speaker amplifier driver
      ASoC: Add DT bindings documentation for max98504 amplifier
      ASoC: samsung: Fix error paths in the I2S driver's probe()
      ASoC: samsung: Specify DMA channels through struct snd_dmaengine_pcm_config

Takashi Iwai (1):
      ASoC: intel: Fix sst-dsp dependency on dw stuff

Vedang Patel (4):
      ASoC: hdac_hdmi: Increase loglevel of hex dump printed
      ASoC: Intel: common: increase the loglevel of "FW Poll Status".
      ASoC: Intel: Skylake: Increase loglevel of debug messages.
      ASoC: Intel: Skylake: Fix NULL Pointer exception in dynamic_debug.

Vinod Koul (27):
      ASoC: Intel: Skylake: Don't use local pointer for firmware
      ASoC: Intel: Skylake: Strip manifest for Skylake platform
      ASoC: Intel: Skylake: Strip manifest for Broxton platform
      ASoC: Intel: Skylake: Find uuids for Skylake
      ASoC: Intel: Skylake: Find uuids for Broxton
      ASoC: Intel: Skylake: Check for module list being NULL
      ASoC: Intel: Kconfig: fix build when ACPI is not enabled
      ASoC: Intel: Kconfig: formatting update
      ASoC: Intel: Revert "ASoC: Intel: Add support for PM ops in bxt-rt298"
      ASoC: Intel: Skylake: Disable async suspend
      ASoC: Intel: Skylake: Add pm ops for broxton-rt298 machine
      ASoC: Intel: Skylake: Update comment style
      ASoC: Intel: Atom: Add quirk for Surface 3
      ASoC: Intel: Add surface3 entry in CHT-RT5645 machine
      ASoC: rt5645: Add ACPI ID 10EC5640
      ASoC: Intel: cht: fix uninit variable warning
      ASoC: Intel: atom: statify cht_quirk
      ASoC: hdac_hdmi: Fix potential NULL dereference
      ASoC: Intel: Skylake: Initialize module list for Broxton
      ASoC: Intel: add kablake device IDs
      ASoC: rt286: set combo jack for Kabylake
      ASoC: Intel: board: add kabylake machine id
      ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_ssm4567
      ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_max98357a
      ASoC: Intel: Kbl: add kabylake additional machine entries
      ASoC: Intel: board: add kabylake nau88l25_max98357a machine id
      ASoC: Intel: board: add kabylake nau88l25_ssm4567 machine id

Wei Yongjun (6):
      ASoC: sti: fix return value check in uni_player_parse_dt_audio_glue()
      ASoC: max9860: fix non static symbol warnings
      ASoC: cs53l30: Fix non static symbol warnings
      ASoC: sunxi: remove redundant dev_err call in sun4i_i2s_probe()
      ASoC: cs35l33: Remove unused including <linux/version.h>
      ASoC: mediatek: mt2701: fix non static symbol warning

Yong Zhi (5):
      ASoC: Intel: Skylake: Add channel constraints for refcap
      ASoC: Intel: Skylake: Use refcap device for mono recording
      ASoC: Intel: Skylake: Add api to retrieve dmic array info from nhlt
      ASoC: Intel: boards: configure DMIC for machine sklnau8825adi
      ASoC: Intel: boards: configure DMIC for machine sklnau8825max

kbuild test robot (2):
      ASoC: cs35l33: fix platform_no_drv_owner.cocci warnings
      ASoC: sunxi: fix semicolon.cocci warnings

 .../devicetree/bindings/sound/adi,adau17x1.txt     |    8 +
 .../devicetree/bindings/sound/adi,adau7002.txt     |   19 +
 .../bindings/sound/brcm,cygnus-audio.txt           |   67 +
 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 .../devicetree/bindings/sound/cs35l33.txt          |  126 ++
 .../devicetree/bindings/sound/cs53l30.txt          |   44 +
 .../devicetree/bindings/sound/designware-i2s.txt   |    4 +
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |    2 +-
 .../devicetree/bindings/sound/max98504.txt         |   44 +
 .../devicetree/bindings/sound/max9860.txt          |   28 +
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  150 ++
 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   43 +
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   10 +-
 .../devicetree/bindings/sound/omap-mcpdm.txt       |   10 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    2 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    5 +
 Documentation/devicetree/bindings/sound/rt5514.txt |    5 +
 .../bindings/sound/samsung,odroidx2-max98090.txt   |   35 -
 .../devicetree/bindings/sound/sgtl5000.txt         |   18 +-
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |   20 +-
 .../devicetree/bindings/sound/sun4i-i2s.txt        |   34 +
 Documentation/sound/alsa/soc/machine.txt           |    2 +-
 MAINTAINERS                                        |   11 +-
 drivers/base/property.c                            |   28 +
 include/acpi/acpi_bus.h                            |    7 +
 include/linux/acpi.h                               |    6 +
 include/linux/mfd/arizona/core.h                   |   10 +
 include/linux/of.h                                 |   14 +-
 include/linux/property.h                           |    3 +
 include/sound/compress_driver.h                    |    5 +
 include/sound/cs35l33.h                            |   48 +
 include/sound/hdmi-codec.h                         |   13 +-
 include/sound/simple_card.h                        |   11 +-
 include/sound/simple_card_utils.h                  |   36 +
 include/sound/soc-dapm.h                           |    8 +-
 include/sound/soc.h                                |   11 +
 sound/core/compress_offload.c                      |   67 +-
 sound/soc/atmel/Kconfig                            |    1 +
 sound/soc/atmel/atmel-classd.c                     |    5 -
 sound/soc/atmel/atmel-pdmic.c                      |    5 -
 sound/soc/atmel/atmel_ssc_dai.c                    |    2 +-
 sound/soc/bcm/Kconfig                              |    9 +
 sound/soc/bcm/Makefile                             |    5 +
 sound/soc/bcm/cygnus-pcm.c                         |  861 ++++++++++
 sound/soc/bcm/cygnus-ssp.c                         | 1529 ++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |  139 ++
 sound/soc/codecs/Kconfig                           |   38 +-
 sound/soc/codecs/Makefile                          |   14 +
 sound/soc/codecs/adau-utils.c                      |   61 +
 sound/soc/codecs/adau-utils.h                      |    7 +
 sound/soc/codecs/adau1373.c                        |   38 +-
 sound/soc/codecs/adau1761-i2c.c                    |    2 +-
 sound/soc/codecs/adau1761-spi.c                    |    2 +-
 sound/soc/codecs/adau1781-i2c.c                    |    2 +-
 sound/soc/codecs/adau1781-spi.c                    |    2 +-
 sound/soc/codecs/adau17x1.c                        |  251 +--
 sound/soc/codecs/adau17x1.h                        |    6 +
 sound/soc/codecs/adau7002.c                        |   80 +
 sound/soc/codecs/ak4613.c                          |   12 +-
 sound/soc/codecs/ak4642.c                          |   13 +-
 sound/soc/codecs/arizona.c                         |   91 +-
 sound/soc/codecs/arizona.h                         |   22 +-
 sound/soc/codecs/bt-sco.c                          |   52 +-
 sound/soc/codecs/cs35l33.c                         | 1303 +++++++++++++++
 sound/soc/codecs/cs35l33.h                         |  221 +++
 sound/soc/codecs/cs47l24.c                         |   19 +
 sound/soc/codecs/cs53l30.c                         | 1143 ++++++++++++++
 sound/soc/codecs/cs53l30.h                         |  459 ++++++
 sound/soc/codecs/da7219-aad.c                      |  103 +-
 sound/soc/codecs/da7219.c                          |   34 +-
 sound/soc/codecs/hdac_hdmi.c                       |    7 +-
 sound/soc/codecs/hdmi-codec.c                      |   15 +-
 sound/soc/codecs/max98504.c                        |  383 +++++
 sound/soc/codecs/max98504.h                        |   59 +
 sound/soc/codecs/max9860.c                         |  753 +++++++++
 sound/soc/codecs/max9860.h                         |  162 ++
 sound/soc/codecs/max9867.c                         |    0
 sound/soc/codecs/max9867.h                         |    0
 sound/soc/codecs/max9877.h                         |    2 -
 sound/soc/codecs/nau8825.c                         | 1256 +++++++++++++--
 sound/soc/codecs/nau8825.h                         |  127 +-
 sound/soc/codecs/pcm1681.c                         |    2 +-
 sound/soc/codecs/pcm179x.c                         |    2 +-
 sound/soc/codecs/pcm5102a.c                        |    1 -
 sound/soc/codecs/rt286.c                           |    7 +
 sound/soc/codecs/rt5514-spi.c                      |  447 ++++++
 sound/soc/codecs/rt5514-spi.h                      |   38 +
 sound/soc/codecs/rt5514.c                          |  168 +-
 sound/soc/codecs/rt5514.h                          |    7 +
 sound/soc/codecs/rt5645.c                          |   24 +-
 sound/soc/codecs/rt5645.h                          |    3 +
 sound/soc/codecs/rt5670.c                          |    3 +-
 sound/soc/codecs/sgtl5000.c                        |  431 ++---
 sound/soc/codecs/sgtl5000.h                        |    2 +
 sound/soc/codecs/tas571x.c                         |  188 +++
 sound/soc/codecs/tas571x.h                         |   40 +
 sound/soc/codecs/tlv320aic31xx.h                   |  134 +-
 sound/soc/codecs/tpa6130a2.c                       |  394 ++---
 sound/soc/codecs/tpa6130a2.h                       |   14 +-
 sound/soc/codecs/wm5102.c                          |    1 +
 sound/soc/codecs/wm5110.c                          |   19 +
 sound/soc/codecs/wm8731.c                          |    5 +-
 sound/soc/codecs/wm8753.c                          |    3 +-
 sound/soc/codecs/wm8985.c                          |  143 +-
 sound/soc/codecs/wm8985.h                          |   38 +
 sound/soc/codecs/wm8998.c                          |    1 +
 sound/soc/codecs/wm_adsp.c                         |   34 +-
 sound/soc/codecs/wm_adsp.h                         |    4 +
 sound/soc/davinci/davinci-mcasp.c                  |    9 +-
 sound/soc/dwc/Kconfig                              |    9 +
 sound/soc/dwc/Makefile                             |    4 +-
 sound/soc/dwc/designware_i2s.c                     |  231 ++-
 sound/soc/dwc/designware_pcm.c                     |  225 +++
 sound/soc/dwc/local.h                              |  128 ++
 sound/soc/fsl/Kconfig                              |    1 +
 sound/soc/fsl/fsl_spdif.c                          |    2 +-
 sound/soc/generic/Kconfig                          |    4 +
 sound/soc/generic/Makefile                         |    2 +
 sound/soc/generic/simple-card-utils.c              |   97 ++
 sound/soc/generic/simple-card.c                    |  276 ++--
 sound/soc/intel/Kconfig                            |   73 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   44 +-
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  460 ++++++
 sound/soc/intel/boards/bxt_rt298.c                 |  118 ++
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   20 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |   51 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |   51 +-
 sound/soc/intel/boards/skl_rt286.c                 |    9 +
 sound/soc/intel/common/Makefile                    |    4 +-
 sound/soc/intel/common/sst-acpi.h                  |    4 +-
 sound/soc/intel/common/sst-dsp-priv.h              |    4 -
 sound/soc/intel/common/sst-dsp.c                   |   69 +-
 sound/soc/intel/common/sst-dsp.h                   |    2 +-
 sound/soc/intel/common/sst-firmware.c              |   68 +
 sound/soc/intel/haswell/sst-haswell-pcm.c          |    1 -
 sound/soc/intel/skylake/Makefile                   |    2 +-
 sound/soc/intel/skylake/bxt-sst.c                  |  202 ++-
 sound/soc/intel/skylake/skl-messages.c             |   53 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   40 +
 sound/soc/intel/skylake/skl-nhlt.h                 |   22 +
 sound/soc/intel/skylake/skl-pcm.c                  |   93 +-
 sound/soc/intel/skylake/skl-sst-dsp.c              |  260 ++-
 sound/soc/intel/skylake/skl-sst-dsp.h              |  102 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |    4 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |   18 +
 sound/soc/intel/skylake/skl-sst-utils.c            |  256 +++
 sound/soc/intel/skylake/skl-sst.c                  |  124 +-
 sound/soc/intel/skylake/skl-topology.c             |  230 ++-
 sound/soc/intel/skylake/skl-topology.h             |    7 +-
 sound/soc/intel/skylake/skl.c                      |   39 +-
 sound/soc/intel/skylake/skl.h                      |   10 +
 sound/soc/mediatek/Kconfig                         |   38 +-
 sound/soc/mediatek/Makefile                        |   10 +-
 sound/soc/mediatek/common/Makefile                 |   16 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |  379 +++++
 sound/soc/mediatek/common/mtk-afe-fe-dai.h         |   45 +
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |   90 ++
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |   23 +
 sound/soc/mediatek/common/mtk-base-afe.h           |  104 ++
 sound/soc/mediatek/mt2701/Makefile                 |   19 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  464 ++++++
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   38 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  172 ++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1656 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  412 +++++
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  186 +++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      |   73 +
 .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     |  925 +++++------
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |   73 +-
 sound/soc/mediatek/mtk-afe-common.h                |  101 --
 sound/soc/omap/Kconfig                             |    3 +-
 sound/soc/omap/omap-mcpdm.c                        |   74 +-
 sound/soc/omap/rx51.c                              |   46 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   71 +-
 sound/soc/rockchip/rockchip_i2s.h                  |   11 +-
 sound/soc/rockchip/rockchip_max98090.c             |   65 +-
 sound/soc/rockchip/rockchip_spdif.c                |   17 +-
 sound/soc/samsung/Kconfig                          |    8 -
 sound/soc/samsung/Makefile                         |    2 -
 sound/soc/samsung/ac97.c                           |    3 +-
 sound/soc/samsung/dma.h                            |    9 +-
 sound/soc/samsung/dmaengine.c                      |   31 +-
 sound/soc/samsung/i2s.c                            |   53 +-
 sound/soc/samsung/odroidx2_max98090.c              |  185 ---
 sound/soc/samsung/pcm.c                            |    3 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                    |    3 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    3 +-
 sound/soc/samsung/spdif.c                          |    3 +-
 sound/soc/sh/Kconfig                               |    1 +
 sound/soc/sh/rcar/adg.c                            |   18 +
 sound/soc/sh/rcar/gen.c                            |   12 +-
 sound/soc/sh/rcar/rsrc-card.c                      |   99 +-
 sound/soc/soc-compress.c                           |    5 +-
 sound/soc/soc-dapm.c                               |   61 +-
 sound/soc/soc-pcm.c                                |   43 +-
 sound/soc/sti/uniperif_player.c                    |    4 +-
 sound/soc/sunxi/Kconfig                            |    9 +
 sound/soc/sunxi/Makefile                           |    2 +-
 sound/soc/sunxi/sun4i-i2s.c                        |  701 +++++++++
 205 files changed, 19212 insertions(+), 3008 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.txt
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l33.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs53l30.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max98504.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt
 create mode 100644 include/sound/cs35l33.h
 create mode 100644 include/sound/simple_card_utils.h
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h
 create mode 100644 sound/soc/codecs/adau-utils.c
 create mode 100644 sound/soc/codecs/adau-utils.h
 create mode 100644 sound/soc/codecs/adau7002.c
 create mode 100644 sound/soc/codecs/cs35l33.c
 create mode 100644 sound/soc/codecs/cs35l33.h
 create mode 100644 sound/soc/codecs/cs53l30.c
 create mode 100644 sound/soc/codecs/cs53l30.h
 create mode 100644 sound/soc/codecs/max98504.c
 create mode 100644 sound/soc/codecs/max98504.h
 create mode 100644 sound/soc/codecs/max9860.c
 create mode 100644 sound/soc/codecs/max9860.h
 mode change 100755 => 100644 sound/soc/codecs/max9867.c
 mode change 100755 => 100644 sound/soc/codecs/max9867.h
 create mode 100644 sound/soc/codecs/rt5514-spi.c
 create mode 100644 sound/soc/codecs/rt5514-spi.h
 create mode 100644 sound/soc/dwc/designware_pcm.c
 create mode 100644 sound/soc/dwc/local.h
 create mode 100644 sound/soc/generic/simple-card-utils.c
 create mode 100644 sound/soc/intel/boards/bxt_da7219_max98357a.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-utils.c
 create mode 100644 sound/soc/mediatek/common/Makefile
 create mode 100644 sound/soc/mediatek/common/mtk-afe-fe-dai.c
 create mode 100644 sound/soc/mediatek/common/mtk-afe-fe-dai.h
 create mode 100644 sound/soc/mediatek/common/mtk-afe-platform-driver.c
 create mode 100644 sound/soc/mediatek/common/mtk-afe-platform-driver.h
 create mode 100644 sound/soc/mediatek/common/mtk-base-afe.h
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-afe-common.h
 rename sound/soc/mediatek/{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c} (51%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (80%)
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h
 delete mode 100644 sound/soc/samsung/odroidx2_max98090.c
 create mode 100644 sound/soc/sunxi/sun4i-i2s.c

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJXli+UAAoJECTWi3JdVIfQ2YcH+IcItGK0tN1e3bn7MWuMN98g
4/KafhQXG6l+VYB9UfA2ug2pOOnYk6tSXCPit59eQWRfTKcO7T4L6NBb6C22l3kl
3JuEycgXlcYAPY+v/3a9bQSAWcVqt8LIqxpnXPNSjNLdZKcEywUwCXRc932sdxsQ
Z7LWO87RAIzOR4IKOGzp2MUaH4TdtcgaCO15EIlEbA2SdMEULw3JnNXozOQd8Vfm
rwNVlizw/BCmRizFSiYOe2Z0ggJ0P5TmEG4Yv2czE9fU6iNqArrVMpyzzoQbMILI
B6X6tQKUbHdZFFvzewrNolrApJTM00DpZlLjZdpHQfj0Ukg2S0L6v5iUYzhZTA==
=FaFC
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--===============5178344442125083376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5178344442125083376==--
