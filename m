From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_parse_clk()" to the asoc tree
Date: Fri, 05 Aug 2016 13:08:58 +0100
Message-ID: <E1bVdvu-0002c3-Lq@debutante>
References: <87k2gimjki.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k2gimjki.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_parse_clk()

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

>From c9a235da8a61cf9af7653fca341ded0881a64eca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Jul 2016 02:53:32 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_parse_clk()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 68 +++++++------------------------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index fa37f842b62f..ed5391f41280 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -190,6 +190,10 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
+		ret = asoc_simple_card_parse_clk_cpu(np, dai_link, dai_props);
+		if (ret < 0)
+			return ret;
+
 		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 							"fe.%s",
 							dai_link->cpu_dai_name);
@@ -225,6 +229,10 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
+		ret = asoc_simple_card_parse_clk_codec(np, dai_link, dai_props);
+		if (ret < 0)
+			return ret;
+
 		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 							"be.%s",
 							dai_link->codec_dai_name);
@@ -250,68 +258,12 @@ static int rsrc_card_parse_links(struct device_node *np,
 	dai_link->ops			= &rsrc_card_ops;
 	dai_link->init			= rsrc_card_dai_init;
 
-	return 0;
-}
-
-static int rsrc_card_parse_clk(struct device_node *np,
-			       struct rsrc_card_priv *priv,
-			       int idx, bool is_fe)
-{
-	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
-	struct clk *clk;
-	struct device_node *of_np = is_fe ?	dai_link->cpu_of_node :
-						dai_link->codec_of_node;
-	u32 val;
-
-	/*
-	 * Parse dai->sysclk come from "clocks = <&xxx>"
-	 * (if system has common clock)
-	 *  or "system-clock-frequency = <xxx>"
-	 *  or device's module clock.
-	 */
-	if (of_property_read_bool(np, "clocks")) {
-		clk = of_clk_get(np, 0);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-
-		dai_props->sysclk = clk_get_rate(clk);
-		dai_props->clk = clk;
-	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
-		dai_props->sysclk = val;
-	} else {
-		clk = of_clk_get(of_np, 0);
-		if (!IS_ERR(clk))
-			dai_props->sysclk = clk_get_rate(clk);
-	}
-
-	return 0;
-}
-
-static int rsrc_card_dai_sub_link_of(struct device_node *node,
-				     struct device_node *np,
-				     struct rsrc_card_priv *priv,
-				     int idx, bool is_fe)
-{
-	struct device *dev = rsrc_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
-	int ret;
-
-	ret = rsrc_card_parse_links(np, priv, idx, is_fe);
-	if (ret < 0)
-		return ret;
-
-	ret = rsrc_card_parse_clk(np, priv, idx, is_fe);
-	if (ret < 0)
-		return ret;
-
 	dev_dbg(dev, "\t%s / %04x / %d\n",
 		dai_link->name,
 		dai_link->dai_fmt,
 		dai_props->sysclk);
 
-	return ret;
+	return 0;
 }
 
 static int rsrc_card_dai_link_of(struct device_node *node,
@@ -348,7 +300,7 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 		if (strcmp(np->name, "cpu") == 0)
 			is_fe = true;
 
-		ret = rsrc_card_dai_sub_link_of(node, np, priv, i, is_fe);
+		ret = rsrc_card_parse_links(np, priv, i, is_fe);
 		if (ret < 0)
 			return ret;
 		i++;
-- 
2.8.1
