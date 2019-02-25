From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845
Date: Mon, 25 Feb 2019 21:54:05 +0800
Message-ID: <20190225135405.108052-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, enric.balletbo@collabora.com, rdunlap@infradead.org, ncrews@chromium.org, bleung@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
warning.

Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8f206cb4fcc0..75ceb04d8bf0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR
+	depends on QCOM_APR && MFD_CROS_EC
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.21.0.rc0.258.g878e2cd30e-goog
