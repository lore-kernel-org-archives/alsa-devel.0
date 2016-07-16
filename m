From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_parse_dailink_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:04:23 +0100
Message-ID: <E1bOOKV-0004us-T7@debutante>
References: <87wpkzlgu3.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wpkzlgu3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_parse_dailink_name()

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

>From 2e8d1c7d544089fe4894c504020d7ac7eb1de531 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:57:34 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_parse_dailink_name()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e3a32d340482..07469cd9272c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -319,7 +319,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device_node *cpu = NULL;
 	struct device_node *plat = NULL;
 	struct device_node *codec = NULL;
-	char *name;
 	char prop[128];
 	char *prefix = "";
 	int ret, cpu_args;
@@ -380,19 +379,13 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (!dai_link->platform_of_node)
 		dai_link->platform_of_node = dai_link->cpu_of_node;
 
-	/* DAI link name is created from CPU/CODEC dai name */
-	name = devm_kzalloc(dev,
-			    strlen(dai_link->cpu_dai_name)   +
-			    strlen(dai_link->codec_dai_name) + 2,
-			    GFP_KERNEL);
-	if (!name) {
-		ret = -ENOMEM;
+	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
+						"%s-%s",
+						dai_link->cpu_dai_name,
+						dai_link->codec_dai_name);
+	if (ret < 0)
 		goto dai_link_of_err;
-	}
 
-	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
-				dai_link->codec_dai_name);
-	dai_link->name = dai_link->stream_name = name;
 	dai_link->ops = &asoc_simple_card_ops;
 	dai_link->init = asoc_simple_card_dai_init;
 
-- 
2.8.1
