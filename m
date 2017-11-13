From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.15
Date: Mon, 13 Nov 2017 11:52:42 +0000
Message-ID: <20171113115242.pmc7asf4yumj5ubk@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7471766321822726942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E7FD0267326
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 12:52:44 +0100 (CET)
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


--===============7471766321822726942==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgvi6ahtbxjvyg6y"
Content-Disposition: inline


--wgvi6ahtbxjvyg6y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 39dae59d66acd86d1de24294bd2f343fd5e7a625:

  Linux 4.14-rc8 (2017-11-05 13:05:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.15

for you to fetch changes up to df6a3e245541ac61cc99f2887437e0a43dd08f2e:

  Merge remote-tracking branches 'asoc/topic/tfa9879', 'asoc/topic/ts3a277e=
', 'asoc/topic/wm8741', 'asoc/topic/wm97xx' and 'asoc/topic/zte' into asoc-=
next (2017-11-10 21:31:33 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.15

The biggest thing this release has been the conversion of the AC98 bus
to the driver model, that's been a long time coming so thanks to Robert
Jarzmik for his dedication there.  Due to there being some AC97 MFD
there's a few fairly large changes in input and the MFD layer, mainly to
the wm97xx driver.

There's also some drivers/drm changes to support the new AMD Stoney
platform, these are shared with the DRM subsystem and should be being
merged via both.

Within the subsystem the overwhelming bulk of the changes is in the
Intel drivers which continue to need lots of cleanups and fixes, this
release they've also gained support for their open source firmware.
There's also some large changs in the core as Morimoto-san continues to
mirror operations into the component level in preparation for conversion
of drivers to that.

 - The AC97 bus has finally caught up with the driver model thanks to
   some dedicated and persistent work from Robert Jarzmik.
 - Continued work from Morimoto-san on moving us towards being able to
   use components for everything.
 - Lots of cleanups for the Intel platform code, including support for
   their open source audio firmware.
 - Support for scaling MCLK with sample rate in simple-card.
 - Support for AMD Stoney platform.

----------------------------------------------------------------
Akshu Agrawal (4):
      drm/amdgpu Moving amdgpu asic types to a separate file
      ASoC: AMD: Add machine driver for cz rt5650
      ASoC: amd: Make the driver name consistent across files
      ASoC: rt5645: Wait for 400msec before concluding on value of RT5645_V=
ENDOR_ID2

Andrea Bondavalli (1):
      ASoC: sun4i-codec: fixed 32bit audio capture support for H3/H2+

Andrew F. Davis (1):
      ASoC: cs42l56: Fix reset GPIO name in example DT binding

Arnd Bergmann (8):
      ASoC: dapm: add initialization for w_param_text pointer
      ASoC: dapm: mark 'snd_soc_dapm_free_kcontrol' as static
      ASoC: Intel: fix Kconfig dependencies
      ASoC: intel: include linux/module.h as needed
      ASoC: Intel: improve DMADEVICES dependency
      ASoC: Intel: improve SND_SOC_INTEL_MACH dependencies
      ASoC: rt5514: mark PM functions as __maybe_unused
      ASoC: rt5514: work around link error

Arvind Yadav (3):
      ASoC: davinci-mcasp: Handle return value of devm_kasprintf
      ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf
      ASoC: fsl-asoc-card: Handle return value of devm_kasprintf

Axel Lin (1):
      ASoC: max98925: Return proper error if revision mismatch

Bard Liao (4):
      ASoC: rt5670: add set_bclk_ratio in dai ops
      ASoC: rt5659: move set_sysclk to codec level
      ASoC: rt5659: move set_pll to codec level
      ASoC: rt5645: remove unexisting route on new rt5645

Bhumika Goyal (2):
      ASoC: Intel: atom: make sst_platform_compr_ops const
      ASoC: kirkwood: make kirkwood_soc_platform const

Carlo Caione (8):
      SoC: intel: byt: Introduce new custom IN2 map
      ASoC: rt5651: Convert rt5651 micbias1 to a supply widget
      ASoC: rt5651: Enable jack detection on JD* pins
      ASoC: rt5651: Enable jack detection on JD* pins
      ASoC: rt5651: Rework quirk logic
      ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt
      ASoC: intel: byt: Add headset jack
      ASoC: intel: byt: Enable IN2 map quirk for a KIANO laptop

Charles Keepax (9):
      ASoC: arizona: Add new common Arizona init function
      ASoC: arizona: Add handling for audio related device tree entries
      ASoC: arizona: Add audio device tree bindings
      mfd: arizona: Remove audio related device tree code
      mfd: arizona: Remove audio bindings from MFD binding document
      ASoC: arizona: Add support for setting the output volume limits
      ASoC: arizona: Add device tree binding doc for volume limits
      ASoC: wm8998: Correct handling of input muxes
      ASoC: wm8741: Use snd_soc_update_bits rather than hard coding

Chintan Patel (2):
      ASoC: Intel: Skylake: Fix jack name format substitution
      ASoC: Intel: Skylake: Decrease loglevel for topology loading

Christophe Jaillet (2):
      ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()
      ASoC: davinci-mcasp: Fix an error handling path in 'davinci_mcasp_pro=
be()'

Christos Gkekas (1):
      ASoC: cygnus: Remove unnecessary active_slots check

Colin Ian King (7):
      ASoC: fsl_spdif: make const arrays rate static
      ASoC: zte: spdif: remove duplicate initialization of dma_data
      ASoC: qcom: remove duplicate initializations of dma_ch and v
      ASoC: hdmi-codec: use sizeof_field rather than declaring hcp
      ASoC: rl6231: make arrays div and pd static const, reduces object cod=
e size
      ASoC: Intel: Skylake: fix swapped order of function arguments dir and=
 pin_index
      ASoC: Intel: sst: remove redundant variable dma_dev_name

Corentin LABBE (1):
      ASoC: Intel: Atom: Remove unneeded linux/miscdevice.h include

Damien Riegel (2):
      ASoC: codecs: msm8916-wcd-analog: use btn0 released detection
      ASoC: codecs: msm8916-wcd-analog: configure micbias in mbhc setup

Douglas Anderson (1):
      ASoC: rockchip: Allocate enough memory so we don't overflow routes

Ed Blake (12):
      ASoC: img-i2s-out: Rename suspend / resume funcs
      ASoC: img-parallel-out: Add pm_runtime_get/put to set_fmt callback
      ASoC: img-spdif-out: Rename suspend / resume funcs
      ASoC: img-parallel-out: Check pm_runtime_get_sync return code
      ASoC: img-i2s-in: Add suspend / resume handling
      ASoC: img-i2s-in: Add runtime PM
      ASoC: img-i2s-out: Add suspend / resume handling
      ASoC: img-i2s-out: Add control of sys clock to runtime PM
      ASoC: img-spdif-in: Add suspend / resume handling
      ASoC: img-spdif-in: Add runtime PM
      ASoC: img-spdif-out: Add suspend / resume handling
      ASoC: img-spdif-out: Add control of sys clock to runtime PM

Fabio Estevam (1):
      ASoC: tfa9879: Add device tree bindings

Fang, Yang A (1):
      ASoC: ts3a227e: add acpi table

Geert Uytterhoeven (1):
      ASoC: fsi: Use of_device_get_match_data() helper

Guenter Roeck (1):
      ASoC: amd: use do_div rather than 64 bit division to fix 32 bit builds

Guneshwor Singh (5):
      ASoC: Intel: Skylake: Add flag to check to register FE dais from topo=
logy
      ASoC: Intel: Skylake: Add dai load ops for dais from topology
      ASoC: Intel: Skylake: Fix missing sentinel in sst_acpi_mach
      ASoC: Intel: Skylake: Fix updown mixer module format
      ASoC: Intel: Skylake: Add channel map in updown mixer module IPC

Gustavo A. R. Silva (7):
      ASoC: msm8916-wcd-analog: mark expected switch fall-through
      ASoC: tlv320aic23: mark expected switch fall-through
      ASoC: tlv320dac31xx: mark expected switch fall-through
      ASoC: tpa6130a2: mark expected switch fall-through
      ASoC: wm8753: mark expected switch fall-throughs
      ASoC: wm8993: mark expected switch fall-throughs
      ASoC: wm8994: mark expected switch fall-throughs

Harsha Priya N (3):
      ASoC: Intel: Kbl: Add Playback DAI for fixup
      ASoC: Intel: Enable tdm slots for max98927
      ASoC: Intel: Fix setting of SSP parameters in Kabylake machine driver

Jaechul Lee (3):
      ASoC: samsung: i2s: Use specific name for i2s dais
      ASoC: samsung: Use 'samsung-i2s' cpu_dai for dai_links
      ASoC: samsung: Fix invalid argument when devm_gpiod_get is called

Jaikrishna Nemallapudi (1):
      ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments

Jean Delvare (1):
      ASoC: rt5645: Make a few struct const

Jean-Fran=E7ois T=EAtu (2):
      ASoC: msm8916-wcd-digital: fix RX2 MIX1 and RX3 MIX1
      ASoC: codecs: msm8916-wcd-analog: fix micbias level

Jeffy Chen (5):
      ASoC: rt5514: Add devicetree binding support for rt5514-spi
      ASoC: rockchip: Add dapm route for DMic
      ASoC: rockchip: Add dapm route for HDMI
      ASoC: rockchip: Init dapm routes dynamically
      ASoC: rockchip: Use bus_type to distinguish rt5514 dsp from rt5514 co=
dec

John Keeping (1):
      ASoC: rockchip: i2s: fix unbalanced clk_disable

Kuninori Morimoto (40):
      ASoC: rsnd: fix ADG flags
      ASoC: add missing snd_soc_component_set_jack
      ASoC: rsnd: add rsnd_dma_alloc()
      ASoC: soc-core: remove rtd NULL check on soc_free_pcm_runtime()
      ASoC: remove unneeded dai->driver check
      ASoC: remove unneeded dai->driver->ops check
      ASoC: add null_snd_soc_ops and reduce NULL ops check
      ASoC: add Component level pcm_new/pcm_free v2
      ASoC: add Component level set_bias_level
      ASoC: rcar: skip disabled-SSI nodes
      ASoC: rsnd: add generic rsnd_flags_xxx() macro
      ASoC: rsnd: use generic rsnd_flags_xxx() macro on ADG
      ASoC: rsnd: DVC kctrl sets once
      ASoC: rsnd: CTU kctrl sets once
      ASoC: rsnd: makes volume ramp rate list generic
      ASoC: rsnd: add MIX Volume Ramp support
      ASoC: soc-core: add component lookup functions
      ASoC: soc-core: add snd_soc_add_component()
      ASoC: soc-core: remove unnecessary message from snd_soc_register_comp=
onent()
      ASoC: rsnd: add rsnd_kctrl_xxx() macro
      ASoC: rsnd: more clear ADG clock debug info
      ASoC: audio-graph-scu-card: add missing Capture routing on Example
      ASoC: audio-graph-scu-card: remove unnecessary route patch from Examp=
le 1
      ASoC: snd_soc_component_driver has snd_pcm_ops
      ASoC: snd_soc_component_driver has snd_compr_ops
      ASoC: snd_soc_component_driver has pmdown_time
      ASoC: snd_soc_component_driver has endianness
      ASoC: snd_soc_component_driver has non_legacy_dai_naming
      ASoC: rsnd: don't use io->mod[] directly
      ASoC: rsnd: tidyup rsnd_mod_next() for loop method
      ASoC: rsnd: NULL check is not needed for clk_unprepare()
      ASoC: rsnd: use snd_pcm_running() in rsnd_io_is_working()
      ASoC: rsnd: Don't check SSISR::DIRQ when Capture
      ASoC: rsnd: rsnd_ssi_run_mods() needs to care ssi_parent_mod
      ASoC: rsnd: remove NULL check from rsnd_mod_name()/rsnd_mod_id()
      ASoC: rsnd: return -EIO if rsnd_dmaen_request_channel() failed
      ASoC: add snd_soc_component_read32
      ASoC: add snd_soc_component_xxx_bias_level()
      ASoC: add snd_soc_component_cache_sync()
      ASoC: add snd_soc_dapm_kcontrol_component()

Li Xu (1):
      ASoC: cs43130: Add break keyword to switch case

Lori Hikichi (3):
      ASoC: cygnus: Add EXPORT_SYMBOL for helper function
      ASoC: cygnus: Remove set_fmt from SPDIF dai ops
      ASoC: cygnus: Remove support for 8 bit audio and for mono

Marco Franchi (1):
      ASoC: sgtl5000: Remove leading zero from '@0a' notation

Marek Szyprowski (1):
      ASoC: samsung: i2s: disable secondary DAI until it gets fixed

Mark Brown (38):
      Merge tag 'v4.14-rc1' into asoc-rockchip
      ASoC: wm9712: Add missing brace
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/so=
und into asoc-core
      Merge branch 'fix/pcm' of git://git.kernel.org/.../broonie/sound into=
 asoc-core
      Merge branch 'topic/component' of git://git.kernel.org/.../broonie/so=
und into asoc-core
      Merge branch 'topic/helpers' of git://git.kernel.org/.../broonie/soun=
d into asoc-intel
      Merge branch 'linus-4.14-rc4-acp-prereq' of git://people.freedesktop.=
org/~agd5f/linux into asoc-amd
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/msm8916' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rockchip' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adau17x1', 'asoc/fix/davinci=
' and 'asoc/fix/max98090' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5514', 'asoc/fix/rt5616', =
'asoc/fix/rt5659', 'asoc/fix/rt5663', 'asoc/fix/samsung' and 'asoc/fix/stm3=
2' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/topology' and 'asoc/fix/wm89=
98' into asoc-linus
      Revert "ASoC: rt5651: Enable jack detection on JD* pins"
      ASoC: pcm512x: Scrub my work address from the driver
      Merge tag 'asoc-fix-v4.14-rc6' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sunxi' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ac97', 'asoc/topic/ac97-mf=
d', 'asoc/topic/amd' and 'asoc/topic/arizona-mfd' into asoc-next
      Merge remote-tracking branches 'asoc/topic/bcm2835', 'asoc/topic/cs42=
l56' and 'asoc/topic/cs43130' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cygnus', 'asoc/topic/da721=
3', 'asoc/topic/davinci' and 'asoc/topic/doc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/fallthro=
ugh', 'asoc/topic/fsi', 'asoc/topic/fsl' and 'asoc/topic/graph' into asoc-n=
ext
      Merge remote-tracking branches 'asoc/topic/hdmi', 'asoc/topic/img' an=
d 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98925', 'asoc/topic/max=
98927', 'asoc/topic/msm8916' and 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231' and 'asoc/topic/rt=
5514' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/rt565=
1', 'asoc/topic/rt5659', 'asoc/topic/rt5663' and 'asoc/topic/rt5670' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sgtl=
5000', 'asoc/topic/stm32', 'asoc/topic/sunxi' and 'asoc/topic/tas571x' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/tfa9879', 'asoc/topic/ts3a=
277e', 'asoc/topic/wm8741', 'asoc/topic/wm97xx' and 'asoc/topic/zte' into a=
soc-next

Matthias Reichl (4):
      ASoC: bcm2835: Add support for TDM modes
      ASoC: bcm2835: Support additional samplerates up to 384kHz
      ASoC: bcm2835: Enforce full symmetry
      ASoC: bcm2835: Support left/right justified and DSP modes

Maxime Ripard (4):
      ASoC: sun8i-codec: Invert Master / Slave condition
      ASoC: sun8i-codec: Fix left and right channels inversion
      ASoC: sun8i-codec: Set the BCLK divider
      ASoC: sun8i-codec: Add a comment on the LRCK inversion

Naveen M (1):
      ASoC: Intel: Headset button support in kabylake machine driver

Nicolas Dechesne (1):
      ASoC: codecs: msm8916-wcd-analog: fix module autoload

Nicolin Chen (2):
      ASoC: fsl_ssi: Caculate bit clock rate using slot number and width
      ASoC: fsl-asoc-card: Don't error out if ENOTSUPP

Nik Nyby (1):
      ASoC: dwc: fix typos in Kconfig

Oder Chiou (3):
      ASoC: rt5663: Add the function of impedance sensing
      ASoC: rt5514-spi: Let the buf_size to align with period_bytes
      ASoC: rt5663: Delay and retry reading rt5663 ID register

Olivier Moysan (9):
      ASoC: stm32: sai: fix stop management in isr
      ASoC: stm32: sai: Fix DMA burst size
      ASoC: stm32: sai: Fix get reset controller
      ASoC: stm32: Add synchronization to SAI bindings
      ASoC: stm32: sai: Move static settings to DAI init
      ASoC: stm32: sai: Remove spurious IRQs on stop
      ASoC: stm32: sai: Add synchronization support
      ASoC: add mclk-fs to audio graph card binding
      ASoC: add mclk-fs support to audio graph card

Pankaj Bharadiya (3):
      ASoC: Intel: Skylake: Fix potential NULL pointer dereference
      ASoC: Intel: Skylake: Fix uuid_module memory leak in failure case
      ASoC: Intel: Skylake: Check for NHLT ACPI header signature

Pierre-Louis Bossart (31):
      ASoC: Intel: boards: use devm_clk_get() unconditionally
      ASoC: Intel: bytcr-rt5651: fix capture routes
      ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests
      ASoC: max98090: reduce verbosity on PLL unlock
      ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code
      ASoC: Intel: cht_bsw_max98090: add support for Baytrail
      ASoC: Intel: atom: use cht_bsw_max98090 for Baytrail Chromebooks
      ASoC: Intel: cht_bsw_max98090: add gpio-based jack detection
      ASoC: rt5670: refactor DMI quirks and fix Dell Venue settings
      ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume
      ASoC: Intel: cht_bsw_rt5672: fix card name
      ASoC: Intel: cht_bsw_max98090: remove useless code, align with Chrome=
OS driver
      ASoC: Add helper to find codec_dai from dai_name
      ASoC: Intel: bytcr_rt5651: add MCLK, quirks and cleanups
      ASoC: Intel: bytcr_rt5640: cosmetic fixes
      ASoC: Intel: cht_bsw_rt5645: cosmetic fixes
      ASoC: Intel: bytcht_da7213: cosmetic fixes
      ASoC: Intel: bytcht_es8316: remove useless code
      ASoC: Intel: boards: use helper to get codec_dai
      ASoC: Intel: boards: fix off-by-one dailink id
      ASoC: Intel: boards: remove hard-coded compressed dailinks
      ASoC: move ACPI common code out of Intel/sst tree
      ASoC: Intel: common: use c99 syntax for ACPI/machine tables
      ASoC: ACPI: add new fields for SOF support
      ASoC: Intel: move all ACPI match tables to common module
      ASoC: Intel: add SOF firmare/topology file information
      ASoC: Intel: move machine drivers to dedicated KConfig
      ASoC: Intel: reorder boards Kconfig by chronological order
      ASoC: Intel: clarify Kconfig dependencies
      ASoC: Intel: Add depends on X86
      ASoC: da7213: add support for DSP modes

Randy Dunlap (1):
      ASoC: fix build warning in soc-core.c

Robert Jarzmik (12):
      ALSA: ac97: split out the generic ac97 registers
      ALSA: ac97: add an ac97 bus
      ASoC: add new ac97 bus support
      ASoC: arm: make pxa2xx-ac97-lib ac97 codec agnostic
      Input: wm97xx: split out touchscreen registering
      mfd: wm97xx-core: core support for wm97xx Codec
      Input: wm97xx: add new AC97 bus support
      ASoC: wm9713: add ac97 new bus support
      ASoC: wm9712: add ac97 new bus support
      ASoC: wm9705: add private structure
      ASoC: wm9705: add ac97 new bus support
      ASoC: wm97xx: fix compilation corner case

Ryan Lee (2):
      ASoC: max98927: Added support for DSP_A and DSP_B format
      ASoC: max98927: Added max98927_dai_tdm_slot function

Sergej Sawazki (1):
      ASoC: wm8741: Fix setting BCLK and LRCLK polarity

Sriram Periyasamy (2):
      ASoC: Intel: Skylake: Optimize UUID handling to fill pin info
      ASoC: Intel: Skylake: Add dynamic module id support

Stuart Henderson (1):
      ASoC: dapm: Make snd_soc_dapm_add/del_routes use runtime mutex subcla=
ss

Subhransu S. Prusty (3):
      ASoC: hdac_hdmi: Fix static checker warning for sprintf usage
      ASoC: hdac_hdmi: Fix possible NULL pointer dereference
      ASoC: hdac_hdmi: Fix possible memory leak on parse and map nid failure

Takashi Iwai (4):
      ASoC: tas571x: Kill BUG_ON() usage
      ASoC: davinci: Kill BUG_ON() usage
      ASoC: intel: Kill BUG_ON() usage
      ASoC: pcm: Sync delayed work before releasing resources

Thierry Escande (1):
      ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

Vijendar Mukunda (7):
      drm/amd/amdgpu: Added asic_type as ACP DMA driver platform data
      ASoC: AMD: Added asic_type as ACP DMA driver platform data
      ASoC: AMD: disabling memory gating in stoney platform
      ASoC: AMD: DMA driver changes for Stoney Platform
      ASoC: AMD: Audio buffer related changes for Stoney
      ASoC: amd: Report accurate hw_ptr during dma
      ASoC: amd: Modified DMA transfer Mechanism for Playback

Vinod Koul (1):
      ASoC: Intel: kbl: fix jack name

anish kumar (3):
      ASoC: dapm: fix error path in snd_soc_dapm_new_pcm
      ASoC: dapm: Refactor the code in snd_soc_dapm_new_pcm
      ASoC: dapm: Avoid creating kcontrol for params

jiada wang (1):
      ASoC: soc-pcm: check symmetry after hw_params

oder_chiou@realtek.com (4):
      ASoC: rt5514: The ACPI also should use the function rt5514_parse_dp()
      ASoC: rt5514: Voice wakeup support.
      ASoC: rt5514-spi: check irq status to schedule data copy in resume fu=
nction
      ASoC: rt5663: Check the JD status in the button pushing

olivier moysan (3):
      ASoC: stm32: sai: fix warning in stm32_sai_set_config()
      ASoC: stm32: spdifrx: fix 16 bits capture
      ASoC: stm32: spdifrx: fix control DMA error management

 Documentation/devicetree/bindings/mfd/arizona.txt  |  40 +-
 .../devicetree/bindings/sound/audio-graph-card.txt |   1 +
 .../bindings/sound/audio-graph-scu-card.txt        |   5 +-
 .../devicetree/bindings/sound/cs42l56.txt          |   2 +-
 Documentation/devicetree/bindings/sound/rt5514.txt |  13 +-
 Documentation/devicetree/bindings/sound/rt5663.txt |  16 +
 .../devicetree/bindings/sound/sgtl5000.txt         |   2 +-
 .../devicetree/bindings/sound/st,stm32-sai.txt     |  14 +-
 .../devicetree/bindings/sound/tfa9879.txt          |  23 +
 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ++
 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   2 +
 drivers/gpu/drm/amd/include/amd_shared.h           |  29 +-
 drivers/input/touchscreen/Kconfig                  |   2 +-
 drivers/input/touchscreen/wm97xx-core.c            | 252 ++++++----
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/arizona-core.c                         | 132 +----
 drivers/mfd/wm97xx-core.c                          | 366 ++++++++++++++
 include/drm/amd_asic_type.h                        |  52 ++
 include/linux/mfd/arizona/pdata.h                  |   3 +
 include/linux/mfd/wm97xx.h                         |  25 +
 include/sound/ac97/codec.h                         | 118 +++++
 include/sound/ac97/compat.h                        |  20 +
 include/sound/ac97/controller.h                    |  85 ++++
 include/sound/ac97/regs.h                          | 262 ++++++++++
 include/sound/ac97_codec.h                         | 239 +--------
 include/sound/pxa2xx-lib.h                         |  15 +-
 include/sound/rt5651.h                             |   8 +
 include/sound/rt5663.h                             |   3 +
 include/sound/soc-acpi-intel-match.h               |  32 ++
 include/sound/soc-acpi.h                           | 111 +++++
 include/sound/soc.h                                | 115 +++++
 sound/Kconfig                                      |   2 +
 sound/Makefile                                     |   1 +
 sound/ac97/Kconfig                                 |  19 +
 sound/ac97/Makefile                                |   8 +
 sound/ac97/ac97_core.h                             |  16 +
 sound/ac97/bus.c                                   | 539 +++++++++++++++++=
++++
 sound/ac97/codec.c                                 |  15 +
 sound/ac97/snd_ac97_compat.c                       | 108 +++++
 sound/arm/pxa2xx-ac97-lib.c                        |  37 +-
 sound/arm/pxa2xx-ac97.c                            |  35 +-
 sound/soc/Kconfig                                  |   3 +
 sound/soc/Makefile                                 |   6 +
 sound/soc/amd/Kconfig                              |   7 +
 sound/soc/amd/Makefile                             |   6 +-
 sound/soc/amd/acp-pcm-dma.c                        | 356 ++++++++++----
 sound/soc/amd/acp-rt5645.c                         | 199 ++++++++
 sound/soc/amd/acp.h                                |  19 +
 sound/soc/bcm/bcm2835-i2s.c                        | 391 +++++++++++----
 sound/soc/bcm/cygnus-ssp.c                         |  34 +-
 sound/soc/codecs/Kconfig                           |  13 +-
 sound/soc/codecs/Makefile                          |   1 +
 sound/soc/codecs/arizona.c                         | 166 ++++++-
 sound/soc/codecs/arizona.h                         |   6 +-
 sound/soc/codecs/cs43130.c                         |  16 +-
 sound/soc/codecs/cs47l24.c                         |  14 +-
 sound/soc/codecs/da7213.c                          |  58 ++-
 sound/soc/codecs/da7213.h                          |   1 +
 sound/soc/codecs/hdac_hdmi.c                       |  51 +-
 sound/soc/codecs/hdmi-codec.c                      |   5 +-
 sound/soc/codecs/max98090.c                        |   2 +-
 sound/soc/codecs/max98925.c                        |  23 +-
 sound/soc/codecs/max98927.c                        | 155 ++++--
 sound/soc/codecs/max98927.h                        |   7 +-
 sound/soc/codecs/msm8916-wcd-analog.c              | 120 ++---
 sound/soc/codecs/msm8916-wcd-digital.c             |   4 +-
 sound/soc/codecs/pcm512x-i2c.c                     |   4 +-
 sound/soc/codecs/pcm512x-spi.c                     |   2 +-
 sound/soc/codecs/pcm512x.c                         |   4 +-
 sound/soc/codecs/pcm512x.h                         |   2 +-
 sound/soc/codecs/rl6231.c                          |   5 +-
 sound/soc/codecs/rt5514-spi.c                      |  46 ++
 sound/soc/codecs/rt5514.c                          |   6 +-
 sound/soc/codecs/rt5645.c                          |  32 +-
 sound/soc/codecs/rt5651.c                          | 219 ++++++++-
 sound/soc/codecs/rt5651.h                          |   4 +
 sound/soc/codecs/rt5659.c                          |  26 +-
 sound/soc/codecs/rt5663.c                          | 272 ++++++++++-
 sound/soc/codecs/rt5670.c                          | 143 +++++-
 sound/soc/codecs/rt5670.h                          |   4 +
 sound/soc/codecs/tas571x.c                         |   3 +-
 sound/soc/codecs/tfa9879.c                         |   6 +
 sound/soc/codecs/tlv320aic23.c                     |   1 +
 sound/soc/codecs/tlv320aic31xx.c                   |   2 +-
 sound/soc/codecs/tpa6130a2.c                       |   1 +
 sound/soc/codecs/ts3a227e.c                        |  10 +
 sound/soc/codecs/wm5102.c                          |  14 +-
 sound/soc/codecs/wm5110.c                          |  14 +-
 sound/soc/codecs/wm8741.c                          |  39 +-
 sound/soc/codecs/wm8753.c                          |   4 +-
 sound/soc/codecs/wm8993.c                          |   2 +
 sound/soc/codecs/wm8994.c                          |   2 +
 sound/soc/codecs/wm8997.c                          |  15 +-
 sound/soc/codecs/wm8998.c                          |  95 ++--
 sound/soc/codecs/wm9705.c                          |  68 ++-
 sound/soc/codecs/wm9712.c                          |  48 +-
 sound/soc/codecs/wm9713.c                          |  39 +-
 sound/soc/davinci/davinci-mcasp.c                  |  21 +-
 sound/soc/dwc/Kconfig                              |   4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  14 +-
 sound/soc/fsl/fsl_spdif.c                          |   4 +-
 sound/soc/fsl/fsl_ssi.c                            |  46 +-
 sound/soc/generic/audio-graph-card.c               |  47 +-
 sound/soc/img/img-i2s-in.c                         | 130 ++++-
 sound/soc/img/img-i2s-out.c                        | 120 +++--
 sound/soc/img/img-parallel-out.c                   |   6 +
 sound/soc/img/img-spdif-in.c                       | 110 ++++-
 sound/soc/img/img-spdif-out.c                      |  87 +++-
 sound/soc/intel/Kconfig                            | 302 +-----------
 sound/soc/intel/Makefile                           |   2 +-
 sound/soc/intel/atom/sst-mfld-platform-compress.c  |   2 +-
 sound/soc/intel/atom/sst-mfld-platform.h           |   2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                | 312 +-----------
 sound/soc/intel/atom/sst/sst_loader.c              |   1 -
 sound/soc/intel/atom/sst/sst_stream.c              |   1 -
 sound/soc/intel/boards/Kconfig                     | 265 ++++++++++
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  16 +-
 sound/soc/intel/boards/bytcht_da7213.c             |  23 +-
 sound/soc/intel/boards/bytcht_es8316.c             |  27 +-
 sound/soc/intel/boards/bytcht_nocodec.c            |  10 +-
 sound/soc/intel/boards/bytcr_rt5640.c              | 118 ++---
 sound/soc/intel/boards/bytcr_rt5651.c              | 297 ++++++++++--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       | 185 +++++--
 sound/soc/intel/boards/cht_bsw_rt5645.c            | 128 ++---
 sound/soc/intel/boards/cht_bsw_rt5672.c            |  68 +--
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  76 ++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   3 +
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  16 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  16 +-
 sound/soc/intel/common/Makefile                    |   4 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  | 196 ++++++++
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  | 194 ++++++++
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |  64 +++
 sound/soc/intel/common/sst-acpi.c                  |  36 +-
 sound/soc/intel/common/sst-acpi.h                  |  82 ----
 sound/soc/intel/common/sst-firmware.c              |   3 +-
 sound/soc/intel/skylake/skl-messages.c             |  32 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   9 +
 sound/soc/intel/skylake/skl-pcm.c                  |  49 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |  15 +-
 sound/soc/intel/skylake/skl-topology.c             |  70 ++-
 sound/soc/intel/skylake/skl-topology.h             |  10 +-
 sound/soc/intel/skylake/skl.c                      |  50 +-
 sound/soc/intel/skylake/skl.h                      |   4 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |   2 +-
 sound/soc/kirkwood/kirkwood.h                      |   2 +-
 sound/soc/omap/omap-hdmi-audio.c                   |   3 +
 sound/soc/pxa/pxa2xx-ac97.c                        |  32 +-
 sound/soc/qcom/lpass-platform.c                    |   2 -
 sound/soc/rockchip/rk3399_gru_sound.c              | 159 +++++-
 sound/soc/rockchip/rockchip_i2s.c                  |   1 -
 sound/soc/samsung/i2s.c                            |  10 +-
 sound/soc/samsung/i2s.h                            |   3 +
 sound/soc/samsung/tm2_wm5110.c                     |   7 +-
 sound/soc/sh/fsi.c                                 |  11 +-
 sound/soc/sh/rcar/adg.c                            |  72 ++-
 sound/soc/sh/rcar/core.c                           |  51 +-
 sound/soc/sh/rcar/ctu.c                            |  88 ++--
 sound/soc/sh/rcar/dma.c                            |  84 ++--
 sound/soc/sh/rcar/dvc.c                            |  60 +--
 sound/soc/sh/rcar/mix.c                            | 158 +++++-
 sound/soc/sh/rcar/rsnd.h                           |  22 +-
 sound/soc/sh/rcar/ssi.c                            |  58 ++-
 .../{intel/common/sst-match-acpi.c =3D> soc-acpi.c}  |  56 +--
 sound/soc/soc-compress.c                           | 461 ++++++++++++++++--
 sound/soc/soc-core.c                               | 222 ++++++---
 sound/soc/soc-dapm.c                               | 158 +++---
 sound/soc/soc-io.c                                 |  14 +
 sound/soc/soc-pcm.c                                | 462 ++++++++++++++++--
 sound/soc/stm/stm32_sai.c                          | 162 ++++++-
 sound/soc/stm/stm32_sai.h                          |  22 +-
 sound/soc/stm/stm32_sai_sub.c                      | 162 +++++--
 sound/soc/stm/stm32_spdifrx.c                      |  23 +-
 sound/soc/sunxi/sun4i-codec.c                      |  29 +-
 sound/soc/sunxi/sun8i-codec.c                      |  72 ++-
 sound/soc/zte/zx-spdif.c                           |   4 +-
 178 files changed, 8694 insertions(+), 2886 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/drm/amd_asic_type.h
 create mode 100644 include/linux/mfd/wm97xx.h
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 include/sound/ac97/regs.h
 create mode 100644 include/sound/soc-acpi-intel-match.h
 create mode 100644 include/sound/soc-acpi.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c
 create mode 100644 sound/soc/amd/acp-rt5645.c
 create mode 100644 sound/soc/intel/boards/Kconfig
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-byt-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cht-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
 delete mode 100644 sound/soc/intel/common/sst-acpi.h
 rename sound/soc/{intel/common/sst-match-acpi.c =3D> soc-acpi.c} (63%)

--wgvi6ahtbxjvyg6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloJh4kACgkQJNaLcl1U
h9DG1Af/fgXqOxjDneHRSY9A9E1ZEBeBnh/3+j0r08wEq4CN5fLClWeskOLoNTN3
SHNXAUpKqhFVpw7xBgzVm/7s7XRXEb79Enfspc6NJ8NkrAM7DZ+WuT+OkUwUSf2A
JlqmY5nstpZnGp/ru8ONAxrfKp1oqkV6ZEh1R//nrMwt6iUJjJt5wn78GOPGzTYs
INjhCdKnny/V/dke1NURbWukv/fv7ePPDnj1k5ErFtpX7Reooq7k+e0je+jnkEFz
MplMDpbK1jy0RW9Fq0p01WjFQccsaf+tFqZFZMzVDN7hBMThKF+8PbKvUpfvbVc7
qp0etzJ59QabgiSv1a21HfGu1GgmWQ==
=jHCn
-----END PGP SIGNATURE-----

--wgvi6ahtbxjvyg6y--

--===============7471766321822726942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7471766321822726942==--
