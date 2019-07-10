From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 4/4] ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()
Date: Wed, 10 Jul 2019 15:25:09 +0800
Message-ID: <1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn>
References: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

After calling of_node_put() on the node variable, it is still being
used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: a0c426fe1433 ("ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/generic/audio-graph-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 31fc83d..c8abb86 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,6 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
+	u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
@@ -83,8 +84,9 @@ static int graph_get_dai_id(struct device_node *ep)
 			return info.id;
 
 		node = of_get_parent(ep);
+		reg = of_get_property(node, "reg", NULL);
 		of_node_put(node);
-		if (of_get_property(node, "reg", NULL))
+		if (reg)
 			return info.port;
 	}
 	node = of_graph_get_port_parent(ep);
-- 
2.9.5
