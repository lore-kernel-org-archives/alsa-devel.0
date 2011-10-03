From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Do DAPM power checks only for
	widgets changed since last run
Date: Mon,  3 Oct 2011 21:32:18 +0100
Message-ID: <1317673938-11716-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2388E103855
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 22:32:23 +0200 (CEST)
In-Reply-To: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

In order to reduce the number of DAPM power checks we run keep a list of
widgets which have been changed since the last DAPM run and iterate over
that rather than the full widget list. Whenever we change the power state
for a widget we add all the source and sink widgets it has to the dirty
list, ensuring that all widgets in the path are checked.

This covers more widgets than we need to as some of the neighbour widgets
won't be connected but it's simpler as a first step. On one system I tried
this gave:

           Power    Path   Neighbour
Before:    207      1939   2461
After:     114      1066   1327

which seems useful.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Still testing this one but it's looking robust enough right now.

 include/sound/soc-dapm.h |    1 +
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |    1 +
 sound/soc/soc-dapm.c     |   52 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bb59532..c080635 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -492,6 +492,7 @@ struct snd_soc_dapm_widget {
 
 	/* used during DAPM updates */
 	struct list_head power_list;
+	struct list_head dirty;
 };
 
 struct snd_soc_dapm_update {
diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4dc699..1224bc3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -827,6 +827,7 @@ struct snd_soc_card {
 	struct list_head widgets;
 	struct list_head paths;
 	struct list_head dapm_list;
+	struct list_head dapm_dirty;
 
 	/* Generic DAPM context for the card */
 	struct snd_soc_dapm_context dapm;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ed8093..778c177 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2916,6 +2916,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		card->rtd[i].dai_link = &card->dai_link[i];
 
 	INIT_LIST_HEAD(&card->list);
+	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c1f3563..50517d8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -119,6 +119,17 @@ static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 	kfree(buf);
 }
 
+static bool dapm_dirty_widget(struct snd_soc_dapm_widget *w)
+{
+	return !list_empty(&w->dirty);
+}
+
+static void dapm_mark_dirty(struct snd_soc_dapm_widget *w)
+{
+	if (!dapm_dirty_widget(w))
+		list_add_tail(&w->dirty, &w->dapm->card->dapm_dirty);
+}
+
 /* create a new dapm widget */
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	const struct snd_soc_dapm_widget *_widget)
@@ -1208,11 +1219,30 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 				  struct list_head *up_list,
 				  struct list_head *down_list)
 {
+	struct snd_soc_dapm_path *path;
+
 	if (w->power == power)
 		return;
 
 	trace_snd_soc_dapm_widget_power(w, power);
 
+	/* If we changed our power state perhaps our neigbours changed
+	 * also.  We're not yet smart enough to update relevant
+	 * neighbours when we change the state of a widget, this acts
+	 * as a proxy for that.  It will notify more neighbours than
+	 * is ideal.
+	 */
+	list_for_each_entry(path, &w->sources, list_sink) {
+		if (path->source) {
+			dapm_mark_dirty(path->source);
+		}
+	}
+	list_for_each_entry(path, &w->sinks, list_source) {
+		if (path->sink) {
+			dapm_mark_dirty(path->sink);
+		}
+	}
+
 	if (power)
 		dapm_seq_insert(w, up_list, true);
 	else
@@ -1276,13 +1306,18 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
 
 	/* Check which widgets we need to power and store them in
-	 * lists indicating if they should be powered up or down.
+	 * lists indicating if they should be powered up or down.  We
+	 * only check widgets that have been flagged as dirty but note
+	 * that new widgets may be added to the dirty list while we
+	 * iterate.
 	 */
-	list_for_each_entry(w, &card->widgets, list) {
+	list_for_each_entry(w, &card->dapm_dirty, dirty) {
 		dapm_power_one_widget(w, &up_list, &down_list);
 	}
 
 	list_for_each_entry(w, &card->widgets, list) {
+		list_del_init(&w->dirty);
+
 		if (w->power) {
 			d = w->dapm;
 
@@ -1579,8 +1614,10 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 			path->connect = 0; /* old connection must be powered down */
 	}
 
-	if (found)
+	if (found) {
+		dapm_mark_dirty(widget);
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
+	}
 
 	return 0;
 }
@@ -1607,8 +1644,10 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		path->connect = connect;
 	}
 
-	if (found)
+	if (found) {
+		dapm_mark_dirty(widget);
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
+	}
 
 	return 0;
 }
@@ -1752,6 +1791,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 	w->connected = status;
 	if (status == 0)
 		w->force = 0;
+	dapm_mark_dirty(w);
 
 	return 0;
 }
@@ -2107,6 +2147,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 
 		w->new = 1;
 
+		list_add(&w->dirty, &(w->dapm->card->dapm_dirty));
 		dapm_debugfs_add_widget(w);
 	}
 
@@ -2588,6 +2629,7 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
+	INIT_LIST_HEAD(&w->dirty);
 	list_add(&w->list, &dapm->card->widgets);
 
 	/* machine layer set ups unconnected pins and insertions */
@@ -2638,6 +2680,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 		dev_vdbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
 			w->name, w->sname, stream, event);
 		if (strstr(w->sname, stream)) {
+			dapm_mark_dirty(w);
 			switch(event) {
 			case SND_SOC_DAPM_STREAM_START:
 				w->active = 1;
@@ -2727,6 +2770,7 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 	dev_dbg(w->dapm->dev, "dapm: force enable pin %s\n", pin);
 	w->connected = 1;
 	w->force = 1;
+	dapm_mark_dirty(w);
 
 	return 0;
 }
-- 
1.7.6.3
