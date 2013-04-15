From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.10
Date: Mon, 15 Apr 2013 17:31:18 +0100
Message-ID: <20130415163117.GL15837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7260260757798987257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D4CA2651BF
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 18:31:19 +0200 (CEST)
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


--===============7260260757798987257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b02e48f2f8755e51fe8ce246988a29bd96f6b85e:

  MAINTAINERS: Update e-mail address (2013-04-12 11:53:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.10

for you to fetch changes up to 5cbad7d39ad229c68a724e5e139fd845b93766b2:

  Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next (2013-04-=
12 13:57:31 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.10

A bunch of changes here, the most interesting one subsystem wise being
Morimoto-san's work to create snd_soc_component which doesn't do much
for now but will be pretty important going forwards:

 - Add a new component object type which will form the basis of moving
   to a more generic handling of SoC and off-SoC components, contributed
   by Kuninori Morimoto.
 - A fairly large set of cleanups for the dmaengine integration from
   Lars-Peter Clausen, starting to move towards being able to have a
   generic driver based on the library.
 - Performance optimisations to DAPM from Ryo Tsutsui.
 - Support for mixer control sharing in DAPM from Stephen Warren.
 - Multiplatform ARM cleanups from Arnd Bergmann.
 - New CODEC drivers for AK5385 and TAS5086 from Daniel Mack.

----------------------------------------------------------------
Alban Bedel (1):
      ASoC: wm8903: Add the DAC boost control

Alexandru Gheorghiu (1):
      ASoC: core: Use PTR_RET function

Andrey Smirnov (2):
      ASoC: si476x: Convert SI476X codec to use regmap
      ASoC: si476x: Cosmetic changes to SI476X codec driver

Arnd Bergmann (4):
      ASoC: samsung: use irq resource for idma
      ASoC: samsung: fix module_device_table
      ASoC: samsung: export idma_reg_addr_init
      ASoC: samsung: move plat/ headers to local directory

Charles Keepax (12):
      ASoC: arizona: Move selection of FLL REFCLK into init
      ASoC: arizona: Tidy up SYNCCLK selection and cache values
      ASoC: arizona: Factor out check for enabled FLL
      ASoC: arizona: Factor out FLL disable
      ASoC: arizona: Factor out FLL enable
      ASoC: arizona: Improve suppression of noop FLL updates
      ASoC: arizona: Add support for directly setting the FLL REFCLK
      ASoC: arizona: Add convience define for clearing SYNCCLK
      ASoC: arizona: Don't enable FLL on REFCLK configuration
      ASoC: wm5102: Correctly use SOC_VALUE_ENUM for ISRC FSL controls
      ASoC: wm0010: Constify usage of firmware filenames
      ASoC: wm0010: Report filename when we fail to load firmware

Dan Carpenter (1):
      ASoC: tas5086: signedness bug in tas5086_hw_params()

Daniel Mack (7):
      ASoC: ak4104: convert to direct regmap API usage
      ASoC: ak4104: correct tranceiver enable handling
      ASoC: Add codec driver for AK5386
      ALSA: ASoC: add codec driver for TI TAS5086
      ASoC: davinci-mcasp: clean up davinci_hw_common_param()
      ASoC: cs4271: convert to direct regmap API usage
      ASoC: cs4271: switch to mute_stream

Dylan Reid (1):
      ASoC: max98088: Add TLV data for volume controls.

Fabio Estevam (2):
      ASoC: fsl: imx-audmux: Use devm_clk_get()
      ASoC: fsl: imx-pcm-fiq: Use 'unsigned int' for period

Heiko St=FCbner (1):
      ASoC: samsung: fix neo1973-wm8753 compilation

Jeeja KP (1):
      ASoC: compress - add support for metadata apis

Kuninori Morimoto (61):
      ASoC: core: tidyup snd_soc_register_codec() fail case
      ASoC: core: use snd_soc_register_dais() on codec
      ASoC: core: remove codec from list if registration failed
      ASoC: fsi: remove unused irq
      ASoC: add snd_soc_register_component()
      ASoC: add .name for snd_soc_component_driver
      ASoC: fsi: use snd_soc_register_component() instead of snd_soc_regist=
er_dais()
      ASoC: pxa2xx-ac97: move EXPORT_SYMBOL_GPL() next to definition
      ASoC: snd_soc_register_component() uses properly snd_soc_register_dai=
[s]()
      ASoC: switch over to use snd_soc_register_component() on davinci i2s
      ASoC: switch over to use snd_soc_register_component() on davinci vcif
      ASoC: switch over to use snd_soc_register_component() on davinci mcasp
      ASoC: switch over to use snd_soc_register_component() on dw i2s
      ASoC: switch over to use snd_soc_register_component() on mpc5200 ac97
      ASoC: switch over to use snd_soc_register_component() on atmel ssc
      ASoC: switch over to use snd_soc_register_component() on au1x i2sc
      ASoC: switch over to use snd_soc_register_component() on au1x psc-ac97
      ASoC: switch over to use snd_soc_register_component() on au1x psc-i2s
      ASoC: switch over to use snd_soc_register_component() on au1x ac97c
      ASoC: switch over to use snd_soc_register_component() on bf6xx i2s
      ASoC: switch over to use snd_soc_register_component() on bf5xx ac97
      ASoC: switch over to use snd_soc_register_component() on bf5xx i2s
      ASoC: switch over to use snd_soc_register_component() on bf5xx tdm
      ASoC: switch over to use snd_soc_register_component() on ep93xx ac97
      ASoC: switch over to use snd_soc_register_component() on ep93xx i2s
      ASoC: switch over to use snd_soc_register_component() on mpc5200 i2s
      ASoC: switch over to use snd_soc_register_component() on fsl ssi
      ASoC: switch over to use snd_soc_register_component() on imx ssi
      ASoC: switch over to use snd_soc_register_component() on jz4740 i2s
      ASoC: switch over to use snd_soc_register_component() on kirkwood i2s
      ASoC: switch over to use snd_soc_register_component() on sst
      ASoC: switch over to use snd_soc_register_component() on mxs saif
      ASoC: switch over to use snd_soc_register_component() on nuc900 ac97
      ASoC: switch over to use snd_soc_register_component() on omap mcbsp
      ASoC: switch over to use snd_soc_register_component() on omap mcpdm
      ASoC: switch over to use snd_soc_register_component() on omap dmic
      ASoC: switch over to use snd_soc_register_component() on omap hdmi
      ASoC: switch over to use snd_soc_register_component() on pxa ssp
      ASoC: switch over to use snd_soc_register_component() on pxa2xx ac97
      ASoC: switch over to use snd_soc_register_component() on pxa2xx i2s
      ASoC: switch over to use snd_soc_register_component() on mmp sspa
      ASoC: switch over to use snd_soc_register_component() on s6000 i2s
      ASoC: switch over to use snd_soc_register_component() on s3c24xx i2s
      ASoC: switch over to use snd_soc_register_component() on s3c i2s
      ASoC: switch over to use snd_soc_register_component() on s3c ac97
      ASoC: switch over to use snd_soc_register_component() on samsung spdif
      ASoC: switch over to use snd_soc_register_component() on samsung i2s
      ASoC: switch over to use snd_soc_register_component() on samsung pcm
      ASoC: switch over to use snd_soc_register_component() on goni_wm8994
      ASoC: switch over to use snd_soc_register_component() on sh4 ssi
      ASoC: switch over to use snd_soc_register_component() on sh4 hac
      ASoC: switch over to use snd_soc_register_component() on spear spdif =
out
      ASoC: switch over to use snd_soc_register_component() on spear spdif =
in
      ASoC: switch over to use snd_soc_register_component() on tegra30 i2s
      ASoC: switch over to use snd_soc_register_component() on tegra20 spdif
      ASoC: switch over to use snd_soc_register_component() on tegra20 ac97
      ASoC: switch over to use snd_soc_register_component() on tegra20 i2s
      ASoC: switch over to use snd_soc_register_component() on txx9aclc ac97
      ASoC: switch over to use snd_soc_register_component() on ux500 msp
      ASoC: snd_soc_[un]register_dai[s]() become non global function
      ASoC: switch over to use snd_soc_register_component() on sh4 siu

Lars-Peter Clausen (28):
      ASoC: core: Drop unused "dapm" field form soc_enum struct
      ASoC: core: Remove unused "n_widgets" field from snd_soc_dapm struct
      ASoC: spear_pcm: Staticize non-exported structs
      ASoC: omap: Call omap_mcbsp_set_threshold() from mcbsp hw_params
      ASoC: ux500_pcm: Remove duplicated SNDRV_PCM_HW_PARAM_PERIODS constra=
int
      ASoC: spear_pcm: No need to wrap snd_dmaengine_pcm_close()
      ASoC: omap-pcm: No need to wrap snd_dmaengine_pcm_close()
      ASoC: tegra_pcm: No need to wrap snd_dmaengine_pcm_close()
      ASoC: ux500_pcm: No need to wrap snd_dmaengine_pcm_close()
      ASoC: atmel-pcm-dma: No need to wrap snd_dmaengine_pcm_close()
      ASoC: ux500_pcm: No need to use snd_dmaengine_pcm_set_data()
      ASoC: speaer_pcm: No need to use snd_dmaengine_pcm_set_data()
      ASoC: atmel-pcm-dma: Do not use snd_dmaengine_pcm_{set,get}_data()
      ASoC: ep93xx: Use ep93xx_dma_params instead of ep93xx_pcm_dma_params
      ASoC: mmp-pcm: Allocate dma filter parameters on the stack
      ASoC: imx-pcm: Embed the imx_dma_data struct in the dma_params struct
      ASoC: mxs: Embed the mxs_dma_data struct in the mxs_pcm_dma_params st=
ruct
      ASoC: dmaengine-pcm: Remove snd_dmaengine_pcm_{set,get}_data
      ASoC: Constify the 'driver' field of snd_soc_platform
      ASoC: Constify the 'ops' field of snd_soc_platform_driver
      ASoC: Constify the 'compr_ops' field of snd_soc_platform_driver
      ASoC: dmaengine_pcm: Setup device_fc in snd_hwparams_to_dma_slave_con=
fig
      ASoC: dmaengine-pcm: Add a common DAI DMA data struct
      ASoC: omap: Use common DAI DMA data
      ASoC: tegra: Use common DAI DMA data struct
      ASoC: fsl: Use common DAI DMA data struct
      ASoC: ep93xx_pcm: Fix compile error
      ASoC: ux500_pcm: Use the same snd_pcm_hardware for playback and captu=
re

Mark Brown (72):
      ASoC: arizona: Only allow input volume updates when inputs are enabled
      ASoC: wm8960: Add input boost volume control
      ASoC: omap: Check regulator enable for DAC on Pandora
      ASoC: arizona: If we only have a clock to synchronise with make it RE=
FCLK
      mfd: arizona: Define additional FLL control registers
      mfd: wm5102: Map in additional FLL control registers
      ASoC: arizona: Increase FLL synchroniser bandwidth for high frequenci=
es
      ASoC: arizona: Optimise FLL loop gains
      ASoC: arizona: Ensure synchroniser is disabled when not needed
      ASoC: arizona: Suppress reference calculations when setting REFCLK to=
 0
      Merge tag 'v3.9-rc2' into asoc-core
      ASoC: arizona: Provide defines for the clock rates
      ASoC: wm_adsp: Handle old .bin files
      ASoC: arizona: Ensure we clock two channels for I2S mode
      ASoC: wm8994: Support constraining the maximum number of channels clo=
cked
      mfd: wm5102: Add additional speaker control registers
      ASoC: arizona: Factor out speaker widgets from CODEC drivers
      ASoC: arizona: Log thermal events
      ASoC: arizona: Suppress speaker enable if thermal shutdown is flagged
      ASoC: arizona: Basic support for ISRC rate selection
      ASoC: wm8994: Restore AIFnCLK after reducing it for low clock rates
      extcon: arizona: Factor out magic application
      ASoC: arizona: Fix interaction between headphone outputs and identifi=
cation
      extcon: arizona: Fix interaction between headphone outputs and identi=
fication
      Merge tag 'arizona-extcon-asoc' of git://git.kernel.org/.../broonie/m=
isc into asoc-arizona
      ASoC: arizona: Add delay after powering up line level outputs
      Merge branch 'topic/pxa' of git://git.kernel.org/.../broonie/sound in=
to asoc-component
      ASoC: wm5102: Implement OSR support
      ASoC: wm2000: Expose some more registers for diagnostics
      ASoC: wm_adsp: Provide defines for firmwares
      ASoC: wm_adsp: Split ADSP1 and ADSP2 firmware controls
      Merge branch 'topic/omap' of git://git.kernel.org/.../broonie/sound i=
nto HEAD
      Merge branch 'fix/samsung' of git://git.kernel.org/.../broonie/sound =
into asoc-samsung
      ASoC: core: Merge Samsung fixes to avoid trivial context conflict
      ASoC: wm8994: Remove duplicate revision cache
      ASoC: wm_adsp: Add support for firmware wide coefficient blocks
      Merge remote-tracking branch 'asoc/fix/compress' into asoc-next
      Merge remote-tracking branch 'asoc/fix/core' into asoc-next
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/fix/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/fix/wm8903' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adau1373' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak4104' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak5386' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l73' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/maintainers' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/si476x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/spear' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tas5086' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm-hubs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm0010' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm2000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8903' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8960' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next

Michal Bachraty (1):
      ASoC: davinci-mcasp: Add support for multichannel playback

Paul Bolle (3):
      ASoC: samsung: remove last traces of neo1973-gta01
      ASoC: codecs: remove hidden prompt
      ASoC: Ux500: remove test for undefined Kconfig macro

Paul Handrigan (1):
      ASoC: cs42l73: If Internal MCLK is >=3D 6.4MHz, then set SCLK to 64*F=
s.

Peter Ujfalusi (4):
      ASoC: omap3pandora: Fix compilation error
      ASoC: omap-mcpdm: Collect link direction configuration under a struct
      ASoC: omap-mcpdm: Fix for full duplex audio use case
      ASoC: omap-mcpdm: Remove leftower define for IO address

Ryo Tsutsui (2):
      ASoC: dapm: Remove redundant clear_walk() for supply widgets
      ASoC: dapm: Only clear paths we've walked

Sachin Kamat (5):
      ASoC: max98090: Remove unneeded version.h header include
      ASoC: max98090: Convert to devm_regmap_init_i2c()
      ASoC: max98090: Make struct dev_pm_ops const
      ASoC: max98090: Fix checkpatch errors related to spacing
      ASoC: max98090: Remove unnecessary braces

Sascha Hauer (1):
      ASoC: imx-ssi: Fix AC97 rates

Sebastien Guiriec (2):
      ASoC: omap-mcpdm: Clean up with devm_* function
      ASoC: omap-dmic: Clean up with devm_request_and_ioremap

Shawn Guo (1):
      ASoC: imx-sgtl5000: use of_node to match cpu dai

Silviu-Mihai Popescu (1):
      ASoC: omap: convert to devm_ioremap_resource()

Stephen Warren (10):
      ASoC: tegra: assume CONFIG_OF in tegra_asoc_utils_init
      ASoC: tegra_wm8753: minor cleanup
      ASoC: tegra_wm9712: assume CONFIG_OF
      ASoC: tegra_alc5632: assume CONFIG_OF, and other cleanup
      ASoC: tegra trimslice: assume CONFIG_OF, and other cleanup
      ASoC: tegra_wm8903: assume CONFIG_OF, remove platform data
      ASoC: tegra: add Tegra114 support to the AHUB driver
      ASoC: tegra: add Tegra114 support to tegra_asoc_utils.c
      ASoC: export snd_soc_register_component
      ASoC: dapm: Implement mixer control sharing

Tim Gardner (2):
      ASoC: adau1373: adau1373_hw_params: Silence overflow warning
      ASoC: wm_hubs: Silence reg_r and reg_l 'may be used uninitialized' wa=
rnings

Vinod Koul (1):
      ASoC: mid-x86 - add support for meaadata apis

Wei Yongjun (2):
      ASoC: tas5086: use module_i2c_driver to simplify the code
      ASoC: arizona: remove duplicated include from arizona.c

Yegor Yefremov (2):
      ASoC: davinci-mcasp: don't configure AFSX direction in DIT mode
      ASoC: davinci-mcasp: don't overwrite DIT settings

Zoltan Puskas (1):
      ASoC: atmel: Add slave mode support to SSC in DSP Mode A

 Documentation/devicetree/bindings/sound/ak5386.txt |   19 +
 .../bindings/sound/nvidia,tegra30-ahub.txt         |   26 +-
 .../devicetree/bindings/sound/ti,tas5086.txt       |   32 ++
 arch/arm/mach-s3c24xx/dma-s3c2410.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c                |    2 -
 arch/arm/plat-samsung/devs.c                       |    6 +
 drivers/extcon/extcon-arizona.c                    |  107 ++--
 drivers/mfd/wm5102-tables.c                        |   10 +
 include/linux/mfd/arizona/core.h                   |    3 +
 include/linux/mfd/arizona/registers.h              |   42 ++
 include/linux/mfd/wm8994/pdata.h                   |    8 +
 include/sound/dmaengine_pcm.h                      |   27 +-
 include/sound/soc-dai.h                            |    8 -
 include/sound/soc-dapm.h                           |    1 -
 include/sound/soc.h                                |   29 +-
 include/sound/tas5086.h                            |    7 +
 include/sound/tegra_wm8903.h                       |   26 -
 sound/soc/atmel/atmel-pcm-dma.c                    |   25 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   54 +-
 sound/soc/au1x/ac97c.c                             |    9 +-
 sound/soc/au1x/i2sc.c                              |    9 +-
 sound/soc/au1x/psc-ac97.c                          |    9 +-
 sound/soc/au1x/psc-i2s.c                           |    9 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |    9 +-
 sound/soc/blackfin/bf5xx-i2s.c                     |    9 +-
 sound/soc/blackfin/bf5xx-tdm.c                     |    9 +-
 sound/soc/blackfin/bf6xx-i2s.c                     |    9 +-
 sound/soc/cirrus/edb93xx.c                         |    1 -
 sound/soc/cirrus/ep93xx-ac97.c                     |   18 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |   25 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |   37 +-
 sound/soc/cirrus/ep93xx-pcm.h                      |   20 -
 sound/soc/cirrus/simone.c                          |    2 -
 sound/soc/cirrus/snappercl15.c                     |    1 -
 sound/soc/codecs/Kconfig                           |   10 +-
 sound/soc/codecs/Makefile                          |    4 +
 sound/soc/codecs/adau1373.c                        |    5 +-
 sound/soc/codecs/ak4104.c                          |   55 +-
 sound/soc/codecs/ak5386.c                          |  152 +++++
 sound/soc/codecs/arizona.c                         |  530 +++++++++++++++-=
--
 sound/soc/codecs/arizona.h                         |   34 +-
 sound/soc/codecs/cs4271.c                          |  166 +++---
 sound/soc/codecs/cs42l73.c                         |    6 +-
 sound/soc/codecs/max98088.c                        |   30 +-
 sound/soc/codecs/max98090.c                        |   45 +-
 sound/soc/codecs/si476x.c                          |   47 +-
 sound/soc/codecs/tas5086.c                         |  591 ++++++++++++++++=
++++
 sound/soc/codecs/wm0010.c                          |    6 +-
 sound/soc/codecs/wm2000.c                          |    4 +-
 sound/soc/codecs/wm2000.h                          |    2 +
 sound/soc/codecs/wm2200.c                          |    2 +-
 sound/soc/codecs/wm5102.c                          |  131 ++---
 sound/soc/codecs/wm5102.h                          |    6 +-
 sound/soc/codecs/wm5110.c                          |   54 +-
 sound/soc/codecs/wm5110.h                          |    6 +-
 sound/soc/codecs/wm8903.c                          |    6 +
 sound/soc/codecs/wm8960.c                          |   10 +
 sound/soc/codecs/wm8994.c                          |   68 ++-
 sound/soc/codecs/wm8994.h                          |    3 +-
 sound/soc/codecs/wm_adsp.c                         |  124 +++-
 sound/soc/codecs/wm_adsp.h                         |    5 +-
 sound/soc/codecs/wm_hubs.c                         |    9 +-
 sound/soc/davinci/davinci-i2s.c                    |   15 +-
 sound/soc/davinci/davinci-mcasp.c                  |   97 +++-
 sound/soc/davinci/davinci-pcm.c                    |   16 +-
 sound/soc/davinci/davinci-pcm.h                    |    1 +
 sound/soc/davinci/davinci-vcif.c                   |   11 +-
 sound/soc/dwc/designware_i2s.c                     |    9 +-
 sound/soc/fsl/fsl_ssi.c                            |   45 +-
 sound/soc/fsl/imx-audmux.c                         |    3 +-
 sound/soc/fsl/imx-pcm-dma.c                        |   58 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |    6 +-
 sound/soc/fsl/imx-pcm.h                            |   19 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    2 +-
 sound/soc/fsl/imx-ssi.c                            |   42 +-
 sound/soc/fsl/imx-ssi.h                            |    7 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    8 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    9 +-
 sound/soc/jz4740/jz4740-i2s.c                      |    9 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   11 +-
 sound/soc/mid-x86/sst_platform.c                   |   20 +-
 sound/soc/mid-x86/sst_platform.h                   |    2 +
 sound/soc/mxs/mxs-pcm.c                            |   43 +-
 sound/soc/mxs/mxs-pcm.h                            |    4 +-
 sound/soc/mxs/mxs-saif.c                           |   17 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    9 +-
 sound/soc/omap/am3517evm.c                         |    1 -
 sound/soc/omap/ams-delta.c                         |    1 -
 sound/soc/omap/mcbsp.c                             |   14 +-
 sound/soc/omap/mcbsp.h                             |    7 +-
 sound/soc/omap/n810.c                              |    1 -
 sound/soc/omap/omap-abe-twl6040.c                  |    1 -
 sound/soc/omap/omap-dmic.c                         |   47 +-
 sound/soc/omap/omap-hdmi.c                         |   33 +-
 sound/soc/omap/omap-mcbsp.c                        |   27 +-
 sound/soc/omap/omap-mcpdm.c                        |  118 ++--
 sound/soc/omap/omap-pcm.c                          |   83 +--
 sound/soc/omap/omap-pcm.h                          |   40 --
 sound/soc/omap/omap-twl4030.c                      |    1 -
 sound/soc/omap/omap3pandora.c                      |    9 +-
 sound/soc/omap/osk5912.c                           |    1 -
 sound/soc/omap/rx51.c                              |    1 -
 sound/soc/pxa/mmp-pcm.c                            |   33 +-
 sound/soc/pxa/mmp-sspa.c                           |    9 +-
 sound/soc/pxa/pxa-ssp.c                            |    9 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   11 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    9 +-
 sound/soc/s6000/s6000-i2s.c                        |    9 +-
 sound/soc/samsung/Kconfig                          |    5 +-
 sound/soc/samsung/ac97.c                           |   14 +-
 sound/soc/samsung/goni_wm8994.c                    |   11 +-
 sound/soc/samsung/h1940_uda1380.c                  |    2 +-
 sound/soc/samsung/i2s.c                            |   33 +-
 sound/soc/samsung/idma.c                           |   11 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    3 +-
 sound/soc/samsung/pcm.c                            |   11 +-
 .../include/plat =3D> sound/soc/samsung}/regs-ac97.h |    0
 .../include/plat =3D> sound/soc/samsung}/regs-iis.h  |    0
 sound/soc/samsung/rx1950_uda1380.c                 |    2 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    9 +-
 sound/soc/samsung/s3c-i2s-v2.h                     |    7 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   12 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   13 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |    2 +-
 sound/soc/samsung/spdif.c                          |   11 +-
 sound/soc/sh/fsi.c                                 |   14 +-
 sound/soc/sh/hac.c                                 |   10 +-
 sound/soc/sh/migor.c                               |    2 +-
 sound/soc/sh/siu_dai.c                             |   11 +-
 sound/soc/sh/ssi.c                                 |   10 +-
 sound/soc/soc-compress.c                           |   41 +-
 sound/soc/soc-core.c                               |  130 ++++-
 sound/soc/soc-dapm.c                               |  320 ++++++-----
 sound/soc/soc-dmaengine-pcm.c                      |   68 ++-
 sound/soc/soc-io.c                                 |    5 +-
 sound/soc/spear/spdif_in.c                         |    9 +-
 sound/soc/spear/spdif_out.c                        |    9 +-
 sound/soc/spear/spear_pcm.c                        |   22 +-
 sound/soc/tegra/tegra20_ac97.c                     |   28 +-
 sound/soc/tegra/tegra20_ac97.h                     |    4 +-
 sound/soc/tegra/tegra20_i2s.c                      |   28 +-
 sound/soc/tegra/tegra20_i2s.h                      |    4 +-
 sound/soc/tegra/tegra20_spdif.c                    |   22 +-
 sound/soc/tegra/tegra20_spdif.h                    |    4 +-
 sound/soc/tegra/tegra30_ahub.c                     |   72 ++-
 sound/soc/tegra/tegra30_ahub.h                     |   24 +-
 sound/soc/tegra/tegra30_i2s.c                      |   28 +-
 sound/soc/tegra/tegra30_i2s.h                      |    4 +-
 sound/soc/tegra/tegra_alc5632.c                    |   15 +-
 sound/soc/tegra/tegra_asoc_utils.c                 |   34 +-
 sound/soc/tegra/tegra_asoc_utils.h                 |    1 +
 sound/soc/tegra/tegra_pcm.c                        |   48 +-
 sound/soc/tegra/tegra_pcm.h                        |    7 -
 sound/soc/tegra/tegra_wm8753.c                     |   15 +-
 sound/soc/tegra/tegra_wm8903.c                     |  179 +++---
 sound/soc/tegra/tegra_wm9712.c                     |    7 +-
 sound/soc/tegra/trimslice.c                        |   56 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    9 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   13 +-
 sound/soc/ux500/ux500_msp_dai.h                    |    5 -
 sound/soc/ux500/ux500_pcm.c                        |   76 +--
 sound/soc/ux500/ux500_pcm.h                        |   14 -
 164 files changed, 3437 insertions(+), 1710 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5386.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas5086.txt
 create mode 100644 include/sound/tas5086.h
 delete mode 100644 include/sound/tegra_wm8903.h
 delete mode 100644 sound/soc/cirrus/ep93xx-pcm.h
 create mode 100644 sound/soc/codecs/ak5386.c
 create mode 100644 sound/soc/codecs/tas5086.c
 delete mode 100644 sound/soc/omap/omap-pcm.h
 rename {arch/arm/plat-samsung/include/plat =3D> sound/soc/samsung}/regs-ac=
