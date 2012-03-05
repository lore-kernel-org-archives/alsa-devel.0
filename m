From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.4
Date: Mon, 5 Mar 2012 12:21:26 +0000
Message-ID: <20120305122125.GG3224@opensource.wolfsonmicro.com>
References: <20120304153255.GB4978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3144527569280992097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFA9824340
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:21:29 +0100 (CET)
In-Reply-To: <20120304153255.GB4978@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3144527569280992097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to ad20ff920c1fd217578e2c637dd50c1878a21c06:

  ASoC: wm8753: fix initialization (2012-03-04 14:34:44 +0000)

This should be the major pull request from my side for 3.4.  I did send
a version of this yesterday based off topic/asoc but the request came
out at 190k or so and will have upset at least some mail software so
I've redone it against mainline.  You already have some of the changes
so the diffstat won't quite reflect what you get when you pull.

The summary below doesn't include the OMAP stuff which you've already
pulled from Liam, the main thing there that I remember is that we've now
got a generic driver for OMAP4 reference boards including Panda which is
configured via platform data allowing new boards to be supported without
driver changes.

----------------------------------------------------------------
This has been a very active release for ASoC, as well as the usual raft
of bugfixes and driver updates there's quite a few framework enhancements.
Most are either small or are laying the groundwork for user visible
features (especially dynamic PCM), the most directly visible change is
the dmaengine library.  There's also a bunch of regmap API enhancements
pulled into the tree so that either the framework or drivers can take
advantage of the new features.

Changes include:

- Support for widgets not associated with a CODEC, an important part of
  the dynamic PCM framework.

- A library factoring out the common code shared by dmaengine based DMA
  drivers contributed by Lars-Peter Clausen.  This will save a lot of
  code and make it much easier to deploy enhancements to dmaengine.

- Support for binary controls, used for providing runtime configuration
  of algorithm coefficients.

- A new DAPM widget type for regulator supplies allowing drivers for
  devices that can power down unused supplies while active to do without
  any per-driver code.

- DAPM widgets for DAIs, initially giving a speed boost for playback
  startup and shutdown and also the basis for CODEC<->CODEC DAI link
  support.

- Support for specifying the number of significant bits on audio
  interfaces, useful for allowing applications to know how much effort to
  put into generating data for a larger sample format.

- Conversion of the FSI driver used on some SH processors to DMAEngine.

- New CODEC drivers for Maxim MAX9768 and Wolfson Microelectronics WM2200.

----------------------------------------------------------------
Andrey Danin (9):
      ASoC: alc5632: Coding style. Remove two extra empty lines.
      ASoC: alc5632: Fixed voice DAC volume step.
      ASoC: alc5632: Add voice DAC playback switch
      ASoC: alc5632: Rename capture switches to common scheme XXX2REC
      ASoC: alc5632: Remove unexisting route from Phone Mix to Mono Mix
      ASoC: alc5632: Refactored DAPM routes to add voice support
      ASoC: alc5632: Add DMIC switches and controls
      ASoC: alc5632: Fix I2S digital interface power for recording
      ASoC: alc5632: Allow 8kHz stream support.

Axel Lin (12):
      ASoC: jz4740: Convert qi_lb60 to use snd_soc_register_card()
      ASoC: Add __devinit/__devexit annotations at necessary places
      ASoC: Set idle_bias_off flag in snd_soc_codec_driver
      ASoC: Use dai_fmt in afeb9260 machine driver
      ASoC: Convert afeb9260 to table based DAPM init
      ASoC: Convert kirkwood-t5325 to use snd_soc_register_card()
      ASoC: Convert kirkwood-openrd to use snd_soc_register_card()
      ASoC: Fix build error in sound/soc/omap/n810.c
      ASoC: Get correct revision id for wm2200
      ASoC: Show device id in the debug message
      ASoC: Change spitz_ext_control to take dapm as argument.
      ASoC: Add __devinit annotation for pxa2xx_ac97_probe

Denis 'GNUtoo' Carikli (1):
      ASoC: wm8753: fix initialization

Dimitris Papastamos (1):
      ASoC: wm8983: Remove useless snd_kcontrol

Fabio Estevam (3):
      ASoC: sgtl5000: Print revision number in hex
      ASoC: sgtl5000: Convert to table based DAPM and control init
      ASoC: soc-core: Show the returned values on error messages

Felipe Contreras (1):
      ASoC: tlv320aic3x: remove unused code

Jassi Brar (1):
      ASoC: Samsung: Merge two identical if-else clauses

