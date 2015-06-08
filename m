From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.2
Date: Mon, 8 Jun 2015 18:51:09 +0100
Message-ID: <20150608175109.GL14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2340619488863538002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 432772604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 19:51:16 +0200 (CEST)
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


--===============2340619488863538002==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fEHFiqIAmqToArad"
Content-Disposition: inline


--fEHFiqIAmqToArad
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.2

for you to fetch changes up to 11e688862c4c8162119a4ca51c3326555966c8bb:

  Merge remote-tracking branches 'asoc/topic/wm8994', 'asoc/topic/wm8996' a=
nd 'asoc/topic/zx' into asoc-next (2015-06-05 18:55:07 +0100)

----------------------------------------------------------------
ASoC: Updates for v4.2

The big thing this release has been Liam's addition of topology support
to the core.  We've also seen quite a bit of driver work and the
continuation of Lars' refactoring for component support.

 - Support for loading ASoC topology maps from firmware, intended to be
   used to allow self-describing DSP firmware images to be built which
   can map controls added by the DSP to userspace without the kernel
   needing to know about individual DSP firmwares.
 - Lots of refactoring to avoid direct access to snd_soc_codec where
   it's not needed supporting future refactoring.
 - Big refactoring and cleanup serieses for the Wolfson ADSP and TI
   TAS2552 drivers.
 - Support for TI TAS571x power amplifiers.
 - Support for Qualcomm APQ8016 and ZTE ZX296702 SoCs.
 - Support for x86 systems with RT5650 and Qualcomm Storm.

----------------------------------------------------------------
Alexander Stein (2):
      ASoC: sgtl5000: Use specific variable for lo_vag
      ASoC: sgtl5000: Calculate Lineout Channel Output Level

Alexandre Belloni (2):
      ASoC: atmel: simplify Kconfig
      ASoC: atmel: compile pcm driver in snd-soc-atmel_ssc_dai

Anatol Pomozov (1):
      ASoC: rt5677: Add reset-gpio dts option

Antonio Ospite (1):
      ASoC: adau1977: fix typo s/Substraction/Subtraction/

Arnd Bergmann (3):
      ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency, again
      ASoC: qcom: remove incorrect dependencies
      ASoC: qcom: fix STORM board Kconfig

Axel Lin (7):
      ASoC: da7210: Fix dependency to allow build with SND_SOC_I2C_AND_SPI
      ASoC: sta32x: Use devm_gpiod_get_optional at appropriate place
      ASoC: sta350: Use devm_gpiod_get_optional at appropriate place
      ASoC: wm8737: Fixup setting VMID Impedance control register
      ASoC: wm8903: Fix define for WM8903_VMID_RES_250K
      ASoC: wm8955: Fix setting wrong register for WM8955_K_8_0_MASK bits
      ASoC: max98925: Fix mask for setting DAI invert mode

Bard Liao (10):
      ASoC: rt5645: Adds push button support for rt5650
      ASoC: rt5677: add i2s asrc clk src selection
      ASoC: rt5645: fix implicit declaration error
      ASoC: rt5645: fix wrong mask for button report
      ASoC: rt5645: remove RT5645_I2S_BCLK_MS1 control
      ASoC: rt5645: fix PLL source register definitions
      ASoC: rt5645: add TDM slot control into dapm route
      ASoC: rt5645: make volume TLV closer to reality
      ASoC: rt5645: fix add missing widget
      ASoC: rt5645: remove unused field in pdata

Charles Keepax (22):
      ASoC: wm_adsp: Split out adsp1 & 2 setup algorithms
      ASoC: wm_adsp: Improve variable naming
      ASoC: wm_adsp: Remove len field from wm_adsp_alg_region
      ASoC: wm_adsp: Limit firmware control name to ALSA control name size
      ASoC: wm_adsp: Move temporary control name to the stack
      ASoC: wm_adsp: Clean up low level control read/write functions
      ASoC: wm_adsp: Factor out creation of alg_regions
      ASoC: wm_adsp: Remove private field from wm_coeff_ctl
      ASoC: wm_adsp: Group all the ALSA control functions together
      ASoC: wm_adsp: Add basic support for rev 1 firmware file format
      ASoC: wm_adsp: Add support for rev 2 firmware file format
      ASoC: wm_adsp: Warn that firmware file format 0 is depreciated
      ASoC: wm_adsp: Use __leXX for little endian data
      ASoC: wm_adsp: Add support for DSP control flags
      ASoC: dapm: Remove local OOM error message
      ASoC: Correct typo in SOC_VALUE_ENUM_SINGLE macro
      ASoC: dapm: Append "Autodisable" to autodisable widget names
      ASoC: dapm: Add support for autodisable mux controls
      ASoC: arizona: Use auto disable muxes for routing
      ASoC: dapm: Add missing mutex unlock
      ASoC: dapm: Break out of widget search when source and sink are locat=
ed
      ASoC: dapm: Add cache to speed up adding of routes

Dan Carpenter (1):
      ASoC: wm8741: check for error returns from wm8741_set_pdata()

Dylan Reid (2):
      ASoC: Add jack types to dt-bindings
      ASoC: jack - add_gpiods accepts filled descriptors

