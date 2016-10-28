From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-scu-card: code sync: tidyup props/link naming" to the asoc tree
Date: Fri, 28 Oct 2016 19:48:26 +0100
Message-ID: <E1c0CCY-0005wB-R3@finisterre>
References: <87oa2j4c5j.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oa2j4c5j.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: code sync: tidyup props/link naming

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

>From 193599264f3eb632f43f83f738b17241f91dbd5a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 28 Oct 2016 03:38:00 +0000
Subject: [PATCH] ASoC: simple-scu-card: code sync: tidyup props/link naming

simple sound card family are using very similar style, but because of its
historical reason, there are small differences. For example pointer style,
function name, caller postion etc...
This patch synchronizes style to other simple card family so that be enable
to easy reviewing.

This patch uses dai_link/dai_props instead of links/props.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/generic/simple-scu-card.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 1704b187f6ee..348e9a7c4d10 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -254,8 +254,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
-	struct snd_soc_dai_link *links;
-	struct asoc_simple_dai *props;
+	struct snd_soc_dai_link *dai_link;
+	struct asoc_simple_dai *dai_props;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	int num, ret;
@@ -267,13 +267,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	num = of_get_child_count(np);
 
-	props = devm_kzalloc(dev, sizeof(*props) * num, GFP_KERNEL);
-	links = devm_kzalloc(dev, sizeof(*links) * num, GFP_KERNEL);
-	if (!props || !links)
+	dai_props = devm_kzalloc(dev, sizeof(*dai_props) * num, GFP_KERNEL);
+	dai_link  = devm_kzalloc(dev, sizeof(*dai_link)  * num, GFP_KERNEL);
+	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
-	priv->dai_props				= props;
-	priv->dai_link				= links;
+	priv->dai_props				= dai_props;
+	priv->dai_link				= dai_link;
 
 	/* Init snd_soc_card */
 	priv->snd_card.owner			= THIS_MODULE;
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
