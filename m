From: bgoswami@codeaurora.org
Subject: [PATCH] ASoC: Add a debug log to track DAPM widget
	power up/down
Date: Fri, 24 May 2019 00:54:27 -0700
Message-ID: <1558684467-11333-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E30AF89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 09:54:32 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Banajit Goswami <bgoswami@codeaurora.org>

Add a debug log to help track widgets being powered-up and powered-down
by DAPM.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/soc-dapm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 29cdfbf4c888..9bab90410de5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1665,6 +1665,13 @@ static void dapm_seq_run(struct snd_soc_card *card,
 			break;
 		}
 
+		/*
+		 * Add this debug log to keep track of widgets being
+		 * powered-up and powered-down.
+		 */
+		dev_dbg(w->dapm->dev, "dapm: powering %s widget %s\n",
+			power_up ? "up" : "down", w->name);
+
 		if (ret < 0)
 			dev_err(w->dapm->dev,
 				"ASoC: Failed to apply widget power: %d\n", ret);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
