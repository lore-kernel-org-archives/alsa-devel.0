From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v5.0
Date: Mon, 22 Oct 2018 12:51:17 +0100
Message-ID: <20181022115117.GA2103@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3865079123674528367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 604C62677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 13:51:20 +0200 (CEST)
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


--===============3865079123674528367==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v5.0

for you to fetch changes up to 65dfb6d6dd2850f3f99f08536d2b14190350c854:

  Merge branch 'asoc-4.20' into asoc-next (2018-10-21 16:59:23 +0100)

----------------------------------------------------------------
ASoC: Updates for v5.0/v4.20

As ever there's a lot of small and driver specific changes going on
here, but we do also have some relatively large changes in the core
thanks to the hard work of Charles and Morimoto-san:

 - More component transitions from Morimoto-san, I think we're about
   finished with this.  Thanks for all the hard work!
 - Morimoto-san also added a bunch of for_each_foo macros
 - A bunch of cleanups and fixes for DAPM from Charles.
 - MCLK support for several different devices, including CS42L51, STM32
   SAI, and MAX98373.
 - Support for Allwinner A64 CODEC analog, Intel boards with DA7219 and
   MAX98927, Meson AXG PDM inputs, Nuvoton NAU8822, Renesas R8A7744 and
   TI PCM3060.

----------------------------------------------------------------
Akshu Agrawal (5):
      ASoC: AMD: Set constraints for DMIC and MAX98357a codec
      ASoC: AMD: Change MCLK to 48Mhz
      ASoC: AMD: Fix simultaneous playback and capture on different channel
      ASoC: AMD: Fix capture unstable in beginning for some runs
      ASoC: AMD: Add SND_JACK_LINEOUT jack type

Alexandru Ardelean (1):
      ASoC: dt-bindings: add dt bindings for adau1977 audio codec

Andreas Dannenberg (2):
      ASoC: codecs: tas5720: add TAS5722 specific volume control
      ASoC: codecs: tas5720: add TAS5722 TDM slot width setting support

Andreas F=E4rber (3):
      ASoC: dt-bindings: add max98088 audio codec
      ASoC: max98088: add OF support
      ASoC: max98088: Add master clock handling

Andrew F. Davis (4):
      ASoC: tas6424: Print full register name in error message
      ASoC: tas6424: Add channel fault reporting
      ASoC: tlv320aic31xx: Add short circuit detection support
      ASoC: tlv320aic31xx: Add overflow detection support

Arnd Bergmann (4):
      ASoC: pxa: avoid AC97_BUS build warning
      ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency
      ASoC: wm9712: fix unused variable warning
      ASoC: max98988: add I2C dependency

Biju Das (1):
      ASoC: rsnd: Add r8a7744 support

Charles Keepax (11):
      ASoC: dapm: Remove clock framework ifdefs
      ASoC: dapm: Don't fail creating new DAPM control on NULL pinctrl
      ASoC: dpcm: Properly initialise hw->rate_max
      ASoC: dapm: Move error handling to snd_soc_dapm_new_control_unlocked
      ASoC: dapm: Cosmetic tidy up of snd_soc_dapm_new_control
      ASoC: dapm: Move connection of CODEC to CODEC DAIs
      ASoC: dapm: Add support for multi-CODEC CODEC to CODEC links
      ASoC: dapm: Move CODEC to CODEC params from the widget to the runtime
      ASoC: dapm: Avoid uninitialised variable warning
      ASoC: dapm: Add missing return value check for snd_soc_dapm_new_dai
      ASoC: dapm: Add support for hw_free on CODEC to CODEC links

Christoph Hellwig (1):
      ASoC: intel: don't pass GFP_DMA32 to dma_alloc_coherent

Codrin Ciubotariu (2):
      ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
      ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board

Colin Ian King (2):
      ASoC: hdac_hdmi: remove redundant check for !port condition
      ASoC: sgtl5000: avoid division by zero if lo_vag is zero

Dan Carpenter (4):
      ASoC: dapm: Fix a couple uninitialized ret variables
      ASoC: qdsp6: q6asm-dai: clean up a return
      ASoC: qdsp6: q6asm-dai: checking NULL vs IS_ERR()
      ASoC: Intel: kbl_da7219_max98927: minor white space clean up

