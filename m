From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2.1 2/3] ASoC: Move widgets from DAPM context
	to snd_soc_card
Date: Tue, 14 Dec 2010 12:18:31 +0200
Message-ID: <1292321912-24765-3-git-send-email-jhnikula@gmail.com>
References: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E42BE1038EE
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 11:17:39 +0100 (CET)
Received: by eyg24 with SMTP id 24so205059eyg.24
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 02:17:36 -0800 (PST)
In-Reply-To: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
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

Decoupling widgets from DAPM context is required when extending the ASoC
core to cross-device paths. Even the list of widgets are now kept in
struct snd_soc_card, the widget listing in sysfs and debugs remain sorted
per device.

This patch makes possible to build cross-device paths but does not extend
yet the DAPM to handle codec bias and widget power changes of an another
device.

Cross-device paths are registered by listing the widgets from device A in
a map for device B. In case of conflicting widget names between the devices,
a uniform name prefix is needed to separate them. See commit ead9b91
"ASoC: Add optional name_prefix for kcontrol, widget and route names" for
help.

An example below shows a path that connects MONO out of A into Line In of B:

static const struct snd_soc_dapm_route mapA[] = {
	{"MONO", NULL, "DAC"},
};

static const struct snd_soc_dapm_route mapB[] = {
	{"Line In", NULL, "MONO"},
};

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h  |    2 +-
 include/sound/soc.h       |    1 +
 sound/soc/codecs/wm8960.c |    4 ++-
 sound/soc/soc-core.c      |    2 +-
 sound/soc/soc-dapm.c      |   69 ++++++++++++++++++++++++++++++++-------------
 5 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9d1ff07..a6f04b1 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -468,7 +468,7 @@ struct snd_soc_dapm_widget {
 
 /* DAPM context */
 struct snd_soc_dapm_context {
-	struct list_head widgets;
+	int n_widgets; /* number of widgets in this context */
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 466895b..d5fb861 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -661,6 +661,7 @@ struct snd_soc_card {
 	struct list_head platform_dev_list;
 	struct list_head dai_dev_list;
 
+	struct list_head widgets;
 	struct list_head paths;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 2c5712d..054f573 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -418,7 +418,9 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	 * list each time to find the desired power state do so now
 	 * and save the result.
 	 */
-	list_for_each_entry(w, &codec->dapm.widgets, list) {
+	list_for_each_entry(w, &codec->card->widgets, list) {
+		if (w->dapm != &codec->dapm)
+			continue;
 		if (strcmp(w->name, "LOUT1 PGA") == 0)
 			wm8960->lout1 = w;
 		if (strcmp(w->name, "ROUT1 PGA") == 0)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bdb2ca9..bd183a7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1879,6 +1879,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->dai_dev_list);
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 
 	soc_init_card_debugfs(card);
@@ -3481,7 +3482,6 @@ int snd_soc_register_codec(struct device *dev,
 	else
 		codec->compress_type = SND_SOC_FLAT_COMPRESSION;
 
-	INIT_LIST_HEAD(&codec->dapm.widgets);
 	codec->write = codec_drv->write;
 	codec->read = codec_drv->read;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 314238a..35f069c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -937,7 +937,9 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
@@ -975,7 +977,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
 	 */
-	if (list_empty(&dapm->widgets)) {
+	if (!dapm->n_widgets) {
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
@@ -1142,8 +1144,8 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 	if (!dapm->debugfs_dapm)
 		return;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
-		if (!w->name)
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!w->name || w->dapm != dapm)
 			continue;
 
 		d = debugfs_create_file(w->name, 0444,
@@ -1238,7 +1240,9 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->dapm.widgets, list) {
+	list_for_each_entry(w, &codec->card->widgets, list) {
+		if (w->dapm != &codec->dapm)
+			continue;
 
 		/* only display widgets that burnm power */
 		switch (w->id) {
@@ -1299,7 +1303,9 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 	struct snd_soc_dapm_widget *w, *next_w;
 	struct snd_soc_dapm_path *p, *next_p;
 
-	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
+	list_for_each_entry_safe(w, next_w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		list_del(&w->list);
 		/*
 		 * remove source and sink paths associated to this widget.
@@ -1330,7 +1336,9 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			dev_dbg(w->dapm->dev, "dapm: pin %s = %d\n",
 				pin, status);
@@ -1366,6 +1374,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
+	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
 	const char *sink;
 	const char *control = route->control;
 	const char *source;
@@ -1385,17 +1394,28 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		source = route->source;
 	}
 
-	/* find src and dest widgets */
-	list_for_each_entry(w, &dapm->widgets, list) {
-
+	/*
+	 * find src and dest widgets over all widgets but favor a widget from
+	 * current DAPM context
+	 */
+	list_for_each_entry(w, &dapm->card->widgets, list) {
 		if (!wsink && !(strcmp(w->name, sink))) {
-			wsink = w;
+			wtsink = w;
+			if (w->dapm == dapm)
+				wsink = w;
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
-			wsource = w;
+			wtsource = w;
+			if (w->dapm == dapm)
+				wsource = w;
 		}
 	}
+	/* use widget from another DAPM context if not found from this */
+	if (!wsink)
+		wsink = wtsink;
+	if (!wsource)
+		wsource = wtsource;
 
 	if (wsource == NULL || wsink == NULL)
 		return -ENODEV;
@@ -1532,7 +1552,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list)
+	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -2031,12 +2051,13 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	else
 		snprintf(w->name, name_len, "%s", widget->name);
 
+	dapm->n_widgets++;
 	w->dapm = dapm;
 	w->codec = dapm->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-	list_add(&w->list, &dapm->widgets);
+	list_add(&w->list, &dapm->card->widgets);
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
@@ -2079,9 +2100,9 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list)
+	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
-		if (!w->sname)
+		if (!w->sname || w->dapm != dapm)
 			continue;
 		dev_dbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
 			w->name, w->sname, stream, event);
@@ -2164,7 +2185,9 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			dev_dbg(w->dapm->dev,
 				"dapm: force enable pin %s\n", pin);
@@ -2229,7 +2252,9 @@ int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin))
 			return w->connected;
 	}
@@ -2254,7 +2279,9 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			w->ignore_suspend = 1;
 			return 0;
@@ -2285,7 +2312,9 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 	LIST_HEAD(down_list);
 	int powerdown = 0;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
 			w->power = 0;
-- 
1.7.2.3
