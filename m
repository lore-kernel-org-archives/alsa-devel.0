From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2.1 1/3] ASoC: Move DAPM paths from DAPM
	context to snd_soc_card
Date: Tue, 14 Dec 2010 12:18:30 +0200
Message-ID: <1292321912-24765-2-git-send-email-jhnikula@gmail.com>
References: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id 5F41D245A2
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 11:17:33 +0100 (CET)
Received: by mail-ew0-f42.google.com with SMTP id 1so218436ewy.29
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 02:17:33 -0800 (PST)
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

Decoupling DAPM paths from DAPM context is a first prerequisite when
extending ASoC core to cross-device paths. This patch is almost a nullop and
does not allow to construct cross-device setup but the path clean-up part in
dapm_free_widgets is prepared to remove cross-device paths between a device
being removed and others.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h       |    1 -
 include/sound/soc.h            |    2 +
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/soc-core.c           |    2 +-
 sound/soc/soc-dapm.c           |   41 ++++++++++++++++++++++++++-------------
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 041e98b..9d1ff07 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -469,7 +469,6 @@ struct snd_soc_dapm_widget {
 /* DAPM context */
 struct snd_soc_dapm_context {
 	struct list_head widgets;
-	struct list_head paths;
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7e65b01..466895b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -661,6 +661,8 @@ struct snd_soc_card {
 	struct list_head platform_dev_list;
 	struct list_head dai_dev_list;
 
+	struct list_head paths;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
 	struct dentry *debugfs_pop_time;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index fc5abdf..899af41 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -185,7 +185,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
 		/* find dapm widget path assoc with kcontrol */
-		list_for_each_entry(path, &widget->dapm->paths, list) {
+		list_for_each_entry(path, &widget->dapm->card->paths, list) {
 			if (path->kcontrol != kcontrol)
 				continue;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1dc4b11..bdb2ca9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1879,6 +1879,7 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->dai_dev_list);
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->paths);
 
 	soc_init_card_debugfs(card);
 
@@ -3481,7 +3482,6 @@ int snd_soc_register_codec(struct device *dev,
 		codec->compress_type = SND_SOC_FLAT_COMPRESSION;
 
 	INIT_LIST_HEAD(&codec->dapm.widgets);
-	INIT_LIST_HEAD(&codec->dapm.paths);
 	codec->write = codec_drv->write;
 	codec->read = codec_drv->read;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b521a13..314238a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -269,7 +269,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 
 	for (i = 0; i < e->max; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &dapm->paths);
+			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = (char*)e->texts[i];
@@ -291,7 +291,7 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	/* search for mixer kcontrol */
 	for (i = 0; i < dest->num_kcontrols; i++) {
 		if (!strcmp(control_name, dest->kcontrols[i].name)) {
-			list_add(&path->list, &dapm->paths);
+			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = dest->kcontrols[i].name;
@@ -450,7 +450,7 @@ static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &dapm->paths, list)
+	list_for_each_entry(p, &dapm->card->paths, list)
 		p->walked = 0;
 }
 
@@ -1177,7 +1177,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->paths, list) {
+	list_for_each_entry(path, &widget->dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1211,7 +1211,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->paths, list) {
+	list_for_each_entry(path, &widget->dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1301,15 +1301,28 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 
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
 		kfree(w->name);
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
@@ -1416,7 +1429,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 
 	/* connect static paths */
 	if (control == NULL) {
-		list_add(&path->list, &dapm->paths);
+		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1437,7 +1450,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-		list_add(&path->list, &dapm->paths);
+		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1460,7 +1473,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
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
