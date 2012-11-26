From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 02/14] ASoC: wm8962: Use devm_regulator_bulk_get
Date: Mon, 26 Nov 2012 17:19:35 +0530
Message-ID: <1353930587-12907-3-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CCFBC2650A4
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:20 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:20 -0800 (PST)
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

devm_regulator_bulk_get() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8962.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ce67200..285a9ef 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3610,7 +3610,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		wm8962->supplies[i].supply = wm8962_supply_names[i];
 
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8962->supplies),
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8962->supplies),
 				 wm8962->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
@@ -3621,7 +3621,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 				    wm8962->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
+		return ret;
 	}
 
 	wm8962->regmap = regmap_init_i2c(i2c, &wm8962_regmap);
@@ -3697,8 +3697,6 @@ err_regmap:
 	regmap_exit(wm8962->regmap);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 err:
 	return ret;
 }
@@ -3709,7 +3707,6 @@ static __devexit int wm8962_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(wm8962->regmap);
-	regulator_bulk_free(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 	return 0;
 }
 
-- 
1.7.4.1