Daniel Mack (6):
      ASoC: pxa-ssp: enable and disable extclk if given
      ASoC: add fault detect recovery property to DT bindings
      ASoC: Add device tree documentation file for wm8782 stereo DAC
      ASoC: wm8782: add support for regulators
      ASoC: sta32x: set ->component pointer in private struct
      ASoC: sta32x: Add support for XTI clock

Danny Smith (1):
      ASoC: adau17x1: Implemented safeload support

David Lin (1):
      ASoC: nau8822: new codec driver

Dmytro Prokopchuk (1):
      ASoC: rsnd: fixup SSI clock during suspend/resume modes

Dragos Tarcatu (3):
      ASoC: rsnd: add support for 16/24 bit slot widths
      ASoC: rsnd: add support for the DSP_A/DSP_B formats
      ASoC: rsnd: add support for 8 bit S8 format

Fabrizio Castro (1):
      ASoC: rsnd: Add r8a774a1 support

Grant Grundler (1):
      ASoC: max98373: usleep_range() needs include/delay.h

Gustavo A. R. Silva (2):
      ASoC: es8328: Fix fall-through annotations
      ASoC: hisilicon: fix fall-through annotations

Hans de Goede (3):
      ASoC: rt5670: Add quirk for Thinkpad 8 tablet
      ASoC: Intel: common: Add quirk for Thinkpad 8 tablet
      ASoC: Intel: cht-bsw-rt5672: Add key-mappings for the headset buttons

Hiroyuki Yokoyama (1):
      ASoC: rsnd: Add device tree binding for r8a77990

Jerome Brunet (7):
      ASoC: meson: imply clock and reset controllers
      ASoC: meson: axg-fifo: report interrupt request failure
      ASoC: meson: axg-tdm: restrict formats depending on slot width
      ASoC: dmic: add Kconfig prompt for the generic dmic codec.
      ASoC: dmic: add DT module alias
      ASoC: meson: add axg pdm input DT binding documentation
      ASoC: meson: add axg pdm input

Jiada Wang (8):
      ASoC: rsnd: add warning message to rsnd_kctrl_accept_runtime()
      ASoC: rsnd: remove is_play parameter from hw_rule function
      ASoC: rsnd: ssi: Fix issue in dma data address assignment
      ASoC: rsnd: ssi: Check runtime channel number rather than hw_params
      ASoc: rsnd: dma: Calculate dma address with consider of BUSIF
      ASoc: rsnd: dma: Calculate PDMACHCRE with consider of BUSIF
      ASoC: rsnd: ssiu: Support BUSIF other than BUSIF0
      ASoC: rsnd: ssiu: Support to init different BUSIF instance

Jon Hunter (1):
      ASoC: core: Don't schedule DAPM work if already in target state

Katsuhiro Suzuki (1):
      ASoC: rockchip: add missing INTERLEAVED PCM attribute

Kirill Marinushkin (3):
      ASoC: pcm3060: Add codec driver
      ASoC: pcm3060: Improve stylistics of file comments
      ASoC: pcm3060: Improve legibility of if-statements

Kuninori Morimoto (55):
      ASoC: simple_card_utils: support snd_soc_dai_link_component style for=
 codec
      ASoC: simple-card: support snd_soc_dai_link_component style for codec
      ASoC: simple-scu-card: use simple_dai_props
      ASoC: simple-scu-card: support snd_soc_dai_link_component style for c=
odec
      ASoC: audio-graph-card: support snd_soc_dai_link_component style for =
codec
      ASoC: audio-graph-scu-card: use simple_dai_props
      ASoC: audio-graph-scu-card: support snd_soc_dai_link_component style =
for codec
      ASoC: simple-card-util: remove dai_link compatible code for codec
      ASoC: soc-core: use snd_soc_dai_link_component for platform
      ASoC: simple-card-util: support snd_soc_dai_link_component style for =
platform
      ASoC: simple-card: support snd_soc_dai_link_component style for platf=
orm
      ASoC: simple-scu-card: support snd_soc_dai_link_component style for p=
latform
      ASoC: audio-graph-card: support snd_soc_dai_link_component style for =
platform
      ASoC: audio-graph-scu-card: support snd_soc_dai_link_component style =
