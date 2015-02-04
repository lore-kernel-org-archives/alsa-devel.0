From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.20
Date: Wed, 4 Feb 2015 21:04:59 +0000
Message-ID: <20150204210459.GN21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0952040998926148065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51FE72605CA
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 22:05:07 +0100 (CET)
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


--===============0952040998926148065==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZC+j7nfuMCqViNoE"
Content-Disposition: inline


--ZC+j7nfuMCqViNoE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:

  Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.20-2

for you to fetch changes up to 16ca41c6cc904d7eb9e92afc5f576e375c314f90:

  Merge remote-tracking branches 'asoc/topic/wm8960', 'asoc/topic/wm8988' a=
nd 'asoc/topic/xtfpga' into asoc-next (2015-02-04 20:57:26 +0000)

----------------------------------------------------------------
ASoC: Updates for v3.20

More updates for v3.20:

 - Lots of refactoring from Lars-Peter Clausen, moving drivers to more
   data driven initialization and rationalizing a lot of DAPM usage.
 - Much improved handling of CDCLK clocks on Samsung I2S controllers.
 - Lots of driver specific cleanups and feature improvements.
 - CODEC support for TI PCM514x and TLV320AIC3104 devices.
 - Board support for Tegra systems with Realtek RT5677.

----------------------------------------------------------------
Alexander Morozov (1):
      ASoC: wm8904: add dt ids table

Alexandre Belloni (2):
      ASoC: atmel: sam9g20_wm8731: remove useless include
      Asoc: sam9x5_wm8731: depend on ARCH_AT91 instead of SOC_AT91SAM9X5

Anatol Pomozov (3):
      ASoC: tegra: Add platform driver for rt5677 audio codec
      ASoC: ts3a227e: Remap keys to match Android headset specification
      ASoC: ts3a227e: Add dts property that allows to specify micbias volta=
ge

Andrew Jackson (9):
      ASoC: dwc: Remove unnecessary debug messages and tests
      ASoC: dwc: Reorder code in preparation for DT support
      ASoC: dwc: Switch to managed clock resource
      ASoC: dwc: Read I2S block configuration from registers
      ASoC: dwc: Prepare clock before use
      ASoC: dwc: Register components with managed interface
      ASoC: dwc: Add documentation for I2S DT
      ASoC: dwc: Add devicetree support for Designware I2S
      ASoC: dwc: Remove unnecessary conditional compilation

Arnd Bergmann (3):
      ASoC: davinci: fix DM365_EVM codec selection
      ASoC: rt5677: fix SPI dependency
      ASoC: pxa: make TTC DKB tristate

Bard Liao (6):
      ASoC: rt5670: set platform data by dmi
      ASoC: rt5670: Add runtime PM support
      ASoC: rt5670: Keep sysclk on if JD func is used
      ASoC: rt5670: redefine ASRC control registers 0x84 and 0x85
      ASoC: rt286: Fix capture volume setting issue
      ASoC: rt5645: Add rt5650 codec support

Bo Shen (7):
      ASoC: atmel_ssc_dai: fix start event for I2S mode
      ASoC: atmel_ssc_dai: remove clock pin comments
      ASoC: wm8904: add new compatible string
      ASoC: atmel_ssc_dai: fix the setting for DSP mode
      ASoC: atmel_ssc_dai: refactor the startup and shutdown
      ASoC: atmel_ssc_dai: only clean PDC when using PDC
      ASoC: atmel-pcm-dma: won't check direction when configure dma

Charles Keepax (2):
      ASoC: arizona: Add delay for output disable
      ASoC: arizona: Coalesce output power up delays

Dan Carpenter (1):
      ASoC: Intel: remove an unused struct member

Eric Nelson (1):
      ASoC: sgtl5000: add delay before first I2C access

Fabio Estevam (10):
      ASoC: fsl_spdif: Use dev_name() for registering the irq
      ASoC: fsl_asrc: Use dev_name() for registering the irq
      ASoC: mxs-saif: Do not store the irq number in the private structure
      ASoC: fsl_ssi: Make error message concise
      ASoC: fsl_asrc: Make error message concise
      ASoC: fsl_sai: Make error message concise
      ASoC: fsl_esai: Make error message concise
      ASoC: fsl_spdif: Make error message concise
      ASoC: fsl_ssi: Change irq type to 'int'
      ASoC: fsl: imx-spdif: Set the card owner field

