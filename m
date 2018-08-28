From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 5/7] ASoC: dapm: Move connection of CODEC to
	CODEC DAIs
Date: Tue, 28 Aug 2018 14:35:06 +0100
Message-ID: <20180828133508.13012-5-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 893122678BB
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently, snd_soc_dapm_connect_dai_link_widgets connects up the routes
representing normal DAIs, however CODEC to CODEC links are hooked up
through separate infrastructure in soc_link_dai_widgets. Improve the
consistency of the code by using snd_soc_dapm_connect_dai_link for both
types of DAIs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-dapm.h |   6 ---
 sound/soc/soc-core.c     |  47 ---------------------
 sound/soc/soc-dapm.c     | 103 ++++++++++++++++++++++++++++++-----------------
 3 files changed, 66 insertions(+), 90 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index fdaaafdc7a00..cb177fa21ce7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -406,12 +406,6 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-			 struct snd_soc_pcm_runtime *rtd,
-			 const struct snd_soc_pcm_stream *params,
-			 unsigned int num_params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 473eefe8658e..4c808373c9d4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1431,48 +1431,6 @@ static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 	return 0;
 }
 
-static int soc_link_dai_widgets(struct snd_soc_card *card,
-				struct snd_soc_dai_link *dai_link,
-				struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dapm_widget *sink, *source;
-	int ret;
-
-	if (rtd->num_codecs > 1)
-		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
-
-	/* link the DAI widgets */
-	sink = codec_dai->playback_widget;
-	source = cpu_dai->capture_widget;
-	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
-					   dai_link->num_params,
-					   source, sink);
-		if (ret != 0) {
-			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				sink->name, source->name, ret);
-			return ret;
-		}
-	}
-
-	sink = cpu_dai->playback_widget;
-	source = codec_dai->capture_widget;
-	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
-					   dai_link->num_params,
-					   source, sink);
-		if (ret != 0) {
-			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				sink->name, source->name, ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int soc_probe_link_dais(struct snd_soc_card *card,
 		struct snd_soc_pcm_runtime *rtd, int order)
 {
@@ -1573,11 +1531,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		} else {
 			INIT_DELAYED_WORK(&rtd->delayed_work,
 						codec2codec_close_delayed_work);
-
-			/* link the DAI widgets */
-			ret = soc_link_dai_widgets(card, dai_link, rtd);
-			if (ret)
-				return ret;
 		}
 	}
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1e4926b6bcc3..b3ed5c870baf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3859,12 +3859,10 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 	return NULL;
 }
 
