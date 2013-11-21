From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 01/18] ASoC: cs4271: Use IS_ENABLED() macro
Date: Thu, 21 Nov 2013 12:38:38 -0200
Message-ID: <1385044736-14911-2-git-send-email-fabio.estevam@freescale.com>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id D5508260376
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:39:11 +0100 (CET)
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
 sound/soc/codecs/cs4271.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index f6e9534..ce05fd9 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -675,7 +675,7 @@ static struct spi_driver cs4271_spi_driver = {
 };
 #endif /* defined(CONFIG_SPI_MASTER) */
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static const struct i2c_device_id cs4271_i2c_id[] = {
 	{"cs4271", 0},
 	{}
@@ -728,7 +728,7 @@ static struct i2c_driver cs4271_i2c_driver = {
 	.probe		= cs4271_i2c_probe,
 	.remove		= cs4271_i2c_remove,
 };
-#endif /* defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE) */
+#endif /* IS_ENABLED(CONFIG_I2C) */
 
 /*
  * We only register our serial bus driver here without
@@ -741,7 +741,7 @@ static int __init cs4271_modinit(void)
 {
 	int ret;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&cs4271_i2c_driver);
 	if (ret) {
 		pr_err("Failed to register CS4271 I2C driver: %d\n", ret);
@@ -767,7 +767,7 @@ static void __exit cs4271_modexit(void)
 	spi_unregister_driver(&cs4271_spi_driver);
 #endif
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&cs4271_i2c_driver);
 #endif
 }
-- 
1.8.1.2
