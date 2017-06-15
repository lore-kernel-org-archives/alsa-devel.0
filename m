From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_of_parse_routing()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:39 +0100
Message-ID: <E1dLYRj-0001gW-Au@debutante>
References: <87vanym79w.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vanym79w.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_of_parse_routing()

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

>From 1fdb5d258e28de85263a34aab57f0a70b1715342 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:25:17 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_of_parse_routing()

Current simple/audio scu card drivers are supporting same
routing on DT, but, doesn't use same function for it.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_of_parse_routing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 8b414af966ee..7b2533c7f82e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -362,13 +362,9 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 			goto card_parse_end;
 	}
 
-	/* DAPM routes */
-	if (of_property_read_bool(node, PREFIX "routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-					PREFIX "routing");
-		if (ret)
-			goto card_parse_end;
-	}
+	ret = asoc_simple_card_of_parse_routing(card, PREFIX, 1);
+	if (ret < 0)
+		goto card_parse_end;
 
 	/* Factor to mclk, used in hw_params() */
 	of_property_read_u32(node, PREFIX "mclk-fs", &priv->mclk_fs);
-- 
2.11.0
