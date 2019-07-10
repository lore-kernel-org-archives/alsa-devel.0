From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:38 +0100 (BST)
Message-ID: <20190710153438.99AAED02D7C@fitzroy.sirena.org.uk>
References: <1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, cheng.shengyu@zte.com.cn, jonathanh@nvidia.com, kuninori.morimoto.gx@renesas.comKuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, tiwai@suse.com, wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()

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

>From c152f8491a8d9a4b25afd65a86eb5e55e2a8c380 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:09 +0800
Subject: [PATCH] ASoC: audio-graph-card: fix an use-after-free in
 graph_get_dai_id()

After calling of_node_put() on the node variable, it is still being
used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: a0c426fe1433 ("ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()")
Link: https://lore.kernel.org/r/1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index bddfcfd7bedf..343ede8042c3 100644
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
2.20.1