Fang, Yang A (1):
      ASoC: Intel: Add support rt5645 in sst driver

Filip Brozovic (1):
      ASoC: sgtl5000: Use shift mask when setting codec mode

Jarkko Nikula (2):
      ASoC: pcm: Fix vague codec and cpu DAI prepare error messages
      ASoC: rt5640: Add RT5642 ACPI ID for Intel Baytrail

Jianqun Xu (1):
      ASoC: rockchip: i2s: set TDL and RDL to 16 samples

Jie Yang (8):
      ASoC: Intel: Store the entry_point read from FW file
      ASoC: Intel: Always enable DRAM block for FW dump
      ASoC: Intel: Add stream direction for pcm-module map
      ASoC: Intel: Split hsw_pcm_data for playback and capture
      ASoC: Intel: initial stream_hw_id to invalid value
      ASoC: Intel: Used lock version to update shim registers
      MAINTAINERS: ASoC: add maintainer for Intel BDW/HSW ASoC driver
      ASoC: Intel: initial scalar variable ba

Jyri Sarha (3):
      ASoC: simple-card: Enable and disable DAI clocks as needed
      ASoC: tlv320aic3x: Add support for tlv320aic3104
      ASoC: tlv320aic3x: Fix bad comment before intercon_extra_3104 definit=
ion

Krzysztof Kozlowski (8):
      ASoC: alc5632: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: cs35l32: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: cs42l52: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: cs42l56: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: cs42l73: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: wm8804: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: wm8988: Constify struct regmap_config and snd_soc_codec_driver
      ASoC: wm8804: Constify struct regmap_config and snd_soc_codec_driver

Kuninori Morimoto (19):
      ASoC: rsnd: add recovery support for under/over flow error on SRC
      ASoC: rsnd: remove unsed .rate
      ASoC: rsnd: tidyup rsnd_io_to_xxx() macro declaration position
      ASoC: rsnd: rsnd_mod controls clock
      ASoC: rsnd: rename rsnd_dai_get() to rsnd_rdai_get()
      ASoC: rsnd: rename rsnd_dai_is_clk_master() to rsnd_rdai_is_clk_maste=
r()
      ASoC: rsnd: remove unused rsnd_dai_id()
      ASoC: rsnd: remove rsnd_dai_get_platform_info() macro
      ASoC: rsnd: add rsnd_io_to_rdai()
      ASoC: rsnd: replace rsnd_dai_is_play() to rsnd_io_is_play()
      ASoC: rsnd: remove unsed rdai parameter from each function
      ASoC: rsnd: replace rdai to priv in each function
      ASoC: rsnd: save priv in struct rsnd_dai
      ASoC: rsnd: error meesage indicates its port
      ASoC: rsnd: ignore DIRQ when DMA transfer
      ASoC: rsnd: tidyup DMA start/stop timing on SSI
      ASoC: rsnd: tidyup DVC/SRC/SSI order
      ASoC: rsnd: call missing snd_ctl_remove()
      ASoC: rsnd: call missing snd_soc_unregiter_component/platform()

Lad, Prabhakar (1):
      ASoC: ts3a227e: fix sparse warning

Lars-Peter Clausen (109):
      ASoC: wm8750: Make VREF a VMID instead of OUTPUT widget
      ASoC: wm8750: Cleanup manual bias level transitions
      ASoC: dapm: Don't mark MICBIAS widgets as auto non-connected
      ASoC: dapm: Simplify fully route card handling
      ASoC: dmaengine: Remove unnecessary snd_pcm_lib_preallocate_free_for_=
all()
      ASoC: au1x: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: nuc900: Remove unnecessary snd_pcm_lib_preallocate_free_for_all=
()
      ASoC: rcar: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: sh: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: txx9: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: broadwell: Drop unnecessary snd_soc_dapm_enable() calls
      ASoC: byt-rt5640: Fix snd_soc_dapm_ignore_suspend() calls
      ASoC: byt-rt5640: Register microphone routes with the card DAPM conte=
