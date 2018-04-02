From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.17
Date: Mon, 2 Apr 2018 16:50:47 +0100
Message-ID: <20180402155047.GS29239@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4392788425411069903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 456692673A2
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 17:50:49 +0200 (CEST)
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


--===============4392788425411069903==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Content-Disposition: inline


--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.17

for you to fetch changes up to 445bb423f6a3c50788529a33b82e45148001e855:

  Merge remote-tracking branch 'asoc/topic/zx_aud96p22' into asoc-next (201=
8-03-28 10:32:03 +0800)

----------------------------------------------------------------
ASoC: Updates for v4.17

This is a *very* big release for ASoC.  Not much change in the core but
there s the transition of all the individual drivers over to components
which is intended to support further core work.  The goal is to make it
easier to do further core work by removing the need to special case all
the different driver classes in the core, many of the devices end up
being used in multiple roles in modern systems.

We also have quite a lot of new drivers added this month of all kinds,
quite a few for simple devices but also some more advanced ones with
more substantial code.

 - The biggest thing is the huge series from Morimoto-san which
   converted everything over to components.  This is a huge change by
   code volume but was fairly mechanical
 - Many fixes for some of the Realtek based Baytrail systems covering
   both the CODECs and the CPUs, contributed by Hans de Goode.
 - Lots of cleanups for Samsung based Odroid systems from Sylwester
   Nawrocki.
 - The Freescale SSI driver also got a lot of cleanups from Nicolin
   Chen.
 - The Blackfin drivers have been removed as part of the removal of the
   architecture.
 - New drivers for AKM AK4458 and AK5558, several AMD based machines,
   several Intel based machines, Maxim MAX9759, Motorola CPCAP,
   Socionext Uniphier SoCs, and TI PCM1789 and TDA7419

----------------------------------------------------------------

I might have some more fixes to come, I was at Linaro Connect and then
on holiday for a week so I've got a bunch of e-mail to trawl through but
I wanted to get this out promptly.

Abhijeet Kumar (4):
      ALSA: hda: Copying sync power state helper to core
      ALSA: hda: Make use of core codec functions to sync power state
      ASoC: hdac_hdmi : Ensuring proper setting of output widget power state
      ASoC: Intel: Skylake: Fix typo

Adam Thomson (2):
      ASoC: da7219: Add common clock usage for providing DAI clks
      ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK

Akshu Agrawal (5):
      ASoC: AMD: Add machine driver for ST DA7219 MAX98357
      ASoC: dwc: Extends DW_I2S_QUIRK_COMP_PARAM1 to playback
      ASoC: ADAU7002: Adding ACPI id
      ASoC: amd: Use single dai for da7219 playback and capture
      ASoC: amd: Enable da7219 master clock using common clock framework

Arnd Bergmann (1):
      ASoC: remove blackfin drivers

Bard Liao (6):
      ASoC: rt5665: remove rt5668 support
      ASoC: rt5659: fix wrong bit define for ADC L2 power.
      ASoC: rt5659: fix wrong control register for ADC2 power
      ASoC: rt5659: Separate adc 1/2 clock control
      ASoC: rt286: don't turn off HV and VREF if headset is detected
      ASoC: rt298: don't turn off HV and VREF if headset is detected

Charles Keepax (2):
      ASoC: arizona: Fixup some minor formatting issues
      ASoC: wm_adsp: Support streams which can start/stop with DSP active

Colin Ian King (7):
      ASoC: Intel: Skylake: make function skl_clk_round_rate static
      ASoC: uniphier: remove redundant check of blk_id
      ASoC: TSCS42xx: make const array norm_addrs static, reduces object co=
de size
      ASoC: sirf: remove duplicated bit-wise or of USP_RXFIFO_THD_INT
      ASoC: pxa: remove duplicated bit-wise or of SNDRV_PCM_FMTBIT_S24_LE
      ASoC: cygnus: remove redundant assignment to pointer 'res'
      ASoC: da7219: make structure da7219_dai_clks_ops static

Corentin Labbe (2):
      ASoC: samsung: clean makefile about inexistant files
      ASoC: sn95031: remove dead makefile about sn95031

Cosmin-Gabriel Samoila (4):
      ASoC: ak4458: Add support for AK4458 DAC driver
      ASoC: ak4458: Add bindings for AK4458 DAC
      ASoC: ak4458: Modify SPDX license format
      ASoC: ak4458: Sort headers alphabetically

Dan Carpenter (1):
      ASoC: uniphier: fix an error code in uniphier_aio_comprdma_new()

Daniel Baluta (3):
      ASoC: ak5558: Add support for AK5558 ADC driver
      ASoC: ak5558: Add bindings for AK5558 ADC
      ASoC: ak5558: Fix style for SPDX identifier

Ezequiel Garcia (3):
      ASoC: rockchip: Fix dai_name for HDMI codec
      ASoC: rockchip: Fix compatible string in example
      ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

Fabio Estevam (17):
      ASoC: fsl-asoc-card: Use 'snd_pcm_format_t' type when appropriate
      ASoC: fsl_esai: Use 'const _be *' type for iprop
      ASoC: fsl_utils: Use 'const _be *' type for iprop
      ASoC: fsl_ssi: Use 'const _be *' type for iprop
      ASoC: wm9712: Use empty struct initializer
      ASoC: tlv320aic3x: Use empty struct initializer
      ASoC: adau17x1: Use empty struct initializer
      ASoC: wm9713: Use empty struct initializer
      ASoC: soc-dapm: Use empty struct initializer
      ASoC: soc-generic-dmaengine-pcm: Add a DMA debugfs_prefix entry
      ASoC: soc-generic-dmaengine-pcm: Fix error handling
      ASoC: soc-generic-dmaengine-pcm: Fix sparse warnings
      ASoC: Revert "ASoC: soc-generic-dmaengine-pcm: Fix error handling"
      ASoC: imx-wm8962: Remove machine driver
      ASoC: wm8524: Remove unit address
      ASoC: sgtl5000: Pass the required '#sound-dai-cells'
      ASoC: tscs42xx: Remove owner assignment from i2c_driver

Geert Uytterhoeven (3):
      ASoC: rt5514: Fix rt5514_spi_burst_read() buffer passing
      ASoC: rt5514: Fix uninitialized calibration value
      ASoC: rsnd: Document R-Car M3-W support

Guneshwor Singh (1):
      ASoC: Intel: Skylake: Refine skl widget type check

Hans de Goede (45):
      ASoC: Intel: sst: Fix error-code check in sst_pause_stream()
      ASoC: Intel: sst: Remove 2 unused members from stream_info struct
      ASoC: Intel: sst: Remove unnecessary sst_init_stream() function
      ASoC: Intel: sst: Remove unused STREAM_DECODE and STREAM_RESET states
      ASoC: Intel: sst: Add sst_realloc_stream() function
      ASoC: Intel: sst: Free streams on suspend, re-alloc on resume
      ASoC: rt5651: Remove unused rt5651_platform_data
      ASoC: rt5651: Move all jack-detect initialization to rt5651_set_jack_=
detect
      ASoC: rt5651: Move 2 functions higher up in rt5651.c
      ASoC: rt5651: Use standard component set_jack callback
      ASoC: rt5651: Add rt5651_apply_properties() helper function
      ASoC: rt5651: Remove is_sys_clk_from_pll()
      ASoC: rt5651: Fix bias_level confusion
      ASoC: rt5651: Do not modify the LDO voltage control bits from set_bia=
s_level()
      ASoC: rt5651: Do not modify jd and PLL power bits from set_bias_level=
()
      ASoC: rt5651: Remove programming of PWR regs before force_bias_level(=
) call
      ASoC: rt5651: Only configure LDO voltage once at boot
      ASoC: rt5651: Remove "JD Power" dapm supply
      ASoC: rt5651: Enable LDO and micbias1 supplies for jack-type detection
      ASoC: rt5651: Only configure OVCD once at set_jack time
      ASoC: rt5651: Always keep OVCD enabled
      ASoC: rt5651: Make rt5651_apply_properties() private
      ASoC: rt5651: Add devicetree-bindings for jack-detect
      ASoC: rt5651: Configure jack-detect source through a device-property
      ASoC: rt5651: Allow specifying over-current threshold through a devic=
e-property
      ASoC: rt5651: Allow specifying the OVCD scale-factor through a device=
-property
      ASoC: rt5651: Enable sticky mode for OVCD
      ASoC: rt5651: Enable Platform Clock during jack-type detect
      ASoC: rt5651: Add rt5651_jack_inserted() helper
      ASoC: rt5651: Rewrite jack-type detection
      ASoC: Intel: bytcr_rt5651: Not being able to find the codec ACPI-dev =
is an error
      ASoC: Intel: bytcr_rt5651: Pass jack-src info via device-properties
      ASoC: Intel: bytcr_rt5651: Actually honor the DMIC_EN quirk if specif=
ied
      ASoC: Intel: bytcr_rt5651: Only create jack if we have a jack-detect =
source
      ASoC: Intel: bytcr_rt5651: Add quirk micbias OVCD configuration
      ASoC: Intel: bytcr_rt5651: Configure PLL1 before using it
      ASoC: Intel: bytcr_rt5651: Drop snd_soc_dai_set_bclk_ratio() call
      ASoC: Intel: bytcr_rt5651: Rename IN3_MAP to IN1_HS_IN3_MAP
      ASoC: Intel: bytcr_rt5651: Add new IN2_HS_IN3 input map and a quirk u=
