From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.7
Date: Sat, 22 Sep 2012 11:50:08 -0400
Message-ID: <20120922155006.GQ4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55F72261677
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:50:11 +0200 (CEST)
Content-Disposition: inline
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

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.7

for you to fetch changes up to ddfb43f3881edb47aa0083651ad31983cdc42c33:

  Merge tag 'v3.6-rc6' into for-3.7 (2012-09-22 11:26:27 -0400)

----------------------------------------------------------------

ASoC: Updates for v3.7

Lots and lots of driver specific cleanups and enhancements but the only
substantial framework feature this time round is the compressed API
binding:

- Addition of ASoC bindings for the compressed API, used by the mid-x86
  drivers.
- Lots of cleanups and API refreshes for CODEC drivers and DaVinci.
- Conversion of OMAP to dmaengine.
- New machine driver for Wolfson Microelectronics Bells.
- New CODEC driver for Wolfson Microelectronics WM0010.

----------------------------------------------------------------
Alexander Shiyan (1):
      ASoC: Rename ep93xx soc directory to cirrus

Bo Shen (1):
      ASoC: wm8904: remove redundant code

Chris Rattray (1):
      ASoC: wm8994: enable mic and short detect debounce.

Dan Carpenter (1):
      ASoC: wm0010: unlock on error path

Daniel Mack (2):
      ASoC: add DT bindings for cs4270
      ASoC: Add reset-gpio DT property to cs4270 driver

Dimitris Papastamos (1):
      ASoC: wm0010: Add initial wm0010 DSP driver

Emil Goode (1):
      ASoC: wm0010: Fix warning, use format %zu for type size_t

Eric Millbrandt (6):
      ASoC: fsl: mpc5200 combine psc_dma platform data
      ASoC: fsl: mpc5200 add missing information to snd_soc_dai_driver
      ASoC: fsl: cleanup headers in pcm030-audio-fabric
      ASoC: fsl: add PPC_MPC52xx dependency to SND_POWERPC_SOC
      ASoC: fsl: pcm030-audio-fabric use snd_soc_register_card
      ASoC: fsl: register the wm9712-codec

Fabio Estevam (5):
      ASoC: imx-ssi: Use devm functions
      ASoC: mxs-saif: Use devm_clk_get()
      ASoC: Revert "ASoC: mc13783: Provide codec->control_data"
      ASoC: Revert "ASoC: ab8500: Inform SoC Core that we have our own I/O =
arrangements"
      Revert "ASoC: AC97 doesn't use regmap by default"

Fengguang Wu (1):
      ASoC: wm0010: Add missing IRQF_ONESHOT

Ga=EBtan Carlier (1):
      ASoC: imx-mc13783: use defines instead of numerical address of regist=
er

Hebbar, Gururaja (9):
      ASoC: Davinci: McASP: remove unused header include
      ASoC: McASP: Convert driver to use Runtime PM API
      ASoC: tlv320aic3x: Add device tree bindings
      ASoC: davinci: davinci-pcm does not need to be a plaform_driver
      ARM: Davinci: Remove references to davinci pcm
      ASoC/ARM: Davinci: McASP: split asp header into platform and audio sp=
ecific
      ASoC: Davinci: McASP: add device tree support for McASP
      ASoC: Davinci: evm: Fix typo in cpu dai name
      ASoC: Davinci: McASP: add support new McASP IP Variant

Javier Martin (1):
      ASoC: Revert 'ASoC: imx-ssi: Remove mono support'

Jerry Snitselaar (1):
      ASoC: core: remove unused variable in soc_probe() in linux-next

Kuninori Morimoto (3):
      ASoC: fsi: fixup pm_runtime_disable() timing on fsi_probe()
      ASoC: fsi: tidyup: remove un-necessary operation from fsi_probe()
      ASoC: fsi: convert to devm_xxx()

Lars-Peter Clausen (4):
      ASoC: Remove unused 'saved_value' field from snd_soc_dapm_widget stru=
ct
      ASoC: ad193x: Use managed regmap init
      ASoC: ad1836: Convert to direct regmap usage.
      ASoC: Avoid recalculating the bitmask for SOC_ENUM controls

Lee Jones (1):
      ASoC: ux500: Strengthen error checking after memory allocation