-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-			 struct snd_soc_pcm_runtime *rtd,
-			 const struct snd_soc_pcm_stream *params,
-			 unsigned int num_params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
+static struct snd_soc_dapm_widget *
+snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
+		     struct snd_soc_dapm_widget *source,
+		     struct snd_soc_dapm_widget *sink)
 {
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
@@ -3876,7 +3874,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
 				   source->name, sink->name);
 	if (!link_name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	memset(&template, 0, sizeof(template));
 	template.reg = SND_SOC_NOPM;
@@ -3888,9 +3886,10 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	template.kcontrol_news = NULL;
 
 	/* allocate memory for control, only in case of multiple configs */
-	if (num_params > 1) {
-		w_param_text = devm_kcalloc(card->dev, num_params,
-					sizeof(char *), GFP_KERNEL);
+	if (rtd->dai_link->num_params > 1) {
+		w_param_text = devm_kcalloc(card->dev,
+					    rtd->dai_link->num_params,
+					    sizeof(char *), GFP_KERNEL);
 		if (!w_param_text) {
 			ret = -ENOMEM;
 			goto param_fail;
@@ -3899,7 +3898,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 		template.num_kcontrols = 1;
 		template.kcontrol_news =
 					snd_soc_dapm_alloc_kcontrol(card,
-						link_name, params, num_params,
+						link_name,
+						rtd->dai_link->params,
+						rtd->dai_link->num_params,
 						w_param_text, &private_value);
 		if (!template.kcontrol_news) {
 			ret = -ENOMEM;
@@ -3914,23 +3915,19 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	if (IS_ERR(w))
 		goto outfree_kcontrol_news;
 
-	w->params = params;
-	w->num_params = num_params;
+	w->params = rtd->dai_link->params;
+	w->num_params = rtd->dai_link->num_params;
 	w->priv = rtd;
 
-	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
-	if (ret)
-		goto outfree_w;
-	return snd_soc_dapm_add_path(&card->dapm, w, sink, NULL, NULL);
+	return w;
 
-outfree_w:
-	devm_kfree(card->dev, w);
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
-	snd_soc_dapm_free_kcontrol(card, &private_value, num_params, w_param_text);
+	snd_soc_dapm_free_kcontrol(card, &private_value,
+				   rtd->dai_link->num_params, w_param_text);
 param_fail:
 	devm_kfree(card->dev, link_name);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
@@ -4039,34 +4036,66 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 					  struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dapm_widget *sink, *source;
+	struct snd_soc_dapm_widget *playback = NULL, *capture = NULL;
+	struct snd_soc_dapm_widget *codec, *playback_cpu, *capture_cpu;
 	int i;
 
+	if (rtd->dai_link->params) {
+		if (rtd->num_codecs > 1)
+			dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
+
+		playback_cpu = cpu_dai->capture_widget;
+		capture_cpu = cpu_dai->playback_widget;
+	} else {
+		playback = cpu_dai->playback_widget;
+		capture = cpu_dai->capture_widget;
+		playback_cpu = playback;
+		capture_cpu = capture;
+	}
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
 		/* connect BE DAI playback if widgets are valid */
-		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
-			source = cpu_dai->playback_widget;
-			sink = codec_dai->playback_widget;
+		codec = codec_dai->playback_widget;
+
+		if (playback_cpu && codec) {
+			if (!playback) {
+				playback = snd_soc_dapm_new_dai(card, rtd,
+								playback_cpu,
+								codec);
+
+				snd_soc_dapm_add_path(&card->dapm, playback_cpu,
+						      playback, NULL, NULL);
+			}
+
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				cpu_dai->component->name, source->name,
-				codec_dai->component->name, sink->name);
+				cpu_dai->component->name, playback_cpu->name,
+				codec_dai->component->name, codec->name);
 
-			snd_soc_dapm_add_path(&card->dapm, source, sink,
-				NULL, NULL);
+			snd_soc_dapm_add_path(&card->dapm, playback, codec,
+					      NULL, NULL);
 		}
 
 		/* connect BE DAI capture if widgets are valid */
-		if (codec_dai->capture_widget && cpu_dai->capture_widget) {
-			source = codec_dai->capture_widget;
-			sink = cpu_dai->capture_widget;
+		codec = codec_dai->capture_widget;
+
+		if (codec && capture_cpu) {
+			if (!capture) {
+				capture = snd_soc_dapm_new_dai(card, rtd,
+							       codec,
+							       capture_cpu);
+
+				snd_soc_dapm_add_path(&card->dapm, capture,
+						      capture_cpu, NULL, NULL);
+			}
+
 			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				codec_dai->component->name, source->name,
-				cpu_dai->component->name, sink->name);
+				codec_dai->component->name, codec->name,
+				cpu_dai->component->name, capture_cpu->name);
 
-			snd_soc_dapm_add_path(&card->dapm, source, sink,
-				NULL, NULL);
+			snd_soc_dapm_add_path(&card->dapm, codec, capture,
+					      NULL, NULL);
 		}
 	}
 }
@@ -4121,7 +4150,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 		 * dynamic FE links have no fixed DAI mapping.
 		 * CODEC<->CODEC links have no direct connection.
 		 */
-		if (rtd->dai_link->dynamic || rtd->dai_link->params)
+		if (rtd->dai_link->dynamic)
 			continue;
 
 		dapm_connect_dai_link_widgets(card, rtd);
-- 
2.11.0
