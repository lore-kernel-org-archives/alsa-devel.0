From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ASoC: dapm - Add API call to query valid
	DAPM paths.
Date: Wed, 18 Apr 2012 11:41:11 +0100
Message-ID: <1334745671-29949-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 1953F2435F
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 12:42:06 +0200 (CEST)
Received: by wgbds11 with SMTP id ds11so467642wgb.3
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 03:42:04 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation for ASoC DSP support.

Add a DAPM API call to determine whether a DAPM audio path is valid between
source and sink widgets. This also takes into account all kcontrol mux and mixer
settings in between the source and sink widgets to validate the audio path.

This will be used by the DSP core to determine the runtime DAI mappings
between FE and BE DAIs in order to run PCM operations.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
Changes since V1:-
 Now uses new DAPM mutex.
 Tracepoint used for path debug.

 include/sound/soc-dapm.h    |    5 ++
 include/trace/events/asoc.h |   80 ++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c        |  122 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 197 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bea0c86..e3833d9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -321,6 +321,7 @@ struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_context;
 struct regulator;
+struct snd_soc_dapm_widget_list;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -403,6 +404,10 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
 
+/* dapm path query */
+int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
+	struct snd_soc_dapm_widget_list **list);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index ab26f8a..6d8efb1 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -7,6 +7,8 @@
 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
 
+#define DAPM_DIRECT "(direct)"
+
 struct snd_soc_jack;
 struct snd_soc_codec;
 struct snd_soc_platform;
@@ -241,6 +243,84 @@ TRACE_EVENT(snd_soc_dapm_walk_done,
 		  (int)__entry->path_checks, (int)__entry->neighbour_checks)
 );
 
+TRACE_EVENT(snd_soc_dapm_output_path,
+
+	TP_PROTO(struct snd_soc_dapm_widget *widget,
+		struct snd_soc_dapm_path *path),
+
+	TP_ARGS(widget, path),
+
+	TP_STRUCT__entry(
+		__string(	wname,	widget->name		)
+		__string(	pname,	path->name ? path->name : DAPM_DIRECT)
+		__string(	psname,	path->sink->name	)
+		__field(	int,	path_sink		)
+		__field(	int,	path_connect		)
+	),
+
+	TP_fast_assign(
+		__assign_str(wname, widget->name);
+		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
+		__assign_str(psname, path->sink->name);
+		__entry->path_connect = path->connect;
+		__entry->path_sink = (int)path->sink;
+	),
+
+	TP_printk("%c%s -> %s -> %s\n",
+		(int) __entry->path_sink &&
+		(int) __entry->path_connect ? '*' : ' ',
+		__get_str(wname), __get_str(pname), __get_str(psname))
+);
+
+TRACE_EVENT(snd_soc_dapm_input_path,
+
+	TP_PROTO(struct snd_soc_dapm_widget *widget,
+		struct snd_soc_dapm_path *path),
+
+	TP_ARGS(widget, path),
+
+	TP_STRUCT__entry(
+		__string(	wname,	widget->name		)
+		__string(	pname,	path->name ? path->name : DAPM_DIRECT)
+		__string(	psname,	path->source->name	)
+		__field(	int,	path_source		)
+		__field(	int,	path_connect		)
+	),
+
+	TP_fast_assign(
+		__assign_str(wname, widget->name);
+		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
+		__assign_str(psname, path->source->name);
+		__entry->path_connect = path->connect;
+		__entry->path_source = (int)path->source;
+	),
+
+	TP_printk("%c%s <- %s <- %s\n",
+		(int) __entry->path_source &&
+		(int) __entry->path_connect ? '*' : ' ',
+		__get_str(wname), __get_str(pname), __get_str(psname))
+);
+
+TRACE_EVENT(snd_soc_dapm_connected,
+
+	TP_PROTO(int paths, int stream),
+
+	TP_ARGS(paths, stream),
+
+	TP_STRUCT__entry(
+		__field(	int,	paths		)
+		__field(	int,	stream		)
+	),
+
+	TP_fast_assign(
+		__entry->paths = paths;
+		__entry->stream = stream;
+	),
+
+	TP_printk("%s: found %d paths\n",
+		__entry->stream ? "capture" : "playback", __entry->paths)
+);
+
 TRACE_EVENT(snd_soc_jack_irq,
 
 	TP_PROTO(const char *name),
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d7ee73a..214323f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -705,11 +705,51 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 	}
 }
 