Mark Brown (79):
      ASoC: wm8994: Implement support for self-oscillation mode in the FLL
      ASoC: jack: Always update jack state even for noop changes
      ASoC: wm_hubs: Move CODEC stored in private data into wm_hubs
      ASoC: wm8994: Ensure we get a notification on startup for jackdet
      ASoC: wm_hubs: Factor out DC servo readback code
      ASoC: wm_hubs: Rename calibrate_dc_servo()
      ASoC: wm8994: Fix some indentation issues
      ASoC: ab8500: Remove pointless cast
      ASoC: wm9712: Fix funky indentation
      ASoC: wm9712: Fix name of Capture Switch
      ASoC: sta529: Staticise non-exported codec driver struct
      ASoC: imx-ssi: Say if we fail to register a second AC'97 bus
      ASoC: core: Remove pointless error on card registration failure
      ASoC: arizona: Implement OPCLK support
      ASoC: wm5102: Enable output clocks
      ASoC: wm5110: Enable output clocks
      ASoC: bells: Add machine driver for Wolfson Bells boards
      Merge remote-tracking branch 'asoc/topic/omap' into for-3.7
      ASoC: wm5102: Add AEC routing control
      ASoC: wm8994: Add bytes controls for DRC
      Merge remote-tracking branch 'asoc/topic/blackfin' into for-3.7
      ASoC: wm9712: Provide TLV information for capture boost controls
      ASoC: wm_hubs: Use explicit casts for converting to signed
      ASoC: wm_hubs: Add trace showing semantics of the DCS update
      ASoC: wm_hubs: Allow configuration of MICBIAS power up delay via pdata
      Merge branch 'asoc-omap' into for-3.7
      Merge branch 'asoc-omap' into for-3.7
      ASoC: wm8994: Update for new WM1811 variants
      ASoC: wm0010: Fix passthrough routing
      ASoC: samsung: Add hookup of WM0010 on Speyside
      ASoC: wm0010: Enable 44.1kHz support
      ASoC: wm0010: Add dummy widget for CLKIN
      ASoC: wm0010: Set idle_bias_off
      ASoC: wm0010: Don't double free reset GPIO
      ASoC: wm0010: Tweak diagnostic output
      ASoC: wm0010: Move resource acquisition to device probe
      Merge branch 'asoc-omap' into for-3.7
      Merge tag 'v3.6-rc4' into asoc-omap
      Merge branch 'asoc-omap' into for-3.7
      ASoC: dapm: Ensure bypass paths are suspended and resumed
      ASoC: dapm: Add flags to regulator supplies
      ASoC: wm8983: Convert to devm_kzalloc()
      ASoC: wm8983: Convert to direct regmap API usage
      ASoC: wm8523: Convert to devm_kzalloc()
      ASoC: wm8523: Move regulator acquisition to I2C probe()
      ASoC: wm8523: Convert to direct regmap API usage
      ASoC: wm8523: Move device ID verification and reset to I2C probe
      ASoC: sta32x: Move regulator acquisition to I2C probe
      ASoC: sta32x: Convert to regmap
      ASoC: wm8741: Move regulator acquisition to I2C/SPI probe()
      ASoC: wm8741: Convert to direct regmap API usage
      ASoC: wm8960: Convert to direct regmap API usage
      ASoC: cs4270: Conver to data based control init
      ASoC: cs4270: Move regulator acquisition to I2C probe()
      ASoC: cs4270: Convert to direct regmap API usage
      ASoC: wm8900: Convert to devm_kzalloc()
      ASoC: wm8900: Convert to direct regmap API usage
      ASoC: wm8900: Fix typo of name to wm9700
      ASoC: wm8510: Convert to devm_kzalloc()
      ASoC: wm8580: Convert to devm_kzalloc()
      ASoC: wm8711: Convert to devm_kzalloc()
      ASoC: wm8728: Convert to devm_kzalloc()
      ASoC: wm8737: Convert to devm_kzalloc()
      ASoC: wm8990: Convert to devm_kzalloc()
      ASoC: wm8991: Convert to devm_kzalloc()
      ASoC: wm8510: Convert to direct regmap API usage
      ASoC: wm8580: Convert to direct regmap API usage
      ASoC: wm8580: Move regulator acquisition to I2C probe
      ASoC: wm8711: Convert to direct regmap API usage
      ASoC: wm8728: Convert to direct regmap API usage
      ASoC: wm8737: Move regulator acquisition to device registration
      ASoC: wm8737: Convert to direct regmap API usage
      ASoC: arizona: Clarify logging for FLL lock status interrupt
      ASoC: core: Mark regmap CODEC register maps as dirty when suspending
      ASoC: wm8776: Convert to direct regmap API usage
      ASoC: wm8960: Support shared LRCLK
      ASoC: wm8961: Convert to direct regmap API usage
      ASoC: wm8961: Move device identification and reset to I2C probe
      Merge tag 'v3.6-rc6' into for-3.7