Fabio Estevam (8):
      ASoC: fsl_ssi: No need call of_device_is_available()
      ASoC: fsl: fsl_dma: Use true/false for boolean init
      ASoC: fsl: imx-mc13783: Simplify trivial if-return sequence
      ASoC: wm8996: Pass the IRQF_ONESHOT flag
      ASoC: wm5100: Pass the IRQF_ONESHOT flag
      ASoC: wm8994: Pass the IRQF_ONESHOT flag
      ASoC: twl6040: Pass the IRQF_ONESHOT flag
      ASoC: max98095: Pass the IRQF_ONESHOT flag

Fang, Yang A (10):
      ASoC: Intel: Add support rt5650 in sst driver
      ASoC: rt5645: set platform data base on DMI
      ASoC: rt5645: fixed kbuild err
      ASoC: Intel: Add support max98090 in sst driver
      ASoC: Intel: Add Cherrytrail & Braswell machine driver cht_bsw_max980=
90_ti
      ASoC: Intel: Support rt5650 codec for Cherrytrail & Braswell
      ASoC: Intel: Fixed kbuild warnings
      ASoC: Intel: Enabled button jack for BSW platform with rt5650 codec
      ASoC: max98090: read micbias from device property
      ASoC: ts3a227e: use device property api

Geert Uytterhoeven (2):
      ASoC: rsnd: Use generic names for device nodes
      ASoC: rsnd: Document r8a7778-specific binding

Jie Yang (6):
      ASoC: Intel: remove unused function hsw_pcm_free_modules()
      ASoC: Intel: don't need compress offload for broadwell
      ASoC: intel: Revert "ASoC: Intel: remove unused function hsw_pcm_free=
_modules()"
      ASoC: intel: Revert "ASoC: Intel: fix broadwell module removing faile=
d issue"
      ASoC: Intel: check and clear runtime module pointer
      ASoC: Intel: handle haswell pcm suspend including runtime modules fre=
eing

Jin Yao (1):
      ASoC: Intel: Remove invalid kfree of devm allocated data

John Lin (5):
      ASoC: rt5645: improve headphone depop function
      ASoC: rt5645: remove unnecessary power in JD function
      ASoC: rt5645: fix IRQ error in jack detection
      ASoC: rt5645: fix jack type detect error
      ASoC: rt5645: fix kernel hang when call rt5645_set_jack_detect()

Jun Nie (5):
      ASoC: simple-card: support platform in dts parse
      ASoC: zx: Add zx296702 SPDIF support
      ASoC: zx: Add ZTE zx296702 I2S DAI driver
      dt: Add documentation for the ZTE SPDIF controller
      dt: Add documentation for the ZTE I2S controller

Jyri Sarha (4):
      ASoC: davinci-mcasp: Calculate BCLK using TDM slots and remove channe=
ls rule
      ASoC: davinci-mcasp: Channel count constraints for multi-serializer c=
ase
      ASoC: davinci-macsp: Optimize implicit BLCK sample-rate rule
      ASoC: core: If component doesn't have of_node use parent's node inste=
ad

Kevin Cernekee (4):
      ASoC: tas571x: Add DT binding document
      ASoC: tas571x: New driver for TI TAS571x power amplifiers
      MAINTAINERS: Add entry for tas571x ASoC codec driver
      ASoC: tas571x: Eliminate redundant dev->of_node NULL check

Krzysztof Kozlowski (4):
      ASoC: au1x: Constify platform_device_id
      ASoC: bt-sco: Constify platform_device_id
      ASoC: fsl: Constify platform_device_id
      ASoC: samsung: Constify platform_device_id

Kuninori Morimoto (13):
      ASoC: rsnd: add rsnd_dai_to_priv() macro
      ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call
      ASoC: rsnd: tidyup SSI parent related function/macro names
      ASoC: rsnd: make sure SSI parent/child uses same number of sound chan=
nel.
      ASoC: rsnd: care snd_kcontrol's index
      ASoC: soc.h: tidyup struct snd_soc_dai_link definition order
      ASoC: rsnd: revert lock for calls to rsnd_dai_call
      ASoC: rsnd: indicate unknown HW start
      ASoC: rsnd: add rsnd_dai_stream_quit()
      ASoC: soc-pcm: DPCM cares BE format
      ASoC: rsnd: rsrc-card uses FE/BE merged format when DPCM
      dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
      ASoC: rsnd: spin lock for interrupt handler

