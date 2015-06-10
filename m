From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/2] ASoC: qcom: add support to apq8016 sbc machine driver
Date: Wed, 10 Jun 2015 13:15:05 +0100
Message-ID: <1433938505-18006-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds sound card support to APQ8016 SBC board aka DB410c.
APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
to internal wcd codec or external codecs. This routing and various board specifics
are controlled by 2 mux registers.

All these patches are tested for HDMI audio via adv7533 bridge and Analog audio
on APQ8016-SBC, msm8916-mtp boards.

Changes since v5:
  - converted if-else to switch case as suggested by Mark.
  - moved usage of startup() to dai link init() as suggested by Mark.
  - replaced "external" boolean property with "link-name" property as
    suggested by Mark.

Changes since v4 (https://lkml.org/lkml/2015/5/22/628)
  - moved all the dt parsing to single function, spotted by Mark.
  - removed unnecessary setting of card->dev = NULL spotted by Mark.
  - renamed the dai links to the correct codec names.
  - removed the special case for EPROBE_DEFER in probe, spotted by Mark.
  - Dropped all the Changes since comments as most of the patches
   in last series are merged to topic/qcom branch.

--srini

Srinivas Kandagatla (2):
  ASoC: qcom: document apq8016 sbc machine driver bindings
  ASoC: qcom: add apq8016 sound card support

 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |  60 +++++++
 sound/soc/qcom/Kconfig                             |   9 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/apq8016_sbc.c                       | 198 +++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
 create mode 100644 sound/soc/qcom/apq8016_sbc.c

-- 
1.9.1
