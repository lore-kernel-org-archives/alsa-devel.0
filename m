From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Add API call to query valid DAPM
	paths.
Date: Wed,  7 Mar 2012 17:55:52 +0000
Message-ID: <1331142952-6502-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog127.obsmtp.com [74.125.149.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C56524534
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 18:56:15 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id ed3so4246858wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 09:56:01 -0800 (PST)
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

Add a DAPM API call to determine whether a DAPM audio path is valid between
source and sink widgets. This also takes into account all kcontrol mux and mixer
settings in between the source and sink widgets to validate the audio path.

This will be used by the Dynamic PCM core to determine the runtime DAI mappings
between FE and BE DAIs in order to run PCM operations.

This also adds some extra debug to help with graph debugging.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    5 ++
 sound/soc/soc-dapm.c     |  127 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d3e45a0..8d58880 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -323,6 +323,7 @@ struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_context;
+struct snd_soc_dapm_widget_list;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -401,6 +402,10 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
 
+/* dapm path query */
+int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
+	struct snd_soc_dapm_widget_list **list);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8320fd7..c7928db 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -703,11 +703,51 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
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
@@ -763,9 +803,26 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 		if (path->walked)
 			continue;
 
+		dev_vdbg(widget->dapm->dev," %c : %s -> %s -> %s\n",
+			path->sink && path->connect ? '*' : ' ',
+			widget->name, path->name, path->sink->name);
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
+					dev_err(widget->dapm->dev,
+						"could not add widget %s\n",
+						widget->name);
+					return con;
+				}
+			}
+
+			con += is_connected_output_ep(path->sink, list);
 		}
 	}
 
@@ -778,7 +835,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
  * Recursively check for a completed path to an active or physically connected
  * input widget. Returns number of complete paths.
  */
-static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
+static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
+	struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -846,9 +904,26 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 		if (path->walked)
 			continue;
 
+		dev_vdbg(widget->dapm->dev," %c : %s <- %s <- %s\n",
+			path->source && path->connect ? '*' : ' ',
+			widget->name, path->name, path->source->name);
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
+					dev_err(widget->dapm->dev,
+						"could not add widget %s\n",
+						widget->name);
+					return con;
+				}
+			}
+
+			con += is_connected_input_ep(path->source, list);
 		}
 	}
 
@@ -857,6 +932,38 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
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
+	dapm_reset(card);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		paths = is_connected_output_ep(dai->playback_widget, list);
+	else
+		paths = is_connected_input_ep(dai->playback_widget, list);
+
+	dev_dbg(dai->dev, "%s: found %d paths\n",
+			stream ? "capture" : "playback", paths);
+	dapm_clear_walk(&card->dapm);
+
+	return paths;
+}
+
 /*
  * Handler for generic register modifier widget.
  */
@@ -913,9 +1020,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 
 	DAPM_UPDATE_STAT(w, power_checks);
 
-	in = is_connected_input_ep(w);
+	in = is_connected_input_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
-	out = is_connected_output_ep(w);
+	out = is_connected_output_ep(w, NULL);
 	dapm_clear_walk(w->dapm);
 	return out != 0 && in != 0;
 }
@@ -935,7 +1042,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	if (w->active) {
-		in = is_connected_input_ep(w);
+		in = is_connected_input_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return in != 0;
 	} else {
@@ -951,7 +1058,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	if (w->active) {
-		out = is_connected_output_ep(w);
+		out = is_connected_output_ep(w, NULL);
 		dapm_clear_walk(w->dapm);
 		return out != 0;
 	} else {
@@ -1587,9 +1694,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
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
