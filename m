From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH v2] ASoC: qcom: Remove QCOM dependency from LPASS variants
Date: Tue,  2 Jun 2015 21:28:37 -0700
Message-ID: <1433305717-8691-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jim Davis <jim.epost@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Building with the following config options ...

 CONFIG_COMPILE_TEST=y
 # CONFIG_SND_SOC_QCOM is not set
 CONFIG_SND_SOC_LPASS_IPQ806X=m
 CONFIG_SND_SOC_STORM=m

... causes the following build warning:

 warning: (SND_SOC_STORM) selects SND_SOC_LPASS_IPQ806X
 which has unmet direct dependencies (SOUND && !M68K &&
 !UML && SND && SND_SOC && SND_SOC_QCOM)

To fix this, the dependency on SND_SOC_QCOM from the
user-invisible LPASS variant config options has been
removed.  This will allow for successful randconfig
builds that use COMPILE_TEST.

Reported-by: Jim Davis <jim.epost@gmail.com>
Fixes: dc1ebd1811e9 ("ASoC: qcom: Add apq8016 lpass driver support")
Fixes: 9bae4880acee ("ASoC: qcom: move ipq806x specific bits out of lpass
driver")
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---

 Created fix in response to Jim's bug report:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/092870.html
 
 sound/soc/qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 938144c..290b056 100644
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