Jaswinder Singh (1):
      ASoC: Samsung: Update email id of the author

Javier Martin (2):
      ASoC: Route Mic Bias in Visstrim_M10 board.
      ASoC: Add external amplifier controls for Visstrim_M10.

Joachim Eastwood (2):
      ASoC: use proper defines for stream directions in pcm engines
      ASoC: replace 0xffffffff with DMA_BIT_MASK macro

Julia Lawall (1):
      ASoC: mxs-saif: use devm_ functions

Kuninori Morimoto (18):
      ASoC: fsi: reduce runtime calculation by using pre-setting
      ASoC: fsi: tidyup: fsi_stream_xx() functions were gathered
      ASoC: fsi: data push/pop calculation part was divided
      ASoC: fsi: rename fsi_dma_soft_xxx() to fsi_pio_xxx()
      ASoC: fsi: tidyup: move fsi_fifo_init() onto fsi_hw_startup()
      ASoC: fsi: remove unnecessary parameter from fsi_hw_shutdown()
      ASoC: fsi: rename fsi_stream_push/pop() to fsi_stream_init/quit()
      ASoC: fsi: modify fsi_pio_get_area() parameter and using position
      ASoC: fsi: re-define fsi_is_play() and fsi_stream_is_play()
      ASoC: fsi: use fsi_stream in fsi_get_current_fifo_samples() parameter
      ASoC: fsi: add fsi_stream_handler and PIO handler
      ASoC: fsi: tidyup: fsi_pio_xxx() are gathered
      ASoC: fsi: don't use is_play as a parameter of fsi functions
      ASoC: fsi: add .start_stop handler to fsi_stream_handler
      ASoC: fsi: fsi_stream_is_working() care substream->runtime
      ASoC: fsi: PortA/B information was controlled by sh_fsi_port_info
      ASoC: fsi: add .init/.quit handler support
      ASoC: fsi: Add DMAEngine support

Lars-Peter Clausen (10):
      ASoC: blackfin: Use dai_fmt
      ASoC: imx-pcm: Remove empty prepare callback
      ASoC: imx-pcm: Remove unused fields from imx_pcm_runtime_data struct
      ASoC: mxs-pcm: Remove unused fields from struct mxs_pcm_runtime_data
      ASoC: imx-ssi: Set dma data early
      ASoC: imx-pcm: Request DMA channel early
      ASoC: mxs-pcm: Request DMA channel early
      ASoC: Add dmaengine PCM helper functions
      ASoC: imx-pcm-dma: Use dmaengine PCM helper functions
      ASoC: mxs-pcm: Use dmaengine PCM helper functions

Leon Romanovsky (7):
      ASoC: Tegra+ALC5632: Implement device tree support in board file
      ASoC: ALC5632: Add device tree binding documentation
      ASoC: Tegra+ALC5632 machine: Add device tree binding documentation
      ASoC: Tegra+ALC5632: Enable headset autodetection on PAZ00 board.
      ASoC: tegra: Remove unused DAPM route structure.
      ASoC: tegra+alc5632: Added digital microphone DAPM widget.
      ASoC: DT: Update digital microphone binding documentation to PAZ00 board.

Liam Girdwood (13):
      ASoC: core - Improve card registration error messaging for large DAI links.
      ASoC: twl6040 - add method to query HS DC offset step size in mV
      ASoC: utils - Add support for a dummy codec driver.
      ASoC: core: Add support for DAI and machine kcontrols.
      ASoC: dapm: Export mixer|mux_update_power() to public API.
      ASoC: dapm: Clean up header information.
      ASoC: max9768: Fix build and use new add control API.
      ALSA: PCM - Add PCM creation API for internal PCMs.
      ASoC: dapm - Make DAPM reset code a separate function.
      ASoC: dapm: Notify stream event to all card components.
      ASoC: core: Convert CODEC debugfs init to use dev_warn()
      ASoC: spitz: Fix kcontrols to use card instead of codec
      ASoC: core: cleanup platform debugfs on probe failure.

Manjunath Hadli (1):
      ASoC: CQ93VC: remove machine specific header file inclusion from codec driver

Marc Dietrich (1):
      ASoC: alc5632: Connect HP/HPL/HPR mix'es to HPOut Mix

