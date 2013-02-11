From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.9
Date: Mon, 11 Feb 2013 12:45:06 +0000
Message-ID: <20130211124505.GF4607@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7367632202805112143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CF2F2616CF
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 13:45:08 +0100 (CET)
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


--===============7367632202805112143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.9

for you to fetch changes up to 699ba4546cfe3f4eee73aff4f307bf16362f9232:

  Merge remote-tracking branch 'asoc/topic/wm8993' into asoc-next (2013-02-=
11 11:06:55 +0000)

----------------------------------------------------------------

ASoC: Updates for v3.9

A fairly quiet release for ASoC:

- Support for a wider range of hardware in the compressed stream code.
- The ability to mute capture streams as well as playback streams while
  inactive.
- DT support for AK4642, FSI, Samsung I2S and WM8962.
- AC'97 support for Tegra.
- New driver for max98090, replacing the stub which was there.

Due to dependencies we've also got support for asynchronous I/O in regmap
and DTification of DMA support for Samsung platforms (used only by the
I2S driver and SPI) merged here as well.

----------------------------------------------------------------
Alexey Galakhov (1):
      ASoC: samsung: Fix compilation error on S3C2440

Andrey Smirnov (2):
      regmap: Add provisions to have user-defined read operation
      regmap: Add provisions to have user-defined write operation

Axel Lin (2):
      ASoC: cs42l52: Convert to devm_input_allocate_device()
      regmap: Export regmap_async_complete_cb

Beno=EEt Th=E9baudeau (1):
      ASoC: tlv320aic3x: Remove mono support

Bo Shen (4):
      ASoC: atmel_pcm: make it buildable as module
      ASoC: atmel_ssc_dai: remove error set private data
      ASoC: atmel_ssc_dai: correct sequence when unload
      ASoC: sam9g20_wm8731: disable clock and correct sequence when unload

Charles Keepax (5):
      ASoC: wm_adsp: Release firmware on error
      ASoC: soc-compress: Add missing brackets around else
      ASoC: soc-compress: Serialise compressed ops
      ASoC: soc-compress: Initialise delayed work to power down audio
      ASoC: soc-compress: Add support for not memory mapped DSPs

Chris Rattray (6):
      ASoC: wm_adsp: Set ADSP1 clock rate to match sys clock
      ASoC: wm2200: Set system clock control register is adsp structs
      ASoC: wm2200: Add Rx ANC input select control
      ASoC: wm2200: correct IN2L and IN3L digital mute
      ASoC: wm2200: Provide platform data for MICBIAS configuration
      ASoC: wm_adsp: round to 4-byte boundary for coeff file blocks

Chuansheng Liu (1):
      ASoC: core: giving WARN when device starting from non-off bias with i=
dle_bias_off

Dan Carpenter (2):
      ASoC: pcm: delete some dead code
      ASoC: dwc: fix support for more than two channels

Daniel Mack (1):
      ALSA: ASoC: cs4271: add optional soft reset workaround

Fabio Estevam (6):
      ASoC: wm8962: Add device tree support
      ASoC: wm8804: Remove redundant check
      ASoC: wm8993: Refactor set_pll code to avoid GCC warnings
      ASoC: wm8985: Refactor set_pll code to avoid gcc warnings
      ASoC: mxs-saif: Remove platform data
      ASoC: mxs-saif: Use a signed integer for error value

Hebbar Gururaja (1):
      ASoC: tlv320aic3x: Convert mic bias to a supply widget

Jerry Wong (2):
      ASoC: Replace max98090 Device Driver
      ASoC: Replace max98090 Device Driver

Joachim Eastwood (2):
      ASoC: atmel-ssc: make it buildable on other architectures
      ASoC: atmel-soc: make it buildable on other architectures

Kuninori Morimoto (12):
      ASoC: fsi: remove platform depended .set_rate() callback support
      ASoC: fsi: remove SH_FSI_xxx_INV flags
      ASoC: fsi: cleanup sh_fsi.h
      ASoC: simple-card: use struct device pointer for dev_xxx()
      ASoC: fsi: don't use platform info pointer on probe()
      ASoC: ak4642: add Device Tree support
      ASoC: simple-card: add asoc_simple_dai for initializing
      ASoC: fsi: add device tree support
      ASoC: SND_SOC_DAIFMT_NB_NF become 0 as default settings
      ASoC: add snd_soc_of_parse_daifmt() for DeviceTree
      ASoC: SND_SOC_DAIFMT_GATED become 0 as default settings
      ASoC: clock gating is decided by bool on snd_soc_of_parse_daifmt()

