From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: add new simple_priv_to_card() macro" to the asoc tree
Date: Thu, 16 Mar 2017 14:11:02 +0000
Message-ID: <E1coW7K-0002a5-HB@debutante>
References: <87innbcfuq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87innbcfuq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: add new simple_priv_to_card() macro

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

>From 5be509576cf634ad384025f50fc4fcb941d14256 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Mar 2017 04:44:00 +0000
Subject: [PATCH] ASoC: simple-card: add new simple_priv_to_card() macro

Current simple card driver is directly calling priv->snd_card
everywhere, but it makes unreadable code.
Let's use simple_priv_to_card() macro for it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 9ad05e237ee0..948f3ba02d12 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -40,9 +40,10 @@ struct simple_card_data {
 	struct snd_soc_dai_link *dai_link;
 };
 
-#define simple_priv_to_dev(priv) ((priv)->snd_card.dev)
-#define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
+#define simple_priv_to_card(priv) (&(priv)->snd_card)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + (i))
+#define simple_priv_to_dev(priv) (simple_priv_to_card(priv)->dev)
+#define simple_priv_to_link(priv, i) (simple_priv_to_card(priv)->dai_link + (i))
 
 #define DAI	"sound-dai"
 #define CELL	"#sound-dai-cells"
@@ -323,6 +324,7 @@ static int asoc_simple_card_parse_aux_devs(struct device_node *node,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *aux_node;
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	int i, n, len;
 
 	if (!of_find_property(node, PREFIX "aux-devs", &len))
@@ -332,19 +334,19 @@ static int asoc_simple_card_parse_aux_devs(struct device_node *node,
 	if (n <= 0)
 		return -EINVAL;
 
-	priv->snd_card.aux_dev = devm_kzalloc(dev,
-			n * sizeof(*priv->snd_card.aux_dev), GFP_KERNEL);
-	if (!priv->snd_card.aux_dev)
+	card->aux_dev = devm_kzalloc(dev,
+			n * sizeof(*card->aux_dev), GFP_KERNEL);
+	if (!card->aux_dev)
 		return -ENOMEM;
 
 	for (i = 0; i < n; i++) {
 		aux_node = of_parse_phandle(node, PREFIX "aux-devs", i);
 		if (!aux_node)
 			return -EINVAL;
-		priv->snd_card.aux_dev[i].codec_of_node = aux_node;
+		card->aux_dev[i].codec_of_node = aux_node;
 	}
 
-	priv->snd_card.num_aux_devs = n;
+	card->num_aux_devs = n;
 	return 0;
 }
 
@@ -352,6 +354,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct simple_card_data *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device_node *dai_link;
 	int ret;
 
@@ -362,7 +365,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 
 	/* The off-codec widgets */
 	if (of_property_read_bool(node, PREFIX "widgets")) {
-		ret = snd_soc_of_parse_audio_simple_widgets(&priv->snd_card,
+		ret = snd_soc_of_parse_audio_simple_widgets(card,
 					PREFIX "widgets");
 		if (ret)
 			goto card_parse_end;
@@ -370,7 +373,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 
 	/* DAPM routes */
 	if (of_property_read_bool(node, PREFIX "routing")) {
-		ret = snd_soc_of_parse_audio_routing(&priv->snd_card,
+		ret = snd_soc_of_parse_audio_routing(card,
 					PREFIX "routing");
 		if (ret)
 			goto card_parse_end;
@@ -401,7 +404,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			goto card_parse_end;
 	}
 
-	ret = asoc_simple_card_parse_card_name(&priv->snd_card, PREFIX);
+	ret = asoc_simple_card_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		goto card_parse_end;
 
@@ -420,6 +423,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_dai_props *dai_props;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct snd_soc_card *card;
 	int num, ret;
 
 	/* Get the number of DAI links */
@@ -442,10 +446,11 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->dai_link			= dai_link;
 
 	/* Init snd_soc_card */
-	priv->snd_card.owner		= THIS_MODULE;
-	priv->snd_card.dev		= dev;
-	priv->snd_card.dai_link		= priv->dai_link;
-	priv->snd_card.num_links	= num;
+	card = simple_priv_to_card(priv);
+	card->owner		= THIS_MODULE;
+	card->dev		= dev;
+	card->dai_link		= priv->dai_link;
+	card->num_links		= num;
 
 	if (np && of_device_is_available(np)) {
 
@@ -474,7 +479,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		priv->snd_card.name	= (cinfo->card) ? cinfo->card : cinfo->name;
+		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
 		dai_link->name		= cinfo->name;
 		dai_link->stream_name	= cinfo->name;
 		dai_link->platform_name	= cinfo->platform;
@@ -489,13 +494,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 					sizeof(priv->dai_props->codec_dai));
 	}
 
-	snd_soc_card_set_drvdata(&priv->snd_card, priv);
+	snd_soc_card_set_drvdata(card, priv);
 
-	ret = devm_snd_soc_register_card(dev, &priv->snd_card);
+	ret = devm_snd_soc_register_card(dev, card);
 	if (ret >= 0)
 		return ret;
 err:
-	asoc_simple_card_clean_reference(&priv->snd_card);
+	asoc_simple_card_clean_reference(card);
 
 	return ret;
 }
-- 
2.11.0