xt
      ASoC: intel: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()
      ASoC: sam9g20_wm8731: Use static DAI format setup
      ASoC: db1200: Use static DAI format setup
      ASoC: eureka-tlv320: Use static DAI format setup
      ASoC: mx27vis-aci32x4: Use static DAI format setup
      ASoC: wm1133-ev1: Use static DAI format setup
      ASoC: mxs-sgtl5000: Use static DAI format setup
      ASoC: ams-delta: Use static DAI format setup
      ASoC: raumfeld: Use static DAI format setup
      ASoC: zylonite: Use static DAI format setup
      ASoC: goni_wm8994: Use static DAI format setup
      ASoC: h1940_uda1380: Use static DAI format setup
      ASoC: jive_wm8750: Use static DAI format setup
      ASoC: neo1973_wm8753: Use static DAI format setup
      ASoC: rx1950_uda1380: Use static DAI format setup
      ASoC: s3c24xx_simtec: Use static DAI format setup
      ASoC: s3c24xx_uda134x: Use static DAI format setup
      ASoC: smartq_wm8987: Use static DAI format setup
      ASoC: smdk_wm8580: Use static DAI format setup
      ASoC: smdk_wm8570pcm: Use static DAI format setup
      ASoC: smdk_wm8994pcm: Use static DAI format setup
      ASoC: migor: Use static DAI format setup
      ASoC: Add helper function for changing the DAI link format
      ASoC: omap-twl4030: Use snd_soc_runtime_set_dai_fmt()
      ASoC: mop500_ab8500: Use snd_soc_runtime_set_dai_fmt()
      ASoC: Export snd_soc_runtime_set_dai_fmt()
      ASoC: ttc-dkb: Remove unnecessary snd_soc_dapm_disable_pin() calls
      ASoC: corgi: Automatically disconnect non-connected pins
      ASoC: e740: Automatically disconnect non-connected pins
      ASoC: e750: Automatically disconnect non-connected pins
      ASoC: hx4700: Automatically disconnect non-connected pins
      ASoC: magician: Automatically disconnect non-connected pins
      ASoC: palm27x: Fix microphone route
      ASoC: palm27x: Automatically disconnect non-connected pins
      ASoC: spitz: Automatically disconnect non-connected pins
      ASoC: ad193x: Don't power down DAC in CODEC probe
      ASoC: mc13783: Update set_tdm_slot() semantics
      ASoC: fsl: Update set_tdm_slot() semantics
      ASoC: fsl: Remove fsl_asoc_xlate_tdm_slot_mask()
      ASoC: Update snd_soc_dai_set_tdm_slot() documentation
      ASoC: 88pm860x: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: ak4671: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: da732x: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: sgtl5000: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: sn95031: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: arizona: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm2000: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm5102: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm5102: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm5110: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8350: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8400: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8731: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8770: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8900: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8903: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8904: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8955: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8961: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8961: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8962: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8988: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8990: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8991: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8993: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8995: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8995: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8996: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm8997: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm9081: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm9090: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm9713: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm_adsp: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: wm_hubs: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: mioa701_wm9713: Fix speaker event
      ASoC: pcm3008: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: tlv320aic31xx: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: tlv320aic3x: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: tlv320dac33: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: twl4030: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: twl6040: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: alc5623: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: alc5632: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt286: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5631: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5640: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5645: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5651: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: rt5677: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: Remove codec field from snd_soc_dapm_widget
      ASoC: jive: Automatically disconnect non-connected pins
      ASoC: smdk_wm8580: Pass card DAPM context to snd_soc_dapm_disable_pin=
()
      ASoC: samsung: Replace depends on REGMAP_I2C with depends on I2C
      ASoC: Add support for allocating AC'97 device before registering it
      ASoC: wm97xx: Reset AC'97 device before registering it

Manuel Lauss (1):
      ASoC: wm8731: init mutex in i2c init path

Mark Brown (27):
      ASoC: dapm: Don't use async I/O
      Merge branch 'topic/rt5670' of git://git.kernel.org/.../broonie/sound=
 into asoc-intel
      Merge remote-tracking branch 'asoc/fix/fsl-ssi' into asoc-fsl
      Merge branch 'topic/rt5677' of git://git.kernel.org/.../broonie/sound=
 into asoc-w-codec
      Merge branch 'topic/dai' of git://git.kernel.org/.../broonie/sound in=
to asoc-samsung
      Merge branch 'fix/atmel' of git://git.kernel.org/.../broonie/sound in=
to asoc-atmel
      Merge branch 'topic/rt286' of git://git.kernel.org/.../broonie/sound =
