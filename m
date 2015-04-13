From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.1
Date: Mon, 13 Apr 2015 13:10:16 +0100
Message-ID: <20150413121016.GI6023@sirena.org.uk>
References: <20150413120953.GH6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8994469187538063237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7FCF261B36
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:10:23 +0200 (CEST)
In-Reply-To: <20150413120953.GH6023@sirena.org.uk>
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


--===============8994469187538063237==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CkCASB6hdLELimsC"
Content-Disposition: inline


--CkCASB6hdLELimsC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 01:09:53PM +0100, Mark Brown wrote:
> The following changes since commit f22e6e847115abc3a0e2ad7bb18d243d42275a=
f1:
>=20
>   Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.1-2
>=20
> for you to fetch changes up to 7667428f80526d908124e0647ac5dbe3dad88900:
>=20
>   Merge remote-tracking branches 'asoc/topic/wm2200', 'asoc/topic/wm5100'=
, 'asoc/topic/wm8731', 'asoc/topic/wm8804' and 'asoc/topic/wm8996' into aso=
c-next (2015-04-12 19:49:22 +0100)
>=20
> ----------------------------------------------------------------
> ASoC: Updates for v4.1
>=20
> More updates for v4.1, pretty much all drivers:
>=20
>  - Lots of cleanups from Lars, mainly moving things from the CODEC level
>    to the card level.
>  - Continuing improvements to rcar from Morimoto-san, pcm512x from
>    Howard and Peter, the Intel platforms from Vinod, Jie, Jin and Han,
>    and to rt5670 from Bard.
>  - Support for some non-DSP Qualcomm platforms, Google's Storm
>    platform, Maxmim MAX98925 CODECs and the Ingenic JZ4780 SoC.
>=20
> ----------------------------------------------------------------
> Alexandre Belloni (2):
>       ASoC: atmel-pcm-pdc: merge atmel-pcm back in
>       ASoC: atmel-pcm-dma: increase buffer_bytes_max
>=20
> Anish Kumar (2):
>       ASoC: Add max98925 codec driver
>       ASoC: max98925: trivial duplicate typo fix in set_fmt
>=20
> Arnd Bergmann (2):
>       ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency
>       ASoC: rnsd: fix build regression without CONFIG_OF
>=20
> Axel Lin (1):
>       ASoC: max98925: Fix bit-width 24 settings in max98925_dai_hw_params
>=20
> Bard Liao (18):
>       ASoC: rt5670: Add disabled item in dmic pin enum
>       ASoC: rt5670: set platform data by dmi
>       ASoC: rt5670: Add runtime PM support
>       ASoC: rt5670: Keep sysclk on if JD func is used
>       ASoC: rt5670: redefine ASRC control registers 0x84 and 0x85
>       ASoC: rt5670: Fix the speaker mono output issue
>       ASoC: rt5670: Revert Keep sysclk on patch
>       ASoC: rt5670: Check sysclk source by private data
>       ASoC: rt5670: Add IRQ function
>       ASoC: rt5670: export jack suspend/resume APIs
>       ASoC: rt5645: Add TDM support for rt5650
>       ASoC: rt5645: Remove adc stereo2 filter
>       ASoC: rt286: check regmap_read result for ID check
>       ASoC: rt5645: Redefine format config for rt5650
>       ASoC: rt5645: Set use_single_rw flag for regmap
>       ASoC: rt5645: Use update_bits for bit control
>       ASoC: rt5645: Restore HP depop setting in HP off
>       ASoC: rt286: Restore default in probe
>=20
> Caesar Wang (1):
>       ASoC: max98090: add shutdown callback for max98090
>=20
> Charles Keepax (12):
>       ASoC: wm_adsp: Improve round to next 4-byte boundary
>       ASoC: wm8804: Split out bus drivers
>       ASoC: wm8804: Merge CODEC probe and bus probe
>       regulator: core: Add devres versions of notifier registration
>       ASoC: wm8804: Use new devres regulator_register_notifier
>       ASoC: wm8804: Fix small issues in probe error paths
>       ASoC: wm8804: Update DT binding document to cover regulator supplies
>       ASoC: dapm: Fix build warning
>       ASoC: wm5102: Remove set of volume update bits for output 3R
>       ASoC: wm8804: Add support for hardware reset line
>       ASoC: wm8804: Update binding documentation to include reset GPIO
>       ASoC: wm8804: Enable runtime PM
>=20
> Dan Carpenter (1):
>       ASoC: Intel: do cast earlier in sst_cdev_tstamp()
>=20
> Dmitry Torokhov (2):
>       ASoC: cx20442: remove incorerct __exit markups
>       ASoC: tlv320aic23: remove incorrect __exit markups
>=20
> Fabian Frederick (6):
>       ASoC: fsl: constify of_device_id array
>       ASoC: kirkwood: constify of_device_id array
>       ASoC: rt5631: constify of_device_id array
>       ASoC: ak4554: constify of_device_id array
>       ASoC: fsi: constify of_device_id array
>       ASoC: rsnd: constify of_device_id array
>=20
> Fabio Estevam (3):
>       ASoC: fsl_ssi: Use devm_snd_soc_register_component()
>       ASoC: fsl_ssi: Use devm_ioremap_resource()
>       ASoC: fsl: Add the audio interface acronyms in Kconfig text
>=20
> Fang, Yang A (2):
>       ALSA: Add params_set_format helper
>       ASoC: Intel: fix machine driver warnings
>=20
> Geert Uytterhoeven (1):
>       ASoC: rsnd: Use %pad to print dma_addr_t in rsnd_dmapp_init()
>=20
> Howard Mitchell (5):
>       ALSA: ControlName.txt: Add 'Analogue' as a prefix for volume contro=
ls
>       ASoC: pcm512x: Add 'Analogue' prefix to analogue volume controls
>       ASoC: pcm512x: Fix divide by zero issue
>       ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4
>       ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4
>=20
> Jarkko Nikula (2):
>       ASoC: Intel: Remove support for Intel MID DMA from firmware loader
>       ASoC: Intel: Remove vague commit about slave DMA config from firmwa=
re loader
>=20
> Jie Yang (9):
>       ASoC: rt286: add jack detection disable with NULL jack passed
>       ASoC: rt286: correct the OR to AND
>       ASoC: Intel: Add suspend_pre and resume_post for Broadwell snd_soc_=
card
>       ASoC: Intel: create common folder and move common files in
>       ASoC: Intel: create haswell folder and move haswell platform files =
in
>       ASoC: Intel: create boards folder and move sst boards files in
>       ASoC: Intel: create baytrail folder and move baytrail platform file=
s in
>       ASoC: Intel: create atom folder and move atom platform files in
>       ASoC: Intel: Fix a buffer overflow issue
>=20
> Jin Yao (6):
>       ASoC: Intel: move sysclk source setting to platform_clock_control f=
or balance.
>       ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_c=
ard
>       ASoC: Intel: move the jack creation to Braswell machine driver
>       ASoC: Intel: Refactor common IPC/mailbox code into generic APIs
>       ASoC: Intel: Use the generic IPC/mailbox APIs in Baytrail
>       ASoC: Intel: Use the generic IPC/mailbox APIs in Broadwell
>=20
> Julia Lawall (1):
>       ASoC: ab8500-codec: don't export static symbol
>=20
> Jyri Sarha (4):
>       ASoC: omap-pcm: Allow only formats with 1, 2, and 4 byte physical s=
ize
>       ASoC: davinci-mcasp: Set rule constraints if implicit BCLK divider =
is used
>       ASoC: omap-hdmi-audio: No not use IEC958_AES1_PRO_MODE_NOTID
>       ASoC: davinci-mcasp: Index ruledata in drvdata with substream->stre=
am
>=20
> Kenneth Westfield (13):
>       ASoC: max98357a: Remove use of DRV_NAME
>       ASoC: max98357a: Use standard DAI names
>       ASoC: qcom: add LPASS header files
>       ASoC: qcom: Add LPASS CPU DAI driver
>       ASoC: qcom: Add LPASS platform driver
>       ASoC: qcom: Document LPASS CPU bindings
>       MAINTAINERS: Add QCOM audio ASoC maintainer
>       ASoC: qcom: Change qcom,adsp in LPASS CPU bindings
>       ASoC: qcom: Modify test for DSP in LPASS driver
>       ASoC: qcom: Document Storm bindings
>       ASoC: qcom: Add Storm machine driver
>       ASoC: qcom: Add ability to build QCOM drivers
>       ASoC: Allow for building QCOM drivers
>=20
> Krzysztof Kozlowski (2):
>       ASoC: max98925: Constify regmap config and other codec data
>       ASoC: rsnd: Fix duplicate const for DVC ramp rates
>=20
> Kuninori Morimoto (41):
>       dmaengine: export symbol of of_dma_request_slave_channel()
>       ASoC: rsnd: remove SH-DMA-BASE specific implementation
>       ASoC: rsnd: remove un-needed parameter from rsnd_dma_init()
>       ASoC: rsnd: remove unused rsnd_dma_available()
>       ASoC: rsnd: remove un-needed parameter from rsnd_dma_quit()
>       ASoC: rsnd: tidyup rsnd_dma_to_mod() macro declaration position
>       ASoC: rsnd: enable to get resource by name
>       ASoC: rsnd: add rsnd_gen_get_phy_addr() to get physical address
>       ASoC: rsnd: add dma.c for Audio DMAC / Audio DMAC peri peri
>       ASoC: rsnd: move rsnd_gen_dma_addr() from gen.c to dma.c
>       ASoC: rsnd: enable to care 1st / 2nd DMAC on rsnd_dma_xxx()
>       ASoC: rsnd: add Audio DMAC peri peri support rework
>       ASoC: rsnd: remove rsnd_dma::addr
>       ASoC: rsnd: remove rsnd_dma::dir
>       ASoC: rsnd: use union with rsnd_dmaen / rsnd_dmapp
>       ASoC: rsnd: enable rsnd_ssi_use_busif() for DMA
>       ASoC: rsnd: ssi: add rsnd_ssi_of_node()
>       ASoC: rsnd: src: add rsnd_src_of_node()
>       ASoC: rsnd: dvc: add rsnd_dvc_of_node()
>       ASoC: rsnd: 1st DMAC dma-names cares subnode
>       ASoC: rsnd: add sample code of rcar_sound,src irq
>       ASoC: rsnd: add sample code of missing clocks
>       ASoC: rsnd: add sample code of dma entry
>       ASoC: rsnd: add sample code of reg-names
>       ASoC: rsnd: recover PIO mode for new dma interface
>       ASoC: rsnd: add regmap_config::name for debugfs
>       ASoC: ak4642: tidyup DAPM route for playback
>       ASoC: rsnd: no more SSI restart when unusual situation
>       ASoC: rsnd: no more SRC restart when unusual situation
>       ASoC: rsnd: tidyup error message format
>       ASoC: rsnd: show debug info for sampling rate convert
>       ASoC: rsnd: add dai_link stream name
>       ASoC: soc-core: initialize debugfs in snd_soc_instantiate_card()
>       ASoC: rsrc-card: add Renesas sampling rate convert sound card suppo=
rt
>       ASoC: rsrc-card: add .be_hw_params_fixup support for convert rate
>       ASoC: rsnd: call clk_prepare/unprepare() in probe/remove
>       ASoC: rsnd: remove useless debug message
>       ASoC: rsnd: add DPCM based sampling rate convert
>       ASoC: rsnd: add Synchronous SRC mode
>       ASoC: ak4642: fixup channels_min
>       ASoC: core: call snd_soc_runtime_set_dai_fmt() before soc_new_pcm()
>=20
> Lars-Peter Clausen (61):
>       ASoC: sn95031: Pass CODEC to sn95031_jack_detection()
>       ASoC: Allow to register jacks at the card level
>       ASoC: simple-card: Register jacks at the card level
>       ASoC: imx-es8328: Register jacks at the card level
>       ASoC: wm1133-ev: Register jacks at the card level
>       ASoC: broadwell: Register jacks at the card level
>       ASoC: byt-max98090: Register jacks at the card level
>       ASoC: cht_bsw_rt5645: Register jacks at the card level
>       ASoC: mfld_machine: Register jacks at the card level
>       ASoC: ams-deltea: Register jacks at the card level
>       ASoC: omap-abe-twl6040: Register jacks at the card level
>       ASoC: omap-twl4030: Register jacks at the card level
>       ASoC: rx51: Register jacks at the card level
>       ASoC: hx4700: Register jacks at the card level
>       ASoC: palm27x: Register jacks at the card level
>       ASoC: ttc-dkb: Register jacks at the card level
>       ASoC: z2: Register jacks at the card level
>       ASoC: h1980_uda1380: Register jacks at the card level
>       ASoC: littlemill: Register jacks at the card level
>       ASoC: lowland: Register jacks at the card level
>       ASoC: rx1950_uda1380: Register jacks at the card level
>       ASoC: smartq: Register jacks at the card level
>       ASoC: speyside: Register jacks at the card level
>       ASoC: tobermory: Register jacks at the card level
>       ASoC: tegra_alc5632: Register jacks at the card level
>       ASoC: tegra_max98090: Register jacks at the card level
>       ASoC: tegra_rt5640: Register jacks at the card level
>       ASoC: tegra_rt5677: Register jacks at the card level
>       ASoC: tegra_wm8903: Register jacks at the card level
>       ASoC: Remove snd_soc_jack_new()
>       ASoC: Remove unnecessary device_remove_file()
>       ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
>       ASoC: Make snd_soc_dapm_kcontrol_codec() inline
>       ASoC: nuc900: No need to track the dma buffer in the driver state s=
truct
>       ASoC: rt286: Drop unnecessary dapm bias_level initialization
>       ASoC: wm2200: Drop unnecessary dapm bias_level initialization
>       ARM: shmobile: armadillo800eva: Properly specify HDMI audio link fo=
rmat
>       ARM: shmobile: armadillo800eva: fix clock inversion
>       ASoC: simple-card: Remove support for setting differing DAI formats
>       ASoC: wm8971: Use system_power_efficient_wq instead of custom workq=
ueue
>       ASoC: wm8971: Integrate capacitor charging into the DAPM sequence
>       ASoC: wm8971: Cleanup manual bias level transitions
>       ASoC: wm8753: Integrate capacitor charging into the DAPM sequence
>       ASoC: wm8753: Cleanup manual bias level transitions
>       ASoC: Remove suspend_bias_level from DAPM context struct
>       ASoC: wm8350: Move delayed work struct from DAPM context to driver =
state
>       ASoC: dapm: Remove delayed_work from dapm context struct
>       ASoC: tegra_alc5632: Use card DAPM context to access widgets
>       ASoC: tegra_rt5677: Use card DAPM context to access widgets
>       ASoC: tegra_wm8903: Use card DAPM context to access widgets
>       ASoC: tegra_wm9712: Use card DAPM context to access widgets
>       ASoC: Create card debugfs directory earlier
>       ASoC: Make soc_dpcm_debugfs_add() non-fatal
>       ASoC: Don't try to register debugfs entries if the parent does not =
exist
>       ASoC: atmel: Add dependency to SND_SOC_I2C_AND_SPI where necessary
>       ASoC: atmel: Improve machine driver compile test coverage
>       ASoC: wm1133-ev1: Use card DAPM context to access widgets
>       ASoC: mop500_ab8500: Use card DAPM context to access widgets
>       ASoC: davinci-evm: Use card DAPM context to access widgets
>       ASoC: n810: Consistently pass the card DAPM context to n810_ext_con=
trol()
>       ASoC: n810: Automatically disconnect non-connected pins
>=20
> Lu, Han (8):
>       ASoC: Intel: add function to load firmware image
>       ASoC: Intel: add function to load sound effect module waves
>       ASoC: Intel: add function to enable/disable sound effect module wav=
es
>       ASoC: Intel: add kcontrol to enable/disable sound effect module wav=
es
>       ASoC: Intel: add function to set parameter to sound effect module w=
aves
>       ASoC: Intel: add kcontrol to set parameter to sound effect module w=
aves
>       Intel: ASoC: Add condition check before set param to waves
>       ASoC: Intel: fix warning reported by static check tool smatch
>=20
> Manish Badarkhe (1):
>       ASoC: davinci-evm: drop un-necessary remove function
>=20
> Mark Brown (38):
>       Merge branch 'fix/rt5677' of git://git.kernel.org/.../broonie/sound=
 into asoc-rt5677
