From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 03/11] ad193x: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:43 -0200
Message-ID: <1384969072-25906-4-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f49.google.com (mail-yh0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id AE911261B1C
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:07 +0100 (CET)
Received: by mail-yh0-f49.google.com with SMTP id z20so3061005yhz.8
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:07 -0800 (PST)
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
 sound/soc/codecs/ad193x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index aea7e52..12c27eb 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -413,7 +413,7 @@ static struct spi_driver ad193x_spi_driver = {
 };
 #endif
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 
 static const struct regmap_config ad193x_i2c_regmap_config = {
 	.val_bits = 8,
@@ -470,7 +470,7 @@ static int __init ad193x_modinit(void)
 {
 	int ret;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret =  i2c_add_driver(&ad193x_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register AD193X I2C driver: %d\n",
@@ -495,7 +495,7 @@ static void __exit ad193x_modexit(void)
 	spi_unregister_driver(&ad193x_spi_driver);
 #endif
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&ad193x_i2c_driver);
 #endif
 }
-- 
1.8.1.2
