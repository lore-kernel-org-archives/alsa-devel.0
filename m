From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 17/18] ASoC: wm8995:
Date: Thu, 21 Nov 2013 12:38:55 -0200
Message-ID: <1385044736-14911-19-git-send-email-fabio.estevam@freescale.com>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B52F2619F0
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:39:37 +0100 (CET)
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
 sound/soc/codecs/wm8995.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index da2899e6..4300caf 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2293,7 +2293,7 @@ static struct spi_driver wm8995_spi_driver = {
 };
 #endif
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int wm8995_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -2350,7 +2350,7 @@ static int __init wm8995_modinit(void)
 {
 	int ret = 0;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&wm8995_i2c_driver);
 	if (ret) {
 		printk(KERN_ERR "Failed to register wm8995 I2C driver: %d\n",
@@ -2371,7 +2371,7 @@ module_init(wm8995_modinit);
 
 static void __exit wm8995_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&wm8995_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
1.8.1.2
