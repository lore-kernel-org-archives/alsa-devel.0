From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-scu-card: code sync: follow to simple family style" to the asoc tree
Date: Fri, 28 Oct 2016 19:49:12 +0100
Message-ID: <E1c0CDI-0005yQ-US@finisterre>
References: <87r37f4c6v.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r37f4c6v.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: code sync: follow to simple family style

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

>From 15a190ffec3b3f5e632faaa01b92f4cef32d63a3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 28 Oct 2016 03:37:26 +0000
Subject: [PATCH] ASoC: simple-scu-card: code sync: follow to simple family
 style

simple sound card family are using very similar style, but because of its
historical reason, there are small differences. For example pointer style,
function name, caller postion etc...
This patch synchronized simple card style to other simple card family

Current simple-scu-card function naming is different from other simple card
family. And related to it, the necessary operation position is also
different. This patch synchronize these to other simple card family.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/generic/simple-scu-card.c | 99 ++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 56 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index b9973a56bcb0..b8d8437ef3dd 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -101,7 +101,7 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int asoc_simple_card_parse_links(struct device_node *np,
+static int asoc_simple_card_dai_link_of(struct device_node *np,
 					struct asoc_simple_card_priv *priv,
 					unsigned int daifmt,
 					int idx, bool is_fe)
@@ -195,22 +195,35 @@ static int asoc_simple_card_parse_links(struct device_node *np,
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of(struct device_node *node,
-				 struct asoc_simple_card_priv *priv)
+static int asoc_simple_card_parse_of(struct device_node *node,
+				     struct asoc_simple_card_priv *priv)
+
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *np;
 	unsigned int daifmt = 0;
-	int ret, i;
 	bool is_fe;
+	int ret, i;
+
+	if (!node)
+		return -EINVAL;
+
+	ret = snd_soc_of_parse_audio_routing(&priv->snd_card, PREFIX "routing");
+	if (ret < 0)
+		return ret;
+
+	/* sampling rate convert */
+	of_property_read_u32(node, PREFIX "convert-rate", &priv->convert_rate);
+
+	/* channels transfer */
+	of_property_read_u32(node, PREFIX "convert-channels", &priv->convert_channels);
 
 	/* find 1st codec */
 	np = of_get_child_by_name(node, PREFIX "codec");
 	if (!np)
 		return -ENODEV;
 
-	ret = asoc_simple_card_parse_daifmt(dev, node, np,
-					    PREFIX, &daifmt);
+	ret = asoc_simple_card_parse_daifmt(dev, node, np, PREFIX, &daifmt);
 	if (ret < 0)
 		return ret;
 
@@ -220,58 +233,12 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		if (strcmp(np->name, PREFIX "cpu") == 0)
 			is_fe = true;
 
-		ret = asoc_simple_card_parse_links(np, priv, daifmt, i, is_fe);
+		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
 		if (ret < 0)
 			return ret;
 		i++;
 	}
 
-	return 0;
-}
-
-static int asoc_simple_card_parse_of(struct device_node *node,
-			      struct asoc_simple_card_priv *priv,
-			      struct device *dev)
-{
-	struct asoc_simple_dai *props;
-	struct snd_soc_dai_link *links;
-	int ret;
-	int num;
-
-	if (!node)
-		return -EINVAL;
-
-	num = of_get_child_count(node);
-	props = devm_kzalloc(dev, sizeof(*props) * num, GFP_KERNEL);
-	links = devm_kzalloc(dev, sizeof(*links) * num, GFP_KERNEL);
-	if (!props || !links)
-		return -ENOMEM;
-
-	priv->dai_props	= props;
-	priv->dai_link	= links;
-
-	/* Init snd_soc_card */
-	priv->snd_card.owner			= THIS_MODULE;
-	priv->snd_card.dev			= dev;
-	priv->snd_card.dai_link			= priv->dai_link;
-	priv->snd_card.num_links		= num;
-	priv->snd_card.codec_conf		= &priv->codec_conf;
-	priv->snd_card.num_configs		= 1;
-
-	ret = snd_soc_of_parse_audio_routing(&priv->snd_card, PREFIX "routing");
-	if (ret < 0)
-		return ret;
-
-	/* sampling rate convert */
-	of_property_read_u32(node, PREFIX "convert-rate", &priv->convert_rate);
-
-	/* channels transfer */
-	of_property_read_u32(node, PREFIX "convert-channels", &priv->convert_channels);
-
-	ret = asoc_simple_card_dai_link_of(node, priv);
-	if (ret < 0)
-		return ret;
-
 	ret = asoc_simple_card_parse_card_name(&priv->snd_card, PREFIX);
 	if (ret < 0)
 		return ret;
@@ -287,16 +254,36 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_card_priv *priv;
-	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_dai_link *links;
+	struct asoc_simple_dai *props;
 	struct device *dev = &pdev->dev;
-	int ret;
+	struct device_node *np = pdev->dev.of_node;
+	int num, ret;
 
 	/* Allocate the private data */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	ret = asoc_simple_card_parse_of(np, priv, dev);
+	num = of_get_child_count(np);
+
+	props = devm_kzalloc(dev, sizeof(*props) * num, GFP_KERNEL);
+	links = devm_kzalloc(dev, sizeof(*links) * num, GFP_KERNEL);
+	if (!props || !links)
+		return -ENOMEM;
+
+	priv->dai_props				= props;
+	priv->dai_link				= links;
+
+	/* Init snd_soc_card */
+	priv->snd_card.owner			= THIS_MODULE;
+	priv->snd_card.dev			= dev;
+	priv->snd_card.dai_link			= priv->dai_link;
+	priv->snd_card.num_links		= num;
+	priv->snd_card.codec_conf		= &priv->codec_conf;
+	priv->snd_card.num_configs		= 1;
+
+	ret = asoc_simple_card_parse_of(np, priv);
 	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "parse error %d\n", ret);
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