sing it
      ASoC: Intel: bytcr_rt5651: Add support for Bay Trail CR / SSP0 using =
boards
      ASoC: Intel: bytcr_rt5651: Add quirk for the VIOS LTH17 laptop
      ASoC: Intel: bytcr_rt5651: Change defaults to enable jack-detect, ana=
log mics
      ASoC: Intel: bytcr_rt5651: Select RCCLK on init()
      ASoC: rt5651: move definitions of dt-binding constants to include/dt-=
bindings
      ASoC: rt5651: Fix jack-dectect typo in the dt-bindings documentation

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default

John Hsu (3):
      ASoC: Intel: add nau8824 sound card
      ASoC: Intel: fix argument error in nau8824 machine
      ASoC: nau8824: recover system clock when device changes

Katsuhiro Suzuki (15):
      ASoC: uniphier: add DT bindings documentation for UniPhier AIO
      ASoC: uniphier: add support for UniPhier AIO common driver
      ASoC: uniphier: add support for UniPhier AIO DMA driver
      ASoC: uniphier: add support for UniPhier AIO CPU DAI driver
      ASoC: uniphier: add support for UniPhier AIO compress audio
      ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver
      ASoC: uniphier: evea: fix typo 'eva' -> 'evea'
      ASoC: uniphier: evea: fix lisence comment style
      ASoC: uniphier: fix broken sound if use SRC in replay
      ASoC: add DT bindings documentation for ROHM BD28623 codec
      ASoC: support ROHM BD28623 codec
      ASoC: uniphier: add support for UniPhier PXs2 AIO
      ASoC: uniphier: evea: add switch for changing source of line-in
      ASoC: uniphier: add syscon property to binding document
      ASoC: uniphier: add syscon property for UniPhier sound system

Krzysztof Kozlowski (1):
      ASoC: samsung: Mark unused Odroid compatibles as deprecated

Kuninori Morimoto (243):
      ASoC: ac97: replace codec to component
      ASoC: wm0010: replace codec to component
      ASoC: wm8804: replace codec to component
      ASoC: cs4271: replace codec to component
      ASoC: wm2000: replace codec to component
      ASoC: wm2200: replace codec to component
      ASoC: wm5100: replace codec to component
      ASoC: wm8350: replace codec to component
      ASoC: wm8400: replace codec to component
      ASoC: wm8580: replace codec to component
      ASoC: wm8524: replace codec to component
      ASoC: wm8510: replace codec to component
      ASoC: wm8523: replace codec to component
      ASoC: wm8711: replace codec to component
      ASoC: wm8750: replace codec to component
      ASoC: wm8737: replace codec to component
      ASoC: wm8776: replace codec to component
      ASoC: wm8770: replace codec to component
      ASoC: wm8727: replace codec to component
      ASoC: wm8731: replace codec to component
      ASoC: wm8782: replace codec to component
      ASoC: wm8728: replace codec to component
      ASoC: wm8741: replace codec to component
      ASoC: wm8753: replace codec to component
      ASoC: wm8900: replace codec to component
      ASoC: wm8903: replace codec to component
      ASoC: wm8955: replace codec to component
      ASoC: wm8960: replace codec to component
      ASoC: wm8985: replace codec to component
      ASoC: wm8971: replace codec to component
      ASoC: wm8978: replace codec to component
      ASoC: wm8974: replace codec to component
      ASoC: wm8990: replace codec to component
      ASoC: wm8988: replace codec to component
      ASoC: wm8983: replace codec to component
      ASoC: wm8962: replace codec to component
      ASoC: wm8996: replace codec to component
      ASoC: wm8991: replace codec to component
      ASoC: wm8995: replace codec to component
      ASoC: wm8961: replace codec to component
      ASoC: wm8940: replace codec to component
      ASoC: wm8904: replace codec to component
      ASoC: wm9081: replace codec to component
      ASoC: wm9090: replace codec to component
      ASoC: wm9867: replace codec to component
      ASoC: wm1250-ev1: replace codec to component
      ASoC: ak4613: replace codec to component
      ASoC: ak4642: replace codec to component
      ASoC: ak5386: replace codec to component
      ASoC: ak4671: replace codec to component
      ASoC: ak4104: replace codec to component
      ASoC: ak4535: replace codec to component
      ASoC: ak4641: replace codec to component
      ASoC: ak4554: replace codec to component
      ASoC: rt274: replace codec to component
      ASoC: rt5616: replace codec to component
      ASoC: rt5640: replace codec to component
      ASoC: rt5651: replace codec to component
      ASoC: rt5514: replace codec to component
      ASoC: rt5659: replace codec to component
      ASoC: rt5670: replace codec to component
      ASoC: rt5660: replace codec to component
      ASoC: rt5631: replace codec to component
      ASoC: rt5665: replace codec to component
      ASoC: cs4270: replace codec to component
      ASoC: cs4349: replace codec to component
      ASoC: cs4265: replace codec to component
      ASoC: cs35l32: replace codec to component
      ASoC: cs35l33: replace codec to component
      ASoC: cs35l35: replace codec to component
      ASoC: cs35l34: replace codec to component
      ASoC: cs42xx8: replace codec to component
      ASoC: cs42l73: replace codec to component
      ASoC: cs42l52: replace codec to component
      ASoC: cs42l56: replace codec to component
      ASoC: cs42l51: replace codec to component
      ASoC: cs42l42: replace codec to component
      ASoC: cs43130: replace codec to component
      ASoC: cs53l30: replace codec to component
      ASoC: da732x: replace codec to component
      ASoC: da7210: replace codec to component
      ASoC: da7218: replace codec to component
      ASoC: da7213: replace codec to component
      ASoC: da9055: replace codec to component
      ASoC: max9860: replace codec to component
      ASoC: max9850: replace codec to component
      ASoC: max98371: replace codec to component
      ASoC: max98095: replace codec to component
      ASoC: max98090: replace codec to component
      ASoC: max98926: replace codec to component
      ASoC: max98088: replace codec to component
      ASoC: max98925: replace codec to component
      ASoC: max98927: replace codec to component
      ASoC: max98357a: replace codec to component
      ASoC: max98373: replace codec to component
      ASoC: adav80x: replace codec to component
      ASoC: adau1373: replace codec to component
      ASoC: adau7002: replace codec to component
      ASoC: adau1977: replace codec to component
      ASoC: adau17x1/adau1761/adau1781: replace codec to component
      ASoC: tlv320aic23: replace codec to component
      ASoC: tlv320aic26: replace codec to component
      ASoC: tlv320aic3x: replace codec to component
      ASoC: tlv320dac33: replace codec to component
      ASoC: tlv320aic32x4: replace codec to component
      ASoC: tlv320aic31xx: replace codec to component
      ASoC: cx20442: replace codec to component
      ASoC: tscs42xx: replace codec to component
      ASoC: pcm179x: replace codec to component
      ASoC: pcm3008: replace codec to component
      ASoC: pcm1681: replace codec to component
      ASoC: pcm512x: replace codec to component
      ASoC: pcm5102a: replace codec to component
      ASoC: pcm3168a: replace codec to component
      ASoC: twl6040: replace codec to component
      ASoC: twl4030: replace codec to component
      ASoC: msm8916-wcd-analog: replace codec to component
      ASoC: msm8916-wcd-digital: replace codec to component
      ASoC: spdif_transmitter: replace codec to component
      ASoC: spdif_receiver: replace codec to component
      ASoC: tas5720: replace codec to component
      ASoC: tas2552: replace codec to component
      ASoC: sun4i: replace codec to component
      ASoC: sun8i: replace codec to component
      ASoC: ads117x: replace codec to component
      ASoC: ab8500: replace codec to component
      ASoC: ad193x: replace codec to component
      ASoC: ad1836: replace codec to component
      ASoC: ad73311: replace codec to component
      ASoC: ssm4567: replace codec to component
      ASoC: ssm2602: replace codec to component
      ASoC: ssm2518: replace codec to component
      ASoC: sta350: replace codec to component
      ASoC: sta32x: replace codec to component
      ASoC: sta529: replace codec to component
      ASoC: tas5086: replace codec to component
      ASoC: tas571x: replace codec to component
      ASoC: nau8824: replace codec to component
      ASoC: nau8810: replace codec to component
      ASoC: nau8540: replace codec to component
      ASoC: es8316: replace codec to component
      ASoC: es7134: replace codec to component
      ASoC: es8328: replace codec to component
      ASoC: alc5632: replace codec to component
      ASoC: alc5623: replace codec to component
      ASoC: hdmi-codec: replace codec to component
      ASoC: bt-sco: replace codec to component
      ASoC: vc4_hdmi: replace codec to component
      ASoC: zx_aud96p22: replace codec to component
      ASoC: wl1273: replace codec to component
      ASoC: mc13783: replace codec to component
      ASoC: sgtl5000: replace codec to component
      ASoC: sirf-audio: replace codec to component
      ASoC: inno_rk3036: replace codec to component
      ASoC: isabelle: replace codec to component
      ASoC: tfa9879: replace codec to component
      ASoC: dmic: replace codec to component
      ASoC: sti-sas: replace codec to component
      ASoC: gtm601: replace codec to component
      ASoC: 88pm860x: replace codec to component
      ASoC: pistachio: replace codec to component
      ASoC: lm49453: replace codec to component
      ASoC: cq93vc: replace codec to component
      ASoC: jz4740: replace codec to component
      ASoC: uda1380: replace codec to component
      ASoC: ml26124: replace codec to component
      ASoC: si476x: replace codec to component
      ASoC: uda134x: replace codec to component
      ASoC: ics43432: replace codec to component
      ASoC: uniphier: evea: replace codec to component
      ASoC: pcm186x: replace codec to component
      ASoC: tas6424: replace codec to component
      ASoC: atmel-pdmic: replace codec to component
      ASoC: atmel-classd: replace codec to component
      ASoC: hdac_hdmi/nau8825/rt286/rt298/rt5663/da7219: replace codec to c=
