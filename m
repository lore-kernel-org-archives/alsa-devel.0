From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v5.1
Date: Fri, 8 Feb 2019 12:53:44 +0000
Message-ID: <20190208125344.GA26529@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7346981497139889765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A1F2267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 13:53:45 +0100 (CET)
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


--===============7346981497139889765==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v5.1

for you to fetch changes up to a50e32694fbcdbf55875095258b9398e2eabd71f:

  ASoC: codecs: jz4725b: Use C++ style comments in header (2019-02-07 14:38=
:49 +0000)

----------------------------------------------------------------
ASoC: Updates for v5.1

Lots and lots of new drivers so far, a highlight being the MediaTek
BTCVSD which is a driver for a Bluetooth radio chip - the first such
driver we've had upstream.  Hopefully we will soon also see a baseband
with an upstream driver!

 - Support for only powering up channels that are actively being used.
 - Quite a few improvements to simplify the generic card drivers,
   especially the merge of the SCU cards into the main generic drivers.
 - Lots of fixes for probing on Intel systems, trying to rationalize
   things to look more standard from a framework point of view.
 - New drivers for Asahi Kasei Microdevices AK4497, Cirrus Logic CS4341,
   Google ChromeOS embedded controllers, Ingenic JZ4725B, MediaTek
   BTCVSD, MT8183 and MT6358, NXP MICFIL, Rockchip RK3328, Spreadtrum
   DMA controllers, Qualcomm WCD9335, Xilinx S/PDIF and PCM formatters.

----------------------------------------------------------------
Adam Thomson (2):
      ASoC: da7219: MCLK should be enabled before DAI clocks
      ASoC: da7219: Add recalc_rate function to return DAI clock rate

Agrawal, Akshu (1):
      ASoC: ADAU7002: Add optional delay before start of capture

Alexander Shiyan (2):
      ASoC: cs4341: Add driver for CS4341 DAC
      ASoC: cs4341: Add DT bindings documentation for CS4341 DAC

Alison Wang (1):
      ASoC: sgtl5000: Allow SCLK pad drive strength to be changed

Amadeusz S=C5=82awi=C5=84ski (3):
      ASoC: topology: Reduce number of dereferences when accessing dobj
      ASoC: topology: Remove widgets from dobj list
      ASoC: topology: Fix memory leak from soc_tplg_denum_create_texts

Anders Roxell (1):
      ASoC: cs4341: fix waring unused-function

Axel Lin (1):
      ASoC: msm8916-wcd-digital: Select REGMAP_MMIO to fix build error

Baolin Wang (2):
      dt-bindings: ASoC: Add Spreadtrum DMA platform documentation
      ASoC: sprd: Add Spreadtrum audio DMA platfrom driver

Bard liao (7):
      ASoC: rt5645: remove unused mux define
      ASoC: rt5670: remove unused mux/mixer define
      ASoC: rt5645: store eq kcontrol byte in __be
      ASoC: rl6437a: use __be32 for a __be32 buf
      ASoC: rt5682: add default pdata for i2s mode
      ASoC: topology: fix memory leak in soc_tplg_dapm_widget_create
      ASoC: topology: unload physical dai link in remove

Charles Keepax (6):
      ASoC: core: Allow soc_find_component lookups to match parent of_node
      ASoC: arizona: Add channel numbers to AIFs
      ASoC: dapm: Only power up active channels from a DAI
      ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked
      ASoC: compress: Clarify the intent of current compressed ops handling
      ASoC: compress: Add helper functions for component trigger/set_params

Cheng-Yi Chiang (4):
      ASoC: qcom: Kconfig: select max98927 for sdm845
      ASoC: sdm845: Set DAI format for dmic codec
      ASoC: Documentation: Add google, cros-ec-codec
      ASoC: cros_ec_codec: Add codec driver for Cros EC

Cl=C3=A9ment P=C3=A9ron (1):
      ASoC: ak4118: fix missing header

Colin Ian King (3):
      ASoC: Intel: make const arrays static, reduces object code size
      ASoC: mediatek: btcvsd: fix spelling mistake "offest" -> "offset"
      ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deempha=