Lars-Peter Clausen (114):
      ASoC: at91sam9g20ek: Automatically disconnect non-connected pins
      ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE internal
      ASoC: Add helper function getting CODEC's DAPM context
      ASoC: Add helper functions bias level management
      ASoC: Route all bias level updates through the core
      ASoC: Move bias level update to the core
      ASoC: samsung: wolfson: Improve compile test coverage
      ASoC: lowland: Use card DAPM context to access widgets
      ASoC: smdk_wm8994: Use card DAPM context to access widgets
      ASoC: smartq: Remove unnecessary snd_soc_dapm_disable_pin()
      ASoC: smartq: Use card DAPM context to access widgets
      ASoC: speyside: Use snd_soc_codec_get_dapm()
      ASoC: ad1836: Replace direct snd_soc_codec dapm field access
      ASoC: adau17x1: Replace direct snd_soc_codec dapm field access
      ASoC: adau1977: Replace direct snd_soc_codec dapm field access
      ASoC: adav80x: Replace direct snd_soc_codec dapm field access
      ASoC: ssm2518: Replace direct snd_soc_codec dapm field access
      ASoC: ssm2602: Replace direct snd_soc_codec dapm field access
      ASoC: ssm4567: Replace direct snd_soc_codec dapm field access
      ASoC: dapm: Add new widgets to the end of the widget list
      ASoC: dapm: Add new widgets to the end of the widget list
      ASoC: dapm: Add demux support
      ASoC: lm4857: Use DAPM demux
      ASoC: lm4857: Convert to component
      ASoC: omap-twl4030: Use card DAPM context to access widgets
      ASoC: brownstone: Automatically disconnect non-connected pins
      ASoC: poodle: Automatically disconnect non-connected pins
      ASoC: tosa: Automatically disconnect non-connected pins
      ASoC: z2: Automatically disconnect non-connected pins
      ASoC: 88pm860x: Replace direct snd_soc_codec dapm field access
      ASoC: ab8500: Replace direct snd_soc_codec dapm field access
      ASoC: ak4641: Replace direct snd_soc_codec dapm field access
      ASoC: cx20442: Replace direct snd_soc_codec dapm field access
      ASoC: es8328: Replace direct snd_soc_codec dapm field access
      ASoC: jz4740: Replace direct snd_soc_codec dapm field access
      ASoC: ml26124: Replace direct snd_soc_codec dapm field access
      ASoC: uda134x: Replace direct snd_soc_codec dapm field access
      ASoC: uda1380: Replace direct snd_soc_codec dapm field access
      ASoC: sgtl5000: Replace direct snd_soc_codec dapm field access
      ASoC: sirf-audio-codec: Replace direct snd_soc_codec dapm field access
      ASoC: sn95031: Replace direct snd_soc_codec dapm field access
      ASoC: lm49453: Replace direct snd_soc_codec dapm field access
      ASoC: pcm512x: Replace direct snd_soc_codec dapm field access
      ASoC: tlv320aix31xx: Replace direct snd_soc_codec dapm field access
      ASoC: tlv320aic3x: Replace direct snd_soc_codec dapm field access
      ASoC: tlv320dac33: Replace direct snd_soc_codec dapm field access
      ASoC: twl4030: Replace direct snd_soc_codec dapm field access
      ASoC: twl6040: Replace direct snd_soc_codec dapm field access
      ASoC: Drop unnecessary bias level check on resume
      ASoC: sta32x: Replace direct snd_soc_codec dapm field access
      ASoC: sta350: Replace direct snd_soc_codec dapm field access
      ASoC: sta529: Replace direct snd_soc_codec dapm field access
      ASoC: da7213: Replace direct snd_soc_codec dapm field access
      ASoC: da732x: Replace direct snd_soc_codec dapm field access
      ASoC: da9055: Replace direct snd_soc_codec dapm field access
      ASoC: max98088: Replace direct snd_soc_codec dapm field access
      ASoC: max98090: Remove unnecessary snd_soc_dapm_sync()
      ASoC: max98090: Replace direct snd_soc_codec dapm field access
      ASoC: max98095: Replace direct snd_soc_codec dapm field access
      ASoC: max9850: Replace direct snd_soc_codec dapm field access
      ASoC: alc5623: Replace direct snd_soc_codec dapm field access
      ASoC: rt286: Replace direct snd_soc_codec dapm field access
      ASoC: rt5631: Replace direct snd_soc_codec dapm field access
      ASoC: rt5640: Replace direct snd_soc_codec dapm field access
      ASoC: rt5651: Replace direct snd_soc_codec dapm field access
      ASoC: rt5670: Replace direct snd_soc_codec dapm field access
      ASoC: rt5677: Replace direct snd_soc_codec dapm field access
      ASoC: cs42l52: Replace direct snd_soc_codec dapm field access
      ASoC: cs42l56: Replace direct snd_soc_codec dapm field access
      ASoC: cs42l73: Replace direct snd_soc_codec dapm field access
      ASoC: cs42xx8: Replace direct snd_soc_codec dapm field access
      ASoC: arizona: Replace direct snd_soc_codec dapm field access
      ASoC: wm0010: Replace direct snd_soc_codec dapm field access
      ASoC: wm5100: Replace direct snd_soc_codec dapm field access
      ASoC: wm5102: Replace direct snd_soc_codec dapm field access
      ASoC: wm5110: Replace direct snd_soc_codec dapm field access
      ASoC: wm8350: Replace direct snd_soc_codec dapm field access
      ASoC: wm8400: Replace direct snd_soc_codec dapm field access
      ASoC: wm8510: Replace direct snd_soc_codec dapm field access
      ASoC: wm8523: Replace direct snd_soc_codec dapm field access
      ASoC: wm8580: Replace direct snd_soc_codec dapm field access
      ASoC: wm8711: Replace direct snd_soc_codec dapm field access
      ASoC: wm8728: Replace direct snd_soc_codec dapm field access
      ASoC: wm8731: Replace direct snd_soc_codec dapm field access
      ASoC: wm8737: Replace direct snd_soc_codec dapm field access
      ASoC: wm8750: Replace direct snd_soc_codec dapm field access
      ASoC: wm8753: Replace direct snd_soc_codec dapm field access
      ASoC: wm8770: Replace direct snd_soc_codec dapm field access
      ASoC: wm8776: Replace direct snd_soc_codec dapm field access
      ASoC: wm8804: Replace direct snd_soc_codec dapm field access
      ASoC: wm8900: Replace direct snd_soc_codec dapm field access
      ASoC: wm8903: Replace direct snd_soc_codec dapm field access
      ASoC: wm8904: Replace direct snd_soc_codec dapm field access
      ASoC: wm8940: Replace direct snd_soc_codec dapm field access
      ASoC: wm8955: Replace direct snd_soc_codec dapm field access
      ASoC: wm8960: Replace direct snd_soc_codec dapm field access
      ASoC: wm8961: Replace direct snd_soc_codec dapm field access
      ASoC: wm8962: Replace direct snd_soc_codec dapm field access
      ASoC: wm8971: Replace direct snd_soc_codec dapm field access
      ASoC: wm8974: Replace direct snd_soc_codec dapm field access
      ASoC: wm8978: Replace direct snd_soc_codec dapm field access
      ASoC: wm8983: Replace direct snd_soc_codec dapm field access
      ASoC: wm8985: Replace direct snd_soc_codec dapm field access
      ASoC: wm8988: Replace direct snd_soc_codec dapm field access
      ASoC: wm8990: Replace direct snd_soc_codec dapm field access
      ASoC: wm8991: Replace direct snd_soc_codec dapm field access
      ASoC: wm8993: Replace direct snd_soc_codec dapm field access
      ASoC: wm8994: Replace direct snd_soc_codec dapm field access
      ASoC: wm8995: Replace direct snd_soc_codec dapm field access
      ASoC: wm8996: Replace direct snd_soc_codec dapm field access
      ASoC: wm8997: Replace direct snd_soc_codec dapm field access
      ASoC: wm9081: Replace direct snd_soc_codec dapm field access
      ASoC: wm9090: Replace direct snd_soc_codec dapm field access
      ASoC: wm_hubs: Replace direct snd_soc_codec dapm field access