omponent
      ASoC: rt5645/rt5677: replace codec to component
      ASoC: wm8993/wm8994/wm8958: replace codec to component
      ASoC: remove rtd->platform checck
      ASoC: soc-utils: replace platform to component
      ASoC: soc-generic-dmaengine-pcm: replace platform to component
      ASoC: intel: atom: replace platform to component
      ASoC: intel: skylake: replace platform to component
      ASoC: intel: baytrail: replace platform to component
      ASoC: intel: haswell: replace platform to component
      ASoC: bcm: cygnus: replace platform to component
      ASoC: sh: rsnd: replace platform to component
      ASoC: sh: dma-sh7760: replace platform to component
      ASoC: sh: fsi: replace platform to component
      ASoC: sh: siu: replace platform to component
      ASoC: atmel: replace platform to component
      ASoC: amd: replace platform to component
      ASoC: cs47l24: replace platform to component
      ASoC: rt5514-spi: replace platform to component
      ASoC: wm5110: replace platform to component
      ASoC: wm5102: replace platform to component
      ASoC: davinci-i2s: replace platform to component
      ASoC: fsl: dma: replace platform to component
      ASoC: fsl: asrc: replace platform to component
      ASoC: fsl: imx: replace platform to component
      ASoC: fsl: mpc5200: replace platform to component
      ASoC: dwc-pcm: replace platform to component
      ASoC: kirkwood: replace platform to component
      ASoC: pxa: mmp: replace platform to component
      ASoC: pxa: pxa2xx: replace platform to component
      ASoC: qcom: lpass-platform: replace platform to component
      ASoC: samsung: idma: replace platform to component
      ASoC: xtfpga-i2s: replace platform to component
      ASoC: blackfin: bf5xx-ac97-pcm: replace platform to component
      ASoC: blackfin: bf5xx-i2s-pcm: replace platform to component
      ASoC: omap-pcm: replace platform to component
      ASoC: au1x: dbdma2: replace platform to component
      ASoC: au1x: dma: replace platform to component
      ASoC: nuc900-pcm: replace platform to component
      ASoC: txx9aclc: replace platform to component
      ASoC: mt2701/mt8173: replace platform to component
      ASoC: stm: stm32_adfsdm: replace platform to component
      ASoC: soc-utils: replace codec to component
      ASoC: adau1701: replace codec to component
      ASoC: rsnd: indicate IRQ error status for debug
      ASoC: rsnd: suppress rsnd_dai_call() debug message
      ASoC: wm9081: fixup wm9081_digital_mute() reg read
      ASoC: wm9712: replace codec to component
      ASoC: wm9713: replace codec to component
      ASoC: ad73311: replace codec to component
      ASoC: stac9766: replace codec to component
      ASoC: wm9705: replace codec to component
      ASoC: ad1980: replace codec to component
      ASoC: uniphier: aio-dma: replace platform to component
      ASoC: arizona: replace codec to component
      ASoC: ak4613: don't have .use_pmdown_time
      ASoC: ak4642: don't have .use_pmdown_time
      ASoC: soc-core: soc_probe_dai() code simplification
      ASoC: intel: kbl_da7219_max98357: replace codec to component
      ASoC: amd: acp-da7219-max98357: replace codec to component
      ASoC: ak4458: replace codec to component
      ASoC: ak5558: replace codec to component
      ASoC: pxa/mioa701_wm9713: replace codec to component
      ASoC: dmic: don't use codec anymore
      soc-core: don't call kfree() for component
      ASoC: twl6040: remove duplicated remove callback
      ASoC: amd: don't use codec anymore
      ASoC: Intel: bytcr_rt5651: don't use codec anymore
      ASoC: cpcap: replace codec to component

Ladislav Michl (6):
      ASoC: max9867: Show Kconfig entry
      ASoC: max9867: Improve error logging
      ASoC: max9867: Fix codec capabilities
      ASoC: max9867: DSP mode
      ASoC: atmel: Remove redundant dev_err() call in probe function
      ASoC: max9867: Drop probe function

Liam Girdwood (3):
      ASoC: pcm: improve debug output for DPCM BE searching.
      ASoC: topology: Check widget kcontrols before deref.
      ASoC: topology: Fix kcontrol name string handling

Mark Brown (108):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rockchip' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/compress' and 'asoc/fix/mtk'=
 into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm186x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl-breakage' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/ak4=
613', 'asoc/topic/amd', 'asoc/topic/atmel' and 'asoc/topic/au1x' into asoc-=
next
      Merge remote-tracking branches 'asoc/topic/bcm2835', 'asoc/topic/code=
cs', 'asoc/topic/compress' and 'asoc/topic/cq93vc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l32', 'asoc/topic/cs35=
l34', 'asoc/topic/cs42l52', 'asoc/topic/cs42l56' and 'asoc/topic/cs42l73' i=
nto asoc-next
      Merge remote-tracking branches 'asoc/topic/cs47l24', 'asoc/topic/cx20=
442', 'asoc/topic/da7213', 'asoc/topic/da7218' and 'asoc/topic/dai-drv' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/debu=
gfs', 'asoc/topic/disconnect', 'asoc/topic/dmic' and 'asoc/topic/ep93xx' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/eukrea-tlv320', 'asoc/topi=
c/fsl', 'asoc/topic/fsl-ssi' and 'asoc/topic/fsl_asrc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hdac_hdmi', 'asoc/topic/hi=
silicon', 'asoc/topic/iio' and 'asoc/topic/max98373' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98926', 'asoc/topic/max=
98927', 'asoc/topic/mc13783', 'asoc/topic/msm8916' and 'asoc/topic/mt8173' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/mtk', 'asoc/topic/mxs', 'a=
soc/topic/mxs-sgtl5000', 'asoc/topic/nau8540' and 'asoc/topic/nau8824' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8825' and 'asoc/topic/n=
uc900' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231' and 'asoc/topic/rt=
5514' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/sam9g=
20_wm8731', 'asoc/topic/sam9x5_wm8731', 'asoc/topic/samsung' and 'asoc/topi=
c/sgtl5000' into asoc-next
      Merge remote-tracking branches 'asoc/topic/si476x', 'asoc/topic/simpl=
e', 'asoc/topic/spdif', 'asoc/topic/st-dfsdm' and 'asoc/topic/stm32' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/sun4i-i2s', 'asoc/topic/su=
n8i-codec', 'asoc/topic/sunxi', 'asoc/topic/symmetry' and 'asoc/topic/tas57=
20' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas6424', 'asoc/topic/tfa9=
879', 'asoc/topic/tlv320aic31xx', 'asoc/topic/tlv320aic32x4' and 'asoc/topi=
c/tlv320aic3x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320dac33', 'asoc/topic/=
ts3a227e' and 'asoc/topic/tscs42xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/uda1380', 'asoc/topic/unip=
hier' and 'asoc/topic/utils' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ux500', 'asoc/topic/wm0010=
', 'asoc/topic/wm2000', 'asoc/topic/wm5102' and 'asoc/topic/wm5110' into as=
oc-next
      Merge remote-tracking branches 'asoc/topic/wm8350', 'asoc/topic/wm840=
0', 'asoc/topic/wm8903', 'asoc/topic/wm8994' and 'asoc/topic/wm8997' into a=
soc-next
      Merge remote-tracking branch 'asoc/topic/wm8998' into asoc-next
      Merge branch 'topic/component-platform' of https://git.kernel.org/...=
/broonie/sound into asoc-samsung
      Merge branch 'fix/sgtl5000' of https://git.kernel.org/.../broonie/sou=
nd into asoc-sgtl5000
      Merge branch 'topic/hda-sync-power' of https://git.kernel.org/.../tiw=
ai/sound into asoc-intel
      ASoC: Intel: Fix build
      Merge branch 'fix/sgtl5000' of https://git.kernel.org/.../broonie/sou=
nd into asoc-sgtl5000
      Merge branch 'fix/hdmi-codec' of https://git.kernel.org/.../broonie/s=
ound into asoc-hdmi-codec
      Merge branch 'topic/component-platform' of https://git.kernel.org/...=
/broonie/sound into HEAD
      Merge branch 'topic/generic-dmaengine' of https://git.kernel.org/.../=
broonie/sound into asoc-stm32
      Merge branch 'topic/component-platform' of https://git.kernel.org/...=
/broonie/sound into asoc-intel
      Merge branch 'topic/wm9867' of https://git.kernel.org/.../broonie/sou=
nd into asoc-max9867
      Merge branch 'topic/rt5651' of https://git.kernel.org/.../broonie/sou=
nd into asoc-intel
      ASoC: core: Fix typo roup->group
      Merge branch 'fix/rt5659' of https://git.kernel.org/.../broonie/sound=
 into asoc-rt5659
      Merge branch 'topic/of' of https://git.kernel.org/.../broonie/sound i=
nto asoc-samsung
      Merge branch 'topic/intel' of https://git.kernel.org/.../broonie/soun=
