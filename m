From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: remove duplicate paramera from asoc_simple_card_parse_of" to the asoc tree
Date: Wed, 07 Jun 2017 20:31:22 +0100
Message-ID: <E1dIgfq-0003Zq-Kn@debutante>
References: <87vao83aeo.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87vao83aeo.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: remove duplicate paramera from asoc_simple_card_parse_of

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

>From 0d6b35212b451d4ac0c07c7b2b15b20ea763df5c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Jun 2017 00:37:30 +0000
Subject: [PATCH] ASoC: simple-scu-card: remove duplicate paramera from
 asoc_simple_card_parse_of

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 9a251400685e..5faf5d6c48a2 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -192,13 +192,13 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 	return 0;
 }
 
-static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct simple_card_data *priv)
+static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *np;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
+	struct device_node *node = dev->of_node;
 	unsigned int daifmt = 0;
 	bool is_fe;
 	int ret, i;
@@ -281,7 +281,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->codec_conf	= &priv->codec_conf;
 	card->num_configs	= 1;
 
-	ret = asoc_simple_card_parse_of(np, priv);
+	ret = asoc_simple_card_parse_of(priv);
 	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "parse error %d\n", ret);
-- 
2.11.0