into asoc-w-codec
      Merge branch 'fix/rt5677' of git://git.kernel.org/.../broonie/sound i=
nto asoc-w-codec
      Merge branch 'topic/arizona' of git://git.kernel.org/.../broonie/soun=
d into asoc-w-codec
      Merge remote-tracking branches 'asoc/fix/ac97', 'asoc/fix/atmel', 'as=
oc/fix/intel', 'asoc/fix/rt286', 'asoc/fix/rt5640', 'asoc/fix/sgtl5000', 'a=
soc/fix/sta32x', 'asoc/fix/tlv320aic3x' and 'asoc/fix/wm8731' into asoc-lin=
us
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dmaengine' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/w-codec' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ad193x', 'asoc/topic/alc56=
32', 'asoc/topic/atmel' and 'asoc/topic/au1x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/bt-sco', 'asoc/topic/cs35l=
32', 'asoc/topic/cs42l52' and 'asoc/topic/cs42l56' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l73', 'asoc/topic/dai'=
 and 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branches 'asoc/topic/doc', 'asoc/topic/dwc', 'a=
soc/topic/fsi', 'asoc/topic/fsl' and 'asoc/topic/fsl-asrc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-spdif', 'asoc/topic/im=
x', 'asoc/topic/intel', 'asoc/topic/mxs-saif' and 'asoc/topic/nuc900' into =
asoc-next
      Merge remote-tracking branches 'asoc/topic/omap', 'asoc/topic/pxa' an=
d 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rockchip', 'asoc/topic/rt5=
645' and 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rx51', 'asoc/topic/samsung=
', 'asoc/topic/sh', 'asoc/topic/simple' and 'asoc/topic/sta32x' into asoc-n=
ext
      Merge remote-tracking branches 'asoc/topic/tdm-slot', 'asoc/topic/teg=
ra', 'asoc/topic/tlv320aic3x', 'asoc/topic/ts3a227e' and 'asoc/topic/ts3a27=
7e' into asoc-next
      Merge remote-tracking branches 'asoc/topic/txx9', 'asoc/topic/wm8750'=
, 'asoc/topic/wm8804' and 'asoc/topic/wm8904' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8960', 'asoc/topic/wm898=
8' and 'asoc/topic/xtfpga' into asoc-next

Markus Elfring (3):
      ASoC: Intel: Delete an unnecessary check before the function call "ss=
t_dma_free"
      ASoC: fsi: Deletion of unnecessary checks before the function call "c=
lk_enable"
      ASoC: Intel: Delete an unnecessary check before the function call "re=
lease_firmware"

Masanari Iida (2):
      ASoC: Fix typo in bt-sco.c
      ASoC: Fix warning with make xmldocs caused by soc-devres.c

Max Filippov (1):
      ASoC: add xtensa xtfpga I2S interface and platform

Mengdong Lin (2):
      ASoC: rt5670: add API to select ASRC clock source
      ASoC: Intel: Select RT5672 ASRC clock source on Cherrytrail and Brasw=
ell

Oder Chiou (6):
      ASoC: rt5677: Revise the filter powers
      ASoC: rt5677: Add the ASRC support
      ASoC: rt5677: Adjust the routing of "PLL1"
      ASoC: rt5677: Add the MICBIAS VDD setting in the platform data
      ASoC: rt5677: Use the regmap functions instead of the snd_soc functio=
ns
      ASoC: rt5677: Add the slot_width "25" support in the TDM mode

Peter Rosin (10):
      ASoC: pcm512x: Also support PCM514x devices
      ALSA: pcm: Add snd_interval_ranges() and snd_pcm_hw_constraint_ranges=
()
      ASoC: pcm512x: Fix spelling of register field names.
      ASoC: pcm512x: Support mastering BCLK/LRCLK without using the PLL
      ASoC: pcm512x: Support mastering BCLK/LRCLK using the PLL
      ASoC: pcm512x: Avoid the PLL for the DAC clock, if possible
      ASoC: pcm512x: Support SND_SOC_DAIFMT_CBM_CFS
      ASoC: pcm512x: Fixup warning splat
      ASoC: pcm512x: Use the correct range constraints for S24_LE
      ASoC: atmel_ssc_dai: Support SND_SOC_DAIFMT_CBM_CFS on I2S

