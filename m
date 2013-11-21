From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 16/18] ASoC: wm8990:
Date: Thu, 21 Nov 2013 12:38:54 -0200
Message-ID: <1385044736-14911-18-git-send-email-fabio.estevam@freescale.com>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 02D92260307
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:39:32 +0100 (CET)
In-Reply-To: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
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

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8990.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 253c88b..34f0020 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1376,7 +1376,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.volatile_register = wm8990_volatile_register,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8990_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -1423,7 +1423,7 @@ static struct i2c_driver wm8990_i2c_driver = {
 static int __init wm8990_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8990_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register wm8990 I2C driver: %d\n",
@@ -1436,7 +1436,7 @@ module_init(wm8990_modinit);
 
 static void __exit wm8990_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8990_i2c_driver);
 #endif
 }
-- 
1.8.1.2
