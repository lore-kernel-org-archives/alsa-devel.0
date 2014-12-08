From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.19
Date: Mon, 8 Dec 2014 13:38:26 +0000
Message-ID: <20141208133826.GA11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6865744515795923269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB9B26044F
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 14:38:54 +0100 (CET)
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


--===============6865744515795923269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4Dl6XKrV7PH8SJF"
Content-Disposition: inline


--F4Dl6XKrV7PH8SJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b2776bf7149bddd1f4161f14f79520f17fc1d71d:

  Linux 3.18 (2014-12-07 14:21:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.19

for you to fetch changes up to 1810afd3e1ded09c53d4e966dddce3c7d484521f:

  Merge remote-tracking branches 'asoc/topic/wm9090', 'asoc/topic/wm9712' and 'asoc/topic/wm9713' into asoc-next (2014-12-08 13:12:36 +0000)

----------------------------------------------------------------
ASoC: Updates for v3.19

Lots and lots of changes this time around, the usual set of driver
updates and a huge bulk of cleanups from Lars-Peter.  Probably the most
interesting thing for most users is the Intel driver updates which will
(with some more machine integration work) enable support for newer x86
laptops.

 - Conversion of AC'97 drivers to use regmap, bringing us closer to the
   removal of the ASoC level I/O code.
 - Clean up a lot of old drivers that were open coding things that have
   subsequently been implemented in the core.
 - Some DAPM performance improvements.
 - Removal of the now seldom used CODEC mutex.
 - Lots of updates for the newer Intel SoC support, including support
   for the DSP and some Cherrytrail and Braswell machine drivers.
 - Support for Samsung boards using rt5631 as the CODEC.
 - Removal of the obsolete AFEB9260 machine driver.
 - Driver support for the TI TS3A227E headset driver used in some
   Chrombeooks.

----------------------------------------------------------------

My plan for the next cycle is to try to send one of these each time I
send fixes, I meant to do that this time around during the second half
of the cycle but ended up not sending fixes (or perhaps sending one lot
of fixes at the same time as I'd applied a bunch of changes I wanted to
cook in -next, can't remember exactly).

Alban Bedel (1):
      ASoC: tegra: Read and use the GPIO flags of the headphone detect

Alexandre Courbot (1):
      ASoC: jack: update calls to gpiod_get*()

Anatol Pomozov (4):
      ASoC: rt5677: Add option to configure gpio as floating/pullup/pulldown
      ASoC: rt5677: Print more information if setting DAI clock failed
      ASoC: rt5677: fix build when kernel compiled without GPIOLIB support
      ASoC: rt5677: add build dependency to spi

Andreas Ruprecht (1):
      ASoC: rockchip: i2s: Fix Kconfig for I2S device driver

Andrew Jackson (1):
      ASoC: dwc: Allocate resources with devm_ioremap_resource

Anil Kumar (1):
      ASoC: davinvi-mcasp: Balance pm_runtime_enable() on probe failure

Axel Lin (2):
      ASoC: cs4265: Remove unused *dev field from struct cs4265_private
      ASoC: cs4271: Split SPI and I2C code into different modules

Bard Liao (14):
      ASoC: rt286: reduce power consumption
      ASoC: rt5645: make bias level more reasonale
      ASoC: rt286: set combo jack by dmi
      ASoC: rt286: fix comment style
      ASoC: rt5645: Add JD function support
      ASoC: rt5645: Add ASRC support
      ASoC: rt5670: add rt5672 codec support
      ASoC: rt5645: remove unused rt5645_clk_sel_put
      ASoC: rt5645: add register setting for TDM
      ASoC: rt5645: two jacks for hp and mic
      ASoC: rt5670: make bias level more reasonable
      ASoC: rt5645: multiple JD mode support
      ASoC: rt5670: check if asrc is useable
      ASoC: rt5670: add DMIC ASRC support

Ben Zhang (2):
      ASoC: rt5677: Include gpio driver header
      ASoC: rt5677: fix rt5677 spi driver build

Charles Keepax (3):
      ASoC: arizona: Add support for 768kHz DMIC operation
      ASoC: wm_adsp: Use vmalloc to allocate firmware download buffer
      ASoC: wm_adsp: Move core_ena to be co-located with start bit

Dan Carpenter (1):
      ASoC: sigmadsp: uninitialized variable in sigmadsp_activate_ctrl()

Daniel Mack (1):
      ASoC: soc-compress: consolidate two identical branches

Dmitry Eremin-Solenikov (3):
      ARM: pxa: spitz: register spitz-audio device
      ASoC: pxa: Convert spitz to use snd_soc_register_card()
      ASoC: pxa: prepare/unprepare clocks in pxa-ssp

Dylan Reid (3):
      ASoC: max98090: Different comp tables for different pclks
      ASoC: add TI ts3a227e headset chip driver
      ASoC: rt5677: make volume TLV closer to reality

Fabio Estevam (15):
      ASoC: fsl: imx-wm8962: Delete unneeded test before of_node_put
      ASoC: fsl: imx-sgtl5000: Delete unneeded test before of_node_put
      ASoC: fsl: imx-spdif: Delete unneeded test before of_node_put
      ASoC: fsl: eukrea-tlv320: Delete unneeded test before of_node_put
      ASoC: sgtl5000: Cleanup the comments
      ASoC: simple-card: Delete unneeded test before of_node_put
      ASoC: sgtl5000: Use the preferred form for passing a size of a struct
      ASoC: wm8962: Use the preferred form for passing a size of a struct
      ASoC: wm8731: Use the preferred form for passing a size of a struct
      ASoC: mxs: mxs-saif: Register the irq with the device name
      ASoC: fsl_ssi: Remove comment about SSI running only in slave mode
      ASoC: sgtl5000: Remove MCLK restriction
      ASoC: sgtl5000: Allow 8kHz playback in codec slave mode
      ASoC: mxs-sgtl5000: Remove MCLK restriction
      ASoC: fsl_ssi: Fix module unbound

Fang, Yang A (1):
      ASoC: Intel: use correct firmware name

Fengguang Wu (1):
      ASoC: Intel: mrfld: fix semicolon.cocci warnings

Geert Uytterhoeven (2):
      ASoC: sh: fsi: Document SoC-specific bindings
      ASoC: rsnd: Document SoC-specific bindings

JS Park (1):
      ASoC: wm_adsp: Fix memory leak in wm_adsp_setup_algs

Jarkko Nikula (3):
      ASoC: max98090: Fix digital microphone
      ASoC: max98090: Fix ill-defined sidetone route
      ASoC: max98090: Fix right sidetone connection

Jean-Francois Moine (4):
      ASoC: simple-card: Remove useless casts
      ASoC: core: add multi-codec support in DT
      ASoC: simple-card: Remove useless function argument
      ASoC: Remove 'const' from the device_node pointers

Jean-Michel Hautbois (2):
      ASoC: sgtl5000: Add MicBias resistor support in DT
      ASoC: sgtl5000: Add MicBias voltage support

Jiada Wang (1):
      ASoC: fsl_ssi: fix error path in probe

Jianqun (2):
      ASoC: rockchip: i2s: add text after tristate for SND_SOC_ROCKCHIP_I2S
      ASoC: simple-card: add "invert" property for detect GPIOs

Jie Yang (9):
      ASoC: Intel: Fix block is enabled multiple times issue
      ASoC: Intel: Work around to fix HW D3 potential crash issue
      ASoC: Intel: Add jack detection for Broadwell
      ASoC: Intel: Correct a macro for FW message
      ASoC: Intel: Fix the driver data not set issue
      ASoC: Intel: Fix stream volume set no effect issue on Broadwell
      ASoC: Intel: Remove useless loopback volume control for Broadwell
      ASoC: Intel: Correct the xmax volume
      ASoC: Intel: Move capture PCM pin to PCM0 for Broadwell/Haswell

Jyri Sarha (3):
      ASoC: hdmi: Mark the maximum significant bits to HDMI codec
      ASoC: hdmi: HDMI codec doesn't benefit from pmdown delay
      ASoC: tlv320aic31xx: Fix off by one error in the loop stucture.

Krishna Mohan Dani (5):
      ASoC: rt5631: Add device tree binding documentation
      ASoC: rt5631: Adding the description of the codec
      ASoC: rt5631: Adding Device Tree compatibility to Realtek's ALC5631/RT5631 codec driver
      ASoC: rt5631: Fixing compilation warning when DT is disabled
      ASoC: Samsung: Add arndale_rt5631 machine driver and binding

Kuninori Morimoto (30):
      ASoC: rsnd: tidyup debug information when read/write
      ASoC: rsnd: tidyup RSND_DVC_VOLUME_NUM to RSND_DVC_CHANNELS
      ASoC: rsnd: add struct rsnd_dvc_cfg and control DVC settings
      ASoC: simple-card: add asoc_simple_card_parse_daifmt()
      ASoC: rsnd: control DVC_DVUCR under rsnd_dvc_volume_update()
      ASoC: rsnd: move DVC_DVUER settings under rsnd_dvc_volume_update()
      ASoC: rsnd: enable multiple DVC valume settings
      ASoC: rsnd: enable single DVC valume settings
      ASoC: rsnd: enable enumerated DVC valume settings
      ASoC: rsnd: tidyup debug message format and timing
      ASoC: rsnd: fallback to PIO mode if DMA mode was failed
      ASoC: rsnd: Add Volume Ramp support
      ASoC: rsnd: add .fallback callback
      ASoC: rsnd: add callback status check method
      ASoC: rsnd: rsnd_src_ssiu_stop() stops SSIU compulsorily
      ASoC: rsnd: tidyup PIO/DMA mode settings method
      ASoC: rsnd: tidyup SSI interrupt enable/disable method
      ASoC: rsnd: care SSIWSR register in rsnd_ssi_hw_start()
      ASoC: rsnd: clear status register when HW start
      ASoC: rsnd: synchronize SSI start/stop sequence between PIO/DMA mode
      ASoC: rsnd: show master clock rate when ADG probe
      ASoC: rsnd: move snd_kcontrol_new fucntions to core.c
      ASoC: rsnd: tidyup rsnd_io_to_runtime() macro
      ASoC: rsnd: use rsnd_src_convert_rate() once on rsnd_src_set_convert_rate_gen2()
      ASoC: rsnd: initialize SRC on rsnd_src_init()
      ASoC: rsnd: set SRC_ROUTE_MODE0 on each rsnd_src_set_convert_rate()
      ASoC: rsnd: share SSI starting method between PIO/DMA mode
      ASoC: rsnd: remove un-necessary parameter from rsnd_src_start/stop()
      ASoC: rsnd: add salvage support for under/over flow error on SSI
      ASoC: rsnd: rename SSI function name of PIO

Lars-Peter Clausen (145):
      ASoC: ak4535: Cleanup manual bias level transitions
      ASoC: ak4535: Use table based setup for controls
      ASoC: ak4641: Cleanup manual bias level transitions
      ASoC: ak4642: Cleanup manual bias level transitions
      ASoC: ak4671: Cleanup manual bias level transitions
      ASoC: max98088: Cleanup manual bias level transitions
      ASoC: max98095: Cleanup manual bias level transitions
      ASoC: max9850: Cleanup manual bias level transitions
      ASoC: sta32x: Cleanup manual bias level transitions
      ASoC: sta350: Cleanup manual bias level transitions
      ASoC: sta529: Cleanup manual bias level transitions
      ASoC: stac9766: Cleanup manual bias level transitions
      ASoC: dapm: Reduce number of checked paths in dapm_widget_in_card_paths()
      ASoC: dapm: Remove always true path source/sink checks
      ASoC: dapm: Remove special DAI widget power check functions
      ASoC: dapm: Remove path 'walked' flag
      ASoC: dapm: Only mark paths dirty when the connection status changed
      ASoC: dapm: Do not add un-muxed paths to MUX control
      ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets
      ASoC: dapm: Introduce toplevel widget categories
      ASoC: dapm: Add a flag to mark paths connected to supply widgets
      ASoC: dapm: Mark endpoints instead of IO widgets dirty during suspend/resume
      ASoC: dapm: Add a few supply widget sanity checks
      ASoC: dapm: Use more aggressive caching
      ASoC: Use generic control handlers for S8 control
      ASoC: ad1980: Remove unused header
      ASoC: ad1980: Cleanup printk usage
      ASoC: ad1980: Use table based control setup
      ASoC: stac9766: Cleanup printk usage
      ASoC: stac9766: Use table based control setup
      ASoC: wm9705: Cleanup printk usage
      ASoC: wm9705: Use table based control setup
      ASoC: wm9712: Cleanup printk usage
      ASoC: wm9712: Use table based control setup
      ASoC: wm9713: Cleanup printk usage
      ASoC: wm9713: Use table based control setup
      ASoC: wm9713: Move driver state struct allocation to driver probe
      ASoC: wm9713: Use virtual control instead of virtual register
      ASoC: Remove snd_soc_platform_driver suspend/resume callbacks
      ASoC: Remove platform field from snd_soc_dai
      ASoC: mioa701_wm9713: Don't opencode CODEC register access
      ASoC: Remove card field from snd_soc_dai struct
      ASoC: Consolidate CPU and CODEC DAI probe
      ASoC: sn95031: Use table based control setup
      ASoC: tas2552: Use table based DAPM setup
      ASoC: wl1273: Use table based control setup
      ASoC: wm8737: Use table based DAPM and control setup
      ASoC: wm8961: Use table based DAPM and control setup
      ASoC: wm8995: Use table based DAPM and control setup
      ASoC: ad193x: Keep DAC output stage active in idle
      ASoC: ssm4567: Add DAC high-pass-filter control
      ASoC: ssm4567: Add support for setting the DAI format and TDM configuration
      ASoC: ssm4567: Add support for disabling the boost stage
      ASoC: wm9712/wm9713: Replace virtual registers with custom put/get callbacks
      ASoC: Forward calls to snd_soc_cache_sync() to regcache_sync()
      ASoC: Remove snd_soc_cache_sync() implementation
      ASoC: ab8500-codec: Move control lock to the driver level
      ASoC: max98095: Move mutex to the driver level
      ASoC: wm5102: Move ultrasonic response settings lock to the driver level
      ASoC: wm8731: Move the deemph lock to the driver level
      ASoC: wm8903: Move the deemph lock to the driver level
      ASoC: wm8958: Move DSP firmware lock to driver level
      ASoC: wm8962: Move DSP enable lock to the driver level
      ASoC: Remove CODEC mutex
      ASoC: adav80x: Replace w->codec with snd_soc_dapm_to_codec(w->dapm)
      ASoC: adau1373: Replace w->codec with snd_soc_dapm_to_codec(w->dapm)
      ASoC: adau17x1: Replace w->codec with snd_soc_dapm_to_codec(w->dapm)
      ASoC: mpc5200_psc_ac97: Remove unused on-stack snd_ac97 device
      ASoC: mpc5200_dma: Don't overwrite ac97 device private_data
      ASoC: Properly handle AC'97 device lifetime management
      ASoC: Move AC'97 support to its own file
      ASoC: ac97: Use static ac97_bus
      ASoC: ac97: Merge soc_ac97_dev_{un,}register()/soc_{un,}register_ac97_codec()
      ASoC: ac97: Drop support for setting platform data via the CPU DAI
      ASoC: ac97: Drop delayed device registration
      ASoC: Drop ac97_control initialization from CODEC driver DAIs
      ASoC: Rename snd_soc_dai_driver struct ac97_control field to bus_control
      ASoC: ac97: Push snd_ac97 pointer to the driver level
      ASoC: Add helper functions for deferred regmap setup
      ASoC: ad1980: Convert to regmap
      ASoC: ad1980: Remove ac97_read/ac97_write wrappers
      ASoC: sigmadsp: Refuse to load firmware files with a non-supported version
      ASoC: sigmadsp: Drop support support SIGMA_ACTION_DELAY
      ASoC: sigmadsp: Restructure in preparation for fw v2 support
      ASoC: sigmadsp: Add support for fw v2
      ASoC: adau1701: Implement sigmadsp safeload
      ASoC: sirf-audio-codec: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: max98088: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: max98090: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: max98095: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: adau17x1: Mark DSP parameter memory as readable and precious
      ASoC: sigmadsp: Fix endianness conversion
      ASoC: cs42l51: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: cs42l73: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
      ASoC: uda134x: Remove is_powered_on_standby from platform data
      ASoC: uda134x: Cleanup manual bias level transitions
      ASoC: uda1380: Cleanup manual bias level transitions
      ASoC: alc5623: Cleanup bias level transitions
      ASoC: alc5632: Cleanup bias level transitions
      ASoC: rt5631: Cleanup bias level transitions
      ASoC: wm8350: Cleanup manual bias level transitions
      ASoC: wm8400: Cleanup manual bias level transitions
      ASoC: wm8510: Cleanup manual bias level transitions
      ASoC: wm8523: Cleanup manual bias level transitions
      ASoC: wm8580: Cleanup manual bias level transitions
      ASoC: wm8711: Cleanup manual bias level transitions
      ASoC: wm8728: Cleanup manual bias level transitions
      ASoC: wm8731: Cleanup manual bias level transitions
      ASoC: wm8737: Cleanup manual bias level transitions
      ASoC: wm8750: Cleanup manual bias level transitions
      ASoC: wm8776: Cleanup manual bias level transitions
      ASoC: wm8804: Cleanup manual bias level transitions
      ASoC: wm8900: Cleanup manual bias level transitions
      ASoC: wm8903: Cleanup manual bias level transitions
      ASoC: wm8940: Cleanup manual bias level transitions
      ASoC: wm8955: Cleanup manual bias level transitions
      ASoC: wm8960: Cleanup manual bias level transitions
      ASoC: wm8961: Cleanup manual bias level transitions
      ASoC: wm8983: Cleanup manual bias level transitions
      ASoC: wm8978: Cleanup manual bias level transitions
      ASoC: wm8974: Cleanup manual bias level transitions
      ASoC: wm8985: Cleanup manual bias level transitions
      ASoC: wm8988: Cleanup manual bias level transitions
      ASoC: wm8990: Cleanup manual bias level transitions
      ASoC: wm8991: Cleanup manual bias level transitions
      ASoC: wm8993: Cleanup manual bias level transitions
      ASoC: wm8994: Cleanup manual bias level transitions
      ASoC: wm8995: Cleanup manual bias level transitions
      ASoC: wm9081: Cleanup manual bias level transitions
      ASoC: wm9090: Cleanup manual bias level transitions
      ASoC: wm9712: Cleanup manual bias level transitions
      ASoC: wm9713: Cleanup manual bias level transitions
      ASoC: qi_lb60: Pass flags to gpiod_get()
      ASoC: Disable regmap helpers if regmap is disabled
      ASoC: cq93vc: Remove unused state struct
      ASoC: cq93vc: Cleanup manual bias level transitions
      ASoC: lm49453: Cleanup manual bias level transitions
      ASoC: sn95031: Cleanup bias level transitions
      ASoC: tlv320aic23: Cleanup manual bias level transitions
      ASoC: tlv320aix31xx: Cleanup manual bias level transitions
      ASoC: tlv320aic32x4: Cleanup manual bias level transitions
      ASoC: tlv320aic3x: Cleanup manual bias level transitions
      ASoC: tlv320dac33: Cleanup manual bias level transitions
      ASoC: twl4030: Cleanup manual bias level transitions
      ASoC: twl6040: Cleanup manual bias level transitions

Liam Girdwood (11):
      ASoC: Intel: Add TDM support to HSW/BDW SSP port
      ASoC: Intel: Add 4 channel support to DSP.
      ASoC: Intel: Make HSW/BDW pointer debug verbose
      ASoC: Intel: Make ADSP memory block allocation more generic
      ASoC: Intel: Add generic support for DSP wake, sleep and stall
      ASoC: Intel: Add PM support to the HSW/BDW DSP core.
      ASoC: Intel: Add PM support to HSW/BDW IPC driver
      ASoC: Intel: Add PM support to HSW/BDW PCM driver
      ASoC: Intel: Add debug output when boot fails.
      ASoC: Intel: fix build with runtime PM disabled.
      ASoC: Intel: Fix build with CONFIG_SLEEP enabled.

Mark Brown (46):
      Merge branch 'fix/sgtl5000' of git://git.kernel.org/.../broonie/sound into asoc-sgtl5000
      Merge tag 'v3.18-rc2' into asoc-sgtl5000
      ASoC: Intel: Add dependency on DesignWare DMA controller
      ASoC: core: Split ops out of soc-core.c
      Merge tag 'v3.18-rc3' into asoc-sgtl5000
      Merge branch 'topic/dapm' of git://git.kernel.org/.../broonie/sound into asoc-core
      Merge branch 'fix/max98090' of git://git.kernel.org/.../broonie/sound into asoc-max98090
      Merge branches 'topic/wm9712' and 'topic/wm9713' of git://git.kernel.org/.../broonie/sound into asoc-wm971x
      Merge branch 'fix/davinci' of git://git.kernel.org/.../broonie/sound into asoc-davinci
      Merge branches 'topic/ad1980', 'topic/wm9705' and 'topic/wm971x' of git://git.kernel.org/.../broonie/sound into asoc-ac97
      regmap: ac97: Add generic AC'97 callbacks
      Merge branch 'topic/ac97' of git://git.kernel.org/.../broonie/regmap into asoc-ac97
      Merge branch 'topic/regmap' of git://git.kernel.org/.../broonie/sound into asoc-ac97
      ASoC: samsung: Fix error handling for clock lookup
      ASoC: samsung: Fix non-DT use of I2S controller
      ASoC: wm5102: Initialize dac_comp_lock mutex
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adsp', 'asoc/fix/davinci', 'asoc/fix/max98090', 'asoc/fix/sigmadsp' and 'asoc/fix/tlv320aic31xx' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/cache' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl-esai' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ac97', 'asoc/topic/ad193x', 'asoc/topic/adau1373' and 'asoc/topic/adau17x1' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adav80x', 'asoc/topic/adsp', 'asoc/topic/ak4535', 'asoc/topic/ak4641' and 'asoc/topic/ak4642' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4671', 'asoc/topic/alc5623', 'asoc/topic/alc5632', 'asoc/topic/arizona' and 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branches 'asoc/topic/codec-mutex', 'asoc/topic/compress' and 'asoc/topic/cq93vc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs4265', 'asoc/topic/cs4271', 'asoc/topic/cs42l51' and 'asoc/topic/cs42l73' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/doc', 'asoc/topic/dpcm', 'asoc/topic/dwc' and 'asoc/topic/fsi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl', 'asoc/topic/fsl-card', 'asoc/topic/fsl-dt' and 'asoc/topic/fsl-ssi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hdmi', 'asoc/topic/intel', 'asoc/topic/jack', 'asoc/topic/jz4740' and 'asoc/topic/lm49453' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98088', 'asoc/topic/max98090', 'asoc/topic/max98095', 'asoc/topic/max9850' and 'asoc/topic/mop500' into asoc-next
      Merge remote-tracking branches 'asoc/topic/multi-codec', 'asoc/topic/mxs-saif', 'asoc/topic/mxs-sgtl5000', 'asoc/topic/omap' and 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rcar', 'asoc/topic/rockchip', 'asoc/topic/rt286' and 'asoc/topic/rt5631' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/rt5670', 'asoc/topic/rt5677', 'asoc/topic/samsung' and 'asoc/topic/sgtl5000' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sh', 'asoc/topic/sigmadsp', 'asoc/topic/simple', 'asoc/topic/sirf' and 'asoc/topic/sn95031' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ssm4567', 'asoc/topic/sta32x', 'asoc/topic/sta350', 'asoc/topic/sta529' and 'asoc/topic/stac9766' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas2552', 'asoc/topic/tegra', 'asoc/topic/tfa9879', 'asoc/topic/tlv320aic23' and 'asoc/topic/tlv320aic31xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320aic32x4', 'asoc/topic/tlv320aic3x', 'asoc/topic/tlv320dac33', 'asoc/topic/ts3a227e' and 'asoc/topic/twl4030' into asoc-next
      Merge remote-tracking branches 'asoc/topic/twl6040', 'asoc/topic/uda134x', 'asoc/topic/uda1380' and 'asoc/topic/wl1273' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8350', 'asoc/topic/wm8400', 'asoc/topic/wm8510', 'asoc/topic/wm8523' and 'asoc/topic/wm8580' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8711', 'asoc/topic/wm8728', 'asoc/topic/wm8731', 'asoc/topic/wm8737' and 'asoc/topic/wm8750' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8776', 'asoc/topic/wm8804', 'asoc/topic/wm8900', 'asoc/topic/wm8903' and 'asoc/topic/wm8940' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8955', 'asoc/topic/wm8960', 'asoc/topic/wm8961', 'asoc/topic/wm8962' and 'asoc/topic/wm8974' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8978', 'asoc/topic/wm8983', 'asoc/topic/wm8985', 'asoc/topic/wm8988' and 'asoc/topic/wm8990' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8991', 'asoc/topic/wm8993', 'asoc/topic/wm8994', 'asoc/topic/wm8995' and 'asoc/topic/wm9081' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm9090', 'asoc/topic/wm9712' and 'asoc/topic/wm9713' into asoc-next

Markus Elfring (3):
      ASoC: omap-mcbsp: Deletion of an unnecessary check before the function call "kfree"
      ASoC: fsi: Deletion of unnecessary checks before the function call "clk_disable"
      ASoC: mop500: Deletion of unnecessary checks before the function call "of_node_put"

Masanari Iida (1):
      ASoC: jack: Fix warning while make htmldocs caused by soc-jack.c

Max Filippov (2):
      ASoC: tlv320aic23: make codecs selectable in Kconfig
      ASoC: tlv320aic23: add dependencies on I2C/SPI_MASTER

Mengdong Lin (4):
      ASoC: rt5670 : Add ACPI match ID for Intel CHT/BSW platforms
      ASoC: Intel: add missing ACPI device table
      ASoC: Intel: Add Cherrytrail & Braswell machine driver cht_bsw_rt5672
      ASoC: Intel: add support for Cherrytrail and Braswell in SST driver

Misael Lopez Cruz (3):
      ASoC: davinci-mcasp: Active slots depend on active serializers
      ASoC: tlv320aic3x: Add output driver pop reduction controls
      ASoC: davinci-mcasp: Add overrun/underrun event handling

Mythri P K (1):
      ASoC: Intel: use lock when changing SST state.

Nicolas Ferre (2):
      ASoC: snd-soc-afeb9260: delete driver as board has just been removed
      ASoC: Kconfig: remove not used SND_AT91_SOC_AFEB9260 option

Nicolin Chen (11):
      ASoC: fsl_esai: Add indentation for binding doc to increase readability
      ASoC: fsl_spdif: Add indentation for binding doc to increase readability
      ASoC: fsl_sai: Add indentation for binding doc to increase readability
      ASoC: eukrea-tlv320: Add indentation for binding doc to increase readability
      ASoC: imx-audmux: Add indentation for binding doc to increase readability
      ASoC: imx-sgtl5000: Add indentation for binding doc to increase readability
      ASoC: imx-spdif: Add indentation for binding doc to increase readability
      ASoC: imx-wm8962: Add indentation for binding doc to increase readability
      ASoC: fsl-asoc-card: Don't bypass settings if cpu-dai is Master
      ASoC: fsl_esai: Use dynamic slot width as default
      ASoC: fsl-asoc-card: Add slot_width setting for cpu-dai

Oder Chiou (12):
      ASoC: rt5645: Add the workqueue of the jack detect function for the debouncing
      ASoC: rt5677: Support DSP function for VAD application
      ASoC: rt5677: add GPIO IRQ support
      ASoC: rt5677: Add TDM channel mapping function
      ASoC: rt5677: Minor coding style and typo fix
      ASoC: rt5677: Use specific r/w function for DSP mode
      ASoC: rt5677: Add TDM channel mux in DAC side of IF1 and IF2
      ASoC: rt5677: Modify the default value of the MX-8E[4] for ASRC function
      ASoC: rt5677: Align the reg_default table with tab character
      ASoC: rt5677: Follow the gpio naming rule to rename the irq function
      ASoC: rt5677: Set the slow charge of the vref in the end of the power sequences
      ASoC: rt5677: Fix the issue that the regmap_range "rt5677_ranges" cannot be accessed

Padmavathi Venna (3):
      ASoC: Samsung: Add quirk for internal DMA
      ASoC: samsung: add support for exynos7 I2S controller
      ASoC: samsung: ASoC: samsung: Fix IISMOD setting in i2s_set_sysclk()

Pavel Machek (1):
      ASoC: omap: enable sound support on n900 on devicetree-based boot

Peter Rosin (3):
      ASoC: atmel_ssc_dai: Match the CMR divider only in full duplex.
      ASoC: tfa9879: New driver for NXP Semiconductors TFA9879 amplifier.
      ASoC: Augment existing card DAPM routes in snd_soc_of_parse_audio_routing

Peter Ujfalusi (10):
      ASoC: davinci-mcasp: Correct TX start sequence
      ASoC: davinci-mcasp: Correct RX start sequence
      ASoC: davinci-mcasp: When stopping TX/RX stop the AFIFO as the last step
      ASoC: davinci-mcasp: Move the AFIFO related code under start_tx/rx functions
      ASoC: tlv320aic3x: Add TDM support
      ASoC: davinci-mcasp: Symmetric sample bits for IIS mode
      ASoC: davinci-mcasp: Fix rx format when more bclk is used on the bus
      ASoC: davinci-mcasp: Validate tdm_slots parameter at probe time
      ASoC: davinci-mcasp: Place constraint on number of channels
      ASoC: tlv320aic3x: Convert SOC_ENUM_SINGLE/DOUBLE arrays to individual

Qiao Zhou (2):
      ASoC: soc-pcm: skip dpcm path checking with incapable/unready FE
      ASoC: soc-pcm: do not hw_free BE if it's still used

Ramesh Babu (1):
      ASoC: core: Call mute for cpu dais as well

Randy Dunlap (1):
      ASoC: cs42l51: depends on I2C

Rasmus Villemoes (1):
      ASoC: dapm: Remove redundant cast

Ricardo Neri (2):
      ASoC: Intel: Add new dependency for Broadwell machine
      ASoC: Intel: Add new dependency for Haswell machine

Richard Fitzgerald (1):
      ASoC: arizona: Add DSP_B and LEFT_J mode support

Subhransu S. Prusty (12):
      ASoC: Intel: mrfld: Replace pci_id with unique device id
      ASoC: Intel: mrfld - Define ipc_info structure
      ASoC: Intel: mrfld: Define sst_res_info for acpi
      ASoC: Intel: mrfld: Fix runtime pm calls in sst_open_pcm_stream
      ASoC: mfld-compress: implement .power callback
      ASoC: Intel: mfld-pcm: Fix to Store device context in sst_data
      ASoC: Intel: move the driver wq init to a routine
      ASoC: Intel: move the lock and wq initialization to routine
      ASoC: Intel: move the driver context allocation to routine
      ASoC: Intel: modularize driver probe and remove
      ASoC: Intel: more probe modularization for sst
      ASoC: Intel: add BYTCR machine driver with RT5640

Sudip Mukherjee (2):
      ASoC: Intel: fix missing mutex
      ASoC: rt286: build warning of section mismatch

Takashi Iwai (2):
      ASoC: eukrea-tlv320: Fix of_node_put() call with uninitialized object
      ASoC: core: Use snd_ctl_enum_info()

Thomas Petazzoni (1):
      ASoC: cs42l51: make driver user-selectable

Vinod Koul (27):
      ASoC: Intel: mrfld: add the gain controls
      ASoC: Intel: mrfld: add DSP core controls
      ASoC: Intel: mrfld: add the DSP DAPM widgets
      ASoC: Intel: mfld-pcm: add FE and BE ops
      ASoC: Intel: mrfld: add the DSP mixers
      ASoC: intel: turn off COMPILE_TEST for medfield
      ASoC: Intel: mrfld - add the dsp sst driver
      ASoC: Intel: mrfld - Add DSP load and management
      ASoC: Intel: sst - add pcm ops handling
      ASoC: Intel: sst: Add IPC handling
      ASoC: Intel: sst: add stream operations
      ASoC: Intel: sst: Add some helper functions
      ASoC: Intel: sst: Add makefile and kconfig changes
      ASoC: intel: use __iowrite32_copy for 32 bit copy
      ASoC: intel: log an error on double free
      ASoC: intel: fix the kernldoc comment
      ASoC: intel: explain why block not found isn't error always
      ASoC: intel: use __iowrite32_copy for 32 bit copy
      ASoC: Intel: sst: add runtime power management handling
      ASoC: Intel: sst: load firmware using async callback
      ASoC: Intel: sst - add compressed ops handling
      ASoC: Intel: mrfld - remove unnecessary check for pointer
      ASoC: Intel: mrfld - create separate module for pci part
      ASoC: Intel: mrfld - add shim save restore
      ASoC: Intel: mrfld - remove non static definition
      ASoC: Intel: mrfld- add ACPI module
      ASoC: Intel: cleanup runtime_pm initialization

Zidan Wang (2):
      ASoC: wm8960: Add device tree support
      ASoC: wm8960: Move register initialisation to I2C driver probe()

kbuild test robot (5):
      ASoC: rt5677: rt5677_irq_init() can be static
      ASoC: Intel: dw_pdata can be static
      ASoC: Intel: byt_rvp_platform_data can be static
      ASoC: Intel: chv_platform_data can be static
      ASoC: sigmadsp: fix simple_return.cocci warnings

 .../devicetree/bindings/sound/arndale.txt          |   24 +
 .../bindings/sound/davinci-mcasp-audio.txt         |    2 +-
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   15 +-
 .../devicetree/bindings/sound/fsl,esai.txt         |   44 +-
 .../devicetree/bindings/sound/fsl,spdif.txt        |   37 +-
 .../devicetree/bindings/sound/fsl-sai.txt          |   66 +-
 .../bindings/sound/imx-audio-sgtl5000.txt          |   61 +-
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   22 +-
 .../devicetree/bindings/sound/imx-audio-wm8962.txt |   45 +-
 .../devicetree/bindings/sound/imx-audmux.txt       |   22 +-
 .../devicetree/bindings/sound/max98090.txt         |    2 +
 .../devicetree/bindings/sound/renesas,fsi.txt      |    9 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   10 +-
 Documentation/devicetree/bindings/sound/rt5631.txt |   48 +
 Documentation/devicetree/bindings/sound/rt5677.txt |   17 +
 .../devicetree/bindings/sound/samsung-i2s.txt      |   15 +-
 .../devicetree/bindings/sound/sgtl5000.txt         |   13 +
 .../devicetree/bindings/sound/ts3a227e.txt         |   26 +
 Documentation/devicetree/bindings/sound/wm8960.txt |   31 +
 MAINTAINERS                                        |    6 +
 arch/arm/mach-pxa/spitz.c                          |    9 +
 arch/x86/include/asm/platform_sst_audio.h          |   62 +
 drivers/base/regmap/Kconfig                        |    5 +-
 drivers/base/regmap/Makefile                       |    1 +
 drivers/base/regmap/regmap-ac97.c                  |  114 ++
 include/linux/mfd/arizona/core.h                   |    1 +
 include/linux/mfd/davinci_voicecodec.h             |    7 -
 include/linux/platform_data/asoc-s3c.h             |    1 +
 include/linux/regmap.h                             |    7 +
 include/sound/rcar_snd.h                           |    8 +-
 include/sound/rt5645.h                             |    4 +
 include/sound/rt5677.h                             |   10 +
 include/sound/soc-dai.h                            |    7 +-
 include/sound/soc-dapm.h                           |    9 +-
 include/sound/soc.h                                |  116 +-
 include/sound/uda134x.h                            |   12 -
 include/trace/events/asoc.h                        |   25 -
 sound/soc/Makefile                                 |    6 +-
 sound/soc/atmel/Kconfig                            |    9 -
 sound/soc/atmel/Makefile                           |    1 -
 sound/soc/atmel/atmel_ssc_dai.c                    |    5 +-
 sound/soc/atmel/snd-soc-afeb9260.c                 |  151 --
 sound/soc/au1x/ac97c.c                             |    2 +-
 sound/soc/au1x/psc-ac97.c                          |    2 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |    2 +-
 sound/soc/blackfin/bf5xx-ad1980.c                  |    2 -
 sound/soc/cirrus/Kconfig                           |    3 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |    2 +-
 sound/soc/codecs/Kconfig                           |   47 +-
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/ab8500-codec.c                    |   32 +-
 sound/soc/codecs/ac97.c                            |   18 +-
 sound/soc/codecs/ad193x.c                          |   14 +-
 sound/soc/codecs/ad1980.c                          |  212 +--
 sound/soc/codecs/ad1980.h                          |   26 -
 sound/soc/codecs/adau1373.c                        |    6 +-
 sound/soc/codecs/adau1701.c                        |   86 +-
 sound/soc/codecs/adau1761.c                        |   25 +-
 sound/soc/codecs/adau1781.c                        |   33 +-
 sound/soc/codecs/adau17x1.c                        |   71 +-
 sound/soc/codecs/adau17x1.h                        |   10 +-
 sound/soc/codecs/adav80x.c                         |    4 +-
 sound/soc/codecs/ak4535.c                          |   31 +-
 sound/soc/codecs/ak4641.c                          |   33 +-
 sound/soc/codecs/ak4642.c                          |   16 -
 sound/soc/codecs/ak4671.c                          |   13 -
 sound/soc/codecs/alc5623.c                         |   22 +-
 sound/soc/codecs/alc5632.c                         |   22 +-
 sound/soc/codecs/arizona.c                         |   34 +-
 sound/soc/codecs/cq93vc.c                          |   33 -
 sound/soc/codecs/cs4265.c                          |    2 -
 sound/soc/codecs/cs4271-i2c.c                      |   62 +
 sound/soc/codecs/cs4271-spi.c                      |   55 +
 sound/soc/codecs/cs4271.c                          |  155 +-
 sound/soc/codecs/cs4271.h                          |   11 +
 sound/soc/codecs/cs42l51.c                         |    6 +-
 sound/soc/codecs/cs42l73.c                         |    6 +-
 sound/soc/codecs/hdmi.c                            |    2 +
 sound/soc/codecs/lm49453.c                         |    8 -
 sound/soc/codecs/max98088.c                        |   31 +-
 sound/soc/codecs/max98090.c                        |  201 ++-
 sound/soc/codecs/max98090.h                        |    8 +
 sound/soc/codecs/max98095.c                        |   23 +-
 sound/soc/codecs/max9850.c                         |   22 +-
 sound/soc/codecs/rt286.c                           |  231 ++-
 sound/soc/codecs/rt5631.c                          |   38 +-
 sound/soc/codecs/rt5645.c                          |  200 ++-
 sound/soc/codecs/rt5645.h                          |   19 +-
 sound/soc/codecs/rt5670.c                          |  136 +-
 sound/soc/codecs/rt5670.h                          |    6 +
 sound/soc/codecs/rt5677-spi.c                      |  130 ++
 sound/soc/codecs/rt5677-spi.h                      |   21 +
 sound/soc/codecs/rt5677.c                          | 1198 ++++++++++++-
 sound/soc/codecs/rt5677.h                          |  162 +-
 sound/soc/codecs/sgtl5000.c                        |  111 +-
 sound/soc/codecs/sigmadsp-i2c.c                    |   81 +-
 sound/soc/codecs/sigmadsp-regmap.c                 |   46 +-
 sound/soc/codecs/sigmadsp.c                        |  711 +++++++-
 sound/soc/codecs/sigmadsp.h                        |   59 +-
 sound/soc/codecs/sirf-audio-codec.c                |    6 +-
 sound/soc/codecs/sn95031.c                         |   15 +-
 sound/soc/codecs/ssm4567.c                         |  128 ++
 sound/soc/codecs/sta32x.c                          |   21 +-
 sound/soc/codecs/sta350.c                          |   21 +-
 sound/soc/codecs/sta529.c                          |   35 +-
 sound/soc/codecs/stac9766.c                        |   60 +-
 sound/soc/codecs/tas2552.c                         |   10 +-
 sound/soc/codecs/tfa9879.c                         |  328 ++++
 sound/soc/codecs/tfa9879.h                         |  202 +++
 sound/soc/codecs/tlv320aic23.c                     |   21 +-
 sound/soc/codecs/tlv320aic31xx.c                   |   31 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   24 +-
 sound/soc/codecs/tlv320aic3x.c                     |  228 ++-
 sound/soc/codecs/tlv320aic3x.h                     |    1 +
 sound/soc/codecs/tlv320dac33.c                     |    2 -
 sound/soc/codecs/ts3a227e.c                        |  314 ++++
 sound/soc/codecs/ts3a227e.h                        |   17 +
 sound/soc/codecs/twl4030.c                         |    2 -
 sound/soc/codecs/twl6040.c                         |   23 +-
 sound/soc/codecs/uda134x.c                         |   32 +-
 sound/soc/codecs/uda1380.c                         |   20 +-
 sound/soc/codecs/wl1273.c                          |   10 +-
 sound/soc/codecs/wm5102.c                          |   18 +-
 sound/soc/codecs/wm8350.c                          |   21 +-
 sound/soc/codecs/wm8400.c                          |   34 +-
 sound/soc/codecs/wm8510.c                          |   26 +-
 sound/soc/codecs/wm8523.c                          |   29 +-
 sound/soc/codecs/wm8580.c                          |    4 -
 sound/soc/codecs/wm8711.c                          |   27 +-
 sound/soc/codecs/wm8728.c                          |   34 +-
 sound/soc/codecs/wm8731.c                          |   37 +-
 sound/soc/codecs/wm8737.c                          |   49 +-
 sound/soc/codecs/wm8750.c                          |   25 +-
 sound/soc/codecs/wm8776.c                          |   31 +-
 sound/soc/codecs/wm8804.c                          |    3 -
 sound/soc/codecs/wm8900.c                          |    8 -
 sound/soc/codecs/wm8903.c                          |   43 +-
 sound/soc/codecs/wm8940.c                          |   22 +-
 sound/soc/codecs/wm8955.c                          |   33 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   12 +-
 sound/soc/codecs/wm8960.c                          |  113 +-
 sound/soc/codecs/wm8961.c                          |   34 +-
 sound/soc/codecs/wm8962.c                          |   11 +-
 sound/soc/codecs/wm8974.c                          |   25 +-
 sound/soc/codecs/wm8978.c                          |   10 -
 sound/soc/codecs/wm8983.c                          |   27 +-
 sound/soc/codecs/wm8985.c                          |   28 +-
 sound/soc/codecs/wm8988.c                          |   27 +-
 sound/soc/codecs/wm8990.c                          |   24 +-
 sound/soc/codecs/wm8991.c                          |   32 +-
 sound/soc/codecs/wm8993.c                          |   12 -
 sound/soc/codecs/wm8994.c                          |    4 +-
 sound/soc/codecs/wm8994.h                          |    2 +
 sound/soc/codecs/wm8995.c                          |   17 +-
 sound/soc/codecs/wm9081.c                          |    7 -
 sound/soc/codecs/wm9090.c                          |   32 +-
 sound/soc/codecs/wm9705.c                          |   46 +-
 sound/soc/codecs/wm9712.c                          |  219 ++-
 sound/soc/codecs/wm9713.c                          |  230 +--
 sound/soc/codecs/wm_adsp.c                         |   97 +-
 sound/soc/davinci/davinci-mcasp.c                  |  339 +++-
 sound/soc/davinci/davinci-mcasp.h                  |   17 +
 sound/soc/dwc/designware_i2s.c                     |   46 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    5 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   19 +-
 sound/soc/fsl/fsl_esai.c                           |   12 +-
 sound/soc/fsl/fsl_ssi.c                            |   17 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    6 +-
 sound/soc/fsl/imx-spdif.c                          |    3 +-
 sound/soc/fsl/imx-ssi.c                            |    2 +-
 sound/soc/fsl/imx-wm8962.c                         |    6 +-
 sound/soc/fsl/mpc5200_dma.c                        |    3 -
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    6 +-
 sound/soc/generic/simple-card.c                    |  160 +-
 sound/soc/intel/Kconfig                            |   44 +-
 sound/soc/intel/Makefile                           |    7 +
 sound/soc/intel/broadwell.c                        |   64 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c                |  230 +++
 sound/soc/intel/cht_bsw_rt5672.c                   |  285 ++++
 sound/soc/intel/haswell.c                          |   14 +-
 sound/soc/intel/sst-atom-controls.c                | 1208 ++++++++++++-
 sound/soc/intel/sst-atom-controls.h                |  428 +++++
 sound/soc/intel/sst-baytrail-dsp.c                 |   24 +-
 sound/soc/intel/sst-dsp-priv.h                     |  136 +-
 sound/soc/intel/sst-dsp.c                          |   31 +
 sound/soc/intel/sst-dsp.h                          |   28 +-
 sound/soc/intel/sst-firmware.c                     |  937 +++++++++--
 sound/soc/intel/sst-haswell-dsp.c                  |  295 +++-
 sound/soc/intel/sst-haswell-ipc.c                  |  413 ++++-
 sound/soc/intel/sst-haswell-ipc.h                  |   25 +-
 sound/soc/intel/sst-haswell-pcm.c                  |  419 ++++-
 sound/soc/intel/sst-mfld-platform-compress.c       |    8 +-
 sound/soc/intel/sst-mfld-platform-pcm.c            |  154 +-
 sound/soc/intel/sst-mfld-platform.h                |    5 +
 sound/soc/intel/sst/Makefile                       |    7 +
 sound/soc/intel/sst/sst.c                          |  437 +++++
 sound/soc/intel/sst/sst.h                          |  546 ++++++
 sound/soc/intel/sst/sst_acpi.c                     |  383 +++++
 sound/soc/intel/sst/sst_drv_interface.c            |  686 ++++++++
 sound/soc/intel/sst/sst_ipc.c                      |  373 +++++
 sound/soc/intel/sst/sst_loader.c                   |  456 +++++
 sound/soc/intel/sst/sst_pci.c                      |  209 +++
 sound/soc/intel/sst/sst_pvt.c                      |  449 +++++
 sound/soc/intel/sst/sst_stream.c                   |  437 +++++
 sound/soc/jz4740/qi_lb60.c                         |   11 +-
 sound/soc/mxs/mxs-saif.c                           |    2 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    7 -
 sound/soc/nuc900/nuc900-ac97.c                     |    2 +-
 sound/soc/omap/Kconfig                             |    8 +-
 sound/soc/omap/mcbsp.c                             |    3 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    7 +-
 sound/soc/pxa/pxa-ssp.c                            |   16 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    6 +-
 sound/soc/pxa/spitz.c                              |   52 +-
 sound/soc/rockchip/Kconfig                         |    9 +-
 sound/soc/samsung/Kconfig                          |    8 +-
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/ac97.c                           |    4 +-
 sound/soc/samsung/arndale_rt5631.c                 |  150 ++
 sound/soc/samsung/i2s-regs.h                       |   10 +-
 sound/soc/samsung/i2s.c                            |  244 ++-
 sound/soc/samsung/odroidx2_max98090.c              |    4 +-
 sound/soc/sh/fsi.c                                 |    9 +-
 sound/soc/sh/hac.c                                 |    2 +-
 sound/soc/sh/rcar/adg.c                            |    2 +-
 sound/soc/sh/rcar/core.c                           |  236 ++-
 sound/soc/sh/rcar/dvc.c                            |  215 +--
 sound/soc/sh/rcar/gen.c                            |   30 +-
 sound/soc/sh/rcar/rsnd.h                           |   92 +-
 sound/soc/sh/rcar/src.c                            |  101 +-
 sound/soc/sh/rcar/ssi.c                            |  233 ++-
 sound/soc/soc-ac97.c                               |  256 +++
 sound/soc/soc-cache.c                              |  149 --
 sound/soc/soc-compress.c                           |   11 +-
 sound/soc/soc-core.c                               | 1768 +++-----------------
 sound/soc/soc-dapm.c                               |  755 +++++----
 sound/soc/soc-jack.c                               |   11 +-
 sound/soc/soc-ops.c                                |  952 +++++++++++
 sound/soc/soc-pcm.c                                |   23 +-
 sound/soc/tegra/tegra20_ac97.c                     |    2 +-
 sound/soc/tegra/tegra_rt5640.c                     |    6 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    2 +-
 sound/soc/txx9/txx9aclc.c                          |    2 +-
 sound/soc/ux500/mop500.c                           |    8 +-
 244 files changed, 17569 insertions(+), 5861 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/arndale.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8960.txt
 create mode 100644 drivers/base/regmap/regmap-ac97.c
 delete mode 100644 sound/soc/atmel/snd-soc-afeb9260.c
 delete mode 100644 sound/soc/codecs/ad1980.h
 create mode 100644 sound/soc/codecs/cs4271-i2c.c
 create mode 100644 sound/soc/codecs/cs4271-spi.c
 create mode 100644 sound/soc/codecs/cs4271.h
 create mode 100644 sound/soc/codecs/rt5677-spi.c
 create mode 100644 sound/soc/codecs/rt5677-spi.h
 create mode 100644 sound/soc/codecs/tfa9879.c
 create mode 100644 sound/soc/codecs/tfa9879.h
 create mode 100644 sound/soc/codecs/ts3a227e.c
 create mode 100644 sound/soc/codecs/ts3a227e.h
 create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c
 create mode 100644 sound/soc/intel/cht_bsw_rt5672.c
 create mode 100644 sound/soc/intel/sst/Makefile
 create mode 100644 sound/soc/intel/sst/sst.c
 create mode 100644 sound/soc/intel/sst/sst.h
 create mode 100644 sound/soc/intel/sst/sst_acpi.c
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
 create mode 100644 sound/soc/intel/sst/sst_ipc.c
 create mode 100644 sound/soc/intel/sst/sst_loader.c
 create mode 100644 sound/soc/intel/sst/sst_pci.c
 create mode 100644 sound/soc/intel/sst/sst_pvt.c
 create mode 100644 sound/soc/intel/sst/sst_stream.c
 create mode 100644 sound/soc/samsung/arndale_rt5631.c
 create mode 100644 sound/soc/soc-ac97.c
 create mode 100644 sound/soc/soc-ops.c

--F4Dl6XKrV7PH8SJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhanRAAoJECTWi3JdVIfQ1QAH/0Lgid19JLMsFP4BvVLbL4iY
vlw1BMDogHv6v4cEeonPFrokgNBcImmPRPTveg/B8w3lIix7RnuRlepVZu09THGD
AdzEWue3Z0/5xeH82Rb8IN19yc6Kc7DrPYq7FgTyoJZJT6ZEkOc9aqQ03xlN0y5j
x9zPo/dOvyfPLKDzS5mDXFfwCE2J3vAUr/Ql5VktHZ7W37bnQe7cfslgOcCrKoCu
YFmCbBx5vNti6hnFC8HqerNPJ9fqU6b8GbBuQA7Ifj128z1mfaoY7ih+ZHx65M4j
1Dm6ahYSgirYwe09Ik7b64jJX/xizJQsuW6+9wvlyuA/06A3JWoojp5FsKW7zws=
=NPVF
-----END PGP SIGNATURE-----

--F4Dl6XKrV7PH8SJF--

--===============6865744515795923269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6865744515795923269==--
