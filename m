From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/4] ASoC: firmware core: Add core support for
	dynamic kcontrols and widgets.
Date: Mon, 19 Nov 2012 18:12:44 +0000
Message-ID: <1353348765-6238-3-git-send-email-lrg@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C152126173D
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:13:01 +0100 (CET)
In-Reply-To: <1353348765-6238-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add support to the ASoC and DAPM core to allow firmware based runtime
generated kcontrols and widgets to be used along side standard ones.
Each widget/component maintains a list of mixer/enum kcontrols that
can be removed when required.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    2 ++
 include/sound/soc.h      |   21 +++++++++++++++++++++
 sound/soc/soc-core.c     |   12 ++++++++++--
 sound/soc/soc-dapm.c     |   14 +++++++-------
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c6c9dad..0b1b86a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -584,6 +584,8 @@ struct snd_soc_dapm_widget {
 	int num_kcontrols;
 	const struct snd_kcontrol_new *kcontrol_news;
 	struct snd_kcontrol **kcontrols;
+	int denum;
+	int dmixer;
 
 	/* widget input and outputs */
 	struct list_head sources;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index b0b1703..bcc2a95 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -803,6 +803,10 @@ struct snd_soc_codec {
 	struct snd_soc_dapm_context dapm;
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 
+	/* dynamic mixer and enum controls */
+	struct list_head dmixers;
+	struct list_head denums;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
@@ -927,6 +931,10 @@ struct snd_soc_platform {
 	struct list_head list;
 	struct list_head card_list;
 
+	/* dynamic mixer and enum controls */
+	struct list_head dmixers;
+	struct list_head denums;
+
 	struct snd_soc_dapm_context dapm;
 
 #ifdef CONFIG_DEBUG_FS
@@ -1107,6 +1115,10 @@ struct snd_soc_card {
 	struct list_head dapm_list;
 	struct list_head dapm_dirty;
 
+	/* dynamic mixer and enum controls */
+	struct list_head dmixers;
+	struct list_head denums;
+
 	/* Generic DAPM context for the card */
 	struct snd_soc_dapm_context dapm;
 	struct snd_soc_dapm_stats dapm_stats;
@@ -1155,6 +1167,10 @@ struct snd_soc_pcm_runtime {
 struct soc_mixer_control {
 	int min, max, platform_max;
 	unsigned int reg, rreg, shift, rshift, invert;
+
+	/* dynamic controls */
+	struct list_head list;
+	struct snd_kcontrol *dcontrol;
 };
 
 struct soc_bytes {
@@ -1179,6 +1195,11 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
+	 /* dynamic enum controls */
+	char **dtexts;
+	unsigned int *dvalues;
+	struct list_head list;
+	struct snd_kcontrol *dcontrol;
 	void *dapm;
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cee37ee..1f448ab 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2404,7 +2404,8 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item > e->max - 1)
 		uinfo->value.enumerated.item = e->max - 1;
 	strcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item]);
+		snd_soc_get_enum_text(e, uinfo->value.enumerated.item));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
@@ -2564,7 +2565,7 @@ int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item > e->max - 1)
 		uinfo->value.enumerated.item = e->max - 1;
 	strcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item]);
+		snd_soc_get_enum_text(e, uinfo->value.enumerated.item));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_enum_ext);
@@ -3600,6 +3601,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (card->rtd == NULL)
 		return -ENOMEM;
 	card->num_rtd = 0;
+
 	card->rtd_aux = &card->rtd[card->num_links];
 
 	for (i = 0; i < card->num_links; i++)
@@ -3607,6 +3609,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	INIT_LIST_HEAD(&card->list);
 	INIT_LIST_HEAD(&card->dapm_dirty);
+	INIT_LIST_HEAD(&card->denums);
+	INIT_LIST_HEAD(&card->dmixers);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
@@ -3890,6 +3894,8 @@ int snd_soc_register_platform(struct device *dev,
 	platform->dapm.platform = platform;
 	platform->dapm.stream_event = platform_drv->stream_event;
 	mutex_init(&platform->mutex);
+	INIT_LIST_HEAD(&platform->denums);
+	INIT_LIST_HEAD(&platform->dmixers);
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
@@ -4007,6 +4013,8 @@ int snd_soc_register_codec(struct device *dev,
 	codec->driver = codec_drv;
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->denums);
+	INIT_LIST_HEAD(&codec->dmixers);
 
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1e36bc8..f456378 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -365,7 +365,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 
 		p->connect = 0;
 		for (i = 0; i < e->max; i++) {
-			if (!(strcmp(p->name, e->texts[i])) && item == i)
+			if (!(strcmp(p->name, snd_soc_get_enum_text(e, i))) && item == i)
 				p->connect = 1;
 		}
 	}
@@ -381,7 +381,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		 * that the default mux choice (the first) will be
 		 * correctly powered up during initialization.
 		 */
-		if (!strcmp(p->name, e->texts[0]))
+		if (!strcmp(p->name, snd_soc_get_enum_text(e, 0)))
 			p->connect = 1;
 	}
 	break;
@@ -399,7 +399,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 
 		p->connect = 0;
 		for (i = 0; i < e->max; i++) {
-			if (!(strcmp(p->name, e->texts[i])) && item == i)
+			if (!(strcmp(p->name, snd_soc_get_enum_text(e, i))) && item == i)
 				p->connect = 1;
 		}
 	}
@@ -445,11 +445,11 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	int i;
 
 	for (i = 0; i < e->max; i++) {
-		if (!(strcmp(control_name, e->texts[i]))) {
+		if (!(strcmp(control_name, snd_soc_get_enum_text(e, i)))) {
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
-			path->name = (char*)e->texts[i];
+			path->name = (char*)snd_soc_get_enum_text(e, i);
 			dapm_set_path_status(dest, path, 0);
 			return 0;
 		}
@@ -1909,12 +1909,12 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		if (path->kcontrol != kcontrol)
 			continue;
 
-		if (!path->name || !e->texts[mux])
+		if (!path->name || !snd_soc_get_enum_text(e, mux))
 			continue;
 
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux]))) {
+		if (!(strcmp(path->name, snd_soc_get_enum_text(e, mux)))) {
 			path->connect = 1; /* new connection */
 			dapm_mark_dirty(path->source, "mux connection");
 		} else {
-- 
1.7.10.4
