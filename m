From: yesanishhere@gmail.com
Subject: [PATCH] ASoC: dapm: Avoid creating kcontrol for params
Date: Fri, 18 Aug 2017 23:39:04 -0700
Message-ID: <1503124744-13547-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6A1266A74
 for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2017 08:39:09 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id i12so2456531pgr.1
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 23:39:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: anish kumar <yesanishhere@gmail.com>

When num_params is defined as one in case of
codec to codec dai link, there is no point in
allocating memory for kcontrol.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 include/sound/soc-dapm.h |   1 -
 sound/soc/soc-dapm.c     | 147 ++++++++++++++++++++++++-----------------------
 2 files changed, 76 insertions(+), 72 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 344b96c..dc5c336 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -582,7 +582,6 @@ struct snd_soc_dapm_widget {
 	void *priv;				/* widget specific data */
 	struct regulator *regulator;		/* attached regulator */
 	const struct snd_soc_pcm_stream *params; /* params for dai links */
-	unsigned int num_params; /* number of params for dai links */
 	unsigned int params_select; /* currently selected param for dai link */
 
 	/* dapm control */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..0a26905 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1032,10 +1032,6 @@ static int dapm_new_dai_link(struct snd_soc_dapm_widget *w)
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_card *card = dapm->card->snd_card;
 
-	/* create control for links with > 1 config */
-	if (w->num_params <= 1)
-		return 0;
-
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
@@ -3770,108 +3766,125 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0] == w->params_select)
 		return 0;
 
-	if (ucontrol->value.enumerated.item[0] >= w->num_params)
-		return -EINVAL;
-
 	w->params_select = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
 
-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-			 const struct snd_soc_pcm_stream *params,
-			 unsigned int num_params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
+struct snd_kcontrol_new *snd_soc_dapm_new_kcontrol(struct snd_soc_card *card,
+		char *link_name,
+		const struct snd_soc_pcm_stream *params,
+		int num_params)
 {
-	struct snd_soc_dapm_widget template;
-	struct snd_soc_dapm_widget *w;
-	char *link_name;
-	int ret, count;
-	unsigned long private_value;
 	const char **w_param_text;
+	int count;
+	unsigned long private_value;
 	struct soc_enum w_param_enum[] = {
 		SOC_ENUM_SINGLE(0, 0, 0, NULL),
 	};
 	struct snd_kcontrol_new kcontrol_dai_link[] = {
 		SOC_ENUM_EXT(NULL, w_param_enum[0],
-			     snd_soc_dapm_dai_link_get,
-			     snd_soc_dapm_dai_link_put),
+				snd_soc_dapm_dai_link_get,
+				snd_soc_dapm_dai_link_put),
 	};
+	struct snd_kcontrol_new *kcontrol_news = NULL;
 	const struct snd_soc_pcm_stream *config = params;
 
 	w_param_text = devm_kcalloc(card->dev, num_params,
 					sizeof(char *), GFP_KERNEL);
 	if (!w_param_text)
-		return -ENOMEM;
-
-	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
-				   source->name, sink->name);
-	if (!link_name) {
-		ret = -ENOMEM;
-		goto outfree_w_param;
-	}
+		return NULL;
 
 	for (count = 0 ; count < num_params; count++) {
 		if (!config->stream_name) {
 			dev_warn(card->dapm.dev,
-				"ASoC: anonymous config %d for dai link %s\n",
-				count, link_name);
+					"ASoC: anonymous config %d for dai link %s\n",
+					count, link_name);
 			w_param_text[count] =
 				devm_kasprintf(card->dev, GFP_KERNEL,
-					       "Anonymous Configuration %d",
-					       count);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
+						"Anonymous Configuration %d",
+						count);
 		} else {
 			w_param_text[count] = devm_kmemdup(card->dev,
-						config->stream_name,
-						strlen(config->stream_name) + 1,
-						GFP_KERNEL);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
+					config->stream_name,
+					strlen(config->stream_name) + 1,
+					GFP_KERNEL);
 		}
