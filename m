From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: use asoc_simple_card_of_parse_tdm()" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:27 +0100
Message-ID: <E1dL5Hn-0007aH-UF@debutante>
References: <87a85b9zsz.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a85b9zsz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: use asoc_simple_card_of_parse_tdm()

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

>From 77b713b52878fbe21d9d5339cc42fbec3202392e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jun 2017 00:35:13 +0000
Subject: [PATCH] ASoC: simple-scu-card: use asoc_simple_card_of_parse_tdm()

Current simple card drivers are using asoc_simple_dai's tx_slot_mask,
rx_slot_mask, slots, slot_width directly to parse TDM.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_of_parse_tdm for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index f203783b2fad..938f3f30eef1 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -171,11 +171,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 					      PREFIX "prefix");
 	}
 
-	ret = snd_soc_of_parse_tdm_slot(np,
-					&dai_props->tx_slot_mask,
-					&dai_props->rx_slot_mask,
-					&dai_props->slots,
-					&dai_props->slot_width);
+	ret = asoc_simple_card_of_parse_tdm(np, dai_props);
 	if (ret)
 		return ret;
 
-- 
2.11.0