d into asoc-amd
      Merge remote-tracking branch 'asoc/fix/component' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/mtk', 'asoc/fix/rt5659', 'as=
oc/fix/ssm2602' and 'asoc/fix/topology' into asoc-linus
      Merge tag 'asoc-v4.16-4' into asoc-next
      Merge remote-tracking branch 'asoc/topic/component-platform' into aso=
c-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1681' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm1789' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm179x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm186x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3008' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3168a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm5102a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5665' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/ab8=
500', 'asoc/topic/ac97', 'asoc/topic/ad1836' and 'asoc/topic/ad193x' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/ad73311', 'asoc/topic/adau=
1373', 'asoc/topic/adau17x1', 'asoc/topic/adau1977' and 'asoc/topic/adau700=
2' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adav80x', 'asoc/topic/ads1=
17x', 'asoc/topic/ak4104', 'asoc/topic/ak4458' and 'asoc/topic/ak4535' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4554', 'asoc/topic/ak461=
3', 'asoc/topic/ak4641', 'asoc/topic/ak4642' and 'asoc/topic/ak4671' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/ak5386', 'asoc/topic/ak555=
8', 'asoc/topic/alc5623', 'asoc/topic/alc5632' and 'asoc/topic/amd' into as=
oc-next
      Merge remote-tracking branches 'asoc/topic/arizona', 'asoc/topic/atme=
l', 'asoc/topic/bd28623', 'asoc/topic/blackfin' and 'asoc/topic/bt-sco' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/cpcap', 'asoc/topic/cq93vc=
' and 'asoc/topic/cs35l32' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l33', 'asoc/topic/cs35=
l34', 'asoc/topic/cs35l35', 'asoc/topic/cs4265' and 'asoc/topic/cs4270' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/cs4271', 'asoc/topic/cs42l=
42', 'asoc/topic/cs42l51', 'asoc/topic/cs42l52' and 'asoc/topic/cs42l56' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l73', 'asoc/topic/cs42=
xx8', 'asoc/topic/cs43130', 'asoc/topic/cs4349' and 'asoc/topic/cs53l30' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/cx20442', 'asoc/topic/cygn=
us', 'asoc/topic/da7210', 'asoc/topic/da7213' and 'asoc/topic/da7218' into =
asoc-next
      Merge remote-tracking branches 'asoc/topic/da7219', 'asoc/topic/da732=
x', 'asoc/topic/da9055' and 'asoc/topic/dmic' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/es7134',=
 'asoc/topic/es8316', 'asoc/topic/es8328' and 'asoc/topic/fsl' into asoc-ne=
xt
      Merge remote-tracking branches 'asoc/topic/fsl_esai', 'asoc/topic/fsl=
_ssi', 'asoc/topic/fsl_utils', 'asoc/topic/generic-dmaengine' and 'asoc/top=
ic/gtm601' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hdmi-codec', 'asoc/topic/i=
cs43432', 'asoc/topic/imx-wm8962' and 'asoc/topic/inno_rk3036' into asoc-ne=
xt
      Merge remote-tracking branches 'asoc/topic/isabelle', 'asoc/topic/jz4=
740', 'asoc/topic/lm49453', 'asoc/topic/max9759' and 'asoc/topic/max98088' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98090', 'asoc/topic/max=
98095', 'asoc/topic/max98357a', 'asoc/topic/max98371' and 'asoc/topic/max98=
373' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max9850', 'asoc/topic/max9=
860', 'asoc/topic/max9867', 'asoc/topic/max98925' and 'asoc/topic/max98926'=
 into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98927', 'asoc/topic/mc1=
3783', 'asoc/topic/mediatek', 'asoc/topic/ml26124' and 'asoc/topic/msm8916-=
wcd-analog' into asoc-next
      Merge remote-tracking branches 'asoc/topic/msm8916-wcd-digital', 'aso=
c/topic/mtk', 'asoc/topic/nau8540', 'asoc/topic/nau8810' and 'asoc/topic/na=
u8824' into asoc-next
      Merge remote-tracking branches 'asoc/topic/pistachio', 'asoc/topic/px=
a', 'asoc/topic/rsnd', 'asoc/topic/rt274' and 'asoc/topic/rt286' into asoc-=
next
      Merge remote-tracking branches 'asoc/topic/rt298', 'asoc/topic/rt5514=
', 'asoc/topic/rt5616', 'asoc/topic/rt5631' and 'asoc/topic/rt5640' into as=
oc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/rt565=
1', 'asoc/topic/rt5659' and 'asoc/topic/rt5660' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5670', 'asoc/topic/sgtl5=
000', 'asoc/topic/si476x' and 'asoc/topic/sirf' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sirf-audio', 'asoc/topic/s=
n95031', 'asoc/topic/soc-dapm', 'asoc/topic/spdif_receiver' and 'asoc/topic=
/spdif_transmitter' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ssm2518', 'asoc/topic/ssm2=
602', 'asoc/topic/ssm4567', 'asoc/topic/sta32x' and 'asoc/topic/sta350' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/sta529', 'asoc/topic/sti-s=
as', 'asoc/topic/stm32', 'asoc/topic/sun4i' and 'asoc/topic/sun8i' into aso=
c-next
      Merge remote-tracking branches 'asoc/topic/tas2552', 'asoc/topic/tas5=
086', 'asoc/topic/tas571x', 'asoc/topic/tas5720' and 'asoc/topic/tas6424' i=
nto asoc-next
      Merge remote-tracking branches 'asoc/topic/tda7419', 'asoc/topic/tfa9=
879', 'asoc/topic/tlv320aic23', 'asoc/topic/tlv320aic26' and 'asoc/topic/tl=
v320aic31xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320aic32x4', 'asoc/topi=
c/tlv320aic3x', 'asoc/topic/tlv320dac33', 'asoc/topic/topology' and 'asoc/t=
opic/tscs42xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/twl4030', 'asoc/topic/twl6=
040', 'asoc/topic/uda134x', 'asoc/topic/uda1380' and 'asoc/topic/uniphier' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/vc4_hdmi', 'asoc/topic/wl1=
273', 'asoc/topic/wm0010', 'asoc/topic/wm1250-ev1' and 'asoc/topic/wm2000' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm2200', 'asoc/topic/wm510=
0', 'asoc/topic/wm8350', 'asoc/topic/wm8400' and 'asoc/topic/wm8510' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8523', 'asoc/topic/wm852=
4', 'asoc/topic/wm8580', 'asoc/topic/wm8711' and 'asoc/topic/wm8727' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8728', 'asoc/topic/wm873=
1', 'asoc/topic/wm8737', 'asoc/topic/wm8741' and 'asoc/topic/wm8750' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8753', 'asoc/topic/wm877=
0', 'asoc/topic/wm8776', 'asoc/topic/wm8782' and 'asoc/topic/wm8804' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8900', 'asoc/topic/wm890=
3', 'asoc/topic/wm8904', 'asoc/topic/wm8940' and 'asoc/topic/wm8955' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8960', 'asoc/topic/wm896=
1', 'asoc/topic/wm8962', 'asoc/topic/wm8971' and 'asoc/topic/wm8974' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8978', 'asoc/topic/wm898=
3', 'asoc/topic/wm8985', 'asoc/topic/wm8988' and 'asoc/topic/wm8990' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8991', 'asoc/topic/wm899=
4', 'asoc/topic/wm8995', 'asoc/topic/wm8996' and 'asoc/topic/wm9081' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm9090', 'asoc/topic/wm971=
2', 'asoc/topic/wm9713' and 'asoc/topic/wm_adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/zx_aud96p22' into asoc-next

Martin Hundeb=F8ll (1):
      ASoC: soc-core: remove error due to probe deferral

Masahiro Yamada (1):
      ASoC: uniphier: remove superfluous <linux/mfd/syscon.h> inclusion

Masanari Iida (1):
      ASoC: mediatek: mt2701: Fix a typo in printk

Matt Porter (2):
      ASoC: add tda7419 audio processor binding
      ASoC: add tda7419 audio processor driver

Matthias Kaehlcke (1):
      ASoC: dmic: Add optional wakeup delay

Michal Oleszczyk (2):
      ASoC: sgtl5000: add 'Audio Switch' block implementation
      ASoC: sgtl5000: add 5 band graphic equalizer

Mukunda, Vijendar (2):
      ASoC: amd: renaming pcm substream names and bytescount params
      ASoC: amd: Coding style changes for acp dma driver

Myl=E8ne Josserand (2):
      ASoC: codecs: Add support for PCM1789
      ASoC: Add bindings for PCM1789

Naveen Manohar (3):
      ASoC: Intel: Add Kabylake-y Dialog Maxim machine driver
      ASoC: Intel: Add Kabylake Dialog+Maxim machine driver entry
      ASoC: Intel: kbl: Enable mclk and ssp sclk early for rt5663

Neil Armstrong (2):
      ASoC: Add DT bindings documentation for max9759 amplifier
      ASoC: max9759: Add Amplifier Driver

Nicolin Chen (17):
      ASoC: fsl_ssi: Redefine RX and TX macros
      ASoC: fsl_ssi: Keep ssi->i2s_net updated
      ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
      ASoC: fsl_ssi: Maintain a mask of active streams
      ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
      ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
      ASoC: fsl_ssi: Clean up helper functions of trigger()
      ASoC: fsl_ssi: Add DAIFMT define for AC97
      ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
      ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
      ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
      ASoC: fsl_ssi: Move one-time configurations to probe()
      ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
      ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
      ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode
      ASoC: fsl_ssi: Move DT related code to a separate probe()
      ASoC: fsl_ssi: Use ssi->streams instead of reading register

