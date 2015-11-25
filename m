From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Define soc_init_dai_link() to wrap link
	intialization." to the asoc tree
Date: Wed, 25 Nov 2015 17:57:38 +0000
Message-ID: <E1a1eK2-0006Wy-L7@debutante>
References: <1439187172-1018-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E47F1261AA0
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:47 +0100 (CET)
In-Reply-To: <1439187172-1018-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Define soc_init_dai_link() to wrap link intialization.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 923c5e61ecd9b0ca006a7707583287439f36c2e9 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Mon, 23 Nov 2015 11:01:49 -0500
Subject: [PATCH] ASoC: Define soc_init_dai_link() to wrap link intialization.

Define soc_init_dai_link() to wrap link initialization, to reuse it later
by snd_soc_instantiate_card() when adding new DAI links from topology in
component probing phase.

Move static func snd_soc_init_multicodec(), so that it can be reused by
soc_init_dai_link(). This saves adding a function declaration for
snd_soc_init_multicodec().

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 181 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 83 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2c95de723d8f..2ecd09475d88 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1134,6 +1134,100 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
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
@@ -2356,33 +2450,6 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
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
@@ -2391,7 +2458,7 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, j, ret;
+	int i, ret;
 	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
@@ -2400,63 +2467,11 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
2.6.2
