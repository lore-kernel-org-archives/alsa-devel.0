From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 00/10] ASoC: QCOM: Add support for ipq806x SOC
Date: Wed, 24 Dec 2014 08:42:00 -0800
Message-ID: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

This set of patches adds support for audio on the Qualcomm Technologies
ipq806x SOC.

The ipq806x SOC has audio-related hardware blocks in its low-power audio
subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power
audio interface (or LPAIF).  This encapsulates the MI2S port, which is what
these drivers are configured to use.  The I2S pins are connected to an external
DAC/amp chip.  In addition, a single GPIO is connected to the same DAC/amp,
which gives the SOC enable/disable control.

The specific drivers added are:
 - a Codec DAI driver that controls the SOC external pins
 - a CPU DAI driver for controlling the LPASS-LPAIF block
 - a PCM MI2S platform driver

These drivers, together, are used by simple-audio-card to complete the audio
implementation.  Corresponding additions to the device tree for the ipq806x and
its documentation has also been added.  Also, as this is a new directory, the
MAINTAINERS file has been updated as well.

== Updates from my previous post:

[Patch v2 00/11] ASoC: QCOM: Add support for ipq806x SOC
http://thread.gmane.org/gmane.linux.ports.arm.msm/10989

 - Removed the PCM platform driver from the DTS platform and tied it to the
   CPU DAI driver.
 - Changed I2S pinctrl to use generic naming convention and moved control to
   CPU DAI driver.  It should be controlled now by soc-core's pinctrl_pm_*
   functionality.
 - Added stub DAPM support in codec driver.  As the DAC GPIO needs to be
   enabled last when starting playback, and disabled first when stopping
   playback, it seems as though the trigger function may be the place for this.  
   Suggestions are welcome for a better place to put this.
 - Removed machine driver and tied DAI drivers to simple-audio-card.
 - Packaged the build files and Maxim codec files together in one change.
 - Removed QCOM as vendor from Maxim code and documentation.
 - Separated the SOC and board definitions into the correct DTS files.
 - Update device tree documentation to reflect changes.
 - General code cleanup.

== Additional patch series upon which this patch series has device-tree
   dependencies (lcc)

[PATCH v2 0/8] qcom audio clock control drivers
http://thread.gmane.org/gmane.linux.ports.arm.msm/10793


Kenneth Westfield (10):
  MAINTAINERS: Add QCOM audio ASoC maintainer
  ASoC: qcom: Document MAX98357A bindings
  ASoC: qcom: Document LPASS CPU bindings
  ASoC: codec: Add MAX98357A codec driver
  ASoC: ipq806x: add LPASS header files
  ASoC: ipq806x: Add LPASS CPU DAI driver
  ASoC: ipq806x: Add I2S PCM platform driver
  ASoC: qcom: Add ability to build QCOM drivers
  ASoC: Allow for building QCOM drivers
  ARM: dts: Model IPQ LPASS audio hardware

 .../devicetree/bindings/sound/max98357a.txt        |  14 +
 .../bindings/sound/qcom,lpass-cpu-mi2s.txt         |  42 ++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  23 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max98357a.c                       | 136 ++++++
 sound/soc/qcom/Kconfig                             |  27 ++
 sound/soc/qcom/Makefile                            |   6 +
 sound/soc/qcom/lpass-cpu-mi2s.c                    | 378 ++++++++++++++++
 sound/soc/qcom/lpass-lpaif-reg.h                   | 155 +++++++
 sound/soc/qcom/lpass-mi2s.h                        |  34 ++
 sound/soc/qcom/lpass-pcm-mi2s.c                    | 486 +++++++++++++++++++++
 15 files changed, 1316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-mi2s.txt
 create mode 100644 sound/soc/codecs/max98357a.c
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.c
 create mode 100644 sound/soc/qcom/lpass-lpaif-reg.h
 create mode 100644 sound/soc/qcom/lpass-mi2s.h
 create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.c

-- 
1.8.2.1