size"

Cosmin Samoila (2):
      ASoC: micfil: Add bindings for MICFIL DAI
      ASoC: Add MICFIL SoC Digital Audio Interface driver.

Curtis Malainey (1):
      ASoC: soc-core: clear platform pointers on error

Dan Carpenter (1):
      ASoC: wcd9335: remove some unnecessary NULL checks

Daniel Baluta (2):
      ASoC: ak4458: Add support for AK4497
      ASoC: dt-bindings: Document support for ak4497

Daniel Mack (1):
      ASoC: eliminate left-over from Raumfeld machine driver removal

Danny Milosavljevic (8):
      ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2 input
      ASoC: sun4i-codec: Add Mic Playback Volume
      ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec
      ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume
      ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and sun4i_co=
dec_right_mixer_controls into sun4i_codec_mixer_controls
      ASoC: sun4i-codec: Add Mic1 Playback Switch, Mic2 Playback Switch
      ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM Play=
back Switch
      ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line =
Right, Line Left, Line Playback Switch

Dimitris Papavasiliou (2):
      ASoC: pcm512x: Implement the set_bclk_ratio interface
      ASoC: pcm512x: Fix clocking calculations when not using the PLL

Fabio Estevam (1):
      ASoC: MAINTAINERS: fsl: Change Fabio's email address

Guennadi Liakhovetski (1):
      ASoC: topology: fix oops/use-after-free case with dai driver

Gustavo A. R. Silva (1):
      ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe

Hans de Goede (17):
      ASoC: es8316: Add jack-detect support
      ASoC: es8316: Add DAC mono mix switch mixer control
      ASoC: Intel: bytcht_es8316: Sort includes alphabetically
      ASoC: Intel: bytcht_es8316: Minor refactoring
      ASoC: Intel: bytcht_es8316: Add support for SSP0 (BYTCR)
      ASoC: Intel: bytcht_es8316: Add jack-detect support
      ASoC: Intel: bytcht_es8316: Add external speaker mux support
      ASoC: Intel: bytcht_es8316: Add input-map support
      ASoC: Intel: bytcht_es8316: Set card long_name based on quirks
      ASoC: Intel: Add ACPI match table entry for ES8316 codec on BYTCR pla=
tform
      ASoC: Intel: common: Add quirk for PoV P1006W tablet
      ASoC: rt5651: Add ACPI ID 10EC5640
      ASoC: rt5651: Add support for jack detect using an external GPIO
      ASoC: Intel: bytcr_rt5651: Revert "Fix DMIC map headsetmic mapping"
      ASoC: Intel: bytcr_rt5651: Add quirks module parameter
      ASoC: Intel: bytcr_rt5651: Add support for jack-detect using an exter=
nal GPIO
      ASoC: Intel: bytcr_rt5651: Add quirk for PoV TAB-P1006W-232 (v1.0) ta=
blet

KaiChieh Chuang (2):
      ASoC: mediatek: add documents for btcvsd driver
      ASoC: mediatek: add btcvsd driver

Katsuhiro Suzuki (2):
      ASoC: rockchip: support ACODEC for rk3328
      ASoC: rockchip: add workaround for silence of rk3288 ACODEC

Kuninori Morimoto (31):
      ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get=
