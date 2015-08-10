From: mengdong.lin@intel.com
Subject: [RFC PATCH 02/10] ASoC: Define soc_init_dai_link() to
	wrap link intialization.
Date: Mon, 10 Aug 2015 14:12:52 +0800
Message-ID: <1439187172-1018-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA8326530B
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 07:59:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Define soc_init_dai_link() to wrap link initialization, to reuse it later
by snd_soc_instantiate_card() when adding new DAI links from topology in
component probing phase.

Move static func snd_soc_init_multicodec(), so that it can be reused by
soc_init_dai_link(). This saves adding a function declaration for
snd_soc_init_multicodec().

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fb78674..e9e8956 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1141,6 +1141,100 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	}
 }
 
+static int snd_soc_init_multicodec(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *dai_link)
+{
+	/* Legacy codec/codec_dai link is a single entry in multicodec */
+	if (dai_link->codec_name || dai_link->codec_of_node ||
+	    dai_link->codec_dai_name) {
+		dai_link->num_codecs = 1;
+
+		dai_link->codecs = devm_kzalloc(card->dev,
+				sizeof(struct snd_soc_dai_link_component),
+				GFP_KERNEL);
+		if (!dai_link->codecs)
+			return -ENOMEM;
+
+		dai_link->codecs[0].name = dai_link->codec_name;
+		dai_link->codecs[0].of_node = dai_link->codec_of_node;
+		dai_link->codecs[0].dai_name = dai_link->codec_dai_name;
+	}
+
+	if (!dai_link->codecs) {
+		dev_err(card->dev, "ASoC: DAI link has no CODECs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int soc_init_dai_link(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *link)
+{
+	int i, ret;
+
+	ret = snd_soc_init_multicodec(card, link);
+	if (ret) {
+		dev_err(card->dev, "ASoC: failed to init multicodec\n");
+		return ret;
+	}
+
+	for (i = 0; i < link->num_codecs; i++) {
+		/*
+		 * Codec must be specified by 1 of name or OF node,
+		 * not both or neither.
+		 */
+		if (!!link->codecs[i].name ==
+		    !!link->codecs[i].of_node) {
+			dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
+				link->name);
+			return -EINVAL;
+		}
+		/* Codec DAI name must be specified */
+		if (!link->codecs[i].dai_name) {
+			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
+				link->name);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Platform may be specified by either name or OF node, but
+	 * can be left unspecified, and a dummy platform will be used.
+	 */
+	if (link->platform_name && link->platform_of_node) {
+		dev_err(card->dev,
+			"ASoC: Both platform name/of_node are set for %s\n",
+			link->name);
+		return -EINVAL;
+	}
+
+	/*
+	 * CPU device may be specified by either name or OF node, but
+	 * can be left unspecified, and will be matched based on DAI
+	 * name alone..
+	 */
+	if (link->cpu_name && link->cpu_of_node) {
+		dev_err(card->dev,
+			"ASoC: Neither/both cpu name/of_node are set for %s\n",
+			link->name);
+		return -EINVAL;
+	}
+	/*
+	 * At least one of CPU DAI name or CPU device name/node must be
+	 * specified
+	 */
+	if (!link->cpu_dai_name &&
+	    !(link->cpu_name || link->cpu_of_node)) {
+		dev_err(card->dev,
+			"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
+			link->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
@@ -2363,33 +2457,6 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
-static int snd_soc_init_multicodec(struct snd_soc_card *card,
-				   struct snd_soc_dai_link *dai_link)
-{
-	/* Legacy codec/codec_dai link is a single entry in multicodec */
-	if (dai_link->codec_name || dai_link->codec_of_node ||
-	    dai_link->codec_dai_name) {
-		dai_link->num_codecs = 1;
-
-		dai_link->codecs = devm_kzalloc(card->dev,
-				sizeof(struct snd_soc_dai_link_component),
-				GFP_KERNEL);
-		if (!dai_link->codecs)
-			return -ENOMEM;
-
-		dai_link->codecs[0].name = dai_link->codec_name;
-		dai_link->codecs[0].of_node = dai_link->codec_of_node;
-		dai_link->codecs[0].dai_name = dai_link->codec_dai_name;
-	}
-
-	if (!dai_link->codecs) {
-		dev_err(card->dev, "ASoC: DAI link has no CODECs\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /**
  * snd_soc_register_card - Register a card with the ASoC core
  *
@@ -2398,7 +2465,7 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, j, ret;
+	int i, ret;
 	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
@@ -2407,63 +2474,11 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai_link *link = &card->dai_link[i];
 
-		ret = snd_soc_init_multicodec(card, link);
+		ret = soc_init_dai_link(card, link);
 		if (ret) {
-			dev_err(card->dev, "ASoC: failed to init multicodec\n");
-			return ret;
-		}
-
-		for (j = 0; j < link->num_codecs; j++) {
-			/*
-			 * Codec must be specified by 1 of name or OF node,
-			 * not both or neither.
-			 */
-			if (!!link->codecs[j].name ==
-			    !!link->codecs[j].of_node) {
-				dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
-					link->name);
-				return -EINVAL;
-			}
-			/* Codec DAI name must be specified */
-			if (!link->codecs[j].dai_name) {
-				dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
-					link->name);
-				return -EINVAL;
-			}
-		}
-
-		/*
-		 * Platform may be specified by either name or OF node, but
-		 * can be left unspecified, and a dummy platform will be used.
-		 */
-		if (link->platform_name && link->platform_of_node) {
-			dev_err(card->dev,
-				"ASoC: Both platform name/of_node are set for %s\n",
+			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
-			return -EINVAL;
-		}
-
-		/*
-		 * CPU device may be specified by either name or OF node, but
-		 * can be left unspecified, and will be matched based on DAI
-		 * name alone..
-		 */
-		if (link->cpu_name && link->cpu_of_node) {
-			dev_err(card->dev,
-				"ASoC: Neither/both cpu name/of_node are set for %s\n",
-				link->name);
-			return -EINVAL;
-		}
-		/*
-		 * At least one of CPU DAI name or CPU device name/node must be
-		 * specified
-		 */
-		if (!link->cpu_dai_name &&
-		    !(link->cpu_name || link->cpu_of_node)) {
-			dev_err(card->dev,
-				"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
-				link->name);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
-- 
1.9.1