>       Merge tag 'asoc-fix-v4.0-rc2' into asoc-linus
>       Merge remote-tracking branch 'asoc/topic/dapm-dt' into asoc-next
>       Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/atmel', 'asoc/topic/davi=
nci', 'asoc/topic/gpiod' and 'asoc/topic/intel' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/jack', 'asoc/topic/max98=
357a', 'asoc/topic/omap' and 'asoc/topic/rt286' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/rt5670', 'asoc/topic/rt5=
677', 'asoc/topic/simple', 'asoc/topic/tegra' and 'asoc/topic/wm-adsp' into=
 asoc-next
>       Merge remote-tracking branch 'asoc/topic/wm8804' into asoc-next
>       Merge branch 'topic/notifier' of git://git.kernel.org/.../broonie/r=
egulator into asoc-wm8804
>       Merge tag 'v4.0-rc3' into asoc-rt5670
>       Merge tag 'v4.0-rc3' into asoc-intel
>       Merge branch 'fix/intel' of git://git.kernel.org/.../broonie/sound =
into asoc-intel
>       Merge branch 'topic/rt5670' of git://git.kernel.org/.../broonie/sou=
nd into asoc-intel
>       Merge branch 'topic/jack' of git://git.kernel.org/.../broonie/sound=
 into asoc-intel