Mark Brown (182):
      ASoC: Make WM8978 I2C usage unconditional
      ASoC: Remove unused control type from wm8978 driver
      ASoC: Convert wm8978 to table based DAPM and control init
      ASoC: Convert wm8978 to devm_kzalloc()
      ASoC: Use standard cache sync for WM8978
      ASoC: Convert wm8978 to direct regmap API usage
      ASoC: Push wm8978 reset down into the I2C probe
      ASoC: Convert WM9090 to use regmap directly
      ASoC: Move WM9090 device identification and reset to I2C probe
      ASoC: Convert wm8993 to direct regmap API usage
      ASoC: Move WM8993 resource acquisition and device reset to bus probe
      ASoC: Convert WM8753 to direct regmap API usage
      ASoC: Make WM8971 I2C usage unconditional
      ASoC: Convert wm8971 to table based DAPM and control init
      ASoC: Convert wm8971 to devm_kzalloc()
      ASoC: Make wm8974 I2C usage unconditional
      ASoC: Convert wm8974 to table based DAPM and control init
      ASoC: Remove wm8974 private data
      ASoC: Use standard cache sync for wm8804
      ASoC: Convert wm8804 to devm_kzalloc()
      ASoC: Convert wm8804 to direct regmap API usage
      ASoC: Make WM8904 I2C usage unconditional
      ASoC: Convert wm8904 to devm_kzalloc()
      ASoC: Use standard cache sync for WM8904
      ASoC: Convert WM8904 to direct regmap API usage
      ASoC: Make I2C usage unconditional in WM8940
      ASoC: Convert WM8940 to devm_kzalloc()
      ASoC: Make I2C usage unconditional in WM8955
      ASoC: Convert WM8955 to devm_kzalloc()
      ASoC: Use standard register cache sync for WM8955
      ASoC: Convert WM8955 to direct regmap API usage
      ASoC: Convert WM8955 to table based DAPM and control init
      ASoC: Optimise performance of WM8904 ADC 128fs OSR mode
      ASoC: Make WM8962 I2C usage unconditional
      ASoC: Convert WM8962 register access map to modern style
      ASoC: Add WM8962 DAC and ADC L/R swap support
      ASoC: Allow drivers to specify how many bits are significant on a DAI
      ASoC: 24 bits are significant on the WM8996 audio interfaces
      ASoC: Implement basic WM8993 interrupt support
      ASoC: Make WM8993 I2C usage unconditional
      ASoC: 24 bits are significant on wm_hubs DAIs
      ASoC: When releasing WM5100 put /RESET into reset
      ASoC: Say we can't read WM5100 ID register
      ASoC: Remove redundant set_bias_level() from WM5100 remove()
      ASoC: Make WM5100 interrupt path use regmap directly
      ASoC: Push WM5100 interrupt request into I2C probe
      ASoC: Don't tell applications about msbits unless we're ignoring input
      ASoC: Use regmap update bits operation for drivers using regmap
      ASoC: Fix build of tlv320dac33
      ASoC: wm8985: Convert to devm_kzalloc()
      ASoC: wm8985: Convert to table based DAPM and control init
      ASoC: wm8985: Use standard cache sync implementation
      ASoC: wm8985 Don't directly reference the cache data structure
      ASoC: wm8985: Convert to direct regmap API usage
      ASoC: wm8988: Convert to table based DAPM and control init
      ASoC: wm8988: Convert to devm_kzalloc()
      regulator: Implement devm_regulator_free()
      regulator: Provide devm_regulator_bulk_get()
      ASoC: sgtl5000: It's sgtl5000 not sgtl500
      regmap: Support register patch sets
      ASoC: Convert WM8731 to direct regmap API usage
      ASoC: wm5100: Fix mismerge of IRQ frees
      Merge tag 'regmap-patch-initial' of git://git.kernel.org/.../broonie/regmap into for-3.4
      ASoC: Convert the WM5100 revision A updates to a regmap patch
      ASoC: wm5100: Fix warnings from recent patches
      ASoC: wm8962: Optimise power consumption for IN4 DC measurement usage
      Merge tag 'topic/devm' of git://git.kernel.org/.../broonie/regulator into HEAD
      ASoC: Provide REGULATOR_SUPPLY widget type
      ASoC: wm5100: Move regulator supplies over to DAPM infrastructure
      ASoC: wm2200: Add WM2200 CODEC driver
      ASoC: dapm: Drop runtime PM references asynchronously
      ASoC: dapm: Ignore isolated signal generators for power purposes
      ASoC: wm5100: Convert to devm_regulator_bulk_get()
      ASoC: wm5100: Use pm_runtime for powerdown managment
      ASoC: wm8996: Handle failures to determine accessory polarity
      ASoC: wm8994: Report any low impedance accessory as a headphone
      ARM: S3C64XX: Use IN4 DC measurement mode on Tobermory
      ASoC: wm8962: Enable idle_bias_off
      ASoC: wm2200: Remove trailing whitespace
      ASoC: max9768: Fix up review comments in max9768 driver
      ASoC: fsi: Remove unneeded empty runtime PM callbacks
      ASoC: wm8993: Convert to use a regmap patch
      ASoC: core: Support suspend to disk
      ASoC: wm_hubs: Push check for idle_bias_off out into drivers
      Merge tag 'v3.3-rc2' into for-3.4
      ASoC: wm8996: Switch to using common code for managing CPVDD supply
      ASoC: wm8996: Use devm_regulator_bulk_get()
      ASoC: wm5100: Handle failures to determine accessory polarity
      ASoC: wm9712: Remove driver specific version
      ASoC: wm9712: Add TLV information for microphone input
      ASoC: pcm: Improve error logging
      ASoC: samsung: Enable accessory detect for WM8994 on Littlemill
      ASoC: wm8994: Don't bring up to STANDBY by default
      ASoC: wm8994: We don't need to runtime resume by default
      ASoC: wm8994: Unsuspend the device while reading GPIO statuses
      ASoC: wm8994: Bring WM8994 accessory detection up to date
      ASoC: tlv320aic3x: Remove even more unused code
      ASoC: wm_hubs: Convert most output drivers to OUT_DRV widgets
      ASoC: wm8962: Support mono playback and record
      ASoC: pcm: If pmdown_time is zero then shut down DAPM immediately
      ASoC: core: Allow CODECs to set ignore_pmdown_time in the driver struct
      ASoC: twl6040: Move ignore_pmdown_time to driver struct
      ASoC: wm2200: Ignore pmdown_time
      Merge branch 'topic/pcm-internal' of git://git.kernel.org/.../tiwai/sound into for-3.4
      Merge tag 'v3.3-rc3' as we've got several bugfixes in there which are     colliding annoyingly with development.
      ASoC: wm8993: Correct typos in regmap conversion
      ASoC: wm8993: Add register default for INPUTS_CLAMP
      ASoC: wm_hubs: Improve single ended line output enable performance
      ASoC: wm_hubs: Clamp inputs to VMID while we ramp
      ASoC: wm8994: VMID management improvements
      ASoC: wm8994: Actively discharge VMID when not in use
      ASoC: wm9081: Use module_i2c_driver
      ASoC: wm8988: Convert to direct regmap API usage
      ASoC: wm8988: Remove unneded -codec from driver name
      ASoC: wm9081: Move WM9081 IRQ platform data handling into I2C probe
      ASoC: wm9081: Use idle_bias_off
      ASoC: wm8994: Use slow start for VMID
      ASoC: dapm: Convert pin switches to use snd_soc_card
      ASoC: wm8962: Update the clocking when setting system clock
      ASoC: wm8962: Only configure BCLK in hw_params when audio is active
      ASoC: wm8962: Log the selected SYSCLK ratio
      ASoC: wm8962: Add new SYSCLK ratios for new device revisions
      ASoC: wm8962: Clean up register dump cruft
      ASoC: wm8962: Don't automatically enable and disable FLL
      ASoC: wm8962: Convert to runtime PM for bias off management
      ASoC: ak4535: Remove -codec from driver name
      ASoC: ak4535: Make I2C usage unconditional
      ASoC: ak4535: Remove bitrotted driver version
      ASoC: ak4535: Convert to direct regmap API usage
      ALSA: core: Constify the name in new kcontrols
      ASoC: dapm: Unexport snd_soc_dapm_new_control()
      ASoC: dapm: Refactor snd_soc_dapm_new_widget() to return the widget
      ASoC: dapm: Supply the DAI and substream when calling stream events
      ASoC: dapm: Constify lots of names that are never modified
      ASoC: dapm: Implement and instantiate DAI widgets
      ASoC: dapm: Convert stream events to use DAI widgets
      ASoC: wm8994: Convert to use DAI widget routing rather than streams
      ASoC: dapm: Only mark pin widgets as dirty if we actually change state
      ASoC: wm8962: Convert to module_i2c_driver()
      ASoC: wm8993: Convert to module_i2c_driver()
      ASoC: wm8996: Convert to module_i2c_driver()
      ASoC: wm8996: Make sure we bounce /RESET to reset
      Merge tag 'v3.3-rc4' into for-3.4 in order to resolve the conflict     resolved below within the FSI driver and allow the application of the     dmaeengine conversion that depends on this resolution.
      regmap: Allow users to query the size of register values
      ASoC: ak4104: Remove uninformative print on probe()
      ASoC: ak4104: Convert to module_spi_driver()
      ASoC: wm8776: Add WM8775 device ID to the WM8776
      ASoC: wm_hubs: Convert headphone driver to output driver widget
      ASoC: wm8994: Enable headphone startup mode 1 for WM1811 and WM8958
      ASoC: wm8994: Actively discharge idle MICBIAS with jack detect
      ASoC: wm8994: Support external capacitors on MICBIAS2 with jack detection
      Merge tag 'topic/introspection' of git://git.kernel.org/.../broonie/regmap into HEAD
      ASoC: io: Retrieve val_bytes from the regmap API
      ASoC: core: Add SND_SOC_BYTES control for coefficient blocks
      ASoC: core: Add support for masking out parts of coefficient blocks
      ASoC: wm8996: Implement DRC coefficient configuration
      ASoC: wm5100: Implement DRC coefficient configuration
      ASoC: wm8996: Convert to use DAPM routes for stream connections
      ASoC: wm8994: Move wm_hubs callback before we start ramping VMID
      ASoC: ak4104: Use snd_soc_update_bits() for read/modify/write
      ASoC: ak4104: Use snd_soc_write() rather than internal write function
      ASoC: ak4104: Convert to direct regmap API usage
      ASoC: wm8962: Remove mistakenly committed debug logging
      ASoC: wm8962: Convert interrupt handler to direct regmap usage
      ASoC: wm8753: Convert to devm_kzalloc()
      ASoC: wm8994: Make sure we don't have MICBIAS on during jackdet mode
      ASoC: wm8996: Fix /RESET bounce ordering
      ASoC: wm8996: Remove stub register cache
      ASoC: wm_hubs: Bomb out if we can't read back the DC servo result
      ASoC: wm8994: Remove stub of register access code
      ASoC: wm8962: Remove register default for PLL2
      ASoC: wm8994: Disable debounce of jack detection on inserted jack
      ASoC: wm8962: Run the headphone in class G mode when sidetone is enabled
      ASoC: core: Log a warning when machines use soc-audio
      ASoC: wm8994: Push wm8994 private data allocation out into device probe
      ASoC: wm8994: Suppress noop updates of FLL K
      ASoC: wm_hubs: Disable cache of the DC servo calibration for WM1811
      ASoC: wm8994: Make sure we sync DAPM on WM8958 detection mode changes
      ASoC: wm8994: Disable JACKDET when disabling detecton
      ASoC: wm8994: Don't bother updating the jackdet mode needlessly
      ASoC: wm8994: Factor out WM1811A detection mode setting
      ASoC: core: Split the union for CODEC/platform in the DAI