Liam Girdwood (6):
      ASoC: Intel: fix broadwell module removing failed issue
      ASoC: DAPM: Add APIs to create individual DAPM controls.
      ASoC: topology: Add topology UAPI header
      ASoC: topology: Add topology core
      ALSA: topology: Export ID types for TLV controls.
      ASoC: dapm: fix build errors for missing snd_soc_dapm_new_control sym=
bol

Maciej S. Szmigiero (3):
      ASoC: ac97: Remove rate constraints
      ASoC: ac97: make selectable in config
      ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask

Marek Belisko (2):
      ASoC: gtm601: Document GTM601 bindings
      ASoC: bt-sco: Add devicetree support for bt-sco codec

Mark Brown (27):
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5645
      Merge branch 'topic/dapm' of git://git.kernel.org/.../broonie/sound i=
nto asoc-tas751x
      ASoC: tas751x: Factor setting of new bias level into the core
      Merge branch 'topic/rt5645' of git://git.kernel.org/.../broonie/sound=
 into asoc-intel
      Merge branch 'topic/dpcm' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rcar
      Merge branch 'topic/rcar-dma' of git://git.kernel.org/.../broonie/sou=
nd into asoc-rcar
      Merge branch 'topic/adsp' of git://git.kernel.org/.../broonie/sound i=
nto asoc-arizona
      ASoC: zte: Fix missing dev in devm operation
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/fmtbit',=
 'asoc/fix/max98925', 'asoc/fix/rcar' and 'asoc/fix/ux500' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/wm8737', 'asoc/fix/wm8903' a=
nd 'asoc/fix/wm8955' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ac97', 'asoc/topic/ad1836'=
, 'asoc/topic/ada1977', 'asoc/topic/adau1701' and 'asoc/topic/adau17x1' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/adau1977', 'asoc/topic/ada=
v80x', 'asoc/topic/arizona' and 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/au1x', 'asoc/topic/bt-sco'=
, 'asoc/topic/cs35l32' and 'asoc/topic/da7210' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci' and 'asoc/topic/d=
pcm' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl', 'asoc/topic/fsl-sai'=
, 'asoc/topic/fsl-spdif', 'asoc/topic/fsl-ssi' and 'asoc/topic/gpio-jack' i=
nto asoc-next
      Merge remote-tracking branches 'asoc/topic/gpiod-flags', 'asoc/topic/=
gtm601', 'asoc/topic/intel', 'asoc/topic/lm3857' and 'asoc/topic/max98090' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98095', 'asoc/topic/oma=
p', 'asoc/topic/pxa', 'asoc/topic/qcom' and 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5677', 'asoc/topic/samsu=
ng' and 'asoc/topic/sgtl5000' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple', 'asoc/topic/ssm25=
18', 'asoc/topic/ssm2602', 'asoc/topic/ssm4567' and 'asoc/topic/sta32x' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/sta350', 'asoc/topic/tas25=
52', 'asoc/topic/tas3a227e' and 'asoc/topic/tas571x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/topology', 'asoc/topic/twl=
6040', 'asoc/topic/wm5100', 'asoc/topic/wm8741' and 'asoc/topic/wm8960' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8994', 'asoc/topic/wm899=
6' and 'asoc/topic/zx' into asoc-next

Nicolas Boichat (2):
      ASoC: rt5645: Rename HP control to Headphone
      ASoC: rt5645: Init jack_detect_work before registering irq

Nicolin Chen (1):
      ASoC: fsl_spdif: Don't try to round-up for clock divisor calculation

Oder Chiou (1):
      ASoC: rt5677: Add DMIC ASRC detect function

Pascal Huerst (1):
      ASoC: adau1701: add regulator consumer support

