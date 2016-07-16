From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_parse_card_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:03:20 +0100
Message-ID: <E1bOOJU-0004sJ-Fp@debutante>
References: <87oa7mr49t.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87oa7mr49t.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_parse_card_name()

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

>From 3527d85b85e65401b7d93073b3ab4e687cdd2521 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:59:40 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_parse_card_name()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 07469cd9272c..43295f024982 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -427,9 +427,6 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (!node)
 		return -EINVAL;
 
-	/* Parse the card name from DT */
-	snd_soc_of_parse_card_name(&priv->snd_card, PREFIX "name");
-
 	/* The off-codec widgets */
 	if (of_property_read_bool(node, PREFIX "widgets")) {
 		ret = snd_soc_of_parse_audio_simple_widgets(&priv->snd_card,
@@ -451,9 +448,6 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (ret == 0)
 		priv->mclk_fs = val;
 
-	dev_dbg(dev, "New simple-card: %s\n", priv->snd_card.name ?
-		priv->snd_card.name : "");
-
 	/* Single/Muti DAI link(s) & New style of DT node */
 	if (of_get_child_by_name(node, PREFIX "dai-link")) {
 		struct device_node *np = NULL;
@@ -476,8 +470,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
-	if (!priv->snd_card.name)
-		priv->snd_card.name = priv->snd_card.dai_link->name;
+	ret = asoc_simple_card_parse_card_name(&priv->snd_card, PREFIX);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.8.1
