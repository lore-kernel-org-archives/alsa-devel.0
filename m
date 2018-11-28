From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 5/5] ASoC: qcom: Kconfig: select config for codec
Date: Wed, 28 Nov 2018 17:00:37 +0800
Message-ID: <20181128090037.257359-5-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Select SND_SOC_RT5663 and SND_SOC_MAX98927 for SND_SOC_SDM845.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e484..3528c4279cbae 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -100,6 +100,8 @@ config SND_SOC_SDM845
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