Peter Ujfalusi (18):
      ASoC: tas2552: Make the enable-gpio really optional
      ASoC: tas2552: Fix kernel crash when the codec is loaded but not part=
 of a card
      ASoC: tas2552: Fix kernel crash caused by wrong kcontrol entry
      ASoC: tas2552: Correct PDM configuration register bit definitions
      ASoC: tas2552: Correct CFG1 register bit definitions
      ASoC: tas2552: Simplify the tas2552_mute function
      ASoC: tas2552: Simplify and reverse the functionality of tas2552_sw_s=
hutdown
      ASoC: tas2552: Rename mclk parameter to pll_clkin to match with the d=
atasheet
      ASoC: tas2552: bindings header file for tas2552 codec
      ASoC: tas2552: Add support for pll and pdm source clock selection
      ASoC: tas2552: Correct dai format support
      ASoC: tas2552: Correct and clean up data format and BCLK/WCLK directi=
on
      ASoC: tas2552: Add TDM support
      ASoC: tas2552: Clean up the Digital - Analog DAPM route definition
      ASoC: tas2552: Correct the Speaker Driver Playback Volume (PGA_GAIN)
      ASoC: tas2552: Implement startup/stop sequence as per TRM
      ASoC: tas2552: Add support for word length configuration
      ASoC: tas2552: Configure the WCLK frequency based on the stream

Rajan Vaja (1):
      ASoC: mop500_ab8500: Add a NULL pointer check in mop500_ab8500_machin=
e_init()

Richard Fitzgerald (6):
      ASoC: arizona: Fix noise generator gain TLV
      ASoC: wm_adsp: Dump scratch registers on DSP shutdown
      ASoC: arizona: Export functions to control subsystem DVFS
      ASoC: wm_adsp: Move DVFS control into codec driver
      ASoC: arizona: Add DVFS handling for sample rate control
      regulator: arizona-ldo1: Do not control DVFS clocking from regulator

Sergej Sawazki (1):
      ASoC: wm8741: Add differential mono mode support

Srinivas Kandagatla (13):
      ASoC: qcom: Remove redundant error check.
      ASoC: qcom: remove unnecessary header files
      ASoC: qcom: move ipq806x specific bits out of lpass driver.
      ASoC: qcom: remove hardcoded i2s port number
      ASoC: qcom: remove hardcoded dma channel
      ASoC: skip legacy dai naming if dai driver has all the information
      ASoC: qcom: support bitclk and osrclk per i2s port
      ASoC: qcom: make osr clock optional
      ASoC: qcom: add dma channel control offset to variant data
      ASoC: qcom: Add ability to handle interrupts per dma channel
      ASoC: qcom: add bit map to track static dma channel allocations
      ASoC: qcom: Document apq8016 bindings.
      ASoC: qcom: Add apq8016 lpass driver support

Subhransu S. Prusty (8):
      ASoC: Intel: Create an ops to check for DSP busy
      ASoC: Intel: Move the busy check to ops for Baytrail
      ASoC: Intel: Move the busy check to ops for HSW
      ASoC: Intel: Remove the direct register reference from common ipc
      ASoC: Intel: Allow to configure max size for mailbox data
      ASoC: Intel: Initialize max mailbox size for baytrail
      ASoC: Intel: Initialize max mailbox size for haswell
      ASoC: Intel: Allocate for the mailbox with max size

Sudip Mukherjee (1):
      ASoC: rt5645: fixed section mismatch

Takashi Iwai (1):
      ASoC: Simplify format_register_str() without stack usages

Uwe Kleine-K=F6nig (3):
      ASoC: sta32x: use devm_gpiod_get_optional for optional reset gpio
      ASoC: max98357a: use flags argument of devm_gpiod_get to set direction
      ASoC: rx51: use flags argument of devm_gpiod_get to set direction

Vinod Koul (6):
      ASoC: intel - use SNDRV_CTL_ELEM_ID_NAME_MAXLEN
      ASoC: Intel: add frame and data polarity to ssp config
      ASoC: Intel: use local values for ssp configuration
      ASoC: Intel: load hw_defaults in hw_params of ssp be
      ASoC: intel: add support for specifying PCM format
      ASoC: Intel: add support for configuring TDM slots for SSP

Vladimir Zapolskiy (1):
      ASoC: dapm: fix snd_soc_dapm_new_control() implicit declaration

Wei Yongjun (1):
      ASoC: cs35l32: Remove unused including <linux/version.h>

Zidan Wang (4):
      ASoC: fsl_sai: add sai master mode support
      ASoC: fsl_sai: add 12kHz, 24kHz, 176.4kHz and 192kHz sample rate supp=
ort
      ASoC: wm8960: Let wm8960 driver configure its bit clock and frame clo=
ck
      ASoC: wm8960: add 32 bit word length support

