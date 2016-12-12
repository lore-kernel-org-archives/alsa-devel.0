From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.10
Date: Mon, 12 Dec 2016 18:25:55 +0000
Message-ID: <20161212182555.742hlkphnseihnk7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4002985814324196069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D4BF266499
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 19:26:04 +0100 (CET)
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


--===============4002985814324196069==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rsa3u7v44hh3ul22"
Content-Disposition: inline


--rsa3u7v44hh3ul22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.10

for you to fetch changes up to a5de5b74a50113564a1e0850e2da96c37c35e55d:

  Merge remote-tracking branches 'asoc/topic/wm9712', 'asoc/topic/wm9713' and 'asoc/topic/zte' into asoc-next (2016-12-12 15:53:32 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.10

There's been a few bits of framework work this time around and quite a
lot of cleanups and improvements to existing code:

 - Support for stereo DAPM controls from Chen-yu Tsai.
 - Some initial work on the of-graph sound card from Morimoto-san, the
   main bulk of this is currently in binding review.
 - Lots of Renesas cleanups from Morimoto-san and sunxi work from
   Chen-yu Tsai.
 - regmap conversions of the remaining AC'97 drivers from Lars-Peter
   Clausen.
 - A new version of the topology ABI from Mengdong Lin.
 - New drivers for Cirrus Logic CS42L42, Qualcomm MSM8916-WCD, and Realtek
   RT5665.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da7219: Improve pop/click performance for sensitive HPs

Alexey Khoroshilov (1):
      SoC: mxs-saif: check validity of ids in mxs_saif_probe()

Arnaud Pouliquen (5):
      ASoC: sti: fix errors management
      ASoC: sti: reset refactoring
      ASoC: sti: clean unused include
      ASoC: sti-sas: clean legacy in sti-sas
      ASoC: sti-sas: add missing return in messages strings

Arnd Bergmann (2):
      ASoC: lpass-platform: initialize dma channel number
      ASoC: topology: avoid uninitialized kcontrol_type

Axel Lin (6):
      regulator: rk808: Use rdev_get_id() to access id of regulator
      ASoC: cs35l34: Remove CS35L34_CHIP_ID from cs35l34_readable_register
      ASoC: msm8916-wcd-analog: Update correct register setting for MIC BIAS Internal1
      ASoC: rt5665: Fix missing mutex_unlock in rt5665_calibrate
      ASoC: rt5665: Use devm_gpio_request_one()
      ASoC: cs35l34: Simplify the logic to set CS35L34_MCLK_CTL setting

Bard Liao (10):
      ASoC: rt5663: rename rt5668 as rt5663 v2
      ASoC: rt5660: enable MCLK detection
      ASoC: rt5640: enable MCLK detection
      ASoC: rt5670: Enable MCLK detection
      ASoC: rt5670: increse LDO power
      ASoC: rt5640: add Mono ADC Capture Switch control
      ASoC: rt286: remove unnecessary selection in Kconfig
      ASoC: add rt5665 codec driver
      ASoC: rl6231: add 19.2M to 4.096M pll preset table
      ASoC: rt298: disable IRQ when jack is NULL

Charles Keepax (18):
      ASoC: arizona: Add gating for clock when used for direct MCLK
      ASoC: arizona: Add gating for source clocks of the FLLs
      ASoC: samsung: i2s: Fixup last IRQ unsafe spin lock call
      ASoC: cs42xx8: Mark chip ID as volatile and remove cache bypass
      ASoC: cs42l56: Make ID registers volatile and remove cache bypass
      ASoC: cs42l73: Remove cache bypass for read of ID registers
      ASoC: arizona: Move request of speaker IRQs into bus probe
      ASoC: arizona: Move request of DSP IRQ into bus probe
      ASoC: cs47l24: Fixup missing variable typo
      ASoC: arizona: Access driver data through platform from compressed ops
      ASoC: core: If a platform doesn't have an of_node use parent's node
      ASoC: wm2200: Correct types of mixer texts and values
      ASoC: arizona: Move notifier functions to header and make inline
      ASoC: arizona: Call arizona_init_notifiers for all CODECs
      ASoC: wm_adsp: Only write shutdown controls for active firmwares
      ASoC: wm_adsp: Check return value from wm_adsp_buffer_init
      ASoC: arizona: Remove redundant extern declarations
      ASoC: wm_adsp: Remove redundant extern declarations

Chen-Yu Tsai (19):
      ASoC: dapm: Support second register for DAPM control updates
      ASoC: dapm: Implement stereo mixer control support
      ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type
      ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual register control type
      ASoC: sun4i-codec: Move data structures to add create_card call to quirks
      ASoC: sun4i-codec: Revise comments for register definition macros
      ASoC: sun4i-codec: Expand quirks to handle register offsets and card creation
      ASoC: sun4i-codec: Increase DMA max burst to 8
      ASoC: sun4i-codec: Add support for A31 playback through headphone output
      ASoC: sun4i-codec: Add support for A31 Line In playback
      ASoC: sun4i-codec: Add support for A31 Line Out playback
      ASoC: sun4i-codec: Add support for A31 analog microphone inputs
      ASoC: sun4i-codec: Add support for A31 board level audio routing
      ASoC: sun4i-codec: Add support for A31 ADC capture path
      ASoC: sun4i-codec: Add support for optional reset control to quirks
      ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog path controls
      ASoC: sunxi: Add support for A23/A33/H3 codec's analog path controls
      ASoC: sun4i-codec: Add support for A23 codec
      ASoC: sun4i-codec: Add support for H3 codec

Colin Ian King (2):
      ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for array
      ASoC: mioa701_wm9713: add missing white space in dev_err message

Dan Carpenter (2):
      ASoC: Intel: Skylake: Fix a shift wrapping bug
      ASoC: sunxi: Uninitialized variable in probe()

Dharageswari R (2):
      ASoC: Intel: Skylake: Use DPIB to update position for Playback stream
      ASoC: Intel: Skylake: Use DPIB to update position for Playback stream

Florian Vaussard (1):
      ASoC: cs42l56: Fix misuse of regmap_update_bits

Geert Uytterhoeven (1):
      ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/

GuruprasadX Pawse (2):
      ASoC: Intel: Skylake: Don't use dma I2S config structure in kernel
      ASoC: Intel: Skylake: Removed the unused I2S blob structure

Jack Yu (1):
      ASoC: Add jd function for rt5663.

James Schulman (2):
      ASoC: Add support for CS42L42 codec
      ASoC: cs42l42: Add devicetree bindings for CS42L42

Jarkko Nikula (2):
      ASoC: rl6347a: Use dev_err for I2C communication error prints
      ASoC: rl6347a: Use dev_err for I2C communication error prints

Jayachandran B (3):
      ASoC: Intel: Skylake: Add D0iX callbacks
      ASoC: Intel: Skylake: remove pci device enabling calls on suspend
      ASoC: Intel: Skylake: Flush pending D0i3 request on suspend

John Hsu (5):
      ASoC: nau8825: Disable short Frame Sync detection logic
      ASoC: nau8825: AD/DA over sampling rate configuration
      ASoC: nau8825: FLL parameters finetune
      ASoC: nau8825: lock longer to avoid playback pop upon resume
      ASoC: nau8825: disable sinc filter for high THD of ADC

Julia Lawall (7):
      ASoC: intel: broadwell: constify snd_soc_ops structures
      ASoC: atmel_wm8904: constify snd_soc_ops structures
      ASoC: rockchip: constify snd_soc_ops structures
      ASoC: qcom: storm: constify snd_soc_ops structures
      ASoC: tegra: constify snd_soc_ops structures
      ASoC: constify snd_soc_ops structures
      ASoC: constify snd_soc_ops structures

Krzysztof Kozlowski (4):
      ASoC: samsung: Remove non-existing MACH dependencies
      ASoC: samsung: smdk_wm8580: Remove old platforms and drop mach-types usage
      ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc
      ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580

Kuninori Morimoto (47):
      ASoC: soc.h: use bit field for playback/capture_only
      ASoC: bunch up bit field for snd_soc_pcm_runtime
      ASoC: bunch up bit field for snd_soc_dai
      ASoC: remove component from snd_soc_pcm_runtime
      ASoC: rsnd: remove duplicate define of rsnd_dvc_of_node()
      ASoC: rsnd: amend .probe/.remove call for DPCM
      ASoC: rsnd: add rsnd_mod_next() for for_each_rsnd_mod_xxx()
      ASoC: rsnd: use for_each_rsnd_mod_xxx() on rsnd_dai_call()
      ASoC: rsnd: use for_each_rsnd_mod_xxx() on rsnd_rdai_continuance_probe()
      ASoC: rsnd: add rsnd_parse_of_node() and integrate rsnd_xxx_of_node
      ASoC: rsnd: remove non DT support for DMA
      ASoC: rsnd: don't use devm_request_irq() for SSI
      ASoC: rsnd: remove rsnd_dma_detach()
      ASoC: rsnd: don't call unneeded of_node_put() on dma.c
      ASoC: rsnd: add nolock_start/stop callback
      ASoC: rsnd: depends on OF
      ASoC: rsnd: enable COMPILE_TEST
      ASoC: rsnd: remove "Gen2 only" comment
      ASoC: rsnd: rsnd_reg cleanup for SSIU
      ASoC: rsnd: fixup SCU_SYS_STATUSx access
      ASoC: rsnd: clear SSI_SYS_STATUSx every time
      ASoC: rsnd: enable SRC sync even FIN = FOUT
      ASoC: max98504: Add missing MAX98504 on SND_SOC_ALL_CODECS
      ASoC: rsnd: use BRGCKR instead of SSICKR
      ASoC: simple-scu-card: code sync: follow to simple family style
      ASoC: simple-scu-card: code sync: rename asoc_simple_card_priv
      ASoC: simple-scu-card: code sync: tidyup props/link naming
      ASoC: simple-card-utils: remove unnecessary cpu/codec pointer check
      ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_routing
      ASoC: soc-core: snd_soc_get_dai_name() become non static
      ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_prefix
      ASoC: soc-core: adjust for graph on snd_soc_of_parse_card_name
      ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_simple_widgets
      ASoC: uda1380: Remove #if IS_ENABLED(CONFIG_I2C)
      ASoC: wm9081: Remove #if IS_ENABLED(CONFIG_I2C)
      ASoC: wm8523: Remove #if IS_ENABLED(CONFIG_I2C)
      ASoC: wm8580: Remove #if IS_ENABLED(CONFIG_I2C)
      ASoC: rsnd: Request/Release DMA channel each time
      ASoC: rsnd: use dma_sync_single_for_xxx() for IOMMU
      ASoC: core: replace codec_dev_list to component_dev_list on Card
      ASoC: core: replace aux_comp_list to component_dev_list
      ASoC: add Component level suspend/resume
      ASoC: rsnd: rsnd_get_dalign() needs to care SSIU, not SSI
      ASoC: simple_card_utils: tidyup file comment/define
      ASoC: rsnd: tidyup ssi->usrcnt counter check in hw_params
      ASoC: rsnd: enable/disable ADG when suspend/resume timing
      ASoC: rsnd: setup BRGCKR/BRRA/BRRB when starting

Lars-Peter Clausen (27):
      ASoC: wm9712: Convert to regmap
      ASoC: wm9712: Remove ac97_read/ac97_write wrappers
      ASoC: wm9705: Convert to regmap
      ASoC: wm9705: Remove ac97_read/ac97_write wrappers
      ASoC: wm9712: Remove unused DAI ID defines
      ASoC: wm9713: Remove unused DAI ID defines
      ASoC: wm8753: Remove unused DAI ID defines
      ASoC: wm9705: Remove unused DAI ID defines
      ASoC: pxa2xx-i2s: Remove unused DAI ID defines
      ASoC: pxa-ssp: Remove unused DAI ID defines
      ASoC: es8328: Remove some unused defines
      ASoC: ak4641: Remove unused DAI ID defines
      ASoC: ak4641: Remove unused AK4641_CACHEREGNUM define
      ASoC: ak4641: Move register defines to main source
      ASoC: stac9766: Remove unused DAI ID defines
      ASoC: stac9766: Remove register paging support
      ASoC: stac9766: Move register defines to main source file
      ASoC: stac9766: Convert to regmap
      ASoC: stac9766: Remove ac97_read/ac97_write wrappers
      ASoC: samsung: Remove unselectable smdk_wm8580pcm
      ASoC: pxa: Make static string arrays 'const 'char * const []'
      ASoC: rt5616: Don't use rtd->codec
      ASoC: intel: mfld: Make static string arrays 'const 'char * const []'
      ASoC: Make return type of dpcm_state_string() const char *
      ASoC: uda1380: Remove unused DAI ID defines
      ASoC: uda1380: Request GPIOs at bus probe time
      ASoC: ab8500: Remove explicit initialization of driver callbacks to NULL

Mark Brown (31):
      Merge branch 'topic/dmaengine' of git://git.kernel.org/.../broonie/sound into asoc-samsung
      Merge remote-tracking branch 'asoc/topic/rl6347a' into asoc-rl6347a
      Merge branch 'fix/samsung' of git://git.kernel.org/.../broonie/sound into asoc-samsung
      Merge branch 'fix/qcom' of git://git.kernel.org/.../broonie/sound into asoc-qcom
      Merge branch 'fix/sunxi' of git://git.kernel.org/.../broonie/sound into asoc-sunxi
      Merge branch 'topic/dapm' of git://git.kernel.org/.../broonie/sound into asoc-sunxi
      Merge branch 'topic/dapm-pin' of git://git.kernel.org/.../broonie/sound into asoc-arizona
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/da7219-pops' and 'asoc/fix/qcom' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm-pin' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dmaengine' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ab8500', 'asoc/topic/arizona', 'asoc/topic/atmel', 'asoc/topic/bcm' and 'asoc/topic/bitfield' into asoc-next
      Merge remote-tracking branches 'asoc/topic/compress', 'asoc/topic/const' and 'asoc/topic/cs35l34' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l42', 'asoc/topic/cs42l56', 'asoc/topic/cs42l73' and 'asoc/topic/cs42xx8' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci' and 'asoc/topic/doc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dpcm', 'asoc/topic/es8328', 'asoc/topic/extcon' and 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branches 'asoc/topic/inntel', 'asoc/topic/input', 'asoc/topic/max98504' and 'asoc/topic/nau8825' into asoc-next
      Merge remote-tracking branches 'asoc/topic/of-graph', 'asoc/topic/pxa', 'asoc/topic/qcom' and 'asoc/topic/rk808' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231', 'asoc/topic/rl6347a', 'asoc/topic/rockchip', 'asoc/topic/rt286' and 'asoc/topic/rt298' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5514', 'asoc/topic/rt5616', 'asoc/topic/rt5640', 'asoc/topic/rt5660' and 'asoc/topic/rt5663' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5665', 'asoc/topic/rt5670', 'asoc/topic/rt5677', 'asoc/topic/samsung' and 'asoc/topic/simple' into asoc-next
      Merge remote-tracking branches 'asoc/topic/stac9766', 'asoc/topic/sti', 'asoc/topic/sti-codec', 'asoc/topic/sunxi' and 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320aic31xx', 'asoc/topic/topology', 'asoc/topic/uda1380', 'asoc/topic/wm2200' and 'asoc/topic/wm8523' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8580', 'asoc/topic/wm8753', 'asoc/topic/wm8978', 'asoc/topic/wm9081' and 'asoc/topic/wm9705' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm9712', 'asoc/topic/wm9713' and 'asoc/topic/zte' into asoc-next

Matt Flax (1):
      ASoC: wm8580: Add the wm8581 codec to the driver

Maxime Ripard (3):
      ASoC: sun4i-i2s: Implement capture support
      ASoC: sunxi: i2s: Implement set_sysclk
      ASoC: wm8978: Adjust clock indices so that simple card works

Mengdong Lin (17):
      ASoC: topology: ABI - Define DAI physical PCM data formats
      ASoC: topology: Make manifest backward compatible from ABI v4
      ASoC: topology: Make PCM backward compatible from ABI v4
      ASoC: topology: Only use valid names of PCM for the kernel DAI & DAI link
      ASoC: topology: Support topology file of ABI v4
      ASoC: topology: ABI - Add flags and private data to PCM
      ASoC: topology: ABI - Update physical DAI link configuration for version 5
      ASoC: Define API to find a dai link
      ASoC: topology: Add support to configure existing physical DAI links
      ASoC: topology: Rename the function to create a FE link
      ASoC: topology: ABI - Rename struct and type for physical DAIs
      ASoC: topology: Rename functions & variables for physical DAIs
      ASoC: topology: ABI - Add voice wake up flag for DAI links
      ASoC: topology: Check name strings of physical DAI links
      ASoC: topology: ABI - Rename be_dai_elems to dai_elems in manifest
      ASoC: topology: Allow a widget to have multiple enum controls
      ASoC: topology: Only free TLV for volume mixers of a widget

Oder Chiou (1):
      ASoC: rt5514: Add the DMIC initial delay to wait it ready.

Pardha Saradhi K (2):
      ASoC: Intel: Skylake: Add D0iX IPCs
      ASoC: Intel: Skylake: Add support for programming D0i3C

Paul Handrigan (2):
      ASoC: cs35l34: Add device tree bindings file for cs35l34
      ASoC: cs35l34: Initial commit of the cs35l34 CODEC driver.

Peter Rosin (3):
      ASoC: atmel_ssc_dai: if not provided, default to sensible dividers
      ASoC: tse850: document axentia,tse850-pcm5142 bindings
      ASoC: atmel: tse850: add ASoC driver for the Axentia TSE-850

Peter Ujfalusi (2):
      ASoC: tlv320aic31xx: Add missing of_device_id for dac3100
      ASoC: tlv320aic31xx: Add support for tlv320dac3101

Pierre-Louis Bossart (3):
      ASoC: Intel: common: add ACPI package extraction utility
      ASoC: Intel: detect audio routing with CHAN package
      ASoC: Intel: bytct_rt5640: change default capture settings

Randy Dunlap (1):
      ASoC: fsl: fix fsl_spdif.c build errors

Richard Fitzgerald (12):
      ASoC: wm_adsp: Remove duplicate set of kcontrol->iface
      ASoC: wm_adsp: Signal firmware shutdown through event control
      ASoC: wm_adsp: factor out getting region name from type
      ASoC: wm_adsp: Support acknowledged controls
      ASoC: wm_adsp: factor out getting base register for a control
      ASoC: wm_adsp: Firmware controls should be added as codec controls
      ASoC: wm_adsp: Remove unused wm_coeff_ctl.kcontrol
      ASoC: core: Add component pin control functions
      ASoC: arizona: Use component pin control functions
      extcon: arizona: Use SoC component pin control functions
      Input: arizona-haptics - Use SoC component pin control functions
      ASoC: wm_adsp: wm_adsp_buf_alloc should use kfree in error path

Sathyanarayana Nujella (2):
      ASoC: Intel: report JACK_LINEOUT event
      ASoC: Intel: update bxt_da7219_max98357a to support quad ch dmic capture

Scott Branden (1):
      ASoC: bcm: add depends on HAS_DMA

Sebastien Guiriec (4):
      ASoC: Intel: atom: Add debug information related to FW version
      ASoC: Intel: atom: Add sysfs entry in order to store FW version
      ASoC: Intel: atom: save FW version
      ASoC: Intel: Add ASoC Intel SST Atom sysfs description

Shawn Guo (2):
      ASoC: zte: spdif and i2s drivers are not zx296702 specific
      ASoC: zte: spdif: correct ZX_SPDIF_CLK_RAT define

Srinivas Kandagatla (7):
      ASoC: codecs: Add msm8916-wcd analog codec
      ASoC: codecs: Add msm8916-wcd digital codec
      ASoC: apq8016-sbc: dt bindings: remove incorrect property
      ASoC: qcom: apq8016-sbc: Add support to multi codec.
      ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch
      ASoC: codecs: msm8916-wcd-analog: clean parse_dt()
      ASoC: codecs: msm8916-wcd-digital: rename parse_dt to get_clks

Stuart Henderson (1):
      ASoC: wm_adsp: Add support for SYSTEM firmware controls

Sylwester Nawrocki (11):
      ASoC: s3c24xx_uda134x: Move global variables to driver's data structure
      ASoC: samsung: Remove unneeded initialization of chan_name
      ASoC: Drop SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
      ASoC: samsung: s3c24xx-i2s: Don't use platform_data for DMA parameters
      ASoC: samsung: s3c24xx-i2s: Debug/error trace cleanup
      ASoC: samsung: pcm: Conversion to use devm_ioremap_resource()
      ASoC: samsung: s2c24xx-i2s: remove redundant error message
      ASoC: samsung: Drop AC97 drivers
      ASoC: samsung: s3c24xx-i2s.c merge fixup
      ASoC: samsung: Add DT bindings documentation for TM2 sound subsystem
      ASoC: samsung: Add machine driver for Exynos5433 based TM2 board

Takashi Iwai (10):
      ASoC: rt5514: Remove superfluous linux/kthread.h inclusion
      ASoC: rt5677: Remove superfluous linux/kthread.h inclusion
      ASoC: cht_bsw_rt5645: Fix leftover kmalloc
      ASoC: Intel: atom: Make some messages to debug level
      ASoC: Intel: Add missing 10EC5672 ACPI ID matching for Cherry Trail
      ASoC: rt5670: Enable Braswell platform workaround for Dell Wyse 3040
      ASoC: rt5670: Add missing 10EC5072 ACPI ID
      ASoC: intel: Replace kthread with work
      ASoC: intel: Fix crash at suspend/resume without card registration
      ASoC: cht_bsw_rt5672: Use HID translation unit

Valentin Rothberg (1):
      ASoC: samsung: Makefile cleanup

Vinod Koul (6):
      ASoC: Intel: Add check_dsp_lp_on callback on IPC
      ASoC: Intel: Add sst_ipc_tx_message_nopm
      ASoC: Intel: Skylake: Add support for LPMode
      ASoC: Intel: Skylake: Add support for specifying D0i3 configuration
      ASoC: Intel: Skylake: Add D0i3 mode ref counting
      ASoC: compress: Add support for compress dai ops

Wei Yongjun (2):
      ASoC: rk3399_gru_sound: Fix non static symbol warning
      ASoC: wm8580: Fix non static symbol warnings

anish kumar (1):
      ASoC: Codec to codec dai link description

kbuild test robot (2):
      ASoC: sun4i-codec: fix semicolon.cocci warnings
      ASoC: fix platform_no_drv_owner.cocci warnings

 Documentation/ABI/testing/sysfs-platform-sst-atom  |   17 +
 .../bindings/sound/axentia,tse850-pcm5142.txt      |   88 +
 .../devicetree/bindings/sound/cs35l34.txt          |   64 +
 .../devicetree/bindings/sound/cs42l42.txt          |  110 +
 .../devicetree/bindings/sound/davinci-mcbsp.txt    |    2 +-
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |    5 +-
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |   85 +
 .../bindings/sound/qcom,msm8916-wcd-digital.txt    |   20 +
 Documentation/devicetree/bindings/sound/rt5514.txt |    3 +
 Documentation/devicetree/bindings/sound/rt5663.txt |    6 +-
 Documentation/devicetree/bindings/sound/rt5665.txt |   68 +
 .../bindings/sound/samsung,tm2-audio.txt           |   38 +
 .../devicetree/bindings/sound/sun4i-codec.txt      |   65 +-
 .../bindings/sound/sun8i-codec-analog.txt          |   16 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |    1 +
 Documentation/devicetree/bindings/sound/wm8580.txt |    4 +-
 Documentation/sound/alsa/soc/codec_to_codec.txt    |  103 +
 MAINTAINERS                                        |    7 +
 drivers/extcon/extcon-arizona.c                    |    8 +-
 drivers/input/misc/arizona-haptics.c               |   13 +-
 drivers/regulator/rk808-regulator.c                |    9 +-
 include/dt-bindings/sound/cs42l42.h                |   73 +
 include/sound/cs35l34.h                            |   35 +
 include/sound/dmaengine_pcm.h                      |    6 -
 include/sound/rt5514.h                             |   20 +
 include/sound/rt5665.h                             |   47 +
 include/sound/simple_card_utils.h                  |    8 +-
 include/sound/soc-dai.h                            |   43 +-
 include/sound/soc-dapm.h                           |   14 +
 include/sound/soc-topology.h                       |    2 +-
 include/sound/soc.h                                |   87 +-
 include/uapi/sound/asoc.h                          |   90 +-
 include/uapi/sound/snd_sst_tokens.h                |    8 +-
 sound/soc/atmel/Kconfig                            |   10 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel_ssc_dai.c                    |   83 +-
 sound/soc/atmel/atmel_ssc_dai.h                    |    1 +
 sound/soc/atmel/atmel_wm8904.c                     |    2 +-
 sound/soc/atmel/tse850-pcm5142.c                   |  472 ++
 sound/soc/bcm/Kconfig                              |    1 +
 sound/soc/codecs/Kconfig                           |   31 +-
 sound/soc/codecs/Makefile                          |   11 +-
 sound/soc/codecs/ab8500-codec.c                    |    2 -
 sound/soc/codecs/adau17x1.c                        |    2 +-
 sound/soc/codecs/ak4641.c                          |   22 +-
 sound/soc/codecs/ak4641.h                          |   47 -
 sound/soc/codecs/arizona.c                         |  153 +-
 sound/soc/codecs/arizona.h                         |  109 +-
 sound/soc/codecs/cs35l34.c                         | 1251 +++++
 sound/soc/codecs/cs35l34.h                         |  269 ++
 sound/soc/codecs/cs42l42.c                         | 1986 ++++++++
 sound/soc/codecs/cs42l42.h                         |  776 ++++
 sound/soc/codecs/cs42l56.c                         |   18 +-
 sound/soc/codecs/cs42l73.c                         |    4 -
 sound/soc/codecs/cs42xx8.c                         |   10 -
 sound/soc/codecs/cs47l24.c                         |   55 +-
 sound/soc/codecs/da7219-aad.c                      |   18 +-
 sound/soc/codecs/da7219.c                          |  139 +-
 sound/soc/codecs/da7219.h                          |    5 +
 sound/soc/codecs/es8328.h                          |   37 -
 sound/soc/codecs/msm8916-wcd-analog.c              |  890 ++++
 sound/soc/codecs/msm8916-wcd-digital.c             |  923 ++++
 sound/soc/codecs/nau8825.c                         |  142 +-
 sound/soc/codecs/nau8825.h                         |   16 +
 sound/soc/codecs/rl6231.c                          |    1 +
 sound/soc/codecs/rl6347a.c                         |    2 +-
 sound/soc/codecs/rt298.c                           |   24 +-
 sound/soc/codecs/rt5514-spi.c                      |    1 -
 sound/soc/codecs/rt5514.c                          |   17 +
 sound/soc/codecs/rt5514.h                          |    2 +
 sound/soc/codecs/rt5616.c                          |    3 +-
 sound/soc/codecs/rt5640.c                          |    5 +
 sound/soc/codecs/rt5640.h                          |    6 +
 sound/soc/codecs/rt5660.c                          |    4 +
 sound/soc/codecs/rt5660.h                          |    3 +
 sound/soc/codecs/rt5663.c                          | 1137 ++---
 sound/soc/codecs/rt5663.h                          | 1162 ++---
 sound/soc/codecs/rt5665.c                          | 4874 ++++++++++++++++++++
 sound/soc/codecs/rt5665.h                          | 1990 ++++++++
 sound/soc/codecs/rt5670.c                          |   16 +-
 sound/soc/codecs/rt5670.h                          |    1 +
 sound/soc/codecs/rt5677-spi.c                      |    1 -
 sound/soc/codecs/stac9766.c                        |  162 +-
 sound/soc/codecs/stac9766.h                        |   17 -
 sound/soc/codecs/sti-sas.c                         |  179 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    3 +
 sound/soc/codecs/tlv320aic31xx.h                   |    1 +
 sound/soc/codecs/tlv320aic3x.c                     |    2 +-
 sound/soc/codecs/uda1380.c                         |   77 +-
 sound/soc/codecs/uda1380.h                         |    4 -
 sound/soc/codecs/wm2200.c                          |    4 +-
 sound/soc/codecs/wm5102.c                          |   59 +-
 sound/soc/codecs/wm5110.c                          |   61 +-
 sound/soc/codecs/wm8523.c                          |   24 +-
 sound/soc/codecs/wm8580.c                          |  123 +-
 sound/soc/codecs/wm8753.h                          |    3 -
 sound/soc/codecs/wm8978.h                          |    2 +-
 sound/soc/codecs/wm8997.c                          |   39 +-
 sound/soc/codecs/wm8998.c                          |   38 +-
 sound/soc/codecs/wm9081.c                          |    2 -
 sound/soc/codecs/wm9705.c                          |  138 +-
 sound/soc/codecs/wm9705.h                          |   11 -
 sound/soc/codecs/wm9712.c                          |  177 +-
 sound/soc/codecs/wm9712.h                          |   11 -
 sound/soc/codecs/wm9713.c                          |    2 +-
 sound/soc/codecs/wm9713.h                          |    4 -
 sound/soc/codecs/wm_adsp.c                         |  354 +-
 sound/soc/codecs/wm_adsp.h                         |   27 +-
 sound/soc/codecs/wmfw.h                            |    4 +
 sound/soc/fsl/Kconfig                              |    1 +
 sound/soc/fsl/efika-audio-fabric.c                 |    1 -
 sound/soc/fsl/fsl-asoc-card.c                      |    2 +-
 sound/soc/fsl/imx-wm8962.c                         |    2 +-
 sound/soc/generic/simple-card-utils.c              |    5 +-
 sound/soc/generic/simple-card.c                    |    2 +-
 sound/soc/generic/simple-scu-card.c                |  115 +-
 sound/soc/intel/atom/sst-atom-controls.c           |    2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    6 +
 sound/soc/intel/atom/sst/sst.c                     |   39 +
 sound/soc/intel/atom/sst/sst.h                     |    1 +
 sound/soc/intel/atom/sst/sst_acpi.c                |    2 +
 sound/soc/intel/atom/sst/sst_ipc.c                 |   11 +
 sound/soc/intel/atom/sst/sst_stream.c              |    4 +-
 sound/soc/intel/baytrail/sst-baytrail-ipc.c        |    3 +-
 sound/soc/intel/boards/bdw-rt5677.c                |    2 +-
 sound/soc/intel/boards/broadwell.c                 |   18 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   26 +-
 sound/soc/intel/boards/bxt_rt298.c                 |    4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   68 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    4 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |    4 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   10 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   46 +-
 sound/soc/intel/boards/haswell.c                   |    2 +-
 sound/soc/intel/boards/mfld_machine.c              |    4 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |    6 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |    6 +-
 sound/soc/intel/boards/skl_rt286.c                 |    4 +-
 sound/soc/intel/common/sst-acpi.h                  |   17 +-
 sound/soc/intel/common/sst-ipc.c                   |   85 +-
 sound/soc/intel/common/sst-ipc.h                   |    8 +-
 sound/soc/intel/common/sst-match-acpi.c            |   57 +
 sound/soc/intel/haswell/sst-haswell-ipc.c          |    3 +-
 sound/soc/intel/skylake/bxt-sst.c                  |  145 +
 sound/soc/intel/skylake/skl-messages.c             |   39 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   28 +-
 sound/soc/intel/skylake/skl-sst-cldma.c            |    1 -
 sound/soc/intel/skylake/skl-sst-dsp.h              |   12 +
 sound/soc/intel/skylake/skl-sst-ipc.c              |   71 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |   37 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |   47 +
 sound/soc/intel/skylake/skl-topology.h             |   28 +-
 sound/soc/intel/skylake/skl.c                      |   59 +-
 sound/soc/intel/skylake/skl.h                      |    6 +
 sound/soc/kirkwood/armada-370-db.c                 |    2 +-
 sound/soc/mxs/mxs-saif.c                           |   13 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    2 +-
 sound/soc/pxa/corgi.c                              |    6 +-
 sound/soc/pxa/e740_wm9705.c                        |    1 -
 sound/soc/pxa/e750_wm9705.c                        |    1 -
 sound/soc/pxa/e800_wm9712.c                        |    1 -
 sound/soc/pxa/em-x270.c                            |    1 -
 sound/soc/pxa/hx4700.c                             |    2 -
 sound/soc/pxa/magician.c                           |    2 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    2 +-
 sound/soc/pxa/palm27x.c                            |    1 -
 sound/soc/pxa/poodle.c                             |    4 +-
 sound/soc/pxa/pxa-ssp.h                            |    6 -
 sound/soc/pxa/pxa2xx-i2s.h                         |    3 -
 sound/soc/pxa/spitz.c                              |    6 +-
 sound/soc/pxa/tosa.c                               |    7 +-
 sound/soc/qcom/apq8016_sbc.c                       |   11 +-
 sound/soc/qcom/lpass-platform.c                    |   49 +-
 sound/soc/qcom/storm.c                             |    2 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |    8 +-
 sound/soc/rockchip/rockchip_max98090.c             |    2 +-
 sound/soc/rockchip/rockchip_rt5645.c               |    2 +-
 sound/soc/samsung/Kconfig                          |   58 +-
 sound/soc/samsung/Makefile                         |    9 +-
 sound/soc/samsung/ac97.c                           |  437 --
 sound/soc/samsung/dmaengine.c                      |    8 +-
 sound/soc/samsung/i2s.c                            |    8 +-
 sound/soc/samsung/ln2440sbc_alc650.c               |   72 -
 sound/soc/samsung/pcm.c                            |   60 +-
 sound/soc/samsung/regs-ac97.h                      |   66 -
 sound/soc/samsung/s3c2412-i2s.c                    |    2 -
 sound/soc/samsung/s3c24xx-i2s.c                    |   51 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |   79 +-
 sound/soc/samsung/smdk2443_wm9710.c                |   68 -
 sound/soc/samsung/smdk_wm8580.c                    |   30 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |  175 -
 sound/soc/samsung/smdk_wm9713.c                    |  108 -
 sound/soc/samsung/tm2_wm5110.c                     |  552 +++
 sound/soc/sh/Kconfig                               |    3 +-
 sound/soc/sh/rcar/adg.c                            |   61 +-
 sound/soc/sh/rcar/core.c                           |  175 +-
 sound/soc/sh/rcar/dma.c                            |  295 +-
 sound/soc/sh/rcar/dvc.c                            |    2 -
 sound/soc/sh/rcar/gen.c                            |   12 +-
 sound/soc/sh/rcar/rsnd.h                           |  156 +-
 sound/soc/sh/rcar/src.c                            |   13 +-
 sound/soc/sh/rcar/ssi.c                            |   28 +-
 sound/soc/sh/rcar/ssiu.c                           |   20 +
 sound/soc/soc-compress.c                           |   98 +-
 sound/soc/soc-core.c                               |  181 +-
 sound/soc/soc-dapm.c                               |  154 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   13 +-
 sound/soc/soc-pcm.c                                |    2 +-
 sound/soc/soc-topology.c                           |  751 ++-
 sound/soc/soc-utils.c                              |  199 +
 sound/soc/sti/sti_uniperif.c                       |   43 +-
 sound/soc/sti/uniperif.h                           |    2 +
 sound/soc/sti/uniperif_player.c                    |   91 +-
 sound/soc/sti/uniperif_reader.c                    |   41 +-
 sound/soc/sunxi/Kconfig                            |    8 +
 sound/soc/sunxi/Makefile                           |    1 +
 sound/soc/sunxi/sun4i-codec.c                      |  867 +++-
 sound/soc/sunxi/sun4i-i2s.c                        |  105 +-
 sound/soc/sunxi/sun8i-codec-analog.c               |  665 +++
 sound/soc/tegra/tegra_alc5632.c                    |    2 +-
 sound/soc/tegra/tegra_max98090.c                   |    2 +-
 sound/soc/tegra/tegra_rt5640.c                     |    2 +-
 sound/soc/tegra/tegra_rt5677.c                     |    2 +-
 sound/soc/tegra/tegra_sgtl5000.c                   |    2 +-
 sound/soc/tegra/tegra_wm8753.c                     |    2 +-
 sound/soc/tegra/tegra_wm8903.c                     |    2 +-
 sound/soc/tegra/trimslice.c                        |    2 +-
 sound/soc/zte/Kconfig                              |   16 +-
 sound/soc/zte/Makefile                             |    4 +-
 sound/soc/zte/{zx296702-i2s.c => zx-i2s.c}         |    0
 sound/soc/zte/{zx296702-spdif.c => zx-spdif.c}     |    2 +-
 232 files changed, 22048 insertions(+), 4367 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-sst-atom
 create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l34.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l42.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
 create mode 100755 Documentation/devicetree/bindings/sound/rt5665.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
 create mode 100644 Documentation/sound/alsa/soc/codec_to_codec.txt
 create mode 100644 include/dt-bindings/sound/cs42l42.h
 create mode 100644 include/sound/cs35l34.h
 create mode 100644 include/sound/rt5514.h
 create mode 100755 include/sound/rt5665.h
 create mode 100644 sound/soc/atmel/tse850-pcm5142.c
 delete mode 100644 sound/soc/codecs/ak4641.h
 create mode 100644 sound/soc/codecs/cs35l34.c
 create mode 100644 sound/soc/codecs/cs35l34.h
 create mode 100644 sound/soc/codecs/cs42l42.c
 create mode 100644 sound/soc/codecs/cs42l42.h
 create mode 100644 sound/soc/codecs/msm8916-wcd-analog.c
 create mode 100644 sound/soc/codecs/msm8916-wcd-digital.c
 create mode 100644 sound/soc/codecs/rt5665.c
 create mode 100644 sound/soc/codecs/rt5665.h
 delete mode 100644 sound/soc/codecs/stac9766.h
 delete mode 100644 sound/soc/codecs/wm9705.h
 delete mode 100644 sound/soc/codecs/wm9712.h
 delete mode 100644 sound/soc/samsung/ac97.c
 delete mode 100644 sound/soc/samsung/ln2440sbc_alc650.c
 delete mode 100644 sound/soc/samsung/regs-ac97.h
 delete mode 100644 sound/soc/samsung/smdk2443_wm9710.c
 delete mode 100644 sound/soc/samsung/smdk_wm8580pcm.c
 delete mode 100644 sound/soc/samsung/smdk_wm9713.c
 create mode 100644 sound/soc/samsung/tm2_wm5110.c
 create mode 100644 sound/soc/sunxi/sun8i-codec-analog.c
 rename sound/soc/zte/{zx296702-i2s.c => zx-i2s.c} (100%)
 rename sound/soc/zte/{zx296702-spdif.c => zx-spdif.c} (99%)

--rsa3u7v44hh3ul22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhO67IACgkQJNaLcl1U
h9ClzQf+Igxg8pz309Gu4hydEG2KiozzRJygbkIkVbTL0rO4m/AmdaWCwwMHx5i3
vikS32hxrB0OrZ0IJ3HtzOQ1zqdqGJgYZqAztc4o7rRuQ3eJbZdCmnPpeGn63ngK
iS9SJyIQjcM7FX5wqv5E3VedlkRYAcvkAOMnxll0p4BybCCpnNoh+vKex3aAshJi
7JJvZQgn0NPBoKDhifo321NY+Zlzirruwh5pRUDycgl1rwJIXLsVn6fa6Dl+04ol
T6qNJgKMwr7HSpwWGT+zuA12BCb+/6fRfI2boJ+AnPqgfepIviakqQBkRcbBR/gR
ItZ0iI8H8LwBvf9N+nVpy72v1cp7ag==
=LY6G
-----END PGP SIGNATURE-----

--rsa3u7v44hh3ul22--

--===============4002985814324196069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4002985814324196069==--