for platform
      ASoC: simple-card-util: remove dai_link compatible code for platform
      ASoC: rsnd: merge .nolock_start and .prepare
      ASoC: add for_each_link_codecs() macro
      ASoC: add for_each_rtd_codec_dai() macro
      ASoC: rsnd: gen: use tab instead of white-space
      ASoC: rsnd: don't use %p for dev_dbg()
      ASoC: atmel_ssc_dai: use devm_snd_soc_register_component()
      ASoC: bcm: use devm_snd_soc_register_component()
      ASoC: hdac_hda: use devm_snd_soc_register_component()
      ASoC: rt5668: use devm_snd_soc_register_component()
      ASoC: tscs454: use devm_snd_soc_register_component()
      ASoC: nuc900: use devm_snd_soc_register_component()
      ASoC: omap: use devm_snd_soc_register_component()
      ASoC: sh: use devm_snd_soc_register_component()
      ASoC: txx9: use devm_snd_soc_register_component()
      ASoC: rt5668: remove empty rt5668_i2c_remove()
      ASoC: soc-core: avoid nested code on soc_remove_dai()
      ASoC: soc-core: remove unused num_dai_links
      ASoC: soc-core: remove dai->driver NULL check
      ASoC: soc-core: manage platform name under snd_soc_init_platform()
      ASoC: soc-core: add snd_soc_is_matching_component()
      ASoC: convert for_each_rtd_codec_dai() for missing part
      ASoC: rename for_each_rtd_codec_dai_reverse to rollback
      ASoC: add for_each_card_prelinks() macro
      ASoC: add for_each_card_links() macro
      ASoC: add for_each_card_rtds() macro
      ASoC: add for_each_card_components() macro
      ASoC: add for_each_comp_order() macro
      ASoC: add for_each_dpcm_fe() macro
      ASoC: add for_each_dpcm_be() macro
      ASoC: tidyup for_each_card_prelinks() dai_link
      ASoC: add for_each_component() macro
      ASoC: add for_each_component_dais() macro
      ASoC: rsnd: use 32bit TDM width as default
      ASoC: audio-graph-card: enable mclk-fs on codec node
      ASoC: pcm3168a: add HW constraint for non RIGHT_J
      ASoC: pcm3168a: add hw constraint for channel
      ASoC: pcm3168a: add I2S/Left_J TDM support
      ASoC: pcm3168a: add hw constraint for capture channel
      ASoC: rsnd: enable TDM settings for SSI parent
      ASoC: rsnd: tidyup SSICR::SWSP for TDM

Linus Walleij (1):
      ASoC: rt5677-spi: Drop unused GPIO include

Lucas Tanure (1):
      ASoC: wm2000: Remove wm2000_read helper function

Mac Chiang (2):
      ASoC: Intel: Boards: Add KBL Dialog Maxim I2S machine driver
      ASoC: Intel: common: Add Kabylake Dialog+Maxim machine driver entry

Marcel Ziswiler (2):
      ASoC: tegra_sgtl5000: fix device_node refcounting
      ASoC: soc-core: fix trivial checkpatch issues

Marco Felsch (2):
      ASoC: dt-bindings: max98088: add external clock binding
      ASoC: max98988: make it selectable

Marcus Cooper (1):
      ASoC: sun4i-i2s: Add compatibility with A64 codec I2S

Mark Brown (10):
      Merge tag 'v4.19-rc1' into asoc-4.19
      Merge tag 'hda-codec-h-move' into asoc-4.20
      Merge branch 'asoc-4.19' into asoc-4.20 tas dependency
      Merge branch 'asoc-4.19' into asoc-4.20 for rcar dep
      Merge branch 'asoc-4.19' into asoc-4.20 Cirrus conflict
      ALSA: hda: Fix implicit definition of pci_iomap() on SH
      Merge branch 'asoc-4.19' into asoc-4.20 for rt5682 deps.
      Merge remote-tracking branch 'asoc/for-4.19' into asoc-4.20
      Merge branch 'asoc-4.19' into asoc-linus
      Merge branch 'asoc-4.20' into asoc-next

Matt Flax (4):
      ASoC: cs4265: SOC_SINGLE register value error fix
      ASoC: cs4265: Add native 32bit I2S transport
      ASoC: cs4265: Add a S/PDIF enable switch
      ASoC: cs4265: Add a MIC pre. route

Matthias Kaehlcke (1):
      ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops

Oder Chiou (2):
      ASoC: rt5514-spi: Get the period_bytes in the copy work to make sure =
