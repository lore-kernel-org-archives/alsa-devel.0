From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 0/9] ASoC: QCOM: Add support for ipq806x SOC
Date: Wed, 19 Nov 2014 10:52:40 -0800
Message-ID: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

This set of patches adds support for audio on the Qualcomm Technologies
ipq806x SOC.

The ipq806x SOC has audio-related hardware blocks in its low-power audio
subsystem (or LPASS).  One of the relevant blocks in the LPASS is its
low-power audio interface (or LPAIF).  This encapsulates the MI2S port,
which is what these drivers are configured to use.  The I2S pins are
connected to an external DAC/amp chip.  In addition, a single GPIO is
connected to the same DAC/amp, which gives the SOC enable/disable
control.

The specific drivers added are:
 - a machine driver that handles the board-specific pins
 - a native driver that handles hardware access to the LPAIF
 - a CPU DAI driver for controlling the LPAIF block
 - a PCM MI2S platform driver

Corresponding additions to the device tree for the ipq806x and its
documentation has also been added.  Also, as this is a new directory,
the MAINTAINERS file has been updated as well.

 - Ken

Kenneth Westfield (9):
  MAINTAINERS: Add QCOM audio ASoC maintainer
  ASoC: qcom: Add device tree binding docs
  ASoC: ipq806x: add native LPAIF driver
  ASoC: ipq806x: Add LPASS CPU DAI driver
  ASoC: ipq806x: Add I2S PCM platform driver
  ASoC: ipq806x: Add machine driver for IPQ806X SOC
  ASoC: qcom: Add ability to build QCOM drivers
  ASoC: Allow for building QCOM drivers
  ARM: dts: Model IPQ LPASS audio hardware

 .../bindings/sound/qcom,ipq806x-snd-card.txt       |  41 ++
 .../bindings/sound/qcom,lpass-cpu-dai.txt          |  20 +
 .../devicetree/bindings/sound/qcom,lpass-lpaif.txt |  21 +
 .../bindings/sound/qcom,lpass-pcm-mi2s.txt         |  12 +
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  33 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/qcom/Kconfig                             |  43 ++
 sound/soc/qcom/Makefile                            |  11 +
 sound/soc/qcom/ipq806x.c                           | 221 ++++++++++
 sound/soc/qcom/lpass-cpu-dai.c                     | 307 +++++++++++++
 sound/soc/qcom/lpass-lpaif.c                       | 488 +++++++++++++++++++++
 sound/soc/qcom/lpass-lpaif.h                       | 181 ++++++++
 sound/soc/qcom/lpass-pcm-mi2s.c                    | 390 ++++++++++++++++
 sound/soc/qcom/lpass-pcm-mi2s.h                    |  40 ++
 16 files changed, 1817 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-snd-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu-dai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-lpaif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile
 create mode 100644 sound/soc/qcom/ipq806x.c
 create mode 100644 sound/soc/qcom/lpass-cpu-dai.c
 create mode 100644 sound/soc/qcom/lpass-lpaif.c
 create mode 100644 sound/soc/qcom/lpass-lpaif.h
 create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.c
 create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.h

-- 
1.8.2.1