+		if (!w_param_text[count])
+			goto outfree_w_param;
 		config++;
 	}
+
 	w_param_enum[0].items = num_params;
 	w_param_enum[0].texts = w_param_text;
 
-	memset(&template, 0, sizeof(template));
-	template.reg = SND_SOC_NOPM;
-	template.id = snd_soc_dapm_dai_link;
-	template.name = link_name;
-	template.event = snd_soc_dai_link_event;
-	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_PRE_PMD;
-	template.num_kcontrols = 1;
-	/* duplicate w_param_enum on heap so that memory persists */
 	private_value =
 		(unsigned long) devm_kmemdup(card->dev,
-			(void *)(kcontrol_dai_link[0].private_value),
-			sizeof(struct soc_enum), GFP_KERNEL);
+				(void *)(kcontrol_dai_link[0].private_value),
+				sizeof(struct soc_enum), GFP_KERNEL);
 	if (!private_value) {
 		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
-			link_name);
-		ret = -ENOMEM;
-		goto outfree_link_name;
+				link_name);
+		goto outfree_w_param;
 	}
 	kcontrol_dai_link[0].private_value = private_value;
 	/* duplicate kcontrol_dai_link on heap so that memory persists */
-	template.kcontrol_news =
-				devm_kmemdup(card->dev, &kcontrol_dai_link[0],
-					sizeof(struct snd_kcontrol_new),
-					GFP_KERNEL);
-	if (!template.kcontrol_news) {
+	kcontrol_news =
+		devm_kmemdup(card->dev, &kcontrol_dai_link[0],
+				sizeof(struct snd_kcontrol_new),
+				GFP_KERNEL);
+	if (!kcontrol_news) {
 		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
-			link_name);
-		ret = -ENOMEM;
+				link_name);
 		goto outfree_private_value;
 	}
+	return kcontrol_news;
+
+outfree_private_value:
+	devm_kfree(card->dev, (void *)private_value);
+outfree_w_param:
+	for (count = 0 ; count < num_params; count++)
+		if (w_param_text[count] != NULL)
+			devm_kfree(card->dev, (void *)w_param_text[count]);
+	devm_kfree(card->dev, w_param_text);
+	return NULL;
+}
+
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 const struct snd_soc_pcm_stream *params,
+			 unsigned int num_params,
+			 struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget template;
+	struct snd_soc_dapm_widget *w;
+	char *link_name;
+	int ret;
 
+	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
+				   source->name, sink->name);
+	if (!link_name)
+		return -ENOMEM;
+
+	memset(&template, 0, sizeof(template));
+	template.reg = SND_SOC_NOPM;
+	template.id = snd_soc_dapm_dai_link;
+	template.name = link_name;
+	template.event = snd_soc_dai_link_event;
+	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_PRE_PMD;
+	template.kcontrol_news = NULL;
+
+	/* allocate memory for control, only in case of multiple configs */
+	if (num_params > 1) {
+		template.num_kcontrols = 1;
+		template.kcontrol_news =
+			snd_soc_dapm_new_kcontrol(card, link_name, params, num_params);
+		if (!template.kcontrol_news) {
+			ret = -ENOMEM;
+			goto outfree_link_name;
+		}
+	}
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
@@ -3892,7 +3905,6 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	}
 
 	w->params = params;
-	w->num_params = num_params;
 
 	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
 	if (ret)
@@ -3903,15 +3915,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	devm_kfree(card->dev, w);
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
-outfree_private_value:
-	devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
 	devm_kfree(card->dev, link_name);
-outfree_w_param:
-	for (count = 0 ; count < num_params; count++)
-		devm_kfree(card->dev, (void *)w_param_text[count]);
-	devm_kfree(card->dev, w_param_text);
-
 	return ret;
 }
 
-- 
2.5.4 (Apple Git-61)