Namarta Kohli (1):
      ASoC: add compress stream support

Peter Senna Tschudin (1):
      ASoC: core: Remove useless kfree

Peter Ujfalusi (54):
      ASoC: omap-mcpdm: Convert to use devm_*
      ASoC: omap-abe-twl6040: Add device tree support
      ASoC: core: Set dapm->idle_bias_off for DAIs not mapped with a codec
      ASoC: omap-twl4030: Simple machine driver for TI SoC with twl4030 cod=
ec
      ARM: OMAP: twl-common: Add helper function to register the omap-twl40=
30 audio driver
      ARM: OMAP3: Switch to use the unified audio driver (omap-twl4030) for=
 selected boards
      ASoC: Remove obsolete OMAP3 machine drivers
      ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting code to ASoC driver
      ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
      ARM: OMAP: board-am3517evm: Configure McBSP1 CLKR/FSR signal source
      ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
      ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
      ASoC: omap-mcbsp: Remove unused defines
      ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the code
      ARM: OMAP2+: McBSP: Do not create legacy devices when booting with DT=
 data
      ASoC: omap-mcbsp: Add device tree bindings
      ASoC: omap-mcbsp: Device tree binding documentation update
      ARM: OMAP2+: twl-common: Fix compile time error when omap-twl4030 aud=
io is not enabled
      ASoC: omap-mcbsp: Check mcbsp->id instead of cpu_dai->id when adding =
ST controls
      ASoC: omap-mcbsp: Only print warning if the st_data is missing for th=
e port
      ASoC: omap-mcbsp: Use macro to create the McBSP2/3 ST controls
      ASoC: omap-mcbsp: Single macro for st channel volume set/get
      ASoC: omap-mcbsp: Fix compilation error due to leftover code
      ASoC: am3517evm: Remove unused cpu_dai from hw_params
      ASoC: twl4030: Convert to use DAI DAPM widgets
      ASoC: twl6040: Convert to use DAI DAPM widgets
      dmaengine: omap: Support for element mode in cyclic DMA
      dmaengine: omap: Add support for pause/resume in cyclic dma mode
      dmaengine: Pass flags via device_prep_dma_cyclic() callback
      dmaengine: omap-dma: Add support to suppress interrupts in cyclic mode
      ASoC: omap-mcbsp: Use sDMA packet mode instead of frame mode
      ASoC: omap-pcm: Select sDMA synchronization based on packet_size
      ASoC: OMAP: Remove sync_mode from omap_pcm_dma_data struct
      ASoC: omap-pcm: Prepare to configure the DMA data_type based on strea=
m properties
      ARM: OMAP4: hwmod_data: Add resource names to McPDM memory ranges
      ASoC: omap-mcpdm: Use platform_get_resource_* to get resources
      ASoC: OMAP: mcbsp, mcpdm, dmic: Let omap-pcm to pick the dma_type
      ASoC: omap-pcm, omap-dmic: Change the use of omap_pcm_dma_data->data_=
type
      ASoC: OMAP: mcbsp, mcpdm, dmic, hdmi: Set dma_data at startup time
      ASoC: omap-pcm: Convert to use dmaengine
      mfd: twl4030-audio: Clean up MODULE_* and platform_driver part
      mfd: twl4030-audio: Convert to use devm_kzalloc
      mfd: twl4030-audio: Rearange and clean-up the probe function
      mfd: twl-core: Add API to query the HFCLK rate
      mfd: twl4030-audio: Get audio MCLK via twl-core API instead of pdata
      dt: Add empty of_find_node_by_name() function
      mfd: twl4030-audio: Add DT support
      Input: twl4030-vibra: Support for DT booted kernel
      ASoC: twl4030: Move hs_extmute GPIO handling to driver
      ARM: OMAP/ASoC: Zoom2: Let the codec to handle the hs_extmute GPIO
      ASoC/mfd: twl4030: Remove set_hs_extmute callback from platform data
      ASoC: twl4030: Convert to use devm_kzalloc
      ASoC: twl4030: Add pointer to pdata within the private data
      ASoC: twl4030: Support for DT booted kernel

