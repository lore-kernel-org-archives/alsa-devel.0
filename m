From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_clean_reference()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:43 +0100
Message-ID: <E1bXZj5-0000NV-C3@debutante>
References: <87poshoxqx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87poshoxqx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_clean_reference()

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

>From 239486baee2bbefd81053cd4a168f90ce5c46fa2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:22:01 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_clean_reference()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index dd5eda1f9a29..16dc13e0bec9 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -333,21 +333,6 @@ static int rsrc_card_parse_of(struct device_node *node,
 	return 0;
 }
 
-/* Decrease the reference count of the device nodes */
-static int rsrc_card_unref(struct snd_soc_card *card)
-{
-	struct snd_soc_dai_link *dai_link;
-	int num_links;
-
-	for (num_links = 0, dai_link = card->dai_link;
-	     num_links < card->num_links;
-	     num_links++, dai_link++) {
-		of_node_put(dai_link->cpu_of_node);
-		of_node_put(dai_link->codec_of_node);
-	}
-	return 0;
-}
-
 static int rsrc_card_probe(struct platform_device *pdev)
 {
 	struct rsrc_card_priv *priv;
@@ -373,7 +358,7 @@ static int rsrc_card_probe(struct platform_device *pdev)
 	if (ret >= 0)
 		return ret;
 err:
-	rsrc_card_unref(&priv->snd_card);
+	asoc_simple_card_clean_reference(&priv->snd_card);
 
 	return ret;
 }
@@ -382,7 +367,7 @@ static int rsrc_card_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	return rsrc_card_unref(card);
+	return asoc_simple_card_clean_reference(card);
 }
 
 static struct platform_driver rsrc_card = {
-- 
2.8.1
