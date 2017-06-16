From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_of_parse_widgets()" to the asoc tree
Date: Fri, 16 Jun 2017 18:50:13 +0100
Message-ID: <E1dLvNt-0005j2-8V@debutante>
References: <87h8zgiumc.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8zgiumc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_of_parse_widgets()

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

>From fa2760dd366c735637504d1d7efab7688391c6b4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jun 2017 01:39:11 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_of_parse_widgets()

Current simple card driver is supporting widgets on DT,
other simple/audio card drivers will support it.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_of_parse_widgets

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7b2533c7f82e..8b7b47251fe1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -354,13 +354,9 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 	dai_link = of_get_child_by_name(node, PREFIX "dai-link");
 
-	/* The off-codec widgets */
-	if (of_property_read_bool(node, PREFIX "widgets")) {
-		ret = snd_soc_of_parse_audio_simple_widgets(card,
-					PREFIX "widgets");
-		if (ret)
-			goto card_parse_end;
-	}
+	ret = asoc_simple_card_of_parse_widgets(card, PREFIX);
+	if (ret < 0)
+		goto card_parse_end;
 
 	ret = asoc_simple_card_of_parse_routing(card, PREFIX, 1);
 	if (ret < 0)
-- 
2.11.0
