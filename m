From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: fix use-after-free in graph_for_each_link" to the asoc tree
Date: Thu,  4 Jul 2019 13:24:53 +0100 (BST)
Message-ID: <20190704122453.A6900274389A@ypsilon.sirena.org.uk>
References: <1562229530-8121-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562229530-8121-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: alsa-devel@alsa-project.org, cheng.shengyu@zte.com.cn, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: fix use-after-free in graph_for_each_link

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 1bcc1fd64e4dd903f4d868a9e053986e3b102713 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Thu, 4 Jul 2019 16:38:50 +0800
Subject: [PATCH] ASoC: audio-graph-card: fix use-after-free in
 graph_for_each_link

After calling of_node_put() on the codec_ep and codec_port variables,
they are still being used, which may result in use-after-free.
We fix this issue by calling of_node_put() after the last usage.

Fixes: fce9b90c1ab7 ("ASoC: audio-graph-card: cleanup DAI link loop method - step2")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/1562229530-8121-1-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index ec7e673ba475..70ed28d97d49 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -435,9 +435,6 @@ static int graph_for_each_link(struct asoc_simple_priv *priv,
 			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 			codec_port = of_get_parent(codec_ep);
 
-			of_node_put(codec_ep);
-			of_node_put(codec_port);
-
 			/* get convert-xxx property */
 			memset(&adata, 0, sizeof(adata));
 			graph_parse_convert(dev, codec_ep, &adata);
@@ -457,6 +454,9 @@ static int graph_for_each_link(struct asoc_simple_priv *priv,
 			else
 				ret = func_noml(priv, cpu_ep, codec_ep, li);
 
+			of_node_put(codec_ep);
+			of_node_put(codec_port);
+
 			if (ret < 0)
 				return ret;
 
-- 
2.20.1