kbuild test robot (7):
      ASoC: adau1977: fix simple_return.cocci warnings
      ASoC: ssm2518: fix simple_return.cocci warnings
      ASoC: qcom: ipq806x_lpass_alloc_dma_channel() can be static
      ASoC: zx: zx_i2s_dai can be static
      ASoC: zx: fix platform_no_drv_owner.cocci warnings
      ASoC: zx: fix simple_return.cocci warnings
      ASoC: zx: fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/sound/adi,adau1701.txt     |    4 +
 Documentation/devicetree/bindings/sound/bt-sco.txt |   13 +
 Documentation/devicetree/bindings/sound/gtm601.txt |   13 +
 .../devicetree/bindings/sound/max98090.txt         |    6 +
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |   13 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    3 +-
 Documentation/devicetree/bindings/sound/rt5677.txt |    2 +
 .../devicetree/bindings/sound/tas571x.txt          |   41 +
 Documentation/devicetree/bindings/sound/wm8741.txt |   11 +
 .../devicetree/bindings/sound/zte,zx-i2s.txt       |   44 +
 .../devicetree/bindings/sound/zte,zx-spdif.txt     |   28 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    6 +
 drivers/dma/sh/rcar-dmac.c                         |   37 +-
 drivers/regulator/arizona-ldo1.c                   |    5 -
 include/dt-bindings/sound/apq8016-lpass.h          |    9 +
 include/dt-bindings/sound/audio-jack-events.h      |    9 +
 include/dt-bindings/sound/tas2552.h                |   18 +
 include/sound/dmaengine_pcm.h                      |    5 -
 include/sound/rt5645.h                             |    3 -
 include/sound/soc-dapm.h                           |   49 +
 include/sound/soc-topology.h                       |  168 ++
 include/sound/soc.h                                |  118 +-
 include/sound/tlv.h                                |   15 +-
 include/uapi/sound/asoc.h                          |  388 +++++
 include/uapi/sound/tlv.h                           |   31 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    2 +
 sound/soc/atmel/Kconfig                            |   20 +-
 sound/soc/atmel/Makefile                           |    8 +-
 sound/soc/atmel/atmel-pcm-dma.c                    |    3 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   10 +-
 sound/soc/au1x/db1200.c                            |    2 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |    1 -
 sound/soc/codecs/88pm860x-codec.c                  |   19 +-
 sound/soc/codecs/Kconfig                           |   12 +-
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ab8500-codec.c                    |   20 +-
 sound/soc/codecs/ac97.c                            |    8 +-
 sound/soc/codecs/ad1836.c                          |    2 +-
 sound/soc/codecs/adau1373.c                        |    1 -
 sound/soc/codecs/adau1701.c                        |  126 +-
 sound/soc/codecs/adau1761.c                        |   27 +-
 sound/soc/codecs/adau1781.c                        |   10 +-
 sound/soc/codecs/adau17x1.c                        |   20 +-
 sound/soc/codecs/adau1977.c                        |   14 +-
 sound/soc/codecs/adav80x.c                         |   11 +-
 sound/soc/codecs/ak4535.c                          |    1 -
 sound/soc/codecs/ak4641.c                          |    3 +-
 sound/soc/codecs/ak4642.c                          |    1 -
 sound/soc/codecs/ak4671.c                          |    1 -
 sound/soc/codecs/alc5623.c                         |    3 +-
 sound/soc/codecs/alc5632.c                         |    1 -
 sound/soc/codecs/arizona.c                         |  174 +-
 sound/soc/codecs/arizona.h                         |   17 +-
 sound/soc/codecs/bt-sco.c                          |   11 +-
 sound/soc/codecs/cq93vc.c                          |    1 -
 sound/soc/codecs/cs35l32.c                         |    1 -
 sound/soc/codecs/cs4265.c                          |    1 -
 sound/soc/codecs/cs42l52.c                         |    5 +-
 sound/soc/codecs/cs42l56.c                         |    5 +-
 sound/soc/codecs/cs42l73.c                         |    3 +-
 sound/soc/codecs/cs42xx8.c                         |    2 +-
 sound/soc/codecs/cx20442.c                         |    6 +-
 sound/soc/codecs/da7213.c                          |    3 +-
 sound/soc/codecs/da732x.c                          |    4 +-
 sound/soc/codecs/da9055.c                          |    3 +-
 sound/soc/codecs/es8328.c                          |    3 +-
 sound/soc/codecs/isabelle.c                        |    2 -
 sound/soc/codecs/jz4740.c                          |    4 +-
 sound/soc/codecs/lm4857.c                          |  114 +-
 sound/soc/codecs/lm49453.c                         |    4 +-
 sound/soc/codecs/max98088.c                        |    3 +-
 sound/soc/codecs/max98090.c                        |   34 +-
 sound/soc/codecs/max98095.c                        |   24 +-
 sound/soc/codecs/max98357a.c                       |    3 +-
 sound/soc/codecs/max9850.c                         |    3 +-
 sound/soc/codecs/max98925.c                        |    2 +-
 sound/soc/codecs/ml26124.c                         |    3 +-
 sound/soc/codecs/pcm512x.c                         |    8 +-
 sound/soc/codecs/rt286.c                           |   33 +-
 sound/soc/codecs/rt5631.c                          |    5 +-
 sound/soc/codecs/rt5640.c                          |   16 +-
 sound/soc/codecs/rt5645.c                          | 1089 +++++++++---
 sound/soc/codecs/rt5645.h                          |   30 +-
 sound/soc/codecs/rt5651.c                          |    5 +-
 sound/soc/codecs/rt5670.c                          |   26 +-
 sound/soc/codecs/rt5677.c                          |  157 +-
 sound/soc/codecs/rt5677.h                          |   15 +
 sound/soc/codecs/sgtl5000.c                        |   56 +-
 sound/soc/codecs/sirf-audio-codec.c                |    2 +-
 sound/soc/codecs/sn95031.c                         |   12 +-
 sound/soc/codecs/ssm2518.c                         |    9 +-
 sound/soc/codecs/ssm2602.c                         |    5 +-
 sound/soc/codecs/ssm4567.c                         |    9 +-
 sound/soc/codecs/sta32x.c                          |   19 +-
 sound/soc/codecs/sta350.c                          |    9 +-
 sound/soc/codecs/sta529.c                          |    8 +-
 sound/soc/codecs/stac9766.c                        |    3 +-
 sound/soc/codecs/tas2552.c                         |  312 +++-
 sound/soc/codecs/tas2552.h                         |   90 +-
 sound/soc/codecs/tas571x.c                         |  514 ++++++
 sound/soc/codecs/tas571x.h                         |   33 +
 sound/soc/codecs/tlv320aic23.c                     |    1 -
 sound/soc/codecs/tlv320aic31xx.c                   |   11 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    1 -
 sound/soc/codecs/tlv320aic3x.c                     |   10 +-
 sound/soc/codecs/tlv320dac33.c                     |    5 +-
 sound/soc/codecs/ts3a227e.c                        |   15 +-
 sound/soc/codecs/twl4030.c                         |    3 +-
 sound/soc/codecs/twl6040.c                         |    9 +-
 sound/soc/codecs/uda134x.c                         |    4 +-
 sound/soc/codecs/uda1380.c                         |    6 +-
 sound/soc/codecs/wm0010.c                          |    6 +-
 sound/soc/codecs/wm1250-ev1.c                      |    2 -
 sound/soc/codecs/wm5100.c                          |   12 +-
 sound/soc/codecs/wm5102.c                          |   62 +-
 sound/soc/codecs/wm5110.c                          |   11 +-
 sound/soc/codecs/wm8350.c                          |    3 +-
 sound/soc/codecs/wm8400.c                          |    3 +-
 sound/soc/codecs/wm8510.c                          |    3 +-
 sound/soc/codecs/wm8523.c                          |    3 +-
 sound/soc/codecs/wm8580.c                          |    3 +-
 sound/soc/codecs/wm8711.c                          |    3 +-
 sound/soc/codecs/wm8728.c                          |    3 +-
 sound/soc/codecs/wm8731.c                          |    8 +-
 sound/soc/codecs/wm8737.c                          |   11 +-
 sound/soc/codecs/wm8741.c                          |  129 +-
 sound/soc/codecs/wm8741.h                          |   10 +
 sound/soc/codecs/wm8750.c                          |    3 +-
 sound/soc/codecs/wm8753.c                          |    3 +-
 sound/soc/codecs/wm8770.c                          |    3 +-
 sound/soc/codecs/wm8776.c                          |    3 +-
 sound/soc/codecs/wm8804.c                          |    2 +-
 sound/soc/codecs/wm8900.c                          |   13 +-
 sound/soc/codecs/wm8903.c                          |    4 +-
 sound/soc/codecs/wm8903.h                          |    2 +-
 sound/soc/codecs/wm8904.c                          |    5 +-
 sound/soc/codecs/wm8940.c                          |    6 +-
 sound/soc/codecs/wm8955.c                          |    7 +-
 sound/soc/codecs/wm8960.c                          |  125 +-
 sound/soc/codecs/wm8961.c                          |    6 +-
 sound/soc/codecs/wm8962.c                          |   21 +-
 sound/soc/codecs/wm8971.c                          |    3 +-
 sound/soc/codecs/wm8974.c                          |    3 +-
 sound/soc/codecs/wm8978.c                          |    7 +-
 sound/soc/codecs/wm8983.c                          |    3 +-
 sound/soc/codecs/wm8985.c                          |    3 +-
 sound/soc/codecs/wm8988.c                          |    3 +-
 sound/soc/codecs/wm8990.c                          |    5 +-
 sound/soc/codecs/wm8991.c                          |    3 +-
 sound/soc/codecs/wm8993.c                          |   12 +-
 sound/soc/codecs/wm8994.c                          |   68 +-
 sound/soc/codecs/wm8995.c                          |    6 +-
 sound/soc/codecs/wm8996.c                          |   23 +-
 sound/soc/codecs/wm8997.c                          |   18 +-
 sound/soc/codecs/wm9081.c                          |    4 +-
 sound/soc/codecs/wm9090.c                          |    6 +-
 sound/soc/codecs/wm9712.c                          |    3 +-
 sound/soc/codecs/wm9713.c                          |    7 +-
 sound/soc/codecs/wm_adsp.c                         | 1210 +++++++------
 sound/soc/codecs/wm_adsp.h                         |   19 +-
 sound/soc/codecs/wm_hubs.c                         |    4 +-
 sound/soc/codecs/wmfw.h                            |   44 +-
 sound/soc/davinci/davinci-mcasp.c                  |  167 +-
 sound/soc/fsl/fsl_dma.c                            |    4 +-
 sound/soc/fsl/fsl_sai.c                            |  144 +-
 sound/soc/fsl/fsl_sai.h                            |    9 +-
 sound/soc/fsl/fsl_spdif.c                          |   10 +-
 sound/soc/fsl/fsl_ssi.c                            |    7 -
 sound/soc/fsl/imx-audmux.c                         |    2 +-
 sound/soc/fsl/imx-mc13783.c                        |    6 +-
 sound/soc/generic/simple-card.c                    |   16 +-
 sound/soc/intel/Kconfig                            |   17 +-
 sound/soc/intel/atom/sst-atom-controls.c           |  167 +-
 sound/soc/intel/atom/sst-atom-controls.h           |    9 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   47 +-
 sound/soc/intel/atom/sst-mfld-platform.h           |    2 +
 sound/soc/intel/atom/sst/sst_acpi.c                |    4 +
 sound/soc/intel/baytrail/sst-baytrail-ipc.c        |   11 +
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  318 ++++
 sound/soc/intel/boards/cht_bsw_rt5645.c            |  118 +-
 sound/soc/intel/common/sst-ipc.c                   |   34 +-
 sound/soc/intel/common/sst-ipc.h                   |    7 +-
 sound/soc/intel/haswell/sst-haswell-ipc.c          |   12 +
 sound/soc/intel/haswell/sst-haswell-pcm.c          |   31 +-
 sound/soc/omap/Kconfig                             |    5 +-
 sound/soc/omap/omap-twl4030.c                      |    3 +-
 sound/soc/omap/rx51.c                              |   30 +-
 sound/soc/pxa/brownstone.c                         |   25 +-
 sound/soc/pxa/poodle.c                             |   19 +-
 sound/soc/pxa/tosa.c                               |   13 +-
 sound/soc/pxa/z2.c                                 |    9 +-
 sound/soc/qcom/Kconfig                             |   19 +-
 sound/soc/qcom/Makefile                            |    4 +
 sound/soc/qcom/lpass-apq8016.c                     |  242 +++
 sound/soc/qcom/lpass-cpu.c                         |  240 +--
 sound/soc/qcom/lpass-ipq806x.c                     |  109 ++
 .../{lpass-lpaif-ipq806x.h =3D> lpass-lpaif-reg.h}   |   92 +-
 sound/soc/qcom/lpass-platform.c                    |  202 ++-
 sound/soc/qcom/lpass.h                             |   51 +-
 sound/soc/samsung/Kconfig                          |   15 +-
 sound/soc/samsung/i2s.c                            |    2 +-
 sound/soc/samsung/lowland.c                        |    2 +-
 sound/soc/samsung/smartq_wm8987.c                  |    6 +-
 sound/soc/samsung/smdk_wm8994.c                    |    3 +-
 sound/soc/samsung/speyside.c                       |    2 +-
 sound/soc/sh/rcar/core.c                           |   32 +-
 sound/soc/sh/rcar/rsnd.h                           |    3 +-
 sound/soc/sh/rcar/rsrc-card.c                      |    1 +
 sound/soc/sh/rcar/src.c                            |   11 +-
 sound/soc/sh/rcar/ssi.c                            |   70 +-
 sound/soc/soc-core.c                               |   67 +-
 sound/soc/soc-dapm.c                               |  349 +++-
 sound/soc/soc-generic-dmaengine-pcm.c              |   25 +-
 sound/soc/soc-jack.c                               |    9 +-
 sound/soc/soc-pcm.c                                |   47 +-
 sound/soc/soc-topology.c                           | 1826 ++++++++++++++++=
