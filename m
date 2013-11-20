From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 11/11] uda1380: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:52 -0200
Message-ID: <1384969072-25906-13-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f49.google.com (mail-yh0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BD632265119
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:20 +0100 (CET)
Received: by mail-yh0-f49.google.com with SMTP id z20so3062089yhz.36
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:20 -0800 (PST)
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
 sound/soc/codecs/uda1380.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index fd0a314..726df6d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -794,7 +794,7 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.num_dapm_routes = ARRAY_SIZE(uda1380_dapm_routes),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static int uda1380_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -840,7 +840,7 @@ static struct i2c_driver uda1380_i2c_driver = {
 static int __init uda1380_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&uda1380_i2c_driver);
 	if (ret != 0)
 		pr_err("Failed to register UDA1380 I2C driver: %d\n", ret);
@@ -851,7 +851,7 @@ module_init(uda1380_modinit);
 
 static void __exit uda1380_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&uda1380_i2c_driver);
 #endif
 }
-- 
1.8.1.2