+/* add widget to list if it's not already in the list */
+static int dapm_list_add_widget(struct snd_soc_dapm_widget_list **list,
+	struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_widget_list *wlist;
+	int wlistsize, wlistentries, i;
+
+	if (*list == NULL)
+		return -EINVAL;
+
+	wlist = *list;
+
+	/* is this widget already in the list */
+	for (i = 0; i < wlist->num_widgets; i++) {
+		if (wlist->widgets[i] == w)
+			return 0;
+	}
+
+	/* allocate some new space */
+	wlistentries = wlist->num_widgets + 1;
+	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
+			wlistentries * sizeof(struct snd_soc_dapm_widget *);
+	*list = krealloc(wlist, wlistsize, GFP_KERNEL);
+	if (*list == NULL) {
+		dev_err(w->dapm->dev, "can't allocate widget list for %s\n",
+			w->name);
+		return -ENOMEM;
+	}
+	wlist = *list;
+
+	/* insert the widget */
+	dev_dbg(w->dapm->dev, "added %s in widget list pos %d\n",
+			w->name, wlist->num_widgets);
+
+	wlist->widgets[wlist->num_widgets] = w;
+	wlist->num_widgets++;
+	return 1;
+}
+
 /*
  * Recursively check for a completed path to an active or physically connected
  * output widget. Returns number of complete paths.
  */
-static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
+static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
+	struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -765,9 +805,23 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 		if (path->walked)
 			continue;
 
+		trace_snd_soc_dapm_output_path(widget, path);
+
 		if (path->sink && path->connect) {
 			path->walked = 1;
-			con += is_connected_output_ep(path->sink);
+
+			/* do we need to add this widget to the list ? */
+			if (list) {
+				int err;
+				err = dapm_list_add_widget(list, path->sink);
+				if (err < 0) {
+					dev_err(widget->dapm->dev, "could not add widget %s\n",
+						widget->name);
+					return con;
+				}
+			}
+
+			con += is_connected_output_ep(path->sink, list);
 		}
 	}
 
@@ -780,7 +834,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
  * Recursively check for a completed path to an active or physically connected
  * input widget. Returns number of complete paths.
  */
-static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
+static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
+	struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -848,9 +903,23 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 		if (path->walked)
 			continue;
 
+		trace_snd_soc_dapm_input_path(widget, path);
+
 		if (path->source && path->connect) {
 			path->walked = 1;
-			con += is_connected_input_ep(path->source);
+
+			/* do we need to add this widget to the list ? */
+			if (list) {
+				int err;
+				err = dapm_list_add_widget(list, path->sink);
+				if (err < 0) {
+					dev_err(widget->dapm->dev, "could not add widget %s\n",
+						widget->name);
+					return con;
+				}
+			}
+
+			con += is_connected_input_ep(path->source, list);
 		}
 	}
 
@@ -859,6 +928,39 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	return con;
 }
 
+/**
+ * snd_soc_dapm_get_connected_widgets - query audio path and it's widgets.
+ * @dai: the soc DAI.
+ * @stream: stream direction.
+ * @list: list of active widgets for this stream.
+ *
+ * Queries DAPM graph as to whether an valid audio stream path exists for
+ * the initial stream specified by name. This takes into account
+ * current mixer and mux kcontrol settings. Creates list of valid widgets.
+ *
+ * Returns the number of valid paths or negative error.
+ */
+int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
+	struct snd_soc_dapm_widget_list **list)
+{
+	struct snd_soc_card *card = dai->card;
+	int paths;
+
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	dapm_reset(card);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		paths = is_connected_output_ep(dai->playback_widget, list);
+	else
+		paths = is_connected_input_ep(dai->playback_widget, list);
+
+	trace_snd_soc_dapm_connected(paths, stream);
+	dapm_clear_walk(&card->dapm);
+	mutex_unlock(&card->dapm_mutex);
+
+	return paths;
+}
+
 /*
  * Handler for generic register modifier widget.
  */
@@ -915,9 +1017,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 
 	DAPM_UPDATE_STAT(w, power_checks);
 
-	in = is_connected_input_ep(w);
+	in = is_connected_input_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
-	out = is_connected_output_ep(w);
+	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
 	return out != 0 && in != 0;
 }
@@ -940,7 +1042,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	if (w->active) {
-		in = is_connected_input_ep(w);
+		in = is_connected_input_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return in != 0;
 	} else {
@@ -956,7 +1058,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	if (w->active) {
-		out = is_connected_output_ep(w);
+		out = is_connected_output_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return out != 0;
 	} else {
@@ -1558,9 +1660,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	in = is_connected_input_ep(w);
+	in = is_connected_input_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
-	out = is_connected_output_ep(w);
+	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
-- 
1.7.5.4