the value correctly
      ASoC: rt5663: Remove the boost volume in the beginning of playback

Olivier Moysan (5):
      ASoC: dt-bindings: add mclk provider support to stm32 sai
      ASoC: dt-bindings: add mclk support to cs42l51
      ASoC: stm32: sai: set sai as mclk clock provider
      ASoC: cs42l51: add mclk support
      ASoC: cs42l51: fix mclk support

Peter Rosin (1):
      ASoC: atmel: tse850: switch to SPDX license identifier

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Add support for FIFO usage caused delay reporting

Pierre-Louis Bossart (3):
      ALSA: hda: move hda_codec.h to include/sound
      ASoC: Intel: common: add table for HDA-based platforms
      ALSA: hda: move hda_codec.h to include/sound

Rakesh Ughreja (5):
      ASoC: Intel: Boards: Machine driver for SKL+ w/ HDAudio codecs
      ASoC: Intel: Skylake: use HDAudio if ACPI enumeration fails
      ASoC: Intel: Skylake: add HDA BE DAIs
      ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
      ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers

Randy Dunlap (1):
      ASoC: fix soc-core.c kernel-doc warning

Richard Fitzgerald (2):
      ASoC: wm_adsp: Rename memory fields in wm_adsp_buffer
      ASoC: wm_adsp: Log addresses as 8 digits in wm_adsp_buffer_populate

Rob Herring (1):
      ASoC: Convert to using %pOFn instead of device_node.name

Robert Jarzmik (1):
      ASoC: pxa: switch to new ac97 bus support

Robert Rosengren (1):
      ASoC: adau17x1: Unused exported functions changed to internal

Rohit kumar (2):
      ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()
      ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines

Ryan Lee (4):
      ASoC: max98373: Sort Digital Volume in reverse order
      ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse order
      ASoC: max98373: Sort max98373_bde_gain_tlv in reverse order
      ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order

Shuming Fan (6):
      ASoC: rt5682: Update calibration function
      ASoC: rt5682: Improve HP performance
      ASoC: rt5682: Remove HP volume control
      ASoC: rt5682: Update calibration function
      ASoC: rt5682: Fix the boost volume at the begining of playback
      ASoC: rt5682: Minor code modification

Srinivas Kandagatla (1):
      ASoC: core: add support to card rebind

Takashi Iwai (6):
      ASoC: intel: skylake: Add missing break in skl_tplg_get_token()
      ASoC: adau1761: Use the standard fall-through annotation
      ASoC: pcm186x: Use the standard fall-through annotation
      ASoC: rt274: Add fall-through annotations
      ASoC: intel: skylake: Add fall-through annotation
      ASoC: topology: Use the standard fall-through annotations

Tzung-Bi Shih (1):
      ASoC: ts3a227e: fix a typo in documentation

Vasily Khoruzhick (6):
      ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
      ASoC: sun8i-codec-analog: split regmap code into separate driver
      ASoC: dt-binding: Add bindings for Allwinner A64 codec's analog path =
controls
      ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path con=
trols
      ASoC: sunxi: allow the sun8i-codec driver to be built on ARM64
      ASoC: sun4i-i2s: move code from startup/shutdown hooks into pm_runtim=
e hooks

Yong Zhi (1):
      ASoC: Intel: hdac_hdmi: Limit sampling rates at dai creation

YueHaibing (2):
      ASoC: qdsp6: q6asm-dai: remove duplicated include from q6asm-dai.c
      ASoC: qcom: qdsp6: remove duplicated include

