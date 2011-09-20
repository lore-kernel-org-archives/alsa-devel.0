From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Trace and collect statistics for DAPM
	graph walking
Date: Tue, 20 Sep 2011 21:45:52 +0100
Message-ID: <1316551552-23025-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9BEB3103A63
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 22:47:02 +0200 (CEST)
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

One of the longest standing areas for improvement in ASoC has been the
DAPM algorithm - it repeats the same checks many times whenever it is run
and makes no effort to limit the areas of the graph it checks meaning we
do an awful lot of walks over the full graph. This has never mattered too
much as the size of the graph has generally been small in relation to the
size of the devices supported and the speed of CPUs but it is annoying.

In preparation for work on improving this insert a trace point after the
graph walk has been done. This gives us specific timing information for
the walk, and in order to give quantifiable (non-benchmark) numbers also
count every time we check a link or check the power for a widget and report
those numbers. Substantial changes in the algorithm may require tweaks to
the stats but they should be useful for simpler things.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h    |    5 +++++
 include/sound/soc.h         |    1 +
 include/trace/events/asoc.h |   22 ++++++++++++++++++++++
 sound/soc/soc-dapm.c        |   17 +++++++++++++++++
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 350b1b3..0e2d017 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -537,4 +537,9 @@ struct snd_soc_dapm_widget_list {
 	struct snd_soc_dapm_widget *widgets[0];
 };
 
+struct snd_soc_dapm_stats {
+	int power_checks;
+	int path_checks;
+};
+
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 24e17be..006f4f6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -828,6 +828,7 @@ struct snd_soc_card {
 
 	/* Generic DAPM context for the card */
 	struct snd_soc_dapm_context dapm;
+	struct snd_soc_dapm_stats dapm_stats;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 603f5a0..2e1adf6 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -216,6 +216,28 @@ DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_event_done,
 
 );
 
+TRACE_EVENT(snd_soc_dapm_walk_done,
+
+	TP_PROTO(struct snd_soc_card *card),
+
+	TP_ARGS(card),
+
+	TP_STRUCT__entry(
+		__string(	name,	card->name		)
+		__field(	int,	power_checks		)
+		__field(	int,	path_checks		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, card->name);
+		__entry->power_checks = card->dapm_stats.power_checks;
+		__entry->path_checks = card->dapm_stats.path_checks;
+	),
+
+	TP_printk("%s: %d power checks, %d path checks", __get_str(name),
+		  (int)__entry->power_checks, (int)__entry->path_checks)
+);
+
 TRACE_EVENT(snd_soc_jack_irq,
 
 	TP_PROTO(const char *name),
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4a440b5..6a1e13e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -48,6 +48,8 @@
 
 #include <trace/events/asoc.h>
 
+#define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.val++;
+
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
@@ -649,6 +651,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	struct snd_soc_dapm_path *path;
 	int con = 0;
 
+	DAPM_UPDATE_STAT(widget, path_checks);
+
 	if (widget->id == snd_soc_dapm_supply)
 		return 0;
 
@@ -697,6 +701,8 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	struct snd_soc_dapm_path *path;
 	int con = 0;
 
+	DAPM_UPDATE_STAT(widget, path_checks);
+
 	if (widget->id == snd_soc_dapm_supply)
 		return 0;
 
@@ -767,6 +773,8 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 {
 	int in, out;
 
+	DAPM_UPDATE_STAT(w, power_checks);
+
 	in = is_connected_input_ep(w);
 	dapm_clear_walk(w->dapm);
 	out = is_connected_output_ep(w);
@@ -779,6 +787,8 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 {
 	int in;
 
+	DAPM_UPDATE_STAT(w, power_checks);
+
 	if (w->active) {
 		in = is_connected_input_ep(w);
 		dapm_clear_walk(w->dapm);
@@ -793,6 +803,8 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 {
 	int out;
 
+	DAPM_UPDATE_STAT(w, power_checks);
+
 	if (w->active) {
 		out = is_connected_output_ep(w);
 		dapm_clear_walk(w->dapm);
@@ -808,6 +820,8 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 	struct snd_soc_dapm_path *path;
 	int power = 0;
 
+	DAPM_UPDATE_STAT(w, power_checks);
+
 	/* Check if one of our outputs is connected */
 	list_for_each_entry(path, &w->sinks, list_source) {
 		if (path->weak)
@@ -1208,6 +1222,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
+	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
+
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
@@ -1299,6 +1315,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	list_for_each_entry(d, &card->dapm_list, list)
 		d->target_bias_level = bias;
 
+	trace_snd_soc_dapm_walk_done(card);
 
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &dapm->card->dapm_list, list)
-- 
1.7.6.3
