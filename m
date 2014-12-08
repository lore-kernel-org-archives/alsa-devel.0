From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 00/11] ASoC: QCOM: Add support for ipq806x SOC
Date: Mon,  8 Dec 2014 14:01:02 -0800
Message-ID: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

This set of patches adds support for audio on the Qualcomm Technologies ipq806x SOC.

The ipq806x SOC has audio-related hardware blocks in its low-power audio subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power audio interface (or LPAIF).  This encapsulates the MI2S port, which is what these drivers are configured to use.  The I2S pins are connected to an external DAC/amp chip.  In addition, a single GPIO is connected to the same DAC/amp, which gives the SOC enable/disable control.

The specific drivers added are:
 - a Codec DAI driver that controls the SOC external pins
 - a CPU DAI driver for controlling the LPASS-LPAIF block
 - a PCM MI2S platform driver
 - a machine driver that ties the three drivers together

Corresponding additions to the device tree for the ipq806x and its documentation has also been added.  Also, as this is a new directory, the MAINTAINERS file has been updated as well.

== Updates from my previous post:

[PATCH 00/9] ASoC: QCOM: Add support for ipq806x SOC
http://thread.gmane.org/gmane.linux.ports.arm.msm/10701

 - remove the native LPAIF driver, and move its functionality to the CPU DAI driver
 - add a codec driver to manage the pins going to the external DAC (previously managed by the machine driver)
 - use devm_* and dev_* where possible
 - ISR only handles relevant DMA channel now
 - update device tree documentation to reflect changes
 - general code cleanup

== Additional patch series upon which this patch series has device-tree dependencies (lcc)

[PATCH v2 0/8] qcom audio clock control drivers
http://thread.gmane.org/gmane.linux.ports.arm.msm/10793


Kenneth Westfield (11):
  MAINTAINERS: Add QCOM audio ASoC maintainer
  ASoC: qcom: Add device tree binding docs
  ASoC: ipq806x: add LPAIF header file
  ASoC: codec: Add Maxim codec driver
  ASoC: ipq806x: Add LPASS CPU DAI driver
  ASoC: ipq806x: Add I2S PCM platform driver
  ASoC: ipq806x: Add machine driver for IPQ806X SOC
  ASoC: codec: Add ability to build QCOM codec
  ASoC: qcom: Add ability to build QCOM drivers
  ASoC: Allow for building QCOM drivers
  ARM: dts: Model IPQ LPASS audio hardware

 .../bindings/sound/qcom,ipq806x-snd-card.txt       |  25 ++
 .../bindings/sound/qcom,lpass-cpu-dai.txt          |  32 ++
 .../bindings/sound/qcom,lpass-pcm-mi2s.txt         |  12 +
 .../bindings/sound/qcom,max98357a-codec.txt        |  23 ++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  33 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max98357a.c                       | 267 ++++++++++++
 sound/soc/qcom/Kconfig                             |  25 ++
 sound/soc/qcom/Makefile                            |  11 +
 sound/soc/qcom/ipq806x.c                           | 127 ++++++
 sound/soc/qcom/lpass-cpu-mi2s.c                    | 374 +++++++++++++++++
 sound/soc/qcom/lpass-cpu-mi2s.h                    |  48 +++
 sound/soc/qcom/lpass-lpaif.h                       | 154 +++++++
 sound/soc/qcom/lpass-pcm-mi2s.c                    | 452 +++++++++++++++++++++
 18 files changed, 1598 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,max98357a-codec.txt
 create mode 100644 sound/soc/codecs/max98357a.c
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile
 create mode 100644 sound/soc/qcom/ipq806x.c
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.c
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.h
 create mode 100644 sound/soc/qcom/lpass-lpaif.h
 create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.c

-- 
1.8.2.1
