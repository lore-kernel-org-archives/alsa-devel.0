From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: add EXPORT_SYMBOL_GPL() for asoc_simple_card_clk_xxx()" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:59 +0100
Message-ID: <E1dL5IJ-0007hL-Ux@debutante>
References: <8737b39ygm.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737b39ygm.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple_card_utils: add EXPORT_SYMBOL_GPL() for asoc_simple_card_clk_xxx()

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

>From 63a5f59208bce7110596b09950f48bf07b8baeb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jun 2017 01:04:11 +0000
Subject: [PATCH] ASoC: simple_card_utils: add EXPORT_SYMBOL_GPL() for
 asoc_simple_card_clk_xxx()

commit 891caea41746 ("ASoC: simple_card_utils:
add asoc_simple_card_clk_xxx()") added new asoc_simple_card_clk_xxx(),
but, it didn't have EXPORT_SYMBOL_GPL().
This patch adds it. Otherwise, we will get below error

ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simple-scu-card.ko] undefined!
ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simple-scu-card.ko] undefined!
ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-simple-card.ko] undefined!
ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-simple-card.ko] undefined!
ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio-graph-scu-card.ko] undefined!
ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audio-graph-scu-card.ko] undefined!
ERROR: "asoc_simple_card_clk_enable" [sound/soc/generic/snd-soc-audio-graph-card.ko] undefined!
ERROR: "asoc_simple_card_clk_disable" [sound/soc/generic/snd-soc-audio-graph-card.ko] undefined!

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index beb4e3817d22..2ad7633292bf 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -120,11 +120,13 @@ int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
 	return clk_prepare_enable(dai->clk);
 }
+EXPORT_SYMBOL_GPL(asoc_simple_card_clk_enable);
 
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
 {
 	clk_disable_unprepare(dai->clk);
 }
+EXPORT_SYMBOL_GPL(asoc_simple_card_clk_disable);
 
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
-- 
2.11.0