Peter Ujfalusi (7):
      ASoC: davinci-mcasp: Support for combined tx/rx interrupt line
      ASoC: rx51: Correct DAPM route for capture
      ASoC: tlv320aic3x: Fix data delay configuration
      ASoC: davinci-evm: Do not include edma headers
      ASoC: davinci-evm: Do not include davinci-pcm.h and davinci-i2s.h
      ASoC: davicni-mcasp: Mark the common irq line as shared
      ASoC: davinci-mcasp: Fix DIT only McASP instance support

Sylwester Nawrocki (13):
      ASoC: samsung: i2s: Remove unused gpios field from struct i2s
      ASoC: samsung: i2s: samsung_i2s_get_driver_data() cleanup
      ASoC: samsung: i2s: Add return value checks in probe()
      ASoC: samsung: i2s: Request memory region in driver probe()
      ASoC: samsung: i2s: Move clk_get() to platform driver probe()
      ASoC: samsung: i2s: Move clk enable to the platform driver probe()
      ASoC: samsung: i2s: Add get_other_dai helper function
      ASoC: samsung: i2s: Remove an unneeded goto usage
      ASoC: samsung: i2s: Add spinlock in place of local_irq_* calls
      ASoC: samsung: i2s: Protect more registers with a spinlock
      ASoC: samsung: odroidx2: Handle I2S CDCLK clock conditionally
      ASoC: samsung: i2s: Add clk provider DT binding documentation
      ASoC: samsung: i2s: Add clock provider for the I2S internal clocks

Takashi Iwai (2):
      ASoC: intel: Remove superfluous backslash in Kconfig
      ASoC: Add sysfs entries via static attribute groups

Thomas Niederpr=FCm (9):
      ASoC: sta32x: correct bit shift value for IDE register
      ASoC: sta32x: Convert to direct regmap API usage.
      ASoC: sta32x: make sta32x a gpio consumer for the reset GPIO
      ASoC: sta32x: use DECLARE_TLV_DB_RANGE macro.
      ASoC: sta32x: move code to calculate mclk divider and extrapolation r=
atio to sta32x_hw_params()
      ASoC: sta32x: add device tree binding.
      ASoC: sta32x: use dev_dbg() for debug output.
      ASoC: sta32x: minor Kconfig update.
      ASoC: sta32x: change dai name to be in line with the sta350 driver.

Vaishali Thakkar (1):
      ASoC: wm5102: Use put_unaligned_be16

Wei Yongjun (1):
      ASoC: Intel: fix sparse non static symbol warnings

Wolfram Sang (4):
      ASoC: intel: sst: drop owner assignment from platform_drivers
      ASoC: omap: drop owner assignment from platform_drivers
      ASoC: pxa: drop owner assignment from platform_drivers
      ASoC: samsung: drop owner assignment from platform_drivers

Zidan Wang (1):
      ASoC: wm8960: Let wm8960 codec driver manage its own MCLK

