From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_ii/iv 3/3] ASoC: Extend DAPM to handle power
	changes on cross-device paths
Date: Fri, 29 Oct 2010 15:02:22 +0300
Message-ID: <1288353742-22005-3-git-send-email-jhnikula@gmail.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7779C103855
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 14:01:24 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 24so1790696eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 05:01:24 -0700 (PDT)
In-Reply-To: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
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

This patch implements this by modifying the dapm_power_widgets so that it
checks all the widgets on snd_soc_card that needs power change. Also all
DAPM contexts are traversed if there is a need to change bias state of them.
Only exception is widgetless codec whose bias state is changed only if power
change is originating from that context.

Functions dapm_seq_run and dapm_seq_run_coalesced are modified so that a new
write is issued when the sequence extends to an another device and DAPM
context of a widget instead of originating DAPM context is used when doing
pop waits and register writes.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h |    3 +
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |    2 +
 sound/soc/soc-dapm.c     |  107 +++++++++++++++++++++++++--------------------
 4 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7f20804..17b1825 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -477,6 +477,9 @@ struct snd_soc_dapm_context {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
+	/* used during DAPM updates */
+	int sys_power;
+	struct list_head list;
 };
 
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index b752c52..4a67177 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -592,6 +592,7 @@ struct snd_soc_card {
 
 	struct list_head widgets;
 	struct list_head paths;
+	struct list_head dapm_list;
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 571de78..5f4b53c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1421,6 +1421,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 		/* mark codec as probed and add to card codec list */
 		codec->probed = 1;
 		list_add(&codec->card_list, &card->codec_dev_list);
+		list_add(&codec->dapm->list, &card->dapm_list);
 	}
 
 	/* probe the platform */
@@ -1665,6 +1666,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->platform_dev_list);
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
+	INIT_LIST_HEAD(&card->dapm_list);
 
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fc1b943..2bccc9d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -717,14 +717,15 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				   struct list_head *pending)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *w, *wt;
 	int reg, power, ret;
 	unsigned int value = 0;
 	unsigned int mask = 0;
 	unsigned int cur_mask;
 
