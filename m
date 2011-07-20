From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ASoC: dapm - Add API call to query the
	widgets of valid DAPM paths.
Date: Wed, 20 Jul 2011 12:23:15 +0100
Message-ID: <1311160995-3475-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 213E9245E2
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 13:23:26 +0200 (CEST)
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

In preparation for Dynamic PCM (AKA DSP) support.

Add a DAPM API call to determine whether a DAPM audio path is valid between
source and sink widgets and return the path widgets. This also takes into
account all kcontrol mux and mixer settings in between the source and sink
widgets to validate the audio path.

This will be used by the Dynamic PCM core to determine the runtime DAI mappings
between FE and BE DAIs in order to run PCM operations.

This modifies the existing is_connected_input_ep() and is_connected_output_ep() by
adding a new parameter to store any valid widgets in a list. We also add some extra
debug to provide further insight into the DAPM path and widget discovery.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    6 ++
 sound/soc/soc-dapm.c     |  184 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 178 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e09505c..198997d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -310,6 +310,7 @@ struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_context;
+struct snd_soc_dapm_widget_list;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -375,6 +376,11 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
 
+/* dapm path query */
+int snd_soc_dapm_get_connected_widgets(struct snd_soc_dapm_context *dapm,
+		const char *stream_name, struct snd_soc_dapm_widget_list **list,
+		int stream);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fbfcda0..4205a97 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -605,11 +605,51 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
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
@@ -638,15 +678,38 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
+
 		if (path->weak)
 			continue;
 
 		if (path->walked)
 			continue;
 
-		if (path->sink && path->connect) {
+
+		if (path->sink) {
+
+			dev_dbg(widget->dapm->dev," %c : %s -> %s -> %s\n",
+				path->sink && path->connect ? '*' : ' ',
+				widget->name, path->name, path->sink->name);
+
+			if (!path->connect)
+				continue;
+
 			path->walked = 1;
-			con += is_connected_output_ep(path->sink);
+
+			/* do we need to add this widget to the list ? */
+			if (list) {
+				int err;
+
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
 
@@ -657,7 +720,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
  * Recursively check for a completed path to an active or physically connected
  * input widget. Returns number of complete paths.
  */
-static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
+static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
+	struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -691,21 +755,117 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
+
 		if (path->weak)
 			continue;
 
 		if (path->walked)
 			continue;
 
-		if (path->source && path->connect) {
+		if (path->source) {
+
+			dev_dbg(widget->dapm->dev," %c : %s <- %s <- %s\n",
+				path->source && path->connect ? '*' : ' ',
+				widget->name, path->name, path->source->name);
+
+			if (!path->connect)
+				continue;
+
 			path->walked = 1;
-			con += is_connected_input_ep(path->source);
+
+			/* do we need to add this widget to the list ? */
+			if (list) {
+				int err;
+
+				err = dapm_list_add_widget(list, path->source);
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
 
 	return con;
 }
 
+static int dapm_get_playback_paths(struct snd_soc_dapm_context *dapm,
+		struct snd_soc_dapm_widget *root,
+		struct snd_soc_dapm_widget_list **list)
+{
+	int paths;
+
+	dev_dbg(dapm->dev, "Playback: checking paths from %s\n",root->name);
+	paths = is_connected_output_ep(root, list);
+	dev_dbg(dapm->dev, "Playback: found %d paths from %s\n", paths, root->name);
+
+	return paths;
+}
+
+static int dapm_get_capture_paths(struct snd_soc_dapm_context *dapm,
+		struct snd_soc_dapm_widget *root,
+		struct snd_soc_dapm_widget_list **list)
+{
+	int paths;
+
+	dev_dbg(dapm->dev, "Capture: checking paths from %s\n",root->name);
+	paths = is_connected_input_ep(root, list);
+	dev_dbg(dapm->dev, "Capture: found %d paths from %s\n", paths, root->name);
+
+	return paths;
+}
+
+/**
+ * snd_soc_dapm_get_connected_widgets - query audio path and it's widgets.
+ * @dapm: the dapm context.
+ * @stream_name: stream name.
+ * @list: list of active widgets for this stream.
+ * @stream: stream direction.
+ *
+ * Queries DAPM graph as to whether an valid audio stream path exists for
+ * the initial widget specified by name. This takes into account
+ * current mixer and mux kcontrol settings. Creates list of valid widgets.
+ *
+ * Returns the number of valid paths or negative error.
+ */
+int snd_soc_dapm_get_connected_widgets(struct snd_soc_dapm_context *dapm,
+	const char *stream_name, struct snd_soc_dapm_widget_list **list,
+	int stream)
+{
+	struct snd_soc_dapm_widget *w;
+	enum snd_soc_dapm_type type;
+	int paths;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		type = snd_soc_dapm_aif_in;
+	else
+		type = snd_soc_dapm_aif_out;
+
+	/* get stream root widget AIF from stream string and direction */
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+
+		if (w->id != type)
+			continue;
+
+		if (strstr(w->sname, stream_name))
+			goto found;
+	}
+	dev_err(dapm->dev, "root widget for %s not found\n", stream_name);
+	return 0;
+
+found:
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		paths = dapm_get_playback_paths(dapm, w, list);
+	else
+		paths = dapm_get_capture_paths(dapm, w, list);
+
+	dapm_clear_walk(dapm);
+	return paths;
+}
+
 /*
  * Handler for generic register modifier widget.
  */
@@ -732,9 +892,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 {
 	int in, out;
 
-	in = is_connected_input_ep(w);
+	in = is_connected_input_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
-	out = is_connected_output_ep(w);
+	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
 	return out != 0 && in != 0;
 }
@@ -745,7 +905,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 	int in;
 
 	if (w->active) {
-		in = is_connected_input_ep(w);
+		in = is_connected_input_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return in != 0;
 	} else {
@@ -759,7 +919,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 	int out;
 
 	if (w->active) {
-		out = is_connected_output_ep(w);
+		out = is_connected_output_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return out != 0;
 	} else {
@@ -1315,9 +1475,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	in = is_connected_input_ep(w);
+	in = is_connected_input_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
-	out = is_connected_output_ep(w);
+	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s  in %d out %d",
-- 
1.7.4.1
