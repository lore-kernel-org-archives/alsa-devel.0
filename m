From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 05/11] ak4642: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:46 -0200
Message-ID: <1384969072-25906-7-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF04261A1F
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:11 +0100 (CET)
Received: by mail-yh0-f44.google.com with SMTP id f64so1952438yha.3
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:11 -0800 (PST)
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
 sound/soc/codecs/ak4642.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 090d499..2f861c9 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -511,7 +511,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4648 = {
 	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 static struct of_device_id ak4642_of_match[];
 static int ak4642_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -576,7 +576,7 @@ static struct i2c_driver ak4642_i2c_driver = {
 static int __init ak4642_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&ak4642_i2c_driver);
 #endif
 	return ret;
@@ -586,7 +586,7 @@ module_init(ak4642_modinit);
 
 static void __exit ak4642_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&ak4642_i2c_driver);
 #endif
 
-- 
1.8.1.2
