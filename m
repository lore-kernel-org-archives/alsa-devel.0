From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Remove bodges for no-widget CODECs
Date: Thu,  8 Mar 2012 15:06:09 +0000
Message-ID: <1331219169-21998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 790E810BAFC
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 16:06:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that we're creating widgets for all DAIs there should be no more
need for the bodges we've been carrying for non-DAPM CODEC drivers so
remove them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

I don't actually have any no widget CODECs so can't really test - Timur,
would it be possible for you to give it a spin?

 sound/soc/soc-dapm.c |   36 ++++--------------------------------
 1 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8ce1e9c..6e5869d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1441,12 +1441,10 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	trace_snd_soc_dapm_start(card);
 
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d->n_widgets || d->codec == NULL) {
-			if (d->idle_bias_off)
-				d->target_bias_level = SND_SOC_BIAS_OFF;
-			else
-				d->target_bias_level = SND_SOC_BIAS_STANDBY;
-		}
+		if (d->idle_bias_off)
+			d->target_bias_level = SND_SOC_BIAS_OFF;
+		else
+			d->target_bias_level = SND_SOC_BIAS_STANDBY;
 	}
 
 	dapm_reset(card);
@@ -1491,32 +1489,6 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 
 	}
 
-	/* If there are no DAPM widgets then try to figure out power from the
-	 * event type.
-	 */
-	if (!dapm->n_widgets) {
-		switch (event) {
-		case SND_SOC_DAPM_STREAM_START:
-		case SND_SOC_DAPM_STREAM_RESUME:
-			dapm->target_bias_level = SND_SOC_BIAS_ON;
-			break;
-		case SND_SOC_DAPM_STREAM_STOP:
-			if (dapm->codec && dapm->codec->active)
-				dapm->target_bias_level = SND_SOC_BIAS_ON;
-			else
-				dapm->target_bias_level = SND_SOC_BIAS_STANDBY;
-			break;
-		case SND_SOC_DAPM_STREAM_SUSPEND:
-			dapm->target_bias_level = SND_SOC_BIAS_STANDBY;
-			break;
-		case SND_SOC_DAPM_STREAM_NOP:
-			dapm->target_bias_level = dapm->bias_level;
-			break;
-		default:
-			break;
-		}
-	}
-
 	/* Force all contexts in the card to the same bias state if
 	 * they're not ground referenced.
 	 */
-- 
1.7.9.1