Richard Zhao (3):
      ASoC: imx-pcm-dma: check kzalloc return value in function snd_imx_open
      ASoC: imx-pcm-dma: open function failed when snd_dmaengine_pcm_open f=
ail
      ASoC: imx-audmux: remove null check of audmux_base in audmux_read_file

Sachin Kamat (33):
      ASoC: isabelle: Remove version.h header file inclusion
      ASoC: tlv320aic32x4: Use module_i2c_driver
      ASoC: max9877: Use module_i2c_driver
      ASoC: wm9090: Use module_i2c_driver
      ASoC: wm8991: Use module_i2c_driver
      ASoC: cs4270: Use module_i2c_driver
      ASoC: tlv320aic3x: Use module_i2c_driver
      ASoC: sta32x: Use module_i2c_driver
      ASoC: tlv320dac33: Use module_i2c_driver
      ASoC: adau1701: Use module_i2c_driver
      ASoC: max9850: Use module_i2c_driver
      ASoC: wm8971: Use module_i2c_driver
      ASoC: ak4671: Use module_i2c_driver
      ASoC: lm4857: Use module_i2c_driver
      ASoC: wm8978: Use module_i2c_driver
      ASoC: max98088: Use module_i2c_driver
      ASoC: wm8955: Use module_i2c_driver
      ASoC: wm2200: Use module_i2c_driver
      ASoC: wm2000: Use module_i2c_driver
      ASoC: wm8940: Use module_i2c_driver
      ASoC: wm8961: Use module_i2c_driver
      ASoC: wm8903: Use module_i2c_driver
      ASoC: adau1373: Use module_i2c_driver
      ASoC: wm8960: Use module_i2c_driver
      ASoC: wm8974: Use module_i2c_driver
      ASoC: max98095: Use module_i2c_driver
      ASoC: cs42l51: Use module_i2c_driver
      ASoC: tpa6130a2: Use module_i2c_driver
      ASoC: cs42l52: Remove duplicate inclusion of slab.h header file
      ASoC: soc-compress: Remove unused variable
      ASoC: tlv320aic26: Use module_spi_driver
      ASoC: wm8770: Use module_spi_driver
      ASoC: ad1836: Use module_spi_driver

Sangsu Park (1):
      ASoC: SAMSUNG: Change Kconfig to support all SAMSUNG ASoC

Scott Jiang (2):
      ASoC: bf5xx-ad1836: convert to use snd_soc_register_card
      blackfin: add platform device for ad1836 machine driver

Shawn Guo (1):
      ASoC: mx27vis: retrieve gpio numbers from platform_data

Stephen Warren (1):
      ASoC: tegra: move platform data header

Timur Tabi (4):
      ASoC: fsl: use snd_soc_register_card to register the card
      ASoC: fsl: remove unnecessary call to dma_unmap_single
      ASoC: wm8960: add support for big-endian audio samples
      ASoC: wm8960: remove 'dres' field from platform data structure

