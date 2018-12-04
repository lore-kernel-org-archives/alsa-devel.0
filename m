From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/7] ASoC: simple-card: use cpu/codec pointer
 on simple_dai_props
Date: Tue, 4 Dec 2018 08:19:43 +0000
Message-ID: <87d0qh3e75.wl-kuninori.morimoto.gx@renesas.com>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410097.outbound.protection.outlook.com [40.107.141.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F850267B51
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:19:47 +0100 (CET)
In-Reply-To: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <3FDD8E6727BC7B44A533DEFDFDDEB020@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

In  DPCM case, it uses CPU-dummy / dummy-Codec dai links, and
non DPCM case, it uses CPU-Codec dai links.

Now, we want to merge simple-card and simple-scu-card.

These sound cards are using silimar but not same logic on each functions.
Then, of course we want to share same logic.
To compromise, this patch uses cpu/codec pointer on simple-card.
It is same logic with simple-scu-card, thus easy merging.
This is prepare for merging audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-card.c | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index ff3f9fa..7661234 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -18,8 +18,8 @@
 struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct simple_dai_props {
-		struct asoc_simple_dai cpu_dai;
-		struct asoc_simple_dai codec_dai;
+		struct asoc_simple_dai *cpu_dai;
+		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
 		struct snd_soc_dai_link_component platform;
 		unsigned int mclk_fs;
@@ -28,6 +28,7 @@ struct simple_card_data {
 	struct asoc_simple_jack hp_jack;
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
+	struct asoc_simple_dai *dais;
 };
 
 #define simple_priv_to_card(priv) (&(priv)->snd_card)
@@ -47,13 +48,13 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 		simple_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_card_clk_enable(&dai_props->cpu_dai);
+	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_clk_enable(&dai_props->codec_dai);
+	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
 	if (ret)
-		asoc_simple_card_clk_disable(&dai_props->cpu_dai);
+		asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
 	return ret;
 }
@@ -65,9 +66,9 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(&dai_props->cpu_dai);
+	asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
-	asoc_simple_card_clk_disable(&dai_props->codec_dai);
+	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
 static int asoc_simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
@@ -102,11 +103,11 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	if (mclk_fs) {
 		mclk = params_rate(params) * mclk_fs;
 
-		ret = asoc_simple_set_clk_rate(&dai_props->codec_dai, mclk);
+		ret = asoc_simple_set_clk_rate(dai_props->codec_dai, mclk);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_set_clk_rate(&dai_props->cpu_dai, mclk);
+		ret = asoc_simple_set_clk_rate(dai_props->cpu_dai, mclk);
 		if (ret < 0)
 			return ret;
 
@@ -134,17 +135,16 @@ static const struct snd_soc_ops asoc_simple_card_ops = {
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *codec = rtd->codec_dai;
-	struct snd_soc_dai *cpu = rtd->cpu_dai;
-	struct simple_dai_props *dai_props =
-		simple_priv_to_props(priv, rtd->num);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_card_init_dai(codec, &dai_props->codec_dai);
+	ret = asoc_simple_card_init_dai(rtd->codec_dai,
+					dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_dai(cpu, &dai_props->cpu_dai);
+	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
+					dai_props->cpu_dai);
 	if (ret < 0)
 		return ret;
 
@@ -153,14 +153,14 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 static int asoc_simple_card_dai_link_of(struct device_node *node,
 					struct simple_card_data *priv,
-					int idx,
+					int *dai_idx, int link_idx,
 					bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
-	struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
-	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, link_idx);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
+	struct asoc_simple_dai *cpu_dai;
+	struct asoc_simple_dai *codec_dai;
 	struct device_node *cpu = NULL;
 	struct device_node *plat = NULL;
 	struct device_node *codec = NULL;
@@ -193,6 +193,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 	}
 
+	cpu_dai			=
+	dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+	codec_dai		=
+	dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+
 	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
 					    prefix, &dai_link->dai_fmt);
 	if (ret < 0)
@@ -290,6 +295,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct device_node *dai_link;
 	struct device_node *node = dev->of_node;
 	int ret;
+	int link_idx, dai_idx;
 
 	if (!node)
 		return -EINVAL;
@@ -308,23 +314,24 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	of_property_read_u32(node, PREFIX "mclk-fs", &priv->mclk_fs);
 
 	/* Single/Muti DAI link(s) & New style of DT node */
+	link_idx = 0;
+	dai_idx  = 0;
 	if (dai_link) {
 		struct device_node *np = NULL;
-		int i = 0;
 
 		for_each_child_of_node(node, np) {
-			dev_dbg(dev, "\tlink %d:\n", i);
+			dev_dbg(dev, "\tlink %d:\n", link_idx);
 			ret = asoc_simple_card_dai_link_of(np, priv,
-							   i, false);
+						&dai_idx, link_idx++, false);
 			if (ret < 0) {
 				of_node_put(np);
 				goto card_parse_end;
 			}
-			i++;
 		}
 	} else {
 		/* For single DAI link & old style of DT node */
-		ret = asoc_simple_card_dai_link_of(node, priv, 0, true);
+		ret = asoc_simple_card_dai_link_of(node, priv,
+						&dai_idx, link_idx++, true);
 		if (ret < 0)
 			goto card_parse_end;
 	}
@@ -362,6 +369,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
+	struct asoc_simple_dai *dais;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct snd_soc_card *card;
@@ -380,7 +388,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	dai_props = devm_kcalloc(dev, num, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, num, sizeof(*dai_link), GFP_KERNEL);
-	if (!dai_props || !dai_link)
+	dais      = devm_kcalloc(dev, num * 2, sizeof(*dais),      GFP_KERNEL);
+	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
 	/*
@@ -397,6 +406,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	priv->dai_props			= dai_props;
 	priv->dai_link			= dai_link;
+	priv->dais			= dais;
 
 	/* Init snd_soc_card */
 	card = simple_priv_to_card(priv);
-- 
2.7.4
