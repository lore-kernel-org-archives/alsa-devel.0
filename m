From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Convert wm1250-ev1 driver to use
	devm_kzalloc()
Date: Sun, 27 Nov 2011 16:03:10 +0000
Message-ID: <1322409792-5132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE9C624453
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:03:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index cd0ec0f..aefb4f8 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -116,7 +116,7 @@ static int __devinit wm1250_ev1_pdata(struct i2c_client *i2c)
 	if (!pdata)
 		return 0;
 
-	wm1250 = kzalloc(sizeof(*wm1250), GFP_KERNEL);
+	wm1250 = devm_kzalloc(&i2c->dev, sizeof(*wm1250), GFP_KERNEL);
 	if (!wm1250) {
 		dev_err(&i2c->dev, "Unable to allocate private data\n");
 		ret = -ENOMEM;
@@ -134,15 +134,13 @@ static int __devinit wm1250_ev1_pdata(struct i2c_client *i2c)
 	ret = gpio_request_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to get GPIOs: %d\n", ret);
-		goto err_alloc;
+		goto err;
 	}
 
 	dev_set_drvdata(&i2c->dev, wm1250);
 
 	return ret;
 
-err_alloc:
-	kfree(wm1250);
 err:
 	return ret;
 }
@@ -151,10 +149,8 @@ static void wm1250_ev1_free(struct i2c_client *i2c)
 {
 	struct wm1250_priv *wm1250 = dev_get_drvdata(&i2c->dev);
 
-	if (wm1250) {
+	if (wm1250)
 		gpio_free_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
-		kfree(wm1250);
-	}
 }
 
 static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
-- 
1.7.7.3
