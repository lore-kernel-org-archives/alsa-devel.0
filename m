From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Make WM8962 I2C usage unconditional
Date: Tue, 10 Jan 2012 18:56:21 +0000
Message-ID: <1326221781-12663-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBB95103AD0
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 19:56:21 +0100 (CET)
In-Reply-To: <>
References: <>
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

We only support I2C so no need to ifdef.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e65c063..11125c9 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -4187,7 +4187,6 @@ static const struct regmap_config wm8962_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -4316,27 +4315,16 @@ static struct i2c_driver wm8962_i2c_driver = {
 	.remove =   __devexit_p(wm8962_i2c_remove),
 	.id_table = wm8962_i2c_id,
 };
-#endif
 
 static int __init wm8962_modinit(void)
 {
-	int ret;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	ret = i2c_add_driver(&wm8962_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8962 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return 0;
+	return i2c_add_driver(&wm8962_i2c_driver);
 }
 module_init(wm8962_modinit);
 
 static void __exit wm8962_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8962_i2c_driver);
-#endif
 }
 module_exit(wm8962_exit);
 
-- 
1.7.7.3