++++
 sound/soc/ux500/mop500_ab8500.c                    |    4 +
 sound/soc/ux500/ux500_pcm.c                        |    1 -
 sound/soc/zte/Kconfig                              |   17 +
 sound/soc/zte/Makefile                             |    2 +
 sound/soc/zte/zx296702-i2s.c                       |  436 +++++
 sound/soc/zte/zx296702-spdif.c                     |  365 ++++
 225 files changed, 9460 insertions(+), 2305 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/bt-sco.txt
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
 create mode 100644 include/dt-bindings/sound/apq8016-lpass.h
 create mode 100644 include/dt-bindings/sound/audio-jack-events.h
 create mode 100644 include/dt-bindings/sound/tas2552.h
 create mode 100644 include/sound/soc-topology.h
 create mode 100644 include/uapi/sound/asoc.h
 create mode 100644 include/uapi/sound/tlv.h
 create mode 100644 sound/soc/codecs/tas571x.c
 create mode 100644 sound/soc/codecs/tas571x.h
 create mode 100644 sound/soc/intel/boards/cht_bsw_max98090_ti.c
 create mode 100644 sound/soc/qcom/lpass-apq8016.c
 create mode 100644 sound/soc/qcom/lpass-ipq806x.c
 rename sound/soc/qcom/{lpass-lpaif-ipq806x.h =3D> lpass-lpaif-reg.h} (64%)
 create mode 100644 sound/soc/soc-topology.c
 create mode 100644 sound/soc/zte/Kconfig
 create mode 100644 sound/soc/zte/Makefile
 create mode 100644 sound/soc/zte/zx296702-i2s.c
 create mode 100644 sound/soc/zte/zx296702-spdif.c

--fEHFiqIAmqToArad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddYMAAoJECTWi3JdVIfQfZsH/1nk1zXPi3SKw8WdTnLU+zEF
dMAbRdlX1R5hi1BVYLwKR28moC0qZqAlEOQbZQL3SJleJYkXecs2RaVxrUk40P6e
9kcWZjafxb1Jv7Bh7YrTDIVjuMrolNYSN90Dm6eSqgMKjUAHd/irOW62NYBrIPRo
OMfpq+xZxAFPrAFge5WRJzmiCkMvN9BTU/CiPb0FdRDGQP6ty238o6dCU+1l/uyG
EgI2r5qpHUAkFDdOV7S/RDk3v5x7fJT0HMPV6aBH9qaUp0SOIlLowyn0irOC+jt/
DKdXayiGA+kw8Kh5+slLU1ivwfgBhbHsI3o6B0Duh9JvETDIOK/CSf2wgrECoxw=
=eJRv
-----END PGP SIGNATURE-----

--fEHFiqIAmqToArad--

--===============2340619488863538002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2340619488863538002==--
