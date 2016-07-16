From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_parse_dailink_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:05:33 +0100
Message-ID: <E1bOOLd-0005GR-F8@debutante>
References: <87vb0jlgt7.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vb0jlgt7.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_parse_dailink_name()

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

>From 8a99a6bd7f410e1b889c8cc59538009f40507aac Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:58:25 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_parse_dailink_name()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index c065a6df0680..81914ca56f00 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -47,7 +47,6 @@ static const struct of_device_id rsrc_card_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
 
-#define DAI_NAME_NUM	32
 struct rsrc_card_dai {
 	unsigned int sysclk;
 	unsigned int tx_slot_mask;
@@ -55,7 +54,6 @@ struct rsrc_card_dai {
 	int slots;
 	int slot_width;
 	struct clk *clk;
-	char dai_name[DAI_NAME_NUM];
 };
 
 #define IDX_CPU		0
@@ -163,6 +161,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 				 struct rsrc_card_priv *priv,
 				 int idx, bool is_fe)
 {
+	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
 	struct of_phandle_args args;
@@ -200,9 +199,11 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
-		/* set dai_name */
-		snprintf(dai_props->dai_name, DAI_NAME_NUM, "fe.%s",
-			 dai_link->cpu_dai_name);
+		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
+							"fe.%s",
+							dai_link->cpu_dai_name);
+		if (ret < 0)
+			return ret;
 
 		/*
 		 * In soc_bind_dai_link() will check cpu name after
@@ -216,7 +217,6 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (!args.args_count)
 			dai_link->cpu_dai_name = NULL;
 	} else {
-		struct device *dev = rsrc_priv_to_dev(priv);
 		const struct rsrc_card_of_data *of_data;
 
 		of_data = of_device_get_match_data(dev);
@@ -234,6 +234,12 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
+		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
+							"be.%s",
+							dai_link->codec_dai_name);
+		if (ret < 0)
+			return ret;
+
 		/* additional name prefix */
 		if (of_data) {
 			priv->codec_conf.of_node = dai_link->codec_of_node;
@@ -244,18 +250,12 @@ static int rsrc_card_parse_links(struct device_node *np,
 						      dai_link->codec_of_node,
 						      "audio-prefix");
 		}
-
-		/* set dai_name */
-		snprintf(dai_props->dai_name, DAI_NAME_NUM, "be.%s",
-			 dai_link->codec_dai_name);
 	}
 
 	/* Simple Card assumes platform == cpu */
 	dai_link->platform_of_node	= dai_link->cpu_of_node;
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
-	dai_link->name			= dai_props->dai_name;
-	dai_link->stream_name		= dai_props->dai_name;
 	dai_link->ops			= &rsrc_card_ops;
 	dai_link->init			= rsrc_card_dai_init;
 
@@ -316,7 +316,7 @@ static int rsrc_card_dai_sub_link_of(struct device_node *node,
 		return ret;
 
 	dev_dbg(dev, "\t%s / %04x / %d\n",
-		dai_props->dai_name,
+		dai_link->name,
 		dai_link->dai_fmt,
 		dai_props->sysclk);
 
-- 
2.8.1
