From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Make WM8978 I2C usage unconditional
Date: Thu, 29 Dec 2011 11:49:09 +0000
Message-ID: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70B8424705
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver only supports I2C.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 85d514d..0b1f7ad 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1001,7 +1001,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.reg_cache_default = wm8978_reg,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -1043,27 +1042,22 @@ static struct i2c_driver wm8978_i2c_driver = {
 	.remove =   __devexit_p(wm8978_i2c_remove),
 	.id_table = wm8978_i2c_id,
 };
-#endif
 
 static int __init wm8978_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8978_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8978 I2C driver: %d\n",
 		       ret);
 	}
-#endif
 	return ret;
 }
 module_init(wm8978_modinit);
 
 static void __exit wm8978_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8978_i2c_driver);
-#endif
 }
 module_exit(wm8978_exit);
 
-- 
1.7.7.3
