From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 3/4] ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()
Date: Wed, 10 Jul 2019 15:25:08 +0800
Message-ID: <1562743509-30496-4-git-send-email-wen.yang99@zte.com.cn>
References: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

After calling of_node_put() on the ports, port, and node variables,
they are still being used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: dd98fbc558a0 ("ASoC: audio-graph-card: cleanup DAI link loop method - step1")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/generic/audio-graph-card.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 30a4e83..31fc83d 100644
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
2.9.5
