From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2.1 3/3] ASoC: Extend DAPM to handle power
	changes on cross-device paths
Date: Tue, 14 Dec 2010 12:18:32 +0200
Message-ID: <1292321912-24765-4-git-send-email-jhnikula@gmail.com>
References: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E4FCD1038F1
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 11:17:39 +0100 (CET)
Received: by eyg24 with SMTP id 24so205084eyg.24
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 02:17:39 -0800 (PST)
In-Reply-To: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Power change event like stream start/stop or kcontrol change in a
cross-device path originates from one device but codec bias and widget power
changes must be populated to another devices on that path as well.

This patch modifies the dapm_power_widgets so that all the widgets on a
sound card are checked for a power change, not just those that are specific
to originating device. Also bias management is extended to check all the
devices. Only exception in bias management are widgetless codecs whose bias
state is changed only if power change is originating from that context.

DAPM context test is added to dapm_seq_run to take care of if power sequence
extends to an another device which requires separate register writes.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h |    5 ++
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |    2 +
 sound/soc/soc-dapm.c     |  109 ++++++++++++++++++++++++++-------------------
 4 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a6f04b1..188f8cf 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -477,6 +477,11 @@ struct snd_soc_dapm_context {
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_card *card; /* parent card */
+
+	/* used during DAPM updates */
+	int dev_power;
+	struct list_head list;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d5fb861..74921f2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -663,6 +663,7 @@ struct snd_soc_card {
 
 	struct list_head widgets;
 	struct list_head paths;
+	struct list_head dapm_list;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bd183a7..a233607 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1427,6 +1427,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	/* mark codec as probed and add to card codec list */
 	codec->probed = 1;
 	list_add(&codec->card_list, &card->codec_dev_list);
+	list_add(&codec->dapm.list, &card->dapm_list);
 
 	return ret;
 }
@@ -1881,6 +1882,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->platform_dev_list);
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
+	INIT_LIST_HEAD(&card->dapm_list);
 
 	soc_init_card_debugfs(card);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 35f069c..d9be65c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -844,19 +844,22 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	LIST_HEAD(pending);
 	int cur_sort = -1;
 	int cur_reg = SND_SOC_NOPM;
+	struct snd_soc_dapm_context *cur_dapm = NULL;
 	int ret;
 
 	list_for_each_entry_safe(w, n, list, power_list) {
 		ret = 0;
 
 		/* Do we need to apply any queued changes? */
-		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
+		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
+		    w->dapm != cur_dapm) {
 			if (!list_empty(&pending))
-				dapm_seq_run_coalesced(dapm, &pending);
+				dapm_seq_run_coalesced(cur_dapm, &pending);
 
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
 			cur_reg = SND_SOC_NOPM;
+			cur_dapm = NULL;
 		}
 
 		switch (w->id) {
@@ -900,6 +903,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 			/* Queue it up for application */
 			cur_sort = sort[w->id];
 			cur_reg = w->reg;
+			cur_dapm = w->dapm;
 			list_move(&w->power_list, &pending);
 			break;
 		}
@@ -926,20 +930,22 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 {
 	struct snd_soc_card *card = dapm->codec->card;
 	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
 	int ret = 0;
 	int power;
-	int sys_power = 0;
 
 	trace_snd_soc_dapm_start(card);
 
+	list_for_each_entry(d, &card->dapm_list, list)
+		if (d->n_widgets)
+			d->dev_power = 0;
+
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
@@ -957,7 +963,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			else
 				power = 1;
 			if (power)
-				sys_power = 1;
+				w->dapm->dev_power = 1;
 
 			if (w->power == power)
 				continue;
@@ -981,22 +987,22 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
-			sys_power = 1;
+			dapm->dev_power = 1;
 			break;
 		case SND_SOC_DAPM_STREAM_STOP:
-			sys_power = !!dapm->codec->active;
+			dapm->dev_power = !!dapm->codec->active;
 			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
-			sys_power = 0;
+			dapm->dev_power = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
 			switch (dapm->bias_level) {
 				case SND_SOC_BIAS_STANDBY:
 				case SND_SOC_BIAS_OFF:
-					sys_power = 0;
+					dapm->dev_power = 0;
 					break;
 				default:
-					sys_power = 1;
+					dapm->dev_power = 1;
 					break;
 			}
 			break;
@@ -1005,21 +1011,24 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	if (sys_power && dapm->bias_level == SND_SOC_BIAS_OFF) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm,
-						  SND_SOC_BIAS_STANDBY);
-		if (ret != 0)
-			dev_err(dapm->dev,
-				"Failed to turn on bias: %d\n", ret);
-	}
+	list_for_each_entry(d, &dapm->card->dapm_list, list) {
+		if (d->dev_power && d->bias_level == SND_SOC_BIAS_OFF) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_STANDBY);
+			if (ret != 0)
+				dev_err(d->dev,
+					"Failed to turn on bias: %d\n", ret);
+		}
 
-	/* If we're changing to all on or all off then prepare */
-	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
-	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
-		if (ret != 0)
-			dev_err(dapm->dev,
-				"Failed to prepare bias: %d\n", ret);
+		/* If we're changing to all on or all off then prepare */
+		if ((d->dev_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
+		    (!d->dev_power && d->bias_level == SND_SOC_BIAS_ON)) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_PREPARE);
+			if (ret != 0)
+				dev_err(d->dev,
+					"Failed to prepare bias: %d\n", ret);
+		}
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
@@ -1028,29 +1037,36 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Now power up. */
 	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
 
-	/* If we just powered the last thing off drop to standby bias */
-	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
-		if (ret != 0)
-			dev_err(dapm->dev,
-				"Failed to apply standby bias: %d\n", ret);
-	}
+	list_for_each_entry(d, &dapm->card->dapm_list, list) {
+		/* If we just powered the last thing off drop to standby bias */
+		if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->dev_power) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_STANDBY);
+			if (ret != 0)
+				dev_err(d->dev,
+					"Failed to apply standby bias: %d\n",
+					ret);
+		}
 
-	/* If we're in standby and can support bias off then do that */
-	if (dapm->bias_level == SND_SOC_BIAS_STANDBY &&
-	    dapm->idle_bias_off) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_OFF);
-		if (ret != 0)
-			dev_err(dapm->dev,
-				"Failed to turn off bias: %d\n", ret);
-	}
+		/* If we're in standby and can support bias off then do that */
+		if (d->bias_level == SND_SOC_BIAS_STANDBY &&
+		    d->idle_bias_off) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_OFF);
+			if (ret != 0)
+				dev_err(d->dev,
+					"Failed to turn off bias: %d\n", ret);
+		}
 
-	/* If we just powered up then move to active bias */
-	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_ON);
-		if (ret != 0)
-			dev_err(dapm->dev,
-				"Failed to apply active bias: %d\n", ret);
+		/* If we just powered up then move to active bias */
+		if (d->bias_level == SND_SOC_BIAS_PREPARE && d->dev_power) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_ON);
+			if (ret != 0)
+				dev_err(d->dev,
+					"Failed to apply active bias: %d\n",
+					ret);
+		}
 	}
 
 	pop_dbg(dapm->dev, card->pop_time,
@@ -2303,6 +2319,7 @@ void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
 	snd_soc_dapm_sys_remove(dapm->dev);
 	dapm_free_widgets(dapm);
+	list_del(&dapm->list);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
-- 
1.7.2.3
