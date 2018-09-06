From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Move connection of CODEC to CODEC
	DAIs" to the asoc tree
Date: Thu,  6 Sep 2018 11:48:55 +0100 (BST)
Message-ID: <20180906104855.A81101122A1F@debutante.sirena.org.uk>
References: <20180905142102.29070-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B3D267822
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:48:56 +0200 (CEST)
In-Reply-To: <20180905142102.29070-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Move connection of CODEC to CODEC DAIs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 778ff5bb8689eb4fd05a72a409e32a3a34e23faf Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 5 Sep 2018 15:21:00 +0100
Subject: [PATCH] ASoC: dapm: Move connection of CODEC to CODEC DAIs

Currently, snd_soc_dapm_connect_dai_link_widgets connects up the routes
representing normal DAIs, however CODEC to CODEC links are hooked up
through separate infrastructure in soc_link_dai_widgets. Improve the
consistency of the code by using snd_soc_dapm_connect_dai_link for both
types of DAIs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h |   6 ---
 sound/soc/soc-core.c     |  47 ------------------
 sound/soc/soc-dapm.c     | 103 +++++++++++++++++++++++++--------------
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
index 390da15c4a8b..4e9367aacc0c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1463,48 +1463,6 @@ static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
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
@@ -1606,11 +1564,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
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
index c111e69b9a09..bbfcb7fc05cc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3860,12 +3860,10 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
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
@@ -3877,7 +3875,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
 				   source->name, sink->name);
 	if (!link_name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	memset(&template, 0, sizeof(template));
 	template.reg = SND_SOC_NOPM;
@@ -3889,9 +3887,10 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
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
@@ -3900,7 +3899,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
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
@@ -3915,23 +3916,19 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
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
@@ -4041,33 +4038,65 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
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
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
 
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
@@ -4122,7 +4151,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 		 * dynamic FE links have no fixed DAI mapping.
 		 * CODEC<->CODEC links have no direct connection.
 		 */
-		if (rtd->dai_link->dynamic || rtd->dai_link->params)
+		if (rtd->dai_link->dynamic)
 			continue;
 
 		dapm_connect_dai_link_widgets(card, rtd);
-- 
2.19.0.rc1
