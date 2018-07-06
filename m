From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 0/5] Add support for audio on SDM845 SoC
Date: Fri,  6 Jul 2018 15:13:10 +0530
Message-ID: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.
Changes since v2:
- Added new file to parse dai-links from device tree
  and use it in sdm845 and apq8096 machine driver.
- Removed qcom prefix from device tree properties as
  suggested by Robb.
- Updated apq8096 machine driver to use common APIs.

Rohit kumar (5):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: qcom: Add support to parse common audio device nodes
  ASoC: qcom: add sdm845 sound card support
  ASoC: dt-bindings: Update dt binding name for apq8096
  ASoC: qcom: apq8096: Use common APIs to parse device nodes

 .../devicetree/bindings/sound/qcom,apq8096.txt     |  15 +-
 .../devicetree/bindings/sound/qcom,sdm845.txt      |  80 +++++
 sound/soc/qcom/Kconfig                             |  14 +
 sound/soc/qcom/Makefile                            |   3 +
 sound/soc/qcom/apq8096.c                           | 151 +-------
 sound/soc/qcom/common.c                            | 150 ++++++++
 sound/soc/qcom/common.h                            |  14 +
 sound/soc/qcom/sdm845.c                            | 390 +++++++++++++++++++++
 8 files changed, 674 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
