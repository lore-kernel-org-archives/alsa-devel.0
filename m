From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Fix locking during codec shutdown
Date: Fri,  6 Jul 2012 16:57:05 +0100
Message-ID: <1341590225-20837-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 7867F104566
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 17:57:11 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so745308wgb.4
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 08:57:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Codec shutdown performs a DAPM power sequence that might cause conflicts
and/or race conditions if another stream power event is running simultaneously.
Use card's dapm mutex to protect any potential race condition between them.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0f078de..b485960 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3578,10 +3578,13 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
 static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 {
+	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(down_list);
 	int powerdown = 0;
 
+	mutex_lock(&card->dapm_mutex);
+
 	list_for_each_entry(w, &dapm->card->widgets, list) {
 		if (w->dapm != dapm)
 			continue;
@@ -3604,6 +3607,8 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 			snd_soc_dapm_set_bias_level(dapm,
 						    SND_SOC_BIAS_STANDBY);
 	}
+
+	mutex_unlock(&card->dapm_mutex);
 }
 
 /*
-- 
1.7.9.5