>       Merge branch 'asoc-fix-rcar' into HEAD
>       Merge branch 'topic/jack' of git://git.kernel.org/.../broonie/sound=
 into asoc-tegra
>       Merge tag 'v4.0-rc7' into asoc-core
>       Merge branch 'topic/delay' of git://git.kernel.org/.../broonie/soun=
d into asoc-core
>       Merge branch 'topic/dapm-dt' of git://git.kernel.org/.../broonie/so=
und into asoc-core
>       Merge tag 'asoc-fix-v4.0-rc7' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/pcm512x' into asoc-linus
>       Merge remote-tracking branches 'asoc/fix/ak4642', 'asoc/fix/atmel',=
 'asoc/fix/cs4271', 'asoc/fix/davinci' and 'asoc/fix/rcar' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/wm8741' into asoc-linus
>       Merge tag 'asoc-v4.1' into asoc-next
>       Merge remote-tracking branch 'asoc/topic/core' into asoc-next
>       Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
>       Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
>       Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/4554', 'asoc/topic/ab850=
0', 'asoc/topic/ak4642', 'asoc/topic/arizona' and 'asoc/topic/atmel' into a=
soc-next
>       Merge remote-tracking branches 'asoc/topic/cx20442' and 'asoc/topic=
/davinci' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/dmaengine', 'asoc/topic/=
fsi', 'asoc/topic/fsl' and 'asoc/topic/fsl-ssi' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/jack', 'asoc/topic/jz474=
0' and 'asoc/topic/kirkwood' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/link-param', 'asoc/topic=
/max98090', 'asoc/topic/max98925' and 'asoc/topic/nuc900' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/omap', 'asoc/topic/qcom'=
, 'asoc/topic/rcar' and 'asoc/topic/rt286' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/rt5641', 'asoc/topic/rt5=
677' and 'asoc/topic/sh-cleanup' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/tegra', 'asoc/topic/tlv3=
20aic23' and 'asoc/topic/ux500' into asoc-next
>       Merge remote-tracking branches 'asoc/topic/wm2200', 'asoc/topic/wm5=
100', 'asoc/topic/wm8731', 'asoc/topic/wm8804' and 'asoc/topic/wm8996' into=
 asoc-next
