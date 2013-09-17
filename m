From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: omap-twl4030: Use
	devm_snd_soc_register_card
Date: Tue, 17 Sep 2013 09:53:59 +0530
Message-ID: <1379391839-8016-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B657261AF4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 06:42:19 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id kx10so6310764pab.27
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 21:42:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, sachin.kamat@linaro.org, broonie@kernel.org, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_card makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/omap/omap-twl4030.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 2a9324f..6a8d6b5 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -338,9 +338,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
 			ret);
 		return ret;
 	}
@@ -357,7 +357,6 @@ static int omap_twl4030_remove(struct platform_device *pdev)
 		snd_soc_jack_free_gpios(&priv->hs_jack,
 					ARRAY_SIZE(hs_jack_gpios),
 					hs_jack_gpios);
-	snd_soc_unregister_card(card);
 
 	return 0;
 }
-- 
1.7.9.5