_dai_id()
      ASoC: audio-graph-card: add asoc_graph_card_get_conversion()
      ASoC: audio-graph-scu-card: remove audio-graph-scu-card on Doc
      ASoC: audio-graph-scu-card: remove audio-graph-scu-card
      ASoC: simple-scu-card: remove simple-scu-card on Doc
      ASoC: simple-scu-card: remove simple-scu-card
      ASoC: audio-graph-card: add 1 CPU : 1 Codec support again
      ASoC: audio-graph-card: add link_info
      ASoC: audio-graph-card: cleanup DAI link loop method - step1
      ASoC: audio-graph-card: cleanup DAI link loop method - step2
      ASoC: audio-graph-card: reduce naming prefix
      ASoC: simple-card: add asoc_simple_card_get_conversion()
      ASoC: simple-card: add 1 CPU : 1 Codec support again
      ASoC: simple-card: add link_info
      ASoC: simple-card: cleanup DAI link loop method - step1
      ASoC: simple-card: cleanup DAI link loop method - step2
      ASoC: simple-card: reduce naming prefix
      ASoC: rsnd: update BSDSR/BSDISR handling
      ASoC: soc.h: add explanation of legacy/modern style of dai_link
      ASoC: soc-core: add .num_platform for dai_link
      ASoC: soc-core: add new snd_soc_flush_all_delayed_work()
      ASoC: soc-core: merge card resources cleanup method
      ASoC: soc-core: reduce if/else nest on soc_probe_link_dais
      ASoC: soc-core: add soc_cleanup_component()
      ASoC: soc-core: use for_each_link_codecs() for dai_link codecs
      ASoC: simple-card: rename to asoc_simple_card_canonicalize_platform()
      ASoC: Fixup build error for mt6358
      ASoC: soc-core: use for_each_link_codecs() for dai_link codecs V2
      ASoC: rsnd: fixup MIX kctrl registration
      ASoC: rsnd: synchronize connection check for simple-card/audio-graph
      ASoC: rsnd: fixup TDM Split mode check for CTU

Marco Felsch (1):
      ASoC: ssm2602: switch to SPDX identifier

Mark Brown (7):
      Merge branch 'asoc-4.21' into HEAD
      Merge branch 'asoc-4.22' into asoc-5.0
      Merge tag 'asoc-fix-v5.0-rc2' into asoc-5.1
      ASoC: core: Fix multi-CODEC setups
      ASoC: wcd9335: Fix missing slimbus dependency
      Merge tag 'v5.0-rc4' into asoc-5.1
      Merge branch 'asoc-5.0' into asoc-5.1 for dapm table

Maruthi Srinivas Bayyavarapu (7):
      dt-bindings: ASoC: xlnx, audio-formatter: Document audio formatter bi=
ndings
      ASoC: xlnx: add pcm formatter platform driver
      ASoC: xlnx: enable audio formatter driver build
      dt-bindings: ASoC: xlnx, spdif: Document spdif bindings
      ASoC: xlnx: add SPDIF audio driver
      ASoC: xlnx: enable SPDIF driver build
      ASoC: xlnx: parse AES audio parameters

Micha=C5=82 Miros=C5=82aw (3):
      ASoC: wm8904: make the driver visible in Kconfig
      ASoC: wm8904: save model id directly in of_device_id.data
      ASoC: wm8904: enable MCLK in STANDBY

Paul Cercueil (7):
      ASoC: codecs: Add jz4725b-codec driver
      dt-bindings: sound: Document jz4740-codec bindings
      dt-bindings: sound: Document jz4725b-codec bindings
      ASoC: codecs: jz4740: Use SPDX license notifier
      ASoC: codecs: jz4740: Add support for devicetree
      ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST
      ASoC: codecs: jz4725b: Use C++ style comments in header

Peter Ujfalusi (3):
      ASoC: ti: davinci-mcasp: No need for IS_MODULE/BUILTIN check for pcm =
driver
      ASoC: davinci-mcasp: Document GPIO support
      ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins

Philipp Zabel (1):
      ASoC: ssm2602: Fix ADC powerup sequencing