Lars-Peter Clausen (1):
      ASoC: Constify ops and compr_ops fields of snd_soc_dai_link

Lee Jones (1):
      ASoC: Ux500: Fix build error pertaining to missing include file

Lucas Stach (4):
      ASoC: tegra: add function to set ac97 rate
      ASoC: tegra: setup DAP3<->DAC3 connection by default
      ASoC: tegra: add ac97 host driver
      ASoC: tegra: add tegra machine driver using wm9712 codec

Mark Brown (97):
      ASoC: wm8962: Convert to devm_input_allocate_device()
      ASoC: wm8962: Unconditionally wait for the FLL to lock
      ASoC: wm5102: Split input PGA controls
      ASoC: wm5110: Split input PGA controls
      ASoC: arizona: Add noise gate hold time enumeration
      ASoC: wm5102: Add noise gate control
      ASoC: wm5110: Add noise gate control
      ASoC: arizona: Implement tristate support
      ASoC: wm2000: Integrate with clock API
      ASoC: wm2000: Use clock API integration to configure MCLK divisor
      Merge branch 'asoc-fix-cs4271' into asoc-cs4271
      ASoC: wm5102: Implement routing and power management for ISRCs
      ASoC: arizona: Allow runtime reconfiguration of the output mode
      Merge branch 'fix/arizona' of git://git.kernel.org/.../broonie/sound =
into asoc-arizona
      ASoC: arizona: Factor out rate selection code
      Merge remote-tracking branch 'asoc/fix/pxa' into asoc-pxa
      ASoC: wm_adsp: Add support for parsing algorithms
      ASoC: wm_adsp: Factor out calculation of memory base addresses
      ASoC: wm_asdp: Validate sanity of algorithm count
      ASoC: wm_adsp: Implement support for algorithm-specific coefficient b=
locks
      ASoC: wm_adsp: Add basic firmware selection support
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-arizona
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-arizona
      Merge branch 'topic/fsi' of git://git.kernel.org/.../broonie/sound in=
to asoc-simple-card
      ASoC: wm_adsp: Add initialisation function for ADSP1
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-wm2200
      ASoC: wm2200: Initialise the ADSPs
      ASoC: arizona: Don't request FLL lock IRQ
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-arizona
      ASoC: wm_adsp: Implement support for coefficeint file format 1
      ASoC: wm2200: Add controls for firmware enumeration
      ASoC: wm5102: Add controls for firmware selection
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-wm2200
      ASoC: wm5100: Implement DRC, EQ and LHPF coefficient configuration
      ASoC: wm2200: Implement EQ and LHPF coefficient configuration
      ASoC: wm_adsp: Make region identification errors more informative
      ASoC: wm_adsp: Use GFP_DMA for algorithm readback
      ASoC: arizona: Support clearing clocks
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-adsp
      ASoC: wm_adsp: Provide explicit trace of coefficient writes
      ASoC: arizona: Allow number of channels clocked to be restricted
      ASoC: core: Ensure SND_SOC_BYTES writes are from DMA safe memory
      ASoC: wm_adsp: Correct handling of some coefficeint blocks
      ASoC: wm2000: Expose some additional registers
      ASoC: wm_adsp: Add speaker Tx as a firmware option
      ASoC: wm_adsp: Accept 0 as a parameter block address
      ASoC: wm_adsp: Ensure ADSP2 DMAs are quiesced when DSP is halted
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-adsp
      regmap: Add asynchronous I/O support
      regmap: spi: Support asynchronous I/O for SPI
      ASoC: wm_adsp: Fix support for firmware switching on DSP2 and higher
      ASoC: wm2000: Lock state machine updates
      ASoC: wm2000: Expose ANC gain adjustment
      Merge tag 'async' of git://git.kernel.org/.../broonie/regmap into aso=
c-adsp
      ASoC: wm_adsp: Use asynchronous I/O to write firmware and coefficients
      regmap: Export regmap_async_complete()
      Merge tag 'async' of git://git.kernel.org/.../broonie/regmap into aso=
