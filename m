From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.14
Date: Mon, 4 Sep 2017 13:38:29 +0100
Message-ID: <20170904123829.oxahfa6dhx6kcj7s@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9027978806689254648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8EA126691F
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 14:38:31 +0200 (CEST)
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


--===============9027978806689254648==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sqwxdu2jcs5axjok"
Content-Disposition: inline


--sqwxdu2jcs5axjok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cc4a41fe5541a73019a864883297bd5043aa6d98:

  Linux 4.13-rc7 (2017-08-27 17:20:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.14

for you to fetch changes up to f5fd4a67bef5f2c5c2c9eb0cb2900e12d192ae23:

  Merge remote-tracking branches 'asoc/topic/wm8524', 'asoc/topic/wm8804' and 'asoc/topic/zte' into asoc-next (2017-09-01 12:13:19 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.14

This is quite a large release by volume of patches and diff, a lot of
that is mechanical cleanup patches but it's great to also see a range of
vendors actively working on adding new features and fixing issues in
their drivers.  Intel and Realtek have been especially active here.

 - Continued work towards moving everything to the component model from
   Morimoto-san.
 - Use of devres for jack detection GPIOs, eliminating some potential
   resource leaks.
 - Jack detection support for Qualcomm MSM8916.
 - Support for Allwinner H3, Cirrus Logic CS43130, Intel Kabylake
   systems with RT5663, Realtek RT274, TI TLV320AIC32x6 and Wolfson
   WM8523.

----------------------------------------------------------------
Andy Shevchenko (3):
      ASoC: rt5677: Hide platform data in the module sources
      ASoC: rt5677: Refactor code to avoid comparison unsigned >= 0
      ASoC: rt5677: Remove never used variables

Anton Vasilyev (1):
      ASoC: samsung: i2s: Null pointer dereference on samsung_i2s_remove

Arnaud Pouliquen (2):
      ASoC: Add bindings for DMIC codec driver
      ASoC: codec: add DT support in dmic codec

Arnd Bergmann (1):
      ASoC: codecs: fix wm8524 build error

Arvind Yadav (27):
      ASoC: rt5514: constify acpi_device_id.
      ASoC: rt5663: constify acpi_device_id.
      ASoC: rt5659: constify acpi_device_id.
      ASoC: rt5665: constify acpi_device_id.
      ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
      ASoC: samsung: s3c24xx: Handle return value of clk_prepare_enable.
      ASoC: samsung: pcm: Handle return value of clk_prepare_enable.
      ASoC: samsung: i2s: Handle return value of clk_prepare_enable.
      ASoC: samsung: spdif: Handle return value of clk_prepare_enable.
      ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare.
      ASoC: jz4740: Handle return value of clk_prepare_enable.
      ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.
      ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.
      ASoC: Intel: constify pci_device_id.
      ASoC: samsung: constify snd_pcm_ops structures
      ASoC: au1x: constify snd_pcm_ops structures
      ASoC: blackfin: constify snd_pcm_ops structures
      ASoC: fsl: constify snd_pcm_ops structures
      ASoC: omap: constify snd_pcm_ops structures
      ASoC: pxa: constify snd_pcm_ops structures
      ASoC: txx9: constify snd_pcm_ops structures
      ASoC: intel: constify snd_pcm_ops structures
      ASoC: nuc900: constify snd_pcm_ops structures
      ASoC: sh: constify snd_pcm_ops structures
      ASoC: codecs: constify snd_soc_dai_ops structures
      ASoC: codecs: constify snd_soc_dai_ops structures
      ASoC: ux500: constify snd_soc_dai_ops structures

Axel Lin (3):
      ASoC: wm8523: Fix array size for bclk_ratios
      ASoC: wm8523: Constfiy lrclk_ratios and bclk_ratios
      ASoC: wm8524: Don't use dev_err to show supported sample rate

Bard Liao (9):
      ASoC: rt5665: force using PLL if MCLK is not suitable
      ASoC: rt274: add rt274 codec driver
      ASoC: rt274: correct comment style
      ASoC: rt5665: add clcok control for master mode
      ASoC: rt5665: add clock sync control for master mode
      ASoC: rt5665: add MONOVOL Playback Volume control
      ASoC: rt5670: add symmetric_rates flag
      ASoC: rt5670: merge ADC L/R Mux
      ASoC: rt274: add acpi id

Bhumika Goyal (31):
      ASoC: sunxi: make snd_soc_codec_driver structures as const
      ASoC: codecs: add const to snd_soc_codec_driver structures
      ASoC: samsung: make snd_soc_platform_driver const
      ASoC: fsl: make snd_soc_platform_driver const
      ASoC: nuc900: make snd_soc_platform_driver const
      ASoC: omap: make snd_soc_platform_driver const
      ASoC: pxa: make snd_soc_platform_driver const
      ASoC: qcom: make snd_soc_platform_driver const
      ASoC: sh: make snd_soc_platform_driver const
      ASoC: txx9: make snd_soc_platform_driver const
      ASoC: soc-utils: make snd_soc_platform_driver const
      ASoC: codecs: make snd_soc_platform_driver const
      ASoC: Intel: make snd_soc_platform_driver const
      ASoC: Intel: kbl: make snd_pcm_hw_constraint_list const
      ASoC: Intel: Skylake: make skl_dsp_fw_ops const
      ASoC: codecs: make snd_compr_ops const
      ASoC: fsl: make snd_pcm_hardware const
      ASoC: kirkwood: make snd_pcm_hardware const
      ASoC: sh: make snd_pcm_hardware const
      ASoC: qcom: make snd_pcm_hardware const
      ASoC: Intel: Atom: make snd_pcm_hardware const
      ASoC: Intel: Skylake: make snd_pcm_hardware const
      ASoC: aux1x: make snd_soc_ops const
      ASoC: cirrus: make snd_soc_ops const
      ASoC: generic: make snd_soc_ops const
      ASoC: rockchip: make snd_soc_ops const
      ASoC: samsung: make snd_soc_ops const
      ASoC: sh: make snd_soc_ops const
      ASoC: bcm: make snd_soc_dai_driver const
      ASoC: codecs: make snd_soc_dai_driver and snd_soc_component_driver const
      ASoC: rt5645: make rt5645_platform_data const

Christophe Jaillet (3):
      ASoC: mediatek: Fix an error checking code
      ASoC: davinci-mcasp: check memory allocation failure
      ALSA: ac97c: Fix an error handling path in 'atmel_ac97c_probe()'

Colin Ian King (8):
      ASoC: hdmi-codec: make const array hdmi_codec_eld_spk_alloc_bits static
      ASoC: rt5663: add in missing loop counter to avoid infinite loop
      ASoC: Intel: Skylake: fix type in debug message
      ASoC: max98926: make max98926_spk_tlv and max98926_current_tlv static
      ASoC: rt5514: make array rt5514_dai static
      ASoC: zx_aud96p22: make array aud96p22_dt_ids static
      ASoC: samsung: make tm2_dapm_widgets and tm2_pm_ops static
      ASoC: hdmi-codec: make a function and two arrays static

Dan Carpenter (1):
      ASoC: codecs: msm8916-wcd-analog: always true condition

Dan Murphy (2):
      ASoC: tlv320aic32x4: Add support for tlv320aic32x6
      ASoC: tlv320aic32x4: Add gpio configuration to the codec

Daniel Baluta (1):
      ASoC: simple-scu-card: Parse off codec widgets

Dharageswari R (1):
      ASoC: Intel: Skylake: Add num of cores in dsp ops

Donglin Peng (11):
      ASoC: s3c24xx_uda134x: Remove unnecessary function call
      ASoC: atmel: Remove unnecessary function call
      ASoC: atmel: Remove unnecessary function call
      ASoC: rockchip: Remove unnecessary function call
      ASoC: mxs-sgtl5000: Remove unnecessary function call
      ASoC: qcom: Remove useless function call
      ASoC: qcom: Remove unnecessary function call
      ASoC: sun4i-codec: Remove unnecessary function call
      ASoC: mediatek: Remove unnecessary function call
      ASoC: tegra: Remove unnecessary function call
      ASoC: ux500: Remove unnecessary function call

Dronamraju Santosh P K (1):
      ASoC: Intel: bxtn: Remove code loader reference in cleanup

Fabio Estevam (11):
      ASoC: sun4i-codec: Remove unneeded gpiod NULL check
      ASoC: adau1977: Remove unneeded gpiod NULL check
      ASoC: wm8804: Remove unneeded gpiod NULL check
      ASoC: cs35l33: Remove unneeded gpiod NULL check
      ASoC: cs35l34: Remove unneeded gpiod NULL check
      ASoC: cs42l42: Remove unneeded gpiod NULL check
      ASoC: cs53l30: Remove unneeded gpiod NULL check
      ASoC: sta32x: Remove unneeded gpiod NULL check
      ASoC: soc-pcm: Remove unused 'debugfs_dpcm_state' entry
      ASoC: soc-core: Remove unneeded dentry member from snd_soc_codec
      ASoC: soc-core: Use IS_ERR_OR_NULL()

Geert Uytterhoeven (1):
      ASoC: rsnd: Drop unit-addresses without reg properties

Guneshwor Singh (7):
      ASoC: Intel: Skylake: Use num_core to allocate instead of macro
      ASoC: Intel: cnl: Add cnl dsp functions and registers
      ASoC: Intel: Skylake: Move platform specific init to platform dsp_init()
      ASoC: Intel: cnl: Unstatify common ipc functions
      ASoC: Intel: cnl: Add sst library functions for cnl platform
      ASoC: Intel: cnl: add dsp ops for cannonlake
      ASoC: Intel: cnl: add pci id for cnl

Gustavo A. R. Silva (32):
      ASoC: kirkwood-i2s: fix error return code in kirkwood_i2s_dev_probe()
      ASoC: spear: fix error return code in spdif_in_probe()
      ASoC: twl6040: fix error return code in twl6040_probe()
      ASoC: fsi: constify dev_pm_ops structure
      ASoC: psc-ac97: constify dev_pm_ops structure
      ASoC: au1x: psc-i2s: constify dev_pm_ops structure
      ASoC: Intel: Skylake: constify snd_soc_dai_ops structures
      ASoC: Intel: Atom: constify snd_soc_dai_ops structures
      ASoC: tegra: constify snd_soc_dai_ops structure
      ASoC: sun8i-codec: constify snd_soc_dai_ops structure
      ASoC: fsl_spdif: constify snd_soc_dai_ops structure
      ASoC: fsl_esai: constify snd_soc_dai_ops structure
      ASoC: fsl_asrc: constify snd_soc_dai_ops structure
      ASoC: hisilicon: constify snd_soc_dai_ops structure
      ASoC: mediatek: mt2701: constify snd_soc_dai_ops structure
      ASoC: mmp-sspa: constify snd_soc_dai_ops structure
      ASoC: zx-i2s: constify snd_soc_dai_ops structure
      ASoC: zx-tdm: constify snd_soc_dai_ops structure
      ASoC: zte: spdif: constify snd_soc_dai_ops structure
      ASoC: cs42l42: constify snd_soc_dai_ops structure
      ASoC: rt5663: constify snd_soc_dai_ops structure
      ASoC: rt5616: constify snd_soc_dai_ops structure
      ASoC: msm8916-wcd-analog: constify snd_soc_dai_ops structure
      ASoC: max98926: constify snd_soc_dai_ops structure
      ASoC: rt5514: constify snd_soc_dai_ops structure
      ASoC: codecs: msm8916-wcd-digital: constify snd_soc_dai_ops structure
      ASoC: max9867: constify snd_soc_dai_ops structure
      ASoC: rk3036: constify snd_soc_dai_ops structure
      ASoC: hdac_hdmi: constify snd_soc_dai_ops structure
      ASoC: dwc: constify snd_soc_dai_ops structure
      ASoC: tas5720: constify snd_soc_dai_ops structure
      ASoC: rsnd: remove unnecessary static in rsnd_ssiu_probe()

Harsha Priya N (4):
      ASoC: Intel: Enabling 4 slot IV feedback for max98927 on Kabylake platform
      ASoC: Intel: kbl_rt5663_rt5514_max98927: Add rt5514 spi dailink
      ASoC: Intel: kbl: Enabling ASRC for RT5663 codec on kabylake platform
      ASoC: Intel: Headset button support in kabylake machine driver

Hsin-Yu Chao (2):
      ASoC: rt5514: expose Hotword Model control
      ASoC: rt5514: Guard Hotword Model bytes loading

Ian W MORRISON (1):
      ASoC: rt5645: Add jack detection workaround for MINIX Z83-4 based devices

Jaechul Lee (1):
      ASoC: samsung: i2s: Support more resolution rates

Jeeja KP (1):
      ASoC: Intel: Skylake: Update module id in pin connections

Jeffy Chen (10):
      ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai
      ASoC: rockchip: Correct 'dmic-delay' property name
      ASoC: Add a sanity check before using dai driver name
      ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
      ASoC: rockchip: Parse dai links from dts
      ASoC: rockchip: Add support for DP codec
      ASoC: rockchip: Add support for DMIC codec
      ASoC: rockchip: Update description of rockchip, codec
      ASoC: rockchip: constify snd_soc_ops structures
      ASoC: hdmi-codec: Use different name for playback streams

John Hsu (1):
      ASoC: nau8825: correct typo of semaphore comment

Julia Lawall (7):
      ASoC: rsnd: add missing of_node_put
      ASoC: blackfin: constify snd_soc_dai_ops structures
      ASoC: rockchip: constify snd_soc_dai_ops structures
      ASoC: codecs: es8316: constify snd_soc_dai_ops structures
      ASoC: codecs: zx_aud96p22: constify snd_soc_dai_ops structures
      ASoC: spear: constify snd_soc_dai_ops structures
      ASoC: Intel: constify snd_compr_codec_caps structures

Kevin Cheng (2):
      ASoC: Intel: Add Kabylake machine driver for RT5663
      ASoC: Intel: Add Kabylake RT5663 machine driver entry

Krzysztof Kozlowski (4):
      ASoC: samsung: Remove non-existing CONFIG_CPU_S3C2413
      ASoC: samsung: Fix possible double iounmap on s3c24xx driver probe failure
      ASoC: samsung: Add missing prepare for iis clock of s3c24xx
      ASoC: samsung: Add proper error paths to s3c24xx I2S driver

Kuninori Morimoto (34):
      ASoC: hdmi-codec: ELD control corresponds to the PCM stream
      ASoC: rsnd: don't use private_value on rsnd_kctrl_new()
      ASoC: remove cache_bypass from snd_soc_codec
      ASoC: rsnd: merge snd_pcm_ops::open and snd_soc_dai_ops::startup
      ASoC: rcar: unregister fixed rate on ADG
      ASoC: soc-core: rename "cmpnt" to "component"
      ASoC: soc-core: remove duplicate mutex_unlock from snd_soc_unregister_component()
      ASoC: rsnd: move rsnd_ssi_config_init() execute condition into it.
      ASoC: rsnd: rsnd_ssi_can_output_clk() macro
      ASoC: rsnd: control SSICR::EN correctly
      ASoC: rsnd: remove 16ch support for now
      ASoC: rsnd: avoid duplicate free_irq()
      ASoC: rsnd: call free_irq() both DMA/PIO mode
      ASoC: rsnd: add rsnd_ssi_flags_has/add() macro
      ASoC: rsnd: call request_irq/free_irq once in MIX case
      ASoC: soc-core: add snd_soc_rtdcom_xxx()
      ASoC: use snd_soc_rtdcom_add() and convert to consistent operation
      ASoC: soc-core: snd_soc_unregister_component() unregister all component
      ASoC: rsnd: tidyup comments position/space/tab
      ASoC: rsnd: remove unused rsnd_xxx_to_dma()
      ASoC: wm8524: remove unnecessary snd_soc_unregister_platform()
      ASoC: simple-scu-card: Add pm callbacks to platform driver
      ASoC: audio-graph-card: Add pm callbacks to platform driver
      ASoC: audio-graph-scu-card: Add pm callbacks to platform driver
      ASoC: use snd_soc_component_get_dapm()
      ASoC: remove duplicate definition of controls/num_controls
      ASoC: remove duplicate definition of dapm_widgets/num_dapm_widgets
      ASoC: remove duplicate definition of dapm_routes/num_dapm_routes
      ASoC: add Component level set_sysclk
      ASoC: add Component level set_pll
      ASoC: add Component level set_jack
      ASoC: add missing compile rule for max98371
      ASoC: add missing compile rule for sirf-audio-codec
      ASoC: add missing compile rule for max98371

Li Xu (2):
      ASoC: cs43130: Add support for CS43130 codec
      ASoC: cs43130: Add devicetree bindings for CS43130

Lori Hikichi (1):
      ASoC: cygnus: Add support for 384kHz frame rates

Lucas Stach (2):
      ASoC: fsl-asoc-card: don't print EPROBE_DEFER as error
      ASoC: simple_card_utils: fix fallback when "label" property isn't present

Marcus Cooper (12):
      ASoC: sun4i-i2s: Extend quirks scope
      ASoC: sun4i-i2s: Add clkdiv offsets to quirks
      ASoC: sun4i-i2s: Add regmap config to quirks
      ASoC: sun4i-i2s: Add TX FIFO offset to quirks
      ASoC: sun4i-i2s: Add regmap fields for channels
      ASoC: sun4i-i2s: Add regfields for word size select and sample resolution
      ASoC: sun4i-i2s: bclk and lrclk polarity tidyup
      ASoC: sun4i-i2s: Add mclk enable regmap field
      ASoC: sun4i-i2s: Add regmap field to set DAI format
      ASoC: sun4i-i2s: Check for slave select bit
      ASoC: sun4i-i2s: Update global enable with bitmask
      ASoC: sun4i-i2s: Add support for H3

Mark Brown (40):
      Merge branch 'fix/rcar' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge branches 'topic/rt274', 'topic/hdmi' and 'topic/msm8916' of git://git.kernel.org/.../broonie/sound into asoc-const
      Merge branch 'topic/qcom' of git://git.kernel.org/.../broonie/sound into asoc-msm8916
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/sound into asoc-core
      Merge branch 'topic/pcm' of git://git.kernel.org/.../broonie/sound into asoc-core
      Merge branch 'topic/sh' of git://git.kernel.org/.../broonie/sound into asoc-rcar
      Merge branch 'topic/const' of git://git.kernel.org/.../broonie/sound into asoc-dmic
      Merge branches 'topic/dmic' and 'topic/qcom' of git://git.kernel.org/.../broonie/sound into asoc-msm8916
      Merge tag 'v4.13-rc6' into asoc-msm8916
      Merge branch 'topic/msm8916' of git://git.kernel.org/.../broonie/sound into asoc-const
      Merge branch 'topic/const' of git://git.kernel.org/.../broonie/sound into asoc-blackfin
      Merge tag 'sound-4.13-rc7' of git://git.kernel.org/.../tiwai/sound into asoc-rt5677
      Merge tag 'v4.13-rc7' into asoc-component
      Merge remote-tracking branch 'asoc/fix/rt5670' into asoc-fixes
      Merge tag 'asoc-fix-v4.13-rc7' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/arizona' and 'asoc/fix/mtk' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/msm8916' into asoc-next
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/const' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adau1977', 'asoc/topic/arizona', 'asoc/topic/atmel', 'asoc/topic/au1x' and 'asoc/topic/bcm' into asoc-next
      Merge remote-tracking branches 'asoc/topic/blackfin', 'asoc/topic/build', 'asoc/topic/cirrus' and 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l33', 'asoc/topic/cs35l34' and 'asoc/topic/cs42l42' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs43130', 'asoc/topic/cs53l30', 'asoc/topic/cygnus' and 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/es8316', 'asoc/topic/fsi', 'asoc/topic/fsl' and 'asoc/topic/hdmi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hisi', 'asoc/topic/img', 'asoc/topic/jack' and 'asoc/topic/jz4740' into asoc-next
      Merge remote-tracking branches 'asoc/topic/kirkwood', 'asoc/topic/max9867', 'asoc/topic/max98926' and 'asoc/topic/max98927' into asoc-next
      Merge remote-tracking branches 'asoc/topic/mtk', 'asoc/topic/mxs', 'asoc/topic/nau8825', 'asoc/topic/nuc900' and 'asoc/topic/of-graph' into asoc-next
      Merge remote-tracking branches 'asoc/topic/omap', 'asoc/topic/psc-ac97' and 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rk3036', 'asoc/topic/rockchip', 'asoc/topic/rt274' and 'asoc/topic/rt5514' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5563', 'asoc/topic/rt5616', 'asoc/topic/rt5645', 'asoc/topic/rt5659' and 'asoc/topic/rt5663' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5665', 'asoc/topic/rt5670', 'asoc/topic/rt5677' and 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple', 'asoc/topic/spear', 'asoc/topic/sta32x', 'asoc/topic/stm32' and 'asoc/topic/sunxi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas2552', 'asoc/topic/tas5720', 'asoc/topic/tegra', 'asoc/topic/tlv320aic32x4' and 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/twl6040', 'asoc/topic/txx9', 'asoc/topic/utils', 'asoc/topic/ux500' and 'asoc/topic/wm8523' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8524', 'asoc/topic/wm8804' and 'asoc/topic/zte' into asoc-next

Markus Elfring (13):
      ASoC: spear: Delete an error message for a failed memory allocation in two functions
      ASoC: compress: Delete error messages for a failed memory allocation in snd_soc_new_compress()
      ASoC: rsnd: Delete an error message for a failed memory allocation in three functions
      ASoC: blackfin: Delete an error message for a failed memory allocation in sport_create()
      ASoC: blackfin: Use common error handling code in sport_create()
      ASoC: blackfin: Add some spaces for better code readability
      ASoC: dwc: Delete an error message for a failed memory allocation in dw_i2s_probe()
      ASoC: kirkwood: Delete an error message for a failed memory allocation in kirkwood_i2s_dev_probe()
      ASoC: fsi: Delete an error message for a failed memory allocation in fsi_probe()
      ASoC: rockchip: Delete an error message for a failed memory allocation in rockchip_i2s_probe()
      ASoC: DaVinci: Delete an error message for a failed memory allocation in two functions
      ASoC: Freescale: Delete an error message for a failed memory allocation in three functions
      ASoC: Medfield: Delete an error message for a failed memory allocation in snd_mfld_mc_probe()

Mihai Serban (1):
      ASoC: codecs: add wm8524 codec driver

Naveen M (2):
      ASoC: Intel: kbl: Add MST route change to kbl machine drivers
      ASoC: Intel: kbl: Add jack port initialize in kbl machine drivers

Naveen Manohar (5):
      ASoC: Intel: Skylake: Use correct nuvoton codec ID
      ASoC: Intel: kbl: Add new FEs for Multi-Playback & Echo-Reference
      ASoC: Intel: kbl: Add DAI links for Multi-Playback & Echo-reference
      ASoC: Intel: kbl: Add map for new DAIs for Multi-Playback & Echo Ref
      ASoC: Intel: kbl: Add map for Maxim IV Feedback

Oskar Schirmer (1):
      ASoC: tas2552: Fix fraction overflow in PLL calculation

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Add dsp cores management

Paul Kocialkowski (1):
      ASoC: tegra: Remove SoC-specific Kconfig depends and selects

Peng Donglin (1):
      ASoC: compress: Set reasonable compress id string

Peter Ujfalusi (1):
      ASoC: tlv320aic3x: Support for OCMV configuration

Philipp Zabel (4):
      ASoC: img: explicitly request exclusive reset control
      ASoC: stm32: explicitly request exclusive reset control
      ASoC: sun4i: explicitly request exclusive reset control
      ASoC: tegra: explicitly request exclusive reset control

Pierre-Louis Bossart (2):
      ASoC: codecs: rt5645: add quirks for Asus T100HA
      ASoC: codecs: rt5670: add jack detection quirk for Dell Venue 5585

Pradeep Tewani (5):
      ASoC: Intel: board: Remove .owner initialization in bxt_rt298 driver
      ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI
      ASoC: Intel: board: Add Geminilake platform support
      ASoC: Intel: board: Fix missing sentinel for bxt_board_id
      ASoC: Intel: Skylake: Add IPC to configure the copier secondary pins

Ramesh Babu (1):
      ASoC: Intel: Skylake: Parse and update module config structure

Rob Herring (2):
      ASoC: fsl: Convert to using %pOF instead of full_name
      ASoC: fsl_dma: remove dma_object path member

Ryan Lee (6):
      ASoC: max98927: Updated volatile register list
      ASoC: max98927: Added missing \n to end of dev_err messages
      ASoC: max98927: Modified chip default register values
      ASoC: max98927: Added PM suspend and resume function
      ASoC: max98927: Modified DAPM widget and map to enable/disable VI sense path
      ASoC: max98927: Changed device property read function

Ryder Lee (2):
      ASoC: mediatek: Add interrupt-names property in binding text
      ASoC: mediatek: switch to use platform_get_irq_byname()

Sapthagiri Baratam (1):
      arizona: anc: Correct setting of FCx_MIC_MODE_SEL

Shreyas NC (5):
      ASoC: Intel: Skylake: Parse multiple manifest data blocks
      ASoC: Intel: uapi: Add new tokens for module common data
      ASoC: Intel: Skylake: Commonize parsing of format tokens
      ASoC: Intel: Skylake: Add driver structures to be filled from topology manifest
      ASoC: Intel: Skylake: Populate module data from topology manifest

Srinivas Kandagatla (9):
      ASoC: jack: fix snd_soc_codec_set_jack return error
      ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk
      ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk
      ASoC: qcom: apq8016-sbc: set default mclk rate
      ASoC: codecs: msm8916-wcd-digital: add CIC filter source selection path
      ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
      ASoC: codecs: msm8916-wcd-analog: get micbias voltage from dt
      ASoC: codecs: msm8916-wcd-analog: add MBHC support
      ASoC: qcom: apq8016-sbc: Add support to Headset JACK

Subhransu S. Prusty (5):
      ASoC: Intel: Skylake: Fix to free dsp resource on ipc_init failure
      ASoC: Intel: Skylake: Fix to free resources for dsp_init failure
      ASoC: Intel: Skylake: Fix to free correct dev id in free_irq
      ASoC: Intel: Skylake: Fix DSP core ref count for init failure
      ASoC: Intel: Skylake: Fix uninitialized return

Sugar Zhang (2):
      ASoC: rockchip: add bindings for i2s
      ASoC: rockchip: separate pinctrl pins from each other

Sylwester Nawrocki (1):
      ASoC: samsung: odroid: Drop requirement of clocks in the sound node

Takashi Iwai (10):
      ASoC: jack: Manage gpios via devres
      ASoC: fsl: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: simple-card: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: intel: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: omap: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: pxa: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: samsung: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: tegra: Remove superfluous snd_soc_jack_free_gpios() call
      ASoC: rt5670: Fix GPIO headset detection regression
      ASoC: tegra: Fix unused variable warning

Vitaly Wool (1):
      ASoC: make clock direction configurable in asoc-simple

guneshwor.o.singh@intel.com (3):
      ASoC: Intel: Skylake: Reset the controller in probe
      ASoC: Intel: Skylake: Remove return check for skl_codec_create()
      ASoC: Intel: Skylake: Fix potential null pointer dereference

huang lin (2):
      dt-bindings: sound: add dmicen property in dmic driver
      ASoC: codec: use enable pin to control dmic start and stop

oder_chiou@realtek.com (18):
      ASoC: rt5514: Move the auto disable DSP function to set_bias_level()
      ASoC: rt5663: Update the calibration funciton
      ASoC: rt5663: Optimize the Jack Type detection
      ASoC: rt5663: Modify the power sequence for reducing the pop sound
      ASoC: rt5663: Add the manual offset field to compensate the DC offset
      ASoC: rt5514: Support the DSP recording continuously after the hotwording triggered
      ASoC: rt5663: Modify the default value for ASRC function
      ASoC: rt5663: Correct the mixer switch setting and remove redundant routing path
      ASoC: rt5514: Support the TDM docking mode
      ASoC: rt5514: Add the I2S ASRC support
      ASoC: rt5514: Use the IS_ENABLED to supports the module build
      ASoC: rt5663: Add the delay time to correct the calibration
      ASoC: rt5514: Add the sanity checks of the buffer related address
      ASoC: rt5663: Seprate the DC offset between headphone and headset
      ASoC: rt5514: reset dma_offset at hw_params
      ASoC: rt5514: Eliminate the noise in the ASRC case
      ASoC: rt5663: Fine tune for the headphone output pop sound
      ASoC: rt5663: Add delay for jack plug in

 .../devicetree/bindings/sound/cs43130.txt          |   67 +
 Documentation/devicetree/bindings/sound/dmic.txt   |   16 +
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |    4 +-
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |   18 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   68 +-
 .../devicetree/bindings/sound/rockchip,pdm.txt     |    7 +-
 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |    2 +-
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    4 +
 Documentation/devicetree/bindings/sound/rt274.txt  |   33 +
 Documentation/devicetree/bindings/sound/rt5663.txt |    8 +
 .../devicetree/bindings/sound/samsung,odroid.txt   |    6 -
 .../devicetree/bindings/sound/simple-card.txt      |    3 +
 .../devicetree/bindings/sound/simple-scu-card.txt  |    1 +
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    2 +
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |   13 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    5 +
 Documentation/devicetree/bindings/sound/wm8524.txt |   16 +
 include/sound/rt5663.h                             |   22 +
 include/sound/rt5677.h                             |   45 -
 include/sound/simple_card_utils.h                  |    1 +
 include/sound/soc.h                                |   53 +-
 include/sound/tlv320aic32x4.h                      |   23 +
 include/uapi/sound/snd_sst_tokens.h                |   92 +-
 sound/atmel/ac97c.c                                |    9 +-
 sound/soc/atmel/atmel-classd.c                     |    1 -
 sound/soc/atmel/atmel-pdmic.c                      |    1 -
 sound/soc/au1x/db1200.c                            |    2 +-
 sound/soc/au1x/dbdma2.c                            |    2 +-
 sound/soc/au1x/dma.c                               |    2 +-
 sound/soc/au1x/psc-ac97.c                          |    2 +-
 sound/soc/au1x/psc-i2s.c                           |    2 +-
 sound/soc/bcm/cygnus-ssp.c                         |  237 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |    2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |    2 +-
 sound/soc/blackfin/bf6xx-i2s.c                     |    2 +-
 sound/soc/blackfin/bf6xx-sport.c                   |   38 +-
 sound/soc/cirrus/edb93xx.c                         |    2 +-
 sound/soc/cirrus/snappercl15.c                     |    2 +-
 sound/soc/codecs/88pm860x-codec.c                  |    2 +-
 sound/soc/codecs/Kconfig                           |   20 +-
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/ab8500-codec.c                    |    2 +-
 sound/soc/codecs/ac97.c                            |    2 +-
 sound/soc/codecs/ad1836.c                          |    2 +-
 sound/soc/codecs/ad193x.c                          |    2 +-
 sound/soc/codecs/ad1980.c                          |    2 +-
 sound/soc/codecs/ad73311.c                         |    2 +-
 sound/soc/codecs/adau1373.c                        |    2 +-
 sound/soc/codecs/adau1701.c                        |    2 +-
 sound/soc/codecs/adau1977.c                        |    8 +-
 sound/soc/codecs/adav80x.c                         |    2 +-
 sound/soc/codecs/ads117x.c                         |    2 +-
 sound/soc/codecs/ak4104.c                          |    2 +-
 sound/soc/codecs/ak4535.c                          |    2 +-
 sound/soc/codecs/ak4554.c                          |    2 +-
 sound/soc/codecs/ak4613.c                          |    2 +-
 sound/soc/codecs/ak4641.c                          |    2 +-
 sound/soc/codecs/ak4642.c                          |    2 +-
 sound/soc/codecs/ak4671.c                          |    2 +-
 sound/soc/codecs/ak5386.c                          |    2 +-
 sound/soc/codecs/alc5623.c                         |    2 +-
 sound/soc/codecs/arizona.c                         |    4 +-
 sound/soc/codecs/bt-sco.c                          |    2 +-
 sound/soc/codecs/cq93vc.c                          |    2 +-
 sound/soc/codecs/cs35l33.c                         |   14 +-
 sound/soc/codecs/cs35l34.c                         |    5 +-
 sound/soc/codecs/cs35l35.c                         |    2 +-
 sound/soc/codecs/cs4271.c                          |    2 +-
 sound/soc/codecs/cs42l42.c                         |   11 +-
 sound/soc/codecs/cs42l51.c                         |    2 +-
 sound/soc/codecs/cs43130.c                         | 2690 ++++++++++++++++++++
 sound/soc/codecs/cs43130.h                         |  546 ++++
 sound/soc/codecs/cs4349.c                          |    2 +-
 sound/soc/codecs/cs47l24.c                         |    6 +-
 sound/soc/codecs/cs53l30.c                         |   17 +-
 sound/soc/codecs/cx20442.c                         |    2 +-
 sound/soc/codecs/da7210.c                          |    2 +-
 sound/soc/codecs/da7213.c                          |    2 +-
 sound/soc/codecs/da7218.c                          |    2 +-
 sound/soc/codecs/da7219.c                          |    2 +-
 sound/soc/codecs/da732x.c                          |    2 +-
 sound/soc/codecs/da9055.c                          |    2 +-
 sound/soc/codecs/dmic.c                            |   54 +-
 sound/soc/codecs/es7134.c                          |    2 +-
 sound/soc/codecs/es8316.c                          |    4 +-
 sound/soc/codecs/es8328.c                          |    2 +-
 sound/soc/codecs/hdac_hdmi.c                       |   43 +-
 sound/soc/codecs/hdmi-codec.c                      |   47 +-
 sound/soc/codecs/ics43432.c                        |    2 +-
 sound/soc/codecs/inno_rk3036.c                     |    4 +-
 sound/soc/codecs/isabelle.c                        |    2 +-
 sound/soc/codecs/jz4740.c                          |    2 +-
 sound/soc/codecs/lm4857.c                          |    2 +-
 sound/soc/codecs/lm49453.c                         |    2 +-
 sound/soc/codecs/max9768.c                         |    2 +-
 sound/soc/codecs/max98088.c                        |    2 +-
 sound/soc/codecs/max98090.c                        |    2 +-
 sound/soc/codecs/max98095.c                        |    2 +-
 sound/soc/codecs/max98357a.c                       |    2 +-
 sound/soc/codecs/max98371.c                        |   14 +-
 sound/soc/codecs/max9850.c                         |    2 +-
 sound/soc/codecs/max9860.c                         |    2 +-
 sound/soc/codecs/max9867.c                         |    4 +-
 sound/soc/codecs/max98926.c                        |    8 +-
 sound/soc/codecs/max98927.c                        |   87 +-
 sound/soc/codecs/mc13783.c                         |    2 +-
 sound/soc/codecs/ml26124.c                         |    2 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |  415 ++-
 sound/soc/codecs/msm8916-wcd-digital.c             |   39 +-
 sound/soc/codecs/nau8540.c                         |    2 +-
 sound/soc/codecs/nau8810.c                         |    2 +-
 sound/soc/codecs/nau8824.c                         |    2 +-
 sound/soc/codecs/nau8825.c                         |   28 +-
 sound/soc/codecs/pcm1681.c                         |    2 +-
 sound/soc/codecs/pcm179x.c                         |    2 +-
 sound/soc/codecs/pcm3008.c                         |    2 +-
 sound/soc/codecs/pcm512x.c                         |    2 +-
 sound/soc/codecs/rt274.c                           | 1229 +++++++++
 sound/soc/codecs/rt274.h                           |  217 ++
 sound/soc/codecs/rt286.c                           |    2 +-
 sound/soc/codecs/rt298.c                           |    2 +-
 sound/soc/codecs/rt5514-spi.c                      |  146 +-
 sound/soc/codecs/rt5514-spi.h                      |    7 +-
 sound/soc/codecs/rt5514.c                          |  174 +-
 sound/soc/codecs/rt5514.h                          |   22 +
 sound/soc/codecs/rt5616.c                          |    4 +-
 sound/soc/codecs/rt5631.c                          |    2 +-
 sound/soc/codecs/rt5640.c                          |    2 +-
 sound/soc/codecs/rt5645.c                          |   45 +-
 sound/soc/codecs/rt5651.c                          |    2 +-
 sound/soc/codecs/rt5659.c                          |    4 +-
 sound/soc/codecs/rt5660.c                          |    2 +-
 sound/soc/codecs/rt5663.c                          |  264 +-
 sound/soc/codecs/rt5663.h                          |    2 +
 sound/soc/codecs/rt5665.c                          |   55 +-
 sound/soc/codecs/rt5665.h                          |   21 +
 sound/soc/codecs/rt5670.c                          |   64 +-
 sound/soc/codecs/rt5677.c                          |   82 +-
 sound/soc/codecs/rt5677.h                          |   30 +-
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/si476x.c                          |    2 +-
 sound/soc/codecs/sirf-audio-codec.c                |   12 +-
 sound/soc/codecs/sn95031.c                         |    2 +-
 sound/soc/codecs/spdif_receiver.c                  |    2 +-
 sound/soc/codecs/spdif_transmitter.c               |    2 +-
 sound/soc/codecs/ssm2518.c                         |    2 +-
 sound/soc/codecs/ssm2602.c                         |    2 +-
 sound/soc/codecs/ssm4567.c                         |    2 +-
 sound/soc/codecs/sta32x.c                          |    3 +-
 sound/soc/codecs/stac9766.c                        |    2 +-
 sound/soc/codecs/tas2552.c                         |   13 +-
 sound/soc/codecs/tas5086.c                         |    2 +-
 sound/soc/codecs/tas5720.c                         |    4 +-
 sound/soc/codecs/tlv320aic23.c                     |    2 +-
 sound/soc/codecs/tlv320aic26.c                     |    2 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    2 +-
 sound/soc/codecs/tlv320aic32x4-i2c.c               |    2 +
 sound/soc/codecs/tlv320aic32x4-spi.c               |    2 +
 sound/soc/codecs/tlv320aic32x4.c                   |  208 +-
 sound/soc/codecs/tlv320aic32x4.h                   |    3 +
 sound/soc/codecs/tlv320aic3x.c                     |   47 +-
 sound/soc/codecs/tlv320aic3x.h                     |    8 +
 sound/soc/codecs/tlv320dac33.c                     |    2 +-
 sound/soc/codecs/twl4030.c                         |    2 +-
 sound/soc/codecs/twl6040.c                         |    6 +-
 sound/soc/codecs/uda134x.c                         |    2 +-
 sound/soc/codecs/uda1380.c                         |    2 +-
 sound/soc/codecs/wl1273.c                          |    2 +-
 sound/soc/codecs/wm5102.c                          |    4 +-
 sound/soc/codecs/wm5110.c                          |    4 +-
 sound/soc/codecs/wm8523.c                          |    6 +-
 sound/soc/codecs/wm8524.c                          |  261 ++
 sound/soc/codecs/wm8804.c                          |    3 +-
 sound/soc/codecs/zx_aud96p22.c                     |    6 +-
 sound/soc/davinci/davinci-mcasp.c                  |    6 +-
 sound/soc/davinci/davinci-vcif.c                   |    5 +-
 sound/soc/dwc/dwc-i2s.c                            |    6 +-
 sound/soc/fsl/fsl-asoc-card.c                      |    2 +-
 sound/soc/fsl/fsl_asrc.c                           |    2 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |    6 +-
 sound/soc/fsl/fsl_dma.c                            |   11 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_spdif.c                          |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |    4 +-
 sound/soc/fsl/imx-audmux.c                         |   16 +-
 sound/soc/fsl/imx-es8328.c                         |    3 -
 sound/soc/fsl/imx-pcm-fiq.c                        |    6 +-
 sound/soc/fsl/mpc5200_dma.c                        |    4 +-
 sound/soc/generic/audio-graph-card.c               |    3 +-
 sound/soc/generic/audio-graph-scu-card.c           |    3 +-
 sound/soc/generic/simple-card-utils.c              |   11 +-
 sound/soc/generic/simple-card.c                    |   10 -
 sound/soc/generic/simple-scu-card.c                |    5 +
 sound/soc/hisilicon/hi6210-i2s.c                   |    2 +-
 sound/soc/img/img-i2s-in.c                         |    2 +-
 sound/soc/img/img-i2s-out.c                        |    2 +-
 sound/soc/img/img-parallel-out.c                   |    2 +-
 sound/soc/img/img-spdif-in.c                       |    2 +-
 sound/soc/img/img-spdif-out.c                      |    2 +-
 sound/soc/intel/Kconfig                            |    3 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   10 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |    4 +-
 sound/soc/intel/atom/sst/sst_pci.c                 |    2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |    4 +-
 sound/soc/intel/boards/bxt_rt298.c                 |   86 +-
 sound/soc/intel/boards/byt-max98090.c              |   12 -
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   10 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  310 ++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   81 +-
 sound/soc/intel/boards/mfld_machine.c              |    4 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c          |    2 +-
 sound/soc/intel/skylake/Makefile                   |    5 +-
 sound/soc/intel/skylake/bxt-sst.c                  |   14 +-
 sound/soc/intel/skylake/cnl-sst-dsp.c              |  274 ++
 sound/soc/intel/skylake/cnl-sst-dsp.h              |  112 +
 sound/soc/intel/skylake/cnl-sst.c                  |  497 ++++
 sound/soc/intel/skylake/skl-messages.c             |  163 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   82 +-
 sound/soc/intel/skylake/skl-sst-dsp.c              |    6 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |    6 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |   12 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |    6 +-
 sound/soc/intel/skylake/skl-sst.c                  |   12 +-
 sound/soc/intel/skylake/skl-topology.c             |  741 +++++-
 sound/soc/intel/skylake/skl-topology.h             |   83 +
 sound/soc/intel/skylake/skl.c                      |   32 +-
 sound/soc/intel/skylake/skl.h                      |    3 +
 sound/soc/jz4740/jz4740-i2s.c                      |   21 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    2 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   11 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |    2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |   15 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |    1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    1 -
 sound/soc/mxs/mxs-saif.c                           |   13 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    1 -
 sound/soc/nuc900/nuc900-pcm.c                      |    4 +-
 sound/soc/omap/ams-delta.c                         |   10 -
 sound/soc/omap/omap-pcm.c                          |    4 +-
 sound/soc/omap/omap-twl4030.c                      |   13 -
 sound/soc/omap/rx51.c                              |    9 -
 sound/soc/pxa/hx4700.c                             |    8 -
 sound/soc/pxa/mmp-pcm.c                            |    4 +-
 sound/soc/pxa/mmp-sspa.c                           |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    4 +-
 sound/soc/qcom/apq8016_sbc.c                       |   58 +-
 sound/soc/qcom/lpass-platform.c                    |    4 +-
 sound/soc/qcom/storm.c                             |    1 -
 sound/soc/rockchip/Kconfig                         |    2 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            |    4 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |  270 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    4 +-
 sound/soc/rockchip/rockchip_pdm.c                  |    2 +-
 sound/soc/samsung/h1940_uda1380.c                  |    9 -
 sound/soc/samsung/i2s.c                            |   45 +-
 sound/soc/samsung/idma.c                           |    4 +-
 sound/soc/samsung/jive_wm8750.c                    |    2 +-
 sound/soc/samsung/odroid.c                         |   44 +-
 sound/soc/samsung/pcm.c                            |    8 +-
 sound/soc/samsung/rx1950_uda1380.c                 |   10 -
 sound/soc/samsung/s3c-i2s-v2.c                     |   14 +-
 sound/soc/samsung/s3c-i2s-v2.h                     |    7 +
 sound/soc/samsung/s3c2412-i2s.c                    |   15 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   11 +-
 sound/soc/samsung/s3c24xx_simtec.c                 |    2 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |    3 +-
 sound/soc/samsung/smartq_wm8987.c                  |    9 -
 sound/soc/samsung/smdk_spdif.c                     |    2 +-
 sound/soc/samsung/spdif.c                          |    8 +-
 sound/soc/samsung/tm2_wm5110.c                     |    4 +-
 sound/soc/sh/dma-sh7760.c                          |    6 +-
 sound/soc/sh/fsi.c                                 |   12 +-
 sound/soc/sh/migor.c                               |    2 +-
 sound/soc/sh/rcar/adg.c                            |   11 +-
 sound/soc/sh/rcar/core.c                           |  109 +-
 sound/soc/sh/rcar/ctu.c                            |    5 +-
 sound/soc/sh/rcar/dma.c                            |    2 +-
 sound/soc/sh/rcar/dvc.c                            |    5 +-
 sound/soc/sh/rcar/gen.c                            |    4 +-
 sound/soc/sh/rcar/mix.c                            |    5 +-
 sound/soc/sh/rcar/rsnd.h                           |    1 +
 sound/soc/sh/rcar/src.c                            |   14 +-
 sound/soc/sh/rcar/ssi.c                            |  141 +-
 sound/soc/sh/rcar/ssiu.c                           |    2 +-
 sound/soc/sh/siu_dai.c                             |    2 +-
 sound/soc/sh/siu_pcm.c                             |    2 +-
 sound/soc/soc-compress.c                           |   23 +-
 sound/soc/soc-core.c                               |  321 ++-
 sound/soc/soc-jack.c                               |   76 +-
 sound/soc/soc-pcm.c                                |   43 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/spear/spdif_in.c                         |   12 +-
 sound/soc/spear/spdif_out.c                        |    4 +-
 sound/soc/stm/stm32_i2s.c                          |    2 +-
 sound/soc/stm/stm32_sai.c                          |    2 +-
 sound/soc/stm/stm32_spdifrx.c                      |    2 +-
 sound/soc/sunxi/sun4i-codec.c                      |   15 +-
 sound/soc/sunxi/sun4i-i2s.c                        |  455 +++-
 sound/soc/sunxi/sun4i-spdif.c                      |   14 +-
 sound/soc/sunxi/sun8i-codec.c                      |    4 +-
 sound/soc/tegra/Kconfig                            |   42 +-
 sound/soc/tegra/tegra30_ahub.c                     |    4 +-
 sound/soc/tegra/tegra30_i2s.c                      |    2 +-
 sound/soc/tegra/tegra_alc5632.c                    |   14 -
 sound/soc/tegra/tegra_max98090.c                   |   19 -
 sound/soc/tegra/tegra_rt5640.c                     |   14 -
 sound/soc/tegra/tegra_rt5677.c                     |   19 -
 sound/soc/tegra/tegra_sgtl5000.c                   |    1 -
 sound/soc/tegra/tegra_wm8753.c                     |    1 -
 sound/soc/tegra/tegra_wm8903.c                     |    7 -
 sound/soc/tegra/tegra_wm9712.c                     |    1 -
 sound/soc/tegra/trimslice.c                        |    1 -
 sound/soc/txx9/txx9aclc.c                          |    4 +-
 sound/soc/ux500/mop500.c                           |    1 -
 sound/soc/ux500/ux500_msp_dai.c                    |    2 +-
 sound/soc/zte/zx-i2s.c                             |    2 +-
 sound/soc/zte/zx-spdif.c                           |    2 +-
 sound/soc/zte/zx-tdm.c                             |    2 +-
 319 files changed, 10887 insertions(+), 1921 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs43130.txt
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt274.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8524.txt
 create mode 100644 include/sound/rt5663.h
 delete mode 100644 include/sound/rt5677.h
 create mode 100644 sound/soc/codecs/cs43130.c
 create mode 100644 sound/soc/codecs/cs43130.h
 create mode 100644 sound/soc/codecs/rt274.c
 create mode 100644 sound/soc/codecs/rt274.h
 create mode 100644 sound/soc/codecs/wm8524.c
 create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.c
 create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.h
 create mode 100644 sound/soc/intel/skylake/cnl-sst.c

--sqwxdu2jcs5axjok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtSUQACgkQJNaLcl1U
h9C+Cwf7BTwN3x6jENRbGdDpvSG0GoA0AlWYJpI3SYtv9Qmn8Ol++c4mJjPonXlZ
5Z81DAByzagED5h5hFe6yFJZzmcq/D6OMh6aPZdX96K+RrI8t2NExUZql5jBjUv4
iUfa2I8W5/6VRjUsoOCFP+vMfImaxLgFk6FQxVM1LW/tr9SeQMTT36EgxW4s3h99
6cm56d1dCaI6vQI1KKzQwlBCjaVNGOh8kLa3E6RpQwih5alDSC6gKKMiXn5MQZBc
tUYumNzJDqaJso5JOVFAjD2g9RaaugcGBD+T2gFSaDvN/MGefUrngDMvdi6n38zO
8oMHNIsVylAd4n/UzDMu9+BNdzxAcg==
=SCIy
-----END PGP SIGNATURE-----

--sqwxdu2jcs5axjok--

--===============9027978806689254648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9027978806689254648==--