Nikita Yushchenko (1):
      ASoC: rsnd: set pm_ops in hibernate-compatible way

Olivier Moysan (4):
      ASoC: dmaengine_pcm: add processing support
      ASoC: stm32: Add S/PDIF to SAI bindings
      ASoC: stm32: sai: Add support of S/PDIF playback
      ASoC: dmaengine_pcm: document process callback

Pawse, GuruprasadX (2):
      ASoC: Intel: Skylake: Add BE DAI for WoV usecase
      ASoC: Intel: board: Add BE DAI link for WoV and update DAPM machine m=
ap.

Peng Donglin (1):
      ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication

Peter Ujfalusi (6):
      ASoC: tlv320aic31xx: Fix master mode clock I2S bus clocks
      ASoC: tlv320aic31xx: Rename AIF_IN from 'DAC IN' to 'AIF IN'
      ASoC: tlv320aic31xx: Do not force power on the DAC/ADC in clock maste=
r mode
      ASoC: hdmi-codec: Fix module unloading caused kernel crash
      ASoC: twl6040: Add back missing write callback
      ASoC: soc-io: Fix snd_soc_component_update_bits_legacy

Ranjani Sridharan (1):
      ASoC: topology: create TLV data for dapm widgets

Richard Fitzgerald (2):
      ASoC: wm_adsp: Don't init cache from DSP memory if control is write-o=
nly
      ASoC: wm_adsp: Fix some signedness errors in register access

Ryder Lee (1):
      ASoC: mediatek: remove "simple-mfd" in the example

Sanyog Kale (1):
      ASoC: Intel: Skylake: Disable clock and power gating during FW/LIB do=
wnload

Sebastian Reichel (1):
      ASoC: cpcap: new codec

Srinivas Kandagatla (1):
      ASoC: dapm: add support to pinctrl dapm

Sriram Periyasamy (1):
      ASoC: Intel: Skylake: Find module id from UUID for bind params

Steven Eckhoff (1):
      ASoC: TSCS42xx: Add missing headers

Sylwester Nawrocki (19):
      ASoC: samsung: Add the DT binding files entry to MAINTAINERS
      ASoC: samsung: i2s: Ensure the RCLK rate is properly determined
      ASoC: samsung: i2s: Update clock-output-names property documentation
      ASoC: samsung: i2s: Ensure names of supplied clocks are unique
      ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access
      ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK
      ASoC: samsung,tm2-audio DT binding documentation update
      ASoC: samsung: Add support for HDMI audio on TM2 board
      ASoC: samsung: Add missing #sound-dai-cells property documentation
      ASoC: Use proper DT compatible string for Hardkernel Odroid boards
      ASoC: max98090: Add #sound-dai-cells property documentation
      ASoC: Add snd_soc_of_put_dai_link_codecs() helper function
      ASoC: samsung: i2s: Fix rclk_srcrate handling
      ASoC: samsung: Drop uneeded RCLKSRC setting in the Snow driver
      ASoC: samsung: Snow DT bindings update
      ASoC: samsung: Add HDMI audio support for Snow
      ASoC: samsung: odroid: Fix 32000 sample rate handling
      ASoC: samsung: odroid: Drop sample rates that cannot be supported fro=
m hw_params()
      ASoC: samsung: Use snd_soc_of_put_dai_link_codecs() in odroid.c

Vijendar Mukunda (1):
      ASoC: amd: modifications in dma stop sequence

Wei Yongjun (1):
      ASoC: mediatek: mt2701: drop unnessary snd_soc_unregister_component()

Wu Fengguang (2):
      ASoC: uniphier: aiodma_rb_get_rp() can be static
      ASoC: rt5659: rt5659_intel_hd_header_probe_setup() can be static

kbuild test robot (1):
      ASoC: ak4458: ak4458_regmap can be static

oder_chiou@realtek.com (2):
      ASoC: rt5659: Add the support of Intel HDA Header
      ASoC: rt5659: Remove the routing path of the power widget "LDO2"

olivier moysan (2):
      ASoC: stm32: spdifrx: fix typo in function name.
      ASoC: stm32: spdifrx: Use default dai name

weiyongjun (A) (2):
      ASoC: wm8400: Use devm_snd_soc_register_component()
      ASoC: da7210: Use devm_snd_soc_register_component()

 Documentation/devicetree/bindings/sound/ak4458.txt |   23 +
 Documentation/devicetree/bindings/sound/ak5558.txt |   22 +
 Documentation/devicetree/bindings/sound/da7219.txt |    6 +
 Documentation/devicetree/bindings/sound/dmic.txt   |    2 +
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |    1 -
 .../devicetree/bindings/sound/imx-audio-wm8962.txt |   53 -
 .../devicetree/bindings/sound/max98090.txt         |    2 +
 .../devicetree/bindings/sound/maxim,max9759.txt    |   18 +
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |    2 +-
 .../devicetree/bindings/sound/pcm1789.txt          |   22 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    1 +
 .../bindings/sound/rockchip,rk3288-hdmi-analog.txt |    2 +-
 .../devicetree/bindings/sound/rohm,bd28623.txt     |   29 +
 Documentation/devicetree/bindings/sound/rt5651.txt |   17 +
 Documentation/devicetree/bindings/sound/rt5665.txt |    4 +-
 .../devicetree/bindings/sound/samsung,odroid.txt   |    8 +-
 .../bindings/sound/samsung,tm2-audio.txt           |   14 +-
 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 +-
 .../devicetree/bindings/sound/sgtl5000.txt         |    3 +
 Documentation/devicetree/bindings/sound/snow.txt   |   13 +-
 .../devicetree/bindings/sound/st,stm32-sai.txt     |    6 +
 .../devicetree/bindings/sound/tda7419.txt          |   38 +
 .../devicetree/bindings/sound/uniphier,aio.txt     |   45 +
 Documentation/devicetree/bindings/sound/wm8524.txt |    2 +-
 MAINTAINERS                                        |    7 -
 arch/x86/include/asm/platform_sst_audio.h          |    1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   47 +-
 include/dt-bindings/sound/rt5651.h                 |   15 +
 include/sound/da7219.h                             |    2 +
 include/sound/dmaengine_pcm.h                      |    7 +
 include/sound/hdaudio.h                            |    2 +
 include/sound/rt5651.h                             |   29 -
 include/sound/rt5659.h                             |    1 +
 include/sound/soc-dapm.h                           |   16 +
 include/sound/soc.h                                |   14 +-
 include/uapi/sound/asound.h                        |    1 +
 sound/hda/hdac_device.c                            |   35 +
 sound/pci/hda/hda_codec.c                          |   28 +-
 sound/pci/hda/hda_local.h                          |    6 +-
 sound/soc/Kconfig                                  |    1 -
 sound/soc/Makefile                                 |    1 -
 sound/soc/amd/Kconfig                              |    9 +
 sound/soc/amd/Makefile                             |    2 +
 sound/soc/amd/acp-da7219-max98357a.c               |  276 ++++
 sound/soc/amd/acp-pcm-dma.c                        |  206 +--
 sound/soc/amd/acp-rt5645.c                         |    4 +-
 sound/soc/amd/acp.h                                |    8 +-
 sound/soc/atmel/atmel-classd.c                     |   65 +-
 sound/soc/atmel/atmel-pcm-pdc.c                    |    6 +-
 sound/soc/atmel/atmel-pdmic.c                      |   67 +-
 sound/soc/au1x/dbdma2.c                            |   13 +-
 sound/soc/au1x/dma.c                               |   12 +-
 sound/soc/bcm/cygnus-pcm.c                         |    7 +-
 sound/soc/bcm/cygnus-ssp.c                         |    2 +-
 sound/soc/blackfin/Kconfig                         |  205 ---
 sound/soc/blackfin/Makefile                        |   40 -
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |  480 ------
 sound/soc/blackfin/bf5xx-ac97.c                    |  388 -----
 sound/soc/blackfin/bf5xx-ac97.h                    |   57 -
 sound/soc/blackfin/bf5xx-ad1836.c                  |  109 --
 sound/soc/blackfin/bf5xx-ad193x.c                  |  131 --
 sound/soc/blackfin/bf5xx-ad1980.c                  |  109 --
 sound/soc/blackfin/bf5xx-ad73311.c                 |  212 ---
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |  373 -----
 sound/soc/blackfin/bf5xx-i2s-pcm.h                 |   17 -
 sound/soc/blackfin/bf5xx-i2s.c                     |  391 -----
 sound/soc/blackfin/bf5xx-sport.c                   | 1102 --------------
 sound/soc/blackfin/bf5xx-sport.h                   |  174 ---
 sound/soc/blackfin/bf5xx-ssm2602.c                 |  126 --
 sound/soc/blackfin/bf6xx-i2s.c                     |  239 ---
 sound/soc/blackfin/bf6xx-sport.c                   |  425 ------
 sound/soc/blackfin/bf6xx-sport.h                   |   82 -
 sound/soc/blackfin/bfin-eval-adau1373.c            |  173 ---
 sound/soc/blackfin/bfin-eval-adau1701.c            |  113 --
 sound/soc/blackfin/bfin-eval-adau1x61.c            |  142 --
 sound/soc/blackfin/bfin-eval-adau1x81.c            |  129 --
 sound/soc/blackfin/bfin-eval-adav80x.c             |  145 --
 sound/soc/codecs/88pm860x-codec.c                  |  166 +--
 sound/soc/codecs/88pm860x-codec.h                  |    4 +-
 sound/soc/codecs/Kconfig                           |   50 +-
 sound/soc/codecs/Makefile                          |   17 +-
 sound/soc/codecs/ab8500-codec.c                    |  295 ++--
 sound/soc/codecs/ac97.c                            |   46 +-
 sound/soc/codecs/ad1836.c                          |   68 +-
 sound/soc/codecs/ad193x-i2c.c                      |    7 -
 sound/soc/codecs/ad193x-spi.c                      |    7 -
 sound/soc/codecs/ad193x.c                          |   46 +-
 sound/soc/codecs/ad1980.c                          |   87 +-
 sound/soc/codecs/ad73311.c                         |   27 +-
 sound/soc/codecs/adau1373.c                        |   84 +-
 sound/soc/codecs/adau1701.c                        |  101 +-
 sound/soc/codecs/adau1761.c                        |   88 +-
 sound/soc/codecs/adau1781.c                        |   51 +-
 sound/soc/codecs/adau17x1.c                        |   69 +-
 sound/soc/codecs/adau17x1.h                        |    8 +-
 sound/soc/codecs/adau1977-i2c.c                    |    7 -
 sound/soc/codecs/adau1977-spi.c                    |    7 -
 sound/soc/codecs/adau1977.c                        |   59 +-
 sound/soc/codecs/adau7002.c                        |   30 +-
 sound/soc/codecs/adav801.c                         |    7 -
 sound/soc/codecs/adav803.c                         |    7 -
 sound/soc/codecs/adav80x.c                         |  130 +-
 sound/soc/codecs/ads117x.c                         |   27 +-
 sound/soc/codecs/ak4104.c                          |   68 +-
 sound/soc/codecs/ak4458.c                          |  657 ++++++++
 sound/soc/codecs/ak4458.h                          |   86 ++
 sound/soc/codecs/ak4535.c                          |   78 +-
 sound/soc/codecs/ak4554.c                          |   27 +-
 sound/soc/codecs/ak4613.c                          |   72 +-
 sound/soc/codecs/ak4641.c                          |   91 +-
 sound/soc/codecs/ak4642.c                          |  104 +-
 sound/soc/codecs/ak4671.c                          |   67 +-
 sound/soc/codecs/ak5386.c                          |   62 +-
 sound/soc/codecs/ak5558.c                          |  415 ++++++
 sound/soc/codecs/ak5558.h                          |   52 +
 sound/soc/codecs/alc5623.c                         |  147 +-
 sound/soc/codecs/alc5632.c                         |  138 +-
 sound/soc/codecs/arizona.c                         |  249 ++--
 sound/soc/codecs/arizona.h                         |   24 +-
 sound/soc/codecs/bd28623.c                         |  242 +++
 sound/soc/codecs/bt-sco.c                          |   21 +-
 sound/soc/codecs/cpcap.c                           | 1562 ++++++++++++++++=
