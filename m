From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.13
Date: Mon, 3 Jul 2017 17:10:23 +0100
Message-ID: <20170703161023.ckm3ktuhsuusv2ai@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6414937102939449717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B15226680F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 18:10:32 +0200 (CEST)
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


--===============6414937102939449717==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uybqx5lu4exsyph7"
Content-Disposition: inline


--uybqx5lu4exsyph7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:

  Linux 4.12 (2017-07-02 16:07:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.13

for you to fetch changes up to b821d298f8864dc3c3d42643812df43289159507:

  Merge remote-tracking branch 'asoc/topic/inte' into asoc-next (2017-07-03 16:51:38 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.13

The big news with this release is the of-graph card, this provides a
replacement for simple-card that is much more flexibile and scalable,
allowing many more systems to use a generic sound card than was possible
before:

 - The of-graph card, finally merged after a long and dedicated effort
   by Morimoto-san.
 - New widget types intended mainly for use with DSPs.
 - New drivers for Allwinner V3s SoCs, Ensonic ES8316, several classes
   of x86 machine, Rockchip PDM controllers, STM32 I2S and S/PDIF
   controllers and ZTE AUD96P22 CODECs.

----------------------------------------------------------------
Adam Thomson (4):
      ASoC: da7213: Update driver to use device_property* FW functions
      ASoC: da7218: Fix incorrect usage of bitwise '&' operator for SRM check
      ASoC: da7219: Fix HP detection procedure for all MCLK frequencies
      ASoC: Intel: bxt: Move codec sysclk config to codec_init function

Andy Shevchenko (5):
      ASoC: omap-mcbsp: Use sysfs_match_string() helper
      ASoC: Intel: byt-max98090: Add GPIO ACPI mapping table
      ASoC: rt5677: Introduce proper table for ACPI enumeration
      ASoC: rt5677: Move platform code to board file
      ASoC: Intel: bdw-rt5677: Switch to devm_acpi_dev_add_driver_gpios()

Arnd Bergmann (3):
      ASoC: rt5514: fix gcc-7 warning
      ASoC: rt5665: fix gcc-7 warning
      ASoC: es8316: add I2C dependency

Arvind Yadav (1):
      ASoC: rsnd: constify dev_pm_ops structures.

Axel Lin (1):
      ASoC: ak4613: Fix out of bounds array access for ak4613_iface

Baoyou Xie (2):
      ASoC: add bindings for ZTE zx-aud96p22 audio codec
      ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver

Bard Liao (11):
      ASoC: rt5665: add ADC STO2 ASRC support
      ASoC: rt5645: read jd1_1 status for jd detection
      ASoC: rt5645: rename jd_invert flag in platform data
      ASoC: rt5645: add inv_jd1_1 flag
      ASoC: rt5670: fix wrong audio route
      ASoC: rt5670: remove duplicate route.
      ASoC: rt5670: move set_sysclk to codec level
      ASoC: rt5651: remove unexisting Muxes
      ASoC: rt5645: enable speaker protection features
      ASoC: rt5670: fix incompatible pointer type of set_sysclk
      ASoC: rt5665: calibration should be done before jack detection

Brian Austin (2):
      ASoC: cs35l35: Add Boost Inductor Calculation
      ASoC: cs35l35: Add DT handling for Inductor

Charles Keepax (3):
      ASoC: cs35l35: Correctly handle 0 for bst_ipk
      ASoC: cs4271: Remove unnecessary additional variable definition
      ASoC: cs35l35: Add additional delay for reset

Christophe Jaillet (1):
      ASoC: rockchip: Fix an error handling in 'rockchip_i2s_probe'

Colin Ian King (6):
      ASoC: Intel: sst: fix spelling mistake: "allocationf" -> "allocation"
      ASoC: hdmi-codec: fix spelling mistake: "deteced" -> "detected"
      ASoC: audio-graph-card: fix spelling mistake: "missmatch" -> "mismatch"
      ASoC: max9867: make array ni_div static const
      ASoC: ak4642: make arrays fs_list and ps_list static const
      ASoC: rsnd: make arrays path and cmd_case static const

Dan Carpenter (1):
      ASoC: stm32: sai: remove some stray tabs

Daniel Drake (2):
      ASoC: add es8316 codec driver
      ASoC: Intel: add machine driver for BYT/CHT + ES8316

Dharageswari R (3):
      ASoC: Intel: Skylake: Add mic-select module type
      ASoC: Intel: Skylake: Add enum control for mic selection
      ASoC: Intel: Boards: Add 4-channel DMIC fixup.

Douglas Anderson (1):
      ASoC: Intel: sst: Delete sst_shim_regs64; saved regs are never used

Geert Uytterhoeven (3):
      ASoC: rt5665: Fix uninitialized warning in rt5665_i2s_pin_event()
      ASoC: fsi: Move inline fsi_stream_is_play() before use
      ASoC: rsnd: Document optional reset properties

Guneshwor Singh (1):
      ASoC: Intel: Skylake: Add sram address to sst_addr structure

Hans de Goede (1):
      ASoC: rt5645: del btn_check_timer on remove

Harsha Priya N (3):
      ASoC: Intel: Add Kabylake machine driver for RT5514, RT5663 and MAX98927
      ASoC: Intel: Convert all sst_codecs data definition to c99 style
      ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine driver entry

Icenowy Zheng (4):
      ASoC: sun8i-codec-analog: split out mbias
      ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for V3s
      ASoC: sun8i-codec-analog: add support for V3s SoC
      ASoC: sun4i-codec: Add support for V3s codec

John Hsu (6):
      ASoC: nau8824: TDM support
      ASoC: nau8825: default value for property
      ASoC: nau8825: fix jack type detection issue after resume
      ASoC: nau8825: make crosstalk function optional
      ASoC: nau8825: debug message of crosstalk bypass
      ASoC: nau8825: change crosstalk-bypass property to bool type

John Stultz (1):
      drm: adv7511_audio: Add .get_dai_id callback to map port number to dai id

Julian Scheel (1):
      ASoC: simple-card: Fix misleading error message

Kuninori Morimoto (83):
      ASoC: ak4613: disable asymmetric audio interface format
      of-graph: export symbol of_phandle_iterator_init/next
      of_graph: add of_graph_get_remote_endpoint()
      of_graph: add of_graph_get_port_parent()
      of_graph: add of_graph_get_endpoint_count()
      ASoC: soc-core: enable "dai-format" on snd_soc_of_parse_daifmt()
      ASoC: simple-card-utils: enable "label" on asoc_simple_card_parse_card_name
      ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()
      ASoC: add audio-graph-card document
      ASoC: add audio-graph-card support
      ASoC: rsnd: move "renesas,rsrc-card" to "simple-scu-audio-card" on Document
      ASoC: rsnd: add missing clocks/clock-names on Document
      ASoC: rsnd: remove un-used OUF_SRCO/I macro
      ASoC: rsnd: remove mismatch explain comment from src.c
      ASoC: rsnd: clkout-lr-asynchronous is AUDIO_CLKOUT related property
      ASoC: rsnd: remove error pointer for adg->clkout[i]
      ASoC: rsnd: need to call nolock_stop if nolock_start was failed
      ASoC: rsnd: check src mod pointer for rsnd_mod_id()
      ASoC: simple-card: tidyup return method from probe()
      ASoC: simple-scu-card: tidyup return method from probe()
      ASoC: audio-graph-card: tidyup return method from probe()
      ASoC: simple-scu-card: cleanup documentation
      ASoC: rsnd: add support graph base DT phase 1
      ASoC: rsnd: add support graph base DT phase 2
      ASoC: rsnd: add HDMI output support
      ASoC: add snd_soc_get_dai_id() function
      ASoC: simple-card-utils: support snd_soc_get_dai_id()
      ASoC: hdmi-codec: remove multi detection support
      ASoC: hdmi-codec: add .get_dai_id support
      ASoC: simple-card-utils: remove strict limitation of bit/frame master
      ASoC: add audio-graph-scu-card document
      ASoC: add audio-graph-scu-card support
      ASoC: audio-graph-scu-card: tidyup return method from probe()
      ASoC: rsnd: remove unused rsnd_ssi_non_ops
      ASoC: rsnd: remove unused rsnd_dai_path_info
      ASoC: simple-scu-card: tidyup "Sampling Rate Conversion"
      ASoC: audio-graph-scu-card: add missing MIX binding example
      ASoC: simple-card-utils: share same dev_dbg() for Card Name
      ASoC: simple-card-utils: share same dev_dbg() for DAI format
      ASoC: simple-card-utils: share same dev_dbg() for Dai Name
      ASoC: simple-card-utils: share same dev_dbg() for sysclk
      ASoC: hdmi-codec: remove unused ratec
      ASoC: simple-card: remove duplicate parameter from asoc_simple_card_parse_of()
      ASoC: simple-scu-card: remove duplicate paramera from asoc_simple_card_parse_of
      ASoC: rsnd: update pointer more accurate
      ASoC: rsnd: cleanup pointer related code
      ASoC: rsnd: don't call free_irq() on Parent SSI
      ASoC: rsnd: add detail explanation of L/R conversion timing
      ASoC: rsnd: control kctrl items acceptance anytime/runtime
      ASoC: simple_card_utils: add asoc_simple_card_clk_xxx()
      ASoC: simple-card: use asoc_simple_card_clk_xxx()
      ASoC: simple-scu-card: use asoc_simple_card_clk_xxx()
      ASoC: audio-graph-scu-card: use asoc_simple_card_clk_xxx()
      ASoC: audio-graph-card: use asoc_simple_card_clk_xxx()
      ASoC: simple_card_utils: add EXPORT_SYMBOL_GPL() for asoc_simple_card_clk_xxx()
      ASoC: rsnd: reduce confusable macro parameter magic
      ASoC: ak4613: add missing 64000 in ak4613_dai_hw_params()
      ASoC: simple-card-utils: add asoc_simple_card_of_parse_tdm()
      ASoC: simple-card: use asoc_simple_card_of_parse_tdm()
      ASoC: simple-scu-card: use asoc_simple_card_of_parse_tdm()
      ASoC: audio-graph-card: use asoc_simple_card_of_parse_tdm()
      ASoC: audio-graph-scu-card: use asoc_simple_card_of_parse_tdm()
      ASoC: simple-card-utils: add asoc_simple_card_convert_fixup()
      ASoC: simple-scu-card: use asoc_simple_card_convert_fixup()
      ASoC: audio-graph-scu-card: use asoc_simple_card_convert_fixup()
      ASoC: simple-card-utils: add asoc_simple_card_of_parse_routing()
      ASoC: simple-card: use asoc_simple_card_of_parse_routing()
      ASoC: simple-scu-card: use asoc_simple_card_of_parse_routing()
      ASoC: audio-graph-scu-card: use asoc_simple_card_of_parse_routing()
      ASoC: rsnd: rename "slots" related variable
      ASoC: rsnd: add rsnd_adg_clk_query()
      ASoC: rsnd: add rsnd_ssi_clk_query()
      ASoC: rsnd: add rsnd_soc_hw_rule/constraint()
      ASoC: ak4613: add hw_constraint rule for Sampling Rate
      ASoC: simple-card-utils: add asoc_simple_card_of_parse_widgets()
      ASoC: simple-card: use asoc_simple_card_of_parse_widgets()
      ASoC: fsl: mpc5200_dma: remove unused psc_dma
      ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC
      ASoC: rsnd: fixup unsigned expression compared with zero: main_rate
      ASoC: audio-graph-card: tidyup asoc_simple_card_canonicalize_cpu() parameter
      ASoC: audio-graph-scu-card: tidyup asoc_simple_card_canonicalize_cpu() parameter
      ASoC: audio-graph-scu-card: support 2nd codec endpoint on DT
      drm: dw-hdmi-i2s: add .get_dai_id callback for ALSA SoC

Liam Girdwood (8):
      ASoC: topology: Allow bespoke configuration post widget creation
      ASoC: topology: rephrase deferred binding warning.
      ASoC: topology: Dont free template strings whilst they are in use.
      ASoC: topology: Fix potential build issues with undeclared structs
      ASoC: topology: Allow bespoke configuration post widget creation
      ASoC: topology: Fix usage of SND_SOC_TPLG_INDEX_ALL during load
      ASoC: topology: show index in debug when adding DAPM routes
      ASoC: dapm: Add new widget type for constructing DAPM graphs on DSPs.

Mark Brown (37):
      Merge branch 'topic/dai-id' of git://git.kernel.org/.../broonie/sound into asoc-of-graph
      Merge branch 'topic/of-graph' of git://git.kernel.org/.../broonie/sound into asoc-hdmi
      Merge branch 'topic/of-graph' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge branch 'fix/rcar' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      ASoC: Back out post commit widget creation changes
      Merge branch 'topic/simple' of git://git.kernel.org/.../broonie/sound into asoc-of-graph
      Merge branch 'topic/rcar' of git://git.kernel.org/.../broonie/sound into asoc-of-graph
      ASoC: rockchip: Fix build
      Merge branch 'topic/rt5677' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ak4613', 'asoc/fix/atmel', 'asoc/fix/compress', 'asoc/fix/cs35l35' and 'asoc/fix/da7219' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rockchip', 'asoc/fix/rt5645', 'asoc/fix/rt5663', 'asoc/fix/rt5670' and 'asoc/fix/zte' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4613', 'asoc/topic/ak4642', 'asoc/topic/atmel', 'asoc/topic/cs35l34' and 'asoc/topic/cs35l35' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs4271', 'asoc/topic/cs53l30', 'asoc/topic/da7213' and 'asoc/topic/da7218' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/drm', 'asoc/topic/dwc' and 'asoc/topic/es8316' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl', 'asoc/topic/hdmi', 'asoc/topic/hisi' and 'asoc/topic/max9867' into asoc-next
      Merge remote-tracking branches 'asoc/topic/msm8916', 'asoc/topic/mtk', 'asoc/topic/nau8824', 'asoc/topic/nau8825' and 'asoc/topic/of-graph' into asoc-next
      Merge remote-tracking branches 'asoc/topic/omap', 'asoc/topic/pxa', 'asoc/topic/rockchip' and 'asoc/topic/rt5514' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5614', 'asoc/topic/rt5645', 'asoc/topic/rt5651', 'asoc/topic/rt5665' and 'asoc/topic/rt5670' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sgtl5000' and 'asoc/topic/sh' into asoc-next
      Merge remote-tracking branches 'asoc/topic/stm32', 'asoc/topic/sunxi', 'asoc/topic/tlv320dac31xx', 'asoc/topic/topology' and 'asoc/topic/wm-adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/zx-aud96p22' into asoc-next
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ak4613', 'asoc/fix/atmel', 'asoc/fix/compress', 'asoc/fix/cs35l35' and 'asoc/fix/da7219' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rockchip', 'asoc/fix/rt5645', 'asoc/fix/rt5663', 'asoc/fix/rt5670' and 'asoc/fix/zte' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4613', 'asoc/topic/ak4642', 'asoc/topic/atmel', 'asoc/topic/cs35l34' and 'asoc/topic/cs35l35' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs4271', 'asoc/topic/cs53l30', 'asoc/topic/da7213' and 'asoc/topic/da7218' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/drm', 'asoc/topic/dwc' and 'asoc/topic/es8316' into asoc-next
      Merge remote-tracking branch 'asoc/topic/inte' into asoc-next

Matthias Kaehlcke (2):
      ASoC: cht_bsw_max98090_ti: Remove unused function cht_get_codec_dai()
      ASoC: Intel: sst: Remove unused function sst_restore_shim64()

Mengdong Lin (1):
      ASoC: Drop invalid DMI fields when setting card long name from DMI info

Naveen M (7):
      ASoC: Intel: Convert atom machine data to C99 style
      ASoC: Intel: Convert skl machine data to C99 style
      ASoC: Intel: Create a helper to search for matching machine
      ASoC: Move quirk to identify correct machine driver
      ASoC: Improve machine driver selection based on quirk data
      ASoC: Intel: Add Kabylake Realtek Maxim machine driver
      ASoC: Intel: Add Kabylake RT5663+MAX98927 machine driver entry

Oder Chiou (4):
      ASoC: rt5514: Add more width and channels support in the TDM mode
      ASoC: rt5514: Add ACPI match ID
      ASoC: rt5663: Fix the IRQ issue
      ASoC: rt5663: Check the JD status in the resume function

Peter Rosin (1):
      ASoC: atmel: tse850: fix off-by-one in the "ANA" enumeration count

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Support for one channel (mono) audio

Pierre-Louis Bossart (2):
      ASoC: Intel: cht_bsw_rt5672: 19.2MHz clock for Baytrail platforms
      ASoC: codecs: rt5670: fix jd mode for Lenovo Miix 2 10

Ramesh Babu (2):
      ASoC: Intel: Skylake: Add deep buffer support
      ASoC: Intel: Skylake: Fix dma buffer size calculation

Richard Fitzgerald (3):
      ASoC: wm_adsp: Fix type warning in sprintf
      ASoC: wm_adsp: Remove unused member of struct wm_coeff_ctl_ops
      ASoC: wm_adsp: Fix typo in algorithm list warning message

Richard Leitner (1):
      ASoC: sgtl5000: add avc support

Ryo Kodama (1):
      ASoC: ak4613: Improve counting DAI number

Satish Babu Patakokila (1):
      ASoC: compress: Derive substream from stream based on direction

Shawn Guo (4):
      ASoC: zx-i2s: fix harsh noise with 16-bit audio
      ASoC: zx-i2s: flip I2S master/slave mode
      ASoC: audio-graph-card: update bindings for amplifier support
      ASoC: audio-graph-card: add widgets and routing for external amplifier support

Shreyas NC (1):
      ASoC: Intel: Skylake: Support for multiple data blocks

Subhransu S. Prusty (2):
      ASoC: Intel: Skylake: Fix typo for token d0i3 caps
      ASoC: skl_rt286: Add deepbuffer dai link

Sugar Zhang (3):
      ASoC: rockchip: add support for pdm controller
      ASoC: rockchip: add bindings for spdif controller
      ASoC: rockchip: i2s: add a delay before i2s clear

Sylwester Nawrocki (1):
      ASoC: samsung: Odroid DT binding documentation corrections

Takashi Iwai (11):
      ASoC: atmel: Use IS_ENABLED()
      ASoC: intel: byt: Constify hw_constraints
      ASoC: intel: skl: Constify hw_constraints
      ASoC: cs35l34: Constify hw_constraints
      ASoC: cs53l30: Constify hw_constraints
      ASoC: mediatek: Constify hw_constraints
      ASoC: samsung: Constify hw_constraints
      ASoC: intel: bxt: Constify hw_constraints
      ASoC: intel: Use kvzalloc() for suspend buffers
      ASoC: rt5645: Add jack detection workaround for GPD Win
      ASoC: rt5645: Add quirk override by module option

Takashi Sakamoto (3):
      ASoC: codecs: msm8916: fix invalid cast to bool type
      ASoC: hisilicon: localize functions without external linkage
      ASoC: intel: atom: localize variable without external linkage

Tomas Vilda (1):
      ASoC: tlv320dac31xx: Fix mistype in tlv320dac31xx codec

Vijendar Mukunda (1):
      ASoC: dwc: Added a quirk DW_I2S_QUIRK_16BIT_IDX_OVERRIDE to dwc driver

Vinod Koul (4):
      ASoC: Intel: Skylake: Add debugfs support
      ASoC: Intel: Skylake: Debugfs facility to dump module config
      ASoC: Intel: Skylake: explicitly add the headers sst-dsp.h
      ASoC: Intel: Skylake: Remove driver debugfs exit

Vunny Sodhi (1):
      ASoC: Intel: Skylake: Add support to read firmware registers

Wei Yongjun (1):
      ASoC: rt5665: make local symbol rt5665_i2c_driver static

Wu Fengguang (1):
      ASoC: fix semicolon.cocci warnings

olivier moysan (14):
      ASoC: stm32: Document STM32 I2S bindings
      ASoC: stm32: Add I2S driver
      ASoC: stm32: Add full duplex support to i2s
      ASoC: stm32: sai: fix DT example
      ASoC: stm32: sai: typo fixes
      ASoC: stm32: sai: remove spurious trace
      ASoC: stm32: sai: change stop sequence
      ASoC: stm32: sai: fix clock management
      ASoC: stm32: sai: manage master clock
      ASoC: stm32: add h7 support for sai
      ASoC: stm32: sai: add h7 support
      ASoC: stm32: change configuration flag
      ASoC: stm32: Add DT bindings for SPDIFRX interface
      ASoC: stm32: Add SPDIFRX support

zhangjun (1):
      ASoC: rockchip: i2s: add other configurable formats

 .../bindings/display/bridge/adi,adv7511.txt        |   8 +
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |   9 +-
 .../devicetree/bindings/sound/audio-graph-card.txt | 129 +++
 .../bindings/sound/audio-graph-scu-card.txt        | 122 +++
 .../devicetree/bindings/sound/cs35l35.txt          |   3 +
 .../devicetree/bindings/sound/nau8825.txt          |   3 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  37 +-
 .../devicetree/bindings/sound/rockchip,pdm.txt     |  39 +
 .../devicetree/bindings/sound/rockchip-spdif.txt   |   2 +
 .../devicetree/bindings/sound/samsung,odroid.txt   |  15 +-
 .../devicetree/bindings/sound/simple-scu-card.txt  |  67 +-
 .../devicetree/bindings/sound/st,stm32-i2s.txt     |  62 ++
 .../devicetree/bindings/sound/st,stm32-sai.txt     |  41 +-
 .../devicetree/bindings/sound/st,stm32-spdifrx.txt |  56 ++
 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 +-
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  |  24 +
 Documentation/sound/soc/dapm.rst                   |  18 +
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c     |  22 +
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |  21 +
 drivers/of/base.c                                  |  62 +-
 include/linux/of_graph.h                           |  21 +
 include/sound/cs35l35.h                            |   2 +
 include/sound/designware_i2s.h                     |   1 +
 include/sound/hdmi-codec.h                         |   9 +
 include/sound/rt5645.h                             |   6 +-
 include/sound/simple_card_utils.h                  |  43 +-
 include/sound/soc-dapm.h                           |   7 +
 include/sound/soc-topology.h                       |   5 +
 include/sound/soc.h                                |   3 +
 include/uapi/sound/asoc.h                          |  10 +-
 include/uapi/sound/snd_sst_tokens.h                |   8 +-
 sound/soc/atmel/atmel-pcm.h                        |   6 +-
 sound/soc/atmel/tse850-pcm5142.c                   |   4 +-
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   4 +
 sound/soc/codecs/ak4613.c                          |  95 +-
 sound/soc/codecs/ak4642.c                          |   4 +-
 sound/soc/codecs/cs35l34.c                         |   4 +-
 sound/soc/codecs/cs35l35.c                         |  94 +-
 sound/soc/codecs/cs35l35.h                         |   6 +
 sound/soc/codecs/cs4271.c                          |   2 -
 sound/soc/codecs/cs53l30.c                         |   2 +-
 sound/soc/codecs/da7213.c                          |  37 +-
 sound/soc/codecs/da7218.c                          |   2 +-
 sound/soc/codecs/da7219-aad.c                      |  31 +-
 sound/soc/codecs/da7219.c                          |  53 +-
 sound/soc/codecs/da7219.h                          |   5 +-
 sound/soc/codecs/es8316.c                          | 637 +++++++++++++
 sound/soc/codecs/es8316.h                          | 129 +++
 sound/soc/codecs/hdmi-codec.c                      |  92 +-
 sound/soc/codecs/max9867.c                         |   2 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |   6 +-
 sound/soc/codecs/nau8824.c                         |  52 ++
 sound/soc/codecs/nau8824.h                         |  12 +
 sound/soc/codecs/nau8825.c                         |  76 +-
 sound/soc/codecs/nau8825.h                         |   1 +
 sound/soc/codecs/rt5514.c                          |  37 +-
 sound/soc/codecs/rt5514.h                          |   6 +
 sound/soc/codecs/rt5645.c                          |  97 +-
 sound/soc/codecs/rt5651.c                          |  44 +-
 sound/soc/codecs/rt5663.c                          |   4 +-
 sound/soc/codecs/rt5663.h                          |   4 +
 sound/soc/codecs/rt5665.c                          | 158 ++--
 sound/soc/codecs/rt5670.c                          |  25 +-
 sound/soc/codecs/rt5677.c                          |  32 +-
 sound/soc/codecs/sgtl5000.c                        |  89 ++
 sound/soc/codecs/tlv320aic31xx.c                   |   2 +-
 sound/soc/codecs/wm_adsp.c                         |   6 +-
 sound/soc/codecs/zx_aud96p22.c                     | 403 +++++++++
 sound/soc/davinci/davinci-mcasp.c                  |  12 +-
 sound/soc/dwc/dwc-i2s.c                            |   6 +
 sound/soc/fsl/mpc5200_dma.c                        |   1 -
 sound/soc/generic/Kconfig                          |  17 +
 sound/soc/generic/Makefile                         |   4 +
 sound/soc/generic/audio-graph-card.c               | 338 +++++++
 sound/soc/generic/audio-graph-scu-card.c           | 411 +++++++++
 sound/soc/generic/simple-card-utils.c              | 198 +++-
 sound/soc/generic/simple-card.c                    |  69 +-
 sound/soc/generic/simple-scu-card.c                |  55 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |  11 +-
 sound/soc/intel/Kconfig                            |  42 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   2 +-
 sound/soc/intel/atom/sst/sst.c                     |  59 +-
 sound/soc/intel/atom/sst/sst.h                     |  30 +-
 sound/soc/intel/atom/sst/sst_acpi.c                | 232 +++--
 sound/soc/intel/boards/Makefile                    |   6 +
 sound/soc/intel/boards/bdw-rt5677.c                |  26 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  26 +-
 sound/soc/intel/boards/bxt_rt298.c                 |  19 +-
 sound/soc/intel/boards/byt-max98090.c              |  24 +-
 sound/soc/intel/boards/bytcht_es8316.c             | 300 +++++++
 sound/soc/intel/boards/bytcht_nocodec.c            |   4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |   4 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  12 -
 sound/soc/intel/boards/cht_bsw_rt5672.c            |  89 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 687 ++++++++++++++
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 640 +++++++++++++
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  16 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  16 +-
 sound/soc/intel/boards/skl_rt286.c                 |  30 +-
 sound/soc/intel/common/sst-acpi.h                  |  23 +
 sound/soc/intel/common/sst-dsp-priv.h              |   4 +
 sound/soc/intel/common/sst-match-acpi.c            |  47 +-
 sound/soc/intel/skylake/Makefile                   |   4 +
 sound/soc/intel/skylake/bxt-sst.c                  |   4 +
 sound/soc/intel/skylake/skl-debug.c                | 261 ++++++
 sound/soc/intel/skylake/skl-messages.c             |  31 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   6 +-
 sound/soc/intel/skylake/skl-sst.c                  |   5 +
 sound/soc/intel/skylake/skl-topology.c             | 187 +++-
 sound/soc/intel/skylake/skl-topology.h             |  21 +
 sound/soc/intel/skylake/skl-tplg-interface.h       |   2 +
 sound/soc/intel/skylake/skl.c                      | 114 ++-
 sound/soc/intel/skylake/skl.h                      |  23 +
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |   2 +-
 sound/soc/omap/mcbsp.c                             |  12 +-
 sound/soc/pxa/Kconfig                              |   2 +-
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_i2s.c                  |  41 +-
 sound/soc/rockchip/rockchip_i2s.h                  |   3 +
 sound/soc/rockchip/rockchip_pdm.c                  | 516 +++++++++++
 sound/soc/rockchip/rockchip_pdm.h                  |  83 ++
 sound/soc/rockchip/rockchip_spdif.c                |   4 +
 sound/soc/samsung/s3c24xx_uda134x.c                |   2 +-
 sound/soc/sh/Kconfig                               |   2 +-
 sound/soc/sh/fsi.c                                 |  13 +-
 sound/soc/sh/rcar/adg.c                            |  61 +-
 sound/soc/sh/rcar/cmd.c                            |   7 +-
 sound/soc/sh/rcar/core.c                           | 494 +++++++---
 sound/soc/sh/rcar/ctu.c                            |   6 +
 sound/soc/sh/rcar/dma.c                            |  32 +-
 sound/soc/sh/rcar/dvc.c                            |  12 +-
 sound/soc/sh/rcar/gen.c                            |   2 +
 sound/soc/sh/rcar/rsnd.h                           |  68 +-
 sound/soc/sh/rcar/src.c                            |  20 +-
 sound/soc/sh/rcar/ssi.c                            | 241 +++--
 sound/soc/sh/rcar/ssiu.c                           |  37 +
 sound/soc/soc-compress.c                           |   6 +-
 sound/soc/soc-core.c                               |  86 +-
 sound/soc/soc-topology.c                           |  37 +-
 sound/soc/stm/Kconfig                              |  29 +-
 sound/soc/stm/Makefile                             |  12 +-
 sound/soc/stm/stm32_i2s.c                          | 946 +++++++++++++++++++
 sound/soc/stm/stm32_sai.c                          |  15 +-
 sound/soc/stm/stm32_sai.h                          |  73 +-
 sound/soc/stm/stm32_sai_sub.c                      | 143 ++-
 sound/soc/stm/stm32_spdifrx.c                      | 998 +++++++++++++++++++++
 sound/soc/sunxi/sun4i-codec.c                      |  63 ++
 sound/soc/sunxi/sun8i-codec-analog.c               | 145 ++-
 sound/soc/zte/zx-i2s.c                             |  15 +-
 152 files changed, 10306 insertions(+), 1191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
 create mode 100644 sound/soc/codecs/es8316.c
 create mode 100644 sound/soc/codecs/es8316.h
 create mode 100644 sound/soc/codecs/zx_aud96p22.c
 create mode 100644 sound/soc/generic/audio-graph-card.c
 create mode 100644 sound/soc/generic/audio-graph-scu-card.c
 create mode 100644 sound/soc/intel/boards/bytcht_es8316.c
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_max98927.c
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
 create mode 100644 sound/soc/intel/skylake/skl-debug.c
 create mode 100644 sound/soc/rockchip/rockchip_pdm.c
 create mode 100644 sound/soc/rockchip/rockchip_pdm.h
 create mode 100644 sound/soc/stm/stm32_i2s.c
 create mode 100644 sound/soc/stm/stm32_spdifrx.c

--uybqx5lu4exsyph7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllabG4ACgkQJNaLcl1U
h9Bj+ggAhb9brwUvOZsGWvCqCRMhdw7072aLRK6NvY3QhBehaJYWilSbGTrIQZr4
Bvv5gG241BQpXdIDEvTueCTH+5jCBupS8Rs+DaJjLjg6FXK//jh/faW6/86xVWm+
zsnVmPpyRecYOz12f4ev9S+YECzJPriKCsjYvJKjzptB/W98zZFFXvfSHBM7wqZx
MXA+0wB1PeeAU55/I9aS+wWlaS0i5LGEqIcb2ErPVSpau6iiTrCeVm81kUI3IJfP
qKOS+v/px16UtXHtes3f1FP/1bQcnMUda8lr/bQeFRJHwLhpVBSknKpL6a1kHYPG
a2jrMM00jcp9LfdBLiw2JOD066cR3Q==
=iO3H
-----END PGP SIGNATURE-----

--uybqx5lu4exsyph7--

--===============6414937102939449717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6414937102939449717==--
