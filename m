From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: dapm: Simplify list creation in
	dapm_dai_get_connected_widgets()
Date: Sun, 26 Jul 2015 19:04:59 +0200
Message-ID: <1437930302-2789-2-git-send-email-lars@metafoo.de>
References: <1437930302-2789-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-144.synserver.de (smtp-out-144.synserver.de
 [212.40.185.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 31531261501
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 19:05:08 +0200 (CEST)
In-Reply-To: <1437930302-2789-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

When running dapm_dai_get_connected_widgets() currently in
is_connected_{input,output}_ep() for each widget that gets added the array
is resized and the code also loops over all existing entries to avoid
adding a widget multiple times.

The former can be avoided by collecting the widgets in a linked list and
only once we have all widgets allocate the array.

The later can be avoided by changing when the widget is added. Currently it
is added when walking the neighbor lists of a widget. Since a widget can be
neighbors with multiple other widgets it could get added twice and hence
the check is necessary. But the main body of is_connected_{input,output}_ep
is guaranteed to be only executed at most once per widget. So adding the
widget to the list at the beginning of the function automatically makes
sure that each widget gets only added once. The only difference is that
using this method the starting point itself will also end up on the list,
but it can easily be skipped when creating the array.

Overall this reduces the code size and speeds things slightly up.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 101 ++++++++++++++++++---------------------------------
 sound/soc/soc-pcm.c  |  11 +-----
 2 files changed, 38 insertions(+), 74 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 10f7c7c..7704bc8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1032,43 +1032,27 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 	}
 }
 
-/* add widget to list if it's not already in the list */
-static int dapm_list_add_widget(struct snd_soc_dapm_widget_list **list,
-	struct snd_soc_dapm_widget *w)
+static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
+	struct list_head *widgets)
 {
-	struct snd_soc_dapm_widget_list *wlist;
-	int wlistsize, wlistentries, i;
-
-	if (*list == NULL)
-		return -EINVAL;
-
-	wlist = *list;
+	struct snd_soc_dapm_widget *w;
+	struct list_head *it;
+	unsigned int size = 0;
+	unsigned int i = 0;
 
-	/* is this widget already in the list */
-	for (i = 0; i < wlist->num_widgets; i++) {
-		if (wlist->widgets[i] == w)
-			return 0;
-	}
+	list_for_each(it, widgets)
+		size++;
 
-	/* allocate some new space */
-	wlistentries = wlist->num_widgets + 1;
-	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-			wlistentries * sizeof(struct snd_soc_dapm_widget *);
-	*list = krealloc(wlist, wlistsize, GFP_KERNEL);
-	if (*list == NULL) {
-		dev_err(w->dapm->dev, "ASoC: can't allocate widget list for %s\n",
-			w->name);
+	*list = kzalloc(sizeof(**list) + size * sizeof(*w), GFP_KERNEL);
+	if (*list == NULL)
 		return -ENOMEM;
-	}
-	wlist = *list;
 
-	/* insert the widget */
-	dev_dbg(w->dapm->dev, "ASoC: added %s in widget list pos %d\n",
-			w->name, wlist->num_widgets);
+	list_for_each_entry(w, widgets, work_list)
+		(*list)->widgets[i++] = w;
 
-	wlist->widgets[wlist->num_widgets] = w;
-	wlist->num_widgets++;
-	return 1;
+	(*list)->num_widgets = i;
+
+	return 0;
 }
 
 /*
@@ -1076,7 +1060,7 @@ static int dapm_list_add_widget(struct snd_soc_dapm_widget_list **list,
  * output widget. Returns number of complete paths.
  */
 static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
-	struct snd_soc_dapm_widget_list **list)
+	struct list_head *list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -1086,6 +1070,10 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
+	/* do we need to add this widget to the list ? */
+	if (list)
+		list_add_tail(&widget->work_list, list);
+
 	if (widget->is_sink && widget->connected) {
 		widget->outputs = snd_soc_dapm_suspend_check(widget);
 		return widget->outputs;
@@ -1104,22 +1092,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 		if (path->connect) {
 			path->walking = 1;
-
-			/* do we need to add this widget to the list ? */
-			if (list) {
-				int err;
-				err = dapm_list_add_widget(list, path->sink);
-				if (err < 0) {
-					dev_err(widget->dapm->dev,
-						"ASoC: could not add widget %s\n",
-						widget->name);
-					path->walking = 0;
-					return con;
-				}
-			}
-
 			con += is_connected_output_ep(path->sink, list);
-
 			path->walking = 0;
 		}
 	}
@@ -1134,7 +1107,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
  * input widget. Returns number of complete paths.
  */
 static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
-	struct snd_soc_dapm_widget_list **list)
+	struct list_head *list)
 {
 	struct snd_soc_dapm_path *path;
 	int con = 0;
@@ -1144,6 +1117,10 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
+	/* do we need to add this widget to the list ? */
+	if (list)
+		list_add_tail(&widget->work_list, list);
+
 	if (widget->is_source && widget->connected) {
 		widget->inputs = snd_soc_dapm_suspend_check(widget);
 		return widget->inputs;
@@ -1162,22 +1139,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 		if (path->connect) {
 			path->walking = 1;
-
-			/* do we need to add this widget to the list ? */
-			if (list) {
-				int err;
-				err = dapm_list_add_widget(list, path->source);
-				if (err < 0) {
-					dev_err(widget->dapm->dev,
-						"ASoC: could not add widget %s\n",
-						widget->name);
-					path->walking = 0;
-					return con;
-				}
-			}
-
 			con += is_connected_input_ep(path->source, list);
-
 			path->walking = 0;
 		}
 	}
@@ -1204,7 +1166,9 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 {
 	struct snd_soc_card *card = dai->component->card;
 	struct snd_soc_dapm_widget *w;
+	LIST_HEAD(widgets);
 	int paths;
+	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
@@ -1218,9 +1182,16 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	}
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		paths = is_connected_output_ep(dai->playback_widget, list);
+		paths = is_connected_output_ep(dai->playback_widget, &widgets);
 	else
-		paths = is_connected_input_ep(dai->capture_widget, list);
+		paths = is_connected_input_ep(dai->capture_widget, &widgets);
+
+	/* Drop starting point */
+	list_del(widgets.next);
+
+	ret = dapm_widget_list_create(list, &widgets);
+	if (ret)
+		return ret;
 
 	trace_snd_soc_dapm_connected(paths, stream);
 	mutex_unlock(&card->dapm_mutex);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a6d3313..70e4b9d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1231,24 +1231,17 @@ static int widget_in_list(struct snd_soc_dapm_widget_list *list,
 }
 
 int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
-	int stream, struct snd_soc_dapm_widget_list **list_)
+	int stream, struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	struct snd_soc_dapm_widget_list *list;
 	int paths;
 
-	list = kzalloc(sizeof(struct snd_soc_dapm_widget_list) +
-			sizeof(struct snd_soc_dapm_widget *), GFP_KERNEL);
-	if (list == NULL)
-		return -ENOMEM;
-
 	/* get number of valid DAI paths and their widgets */
-	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, &list);
+	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list);
 
 	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
 
-	*list_ = list;
 	return paths;
 }
 
-- 
2.1.4
