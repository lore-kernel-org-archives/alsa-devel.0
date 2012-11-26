From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 13/14] ASoC: wm8993: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:46 +0530
Message-ID: <1353930587-12907-14-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AD631265172
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:57 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4983511pad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:57 -0800 (PST)
In-Reply-To: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_regmap_init_i2c() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8993.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index c3d3107..347a359 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1660,7 +1660,7 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	wm8993->dev = &i2c->dev;
 	init_completion(&wm8993->fll_lock);
 
-	wm8993->regmap = regmap_init_i2c(i2c, &wm8993_regmap);
+	wm8993->regmap = devm_regmap_init_i2c(i2c, &wm8993_regmap);
 	if (IS_ERR(wm8993->regmap)) {
 		ret = PTR_ERR(wm8993->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
@@ -1676,14 +1676,14 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 				 wm8993->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
 				    wm8993->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regmap_read(wm8993->regmap, WM8993_SOFTWARE_RESET, &reg);
@@ -1742,8 +1742,6 @@ err_irq:
 		free_irq(i2c->irq, wm8993);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-err:
-	regmap_exit(wm8993->regmap);
 	return ret;
 }
 
@@ -1754,7 +1752,6 @@ static __devexit int wm8993_i2c_remove(struct i2c_client *i2c)
 	snd_soc_unregister_codec(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm8993);
-	regmap_exit(wm8993->regmap);
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 
 	return 0;
-- 
1.7.4.1