Pierre-Louis Bossart (45):
      ASoC: Intel: Skylake: remove useless cast
      ASoC: Intel: Skylake: simplify boolean tests
      ASoC: Intel: Haswell: remove unneeded semicolon
      ASoC: Intel: Haswell: assign booleans to true/false
      ASoC: Intel: Baytrail: remove unneeded variable
      ASoC: Intel: Baytrail: simplify boolean test
      ASoC: Intel: Atom: simplify boolean tests
      ASoC: Intel: boards: use snd_mask_set_format in all machine drivers
      ASoC: dmic: declare trigger function as static
      ASoC: max98090: remove unused constant variables
      ASoC: es8316: remove unused constant variables
      ASoC: codecs: fix kernel doc descriptions
      ASoC: max98383: fix boolean assignments to true/false
      ASoC: cs4271: fix boolean assignments
      ASoC: rt274: fix boolean tests
      ASoc: rt286: fix boolean tests
      ASoC: rt5640: fix boolean assignments
      ASoC: max98927: fix boolean assignments
      ASoC: rt5651: fix boolean assignments
      ASoC: nau8824: fix boolean assignment
      ASoC: tscs42xx.c: fix boolean test
      ASoC: mt6351: remove unneeded variable
      ASoC: da7219: fix endianness issues
      ASoC: da7219: use logical AND
      ASoC: rt298: fix boolean tests
      ASoC: soc-acpi: add static inline fallbacks when CONFIG_ACPI=3Dn
      ASoC: add helper to change platform name for all dailinks
      ASoC: Intel: haswell: platform name fixup support
      ASoC: Intel: broadwell: platform name fixup support
      ASoC: Intel: bdw-rt5677: platform name fixup support
      ASoC: Intel: bytcr_rt5640: platform name fixup support
      ASoC: Intel: bytcr_rt5651: platform name fixup support
      ASoC: Intel: bytcht_da7213: platform name fixup support
      ASoC: Intel: bytcht_es8316: platform name fixup support
      ASoC: Intel: cht_bsw_max98090_ti: platform name fixup support
      ASoC: Intel: cht_bsw_nau8824: platform name fixup support
      ASoC: Intel: cht_bsw_rt5645: platform name fixup support
      ASoC: Intel: cht_bsw_rt5672: platform name fixup support
      ASoC: Intel: bxt_da7219_max98357a: platform name fixup support
      ASoC: Intel: bxt_rt298: platform name fixup support
      ASoC: Intel: glk_rt5682_max98357a: platform name fixup support
      ASoC: Intel: cht_bsw_rt5672: remove useless test
      ASoC: dapm: fix use-after-free issue with dailink sname
      ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables
      ASoC: dapm: harden use of lookup tables

Ranjani Sridharan (2):
      ASoC: topology: add SND_SOC_DOBJ_GRAPH type for dapm routes
      ASoC: topology: modify dapm route loading routine and add dapm route =
unloading

Russell King (1):
      ASoC: hdmi-codec: fix oops on re-probe

Shengjiu Wang (1):
      ASoC: fsl_sai: Remove expensive print in irq handler

Shuming Fan (1):
      ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA fil=
ter

Shunli Wang (4):
      ASoC: mediatek: mt8183: add platform driver
      ASoC: mediatek: mt8183: add audio afe document
      ASoC: mediatek: mt6358: add codec driver
      ASoC: mediatek: mt6358: add codec document

Srinivas Kandagatla (9):
      ASoC: msm8916-wcd-digital: remove few unused variables
      ASoC: dt-bindings: update wcd9335 bindings.
      ASoC: wcd9335: add support to wcd9335 codec
      ASoC: wcd9335: add CLASS-H Controller support
      ASoC: wcd9335: add basic controls
      ASoC: wcd9335: add playback dapm widgets
      ASoC: wcd9335: add capture dapm widgets
      ASoC: wcd9335: add audio routings
      ASoC: apq8096: add slim support

Stefan Agner (6):
      ASoC: imx-sgtl5000: put of nodes if finding codec fails
      ASoC: imx-sgtl5000: lower log level for potential probe deferral cases
      ASoC: imx-sgtl5000: don't print EPROBE_DEFER as error
      ASoC: fsl_spdif: don't print EPROBE_DEFER as error
      ASoC: imx-spdif: don't print EPROBE_DEFER as error
      ASoC: soc-core: remove error due to probe deferral

Stephan Gerhold (3):
      ASoC: Intel: sst: Simplify is_byt_cr()
      ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is missing
      ASoC: Intel: bytcr_rt5640: Add quirks for ASUS MeMO Pad 7 (ME176C)

Wei Yongjun (1):
      ASoC: Intel: bytcht_es8316: use correct drvdata in snd_byt_cht_es8316=
