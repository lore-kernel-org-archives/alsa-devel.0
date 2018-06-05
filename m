From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.18
Date: Tue, 5 Jun 2018 15:49:21 +0100
Message-ID: <20180605144921.GC25374@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2483035829757753561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D43F6267909
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 16:49:26 +0200 (CEST)
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


--===============2483035829757753561==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.18

for you to fetch changes up to aac521e880f221e6d4e67b7061022dbecace0df0:

  Merge branch 'asoc-4.17' into asoc-4.18 merge window (2018-06-05 15:25:41=
 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.18

This is a very big update, mainly due to a huge set of new drivers some
of which are individually very large.  We also have a lot of fixes for
the topology stuff, several of the users have stepped up and fixed some
the serious issues there, and continued progress on the transition away
=66rom CODEC specific drivers to generic component drivers.

 - Many fixes for the topology code, including fixes for the half done
   v4 ABI compatibility from Guenter Roeck and other ABI fixes from
   Kirill Marinushkin.
 - Lots of cleanup for Intel platforms based on Realtek CODECs from Hans
   de Goode.
 - More followups on removing legacy CODEC things and transitioning to
   components from Morimoto-san.
 - Conversion of OMAP DMA to the new, more standard SDMA-PCM driver.
 - A series of fixes and updates to the rather elderly Cirrus Logic SoC
   drivers from Alexander Sverdlin.
 - Qualcomm DSP support from Srinivas Kandagatla.
 - New drivers for Analog SSM2305, Atmel I2S controllers, Mediatek
   MT6351, MT6797 and MT7622, Qualcomm DSPs, Realtek RT1305, RT1306 and
   RT5668 and TI TSCS454

----------------------------------------------------------------
Agrawal, Akshu (2):
      ASoC: AMD: Support headset button on Stoney DA7219
      ASoC: AMD: make channel 1 dma as circular

Akshu Agrawal (3):
      ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
      ASoC: AMD: Fix clocks in CZ DA7219 machine driver
      ASoC: AMD: Add const to snd_soc_ops instances

Alexander Sverdlin (5):
      ASoC: cirrus: i2s: Fix LRCLK configuration
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
      ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs
      ARM: ep93xx: i2s: Add IRQ to platform device resources
      ASoC: cirrus: i2s: IRQ-based stream watchdog

Andy Shevchenko (1):
      ASoC: rt5677: Convert I2C driver to ->probe_new()

Arnd Bergmann (4):
      ASoC: rsnd: mark PM functions __maybe_unused
      ASoC: omap: fix compile-test building
      ASoC: codecs: PCM1789: include gpio/consumer.h
      ASoC: mediatek: export mtk-afe symbols as needed

Bard Liao (2):
      ASoC: rt5668: add rt5668B codec driver
      ASoC: rt5670: improve PLL function's stability

Charles Keepax (7):
      ASoC: wm_adsp: Account for name prefixes when toggling preloader
      ASoC: compress: Only call free for components which have been opened
      ASoC: Remove platform code now everything is componentised
      ASoC: compress: Add helper functions for component open/free
      ASoC: core: Allow codec_conf DT lookups to match parent of_node
      ASoC: compress: Only assign compr->ops->copy once
      ASoC: compress: Fix up some trivial formatting issues

Colin Ian King (10):
      ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" -> "Stopping"
      ASoC: rt5668: fix incorrect 'and' operator
      ASoC: amd: fix spelling mistake: "failer" -> "failure"
      ASoC: Intel: bytcr_rt565: fix missing assignment to ret_val
      ASoC: nau8824: fix spelling mistake: "semaphone" -> "semaphore"
      ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing"
      ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"
      ASoC: wm8904: fix spelling mistake: "Caputure" -> "Capture"
      ASoC: wm2200,wm5100: fix spelling mistake: "Coefficeints" -> "Coeffic=
ients"
      ASoC: intel: skylake: fix spelling mistake: "Homogenous" -> "Homogene=
ous"

Cyrille Pitchen (2):
      ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller
      ASoC: atmel-i2s: add driver for the new Atmel I2S controller

Dan Carpenter (1):
      ASoC: topology: fix some tiny memory leaks

Daniel Mack (6):
      ASoC: core: fix return code in error message
      ASoC: pxa-ssp: allow more flexible setup order
      ASoC: pxa-ssp: simplify pxa_ssp_set_dai_sysclk()
      ASoC: wm8782: add device-tree matching table
      ASoC: make wm8782 codec selectable in Kconfig
      ASoC: simple-card: set cpu dai clk in hw_params

Danny Smith (2):
      ASoC: adau17x1: Handling of DSP_RUN register during fw setup
      ASoC: adau17x1: Do not reload dsp-fw if samplerate has not changed

Divya Prakash (1):
      ASoC: Intel: Skylake: Reset DSP pipe in skl_pcm_hw_free

Fabio Estevam (14):
      ASoC: sgtl5000: Fix the spelling of 'exceed'
      ASoC: sgtl5000: Switch to SPDX identifier
      ASoC: fsl_ssi: Use u32 variable type when using regmap_read()
      ASoC: fsl_ssi: Switch to SPDX identifier
      ASoC: fsl_sai: Switch to SPDX identifier
      ASoC: fsl_esai: Switch to SPDX identifier
      ASoC: fsl_spdif: Switch to SPDX identifier
      ASoC: sgtl5000: Make the node name generic
      ASoC: wm8962: Make the node name generic
      ASoC: wm8960: Make the node name generic
      ASoC: cs42xx8: Make the node name generic
      ASoC: fsl: Mark 'big-endian' property as optional
      ASoC: codec: wolfson: Make the node name generic
      ASoC: codec: realtek: Make the node name generic

Fengguang Wu (1):
      ASoC: rt1305: fix platform_no_drv_owner.cocci warnings

Geert Uytterhoeven (3):
      ASoC: Remove depends on HAS_DMA in case of platform dependency
      ASoC: sh: Drop SUPERH platform dependency
      ASoC: sh: Update menu title and platform dependency

Guenter Roeck (3):
      ASoC: topology: Improve backwards compatibility with v4 topology files
      ASoC: topology: Move v4 manifest header data structures to uapi
      ASoC: topology: Move skl-tplg-interface.h to uapi

Hans de Goede (26):
      ASoC: Intel: Disable SND_SOC_INTEL_BAYTRAIL when SND_SST_ATOM_HIFI2_P=
LATFORM is enabled
      ASoC: rt5640: Remove is_sys_clk_from_pll, it has ordering issues
      ASoC: rt5640: Add devicetree-bindings for dmic, jack-detect
      ASoC: rt5640: Remove unused rt5640_platform_data
      ASoC: rt5640: Move checking of device-properties to component probe c=
allback
      ASoC: rt5640: Allow specifying dmic data pins through device-properti=
es
      ASoC: rt5640: Add jack-detect support
      ASoC: rt5640: Add button press support
      ASoC: Intel: bytcr_rt5640: Configure PLL1 before using it
      ASoC: Intel: bytcr_rt5640: Use device-property for differential mics
      ASoC: rt5645: Add platform-data for Lenovo Ideapad Mixx 310
      ASoC: rt5645: Add platform-data for Lenovo Ideapad Mixx 320
      ASoC: Intel: bytcr_rt5640: Fix compile error
      ASoC: Intel: bytcr_rt5640: Use device properties for setting up dmic
      ASoC: Intel: bytcr_rt5640: Fix Dell Venue 8 5830 Pro quirk
      ASoC: Intel: bytcr_rt5640: Enable jack detection
      ASoC: Intel: bytcr_rt5640: Change BYTCR default input to IN3
      ASoC: Intel: bytcr_rt5640: Unify BYTCR input defaults
      ASoC: Intel: bytcr_rt5640: Add default jack-detect settings
      ASoC: Intel: bytcr_rt5640: Sort DMI quirk list alphabetically
      ASoC: Intel: bytcr_rt5640: Use dmi_first_match() for DMI quirk handli=
ng
      ASoC: Intel: bytcr_rt5640: Add quirks for various devices
      ASoC: Intel: bytcr_rt5640: Set card long_name based on quirks
      ASoC: Intel: cht_bsw_nau8824: Fix jack_type to include SND_JACK_MICRO=
PHONE
      ASoC: Intel: bytcr_rt5640: Add quirk for the ARCHOS 80 Cesium 8" wind=
ows tablet
      ASoC: Intel: bytcr_rt5651: Set card long_name based on quirks

Jarkko Nikula (1):
      ASoC: omap: Remove OMAP_MUX dependency from Nokia N810 audio support

Jean-Jacques Hiblot (3):
      ASoC: tas6424: Add support for the standby pin
      ASoC: tas6424: Add support for the mute pin
      ASoC: tas6424: Allow disabling auto diagnostics for faster power-on

Jerome Brunet (1):
      ASoC: dai playback and capture active may be greater than 1

Jia-Ju Bai (8):
      ASoC: intel: bxt_da7219_max98357a: Replace GFP_ATOMIC with GFP_KERNEL=
 in broxton_audio_probe
      ASoC: intel: bxt_rt298: Replace GFP_ATOMIC with GFP_KERNEL in broxton=
_audio_probe
      ASoC: intel: bytcr_rt5640: Replace GFP_ATOMIC with GFP_KERNEL in snd_=
byt_rt5640_mc_probe
      ASoC: intel: cht_bsw_max98090_ti: Replace GFP_ATOMIC with GFP_KERNEL =
in snd_cht_mc_probe
      ASoC: intel: cht_bsw_rt5645: Replace GFP_ATOMIC with GFP_KERNEL in sn=
d_cht_mc_probe
      ASoC: intel: skl_nau88l25_max98357a: Replace GFP_ATOMIC with GFP_KERN=
EL in skylake_audio_probe
      ASoC: intel: skl_nau88l25_ssm4567: Replace GFP_ATOMIC with GFP_KERNEL=
 in skylake_audio_probe
      ASoC: intel: skl_rt286: Replace GFP_ATOMIC with GFP_KERNEL in skylake=
_audio_probe

John Hsu (2):
      ASoC: nau8824: user configuration of key detection
      ASoC: nau8810: change input PGA mixer stage

Jon Hunter (1):
      ASoC: core: Fix return code shown on error for hw_params

Kai Chieh Chuang (15):
      ASoC: mt6797: add mt6797 platform driver
      ASoC: mediatek: add documents for mt6797
      ASoC: add mt6351 codec driver
      ASoC: mt6351 switch to SPDX license tag
      ASoC: add mt6797-mt6351 driver and config option
      ASoC: mt6797: add structure define and clock control function for 6797
      ASoC: mt6797: switch to SPDX license tag
      ASoC: mediatek: preallocate pages use platform device
      ASoC: mediatek: preallocate pages use platform device
      ASoC: mediatek: avoid using snd_soc_platform
      ASoC: dpcm: fix BE dai not hw_free and shutdown
      ASoC: dpcm: symmetry constraint on FE substream
      ASoC: mt6797: add PCM interface
      ASoC: mt6797: add Hostless DAI
      ASoC: mt6797-mt6351: add hostless phone call path

KaiChieh Chuang (3):
      ASoC: mediatek: add sub dai to mtk_base_afe
      ASoC: mt6797: extract DAI adda in separate file
      ASoC: mt6797: combine DAI to register component

Katsuhiro Suzuki (3):
      ASoC: uniphier: remove boilerplate from lisence comment
      ASoC: uniphier: evea: use DAPM to change source of line-in
      ASoC: uniphier: add digital output volume for UniPhier sound system

Kirill Marinushkin (4):
      ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
      ASoC: topology: Add missing clock gating parameter when parsing hw_co=
nfigs
      ASoC: topology: Add definitions for mclk_direction values
      ASoC: topology: Modify clock gating parameter parsing to switch

Kuninori Morimoto (19):
      ASoC: doc: replace codec to component
      ASoC: trace: remove snd_soc_codec
      ASoC: wm8350: remove snd_soc_codec
      ASoC: rsnd: makes rsnd_cmd_mod_get() static
      ASoC: rsnd: add RSND_GEN3 for R-Car Gen3
      ASoC: rsnd: don't assume node full path name for HDMI probing
      ASoC: rsnd: Enable IPMMU v2
      ASoC: rsnd: ssi: wait maximum 5ms for status check
      media: i2c: tda1997: replace codec to component
      ASoC: remove codec hw_write/control_data
      ASoC: remove codec reg_cache
      ASoC: remove .get_regmap
      ASoC: remove unneeded .pcm_new/free
      ASoC: remove Codec related code
      ASoC: add component_list_show()
      ASoC: convert platform explanation to component
      ASoC: soc.h: merge CONFIG_DEBUG_FS
      ASoC: soc-core: remove snd_soc_component_add_unlocked()
      ASoC: soc-core: remove legacy_dai_naming from snd_soc_register_dais()

Liam Girdwood (6):
      ASoC: topology: Check widget kcontrols before deref
      ASoC: core: Allow topology to override machine driver FE DAI link con=
fig.
      ASoC: core: Add name prefix for machines with topology rewrites
      ASoC: topology: Give more data to clients via callbacks
      ASoC: topology: Add callback for DAPM route load/unload
      ASoC: topology: Add support for compressed PCMs

Lin Huang (1):
      ASoC: rockchip: cdn-dp sound output use spdif

Mac Chiang (1):
      ASoC: Intel: kbl: Move codec sysclk config to codec_init function

Marco Felsch (2):
      ASoC: ssm2305: Add amplifier driver
      ASoC: ssm2305: fix header layout

Mark Brown (7):
      Merge branch 'asoc-4.17' into asoc-4.18 to get adau17x1 changes so fu=
rther patches can be applied.
      ASoC: topology: Fix build errors
      ASoC: topology: Revert recent changes while boot errors are investiga=
ted
      Merge branch 'asoc-4.17' into asoc-4.18 for compress dependencies
      Merge branch 'asoc-4.17' into asoc-4.18 n810 dependencies
      Merge remote-tracking branch 'asoc/for-4.17' into asoc-4.18 to resolv=
e a conflict between a fix and new development in mtk
      Merge branch 'asoc-4.17' into asoc-4.18 merge window

Mukunda, Vijendar (6):
      ASoC: amd: fixed checkpatch pl warnings
      ASoC: amd: rename audio_substream_data variable
      ASoC: amd: pte offset related dma driver changes
      ASoC: amd: sram bank update changes
      ASoC: amd: memory release for rtd structure
      ASoC: amd: dma driver changes for bt i2s instance

Nicolin Chen (3):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
      ASoC: fsl_ssi: Fix mode setting when changing channel number
      ASoC: fsl_esai: Add freq check in set_dai_sysclk()

Oder Chiou (1):
      ASoC: rt5663: Use the set_jack() instead of the export function

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Reset DSP Pipelines in prepare

Paul Handrigan (1):
      ASoC: cs35l35: Add use_single_rw to regmap config

Peter Rosin (6):
      ASoC: max9860: switch to using .probe_new
      ASoC: max9860: fix whitespace issues caused by mindless conversion
      ASoC: tfa9879: fix whitespace issues caused by mindless conversion
      ASoC: tfa9879: switch to using .probe_new
      ASoC: tfa9879: switch to SPDX license tag
      ASoC: max9860: switch to SPDX license tag

Peter Ujfalusi (12):
      ASoC: omap: n810: Correct the card level dapm_route
      ASoC: omap: n810: Correct the cpu_dai, platform and codec name
      ASoC: omap: n810: HS mic is not working, add a widget for it with com=
ment
      ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm
      ASoC: omap-hdmi-audio: Convert to use the sdma-pcm instead of omap-pcm
      ASoC: omap-dmic: Convert to use the sdma-pcm instead of omap-pcm
      ASoC: omap-mcpdm: Convert to use the sdma-pcm instead of omap-pcm
      ASoC: omap-mcbsp: Convert to use the sdma-pcm instead of omap-pcm
      ASoC: davinci-mcasp: Convert to use the sdma-pcm instead of omap-pcm
      ASoC: omap: Delete the obsolete omap-pcm
      ASoC: omap: sdma-pcm: Fix modpost warning
      ASoC: omap: sdma-pcm: Correction for the include files

Philipp Zabel (1):
      ASoC: imx-audmux: add RXFS/RXCLK defines for 6-wire connections

Pierre-Louis Bossart (5):
      ASoC: Intel: atom: fix ACPI/PCI Kconfig
      ASoC: Intel: cht-bsw-rt5672: allow for topology-defined codec-dai set=
up
      MAINTAINERS: update sound/soc/intel maintainers
      ASoC: pcm512x: Add ACPI support
      ASoC: fix 0-day warnings with snd_soc_new_compress()

Pradeep Tewani (1):
      ASoC: Intel: Skylake: Unify the fw ops for SKL and KBL

Pravin Shedge (1):
      ASoC: zte: remove duplicate includes

Rakesh Ughreja (1):
      ASoC: Intel: Skylake: Reset stream to link mapping

Ryder Lee (7):
      ASoC: mediatek: use snd_soc_dai_get_drvdata() to get the private data
      ASoC: mediatek: simplify the control logic of MT2701 I2S
      ASoC: mediatek: Add MTK_STREAM_NUM to mtk-base-afe.h
      ASoC: mediatek: add MT7622 AFE support
      ASoC: mediatek: add MT7622 AFE compatible in documentation
      ASoC: mediatek: switch to SPDX license tag
      ASoC: mediatek: add the .probe() callback in mt2701_afe_pcm_dai_compo=
nent

Shuming Fan (2):
      ASoC: rt1305: Add RT1305/RT1306 amplifier driver
      ASoC: rt1305: fix ACPI_PTR compile error

Srinivas Kandagatla (32):
      ASoC: msm8916-wcd-analog: use threaded context for mbhc events
      soc: qcom dt-bindings: Add APR bus bindings
      soc: qcom: Add APR bus driver
      ASoC: qdsp6: dt-bindings: Add q6core dt bindings
      ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
      ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
      ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
      ASoC: qdsp6: q6common: Add qdsp6 helper functions
      ASoC: qdsp6: q6core: Add q6core driver
      soc: qcom: apr: fix invalid msg_type check
      ASoC: qdsp6: q6afe: Add q6afe driver
      ASoC: qdsp6: qdafe: Add SLIMBus port Support
      ASoC: qdsp6: q6afe: Add support to MI2S ports
      ASoC: qdsp6: q6afe: Add support to MI2S sysclks
      ASoC: qdsp6: q6adm: Add q6adm driver
      ASoC: qdsp6: q6asm: Add q6asm driver
      ASoC: qdsp6: q6asm: Add support to memory map and unmap
      ASoC: qdsp6: q6asm: Add support to audio stream apis
      ASoC: qdsp6: q6routing: Add q6routing driver
      ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
      ASoC: qdsp6: q6routing: Add support to MI2S Mixers
      ASoC: qdsp6: q6afe: Add q6afe dai driver
      ASoC: qdsp6: q6asm: Add q6asm dai driver
      ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
      ASoC: qcom: apq8096: Add db820c machine driver
      ASoC: qdsp6: dt-bindings: Add q6afe tdm dt binding
      ASoC: qdsp6: qdafe: add support to tdm ports
      ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S
      ASoC: qdsp6: q6afe-dai: add support to tdm dais
      ASoC: qdsp6: q6routing: Add macros for mixers
      ASoC: qdsp6: q6routing: Add support to all TDM Mixers
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Steven Eckhoff (4):
      ASoC: TSCS42xx: Shorten lines and other cleanup
      ASoC: TSCS42xx: Cleanup private data members
      ASoC: TSCS42xx: Add CCF support to get sysclk
      ASoC: TSCS454: Add Support

Tero Kristo (1):
      ASoC: dmic: Fix clock parenting

Vijendar Mukunda (3):
      ASoC: amd: dma config parameters changes
      ASoC: amd: added byte count register offset variables to rtd
      ASoC: amd: removed separate byte count variables for playback and cap=
ture

Vinod Koul (8):
      ASoC: Intel: byt-max98090: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: bytcht_es8316: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: bytcr_rt5651: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: cht_bsw_nau8824: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: kbl_da7219_max98357a: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: kbl_rt5663_max98927: Replace GFP_ATOMIC with GFP_KERNEL
      ASoC: Intel: kbl_rt5663_rt5514_max98927: Replace GFP_ATOMIC with GFP_=
KERNEL
      ASoC: Update email address for Vinod

Vishal Thanki (1):
      ASoC: davinci-mcasp: Only disable inactive serializer

Wei Yongjun (3):
      ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static
      ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static
      ASoC: fix return value check in mt6351_codec_driver_probe()

Wolfram Sang (1):
      ASoC: atmel: simplify getting .drvdata

Xie Yisheng (3):
      ASoC: max98088: use match_string() helper
      ASoC: max98095: use match_string() helper
      ASoC: dapm: use match_string() helper

Yan Wang (1):
      ASoC: topology: Fix bugs of freeing soc topology

kbuild test robot (1):
      ASoC: rt5663: rt5663_set_jack_detect() can be static

oder_chiou@realtek.com (2):
      ASoC: rt5514: Add the missing register in the readable table
      ASoC: rt5663: Optimize the power consumption

 .mailmap                                           |    3 +
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   84 +
 .../devicetree/bindings/sound/adi,ssm2305.txt      |   14 +
 .../devicetree/bindings/sound/atmel-i2s.txt        |   47 +
 .../devicetree/bindings/sound/cs42xx8.txt          |    2 +-
 .../devicetree/bindings/sound/fsl,asrc.txt         |   10 +-
 .../devicetree/bindings/sound/fsl,esai.txt         |    2 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |    2 +
 .../devicetree/bindings/sound/fsl-sai.txt          |    8 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |    4 +-
 Documentation/devicetree/bindings/sound/mt6351.txt |   16 +
 .../devicetree/bindings/sound/mt6797-afe-pcm.txt   |   42 +
 .../devicetree/bindings/sound/mt6797-mt6351.txt    |   14 +
 .../devicetree/bindings/sound/qcom,apq8096.txt     |  109 +
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   33 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |  172 +
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   33 +
 .../devicetree/bindings/sound/qcom,q6core.txt      |   21 +
 Documentation/devicetree/bindings/sound/rt274.txt  |    2 +-
 Documentation/devicetree/bindings/sound/rt5514.txt |    2 +-
 Documentation/devicetree/bindings/sound/rt5616.txt |    2 +-
 Documentation/devicetree/bindings/sound/rt5640.txt |   35 +
 Documentation/devicetree/bindings/sound/rt5645.txt |    2 +-
 Documentation/devicetree/bindings/sound/rt5651.txt |    2 +-
 Documentation/devicetree/bindings/sound/rt5663.txt |    2 +-
 Documentation/devicetree/bindings/sound/rt5668.txt |   50 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    2 +-
 .../devicetree/bindings/sound/simple-card.txt      |    5 +
 .../devicetree/bindings/sound/ti,tas6424.txt       |    2 +
 .../devicetree/bindings/sound/tscs42xx.txt         |    6 +
 .../devicetree/bindings/sound/tscs454.txt          |   23 +
 Documentation/devicetree/bindings/sound/wm8510.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8523.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8524.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8580.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8711.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8728.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8731.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8737.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8741.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8750.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8753.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8770.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8776.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8804.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8903.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8960.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8962.txt |    2 +-
 Documentation/devicetree/bindings/sound/wm8994.txt |    2 +-
 Documentation/sound/soc/codec.rst                  |    8 +-
 Documentation/sound/soc/platform.rst               |   30 +-
 MAINTAINERS                                        |   11 +-
 arch/arm/mach-ep93xx/core.c                        |    1 +
 drivers/media/i2c/tda1997x.c                       |   25 +-
 drivers/soc/qcom/Kconfig                           |    9 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  378 +++
 include/dt-bindings/soc/qcom,apr.h                 |   28 +
 include/dt-bindings/sound/fsl-imx-audmux.h         |    7 +
 include/dt-bindings/sound/qcom,q6afe.h             |  111 +
 include/dt-bindings/sound/qcom,q6asm.h             |   22 +
 include/dt-bindings/sound/rt5640.h                 |   25 +
 include/linux/mfd/wm8350/audio.h                   |    3 -
 include/linux/mod_devicetable.h                    |   11 +
 include/linux/soc/qcom/apr.h                       |  128 +
 include/sound/omap-pcm.h                           |   30 -
 include/sound/rt5640.h                             |   27 -
 include/sound/rt5668.h                             |   40 +
 include/sound/soc-dai.h                            |    5 +-
 include/sound/soc.h                                |  397 +--
 include/trace/events/asoc.h                        |    1 -
 include/uapi/sound/asoc.h                          |   86 +-
 .../uapi/sound}/skl-tplg-interface.h               |   85 +-
 sound/soc/Makefile                                 |    2 +-
 sound/soc/amd/acp-da7219-max98357a.c               |   92 +-
 sound/soc/amd/acp-pcm-dma.c                        |  623 ++--
 sound/soc/amd/acp.h                                |   97 +-
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-i2s.c                        |  765 +++++
 sound/soc/atmel/atmel_ssc_dai.c                    |    8 +-
 sound/soc/bcm/Kconfig                              |    3 +-
 sound/soc/cirrus/Kconfig                           |   17 +
 sound/soc/cirrus/edb93xx.c                         |    2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |  106 +-
 sound/soc/cirrus/snappercl15.c                     |    2 +-
 sound/soc/codecs/Kconfig                           |   33 +-
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/adau17x1.c                        |   35 +-
 sound/soc/codecs/adau17x1.h                        |    3 +-
 sound/soc/codecs/cs35l35.c                         |    1 +
 sound/soc/codecs/max98088.c                        |   13 +-
 sound/soc/codecs/max98095.c                        |   13 +-
 sound/soc/codecs/max9860.c                         |   44 +-
 sound/soc/codecs/max9860.h                         |   10 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    9 +-
 sound/soc/codecs/mt6351.c                          | 1505 +++++++++
 sound/soc/codecs/mt6351.h                          |  105 +
 sound/soc/codecs/nau8810.c                         |   19 +-
 sound/soc/codecs/nau8824.c                         |   13 +-
 sound/soc/codecs/pcm1789.c                         |    2 +-
 sound/soc/codecs/pcm512x-i2c.c                     |   17 +-
 sound/soc/codecs/rt1305.c                          | 1191 +++++++
 sound/soc/codecs/rt1305.h                          |  276 ++
 sound/soc/codecs/rt5514.c                          |    3 +
 sound/soc/codecs/rt5640.c                          |  553 +++-
 sound/soc/codecs/rt5640.h                          |   46 +-
 sound/soc/codecs/rt5645.c                          |   23 +
 sound/soc/codecs/rt5663.c                          |   55 +-
 sound/soc/codecs/rt5663.h                          |    2 -
 sound/soc/codecs/rt5668.c                          | 2639 +++++++++++++++
 sound/soc/codecs/rt5668.h                          | 1318 ++++++++
 sound/soc/codecs/rt5670.c                          |    2 +-
 sound/soc/codecs/rt5677.c                          |   13 +-
 sound/soc/codecs/sgtl5000.c                        |   18 +-
 sound/soc/codecs/sgtl5000.h                        |    5 +-
 sound/soc/codecs/ssm2305.c                         |  104 +
 sound/soc/codecs/tas6424.c                         |   72 +-
 sound/soc/codecs/tas6424.h                         |    4 +
 sound/soc/codecs/tfa9879.c                         |   48 +-
 sound/soc/codecs/tfa9879.h                         |    7 +-
 sound/soc/codecs/tscs42xx.c                        |  203 +-
 sound/soc/codecs/tscs42xx.h                        |    2 +-
 sound/soc/codecs/tscs454.c                         | 3497 ++++++++++++++++=
