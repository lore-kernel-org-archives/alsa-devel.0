From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 04/14] ASoC: wm8993: Use devm_regulator_bulk_get
Date: Mon, 26 Nov 2012 17:19:37 +0530
Message-ID: <1353930587-12907-5-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B8182650CA
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:27 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so5190394pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:27 -0800 (PST)
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
 sound/soc/codecs/wm8993.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 94737a3..c3d3107 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1672,7 +1672,7 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(wm8993->supplies); i++)
 		wm8993->supplies[i].supply = wm8993_supply_names[i];
 
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8993->supplies),
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8993->supplies),
 				 wm8993->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
@@ -1683,7 +1683,7 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 				    wm8993->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
+		goto err;
 	}
 
 	ret = regmap_read(wm8993->regmap, WM8993_SOFTWARE_RESET, &reg);
@@ -1742,8 +1742,6 @@ err_irq:
 		free_irq(i2c->irq, wm8993);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 err:
 	regmap_exit(wm8993->regmap);
 	return ret;
@@ -1758,7 +1756,6 @@ static __devexit int wm8993_i2c_remove(struct i2c_client *i2c)
 		free_irq(i2c->irq, wm8993);
 	regmap_exit(wm8993->regmap);
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 
 	return 0;
 }
-- 
1.7.4.1