_mc_remove()

Yizhuo (2):
      ASoC: rt274: Variable "buf" in function rt274_jack_detect() could be =
uninitialized
      ASoC: rt5651: Variable "ret" in function rt5651_i2c_probe() could be =
uninitialized

YueHaibing (1):
      ASoC: rockchip: fix platform_no_drv_owner.cocci warnings

Zhiwei Jiang (1):
      ASoC: dapm: Add warnings for widget overwrite when adding route

b-ak (1):
      ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated

kbuild test robot (1):
      ASoC: wcd9335: fix semicolon.cocci warnings

wen yang (1):
      ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

 Documentation/devicetree/bindings/sound/ak4458.txt |    2 +-
 .../bindings/sound/audio-graph-scu-card.txt        |  123 -
 Documentation/devicetree/bindings/sound/cs4341.txt |   22 +
 .../bindings/sound/davinci-mcasp-audio.txt         |   17 +
 .../devicetree/bindings/sound/fsl,micfil.txt       |   32 +
 .../bindings/sound/google,cros-ec-codec.txt        |   26 +
 .../bindings/sound/ingenic,jz4725b-codec.txt       |   20 +
 .../bindings/sound/ingenic,jz4740-codec.txt        |   20 +
 Documentation/devicetree/bindings/sound/mt6358.txt |   18 +
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   36 +
 .../devicetree/bindings/sound/mtk-btcvsd-snd.txt   |   24 +
 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   10 +-
 .../bindings/sound/rockchip,rk3328-codec.txt       |   23 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    9 +
 .../devicetree/bindings/sound/simple-scu-card.txt  |   94 -
 .../devicetree/bindings/sound/sprd-pcm.txt         |   23 +
 .../bindings/sound/xlnx,audio-formatter.txt        |   29 +
 .../devicetree/bindings/sound/xlnx,spdif.txt       |   28 +
 MAINTAINERS                                        |   12 +-
 include/sound/simple_card_utils.h                  |    4 +-
 include/sound/soc-acpi.h                           |   28 +-
 include/sound/soc-dapm.h                           |   27 +-
 include/sound/soc-topology.h                       |    8 +-
 include/sound/soc.h                                |   70 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |   62 +-
 sound/soc/codecs/Makefile                          |   12 +
 sound/soc/codecs/adau7002.c                        |   45 +
 sound/soc/codecs/ak4118.c                          |    1 +
 sound/soc/codecs/ak4458.c                          |   79 +-
 sound/soc/codecs/cros_ec_codec.c                   |  441 ++
 sound/soc/codecs/cs4271.c                          |    4 +-
 sound/soc/codecs/cs4341.c                          |  346 ++
 sound/soc/codecs/cs47l24.c                         |   52 +-
 sound/soc/codecs/da7219-aad.c                      |    2 +-
 sound/soc/codecs/da7219.c                          |   85 +-
 sound/soc/codecs/da7219.h                          |    1 +
 sound/soc/codecs/dmic.c                            |    4 +-
 sound/soc/codecs/es8316.c                          |  200 +-
 sound/soc/codecs/es8316.h                          |    7 +
 sound/soc/codecs/hdmi-codec.c                      |    4 +-
 sound/soc/codecs/jz4725b.c                         |  598 +++
 sound/soc/codecs/jz4740.c                          |   26 +-
 sound/soc/codecs/max98090.c                        |   15 -
 sound/soc/codecs/max98373.c                        |    6 +-
 sound/soc/codecs/max98927.c                        |    8 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |   10 -
 sound/soc/codecs/mt6351.c                          |    4 +-
 sound/soc/codecs/mt6358.c                          | 2336 +++++++++
 sound/soc/codecs/mt6358.h                          | 2314 +++++++++
 sound/soc/codecs/nau8824.c                         |    2 +-
 sound/soc/codecs/nau8825.c                         |    1 +
 sound/soc/codecs/pcm512x.c                         |   32 +-
 sound/soc/codecs/rk3328_codec.c                    |  519 ++
 sound/soc/codecs/rk3328_codec.h                    |  210 +
 sound/soc/codecs/rl6347a.c                         |    4 +-
 sound/soc/codecs/rt274.c                           |   19 +-
 sound/soc/codecs/rt286.c                           |    8 +-
 sound/soc/codecs/rt298.c                           |   12 +-
 sound/soc/codecs/rt5514.c                          |    1 +
 sound/soc/codecs/rt5640.c                          |    6 +-
 sound/soc/codecs/rt5645.c                          |   66 +-
 sound/soc/codecs/rt5651.c                          |   67 +-
 sound/soc/codecs/rt5651.h                          |    1 +
 sound/soc/codecs/rt5670.c                          |   54 -
 sound/soc/codecs/rt5677.c                          |    8 +-
 sound/soc/codecs/rt5682.c                          |   10 +
 sound/soc/codecs/sgtl5000.c                        |   19 +-
 sound/soc/codecs/ssm2602.c                         |   71 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   30 +-
 sound/soc/codecs/tlv320aic32x4.h                   |    1 +
 sound/soc/codecs/tscs42xx.c                        |    2 +-
 sound/soc/codecs/wcd-clsh-v2.c                     |  576 +++
 sound/soc/codecs/wcd-clsh-v2.h                     |   49 +
 sound/soc/codecs/wcd9335.c                         | 5244 ++++++++++++++++=
