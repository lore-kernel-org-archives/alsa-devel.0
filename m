From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add
	asoc_simple_debug_info()" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:03 +0000 (GMT)
Message-ID: <20190321150703.B053C11288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC24DF89732
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:07:04 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_debug_info()

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

>From 0580dde59438686d60762b6da9229ebec693b94f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:54:42 +0900
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_debug_info()

Current simple-card-utils has dev_dbg(), but people want to
add #define DEBUG at simple-card/audio-graph, not simple-card-utils.
And, people want to get all information.
This patch adds new asoc_simple_debug_info() to indicates information.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 72 +++++++++++++++++++++++++++
 sound/soc/generic/audio-graph-card.c  |  2 +
 sound/soc/generic/simple-card-utils.c | 12 -----
 sound/soc/generic/simple-card.c       |  2 +
 4 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7afe45389972..0199ad0bbcd0 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -129,4 +129,76 @@ int asoc_simple_card_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
 			       int is_hp, char *prefix);
 
+
+#ifdef DEBUG
+inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
+				  char *name,
+				  struct asoc_simple_dai *dai)
+{
+	struct device *dev = simple_priv_to_dev(priv);
+
+	if (dai->name)
+		dev_dbg(dev, "%s dai name = %s\n",
+			name, dai->name);
+	if (dai->sysclk)
+		dev_dbg(dev, "%s sysclk = %d\n",
+			name, dai->sysclk);
+
+	dev_dbg(dev, "%s direction = %s\n",
+		name, dai->clk_direction ? "OUT" : "IN");
+
+	if (dai->slots)
+		dev_dbg(dev, "%s slots = %d\n", name, dai->slots);
+	if (dai->slot_width)
+		dev_dbg(dev, "%s slot width = %d\n", name, dai->slot_width);
+	if (dai->tx_slot_mask)
+		dev_dbg(dev, "%s tx slot mask = %d\n", name, dai->tx_slot_mask);
+	if (dai->rx_slot_mask)
+		dev_dbg(dev, "%s rx slot mask = %d\n", name, dai->rx_slot_mask);
+	if (dai->clk)
+		dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));
+}
+
+inline void asoc_simple_debug_info(struct asoc_simple_priv *priv)
+{
+	struct snd_soc_card *card = simple_priv_to_card(priv);
+	struct device *dev = simple_priv_to_dev(priv);
+
+	int i;
+
+	if (card->name)
+		dev_dbg(dev, "Card Name: %s\n", card->name);
+
+	for (i = 0; i < card->num_links; i++) {
+		struct simple_dai_props *props = simple_priv_to_props(priv, i);
+		struct snd_soc_dai_link *link = simple_priv_to_link(priv, i);
+
+		dev_dbg(dev, "DAI%d\n", i);
+
+		asoc_simple_debug_dai(priv, "cpu", props->cpu_dai);
+		asoc_simple_debug_dai(priv, "codec", props->codec_dai);
+
+		if (link->name)
+			dev_dbg(dev, "dai name = %s\n", link->name);
+
+		dev_dbg(dev, "dai format = %04x\n", link->dai_fmt);
+
+		if (props->adata.convert_rate)
+			dev_dbg(dev, "convert_rate = %d\n",
+				props->adata.convert_rate);
+		if (props->adata.convert_channels)
+			dev_dbg(dev, "convert_channels = %d\n",
+				props->adata.convert_channels);
+		if (props->codec_conf && props->codec_conf->name_prefix)
+			dev_dbg(dev, "name prefix = %s\n",
+				props->codec_conf->name_prefix);
+		if (props->mclk_fs)
+			dev_dbg(dev, "mclk-fs = %d\n",
+				props->mclk_fs);
+	}
+}
+#else
+#define  asoc_simple_debug_info(priv)
+#endif /* DEBUG */
+
 #endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 7dd772a895e2..2a95355540d1 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -712,6 +712,8 @@ static int graph_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 
+	asoc_simple_debug_info(priv);
+
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0)
 		goto err;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 5c1424f03620..f5ba5ad300cc 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -49,9 +49,6 @@ void asoc_simple_card_parse_convert(struct device *dev,
 	/* channels transfer */
 	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-channels");
 	of_property_read_u32(np, prop, &data->convert_channels);
-
-	dev_dbg(dev, "convert_rate     %d\n", data->convert_rate);
-	dev_dbg(dev, "convert_channels %d\n", data->convert_channels);
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_convert);
 
@@ -93,8 +90,6 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 
 	*retfmt = daifmt;
 
-	dev_dbg(dev, "format : %04x\n", daifmt);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_daifmt);
@@ -116,8 +111,6 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
 
 		dai_link->name		= name;
 		dai_link->stream_name	= name;
-
-		dev_dbg(dev, "name : %s\n", name);
 	}
 
 	return ret;
@@ -146,8 +139,6 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 	if (!card->name && card->dai_link)
 		card->name = card->dai_link->name;
 
-	dev_dbg(card->dev, "Card Name: %s\n", card->name ? card->name : "");
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
@@ -211,9 +202,6 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	if (of_property_read_bool(node, "system-clock-direction-out"))
 		simple_dai->clk_direction = SND_SOC_CLOCK_OUT;
 
-	dev_dbg(dev, "%s : sysclk = %d, direction %d\n", dai_name,
-		simple_dai->sysclk, simple_dai->clk_direction);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b792638a11c8..77899624787e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -813,6 +813,8 @@ static int simple_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 
+	asoc_simple_debug_info(priv);
+
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0)
 		goto err;
-- 
2.20.1