Vinod Koul (3):
      ASoC: add definations for compressed operations
      ASoC: mid-x86 - add support for compressed streams
      ASoC: compress - fix code alignment

 .../devicetree/bindings/mfd/twl4030-audio.txt      |   46 +
 Documentation/devicetree/bindings/sound/cs4270.txt |   21 +
 .../bindings/sound/davinci-mcasp-audio.txt         |   45 +
 .../devicetree/bindings/sound/omap-abe-twl6040.txt |   91 ++
 .../devicetree/bindings/sound/omap-mcbsp.txt       |   37 +
 .../devicetree/bindings/sound/omap-twl4030.txt     |   17 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   20 +
 arch/arm/mach-davinci/asp.h                        |   49 +
 arch/arm/mach-davinci/davinci.h                    |    3 +-
 arch/arm/mach-davinci/devices-da8xx.c              |    8 +-
 arch/arm/mach-davinci/devices.c                    |   11 -
 arch/arm/mach-davinci/dm355.c                      |    2 +-
 arch/arm/mach-davinci/dm365.c                      |    2 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/dm646x.c                     |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   42 +-
 arch/arm/mach-omap2/board-am3517evm.c              |   13 +
 arch/arm/mach-omap2/board-cm-t35.c                 |    1 +
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    1 +
 arch/arm/mach-omap2/board-omap3evm.c               |    1 +
 arch/arm/mach-omap2/board-overo.c                  |    1 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    9 +-
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    2 -
 arch/arm/mach-omap2/mcbsp.c                        |  126 +--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +
 arch/arm/mach-omap2/twl-common.c                   |   27 +
 arch/arm/mach-omap2/twl-common.h                   |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h            |    2 -
 arch/blackfin/mach-bf527/boards/ezkit.c            |   20 +
 arch/blackfin/mach-bf533/boards/stamp.c            |   20 +
 arch/blackfin/mach-bf537/boards/stamp.c            |   20 +
 arch/blackfin/mach-bf561/boards/ezkit.c            |   20 +
 arch/blackfin/mach-bf609/boards/ezkit.c            |   19 +
 drivers/dma/at_hdmac.c                             |    3 +-
 drivers/dma/ep93xx_dma.c                           |    4 +-
 drivers/dma/imx-dma.c                              |    2 +-
 drivers/dma/imx-sdma.c                             |    2 +-
 drivers/dma/mmp_tdma.c                             |    2 +-
 drivers/dma/mxs-dma.c                              |    2 +-
 drivers/dma/omap-dma.c                             |   45 +-
 drivers/dma/pl330.c                                |    2 +-
 drivers/dma/sa11x0-dma.c                           |    2 +-
 drivers/dma/sirf-dma.c                             |    2 +-
 drivers/dma/ste_dma40.c                            |    3 +-
 drivers/dma/tegra20-apb-dma.c                      |    2 +-
 drivers/input/misc/twl4030-vibra.c                 |   18 +-
 drivers/mfd/twl-core.c                             |   32 +
 drivers/mfd/twl4030-audio.c                        |  105 ++-
 include/linux/dmaengine.h                          |    4 +-
 include/linux/i2c/twl.h                            |    3 +-
 include/linux/mfd/wm8994/pdata.h                   |    4 +
 include/linux/of.h                                 |    6 +
 include/linux/platform_data/asoc-mx27vis.h         |   11 +
 .../linux/platform_data/davinci_asp.h              |   74 +-
 include/linux/platform_data/omap-twl4030.h         |   32 +
 include/sound/compress_driver.h                    |    1 +
 include/sound/soc-dai.h                            |    3 +
 include/sound/soc-dapm.h                           |    7 +-
 include/sound/soc.h                                |   20 +-
 .../sound/tegra_wm8903.h                           |    7 +-
 include/sound/wm0010.h                             |   27 +
 include/sound/wm8960.h                             |    2 +-
 include/sound/wm8993.h                             |    4 +
 sound/soc/Kconfig                                  |    3 +-
 sound/soc/Makefile                                 |    4 +-
 sound/soc/blackfin/bf5xx-ad1836.c                  |   73 +-
 sound/soc/{ep93xx =3D> cirrus}/Kconfig               |    0
 sound/soc/{ep93xx =3D> cirrus}/Makefile              |    0
 sound/soc/{ep93xx =3D> cirrus}/edb93xx.c             |    0
 sound/soc/{ep93xx =3D> cirrus}/ep93xx-ac97.c         |    0
 sound/soc/{ep93xx =3D> cirrus}/ep93xx-i2s.c          |    0
 sound/soc/{ep93xx =3D> cirrus}/ep93xx-pcm.c          |    0
 sound/soc/{ep93xx =3D> cirrus}/ep93xx-pcm.h          |    0
 sound/soc/{ep93xx =3D> cirrus}/simone.c              |    0
 sound/soc/{ep93xx =3D> cirrus}/snappercl15.c         |    0
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ab8500-codec.c                    |   13 +-
 sound/soc/codecs/ad1836.c                          |   88 +-
 sound/soc/codecs/ad193x.c                          |   50 +-
 sound/soc/codecs/ad1980.c                          |    1 -
 sound/soc/codecs/adau1373.c                        |   12 +-
 sound/soc/codecs/adau1701.c                        |   12 +-
 sound/soc/codecs/ak4671.c                          |   12 +-
 sound/soc/codecs/arizona.c                         |   68 +-
 sound/soc/codecs/arizona.h                         |    6 +-
 sound/soc/codecs/cs4270.c                          |  152 ++--
 sound/soc/codecs/cs42l51.c                         |   19 +-
 sound/soc/codecs/cs42l52.c                         |    1 -
 sound/soc/codecs/isabelle.c                        |    1 -
 sound/soc/codecs/lm4857.c                          |   12 +-
 sound/soc/codecs/max98088.c                        |   18 +-
 sound/soc/codecs/max98095.c                        |   18 +-
 sound/soc/codecs/max9850.c                         |   12 +-
 sound/soc/codecs/max9877.c                         |   12 +-
 sound/soc/codecs/mc13783.c                         |   60 +-
 sound/soc/codecs/sta32x.c                          |  151 ++--
 sound/soc/codecs/sta529.c                          |    2 +-
 sound/soc/codecs/stac9766.c                        |    1 -
 sound/soc/codecs/tlv320aic26.c                     |   12 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   19 +-
 sound/soc/codecs/tlv320aic3x.c                     |   49 +-
 sound/soc/codecs/tlv320dac33.c                     |   19 +-
 sound/soc/codecs/tpa6130a2.c                       |   13 +-
 sound/soc/codecs/twl4030.c                         |  157 +++-
 sound/soc/codecs/twl6040.c                         |   43 +-
 sound/soc/codecs/wm0010.c                          |  944 ++++++++++++++++=