++++
 sound/soc/codecs/wcd9335.h                         |  640 +++
 sound/soc/codecs/wm5102.c                          |   64 +-
 sound/soc/codecs/wm5110.c                          |   80 +-
 sound/soc/codecs/wm8904.c                          |   21 +-
 sound/soc/codecs/wm8997.c                          |   60 +-
 sound/soc/codecs/wm8998.c                          |   60 +-
 sound/soc/fsl/Kconfig                              |    9 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl-asoc-card.c                      |    1 +
 sound/soc/fsl/fsl_micfil.c                         |  826 +++
 sound/soc/fsl/fsl_micfil.h                         |  283 ++
 sound/soc/fsl/fsl_sai.c                            |    8 +-
 sound/soc/fsl/fsl_spdif.c                          |    2 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   11 +-
 sound/soc/fsl/imx-spdif.c                          |    4 +-
 sound/soc/generic/Kconfig                          |   17 -
 sound/soc/generic/Makefile                         |    4 -
 sound/soc/generic/audio-graph-card.c               |  481 +-
 sound/soc/generic/audio-graph-scu-card.c           |  501 --
 sound/soc/generic/simple-card-utils.c              |   25 +-
 sound/soc/generic/simple-card.c                    |  472 +-
 sound/soc/generic/simple-scu-card.c                |  474 --
 sound/soc/intel/atom/sst-atom-controls.c           |    2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   45 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |    2 +-
 sound/soc/intel/atom/sst/sst_loader.c              |    2 +-
 sound/soc/intel/baytrail/sst-baytrail-ipc.c        |    3 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |    2 +-
 sound/soc/intel/boards/bdw-rt5677.c                |   14 +
 sound/soc/intel/boards/broadwell.c                 |   16 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   13 +
 sound/soc/intel/boards/bxt_rt298.c                 |   13 +
 sound/soc/intel/boards/bytcht_da7213.c             |    8 +
 sound/soc/intel/boards/bytcht_es8316.c             |  336 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   23 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  114 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   12 +
 sound/soc/intel/boards/cht_bsw_nau8824.c           |   12 +
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    9 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   30 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |   23 +-
 sound/soc/intel/boards/haswell.c                   |   15 +
 sound/soc/intel/boards/kbl_da7219_max98927.c       |    4 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |   44 +-
 sound/soc/intel/haswell/sst-haswell-ipc.c          |    2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c          |    4 +-
 sound/soc/intel/skylake/skl-messages.c             |    2 +-
 sound/soc/intel/skylake/skl-pcm.c                  |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |    2 +-
 sound/soc/mediatek/Kconfig                         |   19 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/common/Makefile                 |    2 +
 sound/soc/mediatek/common/mtk-btcvsd.c             | 1364 +++++
 sound/soc/mediatek/mt8183/Makefile                 |   13 +
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++
 sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
 sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 +
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 ++
 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 +
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 ++++
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 ++
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 +++
 sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
 sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 +++++++
 sound/soc/pxa/Makefile                             |    1 -
 sound/soc/qcom/Kconfig                             |    1 +
 sound/soc/qcom/apq8096.c                           |   71 +-
 sound/soc/qcom/sdm845.c                            |    2 +
 sound/soc/sh/rcar/core.c                           |   48 +-
 sound/soc/sh/rcar/src.c                            |  125 +-
 sound/soc/soc-compress.c                           |  177 +-
 sound/soc/soc-core.c                               |  267 +-
 sound/soc/soc-dapm.c                               |  244 +-
 sound/soc/soc-pcm.c                                |    4 +
 sound/soc/soc-topology.c                           |  171 +-
 sound/soc/sprd/Kconfig                             |    6 +
 sound/soc/sprd/Makefile                            |    4 +
 sound/soc/sprd/sprd-pcm-dma.c                      |  562 +++
 sound/soc/sprd/sprd-pcm-dma.h                      |   15 +
 sound/soc/sunxi/sun4i-codec.c                      |  149 +-
 sound/soc/ti/davinci-mcasp.c                       |  175 +-
 sound/soc/xilinx/Kconfig                           |   14 +
 sound/soc/xilinx/Makefile                          |    4 +
 sound/soc/xilinx/xlnx_formatter_pcm.c              |  708 +++
 sound/soc/xilinx/xlnx_spdif.c                      |  339 ++
 163 files changed, 27411 insertions(+), 2566 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu=
