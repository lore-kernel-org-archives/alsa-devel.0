From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.19
Date: Mon, 13 Aug 2018 10:58:20 +0100
Message-ID: <20180813095820.GC6757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3033992893230144795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A7EC2677AE
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2018 11:58:22 +0200 (CEST)
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


--===============3033992893230144795==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.19

for you to fetch changes up to 4aa5db22d35588e1a5d2ee88472348ea73d9fb23:

  Merge branch 'asoc-4.19' into asoc-next (2018-08-09 14:47:05 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.19

A fairly big update, including quite a bit of core activity this time
around (which is good to see) along with a fairly large set of new
drivers.

 - A new snd_pcm_stop_xrun() helper which is now used in several
   drivers.
 - Support for providing name prefixes to generic component nodes.
 - Quite a few fixes for DPCM as it gains a bit wider use and more
   robust testing.
 - Generalization of the DIO2125 support to a simple amplifier driver.
 - Accessory detection support for the audio graph card.
 - DT support for PXA AC'97 devices.
 - Quirks for a number of new x86 systems.
 - Support for AM Logic Meson, Everest ES7154, Intel systems with
   RT5682, Qualcomm QDSP6 and WCD9335, Realtek RT5682 and TI TAS5707.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da7219: Add delays to capture path to remove DC offset noise

Agrawal, Akshu (4):
      ASoC: AMD: Add NULL pointer check
      ASoC: AMD: Change codec to channel link as per hardware redesign
      ASoC: AMD: Send correct channel for configuring DMA descriptors
      ASoC: AMD: For capture have interrupts on I2S->ACP channel

Ajit Pandey (1):
      ASoC: wm_adsp: Correct DSP pointer for preloader control

Akshu Agrawal (6):
      ASoC: AMD: Configure channel 1 or channel 0 for capture
      ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002
      ASoC: AMD: Fix build warning
      ASoC: soc-pcm: Use delay set in component pointer function
      ASoC: AMD: Make ACP->SYSMEM DMA non circular
      ASoC: AMD: Set delay value for the capture case

Alexey Khoroshilov (3):
      ASoC: rockchip: put device_node on remove
      ASoC: tegra: fix device_node refcounting
      ASoC: tegra_alc5632: fix device_node refcounting

Andrew Gabbasov (1):
      ASoC: rsnd: cmd: Add missing newline to debug message

Arnaud Pouliquen (2):
      MAINTAINERS: add entry for STI audio drivers
      MAINTAINERS: add entry for STM32 audio drivers

Arnd Bergmann (2):
      ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA
      ASoC: meson: axg-spdifout: select SND_PCM_IEC958

Bard Liao (3):
      ASoC: rt5682: add rt5682 codec driver
      ASoC: rt5682: add button detection mode control
      ASoC: rt5631: add Volume to the name of volume control

Charles Keepax (5):
      ASoC: pcm: Tidy up open/hw_params handling
      ASoC: wm_adsp: Simplify handling of alg offset and length
      ASoC: arizona: Set compressed IRQ to a wake source
      ASoC: wm_adsp: Correct algorithm list allocation size
      ASoC: wm_adsp: Take prefix into account in control name length

Codrin Ciubotariu (2):
      ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)
      ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk

Colin Ian King (5):
      ASoC: twl6040: make pointer dmic_codec_dev static
      ASoC: ak5558: make two structures static
      ASoC: ak4458: make structure soc_codec_dev_ak4458 static const
      ASoC: nau8540: remove redundant variable osrate
      ASoC: stm32: remove redundant pointers 'priv' and 'rtd'

Dan Carpenter (3):
      ASoC: qdsp6: qdafe: fix some off by one bugs
      ASoC: qdsp6: q6afe-dai: fix a range check in of_q6afe_parse_dai_data()
      ASoC: qdsp6: q6routing: off by one in routing_hw_params()

Daniel Kurtz (6):
      ASoC: AMD: Always stop ch2 first
      ASoC: AMD: Always subtract bytescount
      ASoC: AMD: Fix Capture DMA channel names
      ASoC: AMD: Do not generate interrups for every captured sample
      ASoC: AMD: Reset bytescount when starting transaction
      ASoC: AMD: Simplify trigger handler

Daniel Mack (11):
      ASoC: fold pxa2xx-pcm into its only user, pxa2xx-ac97
      ASoC: pxa: clean up function names in pxa2xx-lib
      ASoC: pxa: move some functions to pxa2xx-lib
      ASoC: pxa2xx-pcm-lib: fix indenting
      ASoC: pxa: provide PCM ops for ssp, i2s and ac97 components
      ASoC: pxa: remove bindings from pxa2xx-pcm
      ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable
      ASoC: pxa: select SND_PXA2XX_LIB for drivers that depend on it
      ASoC: pxa-ssp: remove .set_pll() and .set_clkdiv() callbacks
      ASoC: pxa-ssp: add support for an external clock in devicetree
      ASoC: pxa: remove clock divider and pll setup from zylonite and magician

Edward Cragg (1):
      ASoC: tegra: i2s: Fix typo/broken macro

Fabio Estevam (5):
      ASoC: soc-utils: Fix unregistration order
      ASoC: fsl-asoc-card: Switch to SPDX identifier
      ASoC: fsl_asrc: Switch to SPDX identifier
      ASoC: fsl_utils: Switch to SPDX identifier
      ASoC: imx-sgtl5000: Switch to SPDX identifier

Geert Uytterhoeven (1):
      ASoC: rt1305: Use ULL suffixes for 64-bit constants

