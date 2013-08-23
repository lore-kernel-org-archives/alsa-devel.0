From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.12
Date: Fri, 23 Aug 2013 12:47:07 +0100
Message-ID: <20130823114707.GA23803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851541216993197606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 891B4265565
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 13:47:14 +0200 (CEST)
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


--===============1851541216993197606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.12

for you to fetch changes up to 43bcb402f84fe459102120b4e2d28d7117f16cd0:

  Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next (2013-08-=
22 14:29:02 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.12

- DAPM is now mandatory for CODEC drivers in order to avoid the repeated
  regressions in the special cases for non-DAPM CODECs and make it
  easier to integrate with other components on boards.  All existing
  drivers have had some level of DAPM support added.
- A lot of cleanups in DAPM plus support for maintaining controls in a
  specific state while a DAPM widget all contributed by Lars-Peter Clausen.
- Core helpers for bitbanged AC'97 reset from Markus Pargmann.
- New drivers and support for Analog Devices ADAU1702 and ADAU1401(a),
  Asahi Kasei Microdevices AK4554, Atmel AT91ASM9x5 and WM8904 based
  machines, Freescale S/PDIF and SSI AC'97, Renesas R-Car SoCs, Samsung
  Exynos5420 SoCs, Texas Instruments PCM1681 and PCM1792A and Wolfson
  Microelectronics WM8997.
- Support for building drivers that can support it cross-platform for
  compile test.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: adav80x: Add module device table for adav801

Bard Liao (1):
      ASoC: rt5640: remove unused mux

Bo Shen (7):
      ASoC: atmel_ssc_dai: move set dma data to startup callback
      ASoC: atmel_ssc_dai: add error mask define
      ASoC: atmel-pcm-dma: move prepare for dma to dai prepare
      ARM: atmel-ssc: change phybase type to dma_addr_t
      ASoC: atmel-pcm: use generic dmaengine framework
      ASoC: wm8904: fix the typo error for LINER Mux
      ASoC: atmel: add wm8904 based audio machine driver

Charles Keepax (6):
      mfd: arizona: Add GPIO control register bit definitions
      ASoC: arizona: Add signal activity output for DRC
      ASoC: arizona: Add default case to silence build warning
      ASoC: wm5110: Correct input OSR bits for wm5110
      ASoC: arizona: Add widget<->mux route into mux route macro
      ASoC: wm8997: Initial CODEC driver

Dan Carpenter (2):
      ASoC: adau1701: type bug with ADAU1707_CLKDIV_UNSET
      ASoC: dapm: using freed pointer in dapm_kcontrol_add_widget()

Daniel Mack (11):
      ARM: pxa: ssp: remove unnecessary warning on kzalloc() failure
      ARM: pxa: ssp: add shortcut for &pdev->dev
      ARM: pxa: ssp: add DT bindings
      ARM: pxa: ssp: use devm_ functions
      ARM: pxa: ssp: add pxa_ssp_request_of()
      ALSA: move dmaengine implementation from ASoC to ALSA core
      ASoC: pxa: pxa-ssp: add DT bindings
      ASoC: pxa: use snd_dmaengine_dai_dma_data
      ASoC: pxa: pxa-ssp: set dma filter data from startup hook
      ASoC: pxa: add DT bindings for pxa2xx-pcm
      ALSA: core: allow SND_DMAENGINE_PCM use from modules

Dimitris Papastamos (4):
      ASoC: core: Add snd_soc_card_get_kcontrol()
      ASoC: wm_adsp: Simplify kcontrol handling
      ASoC: wm0010: Use DMA-safe memory for SPI transfers
      ASoC: wm_adsp: Sanitize parameter passing

Fabio Estevam (11):
      ASoC: sglt5000: Provide the reg_stride field
      ASoC: fsl: fsl_ssi: Use devm_ functions
      ASoC: fsl: fsl_ssi: Check the return value from clk_prepare_enable()
      ASoC: fsl: imx-wm8962: Fix error path
      ASoC: wm8962: Do not call configure_bclk() inside wm8962_set_dai_sysc=
lk()
      ASoC: fsl: fsl_ssi: Add MODULE_ALIAS
      ASoC: fsl: imx-audmux: Check the return value from clk_prepare_enable=
()
      ASoC: fsl: Fix module build
      ASoC: imx-mc13783: Make SND_SOC_IMX_MC13783 visible again
      ASoC: fsl: Drop SND_SOC_FSL_UTILS from i.mx machine code
      ASoC: fsl: fsl_ssi: Fix the order of resources removal

Jean-Francois Moine (1):
      ASoC: kirkwood-i2s: fix a compilation warning

Julia Lawall (5):
      sound/soc/pxa/mioa701_wm9713.c: Avoid using ARRAY_AND_SIZE(e) as a fu=
nction argument
      ASoC: samsung-ac97: simplify use of devm_ioremap_resource
      ASoC: mioa701_wm9713: Remove definition of ARRAY_AND_SIZE()
      ASoC: tegra20-ac97: simplify use of devm_ioremap_resource
      ASoC: omap: simplify platform_get_resource_byname/devm_ioremap_resour=
ce

Kuninori Morimoto (13):
      ASoC: add ak4554 driver
      ASoC: ak4554: add DT support
      ASoC: add Renesas R-Car core feature
      ASoC: add Renesas R-Car module feature
      ASoC: add Renesas R-Car Generation feature
      ASoC: add Renesas R-Car SCU feature
      ASoC: add Renesas R-Car ADG feature
      ASoC: add Renesas R-Car SSI feature
      ASoC: rsnd: remove platform dai and add dai_id on platform setting
      ASoC: rsnd: add common DMAEngine method
      ASoC: rsnd: SSI supports DMA transfer
      ASoC: rsnd: SSI supports DMA transfer via BUSIF
      ASoC: rsnd: scu: cleanup empty functions

Lars-Peter Clausen (28):
      ASoC: Remove unused dapm_get_snd_card() and dapm_get_soc_card()
      ASoC: Build adau1701 when SND_SOC_ALL_CODECS is selected
      ASoC: adau1701: Add adau1702 and adau1401(a) device ids
      ASoC: dapm: Pass snd_soc_card directly to soc_dpcm_runtime_update()
      ASoC: dapm: Run widget updates for shared controls at the same time
      ASoC: dapm: Add a update parameter to snd_soc_dapm_{mux,mixer}_update=
_power
      ASoC: tlv320aic3x: Use snd_soc_dapm_mixer_update_power
      ASoC: lm4857: Use table based setup for DAPM and controls
      ASoC: lm4857: Convert to regmap
      ASoC: dapm: Move snd_soc_dapm_update from dapm context to card
      ASoC: dapm: Pass card instead of dapm context to dapm_power_widgets()
      ASoC: dapm: Add a helper to get the CODEC for DAPM kcontrol
      ASoC: dapm: Wrap kcontrol widget list access
      ASoC: dapm: Move 'value' field from widget to control
      ASoC: dapm: Keep a list of paths per kcontrol
      ASoC: dapm: Make widget power register settings more flexible
      ASoC: dapm: Add snd_soc_dapm_add_path() helper function
      ASoC: dapm: Delay w->power update until the changes are written
      ASoC: bf5xx-ac97: Remove unused extern declaration
      ASoC: dapm: Check return value of snd_soc_cnew()
      ASoC: dapm: Fix kcontrol path list corruption
      ASoC: dapm: Implement mixer input auto-disable
      ASoC: tlv320aic26: Fix keyclick feature
      ASoC: mc13783: Remove embedded snd_soc_codec structs from private dat=
a structs
      ASoC: twl4030: Remove embedded snd_soc_codec structs from private dat=
a structs
      ASoC: Remove unused soc_pm_waitq
      ASoC: Remove unused snd_soc_info_volsw_ext()
      ASoC: Use snd_soc_info_enum_double() for SOC_ENUM_EXT controls

Lothar Wa=DFmann (1):
      ASoC: mxs: add some error messages to help identifying problems

Ma Haijun (1):
      ASoC: wm8960: Fix ADC volume bits

Marek Belisko (1):
      ASoC: Add PCM1681 codec driver.

Mark Brown (169):
      ASoC: codecs: Make ALL_CODECS depend on COMPILE_TEST
      ASoC: pcm3008: Remove noisy version print
      ASoC: pcm3008: Move gpio allocation to probe
      ASoC: pcm3008: Check for platform data
      ASoC: pcm3008: Convert to devm_gpio_request_one()
      ASoC: wm8994: Move runtime PM init to platform device init
      ASoC: kirkwood: Remove unused headers
      ASoC: kirkwood: Enable build on non-Kirkwood platforms
      ASoC: kirkwood-i2s: Use devm_clk_get() for extclk
      ASoC: kirkwood-i2s: Remove empty remove()
      ASoC: kirkwood-i2s: Inline KIRKWOOD_I2S_RATES
      ASoC: tlv320aic3x: Add compatible strings for specific devices
      ASoC: tlv320aic3x: List tlv320aic3106 as a supported device
      ASoC: imx: Enable COMPILE_TEST builds
      ASoC: samsung-spdif: Convert to devm_clk_get()
      ASoC: omap: Enable COMPILE_TEST build for DT platforms
      ASoC: tegra: Remove unneeded mach-type.h incldues
      ASoC: tegra: Add GPIOLIB dependencies
      ASoC: tegra: Always use the generic dmaengine helper library
      ASoC: tegra: Enable COMPILE_TEST builds
      ASoC: imx-mc13783: Depend on ARCH_ARM
      ASoC: pcm: Use the power efficient workqueue for delayed powerdown
      ASoC: jack: Use power efficient workqueue
      ASoC: mxs: Enable COMPILE_TEST builds
      ASoC: max98090: Use power efficient workqueue
      ASoC: sta32x: Use power efficient workqueue
      ASoC: twl6040: Use power efficient workqueue
      ASoC: wm8350: Use power efficient workqueue
      ASoC: wm8753: Use power efficient workqueue
      ASoC: wm8994: Use power efficient workqueue
      ASoC: fsl_ssi: Provide register I/O functions by default
      ASoC: twl6040: Use power efficient workqueue
      ASoC: mxs: Remove unneeded mach-types.h inclusions
      ASoC: wm8962: Use power efficient workqueue
      ASoC: mxs: Depends on COMMON_CLK
      ASoC: dapm: Use generic power check for everything except DAIs
      ASoC: wm8994: Add clock bindings to the device tree
      ASoC: smdk_wm8994: Make driver name more unique
      ASoC: smdk_wm8994: Configure DAI format at init time
      ASoC: smdk_wm8994: Configure the MCLK1 rate based on the board
      Merge branch 'topic/core' of git://git.kernel.org/.../broonie/sound i=
nto asoc-dapm
      ASoC: samsung: Make secondary I2S DAI device a child of primary
      Merge remote-tracking branch 'asoc/topic/pcm1681' into asoc-new-pcm
      ASoC: pcm1792a: Fix build with !OF
      ASoC: wm8994: Fix class W controls
      ASoC: ad1980: Provide stub DAPM support
      ASoC: ads711x: Add DAPM support
      ASoC: dt: Move WM8903 pin list from Tegra board binding to CODEC bind=
ing
      ASoC: pcm1681: Staticise DAI driver
      ASoC: ad73311: Add DAPM support
      ASoC: ad73311: Add to list of of Analog Devices supported CODECs
      ASoC: max9768: Add DAPM support
      ASoC: cs4271: Convert to table based control init
      ASoC: cs4271: Add DAPM support
      ASoC: doc: Add documentation to MAINTAINERS patterns
      ASoC: compress: Use power efficient workqueue
      ASoC: adau1701: Use gpio_set_value_cansleep()
      ASoC: ak4104: Add stub DAPM support
      ASoC: ak4104: Manage TXE using DAPM
      ASoC: ak5386: Add DAPM support
      Merge tag 'v3.11-rc5' into asoc-dapm
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-dapm
      ASoC: dapm: Don't create routes when creating kcontrols
      ASoC: dapm: Ensure kcontrol list is initialised
      ASoC: dt: Move WM8753 pin list from Tegra board binding to CODEC bind=
ing
      ASoC: dt: Move RT5640 pin list from Tegra board binding to CODEC bind=
ing
      ASoC: dt: Move ALC5632 pin list from Tegra board binding to CODEC bin=
ding
      ASoC: wm8753: Fix typo in DT binding example
      ASoC: ak4554: Add DAPM support
      ASoC: max9877: Convert to use regmap API
      ASoC: max9877: Convert to standard CODEC driver
      ASoC: max9877: Add basic DAPM support
      Merge branch 'topic/dma' of git://git.kernel.org/.../broonie/sound in=
to asoc-pxa
      ASoC: pcm1792a: Remove empty capture DAI stub
      ASoC: pcm1792a: Add DAPM support
      ASoC: pcm1681: Add DAPM support
      Merge branch 'topic/dma' of git://git.kernel.org/.../broonie/sound in=
to asoc-omap
      Merge branch 'topic/dma' of git://git.kernel.org/.../broonie/sound in=
to asoc-omap
      ASoC: samsung: Fix DTS breakage from missing dependencies
      ASoC: tlv320aic26: Remove direct use of internal I/O functions
      ASoC: tlv320aic26: Remove noisy print
      ASoC: tlv320aic26: Add basic DAPM support
      ASoC: si476x: Add DAPM support
      ASoC: pcm3008: Use gpio_set_value_cansleep()
      ASoC: pcm3008: Add DAPM support
      ASoC: pcm3008: Manage DAC and ADC power with DAPM
      ASoC: wl1273: Add stub DAPM support
      ASoC: cs4270: Add DAPM support
      ASoC: wm8727: Add DAPM support
      ASoC: wm8782: Add DAPM support
      ASoC: wm5102: Add inputs for noise and mic mixers
      ASoC: wm5110: Add inputs for noise and mic mixers
      ASoC: wm8997: Add inputs for noise and mic mixers
      ASoC: ac97: Provide stub DAPM integration
      ASoC: hdmi: Provide stub DAPM integration
      ASoC: bt-sco: Add generic compatible string
      ASoC: bt-sco: Provide stub DAPM integration
      ASoC: spdif: Add stub DAPM widgets for Rx
      ASoC: spdif: Remove duplicate const
      ASoC: imx: Add MODULE_LICENSE to DMA drivers
      ASoC: samsung: Check to see if we managed to allocate a channel
      ASoC: samsung: Rename DMA platform registration functions
      Merge remote-tracking branch 'asoc/topic/ac97' into asoc-fsl
      Merge remote-tracking branch 'asoc/fix/wm8960' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/ac97' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ad1980' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ad73311' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adau1701' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adav80x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ads711x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak4104' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak4554' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak5386' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/au1x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/blackfin' into asoc-next
      Merge remote-tracking branch 'asoc/topic/bt' into asoc-next
      Merge remote-tracking branch 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4270' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ep93xx' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/hdmi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branch 'asoc/topic/lm4857' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max9768' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max9877' into asoc-next
      Merge remote-tracking branch 'asoc/topic/mc13783' into asoc-next
      Merge remote-tracking branch 'asoc/topic/mxs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/new-pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/nuc900' into asoc-next
      Merge remote-tracking branch 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1681' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1792a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3008' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5640' into asoc-next
      Merge remote-tracking branch 'asoc/topic/s6000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sgtl5000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/si476x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/spdif' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sta32x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320aic26' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl4030' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl6040' into asoc-next
      Merge remote-tracking branch 'asoc/topic/txx9' into asoc-next
      Merge remote-tracking branch 'asoc/topic/uda134x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wl1273' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm0010' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8350' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8727' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8731' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8753' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8782' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8904' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8960' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next

Markus Pargmann (10):
      ASoC: imx-pcm-dma: DT support
      ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
      ASoC: fsl: Move fsl-ssi binding doc to sound/
      ASoC: imx-audmux: Read default configuration from devicetree
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ASoC: imx-audmux: default configuration parser fixups
      ASoC: imx-audmux: Move definitions to dt-bindings
      ASoC: core: Generic ac97 link reset functions
      ASoC: fsl-ssi: ac97-slave support

Michael Grzeschik (2):
      ASoC: fsl-ssi: imx-pcm-fiq bugfix
      ASoC: fsl: disable ssi irq for imx

Michael Trimarchi (2):
      ASoC: omap-mcbsp: Support SND_SOC_DAIFMT_CBM_CFS for omap3/4
      ASoC: Add PCM1792A spi mode codec support

Mike Dyer (1):
      ASoC: wm8960: Fix PLL register writes

Nicolas Ferre (1):
      ASoC: atmel: machine driver for at91sam9x5-wm8731 boards

Nicolin Chen (4):
      ASoC: fsl: Disable SSI in trigger() if RE/TE are both cleared
      ASoC: fsl: Set sdma peripheral type directly
      ASoC: spdif: Add S20_3LE and S24_LE support for dummy codec drivers
      ASoC: fsl: Add S/PDIF CPU DAI driver

Oskar Schirmer (1):
      ASoC: sgtl5000: fix codec clock source transition to avoid clockless =
moment

Padmavathi Venna (6):
      ASoC: Samsung: I2S: Modify driver to give more flexibility
      ASoC: Samsung: I2S: Add quirks as driver data in I2S
      ASoC: Samsung: I2S: Modify the I2S driver to support I2S on Exynos5420
      ARM: dts: exynos5250: move common i2s properties to exynos5 dtsi
      ARM: dts: Change i2s compatible string on exynos5250
      ARM: dts: Change i2s compatible string on exynos5250

Peter Ujfalusi (1):
      ASoC: omap-abe-twl6040: Remove support for pdata (legacy boot)

Richard Fitzgerald (1):
      ASoC: core: init delayed_work for codec-codec links

Richard Genoud (2):
      ASoC: wm8731: add rates constraints
      ASoC: atmel: update atmel SSC with DMA binding

Rongjun Ying (1):
      ASoC: hdmi-codec: let the driver support HDMI sink

Russell King (8):
      ASoC: uda134x: fix codec driver by converting to DAPM
      ASoC: spdif_transceiver: add output pin widget
      ASoC: kirkwood: merge struct kirkwood_dma_priv with struct kirkwood_d=
ma_data
      ASoC: kirkwood: Free external clock if it is a duplicate of internal
      ASoC: avoid duplicated DAI routes
      ASoC: kirkwood: provide KIRKWOOD_PLAYCTL_ENABLE_MASK
      ASoC: kirkwood: combine kirkwood-i2s and kirkwood-dma drivers
      ASoC: kirkwood: move calculation of max buffer size to kirkwood.h

Sachin Kamat (2):
      ASoC: s6105-ipcam: Fix incorrect placement of __initdata
      ASoC: pxa: Remove duplicate inclusion of dmaengine.h

Steffen Trumtrar (1):
      ASoC: fsl-ssi: add SSIEN errata work around

Stephen Warren (2):
      ASoC: tegra: fix compile warning in AC'97 driver
      ASoC: tegra: support a Mic Jack in the Tegra+RT5640 machine driver

Tushar Behera (1):
      ASoC: samsung: Fix build error with dma function rename

Vinod Koul (1):
      ASoC: compress: use soc_xxx handlers for metadata

Wei Yongjun (7):
      ASoC: db1200: add .owner to struct snd_soc_card
      ASoC: imx_mc13783: add .owner to struct snd_soc_card
      ASoC: brownstone: add .owner to struct snd_soc_card
      ASoC: ttc_dkb: add .owner to struct snd_soc_card
      ASoC: mop500: add .owner to struct snd_soc_card
      ASoC: imx-sgtl5000: fix error return code in imx_sgtl5000_probe()
      ASoC: rcar: fix return value check in rsnd_gen1_probe()

Wolfram Sang (5):
      ASoC: au1x: don't check resource with devm_ioremap_resource
      ASoC: ep93xx: don't check resource with devm_ioremap_resource
      ASoC: nuc900: don't check resource with devm_ioremap_resource
      ASoC: pxa: don't check resource with devm_ioremap_resource
      ASoC: txx9: don't check resource with devm_ioremap_resource

 .../devicetree/bindings/misc/atmel-ssc.txt         |   23 +-
 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |   65 +
 Documentation/devicetree/bindings/sound/ak4554.c   |   11 +
 .../devicetree/bindings/sound/alc5632.txt          |   19 +
 .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   35 +
 .../devicetree/bindings/sound/atmel-wm8904.txt     |   55 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |   54 +
 .../{powerpc/fsl/ssi.txt =3D> sound/fsl,ssi.txt}     |   12 +
 .../devicetree/bindings/sound/imx-audmux.txt       |    9 +
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |   28 +
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt  |   15 +
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |   24 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |   26 +-
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |   27 +-
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   |   24 +-
 .../devicetree/bindings/sound/pcm1792a.txt         |   18 +
 Documentation/devicetree/bindings/sound/rt5640.txt |   20 +
 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 +-
 .../devicetree/bindings/sound/soc-ac97link.txt     |   28 +
 .../devicetree/bindings/sound/ti,pcm1681.txt       |   15 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    9 +-
 Documentation/devicetree/bindings/sound/wm8731.txt |    9 +
 Documentation/devicetree/bindings/sound/wm8753.txt |   24 +-
 Documentation/devicetree/bindings/sound/wm8903.txt |   19 +
 Documentation/devicetree/bindings/sound/wm8994.txt |    4 +
 MAINTAINERS                                        |    2 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    9 +-
 arch/arm/mach-dove/common.c                        |    4 +-
 arch/arm/mach-kirkwood/common.c                    |   24 +-
 arch/arm/plat-pxa/ssp.c                            |  171 ++-
 include/dt-bindings/sound/fsl-imx-audmux.h         |   56 +
 include/linux/atmel-ssc.h                          |    2 +-
 include/linux/mfd/arizona/gpio.h                   |   96 ++
 include/linux/platform_data/asoc-s3c.h             |    1 +
 include/linux/platform_data/omap-abe-twl6040.h     |   49 -
 include/linux/pxa2xx_ssp.h                         |   11 +
 include/sound/pxa2xx-lib.h                         |    7 -
 include/sound/rcar_snd.h                           |   84 ++
 include/sound/soc-dapm.h                           |  199 ++--
 include/sound/soc-dpcm.h                           |    2 +-
 include/sound/soc.h                                |   39 +-
 sound/arm/pxa2xx-ac97.c                            |   26 +-
 sound/arm/pxa2xx-pcm-lib.c                         |   52 +-
 sound/arm/pxa2xx-pcm.c                             |    5 +-
 sound/arm/pxa2xx-pcm.h                             |    6 +-
 sound/core/Kconfig                                 |    3 +
 sound/core/Makefile                                |    3 +
 .../soc-dmaengine-pcm.c =3D> core/pcm_dmaengine.c}   |    0
 sound/soc/Kconfig                                  |    5 +-
 sound/soc/Makefile                                 |    4 -
 sound/soc/atmel/Kconfig                            |   21 +
 sound/soc/atmel/Makefile                           |    4 +
 sound/soc/atmel/atmel-pcm-dma.c                    |  118 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   36 +-
 sound/soc/atmel/atmel_wm8904.c                     |  254 ++++
 sound/soc/atmel/sam9x5_wm8731.c                    |  208 ++++
 sound/soc/au1x/db1200.c                            |    4 +
 sound/soc/au1x/psc-ac97.c                          |    3 -
 sound/soc/blackfin/bf5xx-ac97.h                    |    1 -
 sound/soc/cirrus/ep93xx-ac97.c                     |    3 -
 sound/soc/cirrus/ep93xx-i2s.c                      |    3 -
 sound/soc/codecs/Kconfig                           |   19 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/ac97.c                            |   15 +
 sound/soc/codecs/ad1980.c                          |   43 +
 sound/soc/codecs/ad73311.c                         |   22 +-
 sound/soc/codecs/adau1701.c                        |   25 +-
 sound/soc/codecs/adav80x.c                         |   13 +-
 sound/soc/codecs/ads117x.c                         |   29 +-
 sound/soc/codecs/ak4104.c                          |   34 +-
 sound/soc/codecs/ak4554.c                          |  106 ++
 sound/soc/codecs/ak5386.c                          |   17 +-
 sound/soc/codecs/arizona.c                         |   69 +-
 sound/soc/codecs/arizona.h                         |    5 +-
 sound/soc/codecs/bt-sco.c                          |   22 +-
 sound/soc/codecs/cs4270.c                          |   20 +
 sound/soc/codecs/cs4271.c                          |   30 +-
 sound/soc/codecs/hdmi.c                            |   30 +-
 sound/soc/codecs/lm4857.c                          |  107 +-
 sound/soc/codecs/max9768.c                         |   16 +
 sound/soc/codecs/max98090.c                        |   10 +-
 sound/soc/codecs/max9877.c                         |  294 ++---
 sound/soc/codecs/mc13783.c                         |    1 -
 sound/soc/codecs/pcm1681.c                         |  339 ++++++
 sound/soc/codecs/pcm1792a.c                        |  257 ++++
 sound/soc/codecs/pcm1792a.h                        |   26 +
 sound/soc/codecs/pcm3008.c                         |  150 ++-
 sound/soc/codecs/rt5640.c                          |   26 -
 sound/soc/codecs/sgtl5000.c                        |   10 +-
 sound/soc/codecs/si476x.c                          |   14 +
 sound/soc/codecs/spdif_receiver.c                  |   17 +-
 sound/soc/codecs/spdif_transmitter.c               |   18 +-
 sound/soc/codecs/sta32x.c                          |   10 +-
 sound/soc/codecs/tlv320aic26.c                     |   51 +-
 sound/soc/codecs/tlv320aic3x.c                     |   56 +-
 sound/soc/codecs/twl4030.c                         |    2 -
 sound/soc/codecs/twl6040.c                         |    7 +-
 sound/soc/codecs/uda134x.c                         |   88 +-
 sound/soc/codecs/wl1273.c                          |   17 +
 sound/soc/codecs/wm0010.c                          |   12 +-
 sound/soc/codecs/wm5102.c                          |   53 +-
 sound/soc/codecs/wm5110.c                          |   35 +-
 sound/soc/codecs/wm8350.c                          |    6 +-
 sound/soc/codecs/wm8727.c                          |   17 +-
 sound/soc/codecs/wm8731.c                          |   60 +-
 sound/soc/codecs/wm8753.c                          |    5 +-
 sound/soc/codecs/wm8782.c                          |   17 +-
 sound/soc/codecs/wm8903.c                          |    4 +-
 sound/soc/codecs/wm8904.c                          |    2 +-
 sound/soc/codecs/wm8960.c                          |   10 +-
 sound/soc/codecs/wm8962.c                          |    7 +-
 sound/soc/codecs/wm8994.c                          |   39 +-
 sound/soc/codecs/wm8995.c                          |    5 +-
 sound/soc/codecs/wm8997.c                          | 1175 ++++++++++++++++=
