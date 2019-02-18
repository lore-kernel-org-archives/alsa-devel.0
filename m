From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: qcom: Kconfig: select dmic for sdm845
Date: Mon, 18 Feb 2019 12:18:19 +0800
Message-ID: <20190218041819.115729-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

sdm845 uses dmic on EC so it should select CROS_EC_CODEC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 7948e993adba..8f206cb4fcc0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -103,6 +103,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
+	select SND_SOC_CROS_EC_CODEC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.21.0.rc0.258.g878e2cd30e-goog
