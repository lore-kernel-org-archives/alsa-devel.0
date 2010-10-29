From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_ii/iv 1/3] ASoC: Move DAPM paths from DAPM
	context to snd_soc_card
Date: Fri, 29 Oct 2010 15:02:20 +0300
Message-ID: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 82DC7243FE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 14:01:14 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1625112ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 05:01:14 -0700 (PDT)
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

Decoupling DAPM paths from DAPM context is a first prerequisite when
extending ASoC core to cross-device paths. This patch is almost a nullop and
does not allow to construct cross-device setup but the path clean-up part in
dapm_free_widgets is prepared to remove cross-device paths between a device
being removed and others.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h       |    2 +-
 include/sound/soc.h            |    2 +
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/soc-core.c           |    3 +-
 sound/soc/soc-dapm.c           |   41 ++++++++++++++++++++++++++-------------
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c6dd14a..29b6808 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -466,7 +466,6 @@ struct snd_soc_dapm_widget {
 struct snd_soc_dapm_context {
 	u32 pop_time;
 	struct list_head widgets;
-	struct list_head paths;
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
@@ -474,6 +473,7 @@ struct snd_soc_dapm_context {
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
+	struct snd_soc_card *card; /* parent card */
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4bbd65f..4e3f0e5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -589,6 +589,8 @@ struct snd_soc_card {
 	struct list_head codec_dev_list;
 	struct list_head platform_dev_list;
 	struct list_head dai_dev_list;
+
+	struct list_head paths;
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d007e05..25b2517 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -183,7 +183,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
 		/* find dapm widget path assoc with kcontrol */
-		list_for_each_entry(path, &widget->dapm->paths, list) {
+		list_for_each_entry(path, &widget->dapm->card->paths, list) {
 			if (path->kcontrol != kcontrol)
 				continue;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3c1c2ac..010728a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1406,6 +1406,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the CODEC */
 	if (!codec->probed) {
+		codec->dapm->card = card;
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1662,6 +1663,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->dai_dev_list);
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->paths);
 
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
@@ -2964,7 +2966,6 @@ static struct snd_soc_dapm_context *soc_new_dapm_context(struct device *dev)
 	dapm = kzalloc(sizeof(struct snd_soc_dapm_context), GFP_KERNEL);
 	if (dapm) {
 		INIT_LIST_HEAD(&dapm->widgets);
-		INIT_LIST_HEAD(&dapm->paths);
 		dapm->bias_level = SND_SOC_BIAS_OFF;
 		dapm->dev = dev;
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cee0c96..62d3e0c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -251,7 +251,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 
 	for (i = 0; i < e->max; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &dapm->paths);
+			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = (char*)e->texts[i];
@@ -273,7 +273,7 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	/* search for mixer kcontrol */
 	for (i = 0; i < dest->num_kcontrols; i++) {
 		if (!strcmp(control_name, dest->kcontrols[i].name)) {
-			list_add(&path->list, &dapm->paths);
+			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = dest->kcontrols[i].name;
@@ -429,7 +429,7 @@ static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &dapm->paths, list)
+	list_for_each_entry(p, &dapm->card->paths, list)
 		p->walked = 0;
 }
 
@@ -1133,7 +1133,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->paths, list) {
+	list_for_each_entry(path, &widget->dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1167,7 +1167,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->paths, list) {
+	list_for_each_entry(path, &widget->dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1257,14 +1257,27 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 
 	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
 		list_del(&w->list);
+		/*
+		 * remove source and sink paths associated to this widget.
+		 * While removing the path, remove reference to it from both
+		 * source and sink widgets so that path is removed only once.
+		 */
+		list_for_each_entry_safe(p, next_p, &w->sources, list_sink) {
+			list_del(&p->list_sink);
+			list_del(&p->list_source);
+			list_del(&p->list);
+			kfree(p->long_name);
+			kfree(p);
+		}
+		list_for_each_entry_safe(p, next_p, &w->sinks, list_source) {
+			list_del(&p->list_sink);
+			list_del(&p->list_source);
+			list_del(&p->list);
+			kfree(p->long_name);
+			kfree(p);
+		}
 		kfree(w);
 	}
-
-	list_for_each_entry_safe(p, next_p, &dapm->paths, list) {
-		list_del(&p->list);
-		kfree(p->long_name);
-		kfree(p);
-	}
 }
 
 static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
@@ -1357,7 +1370,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 
 	/* connect static paths */
 	if (control == NULL) {
-		list_add(&path->list, &dapm->paths);
+		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1378,7 +1391,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-		list_add(&path->list, &dapm->paths);
+		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1401,7 +1414,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_spk:
-		list_add(&path->list, &dapm->paths);
+		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 0;
-- 
1.7.2.3
