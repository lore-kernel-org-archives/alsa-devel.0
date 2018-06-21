From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for audio on SDM845 SoC
Date: Thu, 21 Jun 2018 16:23:17 +0530
Message-ID: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F3DE2676C4
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:53:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.
Changes since v1:
Addressed comments posted by Vinod and Srinivas.

Rohit kumar (2):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: qcom: add sdm845 sound card support

 .../devicetree/bindings/sound/qcom,sdm845.txt      |  82 ++++
 sound/soc/qcom/Kconfig                             |   9 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/sdm845.c                            | 514 +++++++++++++++++++++
 4 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
