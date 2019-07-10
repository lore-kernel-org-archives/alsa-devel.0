From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:41 +0100 (BST)
Message-ID: <20190710153441.2A25DD02D7C@fitzroy.sirena.org.uk>
References: <1562743509-30496-4-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562743509-30496-4-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, cheng.shengyu@zte.com.cn, jonathanh@nvidia.com, kuninori.morimoto.gx@renesas.comKuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, tiwai@suse.com, wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()

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

>From aa2e362cb6b3f5ca88093ada01e1a0ace8a517b2 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:08 +0800
Subject: [PATCH] ASoC: audio-graph-card: fix use-after-free in
 graph_dai_link_of_dpcm()

After calling of_node_put() on the ports, port, and node variables,
they are still being used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: dd98fbc558a0 ("ASoC: audio-graph-card: cleanup DAI link loop method - step1")
Link: https://lore.kernel.org/r/1562743509-30496-4-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index e438011f5e45..bddfcfd7bedf 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -208,10 +208,6 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	dev_dbg(dev, "link_of DPCM (%pOF)\n", ep);
 
-	of_node_put(ports);
-	of_node_put(port);
-	of_node_put(node);
-
 	if (li->cpu) {
 		int is_single_links = 0;
 
@@ -229,17 +225,17 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_cpu(ep, dai_link, &is_single_links);
 		if (ret)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_cpu(dev, ep, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
 						   cpus->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		/* card->num_links includes Codec */
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
@@ -263,17 +259,17 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_codec(ep, dai_link);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_codec(dev, ep, dai_link, dai);
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
@@ -293,19 +289,23 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_parse_tdm(ep, dai);
 	if (ret)
-		return ret;
+		goto out_put_node;
 
 	ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
 				       NULL, &dai_link->dai_fmt);
 	if (ret < 0)
-		return ret;
+		goto out_put_node;
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &graph_ops;
 	dai_link->init			= asoc_simple_dai_init;
 
-	return 0;
+out_put_node:
+	of_node_put(ports);
+	of_node_put(port);
+	of_node_put(node);
+	return ret;
 }
 
 static int graph_dai_link_of(struct asoc_simple_priv *priv,
-- 
2.20.1
