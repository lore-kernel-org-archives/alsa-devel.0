From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Message-ID: <20190710153449.1B853D02D7C@fitzroy.sirena.org.uk>
References: <1562743509-30496-2-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562743509-30496-2-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, cheng.shengyu@zte.com.cn, jonathanh@nvidia.com, kuninori.morimoto.gx@renesas.comKuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, tiwai@suse.com, wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()

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

>From 724808ad556c15e9473418d082f8aae81dd267f6 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:06 +0800
Subject: [PATCH] ASoC: simple-card: fix an use-after-free in
 simple_dai_link_of_dpcm()

The node variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: cfc652a73331 ("ASoC: simple-card: tidyup prefix for snd_soc_codec_conf")
Link: https://lore.kernel.org/r/1562743509-30496-2-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e5cde0d5e63c..4117e54884e5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -124,8 +124,6 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	li->link++;
 
-	of_node_put(node);
-
 	/* For single DAI link & old style of DT node */
 	if (is_top)
 		prefix = PREFIX;
@@ -147,17 +145,17 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_cpu(np, dai_link, &is_single_links);
 		if (ret)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_cpu(dev, np, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
 						   cpus->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
@@ -180,17 +178,17 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_codec(np, dai_link);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_codec(dev, np, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "be.%s",
 						   codecs->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		/* check "prefix" from top node */
 		snd_soc_of_parse_node_prefix(top, cconf, codecs->of_node,
@@ -208,19 +206,21 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_parse_tdm(np, dai);
 	if (ret)
-		return ret;
+		goto out_put_node;
 
 	ret = asoc_simple_parse_daifmt(dev, node, codec,
 				       prefix, &dai_link->dai_fmt);
 	if (ret < 0)
-		return ret;
+		goto out_put_node;
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &simple_ops;
 	dai_link->init			= asoc_simple_dai_init;
 
-	return 0;
+out_put_node:
+	of_node_put(node);
+	return ret;
 }
 
 static int simple_dai_link_of(struct asoc_simple_priv *priv,
-- 
2.20.1
