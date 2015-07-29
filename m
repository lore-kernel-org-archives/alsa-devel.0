From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add widget path iterators" to the
	asoc tree
Date: Wed, 29 Jul 2015 15:13:20 +0100
Message-ID: <E1ZKS6i-0004d0-UN@finisterre>
References: <1437930302-2789-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F408265913
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:33 +0200 (CEST)
In-Reply-To: <1437930302-2789-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add widget path iterators

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e63bfd45aba4269811662de0954785622a2ac928 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 26 Jul 2015 19:05:00 +0200
Subject: [PATCH] ASoC: dapm: Add widget path iterators

Add helper iterator macros for iterating over the source and sink paths of
widget. This will make it easier to change the implementation later on.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h                 | 18 ++++++++++++++++++
 sound/soc/intel/atom/sst-atom-controls.c |  4 ++--
 sound/soc/soc-dapm.c                     | 30 +++++++++++++++---------------
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index cadc7fc..4973083 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -673,4 +673,22 @@ static inline enum snd_soc_bias_level snd_soc_dapm_get_bias_level(
 	return dapm->bias_level;
 }
 
+/**
+ * snd_soc_dapm_widget_for_each_sink_path - Iterates over all paths leaving a
+ *  widget
+ * @w: The widget
+ * @p: The path iterator variable
+ */
+#define snd_soc_dapm_widget_for_each_sink_path(w, p) \
+	list_for_each_entry(p, &w->sinks, list_source)
+
+/**
+ * snd_soc_dapm_widget_for_each_source_path - Iterates over all paths leading to
+ *  a widget
+ * @w: The widget
+ * @p: The path iterator variable
+ */
+#define snd_soc_dapm_widget_for_each_source_path(w, p) \
+	list_for_each_entry(p, &w->sources, list_sink)
+
 #endif
diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 31e9b9e..1399e34 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1298,7 +1298,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 		dev_dbg(dai->dev, "Stream name=%s\n",
 				dai->playback_widget->name);
 		w = dai->playback_widget;
-		list_for_each_entry(p, &w->sinks, list_source) {
+		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->connected && !p->connected(w, p->sink))
 				continue;
 
@@ -1317,7 +1317,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 		dev_dbg(dai->dev, "Stream name=%s\n",
 				dai->capture_widget->name);
 		w = dai->capture_widget;
-		list_for_each_entry(p, &w->sources, list_sink) {
+		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->connected && !p->connected(w, p->sink))
 				continue;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4586f95..ac506cf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -193,7 +193,7 @@ static void dapm_widget_invalidate_input_paths(struct snd_soc_dapm_widget *w)
 	list_add_tail(&w->work_list, &list);
 
 	list_for_each_entry(w, &list, work_list) {
-		list_for_each_entry(p, &w->sinks, list_source) {
+		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->is_supply || p->weak || !p->connect)
 				continue;
 			sink = p->sink;
@@ -232,7 +232,7 @@ static void dapm_widget_invalidate_output_paths(struct snd_soc_dapm_widget *w)
 	list_add_tail(&w->work_list, &list);
 
 	list_for_each_entry(w, &list, work_list) {
-		list_for_each_entry(p, &w->sources, list_sink) {
+		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->is_supply || p->weak || !p->connect)
 				continue;
 			source = p->source;
@@ -894,7 +894,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
 		/* match name */
-		list_for_each_entry(path, &w->sources, list_sink) {
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			/* mixer/mux paths name must match control name */
 			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
@@ -958,12 +958,12 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return ret;
 
 	if (w->id == snd_soc_dapm_mux) {
-		list_for_each_entry(path, &w->sources, list_sink) {
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			if (path->name)
 				dapm_kcontrol_add_path(w->kcontrols[0], path);
 		}
 	} else {
-		list_for_each_entry(path, &w->sinks, list_source) {
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			if (path->name)
 				dapm_kcontrol_add_path(w->kcontrols[0], path);
 		}
@@ -1079,7 +1079,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 		return widget->outputs;
 	}
 
-	list_for_each_entry(path, &widget->sinks, list_source) {
+	snd_soc_dapm_widget_for_each_sink_path(widget, path) {
 		DAPM_UPDATE_STAT(widget, neighbour_checks);
 
 		if (path->weak || path->is_supply)
@@ -1126,7 +1126,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 		return widget->inputs;
 	}
 
-	list_for_each_entry(path, &widget->sources, list_sink) {
+	snd_soc_dapm_widget_for_each_source_path(widget, path) {
 		DAPM_UPDATE_STAT(widget, neighbour_checks);
 
 		if (path->weak || path->is_supply)
@@ -1292,7 +1292,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	/* Check if one of our outputs is connected */
-	list_for_each_entry(path, &w->sinks, list_source) {
+	snd_soc_dapm_widget_for_each_sink_path(w, path) {
 		DAPM_UPDATE_STAT(w, neighbour_checks);
 
 		if (path->weak)
@@ -1716,12 +1716,12 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	/* If we changed our power state perhaps our neigbours changed
 	 * also.
 	 */
-	list_for_each_entry(path, &w->sources, list_sink)
+	snd_soc_dapm_widget_for_each_source_path(w, path)
 		dapm_widget_set_peer_power(path->source, power, path->connect);
 
 	/* Supplies can't affect their outputs, only their inputs */
 	if (!w->is_supply) {
-		list_for_each_entry(path, &w->sinks, list_source)
+		snd_soc_dapm_widget_for_each_sink_path(w, path)
 			dapm_widget_set_peer_power(path->sink, power,
 						   path->connect);
 	}
@@ -1958,7 +1958,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 				w->sname,
 				w->active ? "active" : "inactive");
 
-	list_for_each_entry(p, &w->sources, list_sink) {
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
 		if (p->connected && !p->connected(w, p->source))
 			continue;
 
@@ -1968,7 +1968,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 					p->name ? p->name : "static",
 					p->source->name);
 	}
-	list_for_each_entry(p, &w->sinks, list_source) {
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
 		if (p->connected && !p->connected(w, p->sink))
 			continue;
 
@@ -2426,7 +2426,7 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 		if (w->dapm->card->fully_routed)
 			break;
 		w->is_source = 1;
-		list_for_each_entry(p, &w->sources, list_sink) {
+		snd_soc_dapm_widget_for_each_source_path(w, p) {
 			if (p->source->id == snd_soc_dapm_micbias ||
 				p->source->id == snd_soc_dapm_mic ||
 				p->source->id == snd_soc_dapm_line ||
@@ -2441,7 +2441,7 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 		if (w->dapm->card->fully_routed)
 			break;
 		w->is_sink = 1;
-		list_for_each_entry(p, &w->sinks, list_source) {
+		snd_soc_dapm_widget_for_each_sink_path(w, p) {
 			if (p->sink->id == snd_soc_dapm_spk ||
 				p->sink->id == snd_soc_dapm_hp ||
 				p->sink->id == snd_soc_dapm_line ||
@@ -2841,7 +2841,7 @@ static int snd_soc_dapm_weak_route(struct snd_soc_dapm_context *dapm,
 		dev_warn(dapm->dev, "ASoC: Ignoring control for weak route %s->%s\n",
 			 route->source, route->sink);
 
-	list_for_each_entry(path, &source->sinks, list_source) {
+	snd_soc_dapm_widget_for_each_sink_path(source, path) {
 		if (path->sink == sink) {
 			path->weak = 1;
 			count++;
-- 
2.1.4