+++
 sound/soc/codecs/wm8997.h                          |   23 +
 sound/soc/codecs/wm_adsp.c                         |  124 +-
 sound/soc/codecs/wm_adsp.h                         |    3 +-
 sound/soc/codecs/wm_hubs.c                         |    8 +-
 sound/soc/fsl/Kconfig                              |   13 +-
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl_spdif.c                          | 1236 ++++++++++++++++=
++++
 sound/soc/fsl/fsl_spdif.h                          |  191 +++
 sound/soc/fsl/fsl_ssi.c                            |  500 ++++++--
 sound/soc/fsl/imx-audmux.c                         |   78 +-
 sound/soc/fsl/imx-audmux.h                         |   52 +-
 sound/soc/fsl/imx-mc13783.c                        |    1 +
 sound/soc/fsl/imx-pcm-dma.c                        |    4 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |   20 +-
 sound/soc/fsl/imx-pcm.h                            |   26 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    4 +-
 sound/soc/fsl/imx-ssi.c                            |   11 +-
 sound/soc/fsl/imx-ssi.h                            |    1 +
 sound/soc/fsl/imx-wm8962.c                         |    3 +-
 sound/soc/kirkwood/Kconfig                         |   11 +-
 sound/soc/kirkwood/Makefile                        |    4 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |  108 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   67 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |    6 +-
 sound/soc/kirkwood/kirkwood-t5325.c                |    6 +-
 sound/soc/kirkwood/kirkwood.h                      |   11 +-
 sound/soc/mxs/Kconfig                              |    3 +-
 sound/soc/mxs/mxs-saif.c                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   30 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    3 -
 sound/soc/omap/Kconfig                             |    8 +-
 sound/soc/omap/omap-abe-twl6040.c                  |  133 +--
 sound/soc/omap/omap-dmic.c                         |    9 +-
 sound/soc/omap/omap-mcbsp.c                        |    5 +
 sound/soc/omap/omap-mcpdm.c                        |    3 -
 sound/soc/pxa/Kconfig                              |    2 +-
 sound/soc/pxa/brownstone.c                         |    1 +
 sound/soc/pxa/mioa701_wm9713.c                     |    7 +-
 sound/soc/pxa/mmp-pcm.c                            |    7 +-
 sound/soc/pxa/mmp-sspa.c                           |   15 +-
 sound/soc/pxa/pxa-ssp.c                            |   76 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   67 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |   28 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |   21 +-
 sound/soc/pxa/ttc-dkb.c                            |    1 +
 sound/soc/s6000/s6105-ipcam.c                      |    2 +-
 sound/soc/samsung/ac97.c                           |   11 +-
 sound/soc/samsung/dma.c                            |   12 +-
 sound/soc/samsung/dma.h                            |    4 +-
 sound/soc/samsung/i2s-regs.h                       |   51 +-
 sound/soc/samsung/i2s.c                            |  193 ++-
 sound/soc/samsung/pcm.c                            |    4 +-
 sound/soc/samsung/s3c2412-i2s.c                    |    4 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    4 +-
 sound/soc/samsung/smdk_wm8994.c                    |   58 +-
 sound/soc/samsung/spdif.c                          |   12 +-
 sound/soc/sh/Kconfig                               |    7 +
 sound/soc/sh/Makefile                              |    3 +
 sound/soc/sh/rcar/Makefile                         |    2 +
 sound/soc/sh/rcar/adg.c                            |  234 ++++
 sound/soc/sh/rcar/core.c                           |  861 ++++++++++++++
 sound/soc/sh/rcar/gen.c                            |  280 +++++
 sound/soc/sh/rcar/rsnd.h                           |  302 +++++
 sound/soc/sh/rcar/scu.c                            |  236 ++++
 sound/soc/sh/rcar/ssi.c                            |  728 ++++++++++++
 sound/soc/soc-compress.c                           |   13 +-
 sound/soc/soc-core.c                               |  236 +++-
 sound/soc/soc-dapm.c                               |  810 +++++++------
 sound/soc/soc-jack.c                               |    2 +-
 sound/soc/soc-pcm.c                                |   15 +-
 sound/soc/spear/Kconfig                            |    2 +-
 sound/soc/tegra/Kconfig                            |   14 +-
 sound/soc/tegra/tegra20_ac97.c                     |    8 -
 sound/soc/tegra/tegra_alc5632.c                    |    2 -
 sound/soc/tegra/tegra_rt5640.c                     |    1 +
 sound/soc/tegra/tegra_wm8753.c                     |    2 -
 sound/soc/tegra/trimslice.c                        |    2 -
 sound/soc/txx9/txx9aclc-ac97.c                     |    3 -
 sound/soc/ux500/mop500.c                           |    1 +
 193 files changed, 10275 insertions(+), 2357 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/ak4554.c
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9x5-wm=
8731-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-wm8904.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt =3D> sound/f=
sl,ssi.txt} (87%)
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
 create mode 100644 include/dt-bindings/sound/fsl-imx-audmux.h
 create mode 100644 include/linux/mfd/arizona/gpio.h
 delete mode 100644 include/linux/platform_data/omap-abe-twl6040.h
 create mode 100644 include/sound/rcar_snd.h
 rename sound/{soc/soc-dmaengine-pcm.c =3D> core/pcm_dmaengine.c} (100%)
 create mode 100644 sound/soc/atmel/atmel_wm8904.c
 create mode 100644 sound/soc/atmel/sam9x5_wm8731.c
 create mode 100644 sound/soc/codecs/ak4554.c
 create mode 100644 sound/soc/codecs/pcm1681.c
 create mode 100644 sound/soc/codecs/pcm1792a.c
 create mode 100644 sound/soc/codecs/pcm1792a.h
 create mode 100644 sound/soc/codecs/wm8997.c
 create mode 100644 sound/soc/codecs/wm8997.h
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/sh/rcar/Makefile
 create mode 100644 sound/soc/sh/rcar/adg.c
 create mode 100644 sound/soc/sh/rcar/core.c
 create mode 100644 sound/soc/sh/rcar/gen.c
 create mode 100644 sound/soc/sh/rcar/rsnd.h
 create mode 100644 sound/soc/sh/rcar/scu.c
 create mode 100644 sound/soc/sh/rcar/ssi.c

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF0u4AAoJELSic+t+oim9tA4P/jONHYQQp0ALiRuxPhf8Y2dl
PCNEzKPn88A5mKB/ndCRZ0El2A5FY9EFj0k7JrZKmR7ubdClwp0u41SUb2bVRhVV
GTWUC3f/zF/phaW/lOjz5sh6Y7H6CCh4xEpania5gvpiOQ0jOqfQf2lg3V19o0le
nfj4p+u0+Fwdn9Vj9yMhwGA3HLCh//XUiGWQeW7O2jYojtvDAIueJqE26v99LVqj
W6d1tBlz3r7SbCqKgaVcyZQvlLC9DHDSYNO6KU+fvGDE/4bcIQEcfCiWVocEa56F
Li367y3o12he8omYb+0fx11uno82FP5tb7y1P2oSj5s01TZMWu4Xgd3YKVq9p59V
oUu/YZBDa8MmENZ84IijWpHdgsVZDz9DSjvTmoKl7419/fM95mxqvJdsENSSHqHW
7dNyppDcxWgbibleZZoD0zk3Pi9ermLt+INzLgHQ9RhkJ4+hRTrpr6XFS9ggC0M9
i8aS2KsulB5H+9oh2j3yIFf7nPJzg8fW/2eRlPbqaSnxETsG69dl9rLTYf4uvf1a
J3bDRPj8B4lt9j8jAVELlhJok7d+hb8BEBorhJ29FlDi9CTTKcWysvUcaOrsZaL1
TvdN+rA/MuEIWNYS8XCA90w0tjEofeptca85uHMvuRuraH3EtOsUZw7bwkM6UUnW
k4mBhcwTlwy5hB5Lt8yD
=pyvS
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============1851541216993197606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1851541216993197606==--