zhong jiang (5):
      ASoC: q6core: Use kmemdup to replace kzalloc + memcpy
      ASoC: skl-topology: Use kmemdup to replace kzalloc + memcpy
      ASoC: remove unneeded static set .owner field in platform_driver
      ASoC: remove redundant include
      ASoC: qcom: qdsp6: remove duplicated include from q6adm.c

 .../devicetree/bindings/sound/adi,adau1977.txt     |   54 +
 .../devicetree/bindings/sound/amlogic,axg-pdm.txt  |   24 +
 .../devicetree/bindings/sound/cs42l51.txt          |   17 +
 .../devicetree/bindings/sound/maxim,max98088.txt   |   23 +
 .../bindings/sound/mikroe,mikroe-proto.txt         |   23 +
 .../devicetree/bindings/sound/nau8822.txt          |   16 +
 .../devicetree/bindings/sound/pcm3060.txt          |   17 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |   18 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    5 +-
 .../devicetree/bindings/sound/st,sta32x.txt        |    9 +
 .../devicetree/bindings/sound/st,stm32-sai.txt     |    7 +
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    2 +
 .../bindings/sound/sun50i-codec-analog.txt         |   12 +
 .../devicetree/bindings/sound/ts3a227e.txt         |    2 +-
 Documentation/devicetree/bindings/sound/wm8782.txt |   17 +
 .../devicetree/bindings/trivial-devices.txt        |    1 -
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    7 +
 {sound/pci/hda =3D> include/sound}/hda_codec.h       |    0
 include/sound/simple_card_utils.h                  |   27 +-
 include/sound/soc-acpi-intel-match.h               |    6 +
 include/sound/soc-dapm.h                           |    9 -
 include/sound/soc-dpcm.h                           |   10 +
 include/sound/soc.h                                |   45 +-
 sound/arm/Kconfig                                  |    1 -
 sound/pci/hda/hda_auto_parser.c                    |    2 +-
 sound/pci/hda/hda_beep.h                           |    2 +-
 sound/pci/hda/hda_bind.c                           |   14 +-
 sound/pci/hda/hda_codec.c                          |    2 +-
 sound/pci/hda/hda_controller.h                     |    2 +-
 sound/pci/hda/hda_eld.c                            |    2 +-
 sound/pci/hda/hda_generic.c                        |    2 +-
 sound/pci/hda/hda_hwdep.c                          |    2 +-
 sound/pci/hda/hda_intel.c                          |    2 +-
 sound/pci/hda/hda_jack.c                           |    2 +-
 sound/pci/hda/hda_proc.c                           |    2 +-
 sound/pci/hda/hda_sysfs.c                          |    2 +-
 sound/pci/hda/hda_tegra.c                          |    2 +-
 sound/pci/hda/patch_analog.c                       |    2 +-
 sound/pci/hda/patch_ca0110.c                       |    2 +-
 sound/pci/hda/patch_ca0132.c                       |    3 +-
 sound/pci/hda/patch_cirrus.c                       |    2 +-
 sound/pci/hda/patch_cmedia.c                       |    2 +-
 sound/pci/hda/patch_conexant.c                     |    2 +-
 sound/pci/hda/patch_hdmi.c                         |    2 +-
 sound/pci/hda/patch_realtek.c                      |    2 +-
 sound/pci/hda/patch_si3054.c                       |    2 +-
 sound/pci/hda/patch_sigmatel.c                     |    2 +-
 sound/pci/hda/patch_via.c                          |    2 +-
 sound/soc/amd/acp-da7219-max98357a.c               |   77 +-
 sound/soc/amd/acp-pcm-dma.c                        |   30 +-
 sound/soc/amd/acp.h                                |    3 +-
 sound/soc/atmel/Kconfig                            |   12 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel_ssc_dai.c                    |   13 +-
 sound/soc/atmel/mikroe-proto.c                     |  165 +++
 sound/soc/atmel/tse850-pcm5142.c                   |   78 +-
 sound/soc/bcm/cygnus-ssp.c                         |   13 +-
 sound/soc/codecs/Kconfig                           |   36 +-
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/adau1761.c                        |    3 +-
 sound/soc/codecs/adau17x1.c                        |   86 +-
 sound/soc/codecs/adau17x1.h                        |    4 -
 sound/soc/codecs/cs4265.c                          |   12 +-
 sound/soc/codecs/cs42l51.c                         |   21 +
 sound/soc/codecs/dmic.c                            |    1 +
 sound/soc/codecs/es8328.c                          |    4 +-
 sound/soc/codecs/hdac_hda.c                        |  483 +++++++++
 sound/soc/codecs/hdac_hda.h                        |   24 +
 sound/soc/codecs/hdac_hdmi.c                       |   11 +-
 sound/soc/codecs/max98088.c                        |   36 +
 sound/soc/codecs/max98373.c                        |   47 +-
 sound/soc/codecs/nau8822.c                         | 1136 ++++++++++++++++=