Masanari Iida (1):
      ASoC: Fix typo in twl4030.c

Paul Fertser (2):
      ASoC: alc5632: Fix Boost Volume TLVs used for the external microphones
      ASoC: alc5632: Fix Capture/Playback attributes for microphone inputs

Paul Gortmaker (1):
      ASoC: fix trivial build error in mpc5200_dma.c

Peter Ujfalusi (6):
      ASoC: tlv320dac33: Use core to set the msbits constraint
      ASoC: twl4030: Use core to set the msbits constraint
      ASoC: omap-dmic: Use core to set the msbits constraint
      ASoC: omap-mcpdm: Set 24msbits constraint
      ASoC: soc-pcm: msbits constraint: Drop 8 and 16 bit sample sizes
      ASoC: twl4030: Debug code cleanup

Ryan Mallon (1):
      ep93xx: Don't use system controller defines in audio drivers

Sebastien Guiriec (1):
      ASoC: core: add platform DAPM debugfs support

Shawn Guo (8):
      ASoC: imx/mxs: remove redundant SND_PCM selection
      ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
      ASoC: fsl: correct get_dma_channel parameter name
      ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting codec node
      ASoC: Remove unnecessary -codec from cs4270 driver name
      ASoC: imx: initialize dma_params burstsize just in imx-ssi
      ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
      ASoC: sgtl5000: rename device tree binding document

