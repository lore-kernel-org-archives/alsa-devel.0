From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Move DAPM widget debugfs entry
	creation to snd_soc_dapm_new_widgets
Date: Sat, 30 Apr 2011 19:45:49 +0200
Message-ID: <1304185550-12003-3-git-send-email-lars@metafoo.de>
References: <1304185550-12003-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-171.synserver.de
	[212.40.185.171]) by alsa0.perex.cz (Postfix) with SMTP id 14818244F0
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 19:46:09 +0200 (CEST)
In-Reply-To: <1304185550-12003-1-git-send-email-lars@metafoo.de>
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

Currently debugfs entries for a DAPM widgets are only added in
snd_soc_dapm_debugfs_init. If a widget is added later (for example in the
dai_link's probe callback) it will not show up in debugfs.
This patch moves the creation of the widget debugfs entry to
snd_soc_dapm_new_widgets where it will be added after the widget has been
properly instantiated.

As a side-effect this will also reduce the number of times the DAPM widget list
is iterated during a card's instantiation.

Since it is possible that snd_soc_dapm_new_widgets is invoked form the codecs or
cards probe callbacks, the creation of the debugfs dapm directory has to be
moved before these are called.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |   13 +++++++------
 sound/soc/soc-dapm.c |   35 +++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 983ec64..fbd011eb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1493,6 +1493,8 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
 
+	soc_init_codec_debugfs(codec);
+
 	if (driver->probe) {
 		ret = driver->probe(codec);
 		if (ret < 0) {
@@ -1513,8 +1515,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
 					driver->num_dapm_routes);
 
-	soc_init_codec_debugfs(codec);
-
 	/* mark codec as probed and add to card codec list */
 	codec->probed = 1;
 	list_add(&codec->card_list, &card->codec_dev_list);
@@ -1523,6 +1523,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	return 0;
 
 err_probe:
+	soc_cleanup_codec_debugfs(codec);
 	module_put(codec->dev->driver->owner);
 
 	return ret;
@@ -1873,6 +1874,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	card->dapm.card = card;
 	list_add(&card->dapm.list, &card->dapm_list);
 
+#ifdef CONFIG_DEBUG_FS
+	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 	/* deferred resume work */
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
@@ -1919,10 +1924,6 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
 
-#ifdef CONFIG_DEBUG_FS
-	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
-#endif
-
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ffed456..8454cc2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1257,7 +1257,6 @@ static const struct file_operations dapm_bias_fops = {
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
-	struct snd_soc_dapm_widget *w;
 	struct dentry *d;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
@@ -1274,25 +1273,35 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	if (!d)
 		dev_warn(dapm->dev,
 			 "ASoC: Failed to create bias level debugfs file\n");
+}
 
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (!w->name || w->dapm != dapm)
-			continue;
+static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct dentry *d;
 
-		d = debugfs_create_file(w->name, 0444,
-					dapm->debugfs_dapm, w,
-					&dapm_widget_power_fops);
-		if (!d)
-			dev_warn(w->dapm->dev,
-				"ASoC: Failed to create %s debugfs file\n",
-				w->name);
-	}
+	if (!dapm->debugfs_dapm || !w->name)
+		return;
+
+	d = debugfs_create_file(w->name, 0444,
+				dapm->debugfs_dapm, w,
+				&dapm_widget_power_fops);
+	if (!d)
+		dev_warn(w->dapm->dev,
+			"ASoC: Failed to create %s debugfs file\n",
+			w->name);
 }
+
 #else
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
 }
+
+static inline void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
+{
+}
+
 #endif
 
 /* test and update the power status of a mux widget */
@@ -1765,6 +1774,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		}
 
 		w->new = 1;
+
+		dapm_debugfs_add_widget(w);
 	}
 
 	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
-- 
1.7.2.5
