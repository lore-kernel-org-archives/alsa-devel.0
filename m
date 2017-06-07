From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: remove duplicate parameter from asoc_simple_card_parse_of()" to the asoc tree
Date: Wed, 07 Jun 2017 20:31:33 +0100
Message-ID: <E1dIgg1-0003ay-QY@debutante>
References: <87wp8o3afb.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wp8o3afb.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: remove duplicate parameter from asoc_simple_card_parse_of()

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

>From d2fdcc285f8c79ab1a6d20e5196eb173a105b365 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Jun 2017 00:37:05 +0000
Subject: [PATCH] ASoC: simple-card: remove duplicate parameter from
 asoc_simple_card_parse_of()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 565d057f0d14..33ff487193f9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -356,12 +356,12 @@ static int asoc_simple_card_parse_aux_devs(struct device_node *node,
 	return 0;
 }
 
-static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct simple_card_data *priv)
+static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device_node *dai_link;
+	struct device_node *node = dev->of_node;
 	int ret;
 
 	if (!node)
@@ -460,7 +460,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	if (np && of_device_is_available(np)) {
 
-		ret = asoc_simple_card_parse_of(np, priv);
+		ret = asoc_simple_card_parse_of(priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "parse error %d\n", ret);
-- 
2.11.0
