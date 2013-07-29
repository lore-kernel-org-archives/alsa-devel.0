From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/10] ASoC: dapm: Pass card instead of dapm
	context to dapm_power_widgets()
Date: Mon, 29 Jul 2013 17:13:56 +0200
Message-ID: <1375110845-8069-2-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D2C2625E2
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:13 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

DAPM operations are always performed on the card as a whole. Yet (primarily for
historic reasons) dapm_power_widgets() takes a DAPM context as its parameter.
The DAPM context is mainly used to look up a pointer to the card.  The same is
true for a couple of functions that are being called from dapm_power_widgets().
This patch changes the signature of dapm_power_widgets() and a couple of related
functions to take a snd_soc_card instead of a snd_soc_dapm_context.

Some of the functions also use the DAPM's device to print error and debug
messages. This can be a bit confusing though since this means the messages for
all widgets, also those from other contexts, will be printed with that device.
The patch updates those cases to use the device of the widget's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 100 +++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7449e27..5db8df2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1213,10 +1213,9 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 	list_add_tail(&new_widget->power_list, list);
 }
 
-static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
+static void dapm_seq_check_event(struct snd_soc_card *card,
 				 struct snd_soc_dapm_widget *w, int event)
 {
-	struct snd_soc_card *card = dapm->card;
 	const char *ev_name;
 	int power, ret;
 
@@ -1254,22 +1253,21 @@ static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
 		return;
 
 	if (w->event && (w->event_flags & event)) {
-		pop_dbg(dapm->dev, card->pop_time, "pop test : %s %s\n",
+		pop_dbg(w->dapm->dev, card->pop_time, "pop test : %s %s\n",
 			w->name, ev_name);
 		trace_snd_soc_dapm_widget_event_start(w, event);
 		ret = w->event(w, NULL, event);
 		trace_snd_soc_dapm_widget_event_done(w, event);
 		if (ret < 0)
-			dev_err(dapm->dev, "ASoC: %s: %s event failed: %d\n",
+			dev_err(w->dapm->dev, "ASoC: %s: %s event failed: %d\n",
 			       ev_name, w->name, ret);
 	}
 }
 
 /* Apply the coalesced changes from a DAPM sequence */
-static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
+static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 				   struct list_head *pending)
 {
-	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	int reg, power;
 	unsigned int value = 0;
@@ -1292,13 +1290,13 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		if (power)
 			value |= cur_mask;
 
-		pop_dbg(dapm->dev, card->pop_time,
+		pop_dbg(w->dapm->dev, card->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
 		/* Check for events */
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMU);
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMD);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMU);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMD);
 	}
 
 	if (reg >= 0) {
@@ -1308,7 +1306,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		w = list_first_entry(pending, struct snd_soc_dapm_widget,
 				     power_list);
 
-		pop_dbg(dapm->dev, card->pop_time,
+		pop_dbg(w->dapm->dev, card->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
@@ -1316,8 +1314,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	list_for_each_entry(w, pending, power_list) {
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMU);
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMD);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
 	}
 }
 
@@ -1329,8 +1327,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
  * Currently anything that requires more than a single write is not
  * handled.
  */
-static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
-			 struct list_head *list, int event, bool power_up)
+static void dapm_seq_run(struct snd_soc_card *card,
+	struct list_head *list, int event, bool power_up)
 {
 	struct snd_soc_dapm_widget *w, *n;
 	LIST_HEAD(pending);
@@ -1353,7 +1351,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
 		    w->dapm != cur_dapm || w->subseq != cur_subseq) {
 			if (!list_empty(&pending))
-				dapm_seq_run_coalesced(cur_dapm, &pending);
+				dapm_seq_run_coalesced(card, &pending);
 
 			if (cur_dapm && cur_dapm->seq_notifier) {
 				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
@@ -1413,7 +1411,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (!list_empty(&pending))
-		dapm_seq_run_coalesced(cur_dapm, &pending);
+		dapm_seq_run_coalesced(card, &pending);
 
 	if (cur_dapm && cur_dapm->seq_notifier) {
 		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
@@ -1423,9 +1421,9 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	}
 }
 
-static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
+static void dapm_widget_update(struct snd_soc_card *card)
 {
-	struct snd_soc_dapm_update *update = dapm->card->update;
+	struct snd_soc_dapm_update *update = card->update;
 	struct snd_soc_dapm_widget_list *wlist;
 	struct snd_soc_dapm_widget *w = NULL;
 	unsigned int wi;
@@ -1442,7 +1440,7 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 		if (w->event && (w->event_flags & SND_SOC_DAPM_PRE_REG)) {
 			ret = w->event(w, update->kcontrol, SND_SOC_DAPM_PRE_REG);
 			if (ret != 0)
-				dev_err(dapm->dev, "ASoC: %s DAPM pre-event failed: %d\n",
+				dev_err(w->dapm->dev, "ASoC: %s DAPM pre-event failed: %d\n",
 					   w->name, ret);
 		}
 	}
@@ -1453,7 +1451,7 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
 				  update->val);
 	if (ret < 0)
-		dev_err(dapm->dev, "ASoC: %s DAPM update failed: %d\n",
+		dev_err(w->dapm->dev, "ASoC: %s DAPM update failed: %d\n",
 			w->name, ret);
 
 	for (wi = 0; wi < wlist->num_widgets; wi++) {
@@ -1462,7 +1460,7 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 		if (w->event && (w->event_flags & SND_SOC_DAPM_POST_REG)) {
 			ret = w->event(w, update->kcontrol, SND_SOC_DAPM_POST_REG);
 			if (ret != 0)
-				dev_err(dapm->dev, "ASoC: %s DAPM post-event failed: %d\n",
+				dev_err(w->dapm->dev, "ASoC: %s DAPM post-event failed: %d\n",
 					   w->name, ret);
 		}
 	}
@@ -1627,9 +1625,8 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
+static int dapm_power_widgets(struct snd_soc_card *card, int event)
 {
-	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
@@ -1711,29 +1708,29 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	trace_snd_soc_dapm_walk_done(card);
 
 	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &dapm->card->dapm_list, list)
+	list_for_each_entry(d, &card->dapm_list, list)
 		async_schedule_domain(dapm_pre_sequence_async, d,
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
 
 	list_for_each_entry(w, &down_list, power_list) {
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMD);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_WILL_PMD);
 	}
 
 	list_for_each_entry(w, &up_list, power_list) {
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMU);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_WILL_PMU);
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(dapm, &down_list, event, false);
+	dapm_seq_run(card, &down_list, event, false);
 
-	dapm_widget_update(dapm);
+	dapm_widget_update(card);
 
 	/* Now power up. */
-	dapm_seq_run(dapm, &up_list, event, true);
+	dapm_seq_run(card, &up_list, event, true);
 
 	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &dapm->card->dapm_list, list)
