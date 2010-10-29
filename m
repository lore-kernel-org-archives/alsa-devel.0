From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_ii/iv 2/3] ASoC: Move widgets from DAPM context
	to snd_soc_card
Date: Fri, 29 Oct 2010 15:02:21 +0300
Message-ID: <1288353742-22005-2-git-send-email-jhnikula@gmail.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CA742440F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 14:01:21 +0200 (CEST)
Received: by eyg24 with SMTP id 24so1790696eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 05:01:21 -0700 (PDT)
In-Reply-To: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
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
a map for device B. An example below shows a path that connects MONO out of
A into Line In of B:

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
 sound/soc/soc-dapm.c      |   70 +++++++++++++++++++++++++++++++-------------
 5 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 29b6808..7f20804 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -465,7 +465,7 @@ struct snd_soc_dapm_widget {
 /* DAPM context */
 struct snd_soc_dapm_context {
 	u32 pop_time;
-	struct list_head widgets;
+	int n_widgets; /* number of widgets in this context */
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4e3f0e5..b752c52 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -590,6 +590,7 @@ struct snd_soc_card {
 	struct list_head platform_dev_list;
 	struct list_head dai_dev_list;
 
+	struct list_head widgets;
 	struct list_head paths;
 };
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 7c589f3..b25ed82 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -417,7 +417,9 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	 * list each time to find the desired power state do so now
 	 * and save the result.
 	 */
-	list_for_each_entry(w, &codec->dapm->widgets, list) {
+	list_for_each_entry(w, &codec->card->widgets, list) {
+		if (w->dapm != codec->dapm)
+			continue;
 		if (strcmp(w->name, "LOUT1 PGA") == 0)
 			wm8960->lout1 = w;
 		if (strcmp(w->name, "ROUT1 PGA") == 0)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 010728a..571de78 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1663,6 +1663,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->dai_dev_list);
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 
 	ret = snd_soc_register_card(card);
@@ -2965,7 +2966,6 @@ static struct snd_soc_dapm_context *soc_new_dapm_context(struct device *dev)
 
 	dapm = kzalloc(sizeof(struct snd_soc_dapm_context), GFP_KERNEL);
 	if (dapm) {
-		INIT_LIST_HEAD(&dapm->widgets);
 		dapm->bias_level = SND_SOC_BIAS_OFF;
 		dapm->dev = dev;
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 62d3e0c..fc1b943 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -906,7 +906,9 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
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
@@ -942,7 +944,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
 	 */
-	if (list_empty(&dapm->widgets)) {
+	if (!dapm->n_widgets) {
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
@@ -1098,8 +1100,8 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 	if (!dapm->debugfs_dapm)
 		return;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
-		if (!w->name)
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!w->name || w->dapm != dapm)
 			continue;
 
 		d = debugfs_create_file(w->name, 0444,
@@ -1194,8 +1196,9 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->dapm->widgets, list) {
-
+	list_for_each_entry(w, &codec->card->widgets, list) {
+		if (w->dapm != codec->dapm)
+			continue;
 		/* only display widgets that burnm power */
 		switch (w->id) {
 		case snd_soc_dapm_hp:
@@ -1255,7 +1258,9 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 	struct snd_soc_dapm_widget *w, *next_w;
 	struct snd_soc_dapm_path *p, *next_p;
 
-	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
+	list_for_each_entry_safe(w, next_w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		list_del(&w->list);
 		/*
 		 * remove source and sink paths associated to this widget.
@@ -1285,7 +1290,9 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = status;
@@ -1321,22 +1328,34 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
+	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
 	const char *sink = route->sink;
 	const char *control = route->control;
 	const char *source = route->source;
 	int ret = 0;
 
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
@@ -1474,7 +1493,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list)
+	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -1958,12 +1977,13 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
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
@@ -2006,9 +2026,9 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list)
+	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
-		if (!w->sname)
+		if (!w->sname || w->dapm != dapm)
 			continue;
 		pr_debug("widget %s\n %s stream %s event %d\n",
 			 w->name, w->sname, stream, event);
@@ -2090,7 +2110,9 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm, const char
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = 1;
@@ -2153,7 +2175,9 @@ int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm, const char *p
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &dapm->widgets, list) {
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
 		if (!strcmp(w->name, pin))
 			return w->connected;
 	}
@@ -2177,7 +2201,9 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm->widgets, list) {
+	list_for_each_entry(w, &codec->card->widgets, list) {
+		if (w->dapm != codec->dapm)
+			continue;
 		if (!strcmp(w->name, pin)) {
 			w->ignore_suspend = 1;
 			return 0;
@@ -2208,7 +2234,9 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
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