Gustavo A. R. Silva (37):
      ASoC: pxa-ssp: mark expected switch fall-through
      ASoC: nau8825: use 64-bit arithmetic instead of 32-bit
      ASoC: fsl_spdif: Use 64-bit arithmetic instead of 32-bit
      ASoC: nau8824: use 64-bit arithmetic instead of 32-bit
      ASoC: sirf: Fix potential NULL pointer dereference
      ASoC: wm8961: Mark expected switch fall-through
      ASoC: rt5640: Mark expected switch fall-through
      ASoC: rt5677: Mark expected switch fall-through
      ASoC: wm8955: Mark expected switch fall-through
      ASoC: wm8960: Mark expected switch fall-through
      ASoC: wm8904: Mark expected switch fall-through
      ASoC: wm8996: Mark expected switch fall-through
      ASoC: wm8962: Mark expected switch fall-through
      ASoC: wm8995: Mark expected switch fall-through
      ASoC: wm9081: Mark expected switch fall-through
      ASoC: wm8994: Mark expected switch fall-through
      ASoC: smd845: fix memory leak
      ASoC: davinci-i2s: mark expected switch fall-through
      ASoC: omap-mcpdm: Mark expected switch fall-throughs
      ASoC: core: mark expected switch fall-through
      ASoC: fsl_esai: Mark expected switch fall-through
      ASoC: omap-dmic: Mark expected switch fall-throughs
      ASoC: samsung: i2s: Mark expected switch fall-through
      ASoC: max9850: use true and false for boolean values
      ASoC: rt5631: use true and false for boolean values
      ASoC: tda7419: use true and false for boolean values
      ASoC: wm8990: use true and false for boolean values
      ASoC: cs4270: use true and false for boolean values
      ASoC: wm8996: use true and false for boolean values
      ASoC: da7219: use true and false for boolean values
      ASoC: twl6040: use true and false for boolean values
      ASoC: da7213: use true and false for boolean values
      ASoC: wm5100-tables: use true and false for boolean values
      ASoC: da9055: use true and false for boolean values
      ASoC: wm8903: use true and false for boolean values
      ASoC: wm8994: Fix missing break in switch
      ASoC: adav80x: mark expected switch fall-through

Hans de Goede (28):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Chuwi Vi10 tablet
      ASoC: Intel: bytcr_rt5640: Add quirk for the Nuvison/TMax TM800W560 tablet
      ASoC: Intel: bytcr_rt5640: Fix Acer Iconia 8 over-current detect threshold
      ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_DEFAULT_QUIRKS define
      ASoC: Intel: bytcr_rt5651: Change default input map from in2 to in1
      ASoC: Intel: bytcr_rt5651: Fix IN1_IN2_MAP quirk not being logged
      ASoC: Intel: bytcr_rt5651: Remove IN2 input mappings
      ASoC: Intel: bytcr_rt5651: Fix IN1 map headsetmic mapping
      ASoC: Intel: bytcr_rt5651: Fix DMIC map headsetmic mapping
      ASoC: Intel: bytcr_rt5651: Simplify card long-name
      ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_HP_LR_SWAPPED quirk
      ASoC: Intel: bytcr_rt5651: Sort DMI table entries alphabetically
      ASoC: Intel: bytcr_rt5640: Add quirk for the Lenovo Miix2 8 tablet
      ASoC: Intel: bytcr_rt5651: Remove is_valleyview helper
      ASoC: Intel: bytcr_rt5651: Move getting of codec_dev into probe()
      ASoC: Intel: bytcr_rt5651: Add support for externar amplifier enable GPIO
      ASoC: rt5651: Fix workqueue cancel vs irq free race on remove
      ASoC: rt5651: Allow disabling jack-detect by calling set_jack(NULL)
      ASoC: rt5651: Add button press support
      ASoC: Intel: bytcr_rt5651: Disable jack-detect over suspend/resume
      ASoC: Intel: bytcr_rt5651: Reporting button presses
      ASoC: rt5651: Add IN3 Boost volume control
      ASoC: Intel: bytcr_rt5651: Fix using the wrong GPIO for the ext-amp on some boards
      ASoC: Intel: bytcr_rt5651: Set OVCD limit for VIOS LTH17 to 2000uA
      ASoC: Intel: bytcr_rt5651: Add IN2 input mapping
      ASoC: Intel: bytcr_rt5651: Add mono speaker quirk
      ASoC: Intel: bytcr_rt5651: Add quirk table entries for various devices
      ASoC: Intel: bytcr_rt5640: Add quirk for the "Connect Tablet 9" tablet

Hiroyuki Yokoyama (1):
      ASoC: rsnd: Document R-Car M3-N support

Janusz Krzysztofik (1):
      ASoC: cx20442: Don't ignore regulator_get() errors.

Jerome Brunet (39):
      clk: add duty cycle support
      ASoC: simple-amplifier: remame dio2125 documentation
      ASoC: simple-amplifier: rename dio2125 to simple-amplifer
      ASoC: simple-amplifer: add simple-amplifier compatible
      ASoC: tas571x: add tas5707 compatible
      ASoC: tas517x: add tas5707 support
      ASoC: dpcm: improve runtime update predictability
      ASoC: dpcm: extend channel merging to the backend cpu dai
      ASoC: dpcm: don't merge format from invalid codec dai
      ASoC: es7134: remove 64kHz rate from the supported rates
      ASoC: es7134: check if mclk rate is valid
      ASoC: es7134: Add VDD and AVDD power supplies
      ASoC: es7241: add dt-bindings documentation for the es7241 adc
      ASoC: es7241: add es7241 codec support
      ASoC: es7134: update DT binding with new compatible and supplies
      ASoC: es7134: correct required power supplies
      ASoC: es7134: add support for the es7154
      ASoC: dpcm: rework runtime stream merge
      ASoC: dpcm: add rate merge to the BE stream merge
      ASoC: add DT documentation for the sound-name-prefix property
      ASoC: allow soc-core to pick up name prefixes from component nodes
      ASoC: meson: add axg fifos DT binding documentation
      ASoC: meson: add axg fifo base driver
      ASoC: meson: add axg frddr driver
      ASoC: meson: add axg toddr driver
      ASoC: meson: add axg spdif output DT bindings documentation
      ASoC: meson: add axg spdif output
      ASoC: meson: add axg tdm formatters DT bindings documentation
      ASoC: meson: add axg tdm interface DT bindings documentation
      ASoC: meson: add tdm formatter base driver
      ASoC: meson: add tdm interface driver
      ASoC: meson: add tdm output driver
      ASoC: meson: add tdm input driver
      ASoC: export snd_soc_of_get_slot_mask
      ASoC: meson: add axg sound card DT bindings documentation
      ASoC: meson: add axg sound card support
      ASoC: meson: use IRQ_RETVAL in the fifo irq handler
      ASoC: meson: update axg sound card bindings
      ASoC: meson: align axg card driver with DT bindings documentation