++++
 sound/soc/codecs/tscs454.h                         | 2323 +++++++++++++
 sound/soc/codecs/wm2200.c                          |    4 +-
 sound/soc/codecs/wm5100.c                          |    8 +-
 sound/soc/codecs/wm8782.c                          |    9 +
 sound/soc/codecs/wm8904.c                          |    2 +-
 sound/soc/codecs/wm_adsp.c                         |    8 +-
 sound/soc/davinci/Kconfig                          |    2 +-
 sound/soc/davinci/davinci-mcasp.c                  |   10 +-
 sound/soc/fsl/fsl_esai.c                           |   27 +-
 sound/soc/fsl/fsl_esai.h                           |    5 +-
 sound/soc/fsl/fsl_sai.c                            |   16 +-
 sound/soc/fsl/fsl_sai.h                            |    5 +-
 sound/soc/fsl/fsl_spdif.c                          |   24 +-
 sound/soc/fsl/fsl_spdif.h                          |    5 +-
 sound/soc/fsl/fsl_ssi.c                            |   74 +-
 sound/soc/fsl/fsl_ssi.h                            |    6 +-
 sound/soc/fsl/fsl_ssi_dbg.c                        |   18 +-
 sound/soc/generic/simple-card.c                    |   21 +
 sound/soc/hisilicon/hi6210-i2s.c                   |    2 +-
 sound/soc/intel/Kconfig                            |   24 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |    2 +-
 sound/soc/intel/boards/bxt_rt298.c                 |    2 +-
 sound/soc/intel/boards/byt-max98090.c              |    2 +-
 sound/soc/intel/boards/bytcht_es8316.c             |    2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  568 +++-
 sound/soc/intel/boards/bytcr_rt5651.c              |   18 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |    2 +-
 sound/soc/intel/boards/cht_bsw_nau8824.c           |    4 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   30 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |   19 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    5 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    4 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |    2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |    2 +-
 sound/soc/intel/boards/skl_rt286.c                 |    2 +-
 sound/soc/intel/skylake/skl-debug.c                |    6 +-
 sound/soc/intel/skylake/skl-messages.c             |    4 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   36 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |    3 -
 sound/soc/intel/skylake/skl-sst.c                  |   34 +-
 sound/soc/intel/skylake/skl-topology.c             |  171 +-
 sound/soc/intel/skylake/skl-topology.h             |    2 +-
 sound/soc/intel/skylake/skl.c                      |    7 +
 sound/soc/kirkwood/Kconfig                         |    1 -
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    2 +
 sound/soc/mediatek/common/Makefile                 |   14 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   30 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.h         |   10 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |  103 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |   22 +-
 sound/soc/mediatek/common/mtk-base-afe.h           |   30 +-
 sound/soc/mediatek/mt2701/Makefile                 |   14 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |   66 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   23 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |   38 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |  349 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |   13 +-
 sound/soc/mediatek/mt2701/mt2701-reg.h             |   11 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |   10 +-
 sound/soc/mediatek/mt6797/Makefile                 |   14 +
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         |  123 +
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h         |   17 +
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      |   58 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |  914 +++++
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c        |  396 +++
 sound/soc/mediatek/mt6797/mt6797-dai-hostless.c    |  112 +
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c         |  312 ++
 sound/soc/mediatek/mt6797/mt6797-interconnection.h |   33 +
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          |  223 ++
 sound/soc/mediatek/mt6797/mt6797-reg.h             | 1015 ++++++
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      |   10 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |   38 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   10 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |   10 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   10 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   10 +-
 sound/soc/omap/Kconfig                             |   28 +-
 sound/soc/omap/Makefile                            |    4 +-
 sound/soc/omap/n810.c                              |   21 +-
 sound/soc/omap/omap-dmic.c                         |   18 +-
 sound/soc/omap/omap-hdmi-audio.c                   |    5 +-
 sound/soc/omap/omap-mcbsp.c                        |    4 +-
 sound/soc/omap/omap-mcpdm.c                        |    4 +-
 sound/soc/omap/omap-pcm.c                          |  262 --
 sound/soc/omap/sdma-pcm.c                          |   74 +
 sound/soc/omap/sdma-pcm.h                          |   21 +
 sound/soc/pxa/Kconfig                              |    1 -
 sound/soc/pxa/pxa-ssp.c                            |   88 +-
 sound/soc/qcom/Kconfig                             |   57 +-
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  255 ++
 sound/soc/qcom/qdsp6/Makefile                      |    8 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  646 ++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   27 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   | 1303 ++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       | 1495 +++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |  211 ++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  624 ++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1399 ++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   69 +
 sound/soc/qcom/qdsp6/q6core.c                      |  380 +++
 sound/soc/qcom/qdsp6/q6core.h                      |   15 +
 sound/soc/qcom/qdsp6/q6dsp-common.c                |   66 +
 sound/soc/qcom/qdsp6/q6dsp-common.h                |   24 +
 sound/soc/qcom/qdsp6/q6dsp-errno.h                 |   51 +
 sound/soc/qcom/qdsp6/q6routing.c                   | 1006 ++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 sound/soc/rockchip/rk3399_gru_sound.c              |   46 +-
 sound/soc/sh/Kconfig                               |    6 +-
 sound/soc/sh/rcar/cmd.c                            |   15 +-
 sound/soc/sh/rcar/core.c                           |   53 +-
 sound/soc/sh/rcar/dma.c                            |   11 +-
 sound/soc/sh/rcar/gen.c                            |    3 +-
 sound/soc/sh/rcar/rsnd.h                           |    4 +-
 sound/soc/sh/rcar/ssi.c                            |   13 +-
 sound/soc/soc-cache.c                              |   53 -
 sound/soc/soc-compress.c                           |  385 +--
 sound/soc/soc-core.c                               |  794 +----
 sound/soc/soc-dapm.c                               |   20 +-
 sound/soc/soc-devres.c                             |   35 -
 sound/soc/soc-io.c                                 |   83 -
 sound/soc/soc-jack.c                               |   22 -
 sound/soc/soc-pcm.c                                |  147 +-
 sound/soc/soc-topology.c                           |  107 +-
 sound/soc/uniphier/aio-compress.c                  |   13 -
 sound/soc/uniphier/aio-core.c                      |   71 +-
 sound/soc/uniphier/aio-cpu.c                       |  153 +-
 sound/soc/uniphier/aio-dma.c                       |   13 -
 sound/soc/uniphier/aio-ld11.c                      |   13 -
 sound/soc/uniphier/aio-reg.h                       |   46 +-
 sound/soc/uniphier/aio.h                           |   20 +-
 sound/soc/uniphier/evea.c                          |   55 +-
 sound/soc/zte/zx-i2s.c                             |    5 +-
 259 files changed, 29849 insertions(+), 3997 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6351.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-afe-pcm.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-mt6351.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5668.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tscs454.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/dt-bindings/soc/qcom,apr.h
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
 create mode 100644 include/dt-bindings/sound/rt5640.h
 create mode 100644 include/linux/soc/qcom/apr.h
 delete mode 100644 include/sound/omap-pcm.h
 delete mode 100644 include/sound/rt5640.h
 create mode 100644 include/sound/rt5668.h
 rename {sound/soc/intel/skylake =3D> include/uapi/sound}/skl-tplg-interfac=
