From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 2/2] ASoC: qcom: remove Kconfig deps from variant configs
Date: Thu, 18 Jun 2015 15:16:08 -0700
Message-ID: <1434665768-29367-2-git-send-email-kwestfie@codeaurora.org>
References: <1434665768-29367-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1434665768-29367-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jim Davis <jim.epost@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Remove the SND_SOC_QCOM dependency from the variant
configs.  The board configs, which select the
variants, already have this dependency.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index d6ccda7..3cc252e 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -15,13 +15,11 @@ config SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_IPQ806X
 	tristate
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_APQ8016
 	tristate
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
