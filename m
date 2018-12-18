From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.21
Date: Tue, 18 Dec 2018 12:50:24 +0000
Message-ID: <20181218125024.GA6537@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2567934612587976135=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B992677E4
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:50:26 +0100 (CET)
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


--===============2567934612587976135==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.21

for you to fetch changes up to a7a850dba82498a1e050d8d153cae67ce0edb3b2:

  Merge branch 'asoc-4.21' into asoc-next (2018-12-18 12:23:59 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.21

Not much work on the core this time around but we've seen quite a bit of
driver work, including on the generic DT drivers.  There's also a large
part of the diff from a merge of the DaVinci and OMAP directories, along
with some active development there:

 - Preparatory work from Morimoto-san for merging the audio-graph and
   audio-graph-scu cards.
 - A merge of the TI OMAP and DaVinci directories, the OMAP product line
   has been merged into the DaVinci product line so there is now a lot
   of IP sharing which meant that the split directories just got in the
   way.  This has pulled in a few architecture changes as well.
 - A big cleanup of the Maxim MAX9867 driver from Ladislav Michl.
 - Support for Asahi Kaesi AKM4118, AMD ACP3x, Intel platforms with
   RT5660, Meson AXG S/PDIF inputs, several Qualcomm IPs and Xilinx I2S
   controllers.

----------------------------------------------------------------
Adrien Charruel (1):
      ASoC: ak4118: Add support for AK4118 S/PDIF transceiver

Arnd Bergmann (5):
      ASoC: wm97xx: fix uninitialized regmap pointer problem
      ASoC: Intel: mrfld: fix uninitialized variable access
      ASoC: pxa: change ac97 dependencies
      ASoC: sdm845: add rt5663 codec select
      ASoC: simple-card-utils: fix build warning without CONFIG_OF

Axel Lin (1):
      ASoC: ak5558: Remove redundant snd_soc_component_read32 calls

Bard liao (2):
      ASoC: Intel: common: add SOF information for APL RVP
      ASoC: Intel: hdac_hdmi: add Icelake support

Chen-Yu Tsai (2):
      ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator s=
upply
      ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator sup=
ply

Cheng-Yi Chiang (7):
      ASoC: rt5663: Add regulator support
      ASoC: rt5663: Add documentation for power supply support
      ASoC: rt5663: Fix error handling of regulator_set_load
      ASoC: qcom: sdm845: Add board specific dapm widgets
      ASoC: qcom: sdm845: Create and setup jack in init callback
      ASoC: sdm845: Add TDM configuration for speaker
      ASoC: sdm845: Add configuration for headset codec

Cl=E9ment P=E9ron (1):
      ASoC: dt-bindings: add bindings for AK4118 transceiver

Colin Ian King (7):
      ASoC: stm32: sai: fix less than zero comparison on unsigned int
      ASoC: amd: fix memory leak of i2s_data on error return
      ASoC: tlv320aic31xx: asihpi: clean up indentation, remove extraneous =
tab
      ASoC: tlv320dac33: clean up indentation, remove extraneous tab
      ASoC: arizona: fix indentation issue with return statement
      ASoC: qcom: clean up indentation, remove extraneous tab
      ASoC: amd: fix spelling mistake "Inavlid" -> "Invalid"

Dan Carpenter (1):
      ASoC: amd: Fix a NULL vs IS_ERR() check in probe

Daniel Mack (5):
      ASoC: pxa: remove raumfeld machine driver
      ASoC: dt-bindings: cs4270: use 'reset-gpios' rather than 'reset-gpio'
      ASoC: codecs: cs4270: move to GPIO consumer API
      ASoC: dt-bindings: ak4104: use 'reset-gpios' rather than 'reset-gpio'
      ASoC: codecs: ak4104: move to GPIO consumer API

David Lin (2):
      ASoC: nau8822: convert to SPDX identifiers
      ASoC: nau8822: convert to SPDX identifiers

Dimitris Papavasiliou (1):
      ASoC: pcm512x: Implement the digital_mute interface

Fabio Estevam (2):
      ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
      ASoC: fsl-sai: Fix typo in "transmitter"

Fabrizio Castro (1):
      ASoC: rsnd: Add r8a774c0 support

Hans de Goede (4):
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Clapper
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Gnawty
      ASoC: Intel: bytcr_rt5640: Add quirk for the Prowise PT301 tablet
      ASoC: Intel: bytcr_rt5640: Add quirk for the Point of View Mobii TAB-=
P1005W-232

Hiroyuki Yokoyama (1):
      ASoC: rsnd: Add device tree support for r8a77995

Hui Wang (2):
      ASoC: rt5660: Add a new ACPI match ID
      ASoC: Intel: kbl_rt5660: Add a new machine driver for kbl with rt5660

Jenny TC (2):
      ASoC: dmic: introduce mode switch delay
      ASoC: dmic: introduce module_param wakeup_delay

Jerome Brunet (5):
      ASoC: meson: axg-toddr: add support for spdifin backend
      ASoC: meson: add axg spdif input DT binding documentation
      ASoC: meson: add axg spdif input
      MAINTAINERS: Add Amlogic sound drivers entry
      ASoC: meson: fix do_div warning in spdifin

Jiada Wang (1):
      ASoC: pcm3168a: Don't disable pcm3168a when CONFIG_PM defined

Julia Lawall (4):
      ASoC: smd845: constify snd_soc_ops structure
      ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures
      ASoC: codecs: constify snd_soc_dai_ops structures
      ASoC: AMD: constify regulator_desc structure

Kirill Marinushkin (3):
      ASoC: pcm3060: Add DT property for single-ended output
      ASoC: Add documentation for pcm3060 property out-single-ended
      ASoC: pcm3060: Add powersaving widgets for DAC and ADC

Kuninori Morimoto (65):
      ASoC: pcm3168a: cleanup hw_constraint for LEFT_J/I2S
      ASoC: rsnd: move .get_status under rsnd_mod_ops
      ASoC: rsnd: add .get_id/.get_id_sub
      ASoC: rsnd: rsnd_mod_name() handles both name and ID
      ASoC: pcm3168a: remove read-only status register from snd_kcontrol_new
      ASoC: audio-graph-card: remove endpoint bidirectional check
      ASoC: audio-graph-scu-card: remove endpoint bidirectional check
      ASoC: audio-graph-scu-card: remove error check which never happen
      ASoC: rsnd: remove endpoint bidirectional check
      ASoC: rsnd: rename rsnd_runtime_is_ssi_xxx()
      ASoC: rsnd: use defined io_playback/io_capture
      ASoC: rsnd: move HDMI information from ssi.c to core.c
      ASoC: rsnd: handle DPCM converted rate/chan under core
      ASoC: rsnd: tidyup Document for DT binding
      ASoC: rsnd: add SSIU BUSIF support for Document
      ASoC: rsnd: add SSIU BUSIF support
      ASoC: rsnd: add TDM Split mode support for Document
      ASoC: rsnd: add TDM Split mode support
      ASoC: rsnd: use ring buffer for rsnd_mod_name()
      ASoC: rsnd: tidyup rsnd_parse_connect_ssiu_compatible()
      ASoC: rsnd: makes rsnd_ssi_is_dma_mode() static
      ASoC: simple-card-utils: remove asoc_simple_card_clk_register()
      ASoC: simple-card-utils: accept NULL parameter on asoc_simple_card_xx=
x()
      ASoC: simple-card-utils: tidyup asoc_simple_card_parse_convert()
      ASoC: simple_card_utils: remove "option" from asoc_simple_card_of_par=
se_routing()
      ASoC: soc-core: add snd_soc_of_parse_node_prefix()
      ASoC: simple-scu-card: tidyup "prefix" parsing on Doc
      ASoC: simple-scu-card: tidyup "prefix" parsing
      ASoC: audio-graph-scu-card: tidyup "prefix" parsing on Doc
      ASoC: audio-graph-scu-card: tidyup "prefix" parsing
      ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing on=
 Doc
      ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing
      ASoC: audio-graph-scu-card: tidyup asoc_simple_card_parse_daifmt() ti=
ming
      ASoC: audio-graph-card: tidyup typo SND_AUDIO_GRAPH_CARD
      ASoC: audio-graph-card: tidyup define position
      ASoC: rsnd: tidyup for SSIU subnode
      ASoC: soc.h: makes snd_soc_of_parse_audio_prefix() inline
      ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()
      ASoC: rsnd: indicates Channel and Mode for debug
      ASoC: rsnd: fixup mod ID for CTU regmap read/write
      ASoC: rsnd: add missing TDM Split mode support for simple-card
      ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting
      ASoC: audio-graph-scu-card: care link / dai count
      ASoC: audio-graph-scu-card: use cpu/codec pointer on graph_dai_props
      ASoC: audio-graph-scu-card: care multi DPCM codec_conf
      ASoC: audio-graph-card: use cpu/codec pointer on graph_dai_props
      ASoC: simple-card: use cpu/codec pointer on simple_dai_props
      ASoC: simple-scu-card: tidyup asoc_simple_card_parse_daifmt() timing
      ASoC: simple-scu-card: add dai-link support
      ASoC: simple-scu-card: care link / dai count
      ASoC: simple-scu-card: tidyup "convert-rate/channels" parsing
      ASoC: simple-scu-card: use cpu/codec pointer on graph_dai_props
      ASoC: simple-scu-card: care multi DPCM codec_conf
      ASoC: rsnd: remove RSND_REG_ from rsnd_reg
      ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() ID method
      ASoC: audio-graph-card: merge audio-graph-scu-card on Doc
      ASoC: audio-graph-card: merge audio-graph-scu-card
      ASoC: audio-graph-card: tidyup mclk-fs method
      ASoC: audio-graph-card: tidyup convert_rate/channel method
      ASoC: audio-graph-card: tidyup prefix for snd_soc_codec_conf
      ASoC: simple-card: merge simple-scu-card on Doc
      ASoC: simple-card: merge simple-scu-card
      ASoC: simple-card: tidyup mclk-fs method
      ASoC: simple-card: tidyup convert_rate/channel method
      ASoC: simple-card: tidyup prefix for snd_soc_codec_conf

Ladislav Michl (6):
      ASoC: max9867: Fix whitespace
      ASoC: max9867: Remove useless assignment
      ASoC: max9867: Fix power management
      ASoC: max9867: Calculate LRCLK divider
      ASoC: max9867: Fix signal paths
      ASoC: max9867: Add copyright and module author

Lubomir Rintel (1):
      ASoC: dt-bindings: use a generic node name for rt5631

Mark Brown (3):
      Merge branch 'for-4.20' of https://git.kernel.org/.../broonie/sound i=
nto asoc-4.21 intel dep
      Merge branch 'asoc-4.20' into asoc-linus
      Merge branch 'asoc-4.21' into asoc-next

Maruthi Srinivas Bayyavarapu (5):
      ASoC: AMD: add ACP 3.x IP register header
      ASoC: AMD: add ACP3.0 PCI driver
      dt-bindings: ASoC: xlnx, i2s: Document i2s bindings
      ASoC: xlnx: Add i2s driver
      ASoC: xlnx: enable i2s driver build

Nathan Chancellor (1):
      ASoC: simple-card: Dereference pointer for memcpy sizeof in asoc_simp=
le_card_probe

Peter Ujfalusi (25):
      ASoC: omap-mcbsp: On OMAP1 and OMAP2420 only 16bit format is supported
      ASoC: omap: Remove unused machine driver for AM3517-evm
      ASoC: omap-mcbsp: Clean up dma_data addr initialization code
      ASoC: omap-mcbsp: Skip dma_data.maxburst initialization
      ASoC: omap-mcbsp: Clean up the interrupt handlers
      ASoC: omap-mcbsp: Simplify the mcbsp_start/_stop function parameters
      ASoC: omap-mcbsp: Move out the FIFO check from set_threshold and get_=
delay
      ASoC: omap-mcbsp: Re-arrange files for core McBSP and Sidetone functi=
on split
      ASoC: omap-mcbsp: Remove redundant check for mcbsp->pdata
      ASoC: omap-mcbsp: No need to initialize max_xx_thres when it is not u=
sed
      ASoC: tlv320aic3x: Add support for CBM_CFS and CBS_CFM clocking modes
      ASoC: davinci-mcasp: Clear TXSTAT register before activating serializ=
ers
      ASoC: davinci-mcasp: Update PDIR (pin direction) register handling
      ASoC: davinci-mcasp: Document dismod optional property
      ASoC: davinci-mcasp: Implement configurable dismod handling
      dt-bindings: sound: omap-mcpdm: Update documentation for pdmclk
      ASoC: ti: Merge davinci and omap directories
      MAINTAINERS: Add entry for sound/soc/ti and update the OMAP audio sup=
port
      ARM: OMAP1: Makefile: Update for new MCBSP Kconfig option
      ARM: OMAP2: Update for new MCBSP Kconfig option
      ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig options
      ARM: omap2plus_defconfig: Update the audio options
      ARM: omap1_defconfig: Do not select ASoC by default
      ARM: davinci_all_defconfig: Update the audio options
      ASoC: ti: Kconfig: Remove the deprecated options

Pierre-Louis Bossart (14):
      ASoC: acpi: define common interface for machine driver configuration
      ASoC: Intel: use standard interface for Hdaudio machine driver
      ASoC: Intel: use standard interface for Atom machine drivers
      ASoC: Intel: boards: fix Skylake typo
      ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL
      ASoC: Intel: common: add quirk for APL RVP boards
      ASoC: Intel: fix interface for Chromebook machine drivers
      ASoC: Intel: use platform_data for machine drivers
      ASoC: Intel: common: add ACPI matching tables for ICL
      ASoC: Intel: Skylake: Harden DSP detection with PCI class/subclass in=
fo
      ASoC: Intel: Skylake: stop probe if HDaudio capabilities don't exist
      ASoC: Intel: Skylake: remove useless tests on HDaudio capabilities
      ASoC: Intel: Skylake: add error logs on probe, remove dependency on N=
HLT
      ASoC: Intel: Skylake: Add more platform granularity

Richard Fitzgerald (1):
      ASoC: wm_adsp: Factor out common init code

Rob Herring (2):
      ASoC: Convert a few more users to using %pOFn instead of device_node.=
name
      ASoC: Use of_node_name_eq for node name comparisons

Rohit kumar (7):
      ASoC: sdm845: Update slot_width for Quaternary TDM port
      ASoC: sdm845: Add support for Secondary MI2S interface
      ASoC: core: Invoke pcm_new() for all DAI-link
      ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding
      ASoC: qdsp6: qdafe: add support for display_port_rx
      ASoC: qdsp6: q6afe-dai: add support to Display port RX dais
      ASoC: qdsp6: q6routing: add display_port_rx port routing

Ryan Lee (1):
      ASoC: max98373: Added max98373_reset for stable amp reset

Srinivas Kandagatla (5):
      ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
      ALSA: compress: make use of runtime buffer for copy
      ASoC: q6asm-dai: dt-bindings: Add support to compress dais
      ASoC: qdsp6: q6asm: add support to MP3 format
      ASoC: qdsp6: q6asm-dai: Add support to compress offload

Subhransu S. Prusty (2):
      ASoC: Intel: Skylake: Make DSP replies more human readable
      ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

Takashi Iwai (1):
      ASoC: Intel: Skylake: Add CFL-S support

Vasily Khoruzhick (2):
      ASoC: dt-bindings: add regulator property to simple amplifier
      ASoC: simple-amplifier: add VCC regulator widget

Vijendar Mukunda (11):
      ASoC: amd: create ACP3x PCM platform device
      ASoC: amd: add ACP3x PCM platform driver
      ASoC: amd: Interrupt handler changes for ACP3x DMA driver
      ASoC: amd: add acp3x pcm driver dma ops
      ASoC: amd: add acp3x i2s ops
      ASoC: amd: add acp3x tdm mode support
      ASoC: amd: add acp3x runtime pm ops
      ASoC: amd: add acp3x system resume pm op
      ASoC: amd: enable acp3x drivers build
      ASoC: amd: Fixed build errors
      ASoC: amd: Switch to SPDX identifier

Wei Yongjun (1):
      ASoC: stm32: sai: fix invalid use of sizeof in stm32_sai_add_mclk_pro=
vider()

Yangtao Li (2):
      ASoC: nau8825: remove unnecessary unlikely()
      ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro

Young_X (1):
      ASoC: au8540: use 64-bit arithmetic instead of 32-bit

Yu Zhao (2):
      ASoC: use DMA addr rather than CPU pa for acp_audio_dma
      ASoC: use dma_ops of parent device for acp_audio_dma

YueHaibing (1):
      ASoC: amd: remove set but not used variable 'dma_buffer'

Zhuohao Lee (1):
      ASoC: Intel: kbl_da7219_max98927: fix the audio jack button remapping

 Documentation/devicetree/bindings/sound/ak4104.txt |    4 +-
 Documentation/devicetree/bindings/sound/ak4118.txt |   22 +
 .../bindings/sound/amlogic,axg-spdifin.txt         |   22 +
 .../devicetree/bindings/sound/audio-graph-card.txt |  205 ++++
 .../bindings/sound/audio-graph-scu-card.txt        |    4 +-
 Documentation/devicetree/bindings/sound/cs4270.txt |    4 +-
 .../bindings/sound/davinci-mcasp-audio.txt         |    5 +
 Documentation/devicetree/bindings/sound/dmic.txt   |    2 +
 .../devicetree/bindings/sound/fsl-sai.txt          |    8 +-
 .../devicetree/bindings/sound/omap-mcpdm.txt       |   10 +
 .../devicetree/bindings/sound/pcm3060.txt          |    6 +
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   27 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  395 ++++---
 Documentation/devicetree/bindings/sound/rt5631.txt |    4 +-
 Documentation/devicetree/bindings/sound/rt5663.txt |    6 +
 .../devicetree/bindings/sound/simple-amplifier.txt |    5 +
 .../devicetree/bindings/sound/simple-card.txt      |  137 +++
 .../devicetree/bindings/sound/simple-scu-card.txt  |    2 +-
 .../bindings/sound/sun50i-codec-analog.txt         |    2 +
 .../devicetree/bindings/sound/xlnx,i2s.txt         |   28 +
 MAINTAINERS                                        |   18 +-
 arch/arm/configs/davinci_all_defconfig             |    5 +-
 arch/arm/configs/omap1_defconfig                   |    2 -
 arch/arm/configs/omap2plus_defconfig               |   14 +-
 arch/arm/mach-davinci/board-dm365-evm.c            |    4 +-
 arch/arm/mach-omap1/Makefile                       |    2 +-
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |    4 +-
 include/dt-bindings/sound/qcom,q6afe.h             |    1 +
 include/linux/platform_data/davinci_asp.h          |    1 +
 include/sound/compress_driver.h                    |   19 +
 include/sound/simple_card_utils.h                  |    6 +-
 include/sound/soc-acpi-intel-match.h               |    1 +
 include/sound/soc-acpi.h                           |   15 +
 include/sound/soc.h                                |   14 +-
 sound/core/compress_offload.c                      |   18 +-
 sound/soc/Kconfig                                  |    4 +-
 sound/soc/Makefile                                 |    4 +-
 sound/soc/amd/Kconfig                              |    6 +
 sound/soc/amd/Makefile                             |    1 +
 sound/soc/amd/acp-da7219-max98357a.c               |    2 +-
 sound/soc/amd/acp-pcm-dma.c                        |   22 +-
 sound/soc/amd/acp.h                                |    2 +-
 sound/soc/amd/raven/Makefile                       |    6 +
 sound/soc/amd/raven/acp3x-pcm-dma.c                |  777 ++++++++++++++
 sound/soc/amd/raven/acp3x.h                        |   58 +
 sound/soc/amd/raven/chip_offset_byte.h             |  639 +++++++++++
 sound/soc/amd/raven/pci-acp3x.c                    |  156 +++
 sound/soc/codecs/Kconfig                           |    6 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ak4104.c                          |   22 +-
 sound/soc/codecs/ak4118.c                          |  438 ++++++++
 sound/soc/codecs/ak4458.c                          |    2 +-
 sound/soc/codecs/ak5558.c                          |   19 +-
 sound/soc/codecs/cs4270.c                          |   23 +-
 sound/soc/codecs/dmic.c                            |   40 +
 sound/soc/codecs/hdac_hda.c                        |    2 +-
 sound/soc/codecs/hdac_hdmi.c                       |   63 +-
 sound/soc/codecs/max98373.c                        |   35 +-
 sound/soc/codecs/max9867.c                         |  505 ++++-----
 sound/soc/codecs/max9867.h                         |   41 +-
 sound/soc/codecs/nau8540.c                         |    2 +-
 sound/soc/codecs/nau8822.c                         |   26 +-
 sound/soc/codecs/nau8822.h                         |    9 +-
 sound/soc/codecs/nau8825.c                         |    4 +-
 sound/soc/codecs/pcm3060.c                         |   28 +-
 sound/soc/codecs/pcm3060.h                         |    3 +
 sound/soc/codecs/pcm3168a.c                        |   40 +-
 sound/soc/codecs/pcm512x.c                         |  121 ++-
 sound/soc/codecs/pcm512x.h                         |    2 +
 sound/soc/codecs/rt5660.c                          |    1 +
 sound/soc/codecs/rt5663.c                          |   75 +-
 sound/soc/codecs/simple-amplifier.c                |    4 +
 sound/soc/codecs/tas6424.c                         |    2 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    2 +-
 sound/soc/codecs/tlv320aic3x.c                     |   10 +
 sound/soc/codecs/tlv320dac33.c                     |    2 +-
 sound/soc/codecs/wm8998.c                          |    2 +-
 sound/soc/codecs/wm9705.c                          |   10 +-
 sound/soc/codecs/wm9712.c                          |   10 +-
 sound/soc/codecs/wm9713.c                          |   10 +-
 sound/soc/codecs/wm_adsp.c                         |   14 +-
 sound/soc/davinci/Kconfig                          |  106 --
 sound/soc/davinci/Makefile                         |   16 -
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |    6 +-
 sound/soc/fsl/fsl_ssi_dbg.c                        |   14 +-
 sound/soc/generic/Kconfig                          |    4 +-
 sound/soc/generic/audio-graph-card.c               |  465 +++++++--
 sound/soc/generic/audio-graph-scu-card.c           |  262 +++--
 sound/soc/generic/simple-card-utils.c              |   45 +-
 sound/soc/generic/simple-card.c                    |  402 +++++--
 sound/soc/generic/simple-scu-card.c                |  264 +++--
 sound/soc/intel/Kconfig                            |   73 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |    4 +
 sound/soc/intel/atom/sst/sst_loader.c              |    8 +-
 sound/soc/intel/atom/sst/sst_pvt.c                 |    4 +-
 sound/soc/intel/boards/Kconfig                     |   26 +-
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/bytcr_rt5640.c              |   33 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    6 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   14 +
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    6 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |    2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c       |   14 +-
 sound/soc/intel/boards/kbl_rt5660.c                |  543 ++++++++++
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |   14 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   10 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |   22 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |   14 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |   14 +-
 sound/soc/intel/common/Makefile                    |    2 +-
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c  |   36 +
 sound/soc/intel/common/soc-acpi-intel-icl-match.c  |   32 +
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   10 +
 sound/soc/intel/skylake/skl-messages.c             |    8 +
 sound/soc/intel/skylake/skl-nhlt.c                 |    3 +
 sound/soc/intel/skylake/skl-sst-ipc.c              |   50 +-
 sound/soc/intel/skylake/skl.c                      |  144 ++-
 sound/soc/intel/skylake/skl.h                      |    3 -
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    2 +-
 sound/soc/meson/Kconfig                            |    9 +-
 sound/soc/meson/Makefile                           |    2 +
 sound/soc/meson/axg-fifo.h                         |    3 +-
 sound/soc/meson/axg-spdifin.c                      |  521 +++++++++
 sound/soc/meson/axg-toddr.c                        |   15 +-
 sound/soc/omap/Kconfig                             |  129 ---
 sound/soc/omap/Makefile                            |   32 -
 sound/soc/omap/am3517evm.c                         |  141 ---
 sound/soc/omap/mcbsp.c                             | 1104 ----------------=
----
 sound/soc/pxa/Kconfig                              |   26 +-
 sound/soc/pxa/Makefile                             |    1 -
 sound/soc/pxa/raumfeld.c                           |  318 ------
 sound/soc/qcom/Kconfig                             |    2 +
 sound/soc/qcom/lpass-platform.c                    |    2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |   30 +-
 sound/soc/qcom/qdsp6/q6afe.c                       |    4 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  372 ++++++-
 sound/soc/qcom/qdsp6/q6asm.c                       |    5 +
 sound/soc/qcom/qdsp6/q6routing.c                   |    9 +
 sound/soc/qcom/sdm845.c                            |  186 +++-
 sound/soc/sh/rcar/adg.c                            |   38 +-
 sound/soc/sh/rcar/cmd.c                            |   11 +-
 sound/soc/sh/rcar/core.c                           |  256 ++++-
 sound/soc/sh/rcar/ctu.c                            |  138 +--
 sound/soc/sh/rcar/dma.c                            |   84 +-
 sound/soc/sh/rcar/dvc.c                            |   21 +-
 sound/soc/sh/rcar/gen.c                            |   49 +-
 sound/soc/sh/rcar/mix.c                            |    3 +-
 sound/soc/sh/rcar/rsnd.h                           |  382 +++----
 sound/soc/sh/rcar/src.c                            |   67 +-
 sound/soc/sh/rcar/ssi.c                            |  269 ++---
 sound/soc/sh/rcar/ssiu.c                           |  300 ++++--
 sound/soc/soc-core.c                               |   13 +-
 sound/soc/stm/stm32_sai.c                          |    8 +-
 sound/soc/stm/stm32_sai_sub.c                      |    3 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |    2 +
 sound/soc/ti/Kconfig                               |  209 ++++
 sound/soc/ti/Makefile                              |   44 +
 sound/soc/{omap =3D> ti}/ams-delta.c                 |    0
 sound/soc/{davinci =3D> ti}/davinci-evm.c            |    4 +-
 sound/soc/{davinci =3D> ti}/davinci-i2s.c            |    0
 sound/soc/{davinci =3D> ti}/davinci-i2s.h            |    0
 sound/soc/{davinci =3D> ti}/davinci-mcasp.c          |  123 ++-
 sound/soc/{davinci =3D> ti}/davinci-mcasp.h          |   30 +-
 sound/soc/{davinci =3D> ti}/davinci-vcif.c           |    0
 sound/soc/{davinci =3D> ti}/edma-pcm.c               |    0
 sound/soc/{davinci =3D> ti}/edma-pcm.h               |    4 +-
 sound/soc/{omap =3D> ti}/n810.c                      |    0
 sound/soc/{omap =3D> ti}/omap-abe-twl6040.c          |    0
 sound/soc/{omap =3D> ti}/omap-dmic.c                 |    0
 sound/soc/{omap =3D> ti}/omap-dmic.h                 |    0
 .../soc/{omap/omap-hdmi-audio.c =3D> ti/omap-hdmi.c} |    0
 sound/soc/{omap/mcbsp.h =3D> ti/omap-mcbsp-priv.h}   |  126 +--
 sound/soc/ti/omap-mcbsp-st.c                       |  516 +++++++++
 sound/soc/{omap =3D> ti}/omap-mcbsp.c                |  857 ++++++++++++---
 sound/soc/{omap =3D> ti}/omap-mcbsp.h                |    8 +-
 sound/soc/{omap =3D> ti}/omap-mcpdm.c                |    0
 sound/soc/{omap =3D> ti}/omap-mcpdm.h                |    0
 sound/soc/{omap =3D> ti}/omap-twl4030.c              |    0
 sound/soc/{omap =3D> ti}/omap3pandora.c              |    0
 sound/soc/{omap =3D> ti}/osk5912.c                   |    0
 sound/soc/{omap =3D> ti}/rx51.c                      |    0
 sound/soc/{omap =3D> ti}/sdma-pcm.c                  |    0
 sound/soc/{omap =3D> ti}/sdma-pcm.h                  |    4 +-
 sound/soc/xilinx/Kconfig                           |    8 +
 sound/soc/xilinx/Makefile                          |    2 +
 sound/soc/xilinx/xlnx_i2s.c                        |  185 ++++
 190 files changed, 9619 insertions(+), 4021 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spd=
ifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 sound/soc/amd/raven/Makefile
 create mode 100644 sound/soc/amd/raven/acp3x-pcm-dma.c
 create mode 100644 sound/soc/amd/raven/acp3x.h
 create mode 100644 sound/soc/amd/raven/chip_offset_byte.h
 create mode 100644 sound/soc/amd/raven/pci-acp3x.c
 create mode 100644 sound/soc/codecs/ak4118.c
 delete mode 100644 sound/soc/davinci/Kconfig
 delete mode 100644 sound/soc/davinci/Makefile
 create mode 100644 sound/soc/intel/boards/kbl_rt5660.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-icl-match.c
 create mode 100644 sound/soc/meson/axg-spdifin.c
 delete mode 100644 sound/soc/omap/Kconfig
 delete mode 100644 sound/soc/omap/Makefile
 delete mode 100644 sound/soc/omap/am3517evm.c
 delete mode 100644 sound/soc/omap/mcbsp.c
 delete mode 100644 sound/soc/pxa/raumfeld.c
 create mode 100644 sound/soc/ti/Kconfig
 create mode 100644 sound/soc/ti/Makefile
 rename sound/soc/{omap =3D> ti}/ams-delta.c (100%)
 rename sound/soc/{davinci =3D> ti}/davinci-evm.c (99%)
 rename sound/soc/{davinci =3D> ti}/davinci-i2s.c (100%)
 rename sound/soc/{davinci =3D> ti}/davinci-i2s.h (100%)
 rename sound/soc/{davinci =3D> ti}/davinci-mcasp.c (94%)
 rename sound/soc/{davinci =3D> ti}/davinci-mcasp.h (95%)
 rename sound/soc/{davinci =3D> ti}/davinci-vcif.c (100%)
 rename sound/soc/{davinci =3D> ti}/edma-pcm.c (100%)
 rename sound/soc/{davinci =3D> ti}/edma-pcm.h (91%)
 rename sound/soc/{omap =3D> ti}/n810.c (100%)
 rename sound/soc/{omap =3D> ti}/omap-abe-twl6040.c (100%)
 rename sound/soc/{omap =3D> ti}/omap-dmic.c (100%)
 rename sound/soc/{omap =3D> ti}/omap-dmic.h (100%)
 rename sound/soc/{omap/omap-hdmi-audio.c =3D> ti/omap-hdmi.c} (100%)
 rename sound/soc/{omap/mcbsp.h =3D> ti/omap-mcbsp-priv.h} (70%)
 create mode 100644 sound/soc/ti/omap-mcbsp-st.c
 rename sound/soc/{omap =3D> ti}/omap-mcbsp.c (51%)
 rename sound/soc/{omap =3D> ti}/omap-mcbsp.h (92%)
 rename sound/soc/{omap =3D> ti}/omap-mcpdm.c (100%)
 rename sound/soc/{omap =3D> ti}/omap-mcpdm.h (100%)
 rename sound/soc/{omap =3D> ti}/omap-twl4030.c (100%)
 rename sound/soc/{omap =3D> ti}/omap3pandora.c (100%)
 rename sound/soc/{omap =3D> ti}/osk5912.c (100%)
 rename sound/soc/{omap =3D> ti}/rx51.c (100%)
 rename sound/soc/{omap =3D> ti}/sdma-pcm.c (100%)
 rename sound/soc/{omap =3D> ti}/sdma-pcm.h (85%)
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwY7Q8ACgkQJNaLcl1U
h9Dd8Qf/ftxshVjkuBRrZyH3Pep6wIcmqXBKpe61sRZmLiC8/LuEZulCralfPEUJ
I+vTR/asIJaJhxhKBiL69wRoDUMplUAhqn49c57QuYAv29mQ+LX+FOpfVf4bMeMI
9vnNmrXmi+Xcne8ZhDSqJGDttkHEFitajp8rRi9tlS4UbJ7fFlZOCOMP0LxPIKZb
sRLmUfsaEWEM9Ai6L3JkYj+MouRLSEABsBJ6SjSVUKaBneiX/MWNbWy1cy4jjA7t
oi9uQ1TCrNDAbFZuxG4oviG0PHQ1p8aWvqbD/0ZZ6WBaVmaOrDTsje1l4NYyE4R/
hSUl3zmqEU/J3VOCLU/5CG+qqa67iA==
=X+zL
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============2567934612587976135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2567934612587976135==--
