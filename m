From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 03/18] ASoC: da7210: Use IS_ENABLED() macro
Date: Thu, 21 Nov 2013 12:38:41 -0200
Message-ID: <1385044736-14911-5-git-send-email-fabio.estevam@freescale.com>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D67126089A
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:39:16 +0100 (CET)
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
 sound/soc/codecs/da7210.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 9c12314..8166dcb 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1188,7 +1188,7 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 
 static struct reg_default da7210_regmap_i2c_patch[] = {
 
@@ -1362,7 +1362,7 @@ static struct spi_driver da7210_spi_driver = {
 static int __init da7210_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&da7210_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
@@ -1378,7 +1378,7 @@ module_init(da7210_modinit);
 
 static void __exit da7210_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&da7210_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
1.8.1.2
