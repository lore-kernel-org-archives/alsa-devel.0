From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] ASoC: sh: rcar: core: don't open code of_device_get_match_data()
Date: Tue,  1 Mar 2016 17:39:19 +0100
Message-ID: <1456850381-8621-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Compile tested only. I am on the road and can't test the multimedia drivers
because of no cables :( If someone could test it, that would be much
appreciated. Or I'll do it next week. The pattern worked for other drivers
I could actually test, though.

 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5227aad43e3854..3dae30710c34f2 100644
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
