From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH V8 0/5] ASoC: QCOM: Add support for ipq806x SOC
Date: Fri, 13 Mar 2015 01:01:03 -0700
Message-ID: <1426233668-30593-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

This patch series adds support for I2S audio playback on the Storm board, which
contains a Qualcomm Technologies ipq806x SOC and a Maxim max98357a DAC/amp.

The ipq806x SOC has audio-related hardware blocks in its low-power audio
subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power
audio interface (or LPAIF).  This contains an MI2S port, which is what these
drivers are configured to use.  The LPAIF also contains a DMA engine that is
dedicated to moving audio samples into the transmit FIFO of the MI2S port.

One bus from the MI2S port of the SOC is connected to the DAC/amp for stereo
playback.  This bus is configured so that the SOC is bus master and consists of
DATA, LRCLK, and BCLK.  The DAC/amp does not need MCLK to operate.  In addition,
a single GPIO pin from the SOC is connected to the same DAC/amp, which gives
enable/disable control over the DAC/amp.

The specific drivers added are:
  * a codec DAI driver for controlling the DAC/amp (applied from V4)
  * a CPU DAI driver for controlling the MI2S port (applied from V7)
  * a platform driver for controlling the LPAIF DMA engine (applied from V7)
  * a machine driver that instantiates a dai-link for playback

The LPASS also contains clocks that need to be controlled.  Those drivers have
been submitted as several separate patch series:  
  * [PATCH v3 0/8] qcom audio clock control drivers
    http://lkml.org/lkml/2015/1/19/656
  * [PATCH] arm: dts: qcom: Add LCC nodes
    https://lkml.org/lkml/2015/1/28/557
  * [PATCH 1/2] arm: qcom_defconfig: Enable lpass clock driver
    https://lkml.org/lkml/2015/1/28/582
  * [PATCH] clk: qcom: Fix ipq806x LCC frequency tables
    https://lkml.org/lkml/2015/2/26/774
  * [PATCH v2] clk: qcom: Properly change rates for ahbix clock
    https://lkml.org/lkml/2015/3/6/878

Even though the ipq806x LPASS does not contain an audio DSP, other SOCs do have
one.  For those SOCs, the audio DSP typically controls the hardware blocks in
the LPASS.  Hence, different CPU DAI driver(s) would need to be used in order to
facilitate audio with the DSP.  As such, the LPASS DT binding description
alludes to an optional adsp phandle, which is not present for this SOC.  For
other SOCs that do contain an audio DSP, the phandle should exist and refer to a
an adsp node.  Not using the audio DSP on an SOC that does have one would
require different CPU DAI driver(s), in addition to possible bootloader and/or
firmware changes.

Note that the use of a phandle was a modification that has been submitted as
part of a separate patch series.

Corresponding additions to the device tree for the ipq806x SOC and its
documentation have also been added.  Also, as this is a new directory, the
MAINTAINERS file has been updated as well (applied from V7).

= Changes since V7
  [Patch V7 00/10] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/088546.html

  * Changed the compatible property of the machine driver to make it specific
    to audio
  * Removed the lcc node definition from the DT, as it was submitted separately

= Changes since V6
  [Patch V6 00/10] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088218.html

  * Added REGMAP_MMIO selection for the CPU and platform drivers
  * Modified the AHBIX frequency to match the corresponding LCC fix
  * Tweaked the logging in the CPU driver probe.

= Changes since V5
  [Patch V5 00/12] ASoC: QCOM: Add support for ipq806x SOC
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087832.html

  * Correctly use Storm as the build target label and DT binding label.
  * Added audio DSP sub-node to the LPASS device tree, disabled for this SOC.
  * Added logic to CPU DAI driver to fail the probe() if a DSP is present.
  * Use the standard naming convention for the DAI link properties.
  * General code cleanup.

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
  * Added explicit dependency on gpiolib for the codec driver.
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

Kenneth Westfield (5):
  ASoC: qcom: Document Storm bindings
  ASoC: qcom: Add Storm machine driver
  ASoC: qcom: Add ability to build QCOM drivers
  ASoC: Allow for building QCOM drivers
  ARM: dts: Model IPQ LPASS audio hardware

 Documentation/devicetree/bindings/sound/storm.txt |  23 +++
 arch/arm/boot/dts/qcom-ipq8064.dtsi               |  16 +++
 sound/soc/Kconfig                                 |   1 +
 sound/soc/Makefile                                |   1 +
 sound/soc/qcom/Kconfig                            |  25 ++++
 sound/soc/qcom/Makefile                           |  11 ++
 sound/soc/qcom/storm.c                            | 162 ++++++++++++++++++++++
 7 files changed, 239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/storm.txt
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile
 create mode 100644 sound/soc/qcom/storm.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
