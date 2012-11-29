From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.8
Date: Thu, 29 Nov 2012 16:10:15 +0000
Message-ID: <20121129161015.GL32691@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5974406457326972818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FD952650D0
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 17:10:17 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5974406457326972818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8RJ6MkOGpKElHlfH"
Content-Disposition: inline


--8RJ6MkOGpKElHlfH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9489e9dcae718d5fde988e4a684a0f55b5f94d17:

  Linux 3.7-rc7 (2012-11-25 17:59:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

for you to fetch changes up to 536bc8f605a8ea62d1f75d5ec3ed8bc0526a6271:

  Merge branches 'fix/fsl', 'topic/ab8500', 'topic/adsp', 'topic/ak4104', '=
topic/ak4535', 'topic/ak4642', 'topic/atmel', 'topic/cs4271', 'topic/da7210=
', 'topic/da9055', 'topic/davinci', 'topic/dmaengine', 'topic/fsi', 'topic/=
fsl', 'topic/hotplug', 'topic/jack', 'topic/jz4740', 'topic/kirkwood', 'top=
ic/lm49453', 'topic/log', 'topic/max98090', 'topic/rt5631', 'topic/samsung'=
, 'topic/si476x', 'topic/tlv320aic32x4', 'topic/ux500', 'topic/wm0010', 'to=
pic/wm2000', 'topic/wm2200', 'topic/wm8350', 'topic/wm8400', 'topic/wm8510'=
, 'topic/wm8741', 'topic/wm8750', 'topic/wm8753', 'topic/wm8770', 'topic/wm=
8804', 'topic/wm8962', 'topic/wm8971', 'topic/wm8978', 'topic/wm8985', 'top=
ic/wm8988', 'topic/wm8993', 'topic/wm8994' and 'topic/wm8995' of git://git.=
kernel.org/pub/scm/linux/kernel/git/broonie/sound into asoc-next (2012-11-2=
9 15:48:59 +0000)

----------------------------------------------------------------

ASoC: Updates for v3.8

Very quiet release for ASoC really:

- Standardisation of the logging.
- DT support for Atmel.
- Support for Wolfson ADSP cores.
- New drivers for Freescale/iVeia P1022 and Maxim MAX98090.

----------------------------------------------------------------

Will probably have another update with some bug fixes and trivial
cleanups tomorrow.

Andrey Smirnov (1):
      Add a codec driver for SI476X MFD

Ashish Chavan (2):
      ASoC: da9055: Add support for DSP mode of AIF
      ASoC: da9055: DAPMise Headphone and Lineout enable controls

Bill Pemberton (2):
      ASoC: remove use of __devinitconst
      ASoC: max98088: remove use of __devexit_p

Bo Shen (9):
      ASoC: atmel-ssc: use devm_xxx() managed function
      ASoC: atmel-ssc: use module_platform_driver macro
      ASoC: sam9g20-wm8731: convert to use snd_soc_register_card()
      ASoC: sam9g20: using platform device for audio part
      ARM: at91: atmel-ssc: add platform device id table
      ARM: at91: atmel-ssc: add device tree support
      ASoC: atmel-ssc-dai: register dai and pcm directly
      ASoC: atmel-ssc-dai: match new method of dai and pcm register
      ASoC: at91sam9g20ek-wm8731: convert to dt support

Charles Keepax (4):
      ASoC: wm5102: Correct micbias DAPM supplies
      ASoC: arizona: Add support for multiplexer with no associated mixer
      ASoC: wm5102: Remove mixer widgets on the ASRC
      ASoC: wm5110: Remove mixer widgets on the ASRC

Daniel Mack (10):
      ASoC: ak4104: handle more sample rates
      ASoC: ak4104: add DT bindings
      ASoC: cs4271: add support for AMUTEB=3DBMUTEC feature
      ASoC: enable 192KHz support for McASP
      ASoC: McASP: add support for clock dividers
      ASoC: McASP: make AHCLK direction configurable
      ASoC: McASP: set format parameters in dependence of the DAI format
      ASoC: McASP: add support for 24 bit samples
      ASoC: McASP: treat SNDRV_PCM_FORMAT_U24_* as 32 bit words
      ASoC: ak4104: add reset line property to DT bindings

Dimitris Papastamos (3):
      ASoC: bells: Up to 512fs
      ASoC: wm5102: Register DSP1 Aux widgets
      ASoC: wm0010: Up the completion timeout to 20ms instead of 10ms

Eric Millbrandt (2):
      ASoC: fsl/pcm030 add unique dai_link names
      ASoC: wm8978: Remove remuxing of GPIO1 pin

Javier Martin (2):
      ASoC: tlv320aic32x4: Fix problem with first capture.
      ASoC: tlv320aic32x4: Add rstn gpio to platform data.

Kees Cook (1):
      ASoC: fsl: remove CONFIG_EXPERIMENTAL

Kuninori Morimoto (13):
      ASoC: fsi: fixup channels_min/max
      ASoC: fsi: use devm_request_irq()
      ASoC: fsi: fsi_set_master_clk() was called from fsi_hw_xxx() only
      ASoC: fsi: care fsi_hw_start/stop() return value
      ASoC: fsi: add master clock control functions
      ASoC: fsi: tidyup FSIA/B settings
      ASoC: fsi: tidyup sh_fsi_platform_info pointer
      ASoC: fsi: SPDIF format become independent from platform flags
      ASoC: fsi: master clock selection become independent from platform fl=
ags
      ASoC: fsi: stream mode become independent from platform flags
      ASoC: fsi: add SND_SOC_DAIFMT_INV_xxx support
      ASoC: ak4642: cleanup struct ak4642_priv
      ASoC: Add max98090 codec driver

Lars-Peter Clausen (3):
      ASoC: jz4740-codec: Add dB information
      ASoC: jz4740-codec: Use devm_request_and_ioremap
      ASoC: jz4740-codec: Use regmap

Lee Jones (1):
      ASoC: Ux500: Initialise PCM from MSP probe rather than as a device

Liam Girdwood (5):
      ASoC: dapm: Standardise ASoC DAPM messages
      ASoC: cache: Standardise ASoC cache messages
      ASoC: Jack: Standardise ASoC Jack messages
      ASoC: pcm: Standardise ASoC PCM messages
      ASoC: core: Standardise ASoC messages

Lothar Wa=DFmann (6):
      ASoC: imx: add MODULE_LICENSE("GPL")
      ASoC: imx-sgtl5000: prevent module from being unloaded when in use
      ASoC: dmaengine_pcm: set MODULE_LICENSE
      ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
      ASoC: mxs-saif: export mxs_saif_put_mclk,mxs_saif_get_mclk
      ASoC: fsl: fix miscompilation of snd-soc-imx-pcm

Mark Brown (67):
      ASoC: wm2200: Convert to devm APIs
      ASoC: wm2200: Implement AEC loopback support
      ASoC: wm2200: Map DSPs into regmap
      ASoC: wm2200: Fully plumb the DSPs into the routing map
      ASoC: wm2200: Initial DSP support
      ASoC: wm2200: Provide initial coefficient loading
      regmap: Rename n_ranges to num_ranges
      regmap: When we sanity check during range adds say what errors we find
      regmap: Allow ranges to be named
      regmap: Factor out debugfs register read
      regmap: Provide debugfs read of register ranges
      regmap: Factor range lookup out of page selection
      regmap: Make return code checks consistent
      regmap: Split raw writes that cross window boundaries
      ASoC: bells: Add WM0010 support
      ASoC: bells: Correct typo in sub speaker DAI name for WM5110
      ASoC: bells: Provide additional parameterisation
      ASoC: bells: Add WM2200 support
      ASoC: wm8750: Convert to direct regmap API usage
      ASoC: wm8770: Convert to direct regmap API usage
      ASoC: wm8770: Remove unneeded bias level manipulation
      ASoC: wm8770: Remove regulator allocation to SPI probe
      ASoC: wm8770: Conver to table based DAPM and control init
      ASoC: wm8971: Convert to direct regmap API usage
      ASoC: wm8994: Allow a delay between jack insertion and microphone det=
ect
      ASoC: wm8994: Tune VMID power up sequence
      ASoC: wm8994: Tune VMID power down sequence
      ASoC: wm8958: Load firmwares simultaneously
      Merge tag 'regmap/range' of git://git.kernel.org/.../broonie/regmap i=
nto asoc-wm2200
      ASoC: wm2200: Add names for ranges
      ASoC: wm8994: Lower AIFnCLK divisor when dropping to 32kHz
      ASoC: adsp: Add ADSP base support
      Merge branch 'topic/adsp' of git://git.kernel.org/.../broonie/sound i=
nto asoc-arizona
      ASoC: arizona: Define standard hookup for ADSP2
      ASoC: wm5102: Hook up DSP1
      Merge branch 'topic/adsp' of git://git.kernel.org/.../broonie/sound i=
nto asoc-wm2200
      ASoC: wm2200: Convert over to wm_adsp for ADSP1 support
      Merge tag 'v3.7-rc3' into HEAD
      ASoC: ab8500: Staticise non-exported ab85000_codec_dai
      Merge tag 'v3.7-rc6' into asoc-arizona
      Merge tag 'v3.7-rc6' into asoc-wm2200
      ASoC: wm5102: Remove output OSR and PGA volume control
      ASoC: wm8994: Lower AIFnCLK divisor when dropping to 32kHz
      mfd: wm8994: Store platform data in device
      ASoC: wm8994: Use pdata cached in MFD driver
      ASoC: arizona: Support higher clock rates
      ASoC: wm2000: Get the CODEC pointer from the widget
      ASoC: wm5102: Add missing routes for ASRC inputs
      ASoC: arizona: Suppress noop FLL updates
      ASoC: wm0010: Ignore interrupts in power down mode
      ASoC: pcm: Report error code when we fail to init platform
      Merge tag 'v3.7-rc7' into asoc-ux500
      Merge tag 'v3.7-rc7' into asoc-wm2200
      ASoC: arizona: Record FLL setting when disabling
      mfd: arizona: Allow the CODEC DAPM context to be accessed elsewhere
      Input - arizona-haptics: Add driver haptics module on Arizona CODECs
      ASoC: wm5102: Implement haptics support
      ASoC: wm5110: Implement haptics support
      mfd: arizona: Register haptics devices
      ASoC: wm8994: Use the same DCS codes for all WM1811 variants
      ASoC: wm_adsp: Enable DVFS for ADSP2
      Merge branch 'topic/adsp' of git://git.kernel.org/.../broonie/sound i=
nto asoc-arizona
      ASoC: wm5102: Enable DVFS support for the DSP
      ASoC: wm_adsp: Set the core enable as well as start bit for ADSP2
      Merge branches 'topic/omap' and 'topic/arizona' of git://git.kernel.o=
rg/.../broonie/sound into asoc-next
      ASoC: arizona: Add parentheses
      Merge branches 'fix/fsl', 'topic/ab8500', 'topic/adsp', 'topic/ak4104=
', 'topic/ak4535', 'topic/ak4642', 'topic/atmel', 'topic/cs4271', 'topic/da=
7210', 'topic/da9055', 'topic/davinci', 'topic/dmaengine', 'topic/fsi', 'to=
pic/fsl', 'topic/hotplug', 'topic/jack', 'topic/jz4740', 'topic/kirkwood', =
'topic/lm49453', 'topic/log', 'topic/max98090', 'topic/rt5631', 'topic/sams=
ung', 'topic/si476x', 'topic/tlv320aic32x4', 'topic/ux500', 'topic/wm0010',=
 'topic/wm2000', 'topic/wm2200', 'topic/wm8350', 'topic/wm8400', 'topic/wm8=
510', 'topic/wm8741', 'topic/wm8750', 'topic/wm8753', 'topic/wm8770', 'topi=
c/wm8804', 'topic/wm8962', 'topic/wm8971', 'topic/wm8978', 'topic/wm8985', =
'topic/wm8988', 'topic/wm8993', 'topic/wm8994' and 'topic/wm8995' of git://=
git.kernel.org/.../broonie/sound into asoc-next

Matt Porter (2):
      ASoC: davinci: replace private sram api with genalloc
      ARM: davinci: enable SRAM ping ping buffering on DA850

Nicolas Ferre (1):
      ASoC: atmel-ssc: add phybase in device structure

Padmavathi Venna (1):
      ASoC: Samsung: Get I2S src_clk from clock alias id.

Peter Ujfalusi (1):
      ASoC: omap-abe-twl6040: Use "ti,jack-detection" DT property as boolean

Randy Dunlap (1):
      ASoC: fix wm2200.c printk format warnings

Russell King (5):
      ASoC: kirkwood-i2s: use devm_* APIs
      ASoC: kirkwood-i2s: better handling of play/record control registers
      ASoC: kirkwood-dma: remove restriction on sample rates
      ASoC: kirkwood-i2s: add support for external clock rates
      ASoC: kirkwood-dma: remove channel restrictions

Sachin Kamat (9):
      ASoC: rt5631: Fix return value
      ASoC: wm8350: Use devm_regulator_bulk_get
      ASoC: wm8962: Use devm_regulator_bulk_get
      ASoC: wm8400: Use devm_regulator_bulk_get
      ASoC: wm8993: Use devm_regulator_bulk_get
      ASoC: ak4535: Use devm_regmap_init_i2c()
      ASoC: da7210: Use devm_regmap_init_i2c()
      ASoC: lm49453: Use devm_regmap_init_i2c()
      ASoC: wm2200: Remove empty labels

Scott Ling (4):
      ASoC: wm0010: Remove boot_done variable as no longer required.
      ASoC: wm0010: Split out the firmware file parsing from the boot
      ASoC: wm0010: Split out the stage2 load from the boot function
      ASoC: wm0010: Add checking for .dfw info record version.

Thomas Abraham (4):
      ASoC: SAMSUNG: ac97: use clk_prepare_enable and clk_disable_unprepare
      ASoC: SAMSUNG: i2s: use clk_prepare_enable and clk_disable_unprepare
      ASoC: SAMSUNG: pcm: use clk_prepare_enable and clk_disable_unprepare
      ASoC: SAMSUNG: spdif: use clk_prepare_enable and clk_disable_unprepare

Timur Tabi (1):
      ASoC: add support for the Freescale / iVeia P1022 RDK reference board

Tony Lindgren (1):
      ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform support

Tushar Behera (10):
      ASoC: wm8510: remove invalid free of devm_ allocated data
      ASoC: wm8753: remove invalid free of devm_ allocated data
      ASoC: wm8995: Convert to use devm_kzalloc()
      ASoC: wm8741: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: wm8753: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: wm8995: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: wm8804: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: wm8985: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: wm8988: Convert to use devm_regmap_init_{spi,i2c}()
      ASoC: ak4104: Convert to use devm_regmap_init_spi()

Ulf Hansson (2):
      ASoC: Ux500: Fixup use of clocks
      ASoC: Ux500: Control apb clock

Wei Yongjun (1):
      ASoC: jack: remove unused variable in snd_soc_jack_report()

 .../devicetree/bindings/misc/atmel-ssc.txt         |   15 +
 Documentation/devicetree/bindings/sound/ak4104.txt |   22 +
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 +
 Documentation/devicetree/bindings/sound/cs4271.txt |    2 +
 .../devicetree/bindings/sound/omap-abe-twl6040.txt |    4 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    8 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   16 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   32 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    8 +
 arch/arm/mach-at91/at91rm9200.c                    |    9 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |    6 +-
 arch/arm/mach-at91/at91sam9260.c                   |    3 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |    2 +-
 arch/arm/mach-at91/at91sam9261.c                   |    9 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |    6 +-
 arch/arm/mach-at91/at91sam9263.c                   |    6 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |    4 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    6 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |    4 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    6 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |    4 +-
 arch/arm/mach-at91/at91sam9x5.c                    |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c               |   11 +
 arch/arm/mach-davinci/board-da850-evm.c            |   24 +-
 drivers/base/regmap/internal.h                     |    2 +
 drivers/base/regmap/regmap-debugfs.c               |   50 +-
 drivers/base/regmap/regmap.c                       |  154 +++--
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/arizona-haptics.c               |  255 ++++++++
 drivers/mfd/arizona-core.c                         |    2 +
 drivers/mfd/wm8994-core.c                          |   35 +-
 drivers/misc/atmel-ssc.c                           |  135 ++--
 include/linux/atmel-ssc.h                          |    6 +
 include/linux/mfd/arizona/core.h                   |    4 +
 include/linux/mfd/arizona/pdata.h                  |    6 +
 include/linux/mfd/wm8994/core.h                    |    4 +
 include/linux/mfd/wm8994/pdata.h                   |    5 +
 include/linux/platform_data/asoc-s3c.h             |    6 -
 include/linux/platform_data/davinci_asp.h          |    3 +
 include/linux/regmap.h                             |    6 +-
 include/sound/cs4271.h                             |    1 +
 include/sound/sh_fsi.h                             |    6 +
 include/sound/tlv320aic32x4.h                      |    1 +
 sound/soc/atmel/Kconfig                            |    3 +-
 sound/soc/atmel/atmel-pcm.c                        |   23 +-
 sound/soc/atmel/atmel-pcm.h                        |    3 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  157 ++---
 sound/soc/atmel/atmel_ssc_dai.h                    |    3 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |  116 +++-
 sound/soc/codecs/Kconfig                           |   16 +
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/ab8500-codec.c                    |    2 +-
 sound/soc/codecs/ak4104.c                          |   65 +-
 sound/soc/codecs/ak4535.c                          |    7 +-
 sound/soc/codecs/ak4642.c                          |   23 +-
 sound/soc/codecs/arizona.c                         |   21 +
 sound/soc/codecs/arizona.h                         |   65 +-
 sound/soc/codecs/cs4271.c                          |   21 +-
 sound/soc/codecs/da7210.c                          |   13 +-
 sound/soc/codecs/da9055.c                          |   43 +-
 sound/soc/codecs/jz4740.c                          |  142 ++---
 sound/soc/codecs/lm49453.c                         |   10 +-
 sound/soc/codecs/max98088.c                        |   14 +-
 sound/soc/codecs/max98090.c                        |  577 +++++++++++++++++
 sound/soc/codecs/rt5631.c                          |    2 +-
 sound/soc/codecs/si476x.c                          |  255 ++++++++
 sound/soc/codecs/tlv320aic32x4.c                   |   24 +
 sound/soc/codecs/tlv320aic32x4.h                   |    3 +
 sound/soc/codecs/wm0010.c                          |  419 +++++++-----
 sound/soc/codecs/wm2000.c                          |    2 +-
 sound/soc/codecs/wm2200.c                          |  269 ++++++--
 sound/soc/codecs/wm5100.c                          |    2 +-
 sound/soc/codecs/wm5102.c                          |  120 ++--
 sound/soc/codecs/wm5110.c                          |   49 +-
 sound/soc/codecs/wm8350.c                          |    4 +-
 sound/soc/codecs/wm8400.c                          |   14 +-
 sound/soc/codecs/wm8510.c                          |    3 -
 sound/soc/codecs/wm8741.c                          |    4 +-
 sound/soc/codecs/wm8750.c                          |   86 ++-
 sound/soc/codecs/wm8753.c                          |   33 +-
 sound/soc/codecs/wm8770.c                          |  217 ++++---
 sound/soc/codecs/wm8804.c                          |   17 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   79 +--
 sound/soc/codecs/wm8962.c                          |    7 +-
 sound/soc/codecs/wm8971.c                          |   80 ++-
 sound/soc/codecs/wm8978.c                          |    3 -
 sound/soc/codecs/wm8985.c                          |   30 +-
 sound/soc/codecs/wm8988.c                          |   14 +-
 sound/soc/codecs/wm8993.c                          |    7 +-
 sound/soc/codecs/wm8994.c                          |  184 +++---
 sound/soc/codecs/wm8994.h                          |    1 -
 sound/soc/codecs/wm8995.c                          |   40 +-
 sound/soc/codecs/wm_adsp.c                         |  666 ++++++++++++++++=
++++
 sound/soc/codecs/wm_adsp.h                         |   59 ++
 sound/soc/codecs/wmfw.h                            |  128 ++++
 sound/soc/davinci/davinci-evm.c                    |    5 +
 sound/soc/davinci/davinci-mcasp.c                  |   93 ++-
 sound/soc/davinci/davinci-mcasp.h                  |    2 +-
 sound/soc/davinci/davinci-pcm.c                    |   53 +-
 sound/soc/davinci/davinci-pcm.h                    |    2 +
 sound/soc/fsl/Kconfig                              |   20 +-
 sound/soc/fsl/Makefile                             |   14 +-
 sound/soc/fsl/imx-pcm.c                            |    4 +
 sound/soc/fsl/imx-sgtl5000.c                       |    1 +
 sound/soc/fsl/p1022_rdk.c                          |  392 ++++++++++++
 sound/soc/fsl/pcm030-audio-fabric.c                |    4 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |   16 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |  235 ++++---
 sound/soc/kirkwood/kirkwood.h                      |   11 +-
 sound/soc/mxs/mxs-saif.c                           |    2 +
 sound/soc/omap/mcbsp.c                             |    4 +-
 sound/soc/omap/mcbsp.h                             |    6 +
 sound/soc/omap/omap-abe-twl6040.c                  |    4 +-
 sound/soc/omap/omap-mcbsp.c                        |    5 +-
 sound/soc/samsung/ac97.c                           |    6 +-
 sound/soc/samsung/bells.c                          |  222 +++++--
 sound/soc/samsung/i2s.c                            |   20 +-
 sound/soc/samsung/pcm.c                            |   12 +-
 sound/soc/samsung/spdif.c                          |   12 +-
 sound/soc/sh/fsi.c                                 |  550 ++++++++++++++--
 sound/soc/soc-cache.c                              |   10 +-
 sound/soc/soc-core.c                               |  243 +++----
 sound/soc/soc-dapm.c                               |  134 ++--
 sound/soc/soc-dmaengine-pcm.c                      |    2 +
 sound/soc/soc-jack.c                               |   16 +-
 sound/soc/soc-pcm.c                                |  195 +++---
 sound/soc/tegra/tegra20_das.c                      |    2 +-
 sound/soc/tegra/tegra20_i2s.c                      |    4 +-
 sound/soc/tegra/tegra20_spdif.c                    |    2 +-
 sound/soc/tegra/tegra30_ahub.c                     |    6 +-
 sound/soc/tegra/tegra30_i2s.c                      |    4 +-
 sound/soc/tegra/tegra_alc5632.c                    |    2 +-
 sound/soc/tegra/tegra_wm8753.c                     |    2 +-
 sound/soc/tegra/tegra_wm8903.c                     |    2 +-
 sound/soc/tegra/trimslice.c                        |    2 +-
 sound/soc/ux500/mop500.c                           |    4 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   55 +-
 sound/soc/ux500/ux500_msp_dai.h                    |    1 +
 sound/soc/ux500/ux500_pcm.c                        |   19 +-
 sound/soc/ux500/ux500_pcm.h                        |    3 +
 142 files changed, 5700 insertions(+), 1796 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/atmel-ssc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g=
20ek-wm8731-audio.txt
 create mode 100644 drivers/input/misc/arizona-haptics.c
 create mode 100644 sound/soc/codecs/max98090.c
 create mode 100644 sound/soc/codecs/si476x.c
 create mode 100644 sound/soc/codecs/wm_adsp.c
 create mode 100644 sound/soc/codecs/wm_adsp.h
 create mode 100644 sound/soc/codecs/wmfw.h
 create mode 100644 sound/soc/fsl/p1022_rdk.c

--8RJ6MkOGpKElHlfH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQt4jcAAoJELSic+t+oim9N5gQAIX6VqOW8O9Jwa48FQyoX8fw
SHnxadi2+DCUKtyeurllq0WJhqtDQxnAlmir+epS1yCBXid9OFizfUYYrCyByMGu
DBqV0tEqq7LOaFZ7Zps8k3kiB/x01dibLTJKc9uUjfS5+qrGK6deoKhKLdxwkJx2
3jVO2kvyDt5h5ewrJ6VSHcpysBDUXwkVjGZc8lD4PilN7gP543VRrVrL9ZyWey4p
gl5klblZk9Vj9Y2wOobt1rUIf+oEq6x+BA4TWkQk1yaMeaje5jhlSpuhTg9COk97
uO3FdsoY75wNk7goXpYT3eT/iL5iFlijCrxDJBEQ0Em+8CTb5+nsAidX/g/aCVyH
CSTuYQFhJySnL2eYvgYnl0bZ6EGYc8AB0gHvWOKjgmgMMGXnfL7lTzevEOzwoNfY
nG2MumCANifGR9rbCjdOh7lkmU4Kf5lg4pv1MBZilX1/+u/uWzAmHX16q8JwmAfW
IbCMoO2/UCBG6P4nSnUSnFiTbquVdzNDN2XaYRc4S6Du/GWxWwDF/vhWbtki4UuW
NxvPqsPRHbw9SLKEfLDBaZjId+VygE43JcPTAARCro/e86vy+TWOAaEvbBG/dwwe
+6r7uZ52tuc2J9+JS86tGoOSBvKnuBmPrh0HRqiAMC9C/rRvcK0bdIyndtptyP/B
IOPCtH9Tk8LqVgd832u1
=55kW
-----END PGP SIGNATURE-----

--8RJ6MkOGpKElHlfH--

--===============5974406457326972818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5974406457326972818==--
