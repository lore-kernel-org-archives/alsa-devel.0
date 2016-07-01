From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_parse_daifmt()" to the asoc tree
Date: Fri, 01 Jul 2016 17:59:41 +0200
Message-ID: <E1bJ0qz-0006Vp-KQ@finisterre>
References: <87vb0r9q5f.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vb0r9q5f.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_parse_daifmt()

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

>From cecdef3656956b0978bf86ecd1ce0542d2c61e97 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Jun 2016 06:02:46 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_parse_daifmt()

We can use simpel utils asoc_simple_card_parse_daifmt().
Let's use it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card.h       | 11 +---------
 include/sound/simple_card_utils.h | 10 +++++++++
 sound/soc/generic/Kconfig         |  1 +
 sound/soc/generic/simple-card.c   | 46 ++-------------------------------------
 4 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 0399352f3a62..a6a2e1547092 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -13,16 +13,7 @@
 #define __SIMPLE_CARD_H
 
 #include <sound/soc.h>
-
-struct asoc_simple_dai {
-	const char *name;
-	unsigned int sysclk;
-	int slots;
-	int slot_width;
-	unsigned int tx_slot_mask;
-	unsigned int rx_slot_mask;
-	struct clk *clk;
-};
+#include <sound/simple_card_utils.h>
 
 struct asoc_simple_card_info {
 	const char *name;
diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7acc798016e0..50aa7b22a94c 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -12,6 +12,16 @@
 
 #include <sound/soc.h>
 
+struct asoc_simple_dai {
+	const char *name;
+	unsigned int sysclk;
+	int slots;
+	int slot_width;
+	unsigned int tx_slot_mask;
+	unsigned int rx_slot_mask;
+	struct clk *clk;
+};
+
 int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *node,
 				  struct device_node *codec,
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 26c2fe6a0b93..c01c5dd68601 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -3,5 +3,6 @@ config SND_SIMPLE_CARD_UTILS
 
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
+	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables generic simple sound card support
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 8d0311ceded1..e3a32d340482 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -308,48 +308,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	return 0;
 }
 
-static int asoc_simple_card_parse_daifmt(struct device_node *node,
-					 struct simple_card_data *priv,
-					 struct device_node *codec,
-					 char *prefix, int idx)
-{
-	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
-	struct device *dev = simple_priv_to_dev(priv);
-	struct device_node *bitclkmaster = NULL;
-	struct device_node *framemaster = NULL;
-	unsigned int daifmt;
-
-	daifmt = snd_soc_of_parse_daifmt(node, prefix,
-					 &bitclkmaster, &framemaster);
-	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
-
-	if (strlen(prefix) && !bitclkmaster && !framemaster) {
-		/*
-		 * No dai-link level and master setting was not found from
-		 * sound node level, revert back to legacy DT parsing and
-		 * take the settings from codec node.
-		 */
-		dev_dbg(dev, "Revert to legacy daifmt parsing\n");
-
-		daifmt = snd_soc_of_parse_daifmt(codec, NULL, NULL, NULL) |
-			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
-	} else {
-		if (codec == bitclkmaster)
-			daifmt |= (codec == framemaster) ?
-				SND_SOC_DAIFMT_CBM_CFM : SND_SOC_DAIFMT_CBM_CFS;
-		else
-			daifmt |= (codec == framemaster) ?
-				SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
-	}
-
-	dai_link->dai_fmt = daifmt;
-
-	of_node_put(bitclkmaster);
-	of_node_put(framemaster);
-
-	return 0;
-}
-
 static int asoc_simple_card_dai_link_of(struct device_node *node,
 					struct simple_card_data *priv,
 					int idx,
@@ -386,8 +344,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 	}
 
-	ret = asoc_simple_card_parse_daifmt(node, priv,
-					    codec, prefix, idx);
+	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
+					    prefix, &dai_link->dai_fmt);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-- 
2.8.1