++++
 sound/soc/codecs/wm2000.c                          |   12 +-
 sound/soc/codecs/wm2200.c                          |   16 +-
 sound/soc/codecs/wm5100.c                          |    6 +-
 sound/soc/codecs/wm5102.c                          |   52 +-
 sound/soc/codecs/wm5110.c                          |   18 +-
 sound/soc/codecs/wm8510.c                          |  129 ++-
 sound/soc/codecs/wm8523.c                          |  184 ++--
 sound/soc/codecs/wm8580.c                          |  149 ++-
 sound/soc/codecs/wm8711.c                          |   65 +-
 sound/soc/codecs/wm8728.c                          |   60 +-
 sound/soc/codecs/wm8737.c                          |  132 +--
 sound/soc/codecs/wm8741.c                          |  115 ++-
 sound/soc/codecs/wm8770.c                          |   19 +-
 sound/soc/codecs/wm8776.c                          |   75 +-
 sound/soc/codecs/wm8900.c                          |  166 ++--
 sound/soc/codecs/wm8903.c                          |   18 +-
 sound/soc/codecs/wm8904.c                          |    2 -
 sound/soc/codecs/wm8940.c                          |   18 +-
 sound/soc/codecs/wm8955.c                          |   18 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   28 +-
 sound/soc/codecs/wm8960.c                          |  150 +++-
 sound/soc/codecs/wm8961.c                          |  492 ++++------
 sound/soc/codecs/wm8971.c                          |   18 +-
 sound/soc/codecs/wm8974.c                          |   18 +-
 sound/soc/codecs/wm8978.c                          |   18 +-
 sound/soc/codecs/wm8983.c                          |  162 ++--
 sound/soc/codecs/wm8990.c                          |    8 +-
 sound/soc/codecs/wm8991.c                          |   25 +-
 sound/soc/codecs/wm8993.c                          |    2 +
 sound/soc/codecs/wm8994.c                          |  132 ++-
 sound/soc/codecs/wm8994.h                          |   12 +-
 sound/soc/codecs/wm8996.c                          |    2 +-
 sound/soc/codecs/wm9090.c                          |   12 +-
 sound/soc/codecs/wm9712.c                          |   12 +-
 sound/soc/codecs/wm9713.c                          |    1 -
 sound/soc/codecs/wm_hubs.c                         |  114 ++-
 sound/soc/codecs/wm_hubs.h                         |    6 +
 sound/soc/davinci/davinci-evm.c                    |   19 +-
 sound/soc/davinci/davinci-i2s.c                    |   13 +-
 sound/soc/davinci/davinci-mcasp.c                  |  260 +++++-
 sound/soc/davinci/davinci-mcasp.h                  |    6 +-
 sound/soc/davinci/davinci-pcm.c                    |   24 +-
 sound/soc/davinci/davinci-pcm.h                    |    6 +-
 sound/soc/davinci/davinci-sffsdr.c                 |    2 +-
 sound/soc/davinci/davinci-vcif.c                   |    8 +
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl_dma.c                            |    6 -
 sound/soc/fsl/imx-audmux.c                         |    3 -
 sound/soc/fsl/imx-pcm-dma.c                        |    5 +-
 sound/soc/fsl/imx-ssi.c                            |   30 +-
 sound/soc/fsl/mpc5200_dma.c                        |   24 +-
 sound/soc/fsl/mpc5200_dma.h                        |    3 +
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   10 +
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    8 +
 sound/soc/fsl/mpc8610_hpcd.c                       |   32 +-
 sound/soc/fsl/mx27vis-aic32x4.c                    |   42 +-
 sound/soc/fsl/p1022_ds.c                           |   31 +-
 sound/soc/fsl/pcm030-audio-fabric.c                |  100 ++-
 sound/soc/mid-x86/mfld_machine.c                   |    9 +
 sound/soc/mid-x86/sst_dsp.h                        |  134 +++
 sound/soc/mid-x86/sst_platform.c                   |  204 ++++-
 sound/soc/mid-x86/sst_platform.h                   |   26 +-
 sound/soc/mxs/mxs-saif.c                           |   20 +-
 sound/soc/omap/Kconfig                             |   51 +-
 sound/soc/omap/Makefile                            |   10 +-
 sound/soc/omap/am3517evm.c                         |   21 +-
 sound/soc/omap/igep0020.c                          |  120 ---
 sound/soc/omap/mcbsp.c                             |   54 +-
 sound/soc/omap/mcbsp.h                             |    3 -
 sound/soc/omap/omap-abe-twl6040.c                  |  145 ++-
 sound/soc/omap/omap-dmic.c                         |    9 +-
 sound/soc/omap/omap-hdmi.c                         |   17 +-
 sound/soc/omap/omap-mcbsp.c                        |  230 ++---
 sound/soc/omap/omap-mcbsp.h                        |   20 -
 sound/soc/omap/omap-mcpdm.c                        |   92 +-
 sound/soc/omap/omap-pcm.c                          |  236 ++---
 sound/soc/omap/omap-pcm.h                          |    4 +-
 sound/soc/omap/omap-twl4030.c                      |  188 ++++
 sound/soc/omap/omap3beagle.c                       |  150 ----
 sound/soc/omap/omap3evm.c                          |  118 ---
 sound/soc/omap/overo.c                             |  122 ---
 sound/soc/omap/zoom2.c                             |    4 -
 sound/soc/samsung/Kconfig                          |   11 +-
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/bells.c                          |  346 +++++++
 sound/soc/samsung/speyside.c                       |   42 +-
 sound/soc/sh/fsi.c                                 |   28 +-
 sound/soc/soc-compress.c                           |  294 ++++++
 sound/soc/soc-core.c                               |  100 ++-
 sound/soc/soc-dapm.c                               |   44 +-
 sound/soc/soc-jack.c                               |    6 -
 sound/soc/tegra/tegra_wm8903.c                     |    3 +-
 sound/soc/ux500/ux500_msp_dai.c                    |    3 +
 sound/soc/ux500/ux500_msp_i2s.c                    |    2 +
 204 files changed, 5905 insertions(+), 3245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs4270.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-a=