Jiada Wang (1):
      ASoC: soc-pcm: DPCM cares BE channel constraint

Jianqun Xu (1):
      ASoC: rockchip: add config for rockchip dmaengine pcm register

KaiChieh Chuang (2):
      ASoC: mediatek: sub dai use list_head
      ASoC: mt6797: sub dai use list_head

Katsuhiro Suzuki (7):
      ASoC: simple-card-utils: move hp and mic detect gpios from simple-card
      ASoC: simple-card: move hp and mic detection to soc_card probe
      ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card
      ASoC: uniphier: remove redundant check of PLL ID
      ASoC: add hp-det-gpio and mic-det-gpio to audio graph card binding
      ASoC: uniphier: add support for multichannel output
      ASoC: uniphier: change functions to static

Kuninori Morimoto (37):
      ASoC: fsi: convert to SPDX identifiers
      ASoC: hac: convert to SPDX identifiers
      ASoC: ssi: convert to SPDX identifiers
      ASoC: siu: convert to SPDX identifiers
      ASoC: rsnd: convert to SPDX identifiers
      ASoC: migor: convert to SPDX identifiers
      ASoC: dma-sh7760: convert to SPDX identifiers
      ASoC: sh7760-ac97: convert to SPDX identifiers
      ASoC: rsnd: has .symmetric_rates if SSIs are sharing WS pin
      ASoC: rsnd: SSI parent cares SWSP bit
      ASoC: rsnd: add rsnd_daidrv_get()
      ASoC: simple-card: convert to SPDX identifiers
      ASoC: simple-card-utils: convert to SPDX identifiers
      ASoC: simple-scu-card.c: convert to SPDX identifiers
      ASoC: audio-graph-card.c: convert to SPDX identifiers
      ASoC: audio-graph-scu-card.c: convert to SPDX identifiers
      ASoC: soc-io.c: convert to SPDX identifiers
      ASoC: soc-dai.h: convert to SPDX identifiers
      ASoC: soc-ops.c: convert to SPDX identifiers
      ASoC: soc-pcm.c: convert to SPDX identifiers
      ASoC: soc-dpcm.h: convert to SPDX identifiers
      ASoC: soc-jack.c: convert to SPDX identifiers
      ASoC: soc-utils.c: convert to SPDX identifiers
      ASoC: soc-devres.c: convert to SPDX identifiers
      ASoC: soc-acpi: convert to SPDX identifiers
      ASoC: soc-core: convert to SPDX identifiers
      ASoC: soc-dapm: convert to SPDX identifiers
      ASoC: soc-topology: convert to SPDX identifiers
      ASoC: soc-compress: convert to SPDX identifiers
      ASoC: soc-generic-dmaengine-pcm: convert to SPDX identifiers
      ASoC: ac97: convert to SPDX identifiers
      ASoC: ak4642: convert to SPDX identifiers
      ASoC: ak4554: convert to SPDX identifiers
      ASoC: da7210: convert to SPDX identifiers
      ASoC: ak4613: convert to SPDX identifiers
      ASoC: sh: Kconfig: convert to SPDX identifiers
      ASoC: fsi: convert to SPDX identifiers

Ladislav Michl (1):
      ASoC: wm8988: fix typo in rate constraints

Lars-Peter Clausen (1):
      ASoC: adau171x1: Connect playback DAI to the DSP

Liam Girdwood (4):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs
      ASoC: topology: Give more data to clients via callbacks
      ASoC: topology: Add callback for DAPM route load/unload
      ASoC: core: Allow topology to override machine driver FE DAI link config.

Liang Chen (1):
      ASoC: rockchip-i2s: add description for px30

Mac Chiang (1):
      ASoC: Intel: kbl_da7219_max98357a: add fe_ops for kbl Audio Capture Port

Marcel Ziswiler (2):
      ASoC: sgtl5000: fix spelling in devicetree binding document
      ASoC: tegra: improve goto error label

Mark Brown (12):
      Merge branch 'asoc-4.17' into asoc-linus
      Merge branch 'asoc-4.18' into asoc-next
      Merge branch 'asoc-4.18' into asoc-4.19 for amd dep
      Merge tag 'pxa-for-4.19-dma_slave_map' of https://github.com/rjarzmik/linux into asoc-4.19 for ac'97 deps
      Merge tag 'alsa-add-snd-sgbuf-aligned-pages' of https://git.kernel.org/.../broonie/sound into asoc-4.19
      Merge branch 'topic/drm_audio_component' of https://git.kernel.org/.../tiwai/sound into asoc-4.19
      Merge tag 'clk-core-duty-cycle-for-mark' of git://git.kernel.org/.../clk/linux into asoc-4.19
      ASoC: wcd9335: Fix build due to CLASS-H Controller support
      ASoC: wcd9335: Fix build
      Merge branch 'asoc-4.18' into asoc-4.19 wmadsp dep
      Merge branch 'asoc-4.18' into asoc-linus
      Merge branch 'asoc-4.19' into asoc-next