kbuild test robot (2):
      ASoC: Intel: fix platform_no_drv_owner.cocci warnings
      ASoC: Intel: fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/sound/cdns,xtfpga-i2s.txt  |  18 +
 .../devicetree/bindings/sound/designware-i2s.txt   |  31 +
 .../bindings/sound/nvidia,tegra-audio-rt5677.txt   |  67 ++
 .../devicetree/bindings/sound/pcm512x.txt          |  28 +-
 .../devicetree/bindings/sound/samsung-i2s.txt      |  22 +
 .../devicetree/bindings/sound/simple-card.txt      |   5 +
 .../devicetree/bindings/sound/st,sta32x.txt        |  92 ++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |  10 +-
 .../devicetree/bindings/sound/ts3a227e.txt         |   5 +
 Documentation/devicetree/bindings/sound/wm8904.txt |   2 +-
 MAINTAINERS                                        |  11 +
 include/dt-bindings/sound/samsung-i2s.h            |   8 +
 include/sound/pcm.h                                |  12 +
 include/sound/rcar_snd.h                           |   1 +
 include/sound/rt5677.h                             |   3 +
 include/sound/simple_card.h                        |   1 +
 include/sound/soc-dapm.h                           |   4 +-
 include/sound/soc.h                                |   4 +
 include/sound/sta32x.h                             |  18 +-
 sound/core/pcm_lib.c                               |  85 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/atmel/Kconfig                            |   2 +-
 sound/soc/atmel/atmel-pcm-dma.c                    |  12 +-
 sound/soc/atmel/atmel_ssc_dai.c                    | 132 +--
 sound/soc/atmel/sam9g20_wm8731.c                   |  31 +-
 sound/soc/au1x/db1200.c                            |  19 +-
 sound/soc/au1x/dbdma2.c                            |   6 -
 sound/soc/au1x/dma.c                               |   6 -
 sound/soc/codecs/88pm860x-codec.c                  |   4 +-
 sound/soc/codecs/Kconfig                           |   6 +-
 sound/soc/codecs/ad193x.c                          |   4 +-
 sound/soc/codecs/ak4671.c                          |   2 +-
 sound/soc/codecs/alc5623.c                         |   8 +-
 sound/soc/codecs/alc5632.c                         |  12 +-
 sound/soc/codecs/arizona.c                         |  78 +-
 sound/soc/codecs/arizona.h                         |   5 +
 sound/soc/codecs/bt-sco.c                          |   2 +-
 sound/soc/codecs/cs35l32.c                         |   4 +-
 sound/soc/codecs/cs42l52.c                         |   4 +-
 sound/soc/codecs/cs42l56.c                         |   4 +-
 sound/soc/codecs/cs42l73.c                         |   4 +-
 sound/soc/codecs/da732x.c                          |   4 +-
 sound/soc/codecs/mc13783.c                         |  10 +-
 sound/soc/codecs/pcm3008.c                         |   4 +-
 sound/soc/codecs/pcm512x-i2c.c                     |   4 +
 sound/soc/codecs/pcm512x-spi.c                     |   4 +
 sound/soc/codecs/pcm512x.c                         | 932 +++++++++++++++++=
