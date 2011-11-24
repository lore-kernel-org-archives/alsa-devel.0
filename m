From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use devm_kzalloc() in wm5100
Date: Thu, 24 Nov 2011 18:04:30 +0000
Message-ID: <1322157870-2162-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 388DB103B5B
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 19:04:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 46aca14..a9d5ac0 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2743,7 +2743,8 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	unsigned int reg;
 	int ret, i;
 
-	wm5100 = kzalloc(sizeof(struct wm5100_priv), GFP_KERNEL);
+	wm5100 = devm_kzalloc(&i2c->dev, sizeof(struct wm5100_priv),
+			      GFP_KERNEL);
 	if (wm5100 == NULL)
 		return -ENOMEM;
 
@@ -2752,7 +2753,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(wm5100->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err_alloc;
+		goto err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm5100->fll); i++)
@@ -2910,8 +2911,7 @@ err_core:
 			    wm5100->core_supplies);
 err_regmap:
 	regmap_exit(wm5100->regmap);
-err_alloc:
-	kfree(wm5100);
+err:
 	return ret;
 }
 
-- 
1.7.7.3