udio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl604=
0.txt
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcbsp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt
 create mode 100644 arch/arm/mach-davinci/asp.h
 create mode 100644 include/linux/platform_data/asoc-mx27vis.h
 rename arch/arm/mach-davinci/include/mach/asp.h =3D> include/linux/platfor=
m_data/davinci_asp.h (56%)
 create mode 100644 include/linux/platform_data/omap-twl4030.h
 rename arch/arm/mach-tegra/include/mach/tegra_wm8903_pdata.h =3D> include/=
sound/tegra_wm8903.h (89%)
 create mode 100644 include/sound/wm0010.h
 rename sound/soc/{ep93xx =3D> cirrus}/Kconfig (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/Makefile (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/edb93xx.c (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/ep93xx-ac97.c (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/ep93xx-i2s.c (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/ep93xx-pcm.c (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/ep93xx-pcm.h (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/simone.c (100%)
 rename sound/soc/{ep93xx =3D> cirrus}/snappercl15.c (100%)
 create mode 100644 sound/soc/codecs/wm0010.c
 create mode 100644 sound/soc/mid-x86/sst_dsp.h
 delete mode 100644 sound/soc/omap/igep0020.c
 create mode 100644 sound/soc/omap/omap-twl4030.c
 delete mode 100644 sound/soc/omap/omap3beagle.c
 delete mode 100644 sound/soc/omap/omap3evm.c
 delete mode 100644 sound/soc/omap/overo.c
 create mode 100644 sound/soc/samsung/bells.c
 create mode 100644 sound/soc/soc-compress.c
