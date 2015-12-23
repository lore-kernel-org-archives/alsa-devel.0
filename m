From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.5
Date: Wed, 23 Dec 2015 00:43:11 +0000
Message-ID: <20151223004311.GL16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8097841874913796033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 344BF265DA8
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:43:20 +0100 (CET)
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


--===============8097841874913796033==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 4ef7675344d687a0ef5b0d7c0cee12da005870c0:

  Linux 4.4-rc6 (2015-12-20 16:06:09 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.5

for you to fetch changes up to 822ad70a2f5c420da5baa9f4354e6b7813ca6da9:

  Merge remote-tracking branch 'asoc/topic/rt5677' into asoc-next (2015-12-=
23 00:38:14 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.5

This is quite a busy release on the driver front with a lot of new
drivers being added but comparatively quiet on the core side with only
one big change going in and that a fairly straightforward refactoring.

 - Conversion of the array of DAI links to a list by Mengdong Lin,
   supporting dynamically adding and removing DAI links.
 - Some more fixes for the topology code, though it is still not final
   and ready for enabling in production.  We really need to get to the
   point where that can be done.
 - A pile of changes for Intel SkyLake drivers which hopefully deliver
   some useful initial functionality for systems with this chipset,
   though there is more work still to come.
 - New drivers for a number of Imagination Technologies IPs.
 - Lots of new features and cleanups for the Renesas drivers.
 - ANC support for WM5110.
 - New driver for Atmel class D speaker drivers.
 - New drivers for Cirrus CS47L24 and WM1831.
 - New driver for Dialog DA7128.
 - New drivers for Realtek RT5659 and RT56156.
 - New driver for Rockchip RK3036.
 - New driver for TI PC3168A

----------------------------------------------------------------
Adam Thomson (9):
      ASoC: da7218: Add bindings documentation for DA7218 audio codec
      ASoC: da7218: Add da7218 codec driver
      ASoC: da7218: Enable mic level detection reporting to user-space
      ASoC: da7219: Fix Sidetone to work regardless of DAI capture
      ASoC: da7219: Disable regulators on probe() failure
      ASoC: da7219: Update REFERENCES reg default, in-line with HW
      ASoC: da7219: Remove internal LDO features of codec
      ASoC: da7219: Add support for 1.6V micbias level
      ASoC: da7219: Remove support for 32KHz PLL mode

Anatol Pomozov (1):
      ASoC: rt5677: use 'active low' logic for reset pin

Arnd Bergmann (8):
      ASoC: samsung: pass DMA channels as pointers
      ASoC: s3c24xx-i2s: pass DMA channels as platform data
      ASoC: pxa: remove incorrect do_div() call
      ASoC: sh: fix fsi build warnings for 64 bit
      ASoC: samsung: pass filter function as pointer
      ASoC: rcar: remove unused variable
      ASoC: fsl: use correct format string for dma_addr_t
      ASoC: da7218: avoid 64-bit compile warning

Axel Lin (3):
      ASoC: da7219: Use logical instead of bitwise OR for boolean expression
      ASoC: wm8904: Make undocumented registers non-readable
      ASoC: rt5616: Return error if device ID mismatch

Bard Liao (7):
      ASoC: rt298: fix remove unnedded clk setting
      ASoC: rt5645: Separate regmap for rt5645 and rt5650
      ASoC: rt5659: add rt5659 codec driver
      ASoC: rt5645: merge DMI tables of google projects
      ASoC: rt5616: add rt5616 codec driver
      ASoC: rt5616: rename some alsa control names
      ASoC: rt5677: set PLL_CTRL2 non-volatile

Ben Zhang (1):
      ASoC: rt5677: Reconfigure PLL1 after resume

Caesar Wang (5):
      ASoC: rockchip: i2s: change bclk and lrck according to sample rates
      ASoC: rockchip-max98090: Allow more sample rates
      ASoC: rockchip-rt5645: Allow more sample rates
      ASoC: rt5616: add an of_match table
      ASoC: rt5616: add devicetree document for rt5616

Charles Keepax (17):
      ASoC: wm5110: Add DAPM/routing hookup for the ANC block
      ASoC: wm_adsp: Expand the list of available firmwares
      ASoC: arizona: Add 32uS delay after putting FLL into freerun
      ASoC: dapm: Make enable/disable_pin work with always on widgets
      ASoC: arizona: Correct types of mixer texts and values
      ASoC: arizona: Fix type of clock rate pointer in arizona_set_sysclk
      ASoC: wm_adsp: Replace debugfs lock with more general DSP power lock
      ASoC: wm_adsp: Add power lock for firmware change control
      ASoC: wm_adsp: Fixup some minor formatting and checkpatch errors
      ASoC: wm_adsp: Add locking to DSP firmware controls
      ASoC: wm_adsp: Mimic legacy behaviour of reading controls when DSP is=
 on
      ASoC: wm5110: Provide basic hookup for voice control
      ASoC: wm_adsp: Factor out finding the location of an algorithm region
      ALSA: compress: Add SND_AUDIOCODEC_BESPOKE
      ASoC: wm_adsp: Add support for opening a compressed stream
      ASoC: wm_adsp: Add code to locate and initialise compressed buffer
      ASoC: wm_adsp: Attach buffers and streams together

Damien.Horsley (17):
      ASoC: img: Add binding document for I2S input controller
      ASoC: img: Add driver for I2S input controller
      ASoC: img: Add binding document for I2S output controller
      ASoC: img: Add driver for I2S output controller
      ASoC: img: Add binding document for parallel output controller
      ASoC: img: Add driver for parallel output controller
      ASoC: img: Add binding document for SPDIF input controller
      ASoC: img: Add driver for SPDIF input controller
      ASoC: img: Add documentation for SPDIF in controls
      ASoC: img: Add binding document for SPDIF output controller
      ASoC: img: Add driver for SPDIF output controller
      ASoC: img: parallel out: Add missing initialiser
      ASoC: Add SOC_DOUBLE_STS macro
      ASoC: pcm3168a: Add binding document for pcm3168a codec
      ASoC: pcm3168a: Add driver for pcm3168a codec
      ASoC: img: Add binding document for Pistachio internal DAC
      ASoC: img: Add driver for Pistachio internal DAC

Dan Carpenter (3):
      ASoC: Intel: pass correct parameter in sst_alloc_stream_mrfld()
      ASoC: Intel: Skylake: Fix a couple signedness bugs
      ASoC: Intel: Skylake: pointer math issue

Dharageswari R (2):
      ASoC: Intel: Skylake: Add support for Loadable modules
      ASoC: Intel: Skylake: Add support for Mic Select module

Fang, Yang A (3):
      ASoC: Intel: Skylake: add adi + nau8825 machine driver entry
      ASoc: Intel: boards: fix dapm map of nau88l25_ssm4567 machine
      ASoc: Intel: boards: Add HDMI/DP links for nau88l25_ssm4567 machine

Geert Uytterhoeven (2):
      ASoC: rsnd: Add missing initialization of ADG req_rate
      ASoC: rsrc-card: Clarify compatible value

Hans de Goede (3):
      ASoC: sun4i-codec: Rename codec dapm widgets and routes
      ASoC: sun4i-codec: Add support for PA gpio pin
      ASoC: sun4i-codec: Use proper output for external amp routes

Hardik T Shah (3):
      ASoC: Intel: Skylake: Add multiple pin formats
      ASoC: Intel: Skylake: Update the topology interface structure
      ASoC: Intel: Skylake: Add support for module GUIDs

Harsha Priya (1):
      ASoC: Intel: Skylake: Adding nau88l25+ssm4567 machine driver

Jean-Michel Hautbois (1):
      ASoC: sgtl5000: fix VAG power up timing

Jeeja KP (39):
      ASoC: Intel: Skylake: Fix to correct check for non DSP widget
      ASoC: Intel: Skylake: Fix not to ignore return value in be hw_params
      ASoC: Intel: Skylake: Fix to add 32 bit in update FE params
      ASoC: Intel: Skylake: Fix to ignore codec_mask check in probe
      ASoC: Intel: Skylake: Fix to ignore blob check if link type is HDA
      ASoC: Intel: Skylake: Fix support for multiple pins in a module
      ASoC: Intel: Skylake: Fix bit depth when querying the NHLT blob
      ASoC: Intel: Skylake: use module_pin info for unbind
      ASoC: Intel: Skylake: Add support for virtual dsp widgets
      ASoC: Intel: Skylake: Fix DSP pipe underrun/overrun issue
      ASoC: Intel: Skylake: Fix to remove be copier widget power check
      ASoC: Intel: Skylake: Ignore rate check for DMIC link
      ASoC: Intel: Skylake: Fix to remove channel_map calculation
      ASoC: Intel: Skylake: Fix PM behaviour
      ASoC: Intel: Skylake: Fix the SSP0 Fmt fixup to 24 bit
      ASoC: Intel: Skylake: Add support for SSP1 BE cpu dai
      ASoC: Intel: Skylake: remove pm_runtime_get/put calls
      ASoC: Intel: Skylake: Don't enable WAKEENABLE on suspend
      ASoC: Intel: Skylake: Remove redundant init in resume
      ASoC: Intel: Skylake: Fix cleanup of dma buffer
      ASoC: Intel: Skylake: Reset the DSP when set D3 fails
      ASoC: Intel: Skylake: Fix CLDMA buffer wrap case
      ASoC: Intel: Skylake: Fix null ptr dereferenced in skl_tplg_bind_sinks
      ASoC: Intel: Skylake: Add pm ops for skl_rt286 machine
      ASoC: Intel: Skylake: Reconfigure HDA stream register in prepare/resu=
me
      ASoC: Intel: Skylake: Fix to update bit depth for module params
      ASoC: Intel: Skylake: Update pcm capability
      ASoC: Intel: Skylake: Poll CLDMA RUN bit when set
      ASoC: Intel: Skylake: Update DMIC DAIs and capabilities
      ASoC: Intel: Skylake: Add helper routines to handle module params
      ASoC: Intel: Skylake: Add helper routine to handle Algo parameter
      ASoC: Intel: Skylake: Add support to configure module params
      ASoC: Intel: Skylake: Add tlv byte kcontrols
      ASoC: Intel: Skylake: Add memory pages to widget data.
      ASoC: Intel: Skylake: Fix module init data correctly
      ASoC: Intel: Skylake: Add dai link for DMIC capture
      ASoC: Intel: Skylake: Add support for active suspend
      ASoC: Intel: Skylake: Clear stream registers before stream setup
      ASoC: Intel: Skylake: Fix to set pipe state to invalid when deleting

Jiada Wang (1):
      ASoC: wm8962: set ALC2 as non-volatile register

Jie Yang (2):
      ASoC: Intel: sst: only select sst-firmware when DW DMAC is built-in
      ASoC: Intel: sst: fix sst_memcpy32 wrong with non-4x bytes issue

John Keeping (4):
      ASoC: rockchip: i2s: separate capture and playback
      ASoC: rockchip: i2s: remove unused variables
      ASoC: es8328: Fix deemphasis values
      ASoC: es8328: Fix shifts for mixer switches

Julia Lawall (4):
      ASoC: Intel: constify sst_block_ops structures
      ASoC: imx-pcm-dma: add NULL test
      ASoC: omap-hdmi-audio: add NULL test
      ASoC: Intel: add NULL test

Koro Chen (4):
      ASoC: dpcm: Make BE prepare possible in suspend state
      ASoC: mediatek: Move 22M/24M clock control into I2S ops
      ASoC: mediatek: Use current HW pointer for pointer callback
      ASoC: mediatek: Turn AFE on/off in runtime resume/suspend

Kuninori Morimoto (82):
      ASoC: rsnd: DMA become SSI/SRC member
      ASoC: rsnd: DMA related definition goes to dma.c
      ASoC: rsnd: rename rsnd_dma_init() to rsnd_dma_attach()
      ASoC: rsnd: enable to use rsnd_dai_connect() from each mod
      ASoC: rsnd: remove all modules when PIO fallback
      ASoC: rsnd: fixup rsnd_dma_of_path method for mod base common method
      ASoC: rsnd: move rsnd_src_ssi_irq_enable/disable() to ssi.c
      ASoC: rsnd: disable SRC.out only when stop timing
      ASoC: rsnd: rsnd_dai_stream has each mod's status insted of rsnd_mod
      ASoC: rsnd: Don't stop HW even if a large number of errors occur
      ASoC: rsnd: avoid pointless loop in rsnd_mod_interrupt()
      ASoC: rsnd: use common rsnd_ssi_status_xxx()
      ASoC: rsnd: use mod base common method on DMA phase1
      ASoC: rsnd: use mod base common method on DMA phase2
      ASoC: rsnd: use mod base common method on DMA phase3
      ASoC: rsnd: use mod base common method on CMD
      ASoC: rsnd: use mod base common method on SSIU
      ASoC: rsnd: use mod base common method on SSI-parent
      ASoC: rsnd: call rsnd_src_quit() from rsnd_src_quit_gen2()
      ASoC: rsnd: fixup rsnd_dmapp_stop() return value
      ASoC: rsnd: audio_clkout0/1/2/3 are optional properties
      ASoC: rsnd: move CMD related operation to cmd.c
      ASoC: rsnd: DVC settings matches to datasheet
      ASoC: rsnd: MIX settings matches to datasheet
      ASoC: rsnd: tidyup comment position of rsnd_mod_xxx
      ASoC: rsnd: call clk_prepare()/clk_enable() for AUDIO_CLKx
      ASoC: ak4613: add single-end optional property for IN/OUT pins
      ASoC: ak4613: tidyup CTRL1 value selection method
      ASoC: rsnd: SND_SOC_RCAR doesn't depend on DMA_OF
      ASoC: rsnd: ssi: 24bit data needs right-aligned settings
      ASoC: ak4613: don't overwrite CTRL2 register
      ASoC: rsnd: remove Gen1 support from SRC
      ASoC: rsnd: cleanup RSND_REG_xxx
      ASoC: rsnd: SRC settings matches to datasheet
      ASoC: rsnd: remove platform boot support from core.c
      ASoC: rsnd: remove platform boot support from ssi.c
      ASoC: rsnd: remove platform boot support from src.c
      ASoC: rsnd: remove platform boot support from ctu.c
      ASoC: rsnd: remove platform boot support from mix.c
      ASoC: rsnd: remove platform boot support from dvc.c
      ASoC: rsnd: remove platform boot support from gen.c
      ASoC: rsnd: remove struct rsnd_of_data
      ASoC: rsnd: remove struct rcar_snd_info
      ASoC: rsnd: remove struct platform_device from probe/remove parameter
      ASoC: ak4613: tidyup vendor prefix from ak4613 to asahi-kasei
      ASoC: rsnd: tidyup void* cast for 64bit compiler
      ASoC: rsnd: indicate register name for debug
      ASoC: rsnd: tidyup semantics of rsnd_src_record_error()
      ASoC: rsnd: tidyup semantics of rsnd_ssi_record_error()
      ASoC: rsnd: don't use normal *mod in adg.c
      ASoC: rsnd: add missing ADINR::CHNUM on DVC/SRC/SSIU
      ASoC: rsnd: add missing SRC_O_BUSIF_MODE register
      ASoC: rsnd: src: rename rsnd_src_soft_reset() to rsnd_src_activation()
      ASoC: rsnd: mix: rename rsnd_mix_soft_reset() to rsnd_mix_activation()
      ASoC: rsnd: dvc: rename rsnd_dvc_soft_reset() to rsnd_dvc_activation()
      ASoC: rsnd: src: add rsnd_src_halt()
      ASoC: rsnd: mix: add rsnd_mix_halt()
      ASoC: rsnd: dvc: add rsnd_dvc_halt()
      ASoC: rsnd: add rsnd_ssi_config_init()
      ASoC: rsnd: set SSIWSR setting on rsnd_ssi_config_init()
      ASoC: rsnd: ssi enables non-stereo sound
      ASoC: rsnd: dvc enables non-stereo sound
      ASoC: rsnd: add TDM Extend Mode support
      ASoC: rsnd: fixup wrong snd_soc_dai_driver pointer access
      ASoC: rsnd: rsrc-card: check return value of snd_soc_of_get_dai_name()
      ASoC: rsnd: care SWSP bit for TDM/non-TDM
      ASoC: rsnd: tidyup data align position for capture
      ASoC: rsrc-card: enable to use tdm_slot on DT
      ASoC: rsrc-card: Remove support for setting differing DAI formats
      ASoC: rsrc-card: tidyup dai format for DPCM
      ASoC: rsnd: fixup SSIU control timing
      ASoC: rsnd: tidyup return value of rsnd_get_adinr_bit()
      ASoC: rsnd: tidyup debug print position on rsnd_dma_attach()
      ASoC: rsnd: rsnd_dai_connect() returns error if it connect to existin=
g mod
      ASoC: rsnd: SSI/SSIU use rsnd_get_slot_extend() to check TDM
      ASoC: rsnd: remove rsnd_get_slot_runtime()
      ASoC: rsnd: tidyup rsnd_get_slot_xxx() naming
      ASoC: rsnd: add rsnd_set_slot() / rsnd_get_slot_num()
      ASoC: rsnd: add rsnd_parse_connect_common() and remove complex macro
      ASoC: rsnd: add missing DT example for Simple Card
      ASoC: rsnd: add missing DT example for Simple Card with TDM
      ASoC: rsnd: add Multi channel support

Liam Girdwood (1):
      ASoC: Intel: sst: fix the IRQ locked issue

Linus Walleij (2):
      ASoC: wm8903: Be sure to clamp return value
      ASoC: ac97: Be sure to clamp return value

Maciej S. Szmigiero (1):
      ASoC: fsl-asoc-card: use different route map for AC'97 mode

Mans Rullgard (3):
      ASoC: wm8974: set cache type for regmap
      ASoC: wm8974: add devicetree support
      ASoC: wm8974: add binding for WM8974 codec

Mark Brown (37):
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto HEAD
      Merge branch 'fix/arizona' of git://git.kernel.org/.../broonie/sound =
into asoc-arizona
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5645
      Merge branch 'topic/pcm-list' of git://git.kernel.org/.../broonie/sou=
nd into asoc-intel
      Merge branch 'topic/hdac' of git://git.kernel.org/.../broonie/sound i=
nto asoc-intel
      ASoC: hdac: Fix Makefile and Kconfig sorting
      Merge branch 'topic/fsl-sai' of git://git.kernel.org/.../broonie/soun=
d into asoc-fsl
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5645
      Merge branch 'topic/sink' of git://git.kernel.org/.../broonie/sound i=
nto asoc-dapm
      Merge branch 'fix/sun4i-codec' of git://git.kernel.org/.../broonie/so=
und into asoc-sunxi
      Merge branch 'topic/sink' of git://git.kernel.org/.../broonie/sound i=
nto asoc-intel
      rcar: ctu: Avoid use of ret uninitialised
      rcar: dvc: Avoid use of ret uninitialised
      rcar: mux: Avoid use of ret uninitialised
      Merge branch 'topic/arizona' of git://git.kernel.org/.../broonie/soun=
d into asoc-adsp
      Merge branch 'topic/cs47l24' of git://git.kernel.org/.../broonie/soun=
d into asoc-adsp
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/es8328',=
 'asoc/fix/fsl-sai', 'asoc/fix/rockchip', 'asoc/fix/sgtl5000' and 'asoc/fix=
/wm8974' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm-list' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3168a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branch 'asoc/topic/sunxi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ac97', 'asoc/topic/adsp', =
'asoc/topic/ak4613' and 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/atmel-classd', 'asoc/topic=
/const' and 'asoc/topic/da7218' into asoc-next
      Merge remote-tracking branches 'asoc/topic/da7219', 'asoc/topic/dai-l=
ink' and 'asoc/topic/doc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dpcm', 'asoc/topic/dwc', '=
asoc/topic/fsl', 'asoc/topic/fsl-asrc' and 'asoc/topic/fsl-esai' into asoc-=
next
      Merge remote-tracking branches 'asoc/topic/fsl-spdif', 'asoc/topic/im=
g' and 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/kcontrol', 'asoc/topic/max=
98357a' and 'asoc/topic/mtk' into asoc-next
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/qcom', '=
asoc/topic/rcar', 'asoc/topic/rk3036' and 'asoc/topic/rockchip' into asoc-n=
ext
      Merge remote-tracking branches 'asoc/topic/rt286', 'asoc/topic/rt5616=
' and 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sh',=
 'asoc/topic/ssm2518' and 'asoc/topic/sti' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tegra', 'asoc/topic/topolo=
gy', 'asoc/topic/wm8903' and 'asoc/topic/wm8904' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8962', 'asoc/topic/wm897=
4' and 'asoc/topic/wm9713' into asoc-next
      Merge tag 'asoc-fix-v4.4-rc6' into asoc-linus
      Merge tag 'asoc-v4.5' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5677' into asoc-next

Markus Elfring (1):
      ASoC: ssm2518: Use a signed return type for ssm2518_lookup_mcs()

Maruthi Srinivas Bayyavarapu (3):
      ASoC: dwc: add runtime suspend/resume functionality
      ASoC: dwc: add quirk for different register offset
      ASoC: dwc: reconfigure dwc in 'resume' from 'suspend'

Maxime Ripard (3):
      ASoC: sun4i: Implement MIC1 capture
      ASoC: sunxi: Remove useless comments and variable
      ASoC: sun4i-codec: pass through clk_set_rate error

Mengdong Lin (9):
      ASoC: topology: ABI - Rename dai_elems to pcm_elems in manifest
      ASoC: Vendor drivers get a link's runtime by snd_soc_get_pcm_runtime()
      ASoC: Change the PCM runtime array to a list
      ASoC: Define soc_init_dai_link() to wrap link intialization.
      ASoC: Change 2nd argument of soc_bind_dai_link() to DAI link pointer
      ASoC: Implement DAI links in a list & define API to add/remove a link
      ASoC: Define add/remove_dai_link ops for a soc card
      ASoC: soc_bind_dai_link() directly returns success for a bound DAI li=
nk
      ASoC: Bind new DAI links after probing components

Moise Gergaud (1):
      ASoC: sti: set iec958 channel status sampling freq

Mousami Jana (1):
      ASoC: Intel: Skylake: add LARGE_CONFIG_GET IPC support

Mythri P K (1):
      ASoC: core: Pass kcontrol to bytes tlv callbacks

Oder Chiou (1):
      ASoC: rt5645: Use the mod_delayed_work instead of the queue_delayed_w=
ork and cancel_delayed_work_sync

Omair M Abdullah (2):
      ASoC: Intel: Skylake: update mailbox uplink window offset and size
      ASoC: Intel: Skylake: read params from DSP if module is on

PC Liao (1):
      ASoC: dpcm: Apply symmetry for DPCM

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Fix XDATA check in mcasp_start_tx

Pierre-Louis Bossart (9):
      ASoC: Intel: boards: align pin names between byt-rt5640 drivers
      ASoC: Intel: boards: start merging byt-rt5640 drivers
      ASoC: Intel: boards: merge DMI-based quirks in bytcr-rt5640 driver
      ASoC: Intel: tag byt-rt5640 machine driver as deprecated
      ASoc: Intel: Atom: add deep buffer definitions for atom platforms
      ASoC: Intel: boards: add DEEP_BUFFER support for BYT/CHT/BSW
      ASoC: Intel: Atom: add 24-bit support for media playback and capture
      ASoC: Intel: Atom: clean-up compressed DAI definition
      ASoC: Intel: Atom: flip logic for gain Switch

Praveen Diwakar (1):
      ASoC: Intel: Skylake: Update ignore suspend for rt286 machine

Richard Fitzgerald (3):
      ASoC: wm8998: Remove duplicated consts
      ASoC: cs47l24: Add driver for Cirrus Logic CS47L24 and WM1831 codecs
      ASoC: arizona: In arizona_calc_fratio make new codecs the default case

Robert Jarzmik (3):
      ASoC: wm9713: convert to regmap
      ASoC: wm9713: use snd_soc_*() calls to update ac97 registers
      ASoC: ac97: add gpio chip

Rohit Ainapure (3):
      ASoC: max98357a: Add ACPI ID for Maxim
      ASoC: Intel: Add Nuvoton+Maxim machine driver entry
      ASoC: Intel: Skylake: Add Nuvoton Maxim machine driver

Sathyanarayana Nujella (1):
      ASoc: Intel: boards: Add WOV as sink for nau88l25_ssm4567 machine

Sebastien Guiriec (1):
      ASoC: Intel: bytcr_rt5640: set SSP to I2S mode 2ch

Shengjiu Wang (3):
      ASoC: fsl_esai: spba clock is needed by esai device
      ASoC: fsl_spdif: spba clk is needed by spdif device
      ASoC: fsl_asrc: spba clock is needed by asrc device

Simon Horman (1):
      ASoC: rsnd: Add device tree support for r8a77{79,93,94}

Sjoerd Simons (1):
      ASoC: rockchip: spdif: Set transmit data level to 16 samples

Songjun Wu (6):
      ASoC: Atmel: ClassD: supports mono audio
      ASoC: Atmel: ClassD: add GCK's parent clock in DT binding
      ASoC: Atmel: ClassD: unregister codec when error occurs
      ASoC: atmel-pdmic: add the Pulse Density Modulation Interface Control=
ler
      ASoC: atmel-classd: DT binding for PDMIC driver
      ASoC: atmel_wm8904: add snd_soc_pm_ops

Stephen Boyd (1):
      ASoC: qcom: Specify LE device endianness

Subhransu S. Prusty (7):
      ASoC: Intel: Skylake: Fix to cleanup if skl_sst_dsp_init fails
      ALSA: hdac: structure definition for ext_dma_params
      ASoC: hdac-hdmi: Add hdmi driver
      ASoC: hdac_hdmi: Add PM support for HDMI
      ASoC: hdac_hdmi: Add hdac hdmi dai ops
      ASoC: hdac_hdmi: Setup and start infoframe
      ASoC: hdac_hdmi: Use i915 component framework for PM

Sudip Mukherjee (3):
      ASoC: hdac_hdmi: fix possible NULL dereference
      ASoC: tegra_alc5632: check return value
      ASoC: hdac_hdmi: check error return

Sugar Zhang (2):
      ASoC: rockchip: i2s: compatible with different chips
      ASoC: rockchip: add playback property

Takashi Iwai (1):
      ASoC: Fix typo in kernel doc comment for snd_soc_put_volsw_sx()

Vincent Stehl=E9 (1):
      ASoC: Intel: Skylake: fix typo in sizeof

Vinod Koul (20):
      ASoC: Intel: Skylake: Fix substream dereference before check
      ASoC: Intel: Skylake: Fix resource cleanup on teardown
      ASoC: Intel: Move apci find machine routines
      ASoC: Intel: Atom: move atom driver to common acpi match
      ASoC: Intel: Skylake: Fix skl machine driver creation
      ASoC: Intel: add fw name to common dsp context
      ASoC: Intel: Skylake: Use the fw name from ACPI mach table
      ASoC: rt286: set combo jack for Skylake
      ASoC: core: refactor soc_link_dai_widgets()
      ASoC: Intel: Skylake: Add I2C depends for SKL machine
      ASoC: Intel: Skylake: Constrain the audio devices
      ASoC: fsl-asoc-card: Update the rtd query
      ASoC: Intel: Skylake: Update the rtd query
      ASoC: Intel: Skylake: Fix test of a field address
      ASoC: hdac-hdmi: make driver select CONFIG_HDMI
      ASoC: dapm: add a dapm sink widget
      ASoC: core: mark SND_SOC_BYTES_EXT as deprecated
      ASoC: Intel: Skylake: Move up pipe mem free
      ASoC: Intel: Skylake: add wov as int sink
      ASoC: Intel: Skylake: Fix the dapm machine map

Yong Zhi (2):
      ASoc: Intel: boards: update ignore suspend for nau88l25_ssm4567 machi=
ne
      ASoc: Intel: boards: update constraints for nau88l25_ssm4567 machine

ZhengShunQian (2):
      ASoC: rk3036: Inno codec driver for RK3036 SoC
      ASoC: rk3036: Add binding doc of inno-rk3036 codec driver

Zidan Wang (10):
      ASoC: fsl_esai: ETDR and TX0~5 registers are non volatile
      ASoC: fsl-sai: add default register map for regmap cache
      ASoC: fsl_spdif: STL and STR registers are non volatile
      ASoC: fsl_ssi: using macro for default register map
      ASoC: fsl-sai: don't set bclk for Tx/Rx Synchronous with another SAI =
mode
      ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI master mode
      ASoC: fsl_sai: add tdm slots operation support
      ASoC: fsl: using params_width function to simplify code
      ASoC: fsl_sai: fix no frame clk in master mode
      ASoC: fsl_asrc: add support for 8-30kHz output sample rate

kbuild test robot (2):
      ASoC: rk3036: fix platform_no_drv_owner.cocci warnings
      ASoC: da7218: fix boolreturn.cocci warnings

 Documentation/devicetree/bindings/sound/ak4613.txt |   10 +
 .../devicetree/bindings/sound/atmel-classd.txt     |    6 +
 .../devicetree/bindings/sound/atmel-pdmic.txt      |   55 +
 Documentation/devicetree/bindings/sound/da7218.txt |  104 +
 Documentation/devicetree/bindings/sound/da7219.txt |    8 +-
 .../devicetree/bindings/sound/fsl,asrc.txt         |    5 +
 .../devicetree/bindings/sound/fsl,esai.txt         |    5 +
 .../devicetree/bindings/sound/fsl,spdif.txt        |    5 +
 .../devicetree/bindings/sound/img,i2s-in.txt       |   47 +
 .../devicetree/bindings/sound/img,i2s-out.txt      |   51 +
 .../devicetree/bindings/sound/img,parallel-out.txt |   44 +
 .../bindings/sound/img,pistachio-internal-dac.txt  |   18 +
 .../devicetree/bindings/sound/img,spdif-in.txt     |   41 +
 .../devicetree/bindings/sound/img,spdif-out.txt    |   44 +
 .../devicetree/bindings/sound/inno-rk3036.txt      |   20 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   82 +
 .../bindings/sound/renesas,rsrc-card.txt           |    4 +-
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    2 +
 Documentation/devicetree/bindings/sound/rt5616.txt |   26 +
 Documentation/devicetree/bindings/sound/rt5659.txt |   75 +
 Documentation/devicetree/bindings/sound/rt5677.txt |    2 +-
 .../devicetree/bindings/sound/sun4i-codec.txt      |    3 +
 .../devicetree/bindings/sound/ti,pcm3168a.txt      |   48 +
 .../devicetree/bindings/sound/wlf,wm8974.txt       |   15 +
 Documentation/sound/alsa/img,spdif-in.txt          |   49 +
 arch/arm/mach-s3c64xx/dev-audio.c                  |   47 +-
 arch/arm/mach-s3c64xx/include/mach/dma.h           |   52 +-
 arch/arm/plat-samsung/devs.c                       |   23 +-
 arch/x86/include/asm/platform_sst_audio.h          |    1 +
 drivers/dma/Kconfig                                |    2 +-
 include/linux/platform_data/asoc-s3c.h             |    8 +
 include/sound/ac97_codec.h                         |    3 +
 include/sound/da7218.h                             |  109 +
 include/sound/da7219.h                             |   14 +-
 include/sound/designware_i2s.h                     |    5 +
 include/sound/hdaudio_ext.h                        |    6 +
 include/sound/rt5659.h                             |   49 +
 include/sound/soc-dapm.h                           |    4 +
 include/sound/soc-topology.h                       |    6 +-
 include/sound/soc.h                                |   42 +-
 include/uapi/sound/asoc.h                          |    2 +-
 include/uapi/sound/compress_params.h               |    5 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-classd.c                     |   26 +-
 sound/soc/atmel/atmel-pdmic.c                      |  738 ++++
 sound/soc/atmel/atmel-pdmic.h                      |   80 +
 sound/soc/atmel/atmel_wm8904.c                     |    1 +
 sound/soc/codecs/Kconfig                           |   56 +-
 sound/soc/codecs/Makefile                          |   18 +
 sound/soc/codecs/ak4613.c                          |  118 +-
 sound/soc/codecs/arizona.c                         |  143 +-
 sound/soc/codecs/arizona.h                         |   17 +-
 sound/soc/codecs/cs47l24.c                         | 1148 ++++++
 sound/soc/codecs/cs47l24.h                         |   23 +
 sound/soc/codecs/da7218.c                          | 3314 +++++++++++++++
 sound/soc/codecs/da7218.h                          | 1414 +++++++
 sound/soc/codecs/da7219.c                          |   89 +-
 sound/soc/codecs/da7219.h                          |    9 -
 sound/soc/codecs/es8328.c                          |   25 +-
 sound/soc/codecs/es8328.h                          |    1 +
 sound/soc/codecs/hdac_hdmi.c                       |  659 +++
 sound/soc/codecs/inno_rk3036.c                     |  490 +++
 sound/soc/codecs/inno_rk3036.h                     |  123 +
 sound/soc/codecs/max98357a.c                       |   10 +
 sound/soc/codecs/pcm3168a-i2c.c                    |   66 +
 sound/soc/codecs/pcm3168a-spi.c                    |   65 +
 sound/soc/codecs/pcm3168a.c                        |  767 ++++
 sound/soc/codecs/pcm3168a.h                        |  100 +
 sound/soc/codecs/rt286.c                           |    6 +
 sound/soc/codecs/rt298.c                           |    2 -
 sound/soc/codecs/rt5616.c                          | 1381 +++++++
 sound/soc/codecs/rt5616.h                          | 1819 +++++++++
 sound/soc/codecs/rt5645.c                          |  292 +-
 sound/soc/codecs/rt5659.c                          | 4223 ++++++++++++++++=
++++
 sound/soc/codecs/rt5659.h                          | 1819 +++++++++
 sound/soc/codecs/rt5677.c                          |   13 +-
 sound/soc/codecs/sgtl5000.c                        |    1 +
 sound/soc/codecs/ssm2518.c                         |    2 +-
 sound/soc/codecs/wm5110.c                          |  206 +-
 sound/soc/codecs/wm8903.c                          |    2 +-
 sound/soc/codecs/wm8904.c                          |    2 +-
 sound/soc/codecs/wm8962.c                          |    3 +-
 sound/soc/codecs/wm8974.c                          |    8 +
 sound/soc/codecs/wm8998.c                          |   46 +-
 sound/soc/codecs/wm9713.c                          |  296 +-
 sound/soc/codecs/wm_adsp.c                         |  769 +++-
 sound/soc/codecs/wm_adsp.h                         |   23 +-
 sound/soc/davinci/davinci-mcasp.c                  |    4 +-
 sound/soc/dwc/designware_i2s.c                     |  113 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   21 +-
 sound/soc/fsl/fsl_asrc.c                           |   55 +-
 sound/soc/fsl/fsl_asrc.h                           |    2 +
 sound/soc/fsl/fsl_esai.c                           |   63 +-
 sound/soc/fsl/fsl_sai.c                            |  116 +-
 sound/soc/fsl/fsl_sai.h                            |    3 +
 sound/soc/fsl/fsl_spdif.c                          |   35 +-
 sound/soc/fsl/fsl_ssi.c                            |   25 +-
 sound/soc/fsl/imx-pcm-dma.c                        |    2 +
 sound/soc/fsl/imx-pcm-fiq.c                        |    4 +-
 sound/soc/fsl/imx-wm8962.c                         |   10 +-
 sound/soc/generic/simple-card.c                    |   12 +-
 sound/soc/img/Kconfig                              |   52 +
 sound/soc/img/Makefile                             |    7 +
 sound/soc/img/img-i2s-in.c                         |  516 +++
 sound/soc/img/img-i2s-out.c                        |  565 +++
 sound/soc/img/img-parallel-out.c                   |  327 ++
 sound/soc/img/img-spdif-in.c                       |  806 ++++
 sound/soc/img/img-spdif-out.c                      |  441 ++
 sound/soc/img/pistachio-internal-dac.c             |  287 ++
 sound/soc/intel/Kconfig                            |   46 +-
 sound/soc/intel/atom/sst-atom-controls.c           |    5 +-
 sound/soc/intel/atom/sst-atom-controls.h           |    1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   32 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   67 +-
 sound/soc/intel/atom/sst/sst_stream.c              |    2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |    2 +
 sound/soc/intel/boards/Makefile                    |    4 +
 sound/soc/intel/boards/bytcr_rt5640.c              |  241 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   19 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   19 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   19 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  485 +++
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  536 +++
 sound/soc/intel/boards/skl_rt286.c                 |  128 +-
 sound/soc/intel/common/Makefile                    |    7 +-
 sound/soc/intel/common/sst-acpi.c                  |   41 +-
 sound/soc/intel/common/sst-acpi.h                  |   33 +
 sound/soc/intel/common/sst-dsp-priv.h              |    8 +-
 sound/soc/intel/common/sst-dsp.c                   |    2 +-
 sound/soc/intel/common/sst-dsp.h                   |    2 +-
 sound/soc/intel/common/sst-firmware.c              |   20 +-
 sound/soc/intel/common/sst-match-acpi.c            |   43 +
 sound/soc/intel/haswell/sst-haswell-dsp.c          |    2 +-
 sound/soc/intel/haswell/sst-haswell-ipc.c          |   31 +-
 sound/soc/intel/skylake/skl-messages.c             |  280 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   19 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  256 +-
 sound/soc/intel/skylake/skl-sst-cldma.c            |   97 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |   21 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |  108 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |    9 +
 sound/soc/intel/skylake/skl-sst.c                  |  217 +-
 sound/soc/intel/skylake/skl-topology.c             |  658 ++-
 sound/soc/intel/skylake/skl-topology.h             |   63 +-
 sound/soc/intel/skylake/skl-tplg-interface.h       |  105 +-
 sound/soc/intel/skylake/skl.c                      |  158 +-
 sound/soc/intel/skylake/skl.h                      |    6 +-
 sound/soc/mediatek/mtk-afe-common.h                |    1 -
 sound/soc/mediatek/mtk-afe-pcm.c                   |   59 +-
 sound/soc/omap/omap-hdmi-audio.c                   |    2 +
 sound/soc/pxa/brownstone.c                         |    3 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    6 +-
 sound/soc/qcom/lpass-cpu.c                         |    1 +
 sound/soc/rockchip/rockchip_i2s.c                  |  130 +-
 sound/soc/rockchip/rockchip_max98090.c             |    6 +
 sound/soc/rockchip/rockchip_rt5645.c               |    6 +
 sound/soc/rockchip/rockchip_spdif.c                |    6 +-
 sound/soc/rockchip/rockchip_spdif.h                |    2 +-
 sound/soc/samsung/Kconfig                          |    2 -
 sound/soc/samsung/ac97.c                           |   29 +-
 sound/soc/samsung/bells.c                          |   40 +-
 sound/soc/samsung/dma.h                            |    6 +-
 sound/soc/samsung/dmaengine.c                      |   20 +-
 sound/soc/samsung/i2s.c                            |   31 +-
 sound/soc/samsung/littlemill.c                     |   32 +-
 sound/soc/samsung/odroidx2_max98090.c              |    9 +-
 sound/soc/samsung/pcm.c                            |   25 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   16 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   16 +-
 sound/soc/samsung/snow.c                           |    9 +-
 sound/soc/samsung/spdif.c                          |   17 +-
 sound/soc/samsung/speyside.c                       |   12 +-
 sound/soc/samsung/tobermory.c                      |   21 +-
 sound/soc/sh/Kconfig                               |    1 -
 sound/soc/sh/fsi.c                                 |   11 +-
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/adg.c                            |  118 +-
 sound/soc/sh/rcar/cmd.c                            |  171 +
 sound/soc/sh/rcar/core.c                           |  586 +--
 sound/soc/sh/rcar/ctu.c                            |   99 +-
 sound/soc/sh/rcar/dma.c                            |  245 +-
 sound/soc/sh/rcar/dvc.c                            |  273 +-
 sound/soc/sh/rcar/gen.c                            |  133 +-
 sound/soc/sh/rcar/mix.c                            |  158 +-
 sound/soc/sh/rcar/rcar_snd.h                       |  117 -
 sound/soc/sh/rcar/rsnd.h                           |  335 +-
 sound/soc/sh/rcar/rsrc-card.c                      |  129 +-
 sound/soc/sh/rcar/src.c                            |  898 ++---
 sound/soc/sh/rcar/ssi.c                            |  744 ++--
 sound/soc/sh/rcar/ssiu.c                           |  225 ++
 sound/soc/soc-ac97.c                               |  125 +
 sound/soc/soc-core.c                               |  602 ++-
 sound/soc/soc-dapm.c                               |   14 +-
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-pcm.c                                |   82 +-
 sound/soc/sti/uniperif_player.c                    |    3 +-
 sound/soc/sunxi/sun4i-codec.c                      |  279 +-
 sound/soc/tegra/tegra_alc5632.c                    |   12 +-
 sound/soc/tegra/tegra_wm8903.c                     |    3 +-
 202 files changed, 30532 insertions(+), 4175 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-out.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,parallel-ou=
t.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-i=
nternal-dac.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-out.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.txt
 create mode 100644 Documentation/sound/alsa/img,spdif-in.txt
 create mode 100644 include/sound/da7218.h
 create mode 100644 include/sound/rt5659.h
 create mode 100644 sound/soc/atmel/atmel-pdmic.c
 create mode 100644 sound/soc/atmel/atmel-pdmic.h
 create mode 100644 sound/soc/codecs/cs47l24.c
 create mode 100644 sound/soc/codecs/cs47l24.h
 create mode 100644 sound/soc/codecs/da7218.c
 create mode 100644 sound/soc/codecs/da7218.h
 create mode 100644 sound/soc/codecs/hdac_hdmi.c
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h
 create mode 100644 sound/soc/codecs/pcm3168a-i2c.c
 create mode 100644 sound/soc/codecs/pcm3168a-spi.c
 create mode 100644 sound/soc/codecs/pcm3168a.c
 create mode 100644 sound/soc/codecs/pcm3168a.h
 create mode 100644 sound/soc/codecs/rt5616.c
 create mode 100644 sound/soc/codecs/rt5616.h
 create mode 100644 sound/soc/codecs/rt5659.c
 create mode 100644 sound/soc/codecs/rt5659.h
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/img-i2s-in.c
 create mode 100644 sound/soc/img/img-i2s-out.c
 create mode 100644 sound/soc/img/img-parallel-out.c
 create mode 100644 sound/soc/img/img-spdif-in.c
 create mode 100644 sound/soc/img/img-spdif-out.c
 create mode 100644 sound/soc/img/pistachio-internal-dac.c
 create mode 100644 sound/soc/intel/boards/skl_nau88l25_max98357a.c
 create mode 100644 sound/soc/intel/boards/skl_nau88l25_ssm4567.c
 create mode 100644 sound/soc/intel/common/sst-acpi.h
 create mode 100644 sound/soc/intel/common/sst-match-acpi.c
 create mode 100644 sound/soc/sh/rcar/cmd.c
 delete mode 100644 sound/soc/sh/rcar/rcar_snd.h
 create mode 100644 sound/soc/sh/rcar/ssiu.c

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWee4fAAoJECTWi3JdVIfQIrUH/AmfnJuf/fBjXWRWrqIHTne9
tmCygYvascPryPPP9PfItA2TDgjjesUBIObF2QWxlah3Asw1v22aFUyMI77AiWdg
7AjUruFCKD/9Zxn6w/ieAdlZMOjfG1EX4HzdFebLHpGl54cf6XX/9iHHKRCMaClQ
37VfI0+nHa4ui/fnOiuduGuSZDWZzdp+TiqAuBq2YBHRjuPPxLcrGCuIs0uP5DSL
zak9he+anX10FxGOtbBciIAjE3y/bjMap+43u3oxZm+5K3gUbdQOCxWirgfL9vgz
R/1ikIsq7GCm1kW3yUs5f1JlyBrrRYH4jfsZ9zRPfXXvNUnkU0wAG2/husZKNQs=
=08+w
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--

--===============8097841874913796033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8097841874913796033==--
