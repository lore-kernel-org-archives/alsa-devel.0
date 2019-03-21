From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: share common priv
	for simple-card/audio-graph" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:01 +0000 (GMT)
Message-ID: <20190321150701.B3CDB11288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDB5AF8972D
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:07:02 +0100 (CET)
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

   ASoC: simple_card_utils: share common priv for simple-card/audio-graph

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

>From e59289cda8dec0153fa396864c8ba8092ec3b80d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:54:59 +0900
Subject: [PATCH] ASoC: simple_card_utils: share common priv for
 simple-card/audio-graph

Historically, simple-card/simple-scu-card/audio-graph/audio-graph-scu
are similar but different generic sound card.
simple-scu-card which was for DPCM was merged into simple-card, and
audio-graph-scu which was for DPCM was merged into audio-graph.
simple-card is for non OF graph sound card, and
audio-graph is for     OF graph sound card.
And, small detail difference (= function parameter, naming, etc)
between simple-card/audio-graph has been unified.

So today, the difference between simple-card/audio-graph are
just using OF graph style, or not.
In other words, there should no difference other than OF graph sytle.
simple-card/audio-graph are using own priv today , but we can merge it.
This patch merge it at simple_card_utils.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h    | 23 +++++++
 sound/soc/generic/audio-graph-card.c | 96 +++++++++++-----------------
 sound/soc/generic/simple-card.c      | 57 +++++------------
 3 files changed, 76 insertions(+), 100 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 0199ad0bbcd0..c0161ec17572 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -37,6 +37,29 @@ struct asoc_simple_jack {
 	struct snd_soc_jack_gpio gpio;
 };
 
+struct asoc_simple_priv {
+	struct snd_soc_card snd_card;
+	struct simple_dai_props {
+		struct asoc_simple_dai *cpu_dai;
+		struct asoc_simple_dai *codec_dai;
+		struct snd_soc_dai_link_component codecs; /* single codec */
+		struct snd_soc_dai_link_component platforms;
+		struct asoc_simple_card_data adata;
+		struct snd_soc_codec_conf *codec_conf;
+		unsigned int mclk_fs;
+	} *dai_props;
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
+	struct snd_soc_dai_link *dai_link;
+	struct asoc_simple_dai *dais;
+	struct snd_soc_codec_conf *codec_conf;
+	struct gpio_desc *pa_gpio;
+};
+#define simple_priv_to_card(priv)	(&(priv)->snd_card)
+#define simple_priv_to_props(priv, i)	((priv)->dai_props + (i))
+#define simple_priv_to_dev(priv)	(simple_priv_to_card(priv)->dev)
+#define simple_priv_to_link(priv, i)	(simple_priv_to_card(priv)->dai_link + (i))
+
 int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *node,
 				  struct device_node *codec,
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 2a95355540d1..656ca49ba727 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -20,25 +20,6 @@
 #include <linux/string.h>
 #include <sound/simple_card_utils.h>
 
