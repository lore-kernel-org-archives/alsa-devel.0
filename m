From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: Remove trace for DAPM bias level
	logging
Date: Mon,  6 Jun 2011 19:18:29 +0100
Message-ID: <1307384313-23559-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6248424430
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 20:18:37 +0200 (CEST)
In-Reply-To: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's redundant now thanks to the use of the generic trace infrastructure.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 988cdff..4452b57 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -139,24 +139,6 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_card *card = dapm->card;
 	int ret = 0;
 
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		dev_dbg(dapm->dev, "Setting full bias\n");
-		break;
-	case SND_SOC_BIAS_PREPARE:
-		dev_dbg(dapm->dev, "Setting bias prepare\n");
-		break;
-	case SND_SOC_BIAS_STANDBY:
-		dev_dbg(dapm->dev, "Setting standby bias\n");
-		break;
-	case SND_SOC_BIAS_OFF:
-		dev_dbg(dapm->dev, "Setting bias off\n");
-		break;
-	default:
-		dev_err(dapm->dev, "Setting invalid bias %d\n", level);
-		return -EINVAL;
-	}
-
 	trace_snd_soc_bias_level_start(card, level);
 
 	if (card && card->set_bias_level)
-- 
1.7.5.3