++++
 sound/soc/codecs/cq93vc.c                          |   33 +-
 sound/soc/codecs/cs35l32.c                         |   45 +-
 sound/soc/codecs/cs35l33.c                         |  186 ++-
 sound/soc/codecs/cs35l34.c                         |  127 +-
 sound/soc/codecs/cs35l35.c                         |  104 +-
 sound/soc/codecs/cs4265.c                          |   98 +-
 sound/soc/codecs/cs4270.c                          |  124 +-
 sound/soc/codecs/cs4271-i2c.c                      |    7 -
 sound/soc/codecs/cs4271-spi.c                      |    7 -
 sound/soc/codecs/cs4271.c                          |  105 +-
 sound/soc/codecs/cs42l42.c                         |  154 +-
 sound/soc/codecs/cs42l42.h                         |    2 +-
 sound/soc/codecs/cs42l51-i2c.c                     |    8 -
 sound/soc/codecs/cs42l51.c                         |   81 +-
 sound/soc/codecs/cs42l52.c                         |  146 +-
 sound/soc/codecs/cs42l56.c                         |  158 +-
 sound/soc/codecs/cs42l73.c                         |  122 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |    1 -
 sound/soc/codecs/cs42xx8.c                         |   57 +-
 sound/soc/codecs/cs43130.c                         |  243 +--
 sound/soc/codecs/cs43130.h                         |    2 +-
 sound/soc/codecs/cs4349.c                          |   39 +-
 sound/soc/codecs/cs47l24.c                         |  136 +-
 sound/soc/codecs/cs53l30.c                         |   57 +-
 sound/soc/codecs/cx20442.c                         |   89 +-
 sound/soc/codecs/da7210.c                          |  181 ++-
 sound/soc/codecs/da7213.c                          |  328 ++--
 sound/soc/codecs/da7218.c                          |  498 +++----
 sound/soc/codecs/da7218.h                          |    2 +-
 sound/soc/codecs/da7219-aad.c                      |  236 +--
 sound/soc/codecs/da7219-aad.h                      |   12 +-
 sound/soc/codecs/da7219.c                          |  434 ++++--
 sound/soc/codecs/da7219.h                          |   11 +-
 sound/soc/codecs/da732x.c                          |  241 +--
 sound/soc/codecs/da9055.c                          |  186 ++-
 sound/soc/codecs/dmic.c                            |   92 +-
 sound/soc/codecs/es7134.c                          |   27 +-
 sound/soc/codecs/es8316.c                          |   80 +-
 sound/soc/codecs/es8328-i2c.c                      |    7 -
 sound/soc/codecs/es8328-spi.c                      |    7 -
 sound/soc/codecs/es8328.c                          |  147 +-
 sound/soc/codecs/gtm601.c                          |   28 +-
 sound/soc/codecs/hdac_hdmi.c                       |   65 +-
 sound/soc/codecs/hdac_hdmi.h                       |    2 +-
 sound/soc/codecs/hdmi-codec.c                      |   30 +-
 sound/soc/codecs/ics43432.c                        |   16 +-
 sound/soc/codecs/inno_rk3036.c                     |   70 +-
 sound/soc/codecs/isabelle.c                        |   57 +-
 sound/soc/codecs/jz4740.c                          |   50 +-
 sound/soc/codecs/lm49453.c                         |   65 +-
 sound/soc/codecs/max9759.c                         |  207 +++
 sound/soc/codecs/max98088.c                        |  314 ++--
 sound/soc/codecs/max98090.c                        |  319 ++--
 sound/soc/codecs/max98090.h                        |    4 +-
 sound/soc/codecs/max98095.c                        |  448 +++---
 sound/soc/codecs/max98095.h                        |    2 +-
 sound/soc/codecs/max98357a.c                       |   29 +-
 sound/soc/codecs/max98371.c                        |   43 +-
 sound/soc/codecs/max98371.h                        |    1 -
 sound/soc/codecs/max98373.c                        |   75 +-
 sound/soc/codecs/max9850.c                         |   80 +-
 sound/soc/codecs/max9860.c                         |   70 +-
 sound/soc/codecs/max9867.c                         |   91 +-
 sound/soc/codecs/max9867.h                         |    1 -
 sound/soc/codecs/max98925.c                        |   72 +-
 sound/soc/codecs/max98925.h                        |    2 +-
 sound/soc/codecs/max98926.c                        |   56 +-
 sound/soc/codecs/max98926.h                        |    2 +-
 sound/soc/codecs/max98927.c                        |   82 +-
 sound/soc/codecs/max98927.h                        |    2 +-
 sound/soc/codecs/mc13783.c                         |   68 +-
 sound/soc/codecs/ml26124.c                         |  103 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |  207 +--
 sound/soc/codecs/msm8916-wcd-digital.c             |  115 +-
 sound/soc/codecs/nau8540.c                         |   79 +-
 sound/soc/codecs/nau8810.c                         |   73 +-
 sound/soc/codecs/nau8824.c                         |  153 +-
 sound/soc/codecs/nau8824.h                         |    2 +-
 sound/soc/codecs/nau8825.c                         |  107 +-
 sound/soc/codecs/nau8825.h                         |    2 +-
 sound/soc/codecs/pcm1681.c                         |   62 +-
 sound/soc/codecs/pcm1789-i2c.c                     |   62 +
 sound/soc/codecs/pcm1789.c                         |  274 ++++
 sound/soc/codecs/pcm1789.h                         |   17 +
 sound/soc/codecs/pcm179x-i2c.c                     |    6 -
 sound/soc/codecs/pcm179x-spi.c                     |    6 -
 sound/soc/codecs/pcm179x.c                         |   45 +-
 sound/soc/codecs/pcm179x.h                         |    1 -
 sound/soc/codecs/pcm186x-i2c.c                     |    8 -
 sound/soc/codecs/pcm186x-spi.c                     |    8 -
 sound/soc/codecs/pcm186x.c                         |  143 +-
 sound/soc/codecs/pcm186x.h                         |    1 -
 sound/soc/codecs/pcm3008.c                         |   36 +-
 sound/soc/codecs/pcm3168a.c                        |   51 +-
 sound/soc/codecs/pcm5102a.c                        |   16 +-
 sound/soc/codecs/pcm512x.c                         |  162 +-
 sound/soc/codecs/rt274.c                           |  206 ++-
 sound/soc/codecs/rt286.c                           |  205 ++-
 sound/soc/codecs/rt286.h                           |    2 +-
 sound/soc/codecs/rt298.c                           |  217 ++-
 sound/soc/codecs/rt298.h                           |    2 +-
 sound/soc/codecs/rt5514-spi.c                      |   36 +-
 sound/soc/codecs/rt5514.c                          |  128 +-
 sound/soc/codecs/rt5514.h                          |    2 +-
 sound/soc/codecs/rt5616.c                          |  219 ++-
 sound/soc/codecs/rt5631.c                          |  324 ++--
 sound/soc/codecs/rt5640.c                          |  260 ++--
 sound/soc/codecs/rt5640.h                          |    6 +-
 sound/soc/codecs/rt5645.c                          |  370 +++--
 sound/soc/codecs/rt5645.h                          |    4 +-
 sound/soc/codecs/rt5651.c                          |  752 +++++-----
 sound/soc/codecs/rt5651.h                          |   23 +-
 sound/soc/codecs/rt5659.c                          |  472 +++---
 sound/soc/codecs/rt5659.h                          |   21 +-
 sound/soc/codecs/rt5660.c                          |  145 +-
 sound/soc/codecs/rt5660.h                          |    2 +-
 sound/soc/codecs/rt5663.c                          |  600 ++++----
 sound/soc/codecs/rt5663.h                          |    4 +-
 sound/soc/codecs/rt5665.c                          |  350 +++--
 sound/soc/codecs/rt5665.h                          |    3 +-
 sound/soc/codecs/rt5670.c                          |  295 ++--
 sound/soc/codecs/rt5670.h                          |   10 +-
 sound/soc/codecs/rt5677.c                          |  205 ++-
 sound/soc/codecs/rt5677.h                          |    4 +-
 sound/soc/codecs/sgtl5000.c                        |  275 ++--
 sound/soc/codecs/sgtl5000.h                        |    7 +
 sound/soc/codecs/si476x.c                          |   42 +-
 sound/soc/codecs/sirf-audio-codec.c                |   58 +-
 sound/soc/codecs/spdif_receiver.c                  |   26 +-
 sound/soc/codecs/spdif_transmitter.c               |   26 +-
 sound/soc/codecs/ssm2518.c                         |   57 +-
 sound/soc/codecs/ssm2602-i2c.c                     |    7 -
 sound/soc/codecs/ssm2602-spi.c                     |    7 -
 sound/soc/codecs/ssm2602.c                         |   96 +-
 sound/soc/codecs/ssm4567.c                         |   44 +-
 sound/soc/codecs/sta32x.c                          |  134 +-
 sound/soc/codecs/sta350.c                          |  117 +-
 sound/soc/codecs/sta529.c                          |   69 +-
 sound/soc/codecs/stac9766.c                        |   77 +-
 sound/soc/codecs/sti-sas.c                         |   84 +-
 sound/soc/codecs/tas2552.c                         |  178 ++-
 sound/soc/codecs/tas5086.c                         |   94 +-
 sound/soc/codecs/tas571x.c                         |   55 +-
 sound/soc/codecs/tas5720.c                         |  151 +-
 sound/soc/codecs/tas6424.c                         |   99 +-
 sound/soc/codecs/tda7419.c                         |  654 ++++++++
 sound/soc/codecs/tfa9879.c                         |   50 +-
 sound/soc/codecs/tlv320aic23-i2c.c                 |    7 -
 sound/soc/codecs/tlv320aic23-spi.c                 |    7 -
 sound/soc/codecs/tlv320aic23.c                     |  120 +-
 sound/soc/codecs/tlv320aic26.c                     |   83 +-
 sound/soc/codecs/tlv320aic31xx.c                   |  339 +++--
 sound/soc/codecs/tlv320aic31xx.h                   |    1 +
 sound/soc/codecs/tlv320aic32x4.c                   |  207 ++-
 sound/soc/codecs/tlv320aic3x.c                     |  295 ++--
 sound/soc/codecs/tlv320dac33.c                     |  402 +++--
 sound/soc/codecs/tscs42xx.c                        |  244 +--
 sound/soc/codecs/twl4030.c                         |  383 +++--
 sound/soc/codecs/twl6040.c                         |  269 ++--
 sound/soc/codecs/twl6040.h                         |   10 +-
 sound/soc/codecs/uda134x.c                         |   78 +-
 sound/soc/codecs/uda1380.c                         |  160 +-
 sound/soc/codecs/wl1273.c                          |   93 +-
 sound/soc/codecs/wl1273.h                          |    2 +-
 sound/soc/codecs/wm0010.c                          |  181 ++-
 sound/soc/codecs/wm1250-ev1.c                      |   27 +-
 sound/soc/codecs/wm2000.c                          |   78 +-
 sound/soc/codecs/wm2200.c                          |  157 +-
 sound/soc/codecs/wm5100.c                          |  260 ++--
 sound/soc/codecs/wm5100.h                          |    2 +-
 sound/soc/codecs/wm5102.c                          |  154 +-
 sound/soc/codecs/wm5110.c                          |  222 ++-
 sound/soc/codecs/wm8350.c                          |  183 ++-
 sound/soc/codecs/wm8350.h                          |    4 +-
 sound/soc/codecs/wm8400.c                          |  211 ++-
 sound/soc/codecs/wm8510.c                          |  149 +-
 sound/soc/codecs/wm8523.c                          |   98 +-
 sound/soc/codecs/wm8524.c                          |   56 +-
 sound/soc/codecs/wm8580.c                          |  150 +-
 sound/soc/codecs/wm8711.c                          |  116 +-
 sound/soc/codecs/wm8727.c                          |   29 +-
 sound/soc/codecs/wm8728.c                          |   82 +-
 sound/soc/codecs/wm8731.c                          |  101 +-
 sound/soc/codecs/wm8737.c                          |  109 +-
 sound/soc/codecs/wm8741.c                          |  133 +-
 sound/soc/codecs/wm8750.c                          |  115 +-
 sound/soc/codecs/wm8753.c                          |  289 ++--
 sound/soc/codecs/wm8770.c                          |  131 +-
 sound/soc/codecs/wm8776.c                          |  105 +-
 sound/soc/codecs/wm8782.c                          |   27 +-
 sound/soc/codecs/wm8804.c                          |  100 +-
 sound/soc/codecs/wm8900.c                          |  251 ++--
 sound/soc/codecs/wm8903.c                          |  211 ++-
 sound/soc/codecs/wm8903.h                          |    2 +-
 sound/soc/codecs/wm8904.c                          |  355 +++--
 sound/soc/codecs/wm8940.c                          |  159 +-
 sound/soc/codecs/wm8955.c                          |  189 ++-
 sound/soc/codecs/wm8958-dsp2.c                     |  278 ++--
 sound/soc/codecs/wm8960.c                          |  249 ++--
 sound/soc/codecs/wm8961.c                          |  241 ++-
 sound/soc/codecs/wm8962.c                          |  397 +++--
 sound/soc/codecs/wm8962.h                          |    2 +-
 sound/soc/codecs/wm8971.c                          |  108 +-
 sound/soc/codecs/wm8974.c                          |  143 +-
 sound/soc/codecs/wm8978.c                          |  185 ++-
 sound/soc/codecs/wm8983.c                          |  170 +--
 sound/soc/codecs/wm8985.c                          |  201 ++-
 sound/soc/codecs/wm8988.c                          |  127 +-
 sound/soc/codecs/wm8990.c                          |  179 ++-
 sound/soc/codecs/wm8991.c                          |  167 +--
 sound/soc/codecs/wm8993.c                          |  237 +--
 sound/soc/codecs/wm8994.c                          |  810 +++++-----
 sound/soc/codecs/wm8994.h                          |    8 +-
 sound/soc/codecs/wm8995.c                          |  286 ++--
 sound/soc/codecs/wm8996.c                          |  401 +++--
 sound/soc/codecs/wm8996.h                          |    4 +-
 sound/soc/codecs/wm8997.c                          |   72 +-
 sound/soc/codecs/wm8998.c                          |  115 +-
 sound/soc/codecs/wm9081.c                          |  228 ++-
 sound/soc/codecs/wm9090.c                          |  109 +-
 sound/soc/codecs/wm9705.c                          |   83 +-
 sound/soc/codecs/wm9712.c                          |  111 +-
 sound/soc/codecs/wm9713.c                          |  203 ++-
 sound/soc/codecs/wm_adsp.c                         |   99 +-
 sound/soc/codecs/wm_adsp.h                         |   14 +-
 sound/soc/codecs/wm_hubs.c                         |  254 ++--
 sound/soc/codecs/wm_hubs.h                         |   18 +-
 sound/soc/codecs/zx_aud96p22.c                     |   35 +-
 sound/soc/davinci/davinci-i2s.c                    |   13 +-
 sound/soc/dwc/dwc-i2s.c                            |    4 +
 sound/soc/dwc/dwc-pcm.c                            |    5 +-
 sound/soc/fsl/Kconfig                              |   11 -
 sound/soc/fsl/Makefile                             |    2 -
 sound/soc/fsl/fsl-asoc-card.c                      |    6 +-
 sound/soc/fsl/fsl_asrc.c                           |   10 -
 sound/soc/fsl/fsl_asrc.h                           |    3 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |   14 +-
 sound/soc/fsl/fsl_dma.c                            |   27 +-
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |  758 +++++-----
 sound/soc/fsl/fsl_ssi.h                            |    3 -
 sound/soc/fsl/fsl_utils.c                          |    2 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |    6 +-
 sound/soc/fsl/imx-wm8962.c                         |  312 ----
 sound/soc/fsl/mpc5200_dma.c                        |   16 +-
 sound/soc/fsl/wm1133-ev1.c                         |    6 +-
 sound/soc/img/pistachio-internal-dac.c             |   34 +-
 sound/soc/intel/atom/sst-atom-controls.c           |   36 +-
 sound/soc/intel/atom/sst-mfld-platform-compress.c  |    4 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   32 +-
 sound/soc/intel/atom/sst-mfld-platform.h           |    4 +-
 sound/soc/intel/atom/sst/sst.c                     |   24 +-
 sound/soc/intel/atom/sst/sst.h                     |   20 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |    3 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |   19 -
 sound/soc/intel/atom/sst/sst_pvt.c                 |    8 -
 sound/soc/intel/atom/sst/sst_stream.c              |  117 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |   66 +-
 sound/soc/intel/boards/Kconfig                     |   25 +
 sound/soc/intel/boards/Makefile                    |    4 +
 sound/soc/intel/boards/bdw-rt5677.c                |   41 +-
 sound/soc/intel/boards/broadwell.c                 |   17 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   12 +-
 sound/soc/intel/boards/bxt_rt298.c                 |   27 +-
 sound/soc/intel/boards/byt-rt5640.c                |    4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    8 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  466 +++++-
 sound/soc/intel/boards/cht_bsw_nau8824.c           |  282 ++++
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    8 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   18 +-
 sound/soc/intel/boards/haswell.c                   |    3 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |  613 ++++++++
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |   19 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   14 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |   12 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |   12 +-
 sound/soc/intel/boards/skl_rt286.c                 |   12 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |    9 +
 sound/soc/intel/haswell/sst-haswell-ipc.h          |    2 +
 sound/soc/intel/haswell/sst-haswell-pcm.c          |  118 +-
 sound/soc/intel/skylake/skl-debug.c                |    2 +-
 sound/soc/intel/skylake/skl-messages.c             |    9 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   72 +-
 sound/soc/intel/skylake/skl-ssp-clk.c              |    4 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |    3 +
 sound/soc/intel/skylake/skl-topology.c             |  133 +-
 sound/soc/intel/skylake/skl-topology.h             |   15 +-
 sound/soc/intel/skylake/skl.c                      |   40 +
 sound/soc/intel/skylake/skl.h                      |    6 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    3 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   20 +-
 sound/soc/kirkwood/kirkwood.h                      |    4 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   16 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    9 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |    3 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |   54 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |   42 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |    4 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   12 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   12 +-
 sound/soc/nuc900/nuc900-pcm.c                      |    5 +-
 sound/soc/omap/ams-delta.c                         |   20 +-
 sound/soc/omap/omap-abe-twl6040.c                  |    8 +-
 sound/soc/omap/omap-pcm.c                          |    5 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   30 +-
 sound/soc/pxa/mmp-pcm.c                            |   11 +-
 sound/soc/pxa/mmp-sspa.c                           |    1 -
 sound/soc/pxa/pxa2xx-pcm.c                         |    5 +-
 sound/soc/pxa/ttc-dkb.c                            |    6 +-
 sound/soc/qcom/lpass-platform.c                    |   42 +-
 sound/soc/rockchip/Kconfig                         |    3 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            |    2 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |    4 +-
 sound/soc/rockchip/rockchip_rt5645.c               |    8 +-
 sound/soc/samsung/Makefile                         |    3 -
 sound/soc/samsung/i2s-regs.h                       |   11 +-
 sound/soc/samsung/i2s.c                            |   52 +-
 sound/soc/samsung/i2s.h                            |   11 +-
 sound/soc/samsung/idma.c                           |    5 +-
 sound/soc/samsung/littlemill.c                     |    8 +-
 sound/soc/samsung/lowland.c                        |   12 +-
 sound/soc/samsung/odroid.c                         |   33 +-
 sound/soc/samsung/snow.c                           |  229 ++-
 sound/soc/samsung/speyside.c                       |   12 +-
 sound/soc/samsung/tm2_wm5110.c                     |  206 ++-
 sound/soc/samsung/tobermory.c                      |    6 +-
 sound/soc/sh/dma-sh7760.c                          |    5 +-
 sound/soc/sh/fsi.c                                 |   24 +-
 sound/soc/sh/rcar/core.c                           |   36 +-
 sound/soc/sh/rcar/rsnd.h                           |   20 +
 sound/soc/sh/rcar/src.c                            |   22 +-
 sound/soc/sh/rcar/ssi.c                            |   16 +-
 sound/soc/sh/siu.h                                 |    2 +-
 sound/soc/sh/siu_dai.c                             |   10 +-
 sound/soc/sh/siu_pcm.c                             |    9 +-
 sound/soc/sirf/sirf-usp.h                          |    2 +-
 sound/soc/soc-ac97.c                               |   84 +-
 sound/soc/soc-core.c                               |  117 +-
 sound/soc/soc-dapm.c                               |   46 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |  121 +-
 sound/soc/soc-io.c                                 |    7 +-
 sound/soc/soc-pcm.c                                |   11 +
 sound/soc/soc-topology.c                           |   35 +-
 sound/soc/soc-utils.c                              |   28 +-
 sound/soc/stm/stm32_adfsdm.c                       |    7 +-
 sound/soc/stm/stm32_sai.c                          |    2 +
 sound/soc/stm/stm32_sai.h                          |    2 +
 sound/soc/stm/stm32_sai_sub.c                      |  153 +-
 sound/soc/stm/stm32_spdifrx.c                      |    7 +-
 sound/soc/sunxi/sun4i-codec.c                      |   71 +-
 sound/soc/sunxi/sun8i-codec.c                      |   23 +-
 sound/soc/tegra/tegra_wm8903.c                     |    8 +-
 sound/soc/txx9/txx9aclc.c                          |   26 +-
 sound/soc/uniphier/Kconfig                         |   33 +
 sound/soc/uniphier/Makefile                        |    8 +
 sound/soc/uniphier/aio-compress.c                  |  438 ++++++
 sound/soc/uniphier/aio-core.c                      | 1138 ++++++++++++++
 sound/soc/uniphier/aio-cpu.c                       |  578 ++++++++
 sound/soc/uniphier/aio-dma.c                       |  319 ++++
 sound/soc/uniphier/aio-ld11.c                      |  431 ++++++
 sound/soc/uniphier/aio-pxs2.c                      |  320 ++++
 sound/soc/uniphier/aio-reg.h                       |  465 ++++++
 sound/soc/uniphier/aio.h                           |  359 +++++
 sound/soc/uniphier/evea.c                          |  102 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |   17 +-
 488 files changed, 27614 insertions(+), 22906 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm896=
