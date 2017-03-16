From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: add new simple_priv_to_card() macro" to the asoc tree
Date: Thu, 16 Mar 2017 14:10:59 +0000
Message-ID: <E1coW7H-0002ZE-Hd@debutante>
References: <87h92vcfu7.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h92vcfu7.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: add new simple_priv_to_card() macro

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

>From d27f3b4a2d81e873de4d11899e510a1a507da8e3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Mar 2017 04:44:16 +0000
Subject: [PATCH] ASoC: simple-scu-card: add new simple_priv_to_card() macro

Current simple card driver is directly calling priv->snd_card
everywhere, but it makes unreadable code.
Let's use simple_priv_to_card() macro for it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 93d7d8980cd5..cd0f3f50eebf 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -31,9 +31,10 @@ struct simple_card_data {
 	u32 convert_channels;
 };
 
-#define simple_priv_to_dev(priv) ((priv)->snd_card.dev)
-#define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
+#define simple_priv_to_card(priv) (&(priv)->snd_card)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + (i))
+#define simple_priv_to_dev(priv) (simple_priv_to_card(priv)->dev)
+#define simple_priv_to_link(priv, i) (simple_priv_to_card(priv)->dai_link + (i))
 
 #define DAI	"sound-dai"
 #define CELL	"#sound-dai-cells"
@@ -109,6 +110,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct asoc_simple_dai *dai_props = simple_priv_to_props(priv, idx);
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	int ret;
 
 	if (is_fe) {
@@ -163,7 +165,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
-		snd_soc_of_parse_audio_prefix(&priv->snd_card,
+		snd_soc_of_parse_audio_prefix(card,
 					      &priv->codec_conf,
 					      dai_link->codec_of_node,
 					      PREFIX "prefix");
@@ -201,6 +203,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *np;
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	unsigned int daifmt = 0;
 	bool is_fe;
 	int ret, i;
@@ -208,7 +211,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (!node)
 		return -EINVAL;
 
-	ret = snd_soc_of_parse_audio_routing(&priv->snd_card, PREFIX "routing");
+	ret = snd_soc_of_parse_audio_routing(card, PREFIX "routing");
 	if (ret < 0)
 		return ret;
 
@@ -239,12 +242,12 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		i++;
 	}
 
-	ret = asoc_simple_card_parse_card_name(&priv->snd_card, PREFIX);
+	ret = asoc_simple_card_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		return ret;
 
 	dev_dbg(dev, "New card: %s\n",
-		priv->snd_card.name ? priv->snd_card.name : "");
+		card->name ? card->name : "");
 	dev_dbg(dev, "convert_rate     %d\n", priv->convert_rate);
 	dev_dbg(dev, "convert_channels %d\n", priv->convert_channels);
 
@@ -256,6 +259,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dai_props;
+	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int num, ret;
@@ -276,12 +280,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->dai_link				= dai_link;
 
 	/* Init snd_soc_card */
-	priv->snd_card.owner			= THIS_MODULE;
-	priv->snd_card.dev			= dev;
-	priv->snd_card.dai_link			= priv->dai_link;
-	priv->snd_card.num_links		= num;
-	priv->snd_card.codec_conf		= &priv->codec_conf;
-	priv->snd_card.num_configs		= 1;
+	card = simple_priv_to_card(priv);
+	card->owner		= THIS_MODULE;
+	card->dev		= dev;
+	card->dai_link		= priv->dai_link;
+	card->num_links		= num;
+	card->codec_conf	= &priv->codec_conf;
+	card->num_configs	= 1;
 
 	ret = asoc_simple_card_parse_of(np, priv);
 	if (ret < 0) {
@@ -290,13 +295,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		goto err;
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
