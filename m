From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.3
Date: Sun, 30 Aug 2015 16:10:32 +0100
Message-ID: <20150830151032.GE12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0747355367062009652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 832B52604A9
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 17:10:42 +0200 (CEST)
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


--===============0747355367062009652==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XhrUtAZ9VCvva7+0"
Content-Disposition: inline


--XhrUtAZ9VCvva7+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c13dcf9f2d6f5f06ef1bf79ec456df614c5e058b:

  Linux 4.2-rc8 (2015-08-23 20:52:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.2-rc8

for you to fetch changes up to 91931320cfbbcc1dd874c2d0aef62e7d90f07f70:

  Merge remote-tracking branches 'asoc/topic/wm8996', 'asoc/topic/xtensa' and 'asoc/topic/zx296702' into asoc-next (2015-08-30 15:59:18 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.3

Not many updates to the core here, but an awful lot of driver updates
this time round:

 - Factoring out of AC'97 reset code into the core
 - New drivers for Cirrus CS4349, GTM601, InvenSense ICS43432, Realtek
   RT298 and ST STI controllers.
 - Machine drivers for Rockchip systems with MAX98090 and RT5645 and
   RT5650.
 - Initial driver support for Intel Skylake devices.
 - A large number of cleanups for Lars-Peter Clausen and Axel Lin.

----------------------------------------------------------------
Anatol Pomozov (4):
      ASoC: max98357a: Make 'sdmode-gpios' dts property optional
      ASoC: max98357a: Use DAI input as a dapm widget
      ASoC: max98357a: Do not print error message on asoc/gpio errors
      ASoC: rl6231: Simplify DMIC divider calculation expression

Andrew Morton (1):
      ASoC: cs4349: include gpio/consumer.h

Andrzej Hajda (2):
      ASoC: intel: use kmemdup rather than duplicating its implementation
      ASoC: topology: use kmemdup rather than duplicating its implementation

Antonio Borneo (1):
      ASoC: wm0010: Remove redundant spi driver bus initialization

Arnaud Pouliquen (12):
      ASoC: simple card: set cpu-dai sysclk with mclk-fs
      ASoC: sti-sas: Add sti platform codec
      ASoC: sti: add binding for ASoC driver
      ASoC: sti: Add uniperipheral header file
      ASoC: sti: Add CPU DAI driver for playback
      ASoC: sti-sas: fix x86 compilation issue.
      ASoC: sti: minor corrections for uniplayer
      ASoC: sti: Add CPU DAI driver for capture
      ASoC: sti: Add uniperipheral dai driver
      ASoC: Add ability to build sti drivers
      ASoC: sti: Add clock adjustement control
      ASoC: sti: Add IEC control

Axel Lin (73):
      ASoC: gtm601: Fix modalias
      ASoC: rt5645: Constify dmi_system_id table
      ASoC: cs42xx8: Move the code checking *regmap argument earlier
      ASoC: cs42xx8: Setup of_match_table
      ASoC: 88pm860x: Don't change pm860x->dir setting if pm860x_set_dai_sysclk fails
      ASoC: ak4642: Fix up max_register setting
      ASoC: lm49453: Remove fs_rate from struct lm49453_priv
      ASoC: gtm601: Constify soc_codec_dev_gtm601
      ASoC: Constify reg_default tables
      ASoC: rt286: Constify dmi_system_id table
      ASoC: wm0010: Remove spurious missing IRQF_ONESHOT
      ASoC: wm5100: Remove spurious IRQF_ONESHOT flag
      ASoC: wm8996: Remove spurious IRQF_ONESHOT flag
      ASoC: sti-sas: Fix checking return value for ERR_PTR
      ASoC: sti-sas: Staticise local symbols
      ASoC: Constify snd_soc_dai_ops variables
      ASoC: da732x: Merge da732x_dai1_ops and da732x_dai2_ops
      ASoC: sirf-audio-codec: Staticise local symbols
      ASoC: Constify dev_pm_ops variables
      ASoC: cs4349: Fix max_register setting for cs4349_regmap
      ASoC: cs4349: Constify cs4349_regmap
      ASoC: cs4349: Fix setting digital interface format
      ASoC: cs4349: Set .writeable_reg for cs4349_regmap
      ASoC: cs4349: Drop platform data support
      ASoC: cs4349: Remove unneeded NULL test for cs4349->reset_gpio
      ASoC: cs4349: Fix up setting PWR_DWN bit
      ASoC: cs35l32: Fix define for CS35L32_SDOUT_3ST
      ASoC: cs35l32: Remove unneeded NULL test for cs35l32->reset_gpio
      ASoC: cs42l73: Fix mask for setting CS42L73_SP_3ST bit
      ASoC: rt5677: Remove NULL test for desc before gpiod_set_value_cansleep call
      ASoC: tas2552: Fix off-by-one for max_register setting
      ASoC: tas5086: Improve the logic for de-emphasis sampling rate selection
      ASoC: pcm1681: Improve the logic for de-emphasis sampling rate selection
      ASoC: sta529: Remove redundant I2C_FUNC_SMBUS_BYTE_DATA functionality check
      ASoC: cs4265: CS4265_INT_STATUS is readable register
      ASoC: Use params_width() at appropriate places
      ASoC: rt5677: Return error if devm_gpiod_get_optional return ERR_PTR
      ASoC: tas2552: Remove unneeded NULL test for tas2552->enable_gpio
      ASoC: max98088: Get rid of max98088_access table
      ASoC: max98095: Get rid of max98095_access table
      ASoC: wm8983: Get rid of wm8983_access_masks table
      ASoC: max98090: Simplify max98090_readable_register implementation
      ASoC: wm8741: Simplify wm8741_set_dai_sysclk implementation
      ASoC: wm8731: Drop wm8731_writeable function
      ASoC: wm8753: Drop wm8753_writeable function
      ASoC: topology: Use kcalloc instead of kzalloc for array allocation
      ASoC: adav80x: Remove .read_flag_mask setting from adav80x_regmap_config
      ASoC: cs35l32: Use case range at appropriate places
      ASoC: cs42l52: Use case range at appropriate place
      ASoC: cs42l56: Use case range at appropriate place
      ASoC: cs42l73: Use case range at appropriate place
      ASoC: wm8741: Drop misleading readable_reg callback implementation
      ASoC: Set missing card owner field
      ASoC: davinci: Convert to use devm_ioremap_resource
      ASoC: omap-mcbsp: Convert to use devm_ioremap_resource
      ASoC: SPEAr: Convert to use devm_ioremap_resource
      ASoC: tegra: Fix unused variable 'spdif' warning
      ASoC: tegra: Use devm_ioremap_resource instead of open code
      ASoC: ics43432: Fix module license
      ASoC: pxa-ssp: Convert to devm_snd_soc_register_component
      ASoC: pxa2xx-i2s: Convert to devm_snd_soc_register_component
      ASoC: sh: ssi: Convert to devm_snd_soc_register_component
      ASoC: qcom: Constify asoc_qcom_lpass_cpu_dai_ops
      ASoC: au1x: Convert to devm_snd_soc_register_platform
      ASoC: blackfin: Convert to devm_snd_soc_register_platform
      ASoC: nuc900: Convert to devm_snd_soc_register_platform
      ASoC: pxa: Convert to devm_snd_soc_register_platform
      ASoC: txx9: Convert to devm_snd_soc_register_platform
      ASoC: spear_pcm: Use devm_snd_dmaengine_pcm_register to fix resource leak
      ASoC: sh: dma-sh7760: Convert to devm_snd_soc_register_platform
      ASoC: au1x: psc-i2s: Convert to use devm_ioremap_resource
      ASoC: sti_uniperif: Ensure component is unregistered when unload module
      ASoC: zx296702-i2s: Fix resource leak when unload module

Bard Liao (4):
      ASoC: rt5645: move RT5645 muxes to rt5645_specific_dapm_widgets
      ASoC: add rt298 codec driver
      ASoC: rt298: remove meanless pr_info
      ASoC: rl6231: add pll preset table

Ben Zhang (3):
      ASoC: rt5677: Switch to use descriptor-based gpiod API
      ASoC: rt5677: Switch to use unified device property API
      ASoC: rt5677: Allow arbitrary block read/write via SPI

Charles Keepax (8):
      ASoC: arizona: Implement stability check for EQ coefficients
      ASoC: arizona: Implement stability check for LHPF coefficients
      mfd: wm5110: Add registers for custom write sequence triggers
      mfd: wm5110: Add register patch for rev E and above
      ASoC: wm5110: Add special DRE on/off handling for the headphone path
      ASoC: arizona: Use the more idiomatic params_width
      ASoC: arizona: Fix error path in codec probe
      ASoC: arizona: Poll for FLL clock OK rather than use interrupts

Dan Carpenter (3):
      ASoC: fsl: fsl_spdif: signedness bug in fsl_spdif_startup()
      ASoC: max98925: reading beyond the end of the array
      ASoC: sti: error handling bug in sti_uniperiph_cpu_dai_of()

Fabio Estevam (6):
      ASoC: fsl: fsl_asrc: Check for clk_prepare_enable() error
      ASoC: fsl: fsl_spdif: Check for clk_prepare_enable() error
      ASoC: max98090: Check for clk_prepare_enable() error
      ASoC: wm8904: Check for clk_prepare_enable() error
      ASoC: wm8731: Check for clk_prepare_enable() error
      ASoC: max98095: Check for clk_prepare_enable() error

Fang, Yang A (2):
      ASoC: ts3a227e: do not report jack status when there is i2c read err
      ASoC: max98090: Fix sequencing when starting additional routes

Geert Uytterhoeven (2):
      ASoC: fsi: Remove obsolete sh_fsi2 platform_device_id entry
      ASoC: rsnd: Silence DMA slave ID compile warning on 64-bit

Hardik T Shah (1):
      ASoC: Intel: Skylake: Add helpers for SRC and converter modules

Harsha Priya (1):
      ASoC: ssm4567: Added ACPI entry for SSM4567 codec

Jarkko Nikula (6):
      ASoC: rt286: Prefix hexadecimal ID register value with 0x in error print
      ASoC: rt5640: Prefix hexadecimal ID register value with 0x in error print
      ASoC: rt5645: Prefix hexadecimal ID register value with 0x in error print
      ASoC: rt5651: Prefix hexadecimal ID register value with 0x in error print
      ASoC: rt5670: Prefix hexadecimal ID register value with 0x in error print
      ASoC: rt5677: Prefix hexadecimal ID register value with 0x in error print

Javier Martinez Canillas (1):
      ASoC: Export OF module alias information in missing codec drivers

Jean-Francois Moine (1):
      ASoC: kirkwood: prevent double streaming

Jeeja KP (11):
      ASoC: Intel: Add Skylake HDA platform driver
      ASoC: Intel: Add Skylake HDA audio driver
      ASoC: Intel: Add makefile support for SKL driver
      ASoC: Intel: Add support for decoupled mode in skl driver
      ASoC: Intel: Skylake: Add NHLT support to get BE config
      ASoC: Intel: Skylake: Add dsp and ipc init helpers
      ASoC: Intel: Skylake: Fix the NHLT rate size
      ASoC: Intel: Skylake: Use acpi header for NHLT header
      ASoC: Intel: Skylake: Add helpers for DSP module configuration
      ASoC: Intel: Skylake: Add DSP module init and binding routines
      ASoC: Intel: Skylake: Add pipe management helpers

Joe Perches (1):
      ASoC: atmel_ssc_dai: Correct misuse of 0x%<decimal>

John Lin (1):
      ASoC: rt5640: fix line out no sound issue

Jonathan Corbet (1):
      ASoC: Clean up docbook warnings

Julia Lawall (1):
      ASoC: ux500: adjust devm usage

Junjie Mao (1):
      ASoC: Intel: fix runtime pm imbalance on error

Jyri Sarha (1):
      ASoC: omap-hdmi-audio: Set buffer bytes step constraint to 128

Kenneth Westfield (2):
      ASoC: qcom: move board Kconfig deps to parent config
      ASoC: qcom: remove Kconfig deps from variant configs

Koro Chen (5):
      ASoC: dpcm: Add checks of playback/capture before dpcm_get_be
      ASoC: rt5645: Fix missing free_irq
      ASoC: rt5645: Add regulator support
      ASoC: mediatek: Add suspend/resume callbacks
      ASoC: mediatek: Remove AIF widgets for backend DAIs

Krzysztof Kozlowski (2):
      ASoC: mediatek: Drop owner assignment from platform_driver
      ASoC: drivers: Drop owner assignment from i2c_driver

Kuninori Morimoto (36):
      regmap: add force_write option on _regmap_update_bits()
      regmap: add regmap_write_bits()
      regmap: add regmap_fields_force_write()
      ASoC: rsnd: gen: add rsnd_force_write()
      ASoC: core: add snd_soc_of_parse_audio_prefix()
      ASoC: rsrc-card: use snd_soc_of_parse_audio_route/prefix for routing
      ASoC: rsnd: remove unnecessary 'out of memory' message from SSI
      ASoC: rsnd: remove unnecessary 'out of memory' message from SRC
      ASoC: rsnd: remove unnecessary 'out of memory' message from DVC
      ASoC: rsnd: rename BUSIF_DALIGN to SSI_BUSIF_DALIGN
      ASoC: rsnd: rename INT_ENABLE to SSI_INT_ENABLE
      ASoC: rsnd: fixup each module counter on __rsnd_mod_call()
      ASoC: rsnd: add workaround for SRC sync convert + DVC
      ASoC: rsnd: rsnd_mod_id() return -1 if mod was NULL
      ASoC: rsnd: move DVC specific macro into dvc.c
      ASoC: rsnd: move SRC specific macro into src.c
      ASoC: rsnd: dvc: make sure DVC soft reset
      ASoC: rsnd: src: make sure SRC soft reset
      ASoC: rsnd: enable module multi connection
      ASoC: rsnd: rename rsnd_path_parse/break() into add/remove
      ASoC: rsnd: add rsnd_path_parse() for CTU/MIX/DVC route setting
      ASoC: rsnd: add rsnd_dvc_initialize_lock/unlock()
      ASoC: rsnd: add rsnd_src_initialize_lock/unlock()
      ASoC: rsnd: tidyup ADINR function name
      ASoC: rsnd: add rsnd_get_adinr_chan()
      ASoC: rsnd: tidyup data align position
      ASoC: rsnd: show debug message for SSI/SRC/DVC connection
      ASoC: rsnd: tidyup rsnd_dma_ops definition place
      ASoC: rsnd: check the Gen1 at the beginning of DVC probe
      ASoC: rsnd: dma: add DMA name on .ops
      ASoC: rsnd: add rsnd_io_to_mod()
      ASoC: rsnd: tidyup SRC position on each code
      ASoC: rsnd: update Audio DMA path search method
      ASoC: rsnd: add CTU (Channel Transfer Unit) prototype support
      ASoC: rsnd: add MIX (Mixer) support
      ASoC: rsnd: tidyup parameter assignment position

Lars-Peter Clausen (83):
      ASoC: rt5645: Replace direct snd_soc_codec dapm field access
      ASoC: tas571x: Replace direct snd_soc_codec dapm field access
      ASoC: omap3pandora: Use card DAPM context to access widgets
      ASoC: cht_bsw_max98090_ti: Use card DAPM context to access widgets
      ASoC: dapm_widget_show_codec: Use component instead of CODEC
      ASoC: Remove snd_soc_codec dapm field
      ASoC: Prevent components from being bound to multiple cards
      ASoC: Use card field to indicate whether a component is bound
      ASoC: uda134x: Move state struct allocation to bus probe
      ASoC: uda134x: Explicitly handle in-data addresses
      ASoC: uda134x: Convert to regmap
      ASoC: uda134x: Use regmap_update_bits() were appropriate
      ASoC: max98925: Remove control_data initialization
      ASoC: max9877: Make driver global regmap struct local
      ASoC: max9877: Convert to component
      ASoC: max9768: Use managed gpio request
      ASoC: max9768: Convert to component
      ASoC: cs4349: Fix suspend/resume
      ASoC: cs4349: Don't use rtd->codec
      ASoC: dapm: Add helper function to free a widget
      ASoC: dapm: Avoid duplicating immutable strings
      ALSA: ac97: Add helper function to reset the AC97 device
      ASoC: ac97: Add support for resetting device before registration
      ASoC: ad1980: Use core AC'97 reset helper
      ASoC: stac9766: Use core reset helper
      ASoC: wm9705: Use core AC'97 reset helper
      ASoC: wm9712: Use core AC'97 reset helper
      ASoC: wm9713: Use core AC'97 reset helper
      ASoC: dapm: Drop always true checks
      ASoC: dapm: Simplify list creation in dapm_dai_get_connected_widgets()
      ASoC: dapm: Add widget path iterators
      ASoC: wm8804: Drop duplicate const
      ASoC: lpass-ipq806x: Staticise local symbols
      ASoC: rcar ctu: Staticise local symbols
      ASoC: uniperf: Add missing __iomem annotation
      ASoC: uniperf: Staticise local symbols
      ASoC: xtfpga-i2s: Add missing __rcu annotation
      ASoC: 88pm860x: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: ab8500: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: adau1373: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: alc5623: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: alc5632: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: cs42l52: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: cs42l56: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: da7210: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: da7213: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: da9055: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: jz4740: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max9768: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max98088: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max98090: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max98095: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max9850: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: max9877: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5631: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5640: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5645: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5651: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5670: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: rt5677: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: sgtl5000: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: ssm2602: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: tpa6130a2: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: twl4030: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: uda1380: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8350: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8400: Don't use range container for TLV with one entry
      ASoC: wm8737: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8753: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8961: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8962: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm8990: Don't use range container for TLV with one entry
      ASoC: wm8991: Don't use range container for TLVs with one entry
      ASoC: wm8993: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm9081: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm9090: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm9713: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: wm_hubs: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
      ASoC: dapm: dapm_dai_get_connected_widgets: Fix missing mutex unlock
      ASoC: dapm: Consolidate input and output path handling
      ASoC: dapm: Consolidate path trace events
      ASoC: ssm4567: Add sense support

Luis de Bethencourt (1):
      ASoC: bcm2835-i2s: Fix module autoload for OF platform drivers

Maciej S. Szmigiero (6):
      ASoC: fsl_ssi: enable IPG clock during AC'97 reg access
      ASoC: fsl_ssi: AC'97 DAI driver needs probe method too
      ASoC: fsl_ssi: enable AC'97 asymmetric rates
      ASoC: fsl_ssi: add AC'97 ops setting check and cleanup
      ASoC: fsl_ssi: instantiate AC'97 CODEC
      ASoC: fsl_ssi: adjust set DAI format in AC'97 mode

Marek Belisko (2):
      ASoC: Add gtm601 codec driver
      Documentation: vendor-prefixes: Add option prefix

Mark Brown (43):
      Merge branch 'topic/codec-dapm' of git://git.kernel.org/.../broonie/sound into asoc-rt5645
      Merge tag 'regmap-force' into asoc-rcar
      ASoC: sti-sas: Remove spurious dependency on SND_SOC_STI
      Merge branches 'topic/rt298', 'topic/ts3a227e' and 'topic/cs42xx8' of git://git.kernel.org/.../broonie/sound into asoc-owner
      Merge branches 'topic/owner' and 'topic/reg-default' of git://git.kernel.org/.../broonie/sound into asoc-max9877
      Merge branch 'topic/of-name' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge tag 'regmap-seq-delay-api' of git://git.kernel.org/.../broonie/regmap into asoc-wm5110
      Merge tag 'regmap-seq-delay-api' of git://git.kernel.org/.../broonie/regmap into asoc-reg-default
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound into asoc-rt5645
      ASoC: sti-uniperf: Fix implicit inclusion of pinctrl
      Merge branch 'fix/dapm' of git://git.kernel.org/.../broonie/sound into asoc-dapm
      Merge branch 'topic/owner' of git://git.kernel.org/.../broonie/sound into asoc-ssm4567
      Merge branch 'fix/ssm4567' of git://git.kernel.org/.../broonie/sound into asoc-ssm4567
      Merge tag 'v4.2-rc6' into asoc-topology
      Merge branch 'topic/gtm601' of git://git.kernel.org/.../broonie/sound into asoc-ics43432
      Merge branch 'topic/ics43432' of git://git.kernel.org/.../broonie/sound into asoc-gtm601
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adav80x', 'asoc/fix/arizona', 'asoc/fix/max98090', 'asoc/fix/rt5640', 'asoc/fix/samsung' and 'asoc/fix/wm8994' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1681' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ssm4567' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/ac97', 'asoc/topic/ak4542', 'asoc/topic/arizona' and 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/au1x', 'asoc/topic/bcm2835', 'asoc/topic/blackfin' and 'asoc/topic/card' into asoc-next
      Merge remote-tracking branches 'asoc/topic/const', 'asoc/topic/cs35l32', 'asoc/topic/cs4265' and 'asoc/topic/cs42l52' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l56', 'asoc/topic/cs42l73', 'asoc/topic/cs4349' and 'asoc/topic/da732x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/davinci-vcif', 'asoc/topic/doc' and 'asoc/topic/dpcm' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsi', 'asoc/topic/fsl', 'asoc/topic/fsl-asrc', 'asoc/topic/fsl-card' and 'asoc/topic/fsl-sai' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-spdif', 'asoc/topic/fsl-ssi', 'asoc/topic/gtm601', 'asoc/topic/ics43432' and 'asoc/topic/ids' into asoc-next
      Merge remote-tracking branches 'asoc/topic/intel', 'asoc/topic/kirkwood', 'asoc/topic/lm49453', 'asoc/topic/max9768' and 'asoc/topic/max98088' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98090', 'asoc/topic/max98095', 'asoc/topic/max98357a', 'asoc/topic/max9877' and 'asoc/topic/max98925' into asoc-next
      Merge remote-tracking branches 'asoc/topic/mediatek', 'asoc/topic/mtk', 'asoc/topic/nuc900', 'asoc/topic/of-name' and 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branches 'asoc/topic/pm-ops', 'asoc/topic/pxa' and 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rcar', 'asoc/topic/reg-default', 'asoc/topic/rl6231', 'asoc/topic/rockchip' and 'asoc/topic/rt286' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt298', 'asoc/topic/rt5640', 'asoc/topic/rt5651' and 'asoc/topic/rt5670' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5677', 'asoc/topic/sh', 'asoc/topic/simple', 'asoc/topic/sirf-codec' and 'asoc/topic/spear' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ssm2518', 'asoc/topic/sta529', 'asoc/topic/sti' and 'asoc/topic/sti-sas' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas2552', 'asoc/topic/tas5086', 'asoc/topic/tegra', 'asoc/topic/tlv' and 'asoc/topic/topology' into asoc-next
      Merge remote-tracking branches 'asoc/topic/txx9', 'asoc/topic/uda134x', 'asoc/topic/ux500' and 'asoc/topic/width' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm0010', 'asoc/topic/wm5100', 'asoc/topic/wm5110', 'asoc/topic/wm8004' and 'asoc/topic/wm8731' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8741', 'asoc/topic/wm8753', 'asoc/topic/wm8904', 'asoc/topic/wm8960' and 'asoc/topic/wm8983' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8996', 'asoc/topic/xtensa' and 'asoc/topic/zx296702' into asoc-next

Masanari Iida (2):
      ASoC: Fix warning while make xmldocs caused by soc-core.c
      ASoC: Fix warning caused by a typo in comments of snd_soc_add_platform()

Mengdong Lin (4):
      ASoC: topology: Change pass number of DAI smaller than graph
      ASoC: topology: Bind vendor specific kcontrol handlers before standard ones
      ASoC: topology: Reduce arguments of soc_tplg_kcontrol_bind_io()
      ASoC: topology: Add support for TLV bytes controls

Nariman Poushin (2):
      regmap: Use reg_sequence for multi_reg_write / register_patch
      ASoC: wm5110: Use reg_sequence for multi_reg_write/register_patch

Nicolas Boichat (5):
      ASoC: rt5645: Remove irq_jack_detection function
      ASoC: rt5645: Update dapm pins when the card is not instantiated yet
      ASoC: rt5645: Simplify rt5645_enable_push_button_irq
      ASoC: rt5645: Remove unused rt5645 variable
      ASoC: rt5645: Remove return value in jack detect work

Nicolin Chen (1):
      ASoC: fsl-asoc-card: Specify codec_dai_name for DAI links

Nik Nyby (1):
      ASoC: codecs: max98088: fix typo in constant

Nikesh Oswal (1):
      ASoC: arizona: Fix gain settings of FLL in free-run mode

Oder Chiou (7):
      ASoC: Add function "rl6231_get_pre_div" to correct the dmic clock calculation
      ASoC: rt5645: Modify the headphone depop and calibration function to prevent the pop sound in the booting time
      ASoC: rt5645: Modify the jack detection function to prevent the pop sound while the jack plug in
      ASoC: rt5645: Remove the incorrect setting of the JD mode
      ASoC: rt5645: Add the register RT5645_CHARGE_PUMP to readable check function
      ASoC: rt5645: Add struct dmi_system_id "Google Celes" for chrome platform
      ASoC: rt5645: Prevent the pop sound of the headphone while rebooting or shutdowning

Omair M Abdullah (1):
      ASoC: Intel: Skylake: Print error code in IPC for SKL

Ricard Wanderlof (3):
      ASoC: ssm2518: Add explicit device tree support
      ASoC: ics43432: Add codec driver for InvenSense ICS-43432
      ASoC: ics43432: Fix build errors

Sergey Kiselev (1):
      ASoC: wm8731: initialize the hardware when loading the codec driver

Shengjiu Wang (2):
      ASoC: fsl: Add dedicated DMA buffer size for each cpu dai
      ASoC: core: Don't probe the component which is dummy

Subhransu S. Prusty (9):
      ASoC: Intel: Define SKL ADSP IPC and general purpose registers
      ASoC: Intel: Reorganize the common dsp structure
      ASoC: Intel: Add helper to poll register for DSP status
      ASoC: Intel: Add helper to update register bits with attr RWC
      ASoC: Intel: Add Skylake IPC library
      ASoC: Intel: Add DSP init and boot up functionality for SKL
      ASoC: Intel: Skylake: Add dsp loader ops
      ASoC: Intel: Skylake: Process code loader DMA interrupt
      ASoC: Intel: Skylake: Add SKL DSP initialization

Tim Howe (1):
      ASoC: cs4349: Add support for Cirrus Logic CS4349

Vaishali Thakkar (7):
      ASoC: xtensa: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: tegra: Use devm_clk_get
      ASoC: tegra: Convert to managed resources
      ASoC: davinci-vcif: Use devm_snd_soc_register_component
      ASoC: tegra: Revert part of "ASoC: tegra: Convert to managed resources"
      ASoC: rockchip: i2s: Adjust devm usage
      ASoC: samsung: Remove redundant arndale_audio_remove

Vinod Koul (7):
      ASoC: intel: kconfig - Move DW_DMAC_CORE dependency to machines
      ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
      ASoC: intel - atom: statify sst_slot_enum_info
      ASoC: intel - atom: fix sst_platform_compr_ops declaration
      ASoC: Intel: Skylake: Add code loader DMA registers
      ASoC: Intel: Skylake: add code loader DMA operations
      ASoC: Intel: Skylake: Add code loader DMA APIs

Xing Zheng (1):
      ASoC: rockchip: fix a misjudgement by return

Xiubo Li (1):
      ASoC: fsl: fix typos for sound/soc/fsl/*

Zidan Wang (4):
      ASoC: wm8960: update pll and clock setting function
      ASoC: fsl-sai: add 32 bit word length support
      ASoC: fsl-asoc-card: add wm8960 support
      ASoC: wm8994: fix add dynamic path error

kbuild test robot (8):
      ASoC: fix platform_no_drv_owner.cocci warnings
      ASoC: gtm601_dai can be static
      ASoC: sti-sas: fix platform_no_drv_owner.cocci warnings
      ASoC: sti: sti_uniperiph_dai_create_ctrl() can be static
      ASoC: cs4349: fix platform_no_drv_owner.cocci warnings
      ASoC: rockchip: fix platform_no_drv_owner.cocci warnings
      ASoC: rockchip: fix platform_no_drv_owner.cocci warnings
      ASoC: ics43432: fix platform_no_drv_owner.cocci warnings

zhengxing (2):
      ASoC: rockchip: Add machine driver for max98090 codec
      ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

 Documentation/DocBook/alsa-driver-api.tmpl         |    2 +-
 Documentation/devicetree/bindings/sound/cs4349.txt |   19 +
 .../devicetree/bindings/sound/ics43432.txt         |   17 +
 .../devicetree/bindings/sound/max98357a.txt        |    6 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   22 +
 .../bindings/sound/renesas,rsrc-card.txt           |    7 +
 .../bindings/sound/rockchip-max98090.txt           |   19 +
 .../devicetree/bindings/sound/rockchip-rt5645.txt  |   17 +
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  155 +++
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 drivers/base/regmap/internal.h                     |    2 +-
 drivers/base/regmap/regmap.c                       |   73 +-
 drivers/gpu/drm/i2c/adv7511.c                      |    2 +-
 drivers/input/misc/drv260x.c                       |    6 +-
 drivers/input/misc/drv2665.c                       |    2 +-
 drivers/input/misc/drv2667.c                       |    4 +-
 drivers/mfd/arizona-core.c                         |    2 +-
 drivers/mfd/twl6040.c                              |    2 +-
 drivers/mfd/wm5102-tables.c                        |    6 +-
 drivers/mfd/wm5110-tables.c                        |   22 +-
 drivers/mfd/wm8994-core.c                          |    8 +-
 drivers/mfd/wm8997-tables.c                        |    2 +-
 include/linux/mfd/arizona/registers.h              |   37 +
 include/linux/regmap.h                             |   28 +-
 include/sound/ac97_codec.h                         |    2 +
 include/sound/rcar_snd.h                           |   14 +
 include/sound/rt298.h                              |   20 +
 include/sound/soc-dapm.h                           |   84 +-
 include/sound/soc-topology.h                       |   13 +-
 include/sound/soc.h                                |   29 +-
 include/trace/events/asoc.h                        |   53 +-
 sound/ac97_bus.c                                   |   62 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/atmel_ssc_dai.c                    |    2 +-
 sound/soc/au1x/dbdma2.c                            |   11 +-
 sound/soc/au1x/dma.c                               |   11 +-
 sound/soc/au1x/psc-i2s.c                           |   16 +-
 sound/soc/bcm/bcm2835-i2s.c                        |    2 +
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |   10 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |   10 +-
 sound/soc/blackfin/bfin-eval-adau1x61.c            |    1 +
 sound/soc/codecs/88pm860x-codec.c                  |   32 +-
 sound/soc/codecs/Kconfig                           |   25 +
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/ab8500-codec.c                    |    7 +-
 sound/soc/codecs/ad1980.c                          |   36 +-
 sound/soc/codecs/adau1373.c                        |   22 +-
 sound/soc/codecs/adau1701.c                        |    1 -
 sound/soc/codecs/adau1761-i2c.c                    |    1 -
 sound/soc/codecs/adau1781-i2c.c                    |    1 -
 sound/soc/codecs/adau1977-i2c.c                    |    1 -
 sound/soc/codecs/adav803.c                         |    1 -
 sound/soc/codecs/adav80x.c                         |    3 +-
 sound/soc/codecs/ak4535.c                          |    1 -
 sound/soc/codecs/ak4641.c                          |    1 -
 sound/soc/codecs/ak4642.c                          |   34 +-
 sound/soc/codecs/ak4671.c                          |    1 -
 sound/soc/codecs/alc5623.c                         |    8 +-
 sound/soc/codecs/alc5632.c                         |   10 +-
 sound/soc/codecs/arizona.c                         |  129 +-
 sound/soc/codecs/arizona.h                         |   20 +-
 sound/soc/codecs/cs35l32.c                         |   60 +-
 sound/soc/codecs/cs35l32.h                         |    2 +-
 sound/soc/codecs/cs4265.c                          |   19 +-
 sound/soc/codecs/cs4270.c                          |    1 -
 sound/soc/codecs/cs4271-i2c.c                      |    1 -
 sound/soc/codecs/cs42l51-i2c.c                     |    1 -
 sound/soc/codecs/cs42l52.c                         |   65 +-
 sound/soc/codecs/cs42l56.c                         |   71 +-
 sound/soc/codecs/cs42l73.c                         |  115 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |    4 +-
 sound/soc/codecs/cs42xx8.c                         |   19 +-
 sound/soc/codecs/cs42xx8.h                         |    1 +
 sound/soc/codecs/cs4349.c                          |  392 ++++++
 sound/soc/codecs/cs4349.h                          |  136 +++
 sound/soc/codecs/da7210.c                          |   29 +-
 sound/soc/codecs/da7213.c                          |   18 +-
 sound/soc/codecs/da732x.c                          |   15 +-
 sound/soc/codecs/da9055.c                          |   19 +-
 sound/soc/codecs/gtm601.c                          |   95 ++
 sound/soc/codecs/ics43432.c                        |   76 ++
 sound/soc/codecs/isabelle.c                        |   11 +-
 sound/soc/codecs/jz4740.c                          |    7 +-
 sound/soc/codecs/lm4857.c                          |    1 -
 sound/soc/codecs/lm49453.c                         |   19 +-
 sound/soc/codecs/max9768.c                         |   71 +-
 sound/soc/codecs/max98088.c                        |  329 +----
 sound/soc/codecs/max98088.h                        |    2 +-
 sound/soc/codecs/max98090.c                        |  171 ++-
 sound/soc/codecs/max98090.h                        |    1 +
 sound/soc/codecs/max98095.c                        |  354 +-----
 sound/soc/codecs/max98357a.c                       |   25 +-
 sound/soc/codecs/max9850.c                         |    8 +-
 sound/soc/codecs/max9877.c                         |   33 +-
 sound/soc/codecs/max98925.c                        |    6 +-
 sound/soc/codecs/mc13783.c                         |    6 +-
 sound/soc/codecs/ml26124.c                         |    3 +-
 sound/soc/codecs/pcm1681.c                         |   14 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    1 -
 sound/soc/codecs/pcm512x.c                         |    4 +-
 sound/soc/codecs/rl6231.c                          |  104 +-
 sound/soc/codecs/rl6231.h                          |    1 +
 sound/soc/codecs/rt286.c                           |   11 +-
 sound/soc/codecs/rt298.c                           | 1271 ++++++++++++++++++++
 sound/soc/codecs/rt298.h                           |  206 ++++
 sound/soc/codecs/rt5631.c                          |    8 +-
 sound/soc/codecs/rt5640.c                          |   59 +-
 sound/soc/codecs/rt5645.c                          |  443 +++----
 sound/soc/codecs/rt5645.h                          |   27 +-
 sound/soc/codecs/rt5651.c                          |   19 +-
 sound/soc/codecs/rt5670.c                          |   21 +-
 sound/soc/codecs/rt5677-spi.c                      |  233 +++-
 sound/soc/codecs/rt5677-spi.h                      |    8 +-
 sound/soc/codecs/rt5677.c                          |  159 +--
 sound/soc/codecs/rt5677.h                          |    5 +-
 sound/soc/codecs/sgtl5000.c                        |    8 +-
 sound/soc/codecs/si476x.c                          |    2 +-
 sound/soc/codecs/sirf-audio-codec.c                |    4 +-
 sound/soc/codecs/ssm2518.c                         |   10 +-
 sound/soc/codecs/ssm2602-i2c.c                     |    1 -
 sound/soc/codecs/ssm2602.c                         |    7 +-
 sound/soc/codecs/ssm4567.c                         |   34 +-
 sound/soc/codecs/sta32x.c                          |    1 -
 sound/soc/codecs/sta350.c                          |    1 -
 sound/soc/codecs/sta529.c                          |    4 -
 sound/soc/codecs/stac9766.c                        |   57 +-
 sound/soc/codecs/sti-sas.c                         |  628 ++++++++++
 sound/soc/codecs/tas2552.c                         |   20 +-
 sound/soc/codecs/tas2552.h                         |    2 +-
 sound/soc/codecs/tas5086.c                         |   11 +-
 sound/soc/codecs/tas571x.c                         |    2 +-
 sound/soc/codecs/tfa9879.c                         |    3 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    3 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    1 -
 sound/soc/codecs/tlv320aic3x.c                     |    3 +-
 sound/soc/codecs/tlv320dac33.c                     |    1 -
 sound/soc/codecs/tpa6130a2.c                       |   15 +-
 sound/soc/codecs/ts3a227e.c                        |   48 +-
 sound/soc/codecs/twl4030.c                         |    7 +-
 sound/soc/codecs/uda134x.c                         |  180 ++-
 sound/soc/codecs/uda134x.h                         |    2 -
 sound/soc/codecs/uda1380.c                         |   15 +-
 sound/soc/codecs/wm0010.c                          |    3 +-
 sound/soc/codecs/wm1250-ev1.c                      |    1 -
 sound/soc/codecs/wm2000.c                          |    1 -
 sound/soc/codecs/wm2200.c                          |    9 +-
 sound/soc/codecs/wm5100.c                          |   13 +-
 sound/soc/codecs/wm5102.c                          |   27 +-
 sound/soc/codecs/wm5110.c                          |  315 ++++-
 sound/soc/codecs/wm8350.c                          |    7 +-
 sound/soc/codecs/wm8400.c                          |    5 +-
 sound/soc/codecs/wm8510.c                          |    2 +-
 sound/soc/codecs/wm8523.c                          |    2 +-
 sound/soc/codecs/wm8580.c                          |    2 +-
 sound/soc/codecs/wm8711.c                          |    1 -
 sound/soc/codecs/wm8728.c                          |    1 -
 sound/soc/codecs/wm8731.c                          |   88 +-
 sound/soc/codecs/wm8737.c                          |    8 +-
 sound/soc/codecs/wm8741.c                          |   63 +-
 sound/soc/codecs/wm8750.c                          |    1 -
 sound/soc/codecs/wm8753.c                          |   14 +-
 sound/soc/codecs/wm8776.c                          |    5 +-
 sound/soc/codecs/wm8804-i2c.c                      |    1 -
 sound/soc/codecs/wm8804.c                          |    2 +-
 sound/soc/codecs/wm8900.c                          |    1 -
 sound/soc/codecs/wm8903.c                          |    1 -
 sound/soc/codecs/wm8904.c                          |    5 +-
 sound/soc/codecs/wm8940.c                          |    1 -
 sound/soc/codecs/wm8955.c                          |    1 -
 sound/soc/codecs/wm8960.c                          |  221 +++-
 sound/soc/codecs/wm8960.h                          |    1 +
 sound/soc/codecs/wm8961.c                          |    8 +-
 sound/soc/codecs/wm8962.c                          |   21 +-
 sound/soc/codecs/wm8971.c                          |    1 -
 sound/soc/codecs/wm8974.c                          |    1 -
 sound/soc/codecs/wm8978.c                          |    1 -
 sound/soc/codecs/wm8983.c                          |   81 +-
 sound/soc/codecs/wm8985.c                          |    1 -
 sound/soc/codecs/wm8988.c                          |    1 -
 sound/soc/codecs/wm8990.c                          |    6 +-
 sound/soc/codecs/wm8991.c                          |   53 +-
 sound/soc/codecs/wm8993.c                          |   12 +-
 sound/soc/codecs/wm8994.c                          |   18 +-
 sound/soc/codecs/wm8995.c                          |    1 -
 sound/soc/codecs/wm8996.c                          |   11 +-
 sound/soc/codecs/wm8997.c                          |   20 +-
 sound/soc/codecs/wm9081.c                          |   10 +-
 sound/soc/codecs/wm9090.c                          |   22 +-
 sound/soc/codecs/wm9705.c                          |   40 +-
 sound/soc/codecs/wm9712.c                          |   45 +-
 sound/soc/codecs/wm9713.c                          |   55 +-
 sound/soc/codecs/wm9713.h                          |    2 -
 sound/soc/codecs/wm_hubs.c                         |    7 +-
 sound/soc/davinci/davinci-i2s.c                    |   25 +-
 sound/soc/davinci/davinci-mcasp.c                  |   18 +-
 sound/soc/davinci/davinci-vcif.c                   |   14 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   16 +-
 sound/soc/fsl/fsl_asrc.c                           |   25 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_sai.c                            |    2 +-
 sound/soc/fsl/fsl_sai.h                            |   15 +-
 sound/soc/fsl/fsl_spdif.c                          |   25 +-
 sound/soc/fsl/fsl_ssi.c                            |   68 +-
 sound/soc/fsl/imx-pcm-dma.c                        |   25 +-
 sound/soc/fsl/imx-pcm.h                            |    9 +-
 sound/soc/fsl/imx-ssi.c                            |    2 +-
 sound/soc/generic/simple-card.c                    |    9 +
 sound/soc/intel/Kconfig                            |   29 +-
 sound/soc/intel/Makefile                           |    1 +
 sound/soc/intel/atom/sst-atom-controls.c           |    6 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    1 -
 sound/soc/intel/atom/sst-mfld-platform.h           |    1 +
 sound/soc/intel/atom/sst/sst_drv_interface.c       |    9 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    3 +-
 sound/soc/intel/boards/byt-max98090.c              |    1 +
 sound/soc/intel/boards/byt-rt5640.c                |    1 +
 sound/soc/intel/boards/bytcr_rt5640.c              |    1 +
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   19 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    2 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    1 +
 sound/soc/intel/common/sst-dsp-priv.h              |   23 +-
 sound/soc/intel/common/sst-dsp.c                   |   71 ++
 sound/soc/intel/common/sst-dsp.h                   |    6 +
 sound/soc/intel/skylake/Makefile                   |    9 +
 sound/soc/intel/skylake/skl-messages.c             |  884 ++++++++++++++
 sound/soc/intel/skylake/skl-nhlt.c                 |  140 +++
 sound/soc/intel/skylake/skl-nhlt.h                 |  106 ++
 sound/soc/intel/skylake/skl-pcm.c                  |  916 ++++++++++++++
 sound/soc/intel/skylake/skl-sst-cldma.c            |  327 +++++
 sound/soc/intel/skylake/skl-sst-cldma.h            |  251 ++++
 sound/soc/intel/skylake/skl-sst-dsp.c              |  342 ++++++
 sound/soc/intel/skylake/skl-sst-dsp.h              |  145 +++
 sound/soc/intel/skylake/skl-sst-ipc.c              |  771 ++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h              |  125 ++
 sound/soc/intel/skylake/skl-sst.c                  |  280 +++++
 sound/soc/intel/skylake/skl-topology.h             |  286 +++++
 sound/soc/intel/skylake/skl-tplg-interface.h       |   88 ++
 sound/soc/intel/skylake/skl.c                      |  536 +++++++++
 sound/soc/intel/skylake/skl.h                      |   84 ++
 sound/soc/kirkwood/kirkwood-dma.c                  |    4 +
 sound/soc/mediatek/mt8173-max98090.c               |    2 +-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |    2 +-
 sound/soc/mediatek/mtk-afe-common.h                |    8 -
 sound/soc/mediatek/mtk-afe-pcm.c                   |   89 +-
 sound/soc/nuc900/nuc900-pcm.c                      |    9 +-
 sound/soc/omap/mcbsp.c                             |   20 +-
 sound/soc/omap/omap-hdmi-audio.c                   |   10 +-
 sound/soc/omap/omap3pandora.c                      |    6 +-
 sound/soc/pxa/mmp-pcm.c                            |    9 +-
 sound/soc/pxa/pxa-ssp.c                            |   11 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |   11 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    9 +-
 sound/soc/qcom/Kconfig                             |    7 +-
 sound/soc/qcom/lpass-cpu.c                         |    2 +-
 sound/soc/qcom/lpass-ipq806x.c                     |    2 +-
 sound/soc/qcom/lpass.h                             |    2 +-
 sound/soc/rockchip/Kconfig                         |   19 +
 sound/soc/rockchip/Makefile                        |    6 +
 sound/soc/rockchip/rockchip_i2s.c                  |    8 +-
 sound/soc/rockchip/rockchip_max98090.c             |  236 ++++
 sound/soc/rockchip/rockchip_rt5645.c               |  225 ++++
 sound/soc/samsung/arndale_rt5631.c                 |   11 +-
 sound/soc/samsung/snow.c                           |    1 +
 sound/soc/sh/dma-sh7760.c                          |    9 +-
 sound/soc/sh/fsi.c                                 |    1 -
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/core.c                           |  195 ++-
 sound/soc/sh/rcar/ctu.c                            |  171 +++
 sound/soc/sh/rcar/dma.c                            |  128 +-
 sound/soc/sh/rcar/dvc.c                            |   73 +-
 sound/soc/sh/rcar/gen.c                            |   33 +-
 sound/soc/sh/rcar/mix.c                            |  200 +++
 sound/soc/sh/rcar/rsnd.h                           |  111 +-
 sound/soc/sh/rcar/rsrc-card.c                      |   22 +-
 sound/soc/sh/rcar/src.c                            |  117 +-
 sound/soc/sh/rcar/ssi.c                            |    4 +-
 sound/soc/sh/ssi.c                                 |   12 +-
 sound/soc/soc-ac97.c                               |   30 +-
 sound/soc/soc-core.c                               |   86 +-
 sound/soc/soc-dapm.c                               |  503 ++++----
 sound/soc/soc-pcm.c                                |   16 +-
 sound/soc/soc-topology.c                           |  145 +--
 sound/soc/spear/spdif_in.c                         |   20 +-
 sound/soc/spear/spear_pcm.c                        |    2 +-
 sound/soc/sti/Kconfig                              |   11 +
 sound/soc/sti/Makefile                             |    4 +
 sound/soc/sti/sti_uniperif.c                       |  254 ++++
 sound/soc/sti/uniperif.h                           | 1229 +++++++++++++++++++
 sound/soc/sti/uniperif_player.c                    | 1110 +++++++++++++++++
 sound/soc/sti/uniperif_reader.c                    |  362 ++++++
 sound/soc/tegra/tegra20_das.c                      |   23 +-
 sound/soc/tegra/tegra20_i2s.c                      |   23 +-
 sound/soc/tegra/tegra20_spdif.c                    |   47 +-
 sound/soc/tegra/tegra30_ahub.c                     |   80 +-
 sound/soc/tegra/tegra30_i2s.c                      |   23 +-
 sound/soc/txx9/txx9aclc.c                          |   10 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   29 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |    8 +-
 sound/soc/zte/zx296702-i2s.c                       |    6 +-
 301 files changed, 16003 insertions(+), 3744 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4349.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
 create mode 100644 include/sound/rt298.h
 create mode 100644 sound/soc/codecs/cs4349.c
 create mode 100644 sound/soc/codecs/cs4349.h
 create mode 100644 sound/soc/codecs/gtm601.c
 create mode 100644 sound/soc/codecs/ics43432.c
 create mode 100644 sound/soc/codecs/rt298.c
 create mode 100644 sound/soc/codecs/rt298.h
 create mode 100644 sound/soc/codecs/sti-sas.c
 create mode 100644 sound/soc/intel/skylake/Makefile
 create mode 100644 sound/soc/intel/skylake/skl-messages.c
 create mode 100644 sound/soc/intel/skylake/skl-nhlt.c
 create mode 100644 sound/soc/intel/skylake/skl-nhlt.h
 create mode 100644 sound/soc/intel/skylake/skl-pcm.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-cldma.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-cldma.h
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.h
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.c
 create mode 100644 sound/soc/intel/skylake/skl-sst-ipc.h
 create mode 100644 sound/soc/intel/skylake/skl-sst.c
 create mode 100644 sound/soc/intel/skylake/skl-topology.h
 create mode 100644 sound/soc/intel/skylake/skl-tplg-interface.h
 create mode 100644 sound/soc/intel/skylake/skl.c
 create mode 100644 sound/soc/intel/skylake/skl.h
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c
 create mode 100644 sound/soc/sh/rcar/ctu.c
 create mode 100644 sound/soc/sh/rcar/mix.c
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile
 create mode 100644 sound/soc/sti/sti_uniperif.c
 create mode 100644 sound/soc/sti/uniperif.h
 create mode 100644 sound/soc/sti/uniperif_player.c
 create mode 100644 sound/soc/sti/uniperif_reader.c

--XhrUtAZ9VCvva7+0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV4xznAAoJECTWi3JdVIfQ5JEH/2eeZvFcfYCDi10oi/vSH3id
epUGL49mQXGanS1OXpeYupWrplvVysnQm36sk1v87HqUgRSzKBe4cdRviSjzt10g
gOjlEWJ6MBONCUZCKpd/fM2P3K8UV6BpUHcV4PYwijHgsKWvydhuKv134eLtwv7P
BUyYTxjmRA6l6bSlqrJ/ADdWjPPfi0Wj1pk3PiAvI/ctrQiqCwiSjnYd+rbPd5tp
vMPMX6zE7WWBk44++5pWoXEjxjJ68gFGukqY/MPJ8PJ38Qgmpt+vKQFb1sPathwD
tADn0uY7ZeBZiDSzBKcgle5kJHnLecfFSwPk2/qJr2TrDG3N4DQIXez/00VJrAA=
=F9ii
-----END PGP SIGNATURE-----

--XhrUtAZ9VCvva7+0--

--===============0747355367062009652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0747355367062009652==--
