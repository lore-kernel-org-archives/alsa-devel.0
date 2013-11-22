From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] ASoC: wm8990: Convet to module_i2c_driver()
Date: Fri, 22 Nov 2013 14:39:49 +0000
Message-ID: <1385131192-28693-2-git-send-email-broonie@kernel.org>
References: <1385131192-28693-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A1F264F22
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:40:00 +0100 (CET)
In-Reply-To: <1385131192-28693-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensouce.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The device is I2C only (or at least current support is).

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8990.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 4f05fb88bddf..33bec5672418 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1378,7 +1378,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.volatile_register = wm8990_volatile_register,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int wm8990_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -1420,29 +1419,8 @@ static struct i2c_driver wm8990_i2c_driver = {
 	.remove =   wm8990_i2c_remove,
 	.id_table = wm8990_i2c_id,
 };
-#endif
 
-static int __init wm8990_modinit(void)
-{
-	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	ret = i2c_add_driver(&wm8990_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register wm8990 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
-}
-module_init(wm8990_modinit);
-
-static void __exit wm8990_exit(void)
-{
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_del_driver(&wm8990_i2c_driver);
-#endif
-}
-module_exit(wm8990_exit);
+module_i2c_driver(wm8990_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM8990 driver");
 MODULE_AUTHOR("Liam Girdwood");
-- 
1.8.4.4
