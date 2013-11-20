From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 07/11] wm8711: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:48 -0200
Message-ID: <1384969072-25906-9-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f53.google.com (mail-yh0-f53.google.com
 [209.85.213.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EC751261ADA
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:15 +0100 (CET)
Received: by mail-yh0-f53.google.com with SMTP id b20so3753696yha.12
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:14 -0800 (PST)
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
 sound/soc/codecs/wm8711.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 5b428b0..d99f948 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -469,7 +469,7 @@ static struct spi_driver wm8711_spi_driver = {
 };
 #endif /* CONFIG_SPI_MASTER */
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8711_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -520,7 +520,7 @@ static struct i2c_driver wm8711_i2c_driver = {
 static int __init wm8711_modinit(void)
 {
 	int ret;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8711_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8711 I2C driver: %d\n",
@@ -540,7 +540,7 @@ module_init(wm8711_modinit);
 
 static void __exit wm8711_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8711_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
1.8.1.2
