From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v5 0/4] Add support for audio on SDM845 SoC
Date: Wed,  1 Aug 2018 14:31:05 +0530
Message-ID: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.

Changes since v4:
- Used snd_mask_set_format() instead of snd_mask_set() to avoid sparse warning.

Rohit kumar (4):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: dt-bindings: Update dt binding name for apq8096
  ASoC: qcom: Add support to parse common audio device nodes
  ASoC: qcom: add sdm845 sound card support

 .../devicetree/bindings/sound/qcom,apq8096.txt     |  15 +-
 .../devicetree/bindings/sound/qcom,sdm845.txt      |  80 ++++++
 sound/soc/qcom/Kconfig                             |   8 +
 sound/soc/qcom/Makefile                            |   4 +-
 sound/soc/qcom/apq8096.c                           | 111 +-------
 sound/soc/qcom/common.c                            | 112 ++++++++
 sound/soc/qcom/common.h                            |  12 +
 sound/soc/qcom/sdm845.c                            | 286 +++++++++++++++++++++
 8 files changed, 525 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
