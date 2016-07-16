From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_dai instead of rsrc_card_dai" to the asoc tree
Date: Sat, 16 Jul 2016 13:05:30 +0100
Message-ID: <E1bOOLa-0005FZ-H1@debutante>
References: <87twg3lgsm.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87twg3lgsm.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_dai instead of rsrc_card_dai

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

>From 303c3be42815c2d12bf563dc0df9daceea1ebfad Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:58:50 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_dai instead of rsrc_card_dai

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 81914ca56f00..239a13a30bed 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -47,21 +47,12 @@ static const struct of_device_id rsrc_card_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
 
-struct rsrc_card_dai {
-	unsigned int sysclk;
-	unsigned int tx_slot_mask;
-	unsigned int rx_slot_mask;
-	int slots;
-	int slot_width;
-	struct clk *clk;
-};
-
 #define IDX_CPU		0
 #define IDX_CODEC	1
 struct rsrc_card_priv {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
-	struct rsrc_card_dai *dai_props;
+	struct asoc_simple_dai *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	u32 convert_rate;
 	u32 convert_channels;
@@ -75,7 +66,7 @@ static int rsrc_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct rsrc_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct rsrc_card_dai *dai_props =
+	struct asoc_simple_dai *dai_props =
 		rsrc_priv_to_props(priv, rtd->num);
 
 	return clk_prepare_enable(dai_props->clk);
@@ -85,7 +76,7 @@ static void rsrc_card_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct rsrc_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct rsrc_card_dai *dai_props =
+	struct asoc_simple_dai *dai_props =
 		rsrc_priv_to_props(priv, rtd->num);
 
 	clk_disable_unprepare(dai_props->clk);
@@ -101,7 +92,7 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct rsrc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_link *dai_link;
-	struct rsrc_card_dai *dai_props;
+	struct asoc_simple_dai *dai_props;
 	int num = rtd->num;
 	int ret;
 
@@ -163,7 +154,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 {
 	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
+	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
 	struct of_phandle_args args;
 	int ret;
 
@@ -267,7 +258,7 @@ static int rsrc_card_parse_clk(struct device_node *np,
 			       int idx, bool is_fe)
 {
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
+	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
 	struct clk *clk;
 	struct device_node *of_np = is_fe ?	dai_link->cpu_of_node :
 						dai_link->codec_of_node;
@@ -304,7 +295,7 @@ static int rsrc_card_dai_sub_link_of(struct device_node *node,
 {
 	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
+	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
 	int ret;
 
 	ret = rsrc_card_parse_links(np, priv, idx, is_fe);
@@ -371,7 +362,7 @@ static int rsrc_card_parse_of(struct device_node *node,
 			      struct device *dev)
 {
 	const struct rsrc_card_of_data *of_data = of_device_get_match_data(dev);
-	struct rsrc_card_dai *props;
+	struct asoc_simple_dai *props;
 	struct snd_soc_dai_link *links;
 	int ret;
 	int num;
-- 
2.8.1