>=20
> Mengdong Lin (1):
>       ASoC: rt5670: add API to select ASRC clock source
>=20
> Nicholas Mc Guire (5):
>       ASoC: wm8996: match wait_for_completion_timeout return type
>       ASoC: wm8996: ensure lower bounds of 1 for timeout
>       ASoC: arizona: match wait_for_completion_timeout return type
>       ASoC: wm5100: match wait_for_completion_timeout return type
>       ASoC: wm2200: match wait_for_completion_timeout return type
>=20
> Nicolas Ferre (1):
>       MAINTAINERS: change the Atmel audio alsa driver entry
>=20
> Nicolin Chen (2):
>       ASoC: core: Add extra dapm properties for Device Tree
>       ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
>=20
> Nikesh Oswal (2):
>       ASoC: wm_adsp: Ensure DSP controls are always persistent
>       ASoC: dapm: add code to configure dai link parameters
>=20
> Oder Chiou (3):
>       ASoC: rt5677: Add the chip type to distinguish the setting of the c=
lock source
>       ASoC: rt5677: Keep the LDO2 powered while used in the suspend mode
>       ASoC: rt5677: add API to select ASRC clock source
>=20
> Pascal Huerst (1):
>       ASoC: cs4271: Increase delay time after reset
>=20
> Peter Rosin (3):
>       ASoC: atmel_ssc_dai: Allow more rates
>       ASoC: pcm512x: Rearrange to not repeat dacsrc_rate / dac_div
>       ASoC: pcm512x: Allow independently overclocking PLL, DAC and DSP
>=20
> Peter Ujfalusi (10):
>       ASoC: omap: Kconfig: Support for omap5-uevm analog audio
>       ASoC: davinci-mcasp: Add support for CBS_CFM mode
>       ASoC: davinci: Select SND_EDMA_SOC when SND_DAVINCI_SOC is enabled
>       ASoC: davinci-i2s: Convert to use edma-pcm
>       ASoC: davinci-vcif: Convert to use edma-pcm
>       ASoC: davinci-mcasp: Deprecate the use of davinci-pcm in favor of e=
dma-pcm
>       ASoC: davinci: Remove unused davinci-pcm platform driver
>       ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in u=
se
>       ASoC: davinci-mcasp: Fix compilation error
>       ASoC: davinci-mcasp: Fix ruledata setup in davinci_mcasp_startup
>=20
> Pierre-Louis Bossart (1):
>       ASoC: Intel: remove misleading DMA error messages on Baytrail platf=
orms
>=20
> Sapthagiri Baratam (1):
>       ASoC: wm8804: Add DAPM widgets for SPDIF/AIF
>=20
> Sergej Sawazki (1):
>       ASoC: wm8741: Fix rates constraints values
>=20
> Songjun Wu (1):
>       ASoC: wm8731: let codec to manage clock by itself
>=20
> Subhransu S. Prusty (3):
>       ASoC: Intel: Add memcpy32_fromio as well
>       ASoC: Intel: Remove ignore suspend support
>       ASoC: Intel: Remove soc pm handling to allow platform driver handle=
 it
