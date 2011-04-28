From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: Move DAPM widget debugfs entry
	creation to snd_soc_dapm_new_widgets
Date: Thu, 28 Apr 2011 18:46:12 +0200
Message-ID: <1304009173-5786-6-git-send-email-lars@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id 7767D1039B8
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:30 +0200 (CEST)
In-Reply-To: <1304009173-5786-1-git-send-email-lars@metafoo.de>
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
Note that the card's dapm debugfs entry is not removed in the error path of
snd_soc_instantiate_card, but it hasn't been before either. I'll try to address
this along with some other leaks in snd_soc_instantiate_card in a follow up
patch.
---
 sound/soc/soc-core.c |    9 +++++----
 sound/soc/soc-dapm.c |   35 +++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aa21fbc..c30fa9d 100644
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
@@ -1873,6 +1874,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	card->dapm.card = card;
 	list_add(&card->dapm.list, &card->dapm_list);
 
+	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
+
 #ifdef CONFIG_PM_SLEEP
 	/* deferred resume work */
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
@@ -1919,8 +1922,6 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
 
-	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
-
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7c6298b..e3c5d36 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1231,7 +1231,6 @@ static const struct file_operations dapm_bias_fops = {
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
-	struct snd_soc_dapm_widget *w;
 	struct dentry *d;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
@@ -1248,24 +1247,34 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
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
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 }
+
+static inline void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
+{
+}
+
 #endif
 
 /* test and update the power status of a mux widget */
@@ -1742,6 +1751,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		}
 
 		w->new = 1;
+
+		dapm_debugfs_add_widget(w);
 	}
 
 	dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP, NULL);
-- 
1.7.2.5
