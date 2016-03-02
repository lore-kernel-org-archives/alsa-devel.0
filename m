From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: rcar: core: don't open code
	of_device_get_match_data()" to the asoc tree
Date: Wed, 02 Mar 2016 20:03:53 +0900
Message-ID: <E1ab4ZN-0005lq-B0@finisterre>
References: <1456850381-8621-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9CC261A06
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 12:04:02 +0100 (CET)
In-Reply-To: <1456850381-8621-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: rcar: core: don't open code of_device_get_match_data()

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

>From 6d8044b4ff305238503edca7d75f3ab7410396ba Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 1 Mar 2016 17:39:19 +0100
Subject: [PATCH] ASoC: sh: rcar: core: don't open code
 of_device_get_match_data()

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 21e13b3a356f..ba37b0d55b21 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1119,7 +1119,6 @@ static int rsnd_probe(struct platform_device *pdev)
 	struct rsnd_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct rsnd_dai *rdai;
-	const struct of_device_id *of_id = of_match_device(rsnd_of_match, dev);
 	int (*probe_func[])(struct rsnd_priv *priv) = {
 		rsnd_gen_probe,
 		rsnd_dma_probe,
@@ -1145,7 +1144,7 @@ static int rsnd_probe(struct platform_device *pdev)
 	}
 
 	priv->pdev	= pdev;
-	priv->flags	= (unsigned long)of_id->data;
+	priv->flags	= (unsigned long)of_device_get_match_data(dev);
 	spin_lock_init(&priv->lock);
 
 	/*
-- 
2.7.0
