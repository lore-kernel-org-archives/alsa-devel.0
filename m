From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: Pass snd_soc_card instead of
	snd_soc_dapm_context were appropriate
Date: Thu, 28 Apr 2011 18:46:10 +0200
Message-ID: <1304009173-5786-4-git-send-email-lars@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id 3F0F410381F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:27 +0200 (CEST)
In-Reply-To: <1304009173-5786-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the DAPM widget list was moved from DAPM context to snd_soc_card a few
functions which take a snd_soc_dapm_context only use it to get a pointer to the
snd_soc_card. Change these functions to take a snd_soc_card directly.
This will allow to implement DAPM functions which operate on the whole card
instead of individual DAPM contexts.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2801c6a..1c571bc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -721,10 +721,9 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 	list_add_tail(&new_widget->power_list, list);
 }
 
-static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
+static void dapm_seq_check_event(struct snd_soc_card *card,
 				 struct snd_soc_dapm_widget *w, int event)
 {
-	struct snd_soc_card *card = dapm->card;
 	const char *ev_name;
 	int power, ret;
 
@@ -754,7 +753,7 @@ static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
 		return;
 
 	if (w->event && (w->event_flags & event)) {
-		pop_dbg(dapm->dev, card->pop_time, "pop test : %s %s\n",
+		pop_dbg(card->dev, card->pop_time, "pop test : %s %s\n",
 			w->name, ev_name);
 		trace_snd_soc_dapm_widget_event_start(w, event);
 		ret = w->event(w, NULL, event);
@@ -797,8 +796,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 			w->name, reg, value, mask);
 
 		/* Check for events */
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMU);
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMD);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMU);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMD);
 	}
 
 	if (reg >= 0) {
@@ -810,8 +809,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	list_for_each_entry(w, pending, power_list) {
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMU);
-		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMD);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
+		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
 	}
 }
 
@@ -1014,10 +1013,9 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event,
+static int dapm_power_widgets(struct snd_soc_card *card, int event,
 	struct snd_soc_dapm_update *update)
 {
-	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
@@ -1087,7 +1085,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event,
 		d->dev_power = power_card;
 
 	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &dapm->card->dapm_list, list)
+	list_for_each_entry(d, &card->dapm_list, list)
 		async_schedule_domain(dapm_pre_sequence_async, d,
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
@@ -1101,12 +1099,12 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event,
 	dapm_seq_run(&up_list, event, true);
 
 	/* Run all the bias changes in parallel */
-	list_for_each_entry(d, &dapm->card->dapm_list, list)
+	list_for_each_entry(d, &card->dapm_list, list)
 		async_schedule_domain(dapm_post_sequence_async, d,
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
 
-	pop_dbg(dapm->dev, card->pop_time,
+	pop_dbg(card->dev, card->pop_time,
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
 
@@ -1270,7 +1268,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 int mux, struct soc_enum *e,
 				 struct snd_soc_dapm_update *update)
 {
-	struct snd_soc_dapm_context *dapm = widget->dapm;
+	struct snd_soc_card *card = widget->dapm->card;
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
@@ -1283,7 +1281,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &dapm->card->paths, list) {
+	list_for_each_entry(path, &card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1299,7 +1297,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, update);
+		dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP, update);
 
 	return 0;
 }
@@ -1309,7 +1307,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int connect,
 				   struct snd_soc_dapm_update *update)
 {
-	struct snd_soc_dapm_context *dapm = widget->dapm;
+	struct snd_soc_card *card = widget->dapm->card;
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
@@ -1319,7 +1317,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &dapm->card->paths, list) {
+	list_for_each_entry(path, &card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1330,7 +1328,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, update);
+		dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP, update);
 
 	return 0;
 }
@@ -1488,7 +1486,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
  */
 int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
-	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, NULL);
+	return dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
@@ -1740,7 +1738,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		w->new = 1;
 	}
 
-	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, NULL);
+	dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP, NULL);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -2231,7 +2229,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
-	dapm_power_widgets(dapm, event, NULL);
+	dapm_power_widgets(dapm->card, event, NULL);
 }
 
 /**
-- 
1.7.2.5
