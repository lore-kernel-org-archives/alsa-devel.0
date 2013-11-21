From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 06/18] ASoC: wm8737: Use IS_ENABLED() macro
Date: Thu, 21 Nov 2013 12:38:44 -0200
Message-ID: <1385044736-14911-8-git-send-email-fabio.estevam@freescale.com>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F4F260307
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:39:18 +0100 (CET)
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

Using the IS_ENABLED() macro can make the code shorter and simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8737.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 2f167a8..22de242 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -644,7 +644,7 @@ static const struct regmap_config wm8737_regmap = {
 	.volatile_reg = wm8737_volatile,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8737_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -758,7 +758,7 @@ static struct spi_driver wm8737_spi_driver = {
 static int __init wm8737_modinit(void)
 {
 	int ret;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8737_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8737 I2C driver: %d\n",
@@ -781,7 +781,7 @@ static void __exit wm8737_exit(void)
 #if defined(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&wm8737_spi_driver);
 #endif
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8737_i2c_driver);
 #endif
 }
-- 
1.8.1.2