e.h (71%)
 create mode 100644 sound/soc/atmel/atmel-i2s.c
 create mode 100644 sound/soc/codecs/mt6351.c
 create mode 100644 sound/soc/codecs/mt6351.h
 create mode 100644 sound/soc/codecs/rt1305.c
 create mode 100644 sound/soc/codecs/rt1305.h
 create mode 100644 sound/soc/codecs/rt5668.c
 create mode 100644 sound/soc/codecs/rt5668.h
 create mode 100644 sound/soc/codecs/ssm2305.c
 create mode 100644 sound/soc/codecs/tscs454.c
 create mode 100644 sound/soc/codecs/tscs454.h
 create mode 100644 sound/soc/mediatek/mt6797/Makefile
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-common.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-interconnection.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-mt6351.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-reg.h
 delete mode 100644 sound/soc/omap/omap-pcm.c
 create mode 100644 sound/soc/omap/sdma-pcm.c
 create mode 100644 sound/soc/omap/sdma-pcm.h
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h
 delete mode 100644 sound/soc/soc-cache.c

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsWovAACgkQJNaLcl1U
h9DLWgf9E6ya1PBUgiqB5nskdE77hsHsqfq9h9dwuSJsVJ/MTX+KK1nvDwvnFAxS
Bh87Ou7wWcNyhDdBdP6f60Wk8stbW7pitVOHKO5UbhOLYM5aMdsfH6ynBSrM315z
wSaBRbJ41JSH0Hr94F9jeTj88NitgNw4qGPsFIY4w8QRmu3Oj6eEDXqqeBC+P9sj
TVC89FV/Sf75pc8hudZbpTM6/qAXqe80aPJuAtd6WPoDK7bKrxc8Os3SfM4zv2Lw
TVd7TWfkoOMQIDMslu6g08MDeTEMH+L3XSCWshsEzeRULsmk8iSWmWl541DlOwBP
GO9buINyjBkpfhnEj66zcPUycvvV5A==
=6HKK
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

--===============2483035829757753561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2483035829757753561==--