+++-
 sound/soc/codecs/pcm512x.h                         | 109 ++-
 sound/soc/codecs/rt286.c                           |  51 +-
 sound/soc/codecs/rt5631.c                          |  28 +-
 sound/soc/codecs/rt5640.c                          |  12 +-
 sound/soc/codecs/rt5645.c                          | 174 +++-
 sound/soc/codecs/rt5645.h                          |  15 +
 sound/soc/codecs/rt5651.c                          |  18 +-
 sound/soc/codecs/rt5670.c                          | 137 ++-
 sound/soc/codecs/rt5670.h                          |  80 +-
 sound/soc/codecs/rt5677.c                          | 243 +++++-
 sound/soc/codecs/sgtl5000.c                        |  27 +-
 sound/soc/codecs/sn95031.c                         |  33 +-
 sound/soc/codecs/sta32x.c                          | 534 +++++++-----
 sound/soc/codecs/sta32x.h                          |   2 +-
 sound/soc/codecs/tlv320aic31xx.c                   |   9 +-
 sound/soc/codecs/tlv320aic3x.c                     | 349 +++++---
 sound/soc/codecs/tlv320dac33.c                     |   9 +-
 sound/soc/codecs/ts3a227e.c                        |  35 +-
 sound/soc/codecs/twl4030.c                         |  55 +-
 sound/soc/codecs/twl6040.c                         |   4 +-
 sound/soc/codecs/wm2000.c                          |   2 +-
 sound/soc/codecs/wm5100.c                          |   5 +-
 sound/soc/codecs/wm5102.c                          |  23 +-
 sound/soc/codecs/wm5110.c                          |  20 +-
 sound/soc/codecs/wm8350.c                          |   2 +-
 sound/soc/codecs/wm8400.c                          |   9 +-
 sound/soc/codecs/wm8731.c                          |   5 +-
 sound/soc/codecs/wm8750.c                          |   2 +-
 sound/soc/codecs/wm8770.c                          |   8 +-
 sound/soc/codecs/wm8804.c                          |   4 +-
 sound/soc/codecs/wm8900.c                          |   2 +-
 sound/soc/codecs/wm8903.c                          |   2 +-
 sound/soc/codecs/wm8904.c                          |  35 +-
 sound/soc/codecs/wm8955.c                          |   2 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   2 +-
 sound/soc/codecs/wm8960.c                          |  51 +-
 sound/soc/codecs/wm8961.c                          |   4 +-
 sound/soc/codecs/wm8962.c                          |   6 +-
 sound/soc/codecs/wm8988.c                          |   6 +-
 sound/soc/codecs/wm8990.c                          |   9 +-
 sound/soc/codecs/wm8991.c                          |   9 +-
 sound/soc/codecs/wm8993.c                          |   2 +-
 sound/soc/codecs/wm8994.c                          |  23 +-
 sound/soc/codecs/wm8995.c                          |  20 +-
 sound/soc/codecs/wm8996.c                          |   8 +-
 sound/soc/codecs/wm8997.c                          |  11 +-
 sound/soc/codecs/wm9081.c                          |   2 +-
 sound/soc/codecs/wm9090.c                          |   2 +-
 sound/soc/codecs/wm9705.c                          |  16 +-
 sound/soc/codecs/wm9712.c                          |  12 +-
 sound/soc/codecs/wm9713.c                          |  14 +-
 sound/soc/codecs/wm_adsp.c                         |   6 +-
 sound/soc/codecs/wm_hubs.c                         |  10 +-
 sound/soc/davinci/Kconfig                          |   3 +-
 sound/soc/davinci/davinci-evm.c                    |   6 -
 sound/soc/davinci/davinci-mcasp.c                  | 103 ++-
 sound/soc/dwc/Kconfig                              |   1 +
 sound/soc/dwc/designware_i2s.c                     | 311 +++++--
 sound/soc/fsl/eukrea-tlv320.c                      |  23 +-
 sound/soc/fsl/fsl_asrc.c                           |   5 +-
 sound/soc/fsl/fsl_asrc.h                           |   3 -
 sound/soc/fsl/fsl_esai.c                           |   2 +-
 sound/soc/fsl/fsl_sai.c                            |   2 +-
 sound/soc/fsl/fsl_spdif.c                          |  17 +-
 sound/soc/fsl/fsl_ssi.c                            |  10 +-
 sound/soc/fsl/fsl_utils.c                          |  27 -
 sound/soc/fsl/fsl_utils.h                          |   3 -
 sound/soc/fsl/imx-mc13783.c                        |   5 +-
 sound/soc/fsl/imx-spdif.c                          |   1 +
 sound/soc/fsl/imx-ssi.c                            |   5 +-
 sound/soc/fsl/mx27vis-aic32x4.c                    |  12 +-
 sound/soc/fsl/wm1133-ev1.c                         |  16 +-
 sound/soc/generic/simple-card.c                    |  34 +
 sound/soc/intel/Kconfig                            |   4 +-
 sound/soc/intel/broadwell.c                        |  10 -
 sound/soc/intel/byt-rt5640.c                       |  12 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c                |   1 -
 sound/soc/intel/cht_bsw_rt5672.c                   |  15 +-
 sound/soc/intel/sst-baytrail-pcm.c                 |   6 -
 sound/soc/intel/sst-dsp.c                          |   3 +-
 sound/soc/intel/sst-firmware.c                     |   3 +
 sound/soc/intel/sst-haswell-dsp.c                  |  17 +-
 sound/soc/intel/sst-haswell-ipc.c                  |   9 +-
 sound/soc/intel/sst-haswell-pcm.c                  | 105 ++-
 sound/soc/intel/sst-mfld-platform-pcm.c            |   7 -
 sound/soc/intel/sst/sst_acpi.c                     |   7 +-
 sound/soc/intel/sst/sst_loader.c                   |   3 +-
 sound/soc/mxs/mxs-saif.c                           |  10 +-
 sound/soc/mxs/mxs-saif.h                           |   1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |  27 +-
 sound/soc/nuc900/nuc900-pcm.c                      |   6 -
 sound/soc/omap/ams-delta.c                         |  18 +-
 sound/soc/omap/omap-hdmi-audio.c                   |   1 -
 sound/soc/omap/omap-twl4030.c                      |  20 +-
 sound/soc/omap/rx51.c                              |   8 +-
 sound/soc/pxa/Kconfig                              |   2 +-
 sound/soc/pxa/corgi.c                              |  16 +-
 sound/soc/pxa/e740_wm9705.c                        |  20 +-
 sound/soc/pxa/e750_wm9705.c                        |  20 +-
 sound/soc/pxa/hx4700.c                             |   8 +-
 sound/soc/pxa/magician.c                           |  21 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   2 +-
 sound/soc/pxa/palm27x.c                            |  15 +-
 sound/soc/pxa/raumfeld.c                           |  35 +-
 sound/soc/pxa/spitz.c                              |  23 +-
 sound/soc/pxa/ttc-dkb.c                            |   4 -
 sound/soc/pxa/zylonite.c                           |  12 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   4 +
 sound/soc/samsung/Kconfig                          |   4 +-
 sound/soc/samsung/arndale_rt5631.c                 |   1 -
 sound/soc/samsung/goni_wm8994.c                    |  23 +-
 sound/soc/samsung/h1940_uda1380.c                  |  15 +-
 sound/soc/samsung/i2s.c                            | 362 ++++----
 sound/soc/samsung/jive_wm8750.c                    |  34 +-
 sound/soc/samsung/neo1973_wm8753.c                 |  25 +-
 sound/soc/samsung/odroidx2_max98090.c              |   6 +-
 sound/soc/samsung/rx1950_uda1380.c                 |  15 +-
 sound/soc/samsung/s3c24xx_simtec.c                 |  20 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |  12 +-
 sound/soc/samsung/smartq_wm8987.c                  |  16 +-
 sound/soc/samsung/smdk_wm8580.c                    |  26 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |  19 +-
 sound/soc/samsung/smdk_wm8994pcm.c                 |  16 +-
 sound/soc/sh/dma-sh7760.c                          |   6 -
 sound/soc/sh/fsi.c                                 |  15 +-
 sound/soc/sh/migor.c                               |  12 +-
 sound/soc/sh/rcar/adg.c                            |  14 +-
 sound/soc/sh/rcar/core.c                           | 111 ++-
 sound/soc/sh/rcar/dvc.c                            |  63 +-
 sound/soc/sh/rcar/gen.c                            |  15 +
 sound/soc/sh/rcar/rsnd.h                           |  81 +-
 sound/soc/sh/rcar/src.c                            | 269 ++++--
 sound/soc/sh/rcar/ssi.c                            | 100 +--
 sound/soc/sh/siu_pcm.c                             |   1 -
 sound/soc/soc-ac97.c                               |  36 +-
 sound/soc/soc-core.c                               | 207 +++--
 sound/soc/soc-dapm.c                               | 125 +--
 sound/soc/soc-devres.c                             |   2 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |  15 +-
 sound/soc/soc-pcm.c                                |   7 +-
 sound/soc/tegra/Kconfig                            |  10 +
 sound/soc/tegra/Makefile                           |   2 +
 sound/soc/tegra/tegra_rt5677.c                     | 347 ++++++++
 sound/soc/txx9/txx9aclc.c                          |   6 -
 sound/soc/ux500/mop500_ab8500.c                    |  16 +-
 sound/soc/xtensa/Kconfig                           |   7 +
 sound/soc/xtensa/Makefile                          |   3 +
 sound/soc/xtensa/xtfpga-i2s.c                      | 675 +++++++++++++++
 196 files changed, 5566 insertions(+), 2227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cdns,xtfpga-i2s=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-au=
