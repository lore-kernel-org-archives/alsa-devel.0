From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use defined dev on probe()" to the asoc tree
Date: Thu, 16 Mar 2017 14:11:08 +0000
Message-ID: <E1coW7Q-0002br-LZ@debutante>
References: <87lgs7cfvq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87lgs7cfvq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use defined dev on probe()

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

>From dcee9bfe8904518266c95d44a4f435a5f1fa59a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Mar 2017 04:43:21 +0000
Subject: [PATCH] ASoC: simple-card: use defined dev on probe()

Current asoc_simple_card_probe() already has dev definition,
but some place doesn't use it. Let's fix this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a385ff6bfa4b..9ad05e237ee0 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -418,8 +418,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	int num, ret;
 
 	/* Get the number of DAI links */
@@ -491,7 +491,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(&priv->snd_card, priv);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
+	ret = devm_snd_soc_register_card(dev, &priv->snd_card);
 	if (ret >= 0)
 		return ret;
 err:
-- 
2.11.0