c-adsp
      ASoC: arizona: Fix debug logging level for FLLs and AIFs
      ASoC: compress: Only mute playback streams
      ASoC: core: Allow digital mute for capture
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/fix/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/fix/dwc' into asoc-next
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-next
      Merge remote-tracking branch 'asoc/fix/ux500' into asoc-next
      Merge remote-tracking branch 'asoc/fix/wm2000' into asoc-next
      Merge remote-tracking branch 'asoc/fix/wm2200' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak4642' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l52' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/topic/mxs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/of' into asoc-next
      Merge remote-tracking branch 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/simple-card' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320dac33' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm2000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm2200' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm5100' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8350' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8804' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8985' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8993' into asoc-next

Michal Bachraty (1):
      ASoC: McASP: Fix data rotation for playback. Enables 24bit audio play=
back

Mike Dunn (3):
      ASoC: palm27x: fix widgets and routes in dai_link init
      ASoC: palm27x: register card in platform_driver probe
      ALSA: pxa27x: rename pxa27x_assert_ac97reset()

Misael Lopez Cruz (1):
      ASoC: twl6040: Convert PLUGINT to no-suspend irq

Padmavathi Venna (10):
      ASoC: samsung: Rename samsung i2s secondary device name
      ASoC: Samsung: Add I2S S/W RST in startup function
      ASoC: samsung: Add DT support for i2s
      ARM: SAMSUNG: Make dma request compatible to generic dma bindings.
      spi: s3c64xx: Modify SPI driver to use generic DMA DT support
      ARM: dts: Add nodes for i2s controllers for Samsung Exynos5 platforms
      ARM: EXYNOS: Enable platform support for I2S controllers
      ASoC: SMDK: WM8994: Add device tree support for machine file
      ARM: dts: Modify SPI nodes according generic DMA DT bindings
      ASoC: Samsung: Update Kconfig for I2S,SPDIF and PCM audio

Peter Ujfalusi (15):
      ASoC: twl4030: Correct the support for Voice port
      ASoC: zoom2: No need to configure the Voice port anymore
      ASoC: sdp3430: No need to configure the Voice port anymore
      ASoC: twl4030: Convert MICBIAS to SUPPLY widget
      ASoC: twl4030: Configure extmute pinmux when the dedicated pin is in =
use
      ASoC: sdp3430: No need to configure pin mux for extmute
      ASoC: omap-twl4030: Add support for routing, voice port and jack dete=
ct
      ASoC: OMAP: Remove obsolete machine drivers for Zoom2 and SDP3430
      ASoC: twl4030: Remove suspend/resume soc driver operations
      ASoC: twl6040: Only set the bias_level once in twl6040_resume()
      ASoC: twl6040: Convert to use devm_* when possible
      ASoC: twl6040: Switch to use system workqueue for jack reporting
      ASoC: twl6040: Remove leftover code from hs/hf ramp implementation
      ASoC: tlv320dac33: Remove suspend/resume soc driver operations
      ASoC: omap-pcm: No need to set constraint at open time

R. Chandrasekar (1):
      ASoC: Samsung: I2S: Add support for runtime S2R

Ricardo Neri (1):
      ASoC: OMAP: HDMI: Initialize IEC-60958 channel status word

Ryo Tsutsui (1):
      ASoC: arizona: Fixed a bug in FLL fractional calculation

Sachin Kamat (4):
      ASoC: tegra_wm9712: Remove __devinitconst attribute
      ASoC: tegra20_ac97: Remove __devinitconst attribute
      ASoC: tegra: Use NULL instead of 0 for pointers
      ASoC: tegra: Staticize some functions in tegra30_i2s.c

Stephen Rothwell (1):
      ASoC: ak4642: remove __devinitconst annotation

Stephen Warren (1):
      regmap: include linux/sched.h to fix build

Tejun Heo (1):
      ASoC: wm8350: don't use [delayed_]work_pending()

