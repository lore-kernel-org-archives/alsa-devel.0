From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_init_dai()" to the asoc tree
Date: Tue, 09 Aug 2016 13:43:48 +0100
Message-ID: <E1bX6No-0003VX-U3@debutante>
References: <87twhtoxt0.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87twhtoxt0.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_init_dai()

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

>From 600ee2085515c03a7a4a6025034fefccf29e5a24 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Aug 2016 05:49:21 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_init_dai()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 82187e00eb12..1bf35634ebba 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -97,7 +97,6 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dai_props;
 	int num = rtd->num;
-	int ret;
 
 	dai_link	= rsrc_priv_to_link(priv, num);
 	dai_props	= rsrc_priv_to_props(priv, num);
@@ -105,30 +104,7 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				rtd->cpu_dai :
 				rtd->codec_dai;
 
-	if (dai_props->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, dai_props->sysclk, 0);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "set_sysclk error\n");
-			goto err;
-		}
-	}
-
-	if (dai_props->slots) {
-		ret = snd_soc_dai_set_tdm_slot(dai,
-					       dai_props->tx_slot_mask,
-					       dai_props->rx_slot_mask,
-					       dai_props->slots,
-					       dai_props->slot_width);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "set_tdm_slot error\n");
-			goto err;
-		}
-	}
-
-	ret = 0;
-
-err:
-	return ret;
+	return asoc_simple_card_init_dai(dai, dai_props);
 }
 
 static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.8.1
