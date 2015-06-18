From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 1/2] ASoC: qcom: move board Kconfig deps to parent config
Date: Thu, 18 Jun 2015 15:16:07 -0700
Message-ID: <1434665768-29367-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jim Davis <jim.epost@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Rather than have each board define the same set of
dependencies; move the common dependencies to the
SND_SOC_QCOM parent config.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 807fedf..d6ccda7 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -1,5 +1,6 @@
 config SND_SOC_QCOM
 	tristate "ASoC support for QCOM platforms"
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
           Say Y or M if you want to add support to use audio devices
           in Qualcomm Technologies SOC-based platforms.
@@ -26,7 +27,7 @@ config SND_SOC_LPASS_APQ8016
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
+	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
@@ -35,7 +36,7 @@ config SND_SOC_STORM
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
-	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
+	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_APQ8016
 	help
           Support for Qualcomm Technologies LPASS audio block in
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