Stephen Boyd (1):
      regulator: Add devm_regulator_get()

Viresh Kumar (1):
      ASoC: core: Don't overwrite .poweroff in snd_soc_pm_ops

Wolfram Sang (1):
      ASoC: max9768: add driver for max9768 amplifier

 .../devicetree/bindings/sound/alc5632.txt          |   24 +
 .../{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt}  |    0
 .../bindings/sound/tegra-audio-alc5632.txt         |   59 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/driver-model/devres.txt              |    3 +
 arch/arm/mach-ep93xx/core.c                        |   19 +-
 arch/arm/mach-ep93xx/include/mach/platform.h       |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c              |    6 +
 arch/arm/mach-kirkwood/t5325-setup.c               |    6 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c              |   30 +-
 arch/arm/mach-shmobile/board-mackerel.c            |   18 +-
 arch/mips/jz4740/board-qi_lb60.c                   |    6 +
 arch/sh/boards/mach-ecovec24/setup.c               |    4 +-
 arch/sh/boards/mach-se/7724/setup.c                |    4 +-
 drivers/base/regmap/internal.h                     |    3 +
 drivers/base/regmap/regcache.c                     |   11 +
 drivers/base/regmap/regmap.c                       |   73 +
 drivers/regulator/core.c                           |  108 +
 include/linux/mfd/wm8994/pdata.h                   |    3 +
 include/linux/regmap.h                             |    4 +
 include/linux/regulator/consumer.h                 |   12 +
 include/sound/control.h                            |    2 +-
 include/sound/dmaengine_pcm.h                      |   49 +
 include/sound/max9768.h                            |   24 +
 include/sound/pcm.h                                |    4 +
 include/sound/sh_fsi.h                             |   12 +-
 include/sound/soc-dai.h                            |   11 +-
 include/sound/soc-dapm.h                           |   33 +-
 include/sound/soc.h                                |   44 +-
 include/sound/wm2200.h                             |   41 +
 include/sound/wm8962.h                             |    6 +
 sound/core/pcm.c                                   |   99 +-
 sound/soc/Kconfig                                  |    3 +
 sound/soc/Makefile                                 |    3 +
 sound/soc/atmel/atmel-pcm.c                        |    4 +-
 sound/soc/atmel/snd-soc-afeb9260.c                 |   37 +-
 sound/soc/blackfin/bf5xx-ad1836.c                  |   17 +-
 sound/soc/blackfin/bf5xx-ad193x.c                  |   17 +-
 sound/soc/blackfin/bf5xx-ad73311.c                 |   29 +-
 sound/soc/blackfin/bf5xx-ssm2602.c                 |   20 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |   13 +-
 sound/soc/blackfin/bfin-eval-adau1701.c            |   16 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |   13 +-
 sound/soc/codecs/Kconfig                           |    8 +
 sound/soc/codecs/Makefile                          |    4 +
 sound/soc/codecs/ad1836.c                          |    6 +-
 sound/soc/codecs/ad1980.c                          |    2 +-
 sound/soc/codecs/adau1373.c                        |    7 +-
 sound/soc/codecs/adau1701.c                        |    2 +-
 sound/soc/codecs/ak4104.c                          |  174 +-
 sound/soc/codecs/ak4535.c                          |   98 +-
 sound/soc/codecs/ak4535.h                          |    2 -
 sound/soc/codecs/ak4642.c                          |    2 +-
 sound/soc/codecs/ak4671.c                          |    2 +-
 sound/soc/codecs/alc5623.c                         |   12 +-
 sound/soc/codecs/alc5632.c                         |  197 +-
 sound/soc/codecs/alc5632.h                         |    1 +
 sound/soc/codecs/cq93vc.c                          |    4 +-
 sound/soc/codecs/cs4270.c                          |    4 +-
 sound/soc/codecs/cs4271.c                          |    2 +-
 sound/soc/codecs/lm4857.c                          |    2 +-
 sound/soc/codecs/max9768.c                         |  247 ++
 sound/soc/codecs/max98088.c                        |    4 +-
 sound/soc/codecs/max98095.c                        |    6 +-
 sound/soc/codecs/max9877.c                         |    2 +-
 sound/soc/codecs/sgtl5000.c                        |   19 +-
 sound/soc/codecs/sn95031.c                         |    5 +-
 sound/soc/codecs/ssm2602.c                         |    2 +-
 sound/soc/codecs/stac9766.c                        |    2 +-
 sound/soc/codecs/tlv320aic23.c                     |    2 +-
 sound/soc/codecs/tlv320aic26.c                     |    2 +-
 sound/soc/codecs/tlv320aic32x4.c                   |    2 +-
 sound/soc/codecs/tlv320aic3x.c                     |   66 +-
 sound/soc/codecs/tlv320aic3x.h                     |    9 -
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/tpa6130a2.c                       |    4 +-
 sound/soc/codecs/twl4030.c                         |   42 +-
 sound/soc/codecs/twl6040.c                         |   15 +-
 sound/soc/codecs/twl6040.h                         |    1 +
 sound/soc/codecs/uda134x.c                         |    6 +-
 sound/soc/codecs/wl1273.c                          |    2 +-
 sound/soc/codecs/wm2200.c                          | 2286 ++++++++++++
 sound/soc/codecs/wm2200.h                          | 3674 ++++++++++++++++++++
 sound/soc/codecs/wm5100.c                          |  643 ++--
 sound/soc/codecs/wm8731.c                          |  109 +-
 sound/soc/codecs/wm8737.c                          |    2 +-
 sound/soc/codecs/wm8753.c                          |  195 +-
 sound/soc/codecs/wm8770.c                          |    5 +-
 sound/soc/codecs/wm8776.c                          |    8 +-
 sound/soc/codecs/wm8804.c                          |  148 +-
 sound/soc/codecs/wm8904.c                          |  856 ++---
 sound/soc/codecs/wm8904.h                          |   11 +
 sound/soc/codecs/wm8940.c                          |   16 +-
 sound/soc/codecs/wm8955.c                          |  247 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   14 +-
 sound/soc/codecs/wm8960.c                          |    2 +-
 sound/soc/codecs/wm8961.c                          |    2 +-
 sound/soc/codecs/wm8962.c                          | 2125 +++++-------
 sound/soc/codecs/wm8971.c                          |   37 +-
 sound/soc/codecs/wm8974.c                          |   45 +-
 sound/soc/codecs/wm8978.c                          |  185 +-
 sound/soc/codecs/wm8978.h                          |    2 +
 sound/soc/codecs/wm8983.c                          |    5 -
 sound/soc/codecs/wm8985.c                          |  315 +-
 sound/soc/codecs/wm8988.c                          |  171 +-
 sound/soc/codecs/wm8990.c                          |    2 +-
 sound/soc/codecs/wm8991.c                          |    2 +-
 sound/soc/codecs/wm8993.c                          |  649 +++--
 sound/soc/codecs/wm8993.h                          |    9 +
 sound/soc/codecs/wm8994.c                          |  304 ++-
 sound/soc/codecs/wm8994.h                          |    5 +-
 sound/soc/codecs/wm8995.c                          |    4 +-
 sound/soc/codecs/wm8996.c                          |  200 +-
 sound/soc/codecs/wm9081.c                          |   80 +-
 sound/soc/codecs/wm9090.c                          |  272 +-
 sound/soc/codecs/wm9705.c                          |    2 +-
 sound/soc/codecs/wm9712.c                          |   16 +-
 sound/soc/codecs/wm9713.c                          |    2 +-
 sound/soc/codecs/wm_hubs.c                         |  148 +-
 sound/soc/codecs/wm_hubs.h                         |   12 +
 sound/soc/davinci/davinci-pcm.c                    |    4 +-
 sound/soc/ep93xx/edb93xx.c                         |    4 +-
 sound/soc/ep93xx/ep93xx-pcm.c                      |    4 +-
 sound/soc/ep93xx/snappercl15.c                     |    4 +-
 sound/soc/fsl/fsl_dma.c                            |   10 +-
 sound/soc/fsl/mpc5200_dma.c                        |   17 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |   16 +-
 sound/soc/fsl/p1022_ds.c                           |    4 +-
 sound/soc/imx/Kconfig                              |    6 +-
 sound/soc/imx/imx-pcm-dma-mx2.c                    |  221 +-
 sound/soc/imx/imx-ssi.c                            |   30 +-
 sound/soc/imx/mx27vis-aic32x4.c                    |  104 +
 sound/soc/jz4740/qi_lb60.c                         |   56 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    4 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |   46 +-
 sound/soc/kirkwood/kirkwood-t5325.c                |   47 +-
 sound/soc/mid-x86/mfld_machine.c                   |    2 +-
 sound/soc/mxs/Kconfig                              |    2 +-
 sound/soc/mxs/mxs-pcm.c                            |  157 +-
 sound/soc/mxs/mxs-pcm.h                            |   16 -
 sound/soc/mxs/mxs-saif.c                           |   51 +-
 sound/soc/omap/ams-delta.c                         |    2 +-
 sound/soc/omap/n810.c                              |   17 +-
 sound/soc/omap/omap-dmic.c                         |    7 +-
 sound/soc/omap/omap-mcbsp.c                        |    8 +-
 sound/soc/omap/omap-mcbsp.h                        |    2 +-
 sound/soc/omap/omap-mcpdm.c                        |    2 +
 sound/soc/omap/rx51.c                              |   25 +-
 sound/soc/pxa/corgi.c                              |   14 +-
 sound/soc/pxa/magician.c                           |    2 +-
 sound/soc/pxa/poodle.c                             |   14 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   10 +-
 sound/soc/pxa/raumfeld.c                           |    2 +-
 sound/soc/pxa/spitz.c                              |   14 +-
 sound/soc/pxa/tosa.c                               |    2 +-
 sound/soc/s6000/s6000-pcm.c                        |    5 +-
 sound/soc/samsung/ac97.c                           |    4 +-
 sound/soc/samsung/dma.c                            |    2 +-
 sound/soc/samsung/i2s.c                            |   14 +-
 sound/soc/samsung/i2s.h                            |    2 +-
 sound/soc/samsung/littlemill.c                     |    3 +
 sound/soc/samsung/neo1973_wm8753.c                 |    4 +-
 sound/soc/samsung/pcm.c                            |    4 +-
 sound/soc/samsung/s3c24xx_simtec.c                 |    6 +-
 sound/soc/samsung/smdk_wm8580.c                    |    4 +-
 sound/soc/samsung/smdk_wm9713.c                    |    4 +-
 sound/soc/sh/fsi.c                                 |  912 ++++--
 sound/soc/soc-core.c                               |  379 ++-
 sound/soc/soc-dapm.c                               |  393 ++-
 sound/soc/soc-dmaengine-pcm.c                      |  287 ++
 sound/soc/soc-io.c                                 |    7 +
 sound/soc/soc-pcm.c                                |  104 +-
 sound/soc/soc-utils.c                              |   20 +-
 sound/soc/tegra/tegra_alc5632.c                    |  130 +-
 sound/soc/tegra/tegra_pcm.c                        |    2 +-
 176 files changed, 12663 insertions(+), 5230 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/alc5632.txt
 rename Documentation/devicetree/bindings/sound/{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt
 create mode 100644 include/sound/dmaengine_pcm.h
 create mode 100644 include/sound/max9768.h
 create mode 100644 include/sound/wm2200.h
 create mode 100644 sound/soc/codecs/max9768.c
 create mode 100644 sound/soc/codecs/wm2200.c
 create mode 100644 sound/soc/codecs/wm2200.h
 create mode 100644 sound/soc/soc-dmaengine-pcm.c

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVK+/AAoJEBus8iNuMP3dKswP/3ba495P85YYeEXk3uMqHBH4
ty8Lxijd0K1wLTixYv5hvXnJ3AaOW8y7wjc4SNouQrRSytZOVFQB23EmttI/Gz/6
O49su4NCXzrLmIf0nJ3kn2n6biOQWs1jPfI/gvBVTpnF0ob3zLBUlXIvJj9X5m3W
9GgqEzM5+heTpC+ke01Y6cDwnehTsI5Ypj4radDRf2gPKcNjvwJsYS2KKzevE72i
MKGqMzd7nyjZFBG5VFEsUdyj0G6fc1LZbw+6s1lvPzNSJOutKwsFvi44M10qpX3d
b3fObbiU9xsAZIhGav7Bsjki5v4QefjB+iW3OJkmB5r8fYLNQIV6s4axtFh3MdjA
GklKG6jbZDqgjt0tfpuRJO+U1VHmORGnencndDLo/qArb9u1LaWDwk2Pespp21Zv
HVYZBTdaVGUT4MXzGWke+PqiEruTpAsaHp6EaReAmpAUL5YAY7iDKoepiH1Ph23j
5BC+oerqc/urIsU4E1Eq3nLQmPgSk8m9oCWV1Y3XaDd76U3JKickk5ENQA1NoGUB
/AM2qMo2TNAb3a3ByGQupRATgouifrmcQJjqMLnZmu0Z3II4amgs0j8U5J7AUNC0
JfW+2hPOFQJjdXPz5cpNjIS8mk7kdxU0q1AyubPG9JhEvkWmEF8Q0x6d/5NswoSX
hICQeD0sl2wefTA14Tuu
=wOc3
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--

--===============3144527569280992097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3144527569280992097==--