Matthias Kaehlcke (1):
      ASoC: rt5677: Fix initialization of rt5677_of_match.data

Mukunda, Vijendar (1):
      ASoC: AMD: Modified DMA pointer for capture

Naveen Manohar (3):
      ASoC: Intel: broxton: reduce machine name for bxt_da7219_max98357a
      ASoC: Intel: common: Add Geminilake Dialog+Maxim machine driver entry
      ASoC: Intel: Boards: Add GLK Realtek Maxim I2S machine driver

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied

Pierre-Louis Bossart (13):
      ASoC: Intel: Skylake: cleanup before moving ACPI tables
      ASoC: Intel: move SKL+ codec ACPI tables to common directory
      ASoC: Intel: common: add firmware/topology information for SOF
      ASoC: Intel: common: add entries for SOF-based machine drivers
      ASoC: Intel: common: fix copy/paste issue with SOF/broadwell topology file
      ASoC: Intel: common: rename 'reef' to 'sof' in ACPI matching table
      ASoC: Intel: common: fix missing rename from 'reef' to 'sof'
      ASoC: Intel: Haswell: fix endianness handling
      ASoC: Intel: Skylake: BDL definitions should be __le32
      ASoC: Intel: common: make sst_dma functions static
      ASoC: Intel: Atom: simplify iomem address and casts
      ASoC: Intel: Atom: fix inversion between __iowrite32 and __ioread32
      ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally

Rakesh Ughreja (8):
      ALSA: hdac: Remove usage of struct hdac_ext_device and use hdac_device instead
      ALSA: hdac: Remove usage of struct hdac_ext_bus and use hdac_bus instead
      ALSA: hdac: Remove usage of struct hdac_ext_driver, use hdac_driver instead
      ALSA: hdac: ext: add wait for codec to respond after link reset
      ALSA: hda: split snd_hda_codec_new function
      ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
      ALSA: hdac: add extended ops in the hdac_bus
      ASoC: Intel: Skylake: fix widget handling

Richard Fitzgerald (4):
      ASoC: wm_adsp: Allow up to 8 channels for voice control
      ASoC: wm_adsp: Parse HOST_BUFFER controls
      ASoC: wm_adsp: Declare firmware controls from codec driver
      ASoC: wm_adsp: Make DSP name configurable by codec driver

Robert Jarzmik (13):
      ASoC: pxa: add binding for pxa2xx-ac97 audio complex
      ASoC: pxa: add devicetree support
      dmaengine: pxa: use a dma slave map
      ARM: pxa: add dma slave map
      dmaengine: pxa: add a default requestor policy
      mmc: pxamci: remove the dmaengine compat need
      media: pxa_camera: remove the dmaengine compat need
      mtd: rawnand: marvell: remove the dmaengine compat need
      ata: pata_pxa: remove the dmaengine compat need
      dmaengine: pxa: document pxad_param
      ARM: pxa: remove the DMA IO resources
      ARM: pxa: change SSP DMA channels allocation
      ASoC: pxa: remove the dmaengine compat need

Rohit Kumar (1):
      ASoC: qcom: apq8096: set card as device drvdata

Rohit kumar (5):
      ASoC: qcom: dt-bindings: Add sdm845 machine bindings
      ASoC: dt-bindings: Update dt binding name for apq8096
      ASoC: qcom: Add support to parse common audio device nodes
      ASoC: qcom: add sdm845 sound card support
      ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845

Russell King (1):
      ASoC: hdmi-codec: fix routing

Ryan Lee (1):
      ASoC: max98373: Added software reset register to readable registers

Srinivas Kandagatla (36):
      ASoC: q6adm: dt-bindings: add compatible string to routing
      ASoC: q6asm: dt-bindings: add compatible string to dais
      ASoC: q6afe: dt-bindings: add compatible string to dais
      ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
      ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
      ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
      ASoC: qdsp6: q6afe-dai: support dt based module loading
      ASoC: qdsp6: q6asm-dai: support dt based module loading
      ASoC: qdsp6: q6routing: support dt based module loading
      ASoC: qcom: apq8096: remove redundant owner assignment
      ASoC: qdsp6: q6routing: add proper error check
      ASoC: qdsp6: q6asm: remove unused struct q6asm member
      ASoC: qdsp6: q6afe-dai: do not close port if its not opened
      ASoC: qdsp6: q6asm-dai: do not close port if its not opened
      ASoC: qdsp6: q6afe: Add missing slimbus capture ports
      ASoC: qdsp6: q6afe-dai: add support to slim tx dais
      ASoC: qdsp6: q6routing: add slim rx routings
      ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels
      ASoC: core: add support to card re-bind using component framework
      ASoC: qdsp6: q6afe-dai: remove component fw related code
      ASoC: qdsp6: q6asm-dai: remove component framework related code
      ASoC: qdsp6: q6routing: remove component framework related code
      ASoC: qcom: apq8096: remove component framework related code
      ASoC: core: add support to snd_soc_dai_get_channel_map()
      ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
      ASoC: wcd9335: add support to wcd9335 codec
      ASoC: wcd9335: add CLASS-H Controller support
      ASoC: apq8096: remove auto rebinding
      ASoC: smd845: remove auto rebinding
      ASoC: core: remove support for card rebind using component framework
      ASoC: qcom: make common.c as proper module
      ASoC: apq8096: remove unused header files
      ASoC: sdm845: remove unused header files
      ASoC: qcom: remove unused header files from common.h
      ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm
      ASoC: compress: make BE and FE order inline with dpcm

Sriram Periyasamy (1):
      ASoC: hdac_hdmi: Add documentation for power management

Stefan Agner (1):
      ASoC: codecs: PCM1789: unconditionally flush work

