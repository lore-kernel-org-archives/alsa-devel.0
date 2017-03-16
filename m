From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: use defined dev on probe()" to the asoc tree
Date: Thu, 16 Mar 2017 14:11:05 +0000
Message-ID: <E1coW7N-0002ay-Fc@debutante>
References: <87k27rcfv9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k27rcfv9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: use defined dev on probe()

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

>From 40b68dac75a1d16266d3c89244ccf7b899afac3e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Mar 2017 04:43:40 +0000
Subject: [PATCH] ASoC: simple-scu-card: use defined dev on probe()

Current asoc_simple_card_probe() already has dev definition,
but some place doesn't use it. Let's fix this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index bb86ee042490..93d7d8980cd5 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -257,7 +257,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dai_props;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	int num, ret;
 
 	/* Allocate the private data */
@@ -292,7 +292,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(&priv->snd_card, priv);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
+	ret = devm_snd_soc_register_card(dev, &priv->snd_card);
 	if (ret >= 0)
 		return ret;
 err:
-- 
2.11.0