+	list_for_each_entry(d, &card->dapm_list, list)
 		async_schedule_domain(dapm_post_sequence_async, d,
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
@@ -1744,7 +1741,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			d->stream_event(d, event);
 	}
 
-	pop_dbg(dapm->dev, card->pop_time,
+	pop_dbg(card->dev, card->pop_time,
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
 
@@ -1917,14 +1914,14 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-static int soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
+static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &dapm->card->paths, list) {
+	list_for_each_entry(path, &card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1946,7 +1943,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (found)
-		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP);
 
 	return found;
 }
@@ -1960,7 +1957,7 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	card->update = update;
-	ret = soc_dapm_mux_update_power(dapm, kcontrol, mux, e);
+	ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
 	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
@@ -1970,14 +1967,14 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-static int soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
+static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &dapm->card->paths, list) {
+	list_for_each_entry(path, &card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1989,7 +1986,7 @@ static int soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (found)
-		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP);
 
 	return found;
 }
@@ -2003,7 +2000,7 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	card->update = update;
-	ret = soc_dapm_mixer_update_power(dapm, kcontrol, connect);
+	ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
 	card->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
@@ -2180,7 +2177,7 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 		return 0;
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	ret = dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	ret = dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP);
 	mutex_unlock(&dapm->card->dapm_mutex);
 	return ret;
 }
@@ -2545,12 +2542,13 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
  */
 int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
+	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	unsigned int val;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 
-	list_for_each_entry(w, &dapm->card->widgets, list)
+	list_for_each_entry(w, &card->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -2560,7 +2558,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 						sizeof(struct snd_kcontrol *),
 						GFP_KERNEL);
 			if (!w->kcontrols) {
-				mutex_unlock(&dapm->card->dapm_mutex);
+				mutex_unlock(&card->dapm_mutex);
 				return -ENOMEM;
 			}
 		}
@@ -2601,8 +2599,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		dapm_debugfs_add_widget(w);
 	}
 
-	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
-	mutex_unlock(&dapm->card->dapm_mutex);
+	dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP);
+	mutex_unlock(&card->dapm_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -2695,7 +2693,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 		card->update = &update;
 
-		soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect);
+		soc_dapm_mixer_update_power(card, kcontrol, connect);
 
 		card->update = NULL;
 	}
@@ -2777,7 +2775,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		update.val = val;
 		card->update = &update;
 
-		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
+		soc_dapm_mux_update_power(card, kcontrol, mux, e);
 
 		card->update = NULL;
 	}
@@ -2832,7 +2830,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	if (change) {
 		widget->value = ucontrol->value.enumerated.item[0];
-		soc_dapm_mux_update_power(widget->dapm, kcontrol, widget->value, e);
+		soc_dapm_mux_update_power(card, kcontrol, widget->value, e);
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2930,7 +2928,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		update.val = val;
 		card->update = &update;
 
-		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
+		soc_dapm_mux_update_power(card, kcontrol, mux, e);
 
 		card->update = NULL;
 	}
@@ -3478,7 +3476,7 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 		}
 	}
 
-	dapm_power_widgets(&rtd->card->dapm, event);
+	dapm_power_widgets(rtd->card, event);
 }
 
 /**
@@ -3747,7 +3745,7 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 		if (dapm->bias_level == SND_SOC_BIAS_ON)
 			snd_soc_dapm_set_bias_level(dapm,
 						    SND_SOC_BIAS_PREPARE);
-		dapm_seq_run(dapm, &down_list, 0, false);
+		dapm_seq_run(card, &down_list, 0, false);
 		if (dapm->bias_level == SND_SOC_BIAS_PREPARE)
 			snd_soc_dapm_set_bias_level(dapm,
 						    SND_SOC_BIAS_STANDBY);
-- 
1.8.0
