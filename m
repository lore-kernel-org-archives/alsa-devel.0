From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: use simple_dai_props"
	to the asoc tree
Date: Fri, 31 Aug 2018 16:38:26 +0100 (BST)
Message-ID: <20180831153826.9EA5E11226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01500267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:38:27 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: use simple_dai_props

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

>From 5ece10ab99205d11419e3d2e6c7ac0e382d952b5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:08:38 +0000
Subject: [PATCH] ASoC: simple-scu-card: use simple_dai_props

simple-card and simple-scu-card are very similar driver,
but using different feature. Thus we are keeping synchronization
on these 2 drivers style, because it is easy to confirm / check.

Current big difference between these 2 drivers are "dai_props" on
simple_card_data (= priv).
It will be difficult to keep synchronize if we will add new feature
on simple-scu-card. Thus, this patch synchronize it.

[simple]
struct simple_card_data {
	...
	struct simple_dai_props {
		...
	} *dai_props;
	...
};

[simple scu]
struct simple_card_data {
	...
	struct asoc_simple_dai *dai_props;
	...
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 16a83bc51e0e..09be02e7416f 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -22,7 +22,9 @@
 struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
-	struct asoc_simple_dai *dai_props;
+	struct simple_dai_props {
+		struct asoc_simple_dai dai;
+	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
 };
@@ -40,20 +42,20 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct asoc_simple_dai *dai_props =
+	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
-	return asoc_simple_card_clk_enable(dai_props);
+	return asoc_simple_card_clk_enable(&dai_props->dai);
 }
 
 static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct asoc_simple_dai *dai_props =
+	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(dai_props);
+	asoc_simple_card_clk_disable(&dai_props->dai);
 }
 
 static const struct snd_soc_ops asoc_simple_card_ops = {
@@ -66,7 +68,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dai_props;
+	struct simple_dai_props *dai_props;
 	int num = rtd->num;
 
 	dai_link	= simple_priv_to_link(priv, num);
@@ -75,7 +77,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				rtd->cpu_dai :
 				rtd->codec_dai;
 
-	return asoc_simple_card_init_dai(dai, dai_props);
+	return asoc_simple_card_init_dai(dai, &dai_props->dai);
 }
 
 static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -95,7 +97,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
-	struct asoc_simple_dai *dai_props = simple_priv_to_props(priv, idx);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	int ret;
 
@@ -116,7 +118,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, &dai_props->dai);
 		if (ret < 0)
 			return ret;
 
@@ -141,7 +143,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, &dai_props->dai);
 		if (ret < 0)
 			return ret;
 
@@ -157,7 +159,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 					      PREFIX "prefix");
 	}
 
-	ret = asoc_simple_card_of_parse_tdm(np, dai_props);
+	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
 	if (ret)
 		return ret;
 
@@ -230,7 +232,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dai_props;
+	struct simple_dai_props *dai_props;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-- 
2.19.0.rc1
