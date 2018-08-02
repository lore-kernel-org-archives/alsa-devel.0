From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845
Date: Thu,  2 Aug 2018 12:32:59 +0530
Message-ID: <1533193379-1125-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, sfr@canb.auug.org.au, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add DEPENDS_ON QCOM_APR for SND_SOC_SDM845 to fix the
warning: unmet direct dependencies detected for
SND_SOC_QDSP6.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 3507308..5f03312 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -93,6 +93,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
+	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
