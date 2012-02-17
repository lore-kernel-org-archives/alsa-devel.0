From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: ak4535: Make I2C usage unconditional
Date: Thu, 16 Feb 2012 23:04:13 -0800
Message-ID: <1329462255-11374-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68E36103AE0
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 08:04:22 +0100 (CET)
In-Reply-To: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Convert to module_i2c_driver() too.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 29d4dec..71fca53 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -409,7 +409,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.num_dapm_routes = ARRAY_SIZE(ak4535_audio_map),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -450,29 +449,8 @@ static struct i2c_driver ak4535_i2c_driver = {
 	.remove =   __devexit_p(ak4535_i2c_remove),
 	.id_table = ak4535_i2c_id,
 };
-#endif
 
-static int __init ak4535_modinit(void)
-{
-	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	ret = i2c_add_driver(&ak4535_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register AK4535 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
-}
-module_init(ak4535_modinit);
-
-static void __exit ak4535_exit(void)
-{
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_del_driver(&ak4535_i2c_driver);
-#endif
-}
-module_exit(ak4535_exit);
+module_i2c_driver(ak4535_i2c_driver);
 
 MODULE_DESCRIPTION("Soc AK4535 driver");
 MODULE_AUTHOR("Richard Purdie");
-- 
1.7.9.rc1
