From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_parse_card_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:05:27 +0100
Message-ID: <E1bOOLX-0005Ef-JW@debutante>
References: <871t4xqch0.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871t4xqch0.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_parse_card_name()

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

>From 53ae918f117dbb86e7b872e3b7532839f752c895 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jul 2016 00:00:00 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_parse_card_name()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 239a13a30bed..fa37f842b62f 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -395,9 +395,6 @@ static int rsrc_card_parse_of(struct device_node *node,
 					       "audio-routing");
 	}
 
-	/* Parse the card name from DT */
-	snd_soc_of_parse_card_name(&priv->snd_card, "card-name");
-
 	/* sampling rate convert */
 	of_property_read_u32(node, "convert-rate", &priv->convert_rate);
 
@@ -413,8 +410,9 @@ static int rsrc_card_parse_of(struct device_node *node,
 	if (ret < 0)
 		return ret;
 
-	if (!priv->snd_card.name)
-		priv->snd_card.name = priv->snd_card.dai_link->name;
+	ret = asoc_simple_card_parse_card_name(&priv->snd_card, "card-");
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.8.1
