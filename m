From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_clean_reference()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:46 +0100
Message-ID: <E1bXZj8-0000OL-9N@debutante>
References: <87a8jlqco1.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a8jlqco1.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_clean_reference()

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

>From 885fc0595a3e91ed7b6f78ea419952345be0222b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:21:42 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_clean_reference()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 64896e361bde..55638a800f20 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -378,21 +378,6 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	return 0;
 }
 
-/* Decrease the reference count of the device nodes */
-static int asoc_simple_card_unref(struct snd_soc_card *card)
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
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
@@ -478,7 +463,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		return ret;
 
 err:
-	asoc_simple_card_unref(&priv->snd_card);
+	asoc_simple_card_clean_reference(&priv->snd_card);
 	return ret;
 }
 
@@ -490,7 +475,7 @@ static int asoc_simple_card_remove(struct platform_device *pdev)
 	asoc_simple_card_remove_jack(&priv->hp_jack);
 	asoc_simple_card_remove_jack(&priv->mic_jack);
 
-	return asoc_simple_card_unref(card);
+	return asoc_simple_card_clean_reference(card);
 }
 
 static const struct of_device_id asoc_simple_of_match[] = {
-- 
2.8.1
