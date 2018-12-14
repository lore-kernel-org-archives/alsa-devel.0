From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/4] ASoC: qdsp6: Add support for audio over DP
Date: Fri, 14 Dec 2018 17:59:25 +0530
Message-ID: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, asishb@codeaurora.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add support for Audio over display port AFE port

Rohit kumar (4):
  ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding
  ASoC: qdsp6: qdafe: add support for display_port_rx
  ASoC: qdsp6: q6afe-dai: add support to Display port RX dais
  ASoC: qdsp6: q6routing: add display_port_rx port routing

 include/dt-bindings/sound/qcom,q6afe.h |  1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c       | 22 ++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.c           |  4 ++++
 sound/soc/qcom/qdsp6/q6routing.c       |  9 +++++++++
 4 files changed, 36 insertions(+)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
