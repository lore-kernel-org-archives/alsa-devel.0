From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: select max98927 for sdm845
Date: Tue, 15 Jan 2019 19:02:53 +0800
Message-ID: <20190115110253.261596-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Select SND_SOC_MAX98927 for SND_SOC_SDM845.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 This is part of the patch https://patchwork.kernel.org/patch/10696507/
 RT5663 part was added in the patch

 e9dc919043c5 ("ASoC: sdm845: add rt5663 codec select")

 This patch adds max98927.
 Thanks!

 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 804ae0d93058..7948e993adba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -102,6 +102,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.1.97.g81188d93c3-goog