-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs4341.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-=
codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b=
-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-=
codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328=
-codec.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/simple-scu-card=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-form=
atter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 sound/soc/codecs/cros_ec_codec.c
 create mode 100644 sound/soc/codecs/cs4341.c
 create mode 100644 sound/soc/codecs/jz4725b.c
 create mode 100644 sound/soc/codecs/mt6358.c
 create mode 100644 sound/soc/codecs/mt6358.h
 create mode 100644 sound/soc/codecs/rk3328_codec.c
 create mode 100644 sound/soc/codecs/rk3328_codec.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c
 create mode 100644 sound/soc/codecs/wcd9335.h
 create mode 100644 sound/soc/fsl/fsl_micfil.c
 create mode 100644 sound/soc/fsl/fsl_micfil.h
 delete mode 100644 sound/soc/generic/audio-graph-scu-card.c
 delete mode 100644 sound/soc/generic/simple-scu-card.c
 create mode 100644 sound/soc/mediatek/common/mtk-btcvsd.c
 create mode 100644 sound/soc/mediatek/mt8183/Makefile
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h
 create mode 100644 sound/soc/sprd/Kconfig
 create mode 100644 sound/soc/sprd/Makefile
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.c
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.h
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c
 create mode 100644 sound/soc/xilinx/xlnx_spdif.c

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxde9cACgkQJNaLcl1U
h9DaXQf/bRPmCtQ2vL0cs2VxgtD/EApP/oI0AdIw3IvAAM7u1K5u0AypNTfdiil6
bERnJ2MvX1Az02R4DeCUPbCuPf73B1s7XSE4r2MMCbPXZIYw2oapUiUI47O/jZsw
Py9Ez0Mrq6sH88oBv29wQ+pj57+j7MYZPlYAh++XLFdim5xLe5nMMhJaa1g8d7pQ
4Kj8mNELl1obbV2o6saLzNyteXIpYdGcMh9irl5C08gc4JGgtgCP/Jv4sUDxgY1l
XzOXgTYG0weULwm3IkHta2b0opn0ANoF9lqukDnUXONuwDXSl5bD/6j75LUrwpj+
9ZsrhckJbi3MBPMzleAqeYEf9qeyxg==
=YTzh
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============7346981497139889765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7346981497139889765==--