-	reg = list_first_entry(pending, struct snd_soc_dapm_widget,
-			       power_list)->reg;
+	wt = list_first_entry(pending, struct snd_soc_dapm_widget,
+			      power_list);
+	reg = wt->reg;
 
 	list_for_each_entry(w, pending, power_list) {
 		cur_mask = 1 << w->shift;
@@ -746,7 +747,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power up pre event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMU\n",
+			pop_dbg(w->dapm->pop_time, "pop test : %s PRE_PMU\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
@@ -757,7 +758,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power down pre event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMD\n",
+			pop_dbg(w->dapm->pop_time, "pop test : %s PRE_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
@@ -767,11 +768,11 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (reg >= 0) {
-		pop_dbg(dapm->pop_time,
+		pop_dbg(wt->dapm->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
-			value, mask, reg, dapm->pop_time);
-		pop_wait(dapm->pop_time);
-		snd_soc_update_bits(dapm->codec, reg, mask, value);
+			value, mask, reg, wt->dapm->pop_time);
+		pop_wait(wt->dapm->pop_time);
+		snd_soc_update_bits(wt->dapm->codec, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -815,19 +816,22 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm, struct list_head *li
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
 				dapm_seq_run_coalesced(dapm, &pending);
 
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
 			cur_reg = SND_SOC_NOPM;
+			cur_dapm = NULL;
 		}
 
 		switch (w->id) {
@@ -871,6 +875,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm, struct list_head *li
 			/* Queue it up for application */
 			cur_sort = sort[w->id];
 			cur_reg = w->reg;
+			cur_dapm = w->dapm;
 			list_move(&w->power_list, &pending);
 			break;
 		}
@@ -897,18 +902,19 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 {
 	struct snd_soc_card *card = dapm->codec->card;
 	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
 	int ret = 0;
 	int power;
-	int sys_power = 0;
+
+	list_for_each_entry(d, &dapm->card->dapm_list, list)
+		d->sys_power = 0;
 
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
@@ -926,7 +932,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			else
 				power = 1;
 			if (power)
-				sys_power = 1;
+				w->dapm->sys_power = 1;
 
 			if (w->power == power)
 				continue;
@@ -948,19 +954,19 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
-			sys_power = 1;
+			dapm->sys_power = 1;
 			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
-			sys_power = 0;
+			dapm->sys_power = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
 			switch (dapm->bias_level) {
 				case SND_SOC_BIAS_STANDBY:
 				case SND_SOC_BIAS_OFF:
-					sys_power = 0;
+					dapm->sys_power = 0;
 					break;
 				default:
-					sys_power = 1;
+					dapm->sys_power = 1;
 					break;
 			}
 			break;
@@ -969,19 +975,21 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	if (sys_power && dapm->bias_level == SND_SOC_BIAS_OFF) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm,
-						  SND_SOC_BIAS_STANDBY);
-		if (ret != 0)
-			pr_err("Failed to turn on bias: %d\n", ret);
-	}
+	list_for_each_entry(d, &dapm->card->dapm_list, list) {
+		if (d->sys_power && d->bias_level == SND_SOC_BIAS_OFF) {
+			ret = snd_soc_dapm_set_bias_level(card, d,
+							  SND_SOC_BIAS_STANDBY);
+			if (ret != 0)
+				pr_err("Failed to turn on bias: %d\n", ret);
+		}
 
-	/* If we're changing to all on or all off then prepare */
-	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
-	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
-		if (ret != 0)
-			pr_err("Failed to prepare bias: %d\n", ret);
+		/* If we're changing to all on or all off then prepare */
+		if ((d->sys_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
+		    (!d->sys_power && d->bias_level == SND_SOC_BIAS_ON)) {
+			ret = snd_soc_dapm_set_bias_level(card, d, SND_SOC_BIAS_PREPARE);
+			if (ret != 0)
+				pr_err("Failed to prepare bias: %d\n", ret);
+		}
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
@@ -990,26 +998,28 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Now power up. */
 	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
 
-	/* If we just powered the last thing off drop to standby bias */
-	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
-		if (ret != 0)
-			pr_err("Failed to apply standby bias: %d\n", ret);
-	}
+	list_for_each_entry(d, &dapm->card->dapm_list, list) {
+		/* If we just powered the last thing off drop to standby bias */
+		if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->sys_power) {
+			ret = snd_soc_dapm_set_bias_level(card, d, SND_SOC_BIAS_STANDBY);
+			if (ret != 0)
+				pr_err("Failed to apply standby bias: %d\n", ret);
+		}
 
-	/* If we're in standby and can support bias off then do that */
-	if (dapm->bias_level == SND_SOC_BIAS_STANDBY &&
-	    dapm->idle_bias_off) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_OFF);
-		if (ret != 0)
-			pr_err("Failed to turn off bias: %d\n", ret);
-	}
+		/* If we're in standby and can support bias off then do that */
+		if (d->bias_level == SND_SOC_BIAS_STANDBY &&
+		    d->idle_bias_off) {
+			ret = snd_soc_dapm_set_bias_level(card, d, SND_SOC_BIAS_OFF);
+			if (ret != 0)
+				pr_err("Failed to turn off bias: %d\n", ret);
+		}
 
-	/* If we just powered up then move to active bias */
-	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_ON);
-		if (ret != 0)
-			pr_err("Failed to apply active bias: %d\n", ret);
+		/* If we just powered up then move to active bias */
+		if (d->bias_level == SND_SOC_BIAS_PREPARE && d->sys_power) {
+			ret = snd_soc_dapm_set_bias_level(card, d, SND_SOC_BIAS_ON);
+			if (ret != 0)
+				pr_err("Failed to apply active bias: %d\n", ret);
+		}
 	}
 
 	pop_dbg(dapm->pop_time, "DAPM sequencing finished, waiting %dms\n",
@@ -2225,6 +2235,7 @@ void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
 	snd_soc_dapm_sys_remove(dapm->dev);
 	dapm_free_widgets(dapm);
+	list_del(&dapm->list);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
-- 
1.7.2.3
