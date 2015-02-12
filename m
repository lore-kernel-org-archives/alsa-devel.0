From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V5 00/12] ASoC: QCOM: Add support for ipq806x SOC
Date: Wed, 11 Feb 2015 18:10:03 -0800
Message-ID: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

This patch series adds support for I2S audio playback on the Qualcomm
Technologies ipq806x SOC.

The ipq806x SOC has audio-related hardware blocks in its low-power audio
subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power
audio interface (or LPAIF).  This contains an MI2S port, which is what these
drivers are configured to use.  The LPAIF also contains a DMA engine that is
dedicated to moving audio samples into the transmit FIFO of the MI2S port.

The development board being used for testing contains the ipq806x SOC and a
Maxim max98357a DAC/amp.  One bus from the MI2S port of the SOC is connected to
the DAC/amp for stereo playback.  This bus is configured so that the SOC is bus
master and consists of DATA, LRCLK, and BCLK.  The DAC/amp does not need MCLK to
operate.  In addition, a single GPIO pin from the SOC is connected to the same
DAC/amp, which gives enable/disable control over the DAC/amp.

The specific drivers added are:
  * a codec DAI driver for controlling the DAC/amp
  * a CPU DAI driver for controlling the MI2S port
  * a platform driver for controlling the LPAIF DMA engine
  * a machine driver that instantiates a dai-link for playback

Corresponding additions to the device tree for the ipq806x SOC and its
documentation has also been added.  Also, as this is a new directory, the
MAINTAINERS file has been updated as well.

The LPASS also contains clocks that need to be controlled.  Those drivers have
been submitted as a separate patch series:  
  [PATCH v3 0/8] qcom audio clock control drivers
  http://lkml.org/lkml/2015/1/19/656

= Changes since V4
  [Patch V4 00/10] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087499.html

  * Replaced simple-card with a machine driver to resolve the system clock
    configuration, rather than having the CPU DAI driver do it.
  * Added header files to avoid indirect header dependencies and implicit
    forward declarations.
  * Tweaked the ISR to match the conventions of the surrounding code.
  * Removed the usage of the low-power memory as it is not needed.
  * Removed the use of the DRV_NAME constant.
  * Added explicit dependancy on gpiolib for the codec driver.
  * Moved the MODULE_DEVICE_TABLE macro inside the CONFIG_OF conditional.
  * Modified the documentation to reflect the changes.
  * General code cleanup.

= Changes since V3
  [Patch V3 00/10] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085694.html

  * Placed the content of the inline functions into the callbacks.
  * Replaced use of readl/writel register access functions with regmap access
    functions.  Notable exception is the ISR, which uses ioread32/iowrite32.
  * Rearranged the sequencing of the hardware block enables to fit within the
    ASoC framework callbacks, while remaining functional.
    REQ 1: The hardware requires the enable sequence to be:
    LPAIF-DMA[enable],then LPAIF-MI2S[enable], then DAC-GPIO[enable]
    REQ 2: The hardware requires the disable sequence to be:
    DAC-GPIO[disable], then LPAIF-MI2S[disable]
  * Corrected the implementation of the pointer callback.
  * Utilize the LPM to buffer audio samples, rather than memory external to
    LPASS.
  * Corrected the interrupt clearing in the ISR.
  * Implemented a default system clock (defined by the simple-card DT node), and
    optional LPASS DT node modifiers that can alter the system clock in order to
    expand the range of available bit clock frequencies.
  * Addressed all of the remaining issues raised by Mark Brown.
  * General code cleanup.

= Changes since V2
  [Patch v2 00/11] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085186.html

  * Removed the PCM platform driver from the DTS platform and tied it to the CPU
    DAI driver.
  * Changed I2S pinctrl to use generic naming convention and moved control to
    CPU DAI driver.  It should be controlled now by soc-core's pinctrl_pm_*
    functionality.
  * Added stub DAPM support in codec driver.  As the DAC GPIO needs to be
    enabled last when starting playback, and disabled first when stopping
    playback, it seems as though the trigger function may be the place for this.
    Suggestions are welcome for a better place to put this.
  * Removed machine driver and tied DAI drivers to simple-audio-card.
  * Packaged the build files and Maxim codec files together in one change.
  * Removed QCOM as vendor from Maxim code and documentation.
  * Separated the SOC and board definitions into the correct DTS files.
  * Update device tree documentation to reflect changes.
  * General code cleanup.

= Changes since V1
  [PATCH 0/9] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084322.html

  * Remove the native LPAIF driver, and move its functionality to the CPU DAI
    driver.
  * Add a codec driver to manage the pins going to the external DAC (previously
    managed by the machine driver).
  * Use devm_* and dev_* where possible.
  * ISR only handles relevant DMA channel now.
  * Update device tree documentation to reflect changes.
  * General code cleanup.

Kenneth Westfield (12):
  MAINTAINERS: Add QCOM audio ASoC maintainer
  ASoC: max98357a: Document MAX98357A bindings
  ASoC: qcom: Document LPASS CPU bindings
  ASoC: qcom: Document IPQ806X-MAX89357A bindings
  ASoC: codec: Add MAX98357A codec driver
  ASoC: ipq806x: add LPASS header files
  ASoC: ipq806x: Add LPASS CPU DAI driver
  ASoC: ipq806x: Add LPASS platform driver
  ASoC: ipq806x: Add @max98357a machine driver
  ASoC: qcom: Add ability to build QCOM drivers
  ASoC: Allow for building QCOM drivers
  ARM: dts: Model IPQ LPASS audio hardware

 .../devicetree/bindings/sound/max98357a.txt        |  14 +
 .../bindings/sound/qcom,ipq806x-max98357a.txt      |  24 +
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  38 ++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  23 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max98357a.c                       | 145 ++++++
 sound/soc/qcom/Kconfig                             |  26 +
 sound/soc/qcom/Makefile                            |  11 +
 sound/soc/qcom/ipq806x-max98357a.c                 | 171 +++++++
 sound/soc/qcom/lpass-cpu.c                         | 481 +++++++++++++++++++
 sound/soc/qcom/lpass-lpaif-ipq806x.h               | 172 +++++++
 sound/soc/qcom/lpass-platform.c                    | 526 +++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  51 ++
 17 files changed, 1697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-max98357a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 sound/soc/codecs/max98357a.c
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile
 create mode 100644 sound/soc/qcom/ipq806x-max98357a.c
 create mode 100644 sound/soc/qcom/lpass-cpu.c
 create mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
 create mode 100644 sound/soc/qcom/lpass-platform.c
 create mode 100644 sound/soc/qcom/lpass.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
