From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Remove QCOM dependency from LPASS variants
Date: Mon,  1 Jun 2015 22:05:32 -0700
Message-ID: <1433221532-9489-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Remove the dependency on SND_SOC_QCOM from the user-
invisible LPASS variant options.  This will fix
randconfig build errors.

Reported-by: Jim Davis <jim.epost@gmail.com>
Fixes: dc1ebd1811e9 ("ASoC: qcom: Add apq8016 lpass driver support")
Fixes: 9bae4880acee ("ASoC: qcom: move ipq806x specific bits out of lpass
driver")
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---

 Created fix in response to Jim's bug report:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/092870.html
 
 Note: I did some searching but didn't see an example of a fix for the
 same type of bug introduced by 2 commits.  If this needs to be split into
 two fixes, let me know.

 sound/soc/qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 29fff6d..10837bd 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -14,13 +14,11 @@ config SND_SOC_LPASS_PLATFORM
 
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