-struct graph_priv {
-	struct snd_soc_card snd_card;
-	struct graph_dai_props {
-		struct asoc_simple_dai *cpu_dai;
-		struct asoc_simple_dai *codec_dai;
-		struct snd_soc_dai_link_component codecs; /* single codec */
-		struct snd_soc_dai_link_component platforms;
-		struct asoc_simple_card_data adata;
-		struct snd_soc_codec_conf *codec_conf;
-		unsigned int mclk_fs;
-	} *dai_props;
-	struct asoc_simple_jack hp_jack;
-	struct asoc_simple_jack mic_jack;
-	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dais;
-	struct snd_soc_codec_conf *codec_conf;
-	struct gpio_desc *pa_gpio;
-};
-
 struct link_info {
 	int dais; /* number of dai  */
 	int link; /* number of link */
@@ -46,11 +27,6 @@ struct link_info {
 	int cpu;  /* turn for CPU / Codec */
 };
 
-#define graph_priv_to_card(priv) (&(priv)->snd_card)
-#define graph_priv_to_props(priv, i) ((priv)->dai_props + (i))
-#define graph_priv_to_dev(priv) (graph_priv_to_card(priv)->dev)
-#define graph_priv_to_link(priv, i) (graph_priv_to_card(priv)->dai_link + (i))
-
 #define PREFIX	"audio-graph-card,"
 
 static int graph_outdrv_event(struct snd_soc_dapm_widget *w,
@@ -58,7 +34,7 @@ static int graph_outdrv_event(struct snd_soc_dapm_widget *w,
 			      int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct graph_priv *priv = snd_soc_card_get_drvdata(dapm->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(dapm->card);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -83,8 +59,8 @@ static const struct snd_soc_dapm_widget graph_dapm_widgets[] = {
 static int graph_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
 	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
@@ -101,8 +77,8 @@ static int graph_startup(struct snd_pcm_substream *substream)
 static void graph_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
@@ -115,8 +91,8 @@ static int graph_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	unsigned int mclk, mclk_fs = 0;
 	int ret = 0;
 
@@ -148,8 +124,8 @@ static const struct snd_soc_ops graph_ops = {
 
 static int graph_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret = 0;
 
 	ret = asoc_simple_card_init_dai(rtd->codec_dai,
@@ -168,8 +144,8 @@ static int graph_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int graph_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				    struct snd_pcm_hw_params *params)
 {
-	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
 
@@ -198,7 +174,7 @@ static void graph_parse_convert(struct device *dev,
 
 static void graph_parse_mclk_fs(struct device_node *top,
 				struct device_node *ep,
-				struct graph_dai_props *props)
+				struct simple_dai_props *props)
 {
 	struct device_node *port	= of_get_parent(ep);
 	struct device_node *ports	= of_get_parent(port);
@@ -214,15 +190,15 @@ static void graph_parse_mclk_fs(struct device_node *top,
 	of_node_put(node);
 }
 
-static int graph_dai_link_of_dpcm(struct graph_priv *priv,
+static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 				  struct device_node *cpu_ep,
 				  struct device_node *codec_ep,
 				  struct link_info *li,
 				  int dup_codec)
 {
-	struct device *dev = graph_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
+	struct device *dev = simple_priv_to_dev(priv);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct device_node *top = dev->of_node;
 	struct device_node *ep = li->cpu ? cpu_ep : codec_ep;
 	struct device_node *port;
@@ -344,14 +320,14 @@ static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 	return 0;
 }
 
-static int graph_dai_link_of(struct graph_priv *priv,
+static int graph_dai_link_of(struct asoc_simple_priv *priv,
 			     struct device_node *cpu_ep,
 			     struct device_node *codec_ep,
 			     struct link_info *li)
 {
-	struct device *dev = graph_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
+	struct device *dev = simple_priv_to_dev(priv);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct device_node *top = dev->of_node;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
@@ -420,19 +396,19 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	return 0;
 }
 
-static int graph_for_each_link(struct graph_priv *priv,
+static int graph_for_each_link(struct asoc_simple_priv *priv,
 			struct link_info *li,
-			int (*func_noml)(struct graph_priv *priv,
+			int (*func_noml)(struct asoc_simple_priv *priv,
 					 struct device_node *cpu_ep,
 					 struct device_node *codec_ep,
 					 struct link_info *li),
-			int (*func_dpcm)(struct graph_priv *priv,
+			int (*func_dpcm)(struct asoc_simple_priv *priv,
 					 struct device_node *cpu_ep,
 					 struct device_node *codec_ep,
 					 struct link_info *li, int dup_codec))
 {
 	struct of_phandle_iterator it;
-	struct device *dev = graph_priv_to_dev(priv);
+	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *node = dev->of_node;
 	struct device_node *cpu_port;
 	struct device_node *cpu_ep;
@@ -488,9 +464,9 @@ static int graph_for_each_link(struct graph_priv *priv,
 	return 0;
 }
 
-static int graph_parse_of(struct graph_priv *priv)
+static int graph_parse_of(struct asoc_simple_priv *priv)
 {
-	struct snd_soc_card *card = graph_priv_to_card(priv);
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct link_info li;
 	int ret;
 
@@ -526,12 +502,12 @@ static int graph_parse_of(struct graph_priv *priv)
 	return asoc_simple_card_parse_card_name(card, NULL);
 }
 
-static int graph_count_noml(struct graph_priv *priv,
+static int graph_count_noml(struct asoc_simple_priv *priv,
 			    struct device_node *cpu_ep,
 			    struct device_node *codec_ep,
 			    struct link_info *li)
 {
-	struct device *dev = graph_priv_to_dev(priv);
+	struct device *dev = simple_priv_to_dev(priv);
 
 	li->link += 1; /* 1xCPU-Codec */
 	li->dais += 2; /* 1xCPU + 1xCodec */
@@ -541,13 +517,13 @@ static int graph_count_noml(struct graph_priv *priv,
 	return 0;
 }
 
-static int graph_count_dpcm(struct graph_priv *priv,
+static int graph_count_dpcm(struct asoc_simple_priv *priv,
 			    struct device_node *cpu_ep,
 			    struct device_node *codec_ep,
 			    struct link_info *li,
 			    int dup_codec)
 {
-	struct device *dev = graph_priv_to_dev(priv);
+	struct device *dev = simple_priv_to_dev(priv);
 
 	li->link++; /* 1xCPU-dummy */
 	li->dais++; /* 1xCPU */
@@ -563,10 +539,10 @@ static int graph_count_dpcm(struct graph_priv *priv,
 	return 0;
 }
 
-static void graph_get_dais_count(struct graph_priv *priv,
+static void graph_get_dais_count(struct asoc_simple_priv *priv,
 				 struct link_info *li)
 {
-	struct device *dev = graph_priv_to_dev(priv);
+	struct device *dev = simple_priv_to_dev(priv);
 
 	/*
 	 * link_num :	number of links.
@@ -623,7 +599,7 @@ static void graph_get_dais_count(struct graph_priv *priv,
 
 static int graph_card_probe(struct snd_soc_card *card)
 {
-	struct graph_priv *priv = snd_soc_card_get_drvdata(card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
@@ -639,9 +615,9 @@ static int graph_card_probe(struct snd_soc_card *card)
 
 static int graph_probe(struct platform_device *pdev)
 {
-	struct graph_priv *priv;
+	struct asoc_simple_priv *priv;
 	struct snd_soc_dai_link *dai_link;
-	struct graph_dai_props *dai_props;
+	struct simple_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
@@ -654,7 +630,7 @@ static int graph_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	card = graph_priv_to_card(priv);
+	card = simple_priv_to_card(priv);
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->dapm_widgets	= graph_dapm_widgets;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 77899624787e..628c19a3aaff 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -15,24 +15,6 @@
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
 
-struct simple_priv {
-	struct snd_soc_card snd_card;
-	struct simple_dai_props {
-		struct asoc_simple_dai *cpu_dai;
-		struct asoc_simple_dai *codec_dai;
-		struct snd_soc_dai_link_component codecs; /* single codec */
-		struct snd_soc_dai_link_component platforms;
-		struct asoc_simple_card_data adata;
-		struct snd_soc_codec_conf *codec_conf;
-		unsigned int mclk_fs;
-	} *dai_props;
-	struct asoc_simple_jack hp_jack;
-	struct asoc_simple_jack mic_jack;
-	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dais;
-	struct snd_soc_codec_conf *codec_conf;
-};
-
 struct link_info {
 	int dais; /* number of dai  */
 	int link; /* number of link */
@@ -40,11 +22,6 @@ struct link_info {
 	int cpu;  /* turn for CPU / Codec */
 };
 
-#define simple_priv_to_card(priv) (&(priv)->snd_card)
-#define simple_priv_to_props(priv, i) ((priv)->dai_props + (i))
-#define simple_priv_to_dev(priv) (simple_priv_to_card(priv)->dev)
-#define simple_priv_to_link(priv, i) (simple_priv_to_card(priv)->dai_link + (i))
-
 #define DAI	"sound-dai"
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
@@ -52,7 +29,7 @@ struct link_info {
 static int simple_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 	int ret;
@@ -71,7 +48,7 @@ static int simple_startup(struct snd_pcm_substream *substream)
 static void simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
@@ -101,7 +78,7 @@ static int simple_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 	unsigned int mclk, mclk_fs = 0;
@@ -144,7 +121,7 @@ static const struct snd_soc_ops simple_ops = {
 
 static int simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
@@ -164,7 +141,7 @@ static int simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				     struct snd_pcm_hw_params *params)
 {
-	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
@@ -207,7 +184,7 @@ static void simple_parse_mclk_fs(struct device_node *top,
 	of_node_put(node);
 }
 
-static int simple_dai_link_of_dpcm(struct simple_priv *priv,
+static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 				   struct device_node *np,
 				   struct device_node *codec,
 				   struct link_info *li,
@@ -336,7 +313,7 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 	return 0;
 }
 
-static int simple_dai_link_of(struct simple_priv *priv,
+static int simple_dai_link_of(struct asoc_simple_priv *priv,
 			      struct device_node *np,
 			      struct device_node *codec,
 			      struct link_info *li,
@@ -438,13 +415,13 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	return ret;
 }
 
-static int simple_for_each_link(struct simple_priv *priv,
+static int simple_for_each_link(struct asoc_simple_priv *priv,
 			struct link_info *li,
-			int (*func_noml)(struct simple_priv *priv,
+			int (*func_noml)(struct asoc_simple_priv *priv,
 					 struct device_node *np,
 					 struct device_node *codec,
 					 struct link_info *li, bool is_top),
-			int (*func_dpcm)(struct simple_priv *priv,
+			int (*func_dpcm)(struct asoc_simple_priv *priv,
 					 struct device_node *np,
 					 struct device_node *codec,
 					 struct link_info *li, bool is_top))
@@ -513,7 +490,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 }
 
 static int simple_parse_aux_devs(struct device_node *node,
-				 struct simple_priv *priv)
+				 struct asoc_simple_priv *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *aux_node;
@@ -543,7 +520,7 @@ static int simple_parse_aux_devs(struct device_node *node,
 	return 0;
 }
 
-static int simple_parse_of(struct simple_priv *priv)
+static int simple_parse_of(struct asoc_simple_priv *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
@@ -593,7 +570,7 @@ static int simple_parse_of(struct simple_priv *priv)
 	return ret;
 }
 
-static int simple_count_noml(struct simple_priv *priv,
+static int simple_count_noml(struct asoc_simple_priv *priv,
 			     struct device_node *np,
 			     struct device_node *codec,
 			     struct link_info *li, bool is_top)
@@ -605,7 +582,7 @@ static int simple_count_noml(struct simple_priv *priv,
 	return 0;
 }
 
-static int simple_count_dpcm(struct simple_priv *priv,
+static int simple_count_dpcm(struct asoc_simple_priv *priv,
 			     struct device_node *np,
 			     struct device_node *codec,
 			     struct link_info *li, bool is_top)
@@ -618,7 +595,7 @@ static int simple_count_dpcm(struct simple_priv *priv,
 	return 0;
 }
 
-static void simple_get_dais_count(struct simple_priv *priv,
+static void simple_get_dais_count(struct asoc_simple_priv *priv,
 				  struct link_info *li)
 {
 	struct device *dev = simple_priv_to_dev(priv);
@@ -687,7 +664,7 @@ static void simple_get_dais_count(struct simple_priv *priv,
 
 static int simple_soc_probe(struct snd_soc_card *card)
 {
-	struct simple_priv *priv = snd_soc_card_get_drvdata(card);
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, PREFIX);
@@ -703,7 +680,7 @@ static int simple_soc_probe(struct snd_soc_card *card)
 
 static int simple_probe(struct platform_device *pdev)
 {
-	struct simple_priv *priv;
+	struct asoc_simple_priv *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
-- 
2.20.1
