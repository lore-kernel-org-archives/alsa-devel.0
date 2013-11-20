From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 10/11] wm8510: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:51 -0200
Message-ID: <1384969072-25906-12-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f54.google.com (mail-yh0-f54.google.com
 [209.85.213.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD4D26510B
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:19 +0100 (CET)
Received: by mail-yh0-f54.google.com with SMTP id a41so4830880yho.13
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:18 -0800 (PST)
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
 sound/soc/codecs/wm8510.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 6ed5433..7df7d45 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -684,7 +684,7 @@ static struct spi_driver wm8510_spi_driver = {
 };
 #endif /* CONFIG_SPI_MASTER */
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8510_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -735,7 +735,7 @@ static struct i2c_driver wm8510_i2c_driver = {
 static int __init wm8510_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8510_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8510 I2C driver: %d\n",
@@ -755,7 +755,7 @@ module_init(wm8510_modinit);
 
 static void __exit wm8510_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8510_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
1.8.1.2
