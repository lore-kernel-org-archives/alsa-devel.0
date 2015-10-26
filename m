From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.3
Date: Mon, 26 Oct 2015 14:17:20 +0900
Message-ID: <20151026051720.GG28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7936130242109396952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB42E260496
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 06:17:31 +0100 (CET)
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


--===============7936130242109396952==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 32b88194f71d6ae7768a29f87fbba454728273ee:

  Linux 4.3-rc7 (2015-10-25 10:39:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.3-rc6

for you to fetch changes up to bb9a13a0209c56cdf27d125a1f2f6f34378c64f4:

  Merge remote-tracking branches 'asoc/topic/wm8904', 'asoc/topic/wm8955' a=
nd 'asoc/topic/wm8960' into asoc-next (2015-10-26 11:16:20 +0900)

----------------------------------------------------------------
ASoC: Updates for v4.4

Not much core work here, a few small tweaks to interfaces but mainly the
changes here are driver ones.  Highlights include:

 - Updates to the topology userspace interface
 - Big updates to the Renesas support from Morimoto-san
 - Most of the support for Intel Sky Lake systems.
 - New drivers for Asahi Kasei Microdevices AK4613, Allwinnner A10,
   Cirrus Logic WM8998, Dialog DA7219, Nuvoton NAU8825 and Rockchip
   S/PDIF.

----------------------------------------------------------------

Also a new driver for the Atmel Class D speaker drivers which I forgot
in the tag message, sorry.

Adam Thomson (11):
      ASoC: Add SOC_DOUBLE_R_EXT
      ASoC: codecs: Add da7219 codec driver
      ASoC: da7219: Add bindings documentation for DA7219 audio codec
      ASoC: da7219: Add entry to cover DA7219 bindings document
      ASoC: da7219: Improve error handling for regulator supplies
      ASoC: da7219: Use of_match_ptr() when assigning match table
      ASoC: da7219: Improve error checking of mclk enable/disable
      ASoC: da7213: Add DT support to codec driver
      ASoC: da7213: Add support to handle mclk data provided to driver
      ASoC: da7213: Add bindings documentation for codec driver
      ASoC: da7213: Correct units description of dmic-clkrate

Anatol Pomozov (2):
      ASoC: nau8825: Add driver for headset chip Nuvoton 8825
      ASoC: Document DAI signal polarity

Andy Shevchenko (1):
      ASoC: Intel: use dw_dmac autoconfiguration

Axel Lin (20):
      ASoC: mediatek: Convert to devm_snd_soc_register_card
      ASoC: au1x: Convert to devm_snd_soc_register_card
      ASoC: blackfin: Convert to devm_snd_soc_register_card
      ASoC: mxs-sgtl5000: Convert to devm_snd_soc_register_card
      ASoC: pxa: Convert to devm_snd_soc_register_card
      ASoC: sh: siu_dai: Convert to use resource managed APIs
      ASoC: intel: broadwell: Convert to devm_snd_soc_register_card
      ASoC: SPEAr: Make SND_SPEAR_SOC select SND_SOC_GENERIC_DMAENGINE_PCM
      ASoC: rockchip: Fix missing CLKDEV_LOOKUP dependency
      ASoC: rl6347a: Clean up unneeded inclusion of header files
      ASoC: ad193x-spi: Fixup ad193x_spi_id table
      ASoC: rt286: Fix run time error while modifying const data
      ASoC: rt298: Make rt298_index_def const
      ASoC: rockchip: spdif: Convert to use devm_snd_dmaengine_pcm_register
      ASoC: ad193x-spi: Add adau1328 to ad193x_spi_id table
      ASoC: ad193x: Drop .volatile_reg implementation
      ASoC: ssm2518: Drop .volatile_reg implementation
      ASoC: da7219: Fix da7219->alc_en state when enabling ALC
      ASoC: Intel: Skylake: Convert to devm_snd_soc_register_card
      ASoC: rt5645: Sort the order for register bit defines

Bard Liao (1):
      ASoC: rt298: set register non-volatile by default

Ben Zhang (3):
      ASoC: rt5645: Allow 4 channel recording on AIF1
      ASoC: nau8825: Add FLL configuration
      ASoC: nau8825: Show device properties

Charles Keepax (4):
      ASoC: arizona: Add default cases for event switches
      ASoC: arizona: Add utility function to check if an input is analog
      ASoC: Add SOC_SINGLE_RANGE_EXT_TLV macro
      ASoC: wm5110: Add additional analogue input enable for early revs

Cyrille Pitchen (1):
      ASoC: ad193x: add support to ad1934

Dan Carpenter (7):
      ASoC: wm8904: harmless underflow in wm8904_put_deemph()
      ASoC: wm8731: harmless underflow in wm8731_put_deemph()
      ASoC: wm8960: harmless underflow in wm8960_put_deemph()
      ASoC: wm8903: harmless underflow in wm8903_put_deemph()
      ASoC: wm8955: harmless underflow in wm8955_put_deemph()
      ASoC: es8328: harmless underflow in es8328_put_deemph()
      ASoC: wm2000: a couple harmless underflows

Dan Williams (1):
      ASoC: Intel: switch from ioremap_cache to memremap

Daniel Mack (1):
      ASoC: pxa: pxa-pcm-lib: switch over to snd-soc-dmaengine-pcm

Emilio L=F3pez (1):
      ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs

Fang, Yang A (1):
      ASoC: nau8825: add acpi match ID

Geert Uytterhoeven (1):
      ASoC: rsnd: Remove obsolete platform data support

Jarkko Nikula (1):
      spi: atmel: Remove needless bits_per_word and speed_hz tests

Jeeja KP (19):
      ASoC: Intel: Skylake: Remove unused CPU dais
      ASoC: Intel: Skylake: Add pipe and modules handlers
      ASoC: Intel: Skylake: Add module configuration helpers
      ASoC: Intel: Skylake: Initialize and load DSP controls
      ASoC: Intel: Skylake: Add DSP support and enable it
      ASoC: Intel: Skylake: Initialize NHLT table
      ASoC: Intel: Skylake: Check CPA bit in DSP core power down
      ASoC: Intel: Skylake: Verify the status bit before handling interrupt
      ASoC: Intel: Skylake: Correct the runtime handler behaviour
      ASoC: Intel: Skylake: power down all link in suspend
      ASoC: dapm: Add kcontrol support for PGAs
      ASoC: dapm: Add startup & shutdown for dai_links
      ASoC: Intel: Skylake: Fix return for pm_runtime_get_sync()
      ASoC: Intel: Skylake: Remove BE copier blob memcpy
      ASoC: Intel: Skylake: Update for ssp node index in copier cfg
      ASoC: Intel: Skylake: Add support to disable module notifications
      ASoC: Intel: Skylake: Fix to check return value of dsp init
      ASoC: Intel: Skylake: Fix to set Non gateway copier cfg
      ASoC: Intel: Skylake: Add support to topology for module static pin

Jie Yang (2):
      ASoC: compress: add config item for soc-compress to make it compiled =
only when needed
      ASoC: Intel: sst: only use sst-firmware when DW DMAC is available

John Lin (3):
      ASoC: rt5645: Add dmi for Broadwell
      ASoC: rt5645: Add jd_invert for Broadwell
      ASoC: rt5645: Add dmi "Google Reks" for chrome

Julia Lawall (1):
      ASoC: qcom: change PTR_ERR argument

Jyri Sarha (6):
      ASoC: tlv320aic3x: Improve tdm support
      ASoC: davinci-mcasp: Add set_tdm_slots() support
      ASoC: simple-card: Add tdm slot mask support to simple-card
      ASoC: soc-core: Fix sparse warning in be32_to_cpup() call
      ASoC: davinci-mcasp: Get rid of bclk_lrclk_ratio in private data
      ASoC: hdmi: Remove obsolete dummy HDMI codec

Kuninori Morimoto (31):
      ASoC: ak4642: use *dev on ak4642_i2c_probe()
      ASoC: ak4642: enable to use MCKO as fixed rate output pin on DT
      ASoC: rsnd: tidyup rsnd_dma_to_xxx() position
      ASoC: rsnd: rename rsnd_src_pcm_new() to rsnd_src_pcm_new_gen2()
      ASoC: rsnd: remove unneeded sh_clk header
      ASoC: rsnd: add missing #sound-dai-cells explain on Document
      ASoC: rsnd: Add Gen3 initial support
      ASoC: rsnd: add rsnd_mod_get() macro and use it
      ASoC: rsnd: ADG uses mod base common method
      ASoC: rsnd: add common mod confirm method
      ASoC: rsnd: ADG initial setup on rsnd_adg_ssi_clk_init()
      ASoC: rsnd: tidyup ADG clock calculate method
      ASoC: rsnd: tidyup ADG debug message for clock selection
      ASoC: rsnd: adg: ignore undefined clock error
      ASoC: rsnd: add AUDIO_CLKOUT support
      ASoC: rsnd: SND_SOC_RCAR depends on COMMON_CLK
      ASoC: ak4642: exchange macro name to avoid redefinition
      ASoC: rsnd: fixup clkout_name[] index error for single AUDIO_CLKOUT S=
oC
      ASoC: add ak4613 support
      ASoC: ak4613: add Digital Playback Volume support
      ASoC: rsnd: Announce for removing Gen1 SRU support
      ASoC: rsnd: Gen1 probe is not error
      ASoC: rsnd: fixup print debug message after read
      ASoC: rsnd: fixup struct rsnd_gen::res array size
      ASoC: rsnd: fixup devm_request_irq() option on ssi.c
      ASoC: rsnd: fixup rsnd_mod_call() behavior for debug
      ASoC: rsnd: fixup rsnd_dai_call() behavior for unimplemented method
      ASoC: rsnd: fixup rsnd_dai_call() behavior for .stop/.quit
      ASoC: rsnd: rename rsnd_mod_hw_start/stop to rsnd_mod_power_on/off
      ASoC: rsnd: remove unused rsnd_dma_to_ssi() macro
      ASoC: rsnd: remove duplicate parameter from rsnd_ssi_xxx()

Lars-Peter Clausen (4):
      ASoC: Let snd_soc_limit_volume() take a snd_soc_card
      ASoC: h1940_uda1380: Constify rate constraints
      ASoC: rx1950_uda1380: Constify rate constraints
      ASoC: fsl_sai: Constify rate constraints

Luis de Bethencourt (8):
      ASoC: atmel_wm8904: Fix module autoload for OF platform driver
      ASoC: fsl-asoc-card: Fix module autoload for OF platform driver
      ASoC: fsl_sai: Fix module autoload for OF platform driver
      ASoC: jz4740: Fix module autoload for OF platform driver
      ASoC: kirkwood: Fix module autoload for OF platform driver
      ASoC: pxa: Fix module autoload for OF platform drivers
      ASoC: mop500: Fix module autoload for OF platform driver
      ASoC: ux500: Fix module autoload for OF platform driver

Maciej S. Szmigiero (1):
      ASoC: fsl-asoc-card: add AC'97 support

Mark Brown (27):
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5645
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4613', 'asoc/topic/ak464=
2', 'asoc/topic/arizona', 'asoc/topic/atmel' and 'asoc/topic/au1x' into aso=
c-next
      Merge remote-tracking branches 'asoc/topic/blackfin', 'asoc/topic/dav=
inci', 'asoc/topic/fsl', 'asoc/topic/hdmi' and 'asoc/topic/intel' into asoc=
-next
      Merge remote-tracking branches 'asoc/topic/jz4740', 'asoc/topic/kirkw=
ood', 'asoc/topic/mtk', 'asoc/topic/multi' and 'asoc/topic/mxs' into asoc-n=
ext
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/qcom', '=
asoc/topic/rcar' and 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sh', 'asoc/topic/simple', =
'asoc/topic/spear', 'asoc/topic/sunxi' and 'asoc/topic/tlv320aic3x' into as=
oc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next
      Merge tag 'asoc-fix-v4.3-rc2' into asoc-pxa
      Merge branch 'fix/rt298' of git://git.kernel.org/.../broonie/sound in=
to asoc-rt298
      Merge branch 'topic/fsl-mega-fast' of git://git.kernel.org/.../brooni=
e/sound into asoc-fsl
      Merge tag 'asoc-v4.3-rc2' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/doc' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ad193x' and 'asoc/topic/ar=
izona' into asoc-next
      Merge remote-tracking branches 'asoc/topic/atmel-classd' and 'asoc/to=
pic/da7213' into asoc-next
      Merge remote-tracking branch 'asoc/topic/da7219' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/es8328',=
 'asoc/topic/fsl' and 'asoc/topic/fsl-card' into asoc-next
      Merge remote-tracking branches 'asoc/topic/imx' and 'asoc/topic/intel=
' into asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8825' and 'asoc/topic/p=
xa' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rcar', 'asoc/topic/rl6347a=
', 'asoc/topic/rockchip' and 'asoc/topic/rt286' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt298', 'asoc/topic/rt5640=
', 'asoc/topic/samsung' and 'asoc/topic/sh' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ssm2518' and 'asoc/topic/s=
unxi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/topology', 'asoc/topic/wm2=
000', 'asoc/topic/wm8731' and 'asoc/topic/wm8903' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8904', 'asoc/topic/wm895=
5' and 'asoc/topic/wm8960' into asoc-next

Maruthi Srinivas Bayyavarapu (2):
      ASoC: dwc: support dw i2s in slave mode
      ASoC: dwc: add check for master/slave format

Masanari Iida (1):
      ASoC: sh: Fit typo in Kconfig

Maxime Ripard (4):
      ASoC: sunxi: Add the Allwinner A10 codec bindings
      ASoC: sun4i-codec: pass through clk_set_rate error
      ASoC: sun4i-codec: Remove redundant SND_PCM_RATE_KNOT
      ASoC: sun4i-codec: Remove the routing property

Mengdong Lin (2):
      ASoC: topology: ABI - Change stream formats to a bitwise flag
      ASoC: topology: ABI - Remove tdm_slot & dai_fmt from snd_soc_tplg_str=
eam

Mythri P K (1):
      ASoC: dapm: Add snd_soc_dapm_kcontrol_widget()

Nicolin Chen (1):
      ASoC: fsl: Use #ifdef instead of #if for CONFIG_PM_SLEEP

Oder Chiou (7):
      ASoC: rt5645: Remove the repeated definitions
      ASoC: rt5645: Add the control of ClassD modulator Speaker Gain Ratio
      ASoC: rt5645: Prevent the weird sound of the headphone while rebooting
      ASoC: rt5645: Recheck the jack detect status after resuming from S3
      ASoC: rt5640: Revise the input pin name of IN1 and IN2 in document of=
 the devicetree
      ASoC: rt5640: Fill up the IN3's support
      ASoC: rt5645: Add the HWEQ for the speaker output

Omair M Abdullah (1):
      ASoC: Intel: Skylake - Add Skylake RT286 I2S machine driver

Ricard Wanderlof (1):
      ASoC: Handle multiple codecs with split playback / capture

Richard Fitzgerald (2):
      ASoC: arizona: add defines for single-input gain control
      ASoC: wm8998: Initial WM8998 codec driver

Sjoerd Simons (4):
      ASoC: rockchip: namespace rockchip i2s module name
      ASoC: dt-bindings: add rockchip tranceiver bindings
      ASoC: rockchip: Add rockchip SPDIF transceiver driver
      ASoC: rockchip: Drop unneeded properties rockchip i2s/spdif bindings

Songjun Wu (2):
      ASoC: atmel-classd: add the Audio Class D Amplifier
      ASoC: atmel-classd: DT binding for Class D audio amplifier driver

Subhransu S. Prusty (2):
      ASoC: Intel: Skylake: Fix to use correct macros for the path iteration
      ASoC: Intel: Skylake: Fix to fill all sink/source pipe params

Sudip Mukherjee (2):
      ASoC: Intel: remove unused function
      ASoC: rt5645: fix build warning

Sugar Zhang (3):
      ASoC: rockchip: i2s: add 8 channels capture support
      ASoC: rockchip: add capture property
      ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates enabled

Vedang Patel (6):
      ASoC: topology: ABI - Add PCM Support and bump ABI version to 4
      ASoC: topology: ABI - Remove unused struct snd_soc_tplg_stream_config
      ASoC: topology: ABI - Use __le32 instead of __u32 in snd_soc_tplg_dap=
m_widget
      ASoC: topology: ABI - Add name element to snd_soc_tplg_stream
      ASoC: topology: ABI - Add the type for BE DAI link
      ASoC: topology: ABI - Add configuration for BE & Codec-Codec DAI Links

Vinod Koul (4):
      ASoC: Intel: Skylake: add DSP platform widget event handlers
      ASoC: Intel: Skylake: Add FE and BE hw_params handling
      ASoC: Intel: Skylake: Add topology core init and handlers
      ASoC: Intel: Skylake: Modify the log level

Zidan Wang (5):
      ASoC: imx-spdif: add snd_soc_pm_ops for spdif machine driver
      ASoC: fsl_sai: Add driver suspend and resume to support MEGA Fast
      ASoC: fsl_spdif: Add driver suspend and resume to support MEGA Fast
      ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast
      ASoC: fsl_esai: Add driver suspend and resume to support MEGA Fast

kbuild test robot (2):
      ASoC: sunxi: fix platform_no_drv_owner.cocci warnings
      ASoC: nau8825: fix platform_no_drv_owner.cocci warnings

 Documentation/devicetree/bindings/sound/ak4613.txt |   17 +
 Documentation/devicetree/bindings/sound/ak4642.txt |   22 +-
 .../devicetree/bindings/sound/atmel-classd.txt     |   52 +
 Documentation/devicetree/bindings/sound/da7213.txt |   41 +
 Documentation/devicetree/bindings/sound/da7219.txt |  106 ++
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |   10 +-
 .../devicetree/bindings/sound/nau8825.txt          |  102 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    7 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    6 +-
 .../devicetree/bindings/sound/rockchip-spdif.txt   |   40 +
 Documentation/devicetree/bindings/sound/rt5640.txt |    9 +-
 .../devicetree/bindings/sound/sun4i-codec.txt      |   27 +
 .../devicetree/bindings/sound/tdm-slot.txt         |   11 +-
 MAINTAINERS                                        |    1 +
 drivers/spi/spi-atmel.c                            |   21 +-
 include/sound/da7213.h                             |    3 -
 include/sound/da7219-aad.h                         |   99 +
 include/sound/da7219.h                             |   55 +
 include/sound/designware_i2s.h                     |    2 +
 include/sound/pxa2xx-lib.h                         |    1 -
 include/sound/rt5640.h                             |    3 +-
 include/sound/rt5645.h                             |    2 +
 include/sound/simple_card.h                        |    2 +
 include/sound/soc-dai.h                            |   19 +-
 include/sound/soc-dapm.h                           |    3 +
 include/sound/soc.h                                |   27 +-
 include/uapi/sound/asoc.h                          |   76 +-
 sound/arm/pxa2xx-ac97.c                            |   13 +-
 sound/arm/pxa2xx-pcm-lib.c                         |  201 +-
 sound/arm/pxa2xx-pcm.c                             |   12 +-
 sound/arm/pxa2xx-pcm.h                             |    2 -
 sound/soc/Kconfig                                  |    6 +-
 sound/soc/Makefile                                 |    4 +-
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-classd.c                     |  679 +++++++
 sound/soc/atmel/atmel-classd.h                     |  120 ++
 sound/soc/atmel/atmel_wm8904.c                     |    1 +
 sound/soc/au1x/db1000.c                            |   10 +-
 sound/soc/au1x/db1200.c                            |   10 +-
 sound/soc/blackfin/bf5xx-ad1836.c                  |   11 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |   12 +-
 sound/soc/blackfin/bfin-eval-adau1701.c            |   12 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |   12 +-
 sound/soc/codecs/Kconfig                           |   23 +-
 sound/soc/codecs/Makefile                          |   10 +-
 sound/soc/codecs/ad193x-i2c.c                      |    8 +-
 sound/soc/codecs/ad193x-spi.c                      |   16 +-
 sound/soc/codecs/ad193x.c                          |  128 +-
 sound/soc/codecs/ad193x.h                          |    9 +-
 sound/soc/codecs/ak4613.c                          |  497 +++++
 sound/soc/codecs/ak4642.c                          |  153 +-
 sound/soc/codecs/arizona.c                         |   49 +
 sound/soc/codecs/arizona.h                         |   14 +-
 sound/soc/codecs/da7213.c                          |  190 +-
 sound/soc/codecs/da7213.h                          |    8 +-
 sound/soc/codecs/da7219-aad.c                      |  823 ++++++++
 sound/soc/codecs/da7219-aad.h                      |  212 +++
 sound/soc/codecs/da7219.c                          | 1955 ++++++++++++++++=
++++
 sound/soc/codecs/da7219.h                          |  820 ++++++++
 sound/soc/codecs/es8328.c                          |    2 +-
 sound/soc/codecs/hdmi.c                            |  109 --
 sound/soc/codecs/nau8825.c                         | 1309 +++++++++++++
 sound/soc/codecs/nau8825.h                         |  341 ++++
 sound/soc/codecs/rl6347a.c                         |   19 +-
 sound/soc/codecs/rl6347a.h                         |    2 +
 sound/soc/codecs/rt286.c                           |    9 +-
 sound/soc/codecs/rt298.c                           |   11 +-
 sound/soc/codecs/rt5640.c                          |   22 +-
 sound/soc/codecs/rt5645.c                          |  172 +-
 sound/soc/codecs/rt5645.h                          |   30 +-
 sound/soc/codecs/ssm2518.c                         |    6 -
 sound/soc/codecs/tlv320aic3x.c                     |   30 +-
 sound/soc/codecs/wm2000.c                          |    4 +-
 sound/soc/codecs/wm5110.c                          |  187 +-
 sound/soc/codecs/wm8731.c                          |    2 +-
 sound/soc/codecs/wm8903.c                          |    2 +-
 sound/soc/codecs/wm8904.c                          |    2 +-
 sound/soc/codecs/wm8955.c                          |    2 +-
 sound/soc/codecs/wm8960.c                          |    2 +-
 sound/soc/codecs/wm8998.c                          | 1430 ++++++++++++++
 sound/soc/codecs/wm8998.h                          |   23 +
 sound/soc/davinci/davinci-mcasp.c                  |  305 +--
 sound/soc/dwc/designware_i2s.c                     |  123 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  141 +-
 sound/soc/fsl/fsl_esai.c                           |   88 +
 sound/soc/fsl/fsl_sai.c                            |   38 +-
 sound/soc/fsl/fsl_spdif.c                          |   73 +
 sound/soc/fsl/fsl_ssi.c                            |  102 +
 sound/soc/fsl/imx-spdif.c                          |    1 +
 sound/soc/generic/simple-card.c                    |    8 +-
 sound/soc/intel/Kconfig                            |   15 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   19 +-
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/broadwell.c                 |    9 +-
 sound/soc/intel/boards/skl_rt286.c                 |  259 +++
 sound/soc/intel/common/Makefile                    |    6 +-
 sound/soc/intel/common/sst-dsp-priv.h              |    1 +
 sound/soc/intel/common/sst-dsp.c                   |    2 +
 sound/soc/intel/common/sst-dsp.h                   |    2 +
 sound/soc/intel/common/sst-firmware.c              |   10 +-
 sound/soc/intel/skylake/Makefile                   |    3 +-
 sound/soc/intel/skylake/skl-messages.c             |   44 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   10 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  176 +-
 sound/soc/intel/skylake/skl-sst-dsp.c              |    7 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   12 +
 sound/soc/intel/skylake/skl-sst-ipc.h              |    1 +
 sound/soc/intel/skylake/skl-sst.c                  |   56 +-
 sound/soc/intel/skylake/skl-topology.c             | 1252 +++++++++++++
 sound/soc/intel/skylake/skl-topology.h             |   36 +-
 sound/soc/intel/skylake/skl-tplg-interface.h       |   83 +
 sound/soc/intel/skylake/skl.c                      |   32 +-
 sound/soc/intel/skylake/skl.h                      |   17 +-
 sound/soc/jz4740/jz4740-i2s.c                      |    1 +
 sound/soc/kirkwood/armada-370-db.c                 |    1 +
 sound/soc/mediatek/mt8173-max98090.c               |   11 +-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |   11 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    6 +-
 sound/soc/omap/rx51.c                              |    2 +-
 sound/soc/pxa/brownstone.c                         |    9 +-
 sound/soc/pxa/corgi.c                              |   11 +-
 sound/soc/pxa/e740_wm9705.c                        |    5 +-
 sound/soc/pxa/e750_wm9705.c                        |    5 +-
 sound/soc/pxa/e800_wm9712.c                        |    5 +-
 sound/soc/pxa/hx4700.c                             |    4 +-
 sound/soc/pxa/imote2.c                             |   11 +-
 sound/soc/pxa/mioa701_wm9713.c                     |   11 +-
 sound/soc/pxa/palm27x.c                            |    9 +-
 sound/soc/pxa/poodle.c                             |   11 +-
 sound/soc/pxa/pxa-ssp.c                            |    1 +
 sound/soc/pxa/pxa2xx-ac97.c                        |   49 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    3 +
 sound/soc/pxa/pxa2xx-pcm.c                         |   33 +-
 sound/soc/pxa/spitz.c                              |    5 +-
 sound/soc/pxa/tosa.c                               |    5 +-
 sound/soc/pxa/ttc-dkb.c                            |   12 +-
 sound/soc/qcom/lpass-cpu.c                         |    3 +-
 sound/soc/rockchip/Kconfig                         |   12 +-
 sound/soc/rockchip/Makefile                        |    6 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   48 +-
 sound/soc/rockchip/rockchip_i2s.h                  |   16 +
 sound/soc/rockchip/rockchip_spdif.c                |  405 ++++
 sound/soc/rockchip/rockchip_spdif.h                |   63 +
 sound/soc/samsung/h1940_uda1380.c                  |    5 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    5 +-
 sound/soc/sh/Kconfig                               |    3 +-
 sound/soc/sh/rcar/adg.c                            |  306 ++-
 sound/soc/sh/rcar/core.c                           |   66 +-
 sound/soc/sh/rcar/ctu.c                            |   16 +-
 sound/soc/sh/rcar/dma.c                            |    2 +-
 sound/soc/sh/rcar/dvc.c                            |   16 +-
 sound/soc/sh/rcar/gen.c                            |   14 +-
 sound/soc/sh/rcar/mix.c                            |   16 +-
 {include/sound =3D> sound/soc/sh/rcar}/rcar_snd.h    |    1 -
 sound/soc/sh/rcar/rsnd.h                           |   29 +-
 sound/soc/sh/rcar/src.c                            |   27 +-
 sound/soc/sh/rcar/ssi.c                            |  113 +-
 sound/soc/sh/siu_dai.c                             |   85 +-
 sound/soc/soc-compress.c                           |   12 +-
 sound/soc/soc-core.c                               |   29 +-
 sound/soc/soc-dapm.c                               |   59 +-
 sound/soc/soc-ops.c                                |    8 +-
 sound/soc/soc-pcm.c                                |   49 +
 sound/soc/soc-topology.c                           |    4 +-
 sound/soc/sunxi/Kconfig                            |   11 +
 sound/soc/sunxi/Makefile                           |    2 +
 sound/soc/sunxi/sun4i-codec.c                      |  712 +++++++
 sound/soc/ux500/mop500.c                           |    1 +
 sound/soc/ux500/ux500_msp_dai.c                    |    1 +
 170 files changed, 14388 insertions(+), 1422 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4613.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da7213.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nau8825.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt
 create mode 100644 include/sound/da7219-aad.h
 create mode 100644 include/sound/da7219.h
 create mode 100644 sound/soc/atmel/atmel-classd.c
 create mode 100644 sound/soc/atmel/atmel-classd.h
 create mode 100644 sound/soc/codecs/ak4613.c
 create mode 100644 sound/soc/codecs/da7219-aad.c
 create mode 100644 sound/soc/codecs/da7219-aad.h
 create mode 100644 sound/soc/codecs/da7219.c
 create mode 100644 sound/soc/codecs/da7219.h
 delete mode 100644 sound/soc/codecs/hdmi.c
 create mode 100644 sound/soc/codecs/nau8825.c
 create mode 100644 sound/soc/codecs/nau8825.h
 create mode 100644 sound/soc/codecs/wm8998.c
 create mode 100644 sound/soc/codecs/wm8998.h
 create mode 100644 sound/soc/intel/boards/skl_rt286.c
 create mode 100644 sound/soc/intel/skylake/skl-topology.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h
 rename {include/sound =3D> sound/soc/sh/rcar}/rcar_snd.h (98%)
 create mode 100644 sound/soc/sunxi/Kconfig
 create mode 100644 sound/soc/sunxi/Makefile
 create mode 100644 sound/soc/sunxi/sun4i-codec.c

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWLbdfAAoJECTWi3JdVIfQRnMH/2qZ07ffk3zUpVREbwXU/SbN
lyW3I1KGeCmwD5tRXazS4Zxwss+VkVZxWh5zGk25xZVwQa6ZBOlt9M7TjUYUJyoc
3eJ/OjhRgG3myZF59tX9f9QjAlIEfydpZpmGMOfs5DYikeaxR99QVRk+yk+y2iLq
zDs5606QL1VhjA+tJbanxt7Auj5MNWP+4NKOIXUKAN5PfPhrIzHe0PjFvIYJT3Qs
mYopcZoamoWWnWxPbOGmF1mHaYIWy1ai9kMbK9nPApyzD6hl6CSsVNa15/wtt+YR
anO4LJW32KyyVYjrxPOkB99ziYOpEcaMWKoaIYpXWcjoxOaOeSjzRDZOa7dc6aE=
=IpFt
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--

--===============7936130242109396952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7936130242109396952==--
