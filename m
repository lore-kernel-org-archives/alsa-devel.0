From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 09/11] wm8523: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:50 -0200
Message-ID: <1384969072-25906-11-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id EDE4D265104
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:17 +0100 (CET)
Received: by mail-yh0-f44.google.com with SMTP id f64so1947844yha.17
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:17 -0800 (PST)
In-Reply-To: <1384969072-25906-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the IS_ENABLED() macro can make the code shorter and simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8523.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 139bf9a..74d106d 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -452,7 +452,7 @@ static const struct regmap_config wm8523_regmap = {
 	.volatile_reg = wm8523_volatile_register,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8523_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -555,7 +555,7 @@ static struct i2c_driver wm8523_i2c_driver = {
 static int __init wm8523_modinit(void)
 {
 	int ret;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8523_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8523 I2C driver: %d\n",
@@ -568,7 +568,7 @@ module_init(wm8523_modinit);
 
 static void __exit wm8523_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8523_i2c_driver);
 #endif
 }
-- 
1.8.1.2