Thierry Reding (1):
      ASoC: fsi: Remove __devinitconst

 Documentation/devicetree/bindings/sound/ak4642.txt |   17 +
 Documentation/devicetree/bindings/sound/cs4271.txt |   12 +
 .../bindings/sound/nvidia,tegra-audio-wm9712.txt   |   51 +
 .../bindings/sound/nvidia,tegra20-ac97.txt         |   22 +
 .../devicetree/bindings/sound/omap-twl4030.txt     |   46 +
 .../devicetree/bindings/sound/renesas,fsi.txt      |   26 +
 .../bindings/sound/samsung,smdk-wm8994.txt         |   14 +
 .../devicetree/bindings/sound/samsung-i2s.txt      |   63 +
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    6 +
 Documentation/devicetree/bindings/sound/wm8962.txt |   16 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   26 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   44 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    6 +
 arch/arm/mach-pxa/pxa27x.c                         |   20 +-
 arch/arm/mach-shmobile/board-ap4evb.c              |   42 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |   34 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |   20 +-
 arch/arm/mach-shmobile/board-mackerel.c            |   42 +-
 arch/arm/plat-samsung/dma-ops.c                    |   10 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    3 +-
 arch/arm/plat-samsung/s3c-dma-ops.c                |    3 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   27 +-
 arch/sh/boards/mach-se/7724/setup.c                |   29 +-
 drivers/base/regmap/internal.h                     |   18 +
 drivers/base/regmap/regmap-spi.c                   |   52 +
 drivers/base/regmap/regmap.c                       |  301 ++-
 drivers/misc/Kconfig                               |    2 +-
 drivers/misc/atmel-ssc.c                           |    2 +-
 drivers/spi/spi-s3c64xx.c                          |   77 +-
 include/linux/mfd/arizona/pdata.h                  |    9 +
 include/linux/regmap.h                             |   28 +
 include/sound/cs4271.h                             |   15 +
 include/sound/max98090.h                           |   29 +
 include/sound/saif.h                               |   16 -
 include/sound/sh_fsi.h                             |   70 +-
 include/sound/simple_card.h                        |   12 +-
 include/sound/soc-dai.h                            |    8 +-
 include/sound/soc.h                                |    6 +-
 include/sound/tlv320aic3x.h                        |   10 +
 include/sound/wm2000.h                             |    3 -
 include/sound/wm2200.h                             |   22 +-
 sound/arm/pxa2xx-ac97-lib.c                        |    8 +-
 sound/soc/atmel/Kconfig                            |    6 +-
 sound/soc/atmel/atmel-pcm-pdc.c                    |    4 +-
 sound/soc/atmel/atmel-pcm.c                        |    2 +-
 sound/soc/atmel/atmel-pcm.h                        |    6 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   14 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |    6 +-
 sound/soc/codecs/ak4642.c                          |   33 +-
 sound/soc/codecs/arizona.c                         |  247 +-
 sound/soc/codecs/arizona.h                         |    8 +-
 sound/soc/codecs/cs4271.c                          |   34 +
 sound/soc/codecs/cs42l52.c                         |    4 +-
 sound/soc/codecs/max98090.c                        | 2685 ++++++++++++++++=
----
 sound/soc/codecs/max98090.h                        | 1549 +++++++++++
 sound/soc/codecs/tlv320aic3x.c                     |   87 +-
 sound/soc/codecs/tlv320aic3x.h                     |    4 +
 sound/soc/codecs/tlv320dac33.c                     |   16 -
 sound/soc/codecs/twl4030.c                         |   85 +-
 sound/soc/codecs/twl6040.c                         |   62 +-
 sound/soc/codecs/wm2000.c                          |   66 +-
 sound/soc/codecs/wm2000.h                          |    3 +
 sound/soc/codecs/wm2200.c                          |   62 +-
 sound/soc/codecs/wm5100.c                          |   13 +
 sound/soc/codecs/wm5102.c                          |  172 +-
 sound/soc/codecs/wm5110.c                          |  111 +-
 sound/soc/codecs/wm8350.c                          |   10 +-
 sound/soc/codecs/wm8804.c                          |    3 -
 sound/soc/codecs/wm8962.c                          |   37 +-
 sound/soc/codecs/wm8983.c                          |   41 +-
 sound/soc/codecs/wm8985.c                          |   43 +-
 sound/soc/codecs/wm_adsp.c                         |  525 +++-
 sound/soc/codecs/wm_adsp.h                         |   18 +
 sound/soc/codecs/wmfw.h                            |   15 +-
 sound/soc/davinci/davinci-evm.c                    |    6 +-
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 sound/soc/dwc/designware_i2s.c                     |    4 +
 sound/soc/generic/simple-card.c                    |   63 +-
 sound/soc/mxs/mxs-saif.c                           |   49 +-
 sound/soc/omap/Kconfig                             |   19 +-
 sound/soc/omap/Makefile                            |    4 -
 sound/soc/omap/n810.c                              |    4 +-
 sound/soc/omap/omap-hdmi.c                         |    2 +
 sound/soc/omap/omap-pcm.c                          |   14 +-
 sound/soc/omap/omap-twl4030.c                      |  204 +-
 sound/soc/omap/omap3pandora.c                      |    8 +-
 sound/soc/omap/rx51.c                              |    8 +-
 sound/soc/omap/sdp3430.c                           |  278 --
 sound/soc/omap/zoom2.c                             |  207 --
 sound/soc/pxa/palm27x.c                            |   38 +-
 sound/soc/samsung/Kconfig                          |    6 +-
 sound/soc/samsung/dma.c                            |    3 +-
 sound/soc/samsung/dma.h                            |    1 +
 sound/soc/samsung/i2s.c                            |  267 +-
 sound/soc/samsung/i2s.h                            |    7 -
 sound/soc/samsung/s3c24xx-i2s.c                    |    2 +-
 sound/soc/samsung/smdk_wm8580.c                    |    7 +-
 sound/soc/samsung/smdk_wm8994.c                    |   30 +-
 sound/soc/sh/fsi.c                                 |  242 +-
 sound/soc/soc-compress.c                           |  123 +-
 sound/soc/soc-core.c                               |  135 +-
 sound/soc/soc-dapm.c                               |    6 +-
 sound/soc/soc-pcm.c                                |   19 +-
 sound/soc/tegra/Kconfig                            |   19 +
 sound/soc/tegra/Makefile                           |    4 +
 sound/soc/tegra/tegra20_ac97.c                     |  480 ++++
 sound/soc/tegra/tegra20_ac97.h                     |   95 +
 sound/soc/tegra/tegra20_das.c                      |   13 +
 sound/soc/tegra/tegra30_ahub.c                     |    4 +-
 sound/soc/tegra/tegra30_i2s.c                      |    4 +-
 sound/soc/tegra/tegra_asoc_utils.c                 |   53 +
 sound/soc/tegra/tegra_asoc_utils.h                 |    1 +
 sound/soc/tegra/tegra_wm9712.c                     |  176 ++
 sound/soc/ux500/mop500.c                           |    2 +-
 114 files changed, 7824 insertions(+), 2023 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4642.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-au=
