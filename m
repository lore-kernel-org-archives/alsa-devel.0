From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: tidyup return method from probe()" to the asoc tree
Date: Fri, 19 May 2017 18:04:15 +0100
Message-ID: <E1dBlK3-0003is-LC@debutante>
References: <87pof53bx6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87pof53bx6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>Dan Carpenter <dan.carpenter@oracle.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: tidyup return method from probe()

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

>From c73df77d72de28ad72973d3c3103a5361e1440fb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 May 2017 00:57:44 +0000
Subject: [PATCH] ASoC: simple-scu-card: tidyup return method from probe()

Current return method from probe() is very confusable.
This patch tidyup it to normal return method

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index dcbcab230d1b..9b9b01e12149 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -298,8 +298,10 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(dev, card);
-	if (ret >= 0)
-		return ret;
+	if (ret < 0)
+		goto err;
+
+	return 0;
 err:
 	asoc_simple_card_clean_reference(card);
 
-- 
2.11.0