>=20
> Sudip Mukherjee (1):
>       ASoC: Intel: remove unused functions
>=20
> Takeshi Kihara (1):
>       ASoC: ak4642: enable stereo line output power-save mode
>=20
> Tomeu Vizoso (3):
>       ASoC: tegra: Expose Headphones pin to userspace
>       ASoC: tegra: Add sink for the internal mic to tegra_max98090
>       ASoC: tegra: Add control for the Mic Jack pin
>=20
> Uwe Kleine-K=F6nig (5):
>       ASoC: improve usage of gpiod API
>       ASoC: fsi: fix license specification
>       ASoC: fsi: reorder code to make a forward declaration superfluous
>       ASoC: fsi: mark several data structures as const
>       ASoC: rcar: mark device data as constant
>=20
> Vinod Koul (10):
>       ASoC: core: allow pcms to be registered as nonatomic
>       ASoC: Intel: mark cht machine driver with nonatomic trigger
>       ASoC: Intel: update MMX ID to 3
>       ASoC: Intel: add support for pause and resume in sst
>       ASoC: Intel: add support for pcm stream suspend/resume
>       ASoC: Intel: add support for platform suspend
>       ASoC: Intel: add pm support in sst ipc driver
>       ASoC: Intel: Move the fw download to power_control
>       ASoC: Intel: wrap runtime_pm usage count under CONFIG_PM
>       ASoC: Intel: acpi_probe: fix error return path
>=20
> Vishal Thanki (1):
>       ASoC: simple-card: Add a NULL pointer check in asoc_simple_card_dai=
_link_of
>=20
> Zubair Lutfullah Kakakhel (1):
>       ASoC: jz4740: Add jz4780 support
>=20
> kbuild test robot (4):
>       ASoC: tegra: fix platform_no_drv_owner.cocci warnings
>       ASoC: max98925_spk_tlv can be static
>       ASoC: Intel: read_shim_data() can be static
>       ASoC: Intel: fix array_size.cocci warnings
>=20
>  .../bindings/sound/ingenic,jz4740-i2s.txt          |   2 +-
>  .../devicetree/bindings/sound/max98925.txt         |  22 +
>  .../bindings/sound/nvidia,tegra-audio-max98090.txt |   1 +
>  .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  43 +
>  .../devicetree/bindings/sound/renesas,rsnd.txt     | 125 ++-
>  .../bindings/sound/renesas,rsrc-card.txt           |  67 ++
>  Documentation/devicetree/bindings/sound/storm.txt  |  23 +
>  Documentation/devicetree/bindings/sound/wm8804.txt |   7 +
>  Documentation/sound/alsa/ControlNames.txt          |  10 +-
>  MAINTAINERS                                        |   9 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c     |   3 +-
>  drivers/dma/of-dma.c                               |   1 +
>  drivers/regulator/devres.c                         |  85 ++
>  include/linux/regulator/consumer.h                 |  16 +
>  include/sound/pcm_params.h                         |   7 +
>  include/sound/rt5670.h                             |   1 +
>  include/sound/simple_card.h                        |   1 -
>  include/sound/soc-dapm.h                           |   6 +-
>  include/sound/soc-dpcm.h                           |   2 +-
>  include/sound/soc.h                                |  30 +-
>  sound/soc/Kconfig                                  |   1 +
>  sound/soc/Makefile                                 |   1 +
>  sound/soc/atmel/Kconfig                            |   9 +-
>  sound/soc/atmel/Makefile                           |   2 -
>  sound/soc/atmel/atmel-pcm-dma.c                    |   4 +-
>  sound/soc/atmel/atmel-pcm-pdc.c                    |  79 ++
>  sound/soc/atmel/atmel-pcm.c                        | 121 ---
>  sound/soc/atmel/atmel-pcm.h                        |   5 -
>  sound/soc/atmel/atmel_ssc_dai.c                    | 111 ++-
>  sound/soc/atmel/atmel_ssc_dai.h                    |   1 +
>  sound/soc/codecs/Kconfig                           |  22 +-
>  sound/soc/codecs/Makefile                          |   6 +
>  sound/soc/codecs/ab8500-codec.c                    |   2 -
>  sound/soc/codecs/adau1977.c                        |  17 +-
>  sound/soc/codecs/ak4554.c                          |   2 +-
>  sound/soc/codecs/ak4642.c                          |  41 +-
>  sound/soc/codecs/arizona.c                         |   6 +-
>  sound/soc/codecs/cs35l32.c                         |  19 +-
>  sound/soc/codecs/cs4265.c                          |  19 +-
>  sound/soc/codecs/cs4271.c                          |   4 +-
>  sound/soc/codecs/cx20442.c                         |   4 +-
>  sound/soc/codecs/max98090.c                        |  17 +
>  sound/soc/codecs/max98357a.c                       |  11 +-
>  sound/soc/codecs/max98925.c                        | 655 ++++++++++++++++
>  sound/soc/codecs/max98925.h                        | 832 +++++++++++++++=
+++++
>  sound/soc/codecs/pcm512x.c                         | 205 ++++-
>  sound/soc/codecs/rt286.c                           |  40 +-
>  sound/soc/codecs/rt5631.c                          |   2 +-
>  sound/soc/codecs/rt5645.c                          |  90 ++-
>  sound/soc/codecs/rt5645.h                          |   2 -
>  sound/soc/codecs/rt5670.c                          | 213 ++++-
>  sound/soc/codecs/rt5670.h                          |  10 +
>  sound/soc/codecs/rt5677.c                          | 207 ++++-
>  sound/soc/codecs/rt5677.h                          |  85 ++
>  sound/soc/codecs/sn95031.c                         |  14 +-
>  sound/soc/codecs/sn95031.h                         |   3 +-
>  sound/soc/codecs/sta350.c                          |  30 +-
>  sound/soc/codecs/tas2552.c                         |  13 +-
>  sound/soc/codecs/tlv320aic23-i2c.c                 |   4 +-
>  sound/soc/codecs/wm2200.c                          |   9 +-
>  sound/soc/codecs/wm5100.c                          |   7 +-
>  sound/soc/codecs/wm5102.c                          |   1 -
>  sound/soc/codecs/wm8350.c                          |  25 +-
>  sound/soc/codecs/wm8731.c                          |  34 +
>  sound/soc/codecs/wm8741.c                          |   8 +-
>  sound/soc/codecs/wm8753.c                          |  73 +-
>  sound/soc/codecs/wm8804-i2c.c                      |  65 ++
>  sound/soc/codecs/wm8804-spi.c                      |  57 ++
>  sound/soc/codecs/wm8804.c                          | 534 ++++++-------
>  sound/soc/codecs/wm8804.h                          |   8 +
>  sound/soc/codecs/wm8971.c                          |  99 +--
>  sound/soc/codecs/wm8996.c                          |  12 +-
>  sound/soc/codecs/wm_adsp.c                         |  13 +-
>  sound/soc/davinci/Kconfig                          |  18 +-
>  sound/soc/davinci/Makefile                         |   2 -
>  sound/soc/davinci/davinci-evm.c                    |  17 +-
>  sound/soc/davinci/davinci-i2s.c                    |  67 +-
>  sound/soc/davinci/davinci-mcasp.c                  | 335 +++++---
>  sound/soc/davinci/davinci-pcm.c                    | 861 ---------------=
------
>  sound/soc/davinci/davinci-pcm.h                    |  41 -
>  sound/soc/davinci/davinci-vcif.c                   |  55 +-
>  sound/soc/fsl/Kconfig                              |   4 +-
>  sound/soc/fsl/fsl-asoc-card.c                      |   6 +
>  sound/soc/fsl/fsl_ssi.c                            |  32 +-
>  sound/soc/fsl/imx-es8328.c                         |   6 +-
>  sound/soc/fsl/mpc5200_psc_ac97.c                   |   2 +-
>  sound/soc/fsl/mpc5200_psc_i2s.c                    |   2 +-
>  sound/soc/fsl/pcm030-audio-fabric.c                |   2 +-
>  sound/soc/fsl/wm1133-ev1.c                         |  15 +-
>  sound/soc/generic/simple-card.c                    |  50 +-
>  sound/soc/intel/Makefile                           |  42 +-
>  sound/soc/intel/atom/Makefile                      |   7 +
>  sound/soc/intel/{ =3D> atom}/sst-atom-controls.c     |   0
>  sound/soc/intel/{ =3D> atom}/sst-atom-controls.h     |   0
>  sound/soc/intel/{ =3D> atom}/sst-mfld-dsp.h          |   0
>  .../intel/{ =3D> atom}/sst-mfld-platform-compress.c  |   0
>  sound/soc/intel/{ =3D> atom}/sst-mfld-platform-pcm.c |  60 ++
>  sound/soc/intel/{ =3D> atom}/sst-mfld-platform.h     |   1 +
>  sound/soc/intel/{ =3D> atom}/sst/Makefile            |   0
>  sound/soc/intel/{ =3D> atom}/sst/sst.c               | 130 +++-
>  sound/soc/intel/{ =3D> atom}/sst/sst.h               |  12 +
>  sound/soc/intel/{ =3D> atom}/sst/sst_acpi.c          |   4 +-
>  sound/soc/intel/{ =3D> atom}/sst/sst_drv_interface.c |  69 +-
>  sound/soc/intel/{ =3D> atom}/sst/sst_ipc.c           |   2 +-
>  sound/soc/intel/{ =3D> atom}/sst/sst_loader.c        |  12 +-
>  sound/soc/intel/{ =3D> atom}/sst/sst_pci.c           |   0
>  sound/soc/intel/{ =3D> atom}/sst/sst_pvt.c           |  26 +-
>  sound/soc/intel/{ =3D> atom}/sst/sst_stream.c        |   2 +-
>  sound/soc/intel/baytrail/Makefile                  |   4 +
>  sound/soc/intel/{ =3D> baytrail}/sst-baytrail-dsp.c  |   4 +-
>  sound/soc/intel/{ =3D> baytrail}/sst-baytrail-ipc.c  | 364 ++-------
>  sound/soc/intel/{ =3D> baytrail}/sst-baytrail-ipc.h  |   0
>  sound/soc/intel/{ =3D> baytrail}/sst-baytrail-pcm.c  |   4 +-
>  sound/soc/intel/boards/Makefile                    |  15 +
>  sound/soc/intel/{ =3D> boards}/broadwell.c           |  50 +-
>  sound/soc/intel/{ =3D> boards}/byt-max98090.c        |  13 +-
>  sound/soc/intel/{ =3D> boards}/byt-rt5640.c          |   4 +-
>  .../{bytcr_dpcm_rt5640.c =3D> boards/bytcr_rt5640.c} |   8 +-
>  sound/soc/intel/{ =3D> boards}/cht_bsw_rt5645.c      |  20 +-
>  sound/soc/intel/{ =3D> boards}/cht_bsw_rt5672.c      | 108 ++-
>  sound/soc/intel/{ =3D> boards}/haswell.c             |  10 +-
>  sound/soc/intel/{ =3D> boards}/mfld_machine.c        |  24 +-
>  sound/soc/intel/common/Makefile                    |   7 +
>  sound/soc/intel/{ =3D> common}/sst-acpi.c            |   1 +
>  sound/soc/intel/{ =3D> common}/sst-dsp-priv.h        |  13 +
>  sound/soc/intel/{ =3D> common}/sst-dsp.c             |   0
>  sound/soc/intel/{ =3D> common}/sst-dsp.h             |   2 +-
>  sound/soc/intel/{ =3D> common}/sst-firmware.c        |  10 +-
>  sound/soc/intel/common/sst-ipc.c                   | 294 +++++++
>  sound/soc/intel/common/sst-ipc.h                   |  91 +++
>  sound/soc/intel/haswell/Makefile                   |   4 +
>  sound/soc/intel/{ =3D> haswell}/sst-haswell-dsp.c    |   9 +-
>  sound/soc/intel/{ =3D> haswell}/sst-haswell-ipc.c    | 794 ++++++++++++-=
------
>  sound/soc/intel/{ =3D> haswell}/sst-haswell-ipc.h    |  53 ++
>  sound/soc/intel/{ =3D> haswell}/sst-haswell-pcm.c    | 140 +++-
>  sound/soc/jz4740/jz4740-i2s.c                      |  84 +-
>  sound/soc/kirkwood/kirkwood-i2s.c                  |   2 +-
>  sound/soc/nuc900/nuc900-audio.h                    |   3 -
>  sound/soc/nuc900/nuc900-pcm.c                      |  31 +-
>  sound/soc/omap/Kconfig                             |   4 +-
>  sound/soc/omap/ams-delta.c                         |   4 +-
>  sound/soc/omap/n810.c                              |  23 +-
>  sound/soc/omap/omap-abe-twl6040.c                  |  10 +-
>  sound/soc/omap/omap-hdmi-audio.c                   |   2 -
>  sound/soc/omap/omap-pcm.c                          |  21 +-
>  sound/soc/omap/omap-twl4030.c                      |  12 +-
>  sound/soc/omap/rx51.c                              |   6 +-
>  sound/soc/pxa/hx4700.c                             |  11 +-
>  sound/soc/pxa/palm27x.c                            |  11 +-
>  sound/soc/pxa/ttc-dkb.c                            |  15 +-
>  sound/soc/pxa/z2.c                                 |  10 +-
>  sound/soc/qcom/Kconfig                             |  25 +
>  sound/soc/qcom/Makefile                            |  11 +
>  sound/soc/qcom/lpass-cpu.c                         | 491 ++++++++++++
>  sound/soc/qcom/lpass-lpaif-ipq806x.h               | 172 ++++
>  sound/soc/qcom/lpass-platform.c                    | 526 +++++++++++++
>  sound/soc/qcom/lpass.h                             |  51 ++
>  sound/soc/qcom/storm.c                             | 162 ++++
>  sound/soc/samsung/h1940_uda1380.c                  |   9 +-
>  sound/soc/samsung/littlemill.c                     |  12 +-
>  sound/soc/samsung/lowland.c                        |  14 +-
>  sound/soc/samsung/rx1950_uda1380.c                 |   9 +-
>  sound/soc/samsung/smartq_wm8987.c                  |  11 +-
>  sound/soc/samsung/speyside.c                       |  14 +-
>  sound/soc/samsung/tobermory.c                      |  13 +-
>  sound/soc/sh/Kconfig                               |   6 +
>  sound/soc/sh/fsi.c                                 |  71 +-
>  sound/soc/sh/rcar/Makefile                         |   7 +-
>  sound/soc/sh/rcar/adg.c                            |   4 +-
>  sound/soc/sh/rcar/core.c                           | 278 ++-----
>  sound/soc/sh/rcar/dma.c                            | 616 +++++++++++++++
>  sound/soc/sh/rcar/dvc.c                            |  45 +-
>  sound/soc/sh/rcar/gen.c                            | 152 +---
>  sound/soc/sh/rcar/rsnd.h                           |  92 ++-
>  sound/soc/sh/rcar/rsrc-card.c                      | 512 ++++++++++++
>  sound/soc/sh/rcar/src.c                            | 250 ++++--
>  sound/soc/sh/rcar/ssi.c                            |  73 +-
>  sound/soc/soc-core.c                               | 124 +--
>  sound/soc/soc-dapm.c                               | 182 ++++-
>  sound/soc/soc-jack.c                               |  42 +-
>  sound/soc/soc-pcm.c                                |  17 +-
>  sound/soc/tegra/tegra_alc5632.c                    |  14 +-
>  sound/soc/tegra/tegra_max98090.c                   |  26 +-
>  sound/soc/tegra/tegra_rt5640.c                     |  10 +-
>  sound/soc/tegra/tegra_rt5677.c                     |  20 +-
>  sound/soc/tegra/tegra_wm8903.c                     |  21 +-
>  sound/soc/tegra/tegra_wm9712.c                     |   6 +-
>  sound/soc/ux500/mop500_ab8500.c                    |  36 +-
>  188 files changed, 8983 insertions(+), 3633 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cp=
u.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsrc-=
card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/storm.txt
>  delete mode 100644 sound/soc/atmel/atmel-pcm.c
>  create mode 100644 sound/soc/codecs/max98925.c
>  create mode 100644 sound/soc/codecs/max98925.h
>  create mode 100644 sound/soc/codecs/wm8804-i2c.c
>  create mode 100644 sound/soc/codecs/wm8804-spi.c
>  delete mode 100644 sound/soc/davinci/davinci-pcm.c
>  delete mode 100644 sound/soc/davinci/davinci-pcm.h
>  create mode 100644 sound/soc/intel/atom/Makefile
>  rename sound/soc/intel/{ =3D> atom}/sst-atom-controls.c (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst-atom-controls.h (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst-mfld-dsp.h (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst-mfld-platform-compress.c (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst-mfld-platform-pcm.c (94%)
>  rename sound/soc/intel/{ =3D> atom}/sst-mfld-platform.h (99%)
>  rename sound/soc/intel/{ =3D> atom}/sst/Makefile (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst.c (79%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst.h (98%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_acpi.c (99%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_drv_interface.c (92%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_ipc.c (99%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_loader.c (97%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_pci.c (100%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_pvt.c (95%)
>  rename sound/soc/intel/{ =3D> atom}/sst/sst_stream.c (99%)
>  create mode 100644 sound/soc/intel/baytrail/Makefile
>  rename sound/soc/intel/{ =3D> baytrail}/sst-baytrail-dsp.c (99%)
>  rename sound/soc/intel/{ =3D> baytrail}/sst-baytrail-ipc.c (71%)
>  rename sound/soc/intel/{ =3D> baytrail}/sst-baytrail-ipc.h (100%)
>  rename sound/soc/intel/{ =3D> baytrail}/sst-baytrail-pcm.c (99%)
>  create mode 100644 sound/soc/intel/boards/Makefile
>  rename sound/soc/intel/{ =3D> boards}/broadwell.c (86%)
>  rename sound/soc/intel/{ =3D> boards}/byt-max98090.c (94%)
>  rename sound/soc/intel/{ =3D> boards}/byt-rt5640.c (98%)
>  rename sound/soc/intel/{bytcr_dpcm_rt5640.c =3D> boards/bytcr_rt5640.c} =
(97%)
>  rename sound/soc/intel/{ =3D> boards}/cht_bsw_rt5645.c (95%)
>  rename sound/soc/intel/{ =3D> boards}/cht_bsw_rt5672.c (75%)
>  rename sound/soc/intel/{ =3D> boards}/haswell.c (96%)
>  rename sound/soc/intel/{ =3D> boards}/mfld_machine.c (96%)
>  create mode 100644 sound/soc/intel/common/Makefile
>  rename sound/soc/intel/{ =3D> common}/sst-acpi.c (99%)
>  rename sound/soc/intel/{ =3D> common}/sst-dsp-priv.h (97%)
>  rename sound/soc/intel/{ =3D> common}/sst-dsp.c (100%)
>  rename sound/soc/intel/{ =3D> common}/sst-dsp.h (99%)
>  rename sound/soc/intel/{ =3D> common}/sst-firmware.c (99%)
>  create mode 100644 sound/soc/intel/common/sst-ipc.c
>  create mode 100644 sound/soc/intel/common/sst-ipc.h
>  create mode 100644 sound/soc/intel/haswell/Makefile
>  rename sound/soc/intel/{ =3D> haswell}/sst-haswell-dsp.c (98%)
>  rename sound/soc/intel/{ =3D> haswell}/sst-haswell-ipc.c (77%)
>  rename sound/soc/intel/{ =3D> haswell}/sst-haswell-ipc.h (87%)
>  rename sound/soc/intel/{ =3D> haswell}/sst-haswell-pcm.c (88%)
>  create mode 100644 sound/soc/qcom/Kconfig
>  create mode 100644 sound/soc/qcom/Makefile
>  create mode 100644 sound/soc/qcom/lpass-cpu.c
>  create mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
>  create mode 100644 sound/soc/qcom/lpass-platform.c
>  create mode 100644 sound/soc/qcom/lpass.h
>  create mode 100644 sound/soc/qcom/storm.c
>  create mode 100644 sound/soc/sh/rcar/dma.c
>  create mode 100644 sound/soc/sh/rcar/rsrc-card.c



--CkCASB6hdLELimsC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVK7InAAoJECTWi3JdVIfQGogH/RDCovOAvjapXxc3/BtOGH2B
22Ozu7HieAuX16lHVFO7bXCD3re4eb10s+KoEae+vK1FJmzkQMNROg325qWGw7Ds
oIeDydkTVPj8T/dQlO2NJWA037LUybnCUj7/aAAGN/3/BoD7uAAcPQu4RFG8OB2E
PkeLx1pUtIngpLwTLjEKneC6kD9IFe7qKWf4R+oFcSPUcNh3txOJEXniN6GI9VvY
iKvKlwsgErISbnxRyd1a5Jzqx8v+r89fwaeUon7UJ/uOMHhX/pSLvpgMtP5e/h8M
IqFmB3T6jCzmvqrNTNYndIJOtHwwh1sqGXI+v80YNp+RMrPUEUKT2FDJfPPiebA=
=1Gkd
-----END PGP SIGNATURE-----

--CkCASB6hdLELimsC--

--===============8994469187538063237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8994469187538063237==--