++++
 sound/soc/codecs/nau8822.h                         |  204 ++++
 sound/soc/codecs/pcm186x.c                         |    3 +-
 sound/soc/codecs/pcm3060-i2c.c                     |   60 ++
 sound/soc/codecs/pcm3060-spi.c                     |   59 +
 sound/soc/codecs/pcm3060.c                         |  295 +++++
 sound/soc/codecs/pcm3060.h                         |   88 ++
 sound/soc/codecs/pcm3168a.c                        |   82 ++
 sound/soc/codecs/rt274.c                           |    2 +
 sound/soc/codecs/rt5514-spi.c                      |   14 +-
 sound/soc/codecs/rt5651.c                          |    1 -
 sound/soc/codecs/rt5663.c                          |    7 +-
 sound/soc/codecs/rt5668.c                          |   10 +-
 sound/soc/codecs/rt5670.c                          |   12 +
 sound/soc/codecs/rt5677-spi.c                      |    1 -
 sound/soc/codecs/rt5682.c                          |   86 +-
 sound/soc/codecs/rt5682.h                          |   14 +
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/sta32x.c                          |   30 +
 sound/soc/codecs/tas5720.c                         |  103 +-
 sound/soc/codecs/tas6424.c                         |   58 +-
 sound/soc/codecs/tas6424.h                         |   10 +
 sound/soc/codecs/tlv320aic31xx.c                   |   85 ++
 sound/soc/codecs/tlv320aic31xx.h                   |   23 +
 sound/soc/codecs/tscs454.c                         |    2 +-
 sound/soc/codecs/wm2000.c                          |   54 +-
 sound/soc/codecs/wm8782.c                          |   63 ++
 sound/soc/codecs/wm8904.c                          |    1 -
 sound/soc/codecs/wm8974.c                          |    1 -
 sound/soc/codecs/wm9712.c                          |    3 +-
 sound/soc/codecs/wm_adsp.c                         |   26 +-
 sound/soc/davinci/davinci-mcasp.c                  |   37 +
 sound/soc/fsl/fsl_asrc_dma.c                       |    2 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_utils.c                          |    4 +-
 sound/soc/fsl/pcm030-audio-fabric.c                |    5 +-
 sound/soc/generic/audio-graph-card.c               |   21 +-
 sound/soc/generic/audio-graph-scu-card.c           |   55 +-
 sound/soc/generic/simple-card-utils.c              |   53 +-
 sound/soc/generic/simple-card.c                    |   30 +-
 sound/soc/generic/simple-scu-card.c                |   54 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    4 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    4 +-
 sound/soc/intel/boards/Kconfig                     |   22 +
 sound/soc/intel/boards/Makefile                    |    4 +
 sound/soc/intel/boards/broadwell.c                 |    4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    4 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    9 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c       |  983 +++++++++++++++++
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    5 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    5 +-
 sound/soc/intel/boards/skl_hda_dsp_common.c        |  127 +++
 sound/soc/intel/boards/skl_hda_dsp_common.h        |   38 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |  183 ++++
 sound/soc/intel/common/Makefile                    |    3 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |    7 +
 sound/soc/intel/common/soc-acpi-intel-hda-match.c  |   40 +
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   13 +
 sound/soc/intel/common/sst-firmware.c              |    2 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   71 +-
 sound/soc/intel/skylake/skl-topology.c             |    4 +-
 sound/soc/intel/skylake/skl.c                      |   96 +-
 sound/soc/intel/skylake/skl.h                      |   12 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |   13 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |   14 +-
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          |   14 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   13 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |   12 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   12 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   12 +-
 sound/soc/meson/Kconfig                            |   13 +
 sound/soc/meson/Makefile                           |    2 +
 sound/soc/meson/axg-card.c                         |   16 +-
 sound/soc/meson/axg-fifo.c                         |    2 +
 sound/soc/meson/axg-pdm.c                          |  654 +++++++++++
 sound/soc/meson/axg-tdm-interface.c                |   50 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    4 +-
 sound/soc/omap/omap-hdmi-audio.c                   |    4 +-
 sound/soc/pxa/Kconfig                              |   13 +-
 sound/soc/pxa/pxa-ssp.c                            |    6 +
 sound/soc/pxa/pxa2xx-ac97.c                        |   48 +-
 sound/soc/qcom/apq8096.c                           |    7 +-
 sound/soc/qcom/qdsp6/q6adm.c                       |   17 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |    8 +-
 sound/soc/qcom/qdsp6/q6asm.c                       |    1 -
 sound/soc/qcom/qdsp6/q6core.c                      |    9 +-
 sound/soc/qcom/sdm845.c                            |    7 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c            |    1 -
 sound/soc/rockchip/rockchip_pcm.c                  |    3 +-
 sound/soc/samsung/tm2_wm5110.c                     |   13 +-
 sound/soc/sh/hac.c                                 |    3 +-
 sound/soc/sh/rcar/adg.c                            |    4 +-
 sound/soc/sh/rcar/core.c                           |  124 ++-
 sound/soc/sh/rcar/ctu.c                            |    2 +-
 sound/soc/sh/rcar/dma.c                            |  109 +-
 sound/soc/sh/rcar/gen.c                            |   33 +-
 sound/soc/sh/rcar/rsnd.h                           |   63 +-
 sound/soc/sh/rcar/src.c                            |    2 +-
 sound/soc/sh/rcar/ssi.c                            |  112 +-
 sound/soc/sh/rcar/ssiu.c                           |   92 +-
 sound/soc/soc-compress.c                           |    4 +-
 sound/soc/soc-core.c                               |  582 +++++-----
 sound/soc/soc-dapm.c                               |  437 ++++----
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-pcm.c                                |  253 +++--
 sound/soc/soc-topology.c                           |   15 +-
 sound/soc/soc-utils.c                              |    4 +-
 sound/soc/stm/stm32_sai.c                          |    2 +-
 sound/soc/stm/stm32_sai.h                          |    3 +
 sound/soc/stm/stm32_sai_sub.c                      |  282 ++++-
 sound/soc/sunxi/Kconfig                            |   17 +-
 sound/soc/sunxi/Makefile                           |    2 +
 sound/soc/sunxi/sun4i-i2s.c                        |   82 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |  444 ++++++++
 sound/soc/sunxi/sun8i-adda-pr-regmap.c             |  102 ++
 sound/soc/sunxi/sun8i-adda-pr-regmap.h             |    7 +
 sound/soc/sunxi/sun8i-codec-analog.c               |   79 +-
 sound/soc/sunxi/sun8i-codec.c                      |   22 +-
 sound/soc/tegra/tegra_sgtl5000.c                   |   17 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    3 +-
 193 files changed, 8358 insertions(+), 1542 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-p=