Steven Eckhoff (3):
      ASoC: TSCS42xx: Add mic bias boost control
      ASoC: TSCS42xx: Remove Playback/Capture in names
      ASoC: TSCS42xx: Add headphone auto switching

Stuart Henderson (1):
      ASoC: wm_adsp: Ensure DSP boot work complete before preloader_put return

Takashi Iwai (18):
      ASoC: davinci: Use snd_pcm_stop_xrun() helper
      ASoC: qcom: Use snd_pcm_stop_xrun() helper
      ASoC: sti: Use snd_pcm_stop_xrun() helper
      ASoC: stm32: Use snd_pcm_stop_xrun() helper
      Merge branch 'topic/hda-core-intel' into topic/hda-acomp
      drm/i915: Split audio component to a generic type
      ALSA: hda/i915: Associate audio component with devres
      ALSA: hda: Make audio component support more generic
      ASoC: zte: Fix incorrect PCM format bit usages
      ASoC: dmaengine: Fix missing __user prefix in copy_user callback
      ASoC: dapm: Use int for format bit position
      ALSA: pcm: Add snd_mask_set_format() helper for standard usages
      ASoC: doc: Replace open code with params_set_format()
      ASoC: intel: Fix snd_pcm_format_t handling
      ASoC: fsl: Use snd_mask_set_format()
      ASoC: pcm186x: Declare PCM format with snd_pcm_format_t
      ASoC: dmaengine: Use standard pcm_format_to_bits() macro
      ALSA: memalloc: Fix missing PAGE_SIZE definition

Wei Yongjun (2):
      ASoC: rt5682: use devm_snd_soc_register_component()
      ASoC: rt1305: use devm_snd_soc_register_component()

Yong Zhi (1):
      ASoC: Intel: bxt: Use refcap device for mono recording

benjamin.gaignard@linaro.org (1):
      ASoC: stm32: replace "%p" with "%pK"

