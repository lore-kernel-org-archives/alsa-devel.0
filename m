From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_routing" to the asoc tree
Date: Fri, 11 Nov 2016 15:29:11 +0000
Message-ID: <E1c5DlP-0002Be-69@finisterre>
References: <87k2d74c43.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k2d74c43.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Guennadi <g.liakhovetski@gmx.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_routing

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

>From 7364c8dc255232db33bcd1c5b19eb8f34cf6108a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2016 01:18:35 +0000
Subject: [PATCH] ASoC: soc-core: adjust for graph on
 snd_soc_of_parse_audio_routing

It is assuming that the card related information is located on
"card" node, but graph case doesn't have it.
This patch adds node parameter to adjust for graph support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 9 +++++++--
 sound/soc/soc-core.c | 9 ++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f1c784e44f6..148bf553d598 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1655,8 +1655,13 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
-int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
-				   const char *propname);
+
+#define snd_soc_of_parse_audio_routing(card, propname) \
+	snd_soc_of_parse_audio_routing_from_node(card, NULL, propname)
+int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
+					     struct device_node *np,
+					     const char *propname);
+
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd903261..ec881b8825b6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3615,14 +3615,17 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
 
-int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
+int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
+				   struct device_node *np,
 				   const char *propname)
 {
-	struct device_node *np = card->dev->of_node;
 	int num_routes;
 	struct snd_soc_dapm_route *routes;
 	int i, ret;
 
+	if (!np)
+		np = card->dev->of_node;
+
 	num_routes = of_property_count_strings(np, propname);
 	if (num_routes < 0 || num_routes & 1) {
 		dev_err(card->dev,
@@ -3669,7 +3672,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing_from_node);
 
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
-- 
2.10.2
