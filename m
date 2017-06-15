From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: use asoc_simple_card_of_parse_routing()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:33 +0100
Message-ID: <E1dLYRd-0001eP-6e@debutante>
References: <87shj2m78z.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shj2m78z.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: use asoc_simple_card_of_parse_routing()

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

>From 9fb9b2f236f05168a6138e62c82124a2f5eaf320 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:25:51 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: use
 asoc_simple_card_of_parse_routing()

Current simple/audio scu card drivers are supporting same
routing on DT, but, doesn't use same function for it.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_of_parse_routing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 9502f6ed14b8..05934b24627b 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -195,8 +195,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	 * see simple-card
 	 */
 
-	ret = snd_soc_of_parse_audio_routing(card, "routing");
-	if (ret)
+	ret = asoc_simple_card_of_parse_routing(card, NULL, 0);
+	if (ret < 0)
 		return ret;
 
 	asoc_simple_card_parse_convert(dev, NULL, &priv->adata);
-- 
2.11.0