2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt
 create mode 100644 include/dt-bindings/sound/rt5651.h
 delete mode 100644 include/sound/rt5651.h
 create mode 100644 sound/soc/amd/acp-da7219-max98357a.c
 delete mode 100644 sound/soc/blackfin/Kconfig
 delete mode 100644 sound/soc/blackfin/Makefile
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1836.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad193x.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1980.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad73311.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ssm2602.c
 delete mode 100644 sound/soc/blackfin/bf6xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.h
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1373.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1701.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x61.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x81.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adav80x.c
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h
 create mode 100644 sound/soc/codecs/bd28623.c
 create mode 100644 sound/soc/codecs/cpcap.c
 create mode 100644 sound/soc/codecs/max9759.c
 create mode 100644 sound/soc/codecs/pcm1789-i2c.c
 create mode 100644 sound/soc/codecs/pcm1789.c
 create mode 100644 sound/soc/codecs/pcm1789.h
 create mode 100644 sound/soc/codecs/tda7419.c
 delete mode 100644 sound/soc/fsl/imx-wm8962.c
 create mode 100644 sound/soc/intel/boards/cht_bsw_nau8824.c
 create mode 100644 sound/soc/intel/boards/kbl_da7219_max98357a.c
 create mode 100644 sound/soc/uniphier/aio-compress.c
 create mode 100644 sound/soc/uniphier/aio-core.c
 create mode 100644 sound/soc/uniphier/aio-cpu.c
 create mode 100644 sound/soc/uniphier/aio-dma.c
 create mode 100644 sound/soc/uniphier/aio-ld11.c
 create mode 100644 sound/soc/uniphier/aio-pxs2.c
 create mode 100644 sound/soc/uniphier/aio-reg.h
 create mode 100644 sound/soc/uniphier/aio.h

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCUVYACgkQJNaLcl1U
h9BI5gf9HPXTxJktrgs4we1Mkhc4fGz61ObYDgNHSFyNzRlsnhuy7wnb8qf2MHQ4
hakx5I9rA1mu7PFS4jM2XaAytAP6ZHM+rdL7jOSiW9u2lM3aAScM1hdgrkdKO9Ip
2etlDXAJOaYSjBmIkp0vRGf5Ux7hTE43XionFfZSfTteckhQTNxQnLutxgWED9lv
oYo7LFSnefUPe7AJ6tZ6ZoyDnslURejguzLEiPXh3/Z8euETjMdb9171V2aiTnaR
lzhSKgW1Q3waZ/RKoUck9xPxGUqe30mC3ThB1oAri8vjkBJkTKSaEXo/wmrSq9CG
ZUNo+yR7G0cm2CQcdS8MhNCT7Jijgw==
=Q7Cn
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--

--===============4392788425411069903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4392788425411069903==--