dio-rt5677.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,sta32x.txt
 create mode 100644 include/dt-bindings/sound/samsung-i2s.h
 create mode 100644 sound/soc/tegra/tegra_rt5677.c
 create mode 100644 sound/soc/xtensa/Kconfig
 create mode 100644 sound/soc/xtensa/Makefile
 create mode 100644 sound/soc/xtensa/xtfpga-i2s.c

--ZC+j7nfuMCqViNoE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0ol6AAoJECTWi3JdVIfQ/3sH+wb/TH0SrH0lOM5j67XNNsnw
MT1tZsN7Jy0hJQXG2/m0p68Mt+l8+nZ9eUlJd+yIPA8+C9fOVAcy/wMGHK0m6x4E
DHgQH30+bjLGYT94Z2ElPyoUkNAfytXGxUM7PuMt2CvQLnTOSp71X5TU0yWD7TGh
i5U/UATpc2yBYxbFeyFGrgykfov4dvssZp70luQI+SmWzvU3sW3EvJK5e2BgL76M
TAG1yKZ6Vugn897MWqGRTlNQcXQSn7n68mY1wS2PX5Nei2USJDwB/qhqenw6f5L5
FH5eNxXMQzESbRV/xewCXDY3Y3OjivsmOmaskBIKfk/xqiP7thrZ5XozsJ2EOkU=
=FtZ2
-----END PGP SIGNATURE-----

--ZC+j7nfuMCqViNoE--

--===============0952040998926148065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0952040998926148065==--