roto.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nau8822.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm3060.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-an=
alog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt
 rename {sound/pci/hda =3D> include/sound}/hda_codec.h (100%)
 create mode 100644 sound/soc/atmel/mikroe-proto.c
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h
 create mode 100644 sound/soc/codecs/nau8822.c
 create mode 100644 sound/soc/codecs/nau8822.h
 create mode 100644 sound/soc/codecs/pcm3060-i2c.c
 create mode 100644 sound/soc/codecs/pcm3060-spi.c
 create mode 100644 sound/soc/codecs/pcm3060.c
 create mode 100644 sound/soc/codecs/pcm3060.h
 create mode 100644 sound/soc/intel/boards/kbl_da7219_max98927.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
 create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-hda-match.c
 create mode 100644 sound/soc/meson/axg-pdm.c
 create mode 100644 sound/soc/sunxi/sun50i-codec-analog.c
 create mode 100644 sound/soc/sunxi/sun8i-adda-pr-regmap.c
 create mode 100644 sound/soc/sunxi/sun8i-adda-pr-regmap.h

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvNubUACgkQJNaLcl1U
h9BIFwf7BGKPOqqsPnDk6RfzbR5NwB6ovSLoWtjqkAGTEWyN2obC3Lu7v3SDZ7Ny
8b6ekjQe2FwsseSiYkmBVQUg6C16aZ0uwuWWusjrnyz4Alti9oN4PzFfZTIwODEU
qmFxDvuZQsEFQpWH9jZ6gUiHvsdvRM9/7DWgIgYo3fu4lejwCeLg5qWicX2grLua
wBcJn51I6mQcdcaRD6EqCH9op80cHenRyWnwnnScFu+KZls68u8s26PGPlLFzUO0
m5neUzy3sv7a24oFn67Yic8BST/v5dwKlYvlYWBT+9m1FbsZCDEUiDsi17h65tgA
A9gRlyP1zhu17hn/+fVuk5Taa+ZImw==
=pb0B
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============3865079123674528367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3865079123674528367==--
