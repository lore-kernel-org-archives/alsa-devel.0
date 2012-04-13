From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: dapm: release lock on error paths
Date: Fri, 13 Apr 2012 22:25:43 +0300
Message-ID: <20120413192543.GC18505@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 3313E10B98E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 21:25:54 +0200 (CEST)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We added locking here but there were a couple error paths where we
forgot to drop the lock before returning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 82e99b6..3191d01 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2133,7 +2133,7 @@ err:
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
-	int i, ret;
+	int i, ret = 0;
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
@@ -2141,13 +2141,13 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 		if (ret < 0) {
 			dev_err(dapm->dev, "Failed to add route %s->%s\n",
 				route->source, route->sink);
-			return ret;
+			break;
 		}
 		route++;
 	}
 	mutex_unlock(&dapm->card->dapm_mutex);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
@@ -2851,6 +2851,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 	int i;
+	int ret = 0;
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
@@ -2859,12 +2860,13 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 			dev_err(dapm->dev,
 				"ASoC: Failed to create DAPM control %s\n",
 				widget->name);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			break;
 		}
 		widget++;
 	}
 	mutex_unlock(&dapm->card->dapm_mutex);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
