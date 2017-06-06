From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share same dev_dbg() for Dai Name" to the asoc tree
Date: Tue, 06 Jun 2017 20:05:57 +0100
Message-ID: <E1dIJnh-0007Ao-1c@debutante>
References: <87bmq3dpvt.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87bmq3dpvt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: share same dev_dbg() for Dai Name

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

>From 4579771ebb78aa26831ee3d9617690da5198072c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 5 Jun 2017 04:28:29 +0000
Subject: [PATCH] ASoC: simple-card-utils: share same dev_dbg() for Dai Name

Let's share same debug message for DAI Name

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c  | 1 -
 sound/soc/generic/simple-card-utils.c | 2 ++
 sound/soc/generic/simple-card.c       | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1769a39a22c4..2c3a1cc01442 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -169,7 +169,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	dai_link->ops = &asoc_graph_card_ops;
 	dai_link->init = asoc_graph_card_dai_init;
 
-	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
 	dev_dbg(dev, "\tcpu : %s / %d\n",
 		dai_link->cpu_dai_name,
 		cpu_dai->sysclk);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 59e770125596..1f08064f65b1 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -74,6 +74,8 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
 
 		dai_link->name		= name;
 		dai_link->stream_name	= name;
+
+		dev_dbg(dev, "name : %s\n", name);
 	}
 
 	return ret;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d364f08a7182..1da0e2b068c3 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -301,7 +301,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	dai_link->ops = &asoc_simple_card_ops;
 	dai_link->init = asoc_simple_card_dai_init;
 
-	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
 	dev_dbg(dev, "\tcpu : %s / %d\n",
 		dai_link->cpu_dai_name,
 		dai_props->cpu_dai.sysclk);
-- 
2.11.0
