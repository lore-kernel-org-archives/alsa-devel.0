From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Simplify logic in
	snd_soc_dapm_set_bias_level()
Date: Mon,  6 Jun 2011 19:18:30 +0100
Message-ID: <1307384313-23559-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6788124437
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

No functional changes but much less indentation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4452b57..d989dd7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -143,17 +143,19 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 
 	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, level);
-	if (ret == 0) {
-		if (dapm->codec && dapm->codec->driver->set_bias_level)
-			ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
-		else
-			dapm->bias_level = level;
-	}
-	if (ret == 0) {
-		if (card && card->set_bias_level_post)
-			ret = card->set_bias_level_post(card, level);
-	}
+	if (ret != 0)
+		goto out;
+
+	if (dapm->codec && dapm->codec->driver->set_bias_level)
+		ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
+	else
+		dapm->bias_level = level;
+	if (ret != 0)
+		goto out;
 
+	if (card && card->set_bias_level_post)
+		ret = card->set_bias_level_post(card, level);
+out:
 	trace_snd_soc_bias_level_done(card, level);
 
 	return ret;
-- 
1.7.5.3
