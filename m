From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share same dev_dbg() for DAI format" to the asoc tree
Date: Tue, 06 Jun 2017 20:06:00 +0100
Message-ID: <E1dIJnk-0007Bf-Qu@debutante>
References: <87d1ajdpwb.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1ajdpwb.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: share same dev_dbg() for DAI format

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

>From aaad9c131b8fcdb493ed64e56cea8ea52977e091 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 5 Jun 2017 04:28:12 +0000
Subject: [PATCH] ASoC: simple-card-utils: share same dev_dbg() for DAI format

Let's share same debug message for DAI format

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c  | 1 -
 sound/soc/generic/simple-card-utils.c | 2 ++
 sound/soc/generic/simple-card.c       | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 93c167a91d2d..1769a39a22c4 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -170,7 +170,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	dai_link->init = asoc_graph_card_dai_init;
 
 	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
-	dev_dbg(dev, "\tformat : %04x\n", dai_link->dai_fmt);
 	dev_dbg(dev, "\tcpu : %s / %d\n",
 		dai_link->cpu_dai_name,
 		cpu_dai->sysclk);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index da24ac171aec..59e770125596 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -51,6 +51,8 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 
 	*retfmt = daifmt;
 
+	dev_dbg(dev, "format : %04x\n", daifmt);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_daifmt);
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4dacaf78a0de..d364f08a7182 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -302,7 +302,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	dai_link->init = asoc_simple_card_dai_init;
 
 	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
-	dev_dbg(dev, "\tformat : %04x\n", dai_link->dai_fmt);
 	dev_dbg(dev, "\tcpu : %s / %d\n",
 		dai_link->cpu_dai_name,
 		dai_props->cpu_dai.sysclk);
-- 
2.11.0
