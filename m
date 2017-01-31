From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove OF adjusting for
	snd_soc_of_parse_audio_routing" to the asoc tree
Date: Tue, 31 Jan 2017 20:02:32 +0000
Message-ID: <E1cYedM-0005bg-Hm@debutante>
References: <87d1f9qadv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4C1C2673A2
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:42 +0100 (CET)
In-Reply-To: <87d1f9qadv.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux-DT <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_routing

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

>From 2bc644af610f28d05812f224636a95a57c2631d1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Jan 2017 06:36:50 +0000
Subject: [PATCH] ASoC: soc-core: remove OF adjusting for
 snd_soc_of_parse_audio_routing

Because prototype of OF-graph sound card support didn't have Sound Card
node, commit 7364c8dc255232db33bcd1c5b19eb8f34cf6108a
("ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_routing")
adjusted to it on each functions.

But final discussion result of ALSA SoC / OF-graph ML, OF-graph sound
card has node. Thus, this commit became no longer needed.

This reverts commit 7364c8dc255232db33bcd1c5b19eb8f34cf6108a.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 9 ++-------
 sound/soc/soc-core.c | 9 +++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2b502f6cc6d0..838e03778b58 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1668,13 +1668,8 @@ void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
-
-#define snd_soc_of_parse_audio_routing(card, propname) \
-	snd_soc_of_parse_audio_routing_from_node(card, NULL, propname)
-int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
-					     struct device_node *np,
-					     const char *propname);
-
+int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
+				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f1901bb1466e..e30984fd649b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3690,17 +3690,14 @@ void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix_from_node);
 
-int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
-				   struct device_node *np,
+int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
 {
+	struct device_node *np = card->dev->of_node;
 	int num_routes;
 	struct snd_soc_dapm_route *routes;
 	int i, ret;
 
-	if (!np)
-		np = card->dev->of_node;
-
 	num_routes = of_property_count_strings(np, propname);
 	if (num_routes < 0 || num_routes & 1) {
 		dev_err(card->dev,
@@ -3747,7 +3744,7 @@ int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing_from_node);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
 
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
-- 
2.11.0
