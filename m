From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share same dev_dbg() for Card Name" to the asoc tree
Date: Tue, 06 Jun 2017 20:06:05 +0100
Message-ID: <E1dIJnp-0007CX-2F@debutante>
References: <87efuzdpws.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87efuzdpws.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: share same dev_dbg() for Card Name

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

>From d4dbcb63c8bde48741468cf7c711b76ed3e7fce5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 5 Jun 2017 04:27:56 +0000
Subject: [PATCH] ASoC: simple-card-utils: share same dev_dbg() for Card Name

Let's share same debug message for Card Name

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 2 --
 sound/soc/generic/simple-card-utils.c    | 2 ++
 sound/soc/generic/simple-scu-card.c      | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index c5c52d1f500c..1ce727b6bc21 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -295,8 +295,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret)
 		goto parse_of_err;
 
-	dev_dbg(dev, "New card: %s\n",
-		card->name ? card->name : "");
 	dev_dbg(dev, "convert_rate     %d\n", priv->convert_rate);
 	dev_dbg(dev, "convert_channels %d\n", priv->convert_channels);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 9c7f5b91b90a..da24ac171aec 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -100,6 +100,8 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 	if (!card->name && card->dai_link)
 		card->name = card->dai_link->name;
 
+	dev_dbg(card->dev, "Card Name: %s\n", card->name ? card->name : "");
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 9b9b01e12149..5f4384f322c1 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -246,8 +246,6 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(dev, "New card: %s\n",
-		card->name ? card->name : "");
 	dev_dbg(dev, "convert_rate     %d\n", priv->convert_rate);
 	dev_dbg(dev, "convert_channels %d\n", priv->convert_channels);
 
-- 
2.11.0