dio-wm9712.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-=
ac97.txt
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,fsi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm=
8994.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8962.txt
 create mode 100755 include/sound/max98090.h
 delete mode 100644 include/sound/saif.h
 mode change 100644 =3D> 100755 sound/soc/codecs/max98090.c
 create mode 100755 sound/soc/codecs/max98090.h
 delete mode 100644 sound/soc/omap/sdp3430.c
 delete mode 100644 sound/soc/omap/zoom2.c
 create mode 100644 sound/soc/tegra/tegra20_ac97.c
 create mode 100644 sound/soc/tegra/tegra20_ac97.h
 create mode 100644 sound/soc/tegra/tegra_wm9712.c

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRGOfFAAoJELSic+t+oim9abkQAJgRjBFBapyD60/iu6ma291X
rHagYCK5oLorNPJX0HS9yAuYEK+AVfGUXd8ijjURz5U0UYVyIBrroonEjhBqYCBn
wfHLAnb2CAuHJ+FMmQeOtUC4cahamzvQn1HJvYE70MLc8r8q6Et/sOTy2cjl/7cf
mdegtP304KXSJSVRDGYiQjgig76AoXjCIQzoCz20Qb433LJEyIjmQ+AVtfmVEnxt
zl4kqKm2GD76fz29rDX8DIliG0G5tFV9E/h5NYOo8wBkVgmkttkDJKYlTprNVfW4
yopuvgo0ph+tKNW3kCERHR9C+Qy5Uq8h3BN+6zJXohlNvYHtZoUirZBtm/j1GzqL
prMGEbcrQmGzZRM5BQKA/gZGHbyJyh+wWeTlO0jrC//uNxNdmEbRgz7laAgjY4cM
bIFHGnkTYspbtf3FdkSosX3XkS3HF4N0BxnPR2iRs5H5qU7Ez0yGa1YE2SMkzMpb
7xj4nIjbJK0miXhppmRjmhEtr4cFR+E4DejAGDvwZqKYxiT6alfIEXnV1Qo8PLmk
CjZBD1TS4TgeeYZBKaLj9mqW65/SXwdEH7h2Xlxxz3AJGDdeZiwxK+5JcCTVe8/c
WmfGFV2TRDqw5qGm7WuDrWARTWFRcnZuQiN9PVwYqfXJ012+kFW9yLwQvBgAYhpY
esjQNCzxegSzRMFfRhbj
=XUjM
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--

--===============7367632202805112143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7367632202805112143==--
