From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_parse_daifmt()" to the asoc tree
Date: Fri, 01 Jul 2016 17:59:36 +0200
Message-ID: <E1bJ0qu-0006Uz-4G@finisterre>
References: <87fusyr45m.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fusyr45m.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_parse_daifmt()

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

>From d6a4a9a45d072e3a27ea6e5f98192d78be621a9c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Jun 2016 06:03:13 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_parse_daifmt()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig          |  1 +
 sound/soc/sh/rcar/rsrc-card.c | 38 ++++----------------------------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index c9902a6d6fa0..9311f119feb5 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -44,6 +44,7 @@ config SND_SOC_RCAR
 
 config SND_SOC_RSRC_CARD
 	tristate "Renesas Sampling Rate Convert Sound Card"
+	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables simple sound if you need sampling rate convert
 
diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 1bc7ecfc42a9..984d8fed0dbd 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -20,6 +20,7 @@
 #include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <sound/simple_card_utils.h>
 
 struct rsrc_card_of_data {
 	const char *prefix;
@@ -159,38 +160,6 @@ static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int rsrc_card_parse_daifmt(struct device_node *node,
-				  struct device_node *codec,
-				  struct rsrc_card_priv *priv,
-				  struct snd_soc_dai_link *dai_link,
-				  unsigned int *retfmt)
-{
-	struct device_node *bitclkmaster = NULL;
-	struct device_node *framemaster = NULL;
-	unsigned int daifmt;
-
-	daifmt = snd_soc_of_parse_daifmt(node, NULL,
-					 &bitclkmaster, &framemaster);
-	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
-
-	if (!bitclkmaster && !framemaster)
-		return -EINVAL;
-
-	if (codec == bitclkmaster)
-		daifmt |= (codec == framemaster) ?
-			SND_SOC_DAIFMT_CBM_CFM : SND_SOC_DAIFMT_CBM_CFS;
-	else
-		daifmt |= (codec == framemaster) ?
-			SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
-
-	of_node_put(bitclkmaster);
-	of_node_put(framemaster);
-
-	*retfmt = daifmt;
-
-	return 0;
-}
-
 static int rsrc_card_parse_links(struct device_node *np,
 				 struct rsrc_card_priv *priv,
 				 int idx, bool is_fe)
@@ -358,6 +327,7 @@ static int rsrc_card_dai_sub_link_of(struct device_node *node,
 static int rsrc_card_dai_link_of(struct device_node *node,
 				 struct rsrc_card_priv *priv)
 {
+	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link;
 	struct device_node *np;
 	unsigned int daifmt = 0;
@@ -370,8 +340,8 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 		dai_link = rsrc_priv_to_link(priv, i);
 
 		if (strcmp(np->name, "codec") == 0) {
-			ret = rsrc_card_parse_daifmt(node, np, priv,
-						     dai_link, &daifmt);
+			ret = asoc_simple_card_parse_daifmt(dev, node, np,
+							    NULL, &daifmt);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.8.1
