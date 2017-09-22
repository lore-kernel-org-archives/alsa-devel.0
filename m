From: yesanishhere@gmail.com
Subject: [Resend] [PATCH v1 3/4] ASoC: dapm: Avoid creating
	kcontrol for params
Date: Fri, 22 Sep 2017 00:55:40 -0700
Message-ID: <1506066940-56758-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B7C326764C
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 09:55:51 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id i130so238260pgc.0
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 00:55:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ckeepax@opensource.cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: anish kumar <yesanishhere@gmail.com>

Currently in codec to codec dai link if there are multiple
params defined then dapm can use created kcontrol to
decide which param to apply at runtime.

However, in case there is only single param configuration
then there is no point in creating the kcontrol and also there
is no point in allocating memory for kcontrol.

In the snd_soc_dapm_new_pcm function, there is memory
allocation happening for kcontrol which is later used
or not used based on num_param. It is better to not
allocate memory when there is only a single configuration.
This change is to remedy that anomaly.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
Changes in v1:
  - Included the review comments from charles regarding
    releasing memory in error path.

 sound/soc/soc-dapm.c | 130 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 52 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d55cac6..e659c74 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3778,18 +3778,13 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-			 const struct snd_soc_pcm_stream *params,
-			 unsigned int num_params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
+static struct snd_kcontrol_new *
+snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
+			char *link_name,
+			const struct snd_soc_pcm_stream *params,
+			int num_params, const char **w_param_text,
+			unsigned long *private_value)
 {
-	struct snd_soc_dapm_widget template;
-	struct snd_soc_dapm_widget *w;
-	char *link_name;
-	int ret, count;
-	unsigned long private_value;
-	const char **w_param_text;
 	struct soc_enum w_param_enum[] = {
 		SOC_ENUM_SINGLE(0, 0, 0, NULL),
 	};
@@ -3798,19 +3793,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			     snd_soc_dapm_dai_link_get,
 			     snd_soc_dapm_dai_link_put),
 	};
+	struct snd_kcontrol_new *kcontrol_news;
 	const struct snd_soc_pcm_stream *config = params;
-
-	w_param_text = devm_kcalloc(card->dev, num_params,
-					sizeof(char *), GFP_KERNEL);
-	if (!w_param_text)
-		return -ENOMEM;
-
-	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
-				   source->name, sink->name);
-	if (!link_name) {
-		ret = -ENOMEM;
-		goto outfree_w_param;
-	}
+	int count;
 
 	for (count = 0 ; count < num_params; count++) {
 		if (!config->stream_name) {
@@ -3827,47 +3812,90 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 						strlen(config->stream_name) + 1,
 						GFP_KERNEL);
 		}
-		if (!w_param_text[count]) {
-			ret = -ENOMEM;
-			goto outfree_link_name;
-		}
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
-	private_value =
+	*private_value =
 		(unsigned long) devm_kmemdup(card->dev,
 			(void *)(kcontrol_dai_link[0].private_value),
 			sizeof(struct soc_enum), GFP_KERNEL);
-	if (!private_value) {
+	if (!*private_value) {
 		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
 			link_name);
-		ret = -ENOMEM;
-		goto outfree_link_name;
+		goto outfree_w_param;
 	}
-	kcontrol_dai_link[0].private_value = private_value;
+	kcontrol_dai_link[0].private_value = *private_value;
 	/* duplicate kcontrol_dai_link on heap so that memory persists */
-	template.kcontrol_news =
-				devm_kmemdup(card->dev, &kcontrol_dai_link[0],
-					sizeof(struct snd_kcontrol_new),
-					GFP_KERNEL);
-	if (!template.kcontrol_news) {
+	kcontrol_news =
+			devm_kmemdup(card->dev, &kcontrol_dai_link[0],
+				sizeof(struct snd_kcontrol_new),
+				GFP_KERNEL);
+	if (!kcontrol_news) {
 		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
 			link_name);
-		ret = -ENOMEM;
 		goto outfree_private_value;
 	}
+	return kcontrol_news;
+
+outfree_private_value:
+	devm_kfree(card->dev, (void *)*private_value);
+outfree_w_param:
+	for (count = 0 ; count < num_params; count++)
+		devm_kfree(card->dev, (void *)w_param_text[count]);
+	return NULL;
+}
 
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 const struct snd_soc_pcm_stream *params,
+			 unsigned int num_params,
+			 struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget template;
+	struct snd_soc_dapm_widget *w;
+	const char **w_param_text;
+	unsigned long private_value;
+	char *link_name;
+	int ret, count;
+
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
+	w_param_text = devm_kcalloc(card->dev, num_params,
+				sizeof(char *), GFP_KERNEL);
+	if (!w_param_text) {
+		ret = -ENOMEM;
+		goto param_fail;
+	}
+
+	/* allocate memory for control, only in case of multiple configs */
+	if (num_params > 1) {
+		template.num_kcontrols = 1;
+		template.kcontrol_news =
+					snd_soc_dapm_alloc_kcontrol(card,
+						link_name, params, num_params,
+						w_param_text, &private_value);
+		if (!template.kcontrol_news) {
+			ret = -ENOMEM;
+			goto outfree_link_name;
+		}
+	}
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
@@ -3899,15 +3927,13 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	devm_kfree(card->dev, w);
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
-outfree_private_value:
 	devm_kfree(card->dev, (void *)private_value);
-outfree_link_name:
-	devm_kfree(card->dev, link_name);
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
-outfree_w_param:
+outfree_link_name:
 	devm_kfree(card->dev, w_param_text);
-
+param_fail:
+	devm_kfree(card->dev, link_name);
 	return ret;
 }
 
-- 
2.5.4 (Apple Git-61)