olivier moysan (1):
      ASoC: stm32: sai: add iec958 controls support

 .../devicetree/bindings/sound/amlogic,axg-fifo.txt |   23 +
 .../bindings/sound/amlogic,axg-sound-card.txt      |  124 +
 .../bindings/sound/amlogic,axg-spdifout.txt        |   20 +
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  |   28 +
 .../bindings/sound/amlogic,axg-tdm-iface.txt       |   22 +
 .../devicetree/bindings/sound/atmel-i2s.txt        |   11 +-
 .../devicetree/bindings/sound/audio-graph-card.txt |    2 +
 .../devicetree/bindings/sound/dioo,dio2125.txt     |   12 -
 .../devicetree/bindings/sound/everest,es7134.txt   |    7 +-
 .../devicetree/bindings/sound/everest,es7241.txt   |   28 +
 .../bindings/sound/marvell,pxa2xx-ac97.txt         |   27 +
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |    8 +
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt  |   15 -
 .../devicetree/bindings/sound/name-prefix.txt      |   24 +
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   15 +-
 .../devicetree/bindings/sound/qcom,q6adm.txt       |    6 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |    6 +
 .../devicetree/bindings/sound/qcom,q6asm.txt       |    6 +
 .../devicetree/bindings/sound/qcom,sdm845.txt      |   80 +
 .../devicetree/bindings/sound/qcom,wcd9335.txt     |  123 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    1 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 Documentation/devicetree/bindings/sound/rt5682.txt |   50 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    2 +-
 .../devicetree/bindings/sound/simple-amplifier.txt |   12 +
 .../devicetree/bindings/sound/tas571x.txt          |    1 +
 Documentation/sound/soc/dpcm.rst                   |    4 +-
 MAINTAINERS                                        |   15 +
 arch/arm/mach-pxa/devices.c                        |  148 +-
 arch/arm/mach-pxa/devices.h                        |    6 +-
 arch/arm/mach-pxa/pxa25x.c                         |   38 +-
 arch/arm/mach-pxa/pxa27x.c                         |   39 +-
 arch/arm/mach-pxa/pxa3xx.c                         |   41 +-
 arch/arm/plat-pxa/ssp.c                            |   47 -
 drivers/ata/pata_pxa.c                             |   10 +-
 drivers/clk/clk.c                                  |  199 +-
 drivers/dma/pxa_dma.c                              |   15 +-
 drivers/gpu/drm/i915/Kconfig                       |    1 +
 drivers/gpu/drm/i915/intel_audio.c                 |   22 +-
 drivers/media/platform/pxa_camera.c                |   22 +-
 drivers/mmc/host/pxamci.c                          |   29 +-
 drivers/mtd/nand/raw/marvell_nand.c                |   17 +-
 include/drm/drm_audio_component.h                  |  118 +
 include/drm/i915_component.h                       |   85 +-
 include/linux/clk-provider.h                       |   26 +
 include/linux/clk.h                                |   33 +
 include/linux/dma/pxa-dma.h                        |    9 +
 include/linux/platform_data/mmp_dma.h              |    4 +
 include/linux/pxa2xx_ssp.h                         |   10 +-
 include/sound/ac97/codec.h                         |    8 +-
 include/sound/ac97/compat.h                        |    9 +-
 include/sound/ac97/controller.h                    |    8 +-
 include/sound/ac97/regs.h                          |   20 +-
 include/sound/ac97_codec.h                         |   25 +-
 include/sound/compress_driver.h                    |   21 +-
 include/sound/dmaengine_pcm.h                      |   14 +-
 include/sound/hda_component.h                      |   61 +
 include/sound/hda_i915.h                           |   37 +-
 include/sound/hdaudio.h                            |   35 +-
 include/sound/hdaudio_ext.h                        |  123 +-
 include/sound/memalloc.h                           |   18 +-
 include/sound/pcm_params.h                         |   10 +-
 include/sound/pxa2xx-lib.h                         |   13 +-
 include/sound/rt5682.h                             |   40 +
 include/sound/sh_fsi.h                             |   13 +-
 include/sound/simple_card.h                        |    7 +-
 include/sound/simple_card_utils.h                  |   23 +-
 include/sound/soc-acpi-intel-match.h               |   19 +-
 include/sound/soc-acpi.h                           |   13 +-
 include/sound/soc-dai.h                            |   15 +-
 include/sound/soc-dapm.h                           |   11 +-
 include/sound/soc-dpcm.h                           |    7 +-
 include/sound/soc-topology.h                       |   37 +-
 include/sound/soc.h                                |   31 +-
 include/trace/events/clk.h                         |   36 +
 sound/arm/Kconfig                                  |    5 -
 sound/arm/Makefile                                 |    3 -
 sound/arm/pxa2xx-ac97-lib.c                        |   12 +
 sound/arm/pxa2xx-ac97.c                            |  124 +-
 sound/arm/pxa2xx-pcm-lib.c                         |   75 +-
 sound/arm/pxa2xx-pcm.c                             |  129 -
 sound/arm/pxa2xx-pcm.h                             |   27 -
 sound/hda/Kconfig                                  |    7 +-
 sound/hda/Makefile                                 |    1 +
 sound/hda/ext/hdac_ext_bus.c                       |   80 +-
 sound/hda/ext/hdac_ext_controller.c                |   64 +-
 sound/hda/ext/hdac_ext_stream.c                    |  104 +-
 sound/hda/hdac_component.c                         |  335 +++
 sound/hda/hdac_i915.c                              |  335 +--
 sound/pci/hda/hda_codec.c                          |   68 +-
 sound/pci/hda/hda_codec.h                          |    2 +
 sound/pci/hda/patch_hdmi.c                         |   57 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/amd/Kconfig                              |    1 +
 sound/soc/amd/acp-da7219-max98357a.c               |  109 +-
 sound/soc/amd/acp-pcm-dma.c                        |  214 +-
 sound/soc/amd/acp.h                                |   13 +-
 sound/soc/atmel/atmel-i2s.c                        |   46 +-
 sound/soc/codecs/Kconfig                           |   25 +-
 sound/soc/codecs/Makefile                          |    8 +-
 sound/soc/codecs/adau17x1.c                        |    1 +
 sound/soc/codecs/adav80x.c                         |    1 +
 sound/soc/codecs/ak4458.c                          |    2 +-
 sound/soc/codecs/ak4554.c                          |   17 +-
 sound/soc/codecs/ak4613.c                          |   26 +-
 sound/soc/codecs/ak4642.c                          |   26 +-
 sound/soc/codecs/ak5558.c                          |    4 +-
 sound/soc/codecs/cs4270.c                          |    2 +-
 sound/soc/codecs/cs47l24.c                         |   11 +
 sound/soc/codecs/cx20442.c                         |   23 +-
 sound/soc/codecs/da7210.c                          |   27 +-
 sound/soc/codecs/da7213.c                          |    4 +-
 sound/soc/codecs/da7219-aad.c                      |    5 +
 sound/soc/codecs/da7219.c                          |   48 +-
 sound/soc/codecs/da7219.h                          |    8 +-
 sound/soc/codecs/da9055.c                          |    4 +-
 sound/soc/codecs/es7134.c                          |  227 +-
 sound/soc/codecs/es7241.c                          |  322 +++
 sound/soc/codecs/hdac_hdmi.c                       |  495 ++--
 sound/soc/codecs/hdmi-codec.c                      |   21 +-
 sound/soc/codecs/max98373.c                        |    1 +
 sound/soc/codecs/max9850.c                         |    4 +-
 sound/soc/codecs/nau8540.c                         |    3 -
 sound/soc/codecs/nau8824.c                         |    2 +-
 sound/soc/codecs/nau8825.c                         |    2 +-
 sound/soc/codecs/pcm1789.c                         |    3 +-
 sound/soc/codecs/pcm186x.c                         |    2 +-
 sound/soc/codecs/rt1305.c                          |   15 +-
 sound/soc/codecs/rt5514.c                          |    8 +-
 sound/soc/codecs/rt5631.c                          |   12 +-
 sound/soc/codecs/rt5640.c                          |    2 +
 sound/soc/codecs/rt5651.c                          |  235 +-
 sound/soc/codecs/rt5651.h                          |    8 +
 sound/soc/codecs/rt5677.c                          |    3 +-
 sound/soc/codecs/rt5682.c                          | 2681 ++++++++++++++++++++
 sound/soc/codecs/rt5682.h                          | 1324 ++++++++++
 sound/soc/codecs/{dio2125.c => simple-amplifier.c} |   42 +-
 sound/soc/codecs/tas571x.c                         |  110 +
 sound/soc/codecs/tas571x.h                         |   16 +
 sound/soc/codecs/tda7419.c                         |    4 +-
 sound/soc/codecs/tscs42xx.c                        |   37 +-
 sound/soc/codecs/tscs42xx.h                        |    8 +
 sound/soc/codecs/twl6040.c                         |    2 +-
 sound/soc/codecs/wm2200.c                          |   10 +-
 sound/soc/codecs/wm5100-tables.c                   |   12 +-
 sound/soc/codecs/wm5102.c                          |   10 +
 sound/soc/codecs/wm5110.c                          |   13 +
 sound/soc/codecs/wm8903.c                          |    4 +-
 sound/soc/codecs/wm8904.c                          |    1 +
 sound/soc/codecs/wm8955.c                          |    1 +
 sound/soc/codecs/wm8960.c                          |    1 +
 sound/soc/codecs/wm8961.c                          |    1 +
 sound/soc/codecs/wm8962.c                          |    1 +
 sound/soc/codecs/wm8988.c                          |    4 +-
 sound/soc/codecs/wm8990.c                          |    4 +-
 sound/soc/codecs/wm8994.c                          |    1 +
 sound/soc/codecs/wm8995.c                          |    1 +
 sound/soc/codecs/wm8996.c                          |    9 +-
 sound/soc/codecs/wm9081.c                          |    1 +
 sound/soc/codecs/wm_adsp.c                         |  216 +-
 sound/soc/codecs/wm_adsp.h                         |   12 +-
 sound/soc/codecs/wmfw.h                            |    1 +
 sound/soc/davinci/davinci-i2s.c                    |    1 +
 sound/soc/davinci/davinci-mcasp.c                  |   16 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   20 +-
 sound/soc/fsl/fsl_asrc.c                           |   18 +-
 sound/soc/fsl/fsl_asrc.h                           |    5 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |   18 +-
 sound/soc/fsl/fsl_esai.c                           |    1 +
 sound/soc/fsl/fsl_spdif.c                          |    2 +-
 sound/soc/fsl/fsl_utils.c                          |   18 +-
 sound/soc/fsl/fsl_utils.h                          |    7 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   15 +-
 sound/soc/generic/audio-graph-card.c               |   41 +-
 sound/soc/generic/audio-graph-scu-card.c           |   25 +-
 sound/soc/generic/simple-card-utils.c              |   74 +-
 sound/soc/generic/simple-card.c                    |  106 +-
 sound/soc/generic/simple-scu-card.c                |   21 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |   29 +-
 sound/soc/intel/atom/sst/sst_loader.c              |    6 +-
 sound/soc/intel/boards/Kconfig                     |   14 +
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/bdw-rt5677.c                |    4 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   20 +-
 sound/soc/intel/boards/bxt_rt298.c                 |    2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   55 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  364 ++-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |  643 +++++
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |    3 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    4 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    4 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |    2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |    2 +-
 sound/soc/intel/boards/skl_rt286.c                 |    2 +-
 sound/soc/intel/common/Makefile                    |    6 +-
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c  |   59 +
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |   40 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |   56 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |   32 +
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |   41 +
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |   16 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   91 +
 sound/soc/intel/common/soc-acpi-intel-skl-match.c  |   47 +
 sound/soc/intel/common/sst-firmware.c              |    6 +-
 sound/soc/intel/haswell/sst-haswell-dsp.c          |   53 +-
 sound/soc/intel/skylake/skl-messages.c             |   50 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |    8 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  119 +-
 sound/soc/intel/skylake/skl-sst-cldma.c            |    8 +-
 sound/soc/intel/skylake/skl-sst-cldma.h            |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |   28 +-
 sound/soc/intel/skylake/skl-topology.h             |   11 +-
 sound/soc/intel/skylake/skl.c                      |  360 +--
 sound/soc/intel/skylake/skl.h                      |    7 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |   64 +-
 sound/soc/mediatek/common/mtk-base-afe.h           |    6 +-
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      |    1 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |   65 +-
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c        |   20 +-
 sound/soc/mediatek/mt6797/mt6797-dai-hostless.c    |   16 +-
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c         |   19 +-
 sound/soc/meson/Kconfig                            |   65 +
 sound/soc/meson/Makefile                           |   21 +
 sound/soc/meson/axg-card.c                         |  671 +++++
 sound/soc/meson/axg-fifo.c                         |  341 +++
 sound/soc/meson/axg-fifo.h                         |   80 +
 sound/soc/meson/axg-frddr.c                        |  141 +
 sound/soc/meson/axg-spdifout.c                     |  456 ++++
 sound/soc/meson/axg-tdm-formatter.c                |  381 +++
 sound/soc/meson/axg-tdm-formatter.h                |   39 +
 sound/soc/meson/axg-tdm-interface.c                |  542 ++++
 sound/soc/meson/axg-tdm.h                          |   78 +
 sound/soc/meson/axg-tdmin.c                        |  229 ++
 sound/soc/meson/axg-tdmout.c                       |  259 ++
 sound/soc/meson/axg-toddr.c                        |  199 ++
 sound/soc/omap/omap-abe-twl6040.c                  |    2 +-
 sound/soc/omap/omap-dmic.c                         |    2 +
 sound/soc/omap/omap-mcpdm.c                        |    4 +
 sound/soc/pxa/Kconfig                              |    6 +-
 sound/soc/pxa/magician.c                           |  106 +-
 sound/soc/pxa/pxa-ssp.c                            |  181 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   47 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    9 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |   73 -
 sound/soc/pxa/zylonite.c                           |    9 -
 sound/soc/qcom/Kconfig                             |   14 +
 sound/soc/qcom/Makefile                            |    4 +
 sound/soc/qcom/apq8096.c                           |  188 +-
 sound/soc/qcom/common.c                            |  112 +
 sound/soc/qcom/common.h                            |   11 +
 sound/soc/qcom/lpass-platform.c                    |    2 +-
 sound/soc/qcom/qdsp6/q6adm.c                       |   16 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  225 +-
 sound/soc/qcom/qdsp6/q6afe.c                       |   43 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |   42 +-
 sound/soc/qcom/qdsp6/q6asm.c                       |   17 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |   71 +-
 sound/soc/qcom/sdm845.c                            |  285 +++
 sound/soc/rockchip/Makefile                        |    3 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    3 +-
 sound/soc/rockchip/rockchip_pcm.c                  |   45 +
 sound/soc/rockchip/rockchip_pcm.h                  |   14 +
 sound/soc/rockchip/rockchip_rt5645.c               |   27 +-
 sound/soc/samsung/i2s.c                            |    1 +
 sound/soc/sh/Kconfig                               |    1 +
 sound/soc/sh/dma-sh7760.c                          |   26 +-
 sound/soc/sh/fsi.c                                 |   22 +-
 sound/soc/sh/hac.c                                 |   20 +-
 sound/soc/sh/migor.c                               |   14 +-
 sound/soc/sh/rcar/Makefile                         |    1 +
 sound/soc/sh/rcar/adg.c                            |   15 +-
 sound/soc/sh/rcar/cmd.c                            |   19 +-
 sound/soc/sh/rcar/core.c                           |   41 +-
 sound/soc/sh/rcar/ctu.c                            |   15 +-
 sound/soc/sh/rcar/dma.c                            |   17 +-
 sound/soc/sh/rcar/dvc.c                            |   16 +-
 sound/soc/sh/rcar/gen.c                            |   16 +-
 sound/soc/sh/rcar/mix.c                            |   14 +-
 sound/soc/sh/rcar/rsnd.h                           |   17 +-
 sound/soc/sh/rcar/src.c                            |   16 +-
 sound/soc/sh/rcar/ssi.c                            |   59 +-
 sound/soc/sh/rcar/ssiu.c                           |   15 +-
 sound/soc/sh/sh7760-ac97.c                         |   14 +-
 sound/soc/sh/siu.h                                 |   26 +-
 sound/soc/sh/siu_dai.c                             |   26 +-
 sound/soc/sh/siu_pcm.c                             |   27 +-
 sound/soc/sh/ssi.c                                 |   21 +-
 sound/soc/sirf/sirf-usp.c                          |    7 +-
 sound/soc/soc-ac97.c                               |   29 +-
 sound/soc/soc-acpi.c                               |   20 +-
 sound/soc/soc-compress.c                           |  120 +-
 sound/soc/soc-core.c                               |  200 +-
 sound/soc/soc-dapm.c                               |   51 +-
 sound/soc/soc-devres.c                             |   15 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   30 +-
 sound/soc/soc-io.c                                 |   19 +-
 sound/soc/soc-jack.c                               |   19 +-
 sound/soc/soc-ops.c                                |   29 +-
 sound/soc/soc-pcm.c                                |  469 ++--
 sound/soc/soc-topology.c                           |   91 +-
 sound/soc/soc-utils.c                              |   24 +-
 sound/soc/sti/uniperif_player.c                    |    6 +-
 sound/soc/sti/uniperif_reader.c                    |    2 +-
 sound/soc/stm/Kconfig                              |    1 +
 sound/soc/stm/stm32_adfsdm.c                       |   10 +-
 sound/soc/stm/stm32_sai_sub.c                      |  146 +-
 sound/soc/tegra/tegra20_ac97.c                     |    2 +-
 sound/soc/tegra/tegra30_i2s.h                      |    2 +-
 sound/soc/tegra/tegra_alc5632.c                    |   17 +-
 sound/soc/tegra/tegra_rt5677.c                     |   17 +-
 sound/soc/uniphier/aio-core.c                      |   84 +-
 sound/soc/uniphier/aio-cpu.c                       |    5 -
 sound/soc/uniphier/aio-ld11.c                      |    2 +-
 sound/soc/uniphier/aio-reg.h                       |    1 +
 sound/soc/uniphier/aio.h                           |    6 +-
 sound/soc/zte/zx-tdm.c                             |    4 +-
 317 files changed, 15598 insertions(+), 4320 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5682.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-amplifier.txt
 create mode 100644 include/drm/drm_audio_component.h
 create mode 100644 include/sound/hda_component.h
 create mode 100644 include/sound/rt5682.h
 delete mode 100644 sound/arm/pxa2xx-pcm.c
 delete mode 100644 sound/arm/pxa2xx-pcm.h
 create mode 100644 sound/hda/hdac_component.c
 create mode 100644 sound/soc/codecs/es7241.c
 create mode 100644 sound/soc/codecs/rt5682.c
 create mode 100644 sound/soc/codecs/rt5682.h
 rename sound/soc/codecs/{dio2125.c => simple-amplifier.c} (68%)
 create mode 100644 sound/soc/intel/boards/glk_rt5682_max98357a.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-bxt-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cnl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-glk-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-kbl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-skl-match.c
 create mode 100644 sound/soc/meson/Kconfig
 create mode 100644 sound/soc/meson/Makefile
 create mode 100644 sound/soc/meson/axg-card.c
 create mode 100644 sound/soc/meson/axg-fifo.c
 create mode 100644 sound/soc/meson/axg-fifo.h
 create mode 100644 sound/soc/meson/axg-frddr.c
 create mode 100644 sound/soc/meson/axg-spdifout.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.h
 create mode 100644 sound/soc/meson/axg-tdm-interface.c
 create mode 100644 sound/soc/meson/axg-tdm.h
 create mode 100644 sound/soc/meson/axg-tdmin.c
 create mode 100644 sound/soc/meson/axg-tdmout.c
 create mode 100644 sound/soc/meson/axg-toddr.c
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h
 create mode 100644 sound/soc/qcom/sdm845.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.h

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltxVjsACgkQJNaLcl1U
h9Cl8gf9EBNZoNzYKneJHEiznwRASaz7MiWS6LXT4nWivZNfnV8kqjMy9TOCUgT5
Zu/el/iGE3NhWU3NOhQEN6Zmiv8EG5E5r7ZIxgAmD/KEUWguG7Dwl9Bw1wiiAQlT
KhQizXw5sJZ/ye7ZF5jIqKW/YIXKaJnRHmULMNjoSFd8jntdr6SUFZyFaDJaS0r2
c0BgZsvaJQqJOJJATa98a/0JeZBcwH1hd83aEXwI41n19BCU/pZ9JPGJJemsxtD9
1VGWTA6wSxpiQrS7eilU8PLVgGedtgrqEgg3YMocpMBo84XEsDBI2G5OdwZUydXb
jIh5Wg4oSonyYetTxc+pHL7IMdEYkg==
=jUm5
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

--===============3033992893230144795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3033992893230144795==--
