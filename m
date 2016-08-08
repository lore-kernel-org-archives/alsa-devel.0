From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_parse_dai()" to the asoc tree
Date: Mon, 08 Aug 2016 11:46:50 +0100
Message-ID: <E1bWi54-0000Jr-L9@debutante>
References: <8737pdqchm.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737pdqchm.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_parse_dai()

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

>From 5bbf3866cbc1da23c628ad5dd7248cca8b8adc2c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 06:02:31 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_parse_dai()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index ed5391f41280..82187e00eb12 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -62,6 +62,9 @@ struct rsrc_card_priv {
 #define rsrc_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
 #define rsrc_priv_to_props(priv, i) ((priv)->dai_props + (i))
 
+#define DAI	"sound-dai"
+#define CELL	"#sound-dai-cells"
+
 static int rsrc_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -155,18 +158,9 @@ static int rsrc_card_parse_links(struct device_node *np,
 	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
-	struct of_phandle_args args;
+	int is_single_links = 0;
 	int ret;
 
-	/*
-	 * Get node via "sound-dai = <&phandle port>"
-	 * it will be used as xxx_of_node on soc_bind_dai_link()
-	 */
-	ret = of_parse_phandle_with_args(np, "sound-dai",
-					 "#sound-dai-cells", 0, &args);
-	if (ret)
-		return ret;
-
 	/* Parse TDM slot */
 	ret = snd_soc_of_parse_tdm_slot(np,
 					&dai_props->tx_slot_mask,
@@ -185,9 +179,10 @@ static int rsrc_card_parse_links(struct device_node *np,
 		/* FE settings */
 		dai_link->dynamic		= 1;
 		dai_link->dpcm_merged_format	= 1;
-		dai_link->cpu_of_node		= args.np;
-		ret = snd_soc_of_get_dai_name(np, &dai_link->cpu_dai_name);
-		if (ret < 0)
+
+		ret = asoc_simple_card_parse_cpu(np, dai_link, DAI, CELL,
+						 &is_single_links);
+		if (ret)
 			return ret;
 
 		ret = asoc_simple_card_parse_clk_cpu(np, dai_link, dai_props);
@@ -209,7 +204,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 		 *	fmt_single_name()
 		 *	fmt_multiple_name()
 		 */
-		if (!args.args_count)
+		if (is_single_links)
 			dai_link->cpu_dai_name = NULL;
 	} else {
 		const struct rsrc_card_of_data *of_data;
@@ -224,8 +219,8 @@ static int rsrc_card_parse_links(struct device_node *np,
 		/* BE settings */
 		dai_link->no_pcm		= 1;
 		dai_link->be_hw_params_fixup	= rsrc_card_be_hw_params_fixup;
-		dai_link->codec_of_node		= args.np;
-		ret = snd_soc_of_get_dai_name(np, &dai_link->codec_dai_name);
+
+		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
 		if (ret < 0)
 			return ret;
 
-- 
2.8.1