97.h (100%)
 rename {arch/arm/plat-samsung/include/plat =3D> sound/soc/samsung}/regs-ii=
s.h (100%)

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbCtOAAoJELSic+t+oim9BS4P/1x5bAt0d8wi1izly7D5x2UZ
IGXl5kjqv7notMO+88YMUQaFCV5sEuIK6o3RoRyOQH0oouSR4Gio8ZalZDAs51nz
CbEUrkNW/7vKzVvINWDb0b5v/P/Zzo4rYkASFRLQgad560I97ViIlvVjTn30hqiw
jpzPFAsbcRSFBslvgHfZulUC8HI1GvVaDcG0UP/WE7ebReB4o5RnLTJOgt/O0w9p
tyo5ZljGwuILqHu4r0gOy+3uckpx/Z3K4Zj6GsC15+7mIVa5HXyMcqgYvLOlUGXz
cWY/WSQ3TTqC7VywiMALTp+TZs5genBCUqBwZcoYjQwffG2UvtQIVvaHO8utslnr
jLeY6WY+MWurYkRpcsNZAnIMVp7If24PEqD5xBgZU0gV9OMo3780vemv/lIIM2Im
DdUvskqva22/nocy3vD22UhdNMSEiGTyugMiVAtWwBhoa+/sKtU/V7uUEN60H+pf
PKuBbBwS0jOSMRwg6+XlHmMtREw4BY2Q6XZRUEGLolEEYCSKB2HQw/lLDbac+JoP
/o9nNgc/a7rR/5V7sgainU7MiS2RKgnyiDX2F1uNiyAa1B4fmue6wqKVjDMHS+wd
MINrHXlqEYrFmhYxhAcHeLE/9DCUSy/CLYkjvwIII2HyyqYO8mHwklGV076WEK3s
Dgjj1UqwMmd2dAbdBWsS
=isVj
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--

--===============7260260757798987257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7260260757798987257==--
