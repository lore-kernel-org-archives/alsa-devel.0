From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Return proper error if i2c_add_driver
	fails
Date: Tue, 10 Jan 2012 16:54:50 +0800
Message-ID: <1326185690.28549.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D98C10393F
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 09:55:02 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1985060ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 00:55:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8523.c |    4 ++--
 sound/soc/codecs/wm8711.c |    4 ++--
 sound/soc/codecs/wm8737.c |    4 ++--
 sound/soc/codecs/wm8962.c |    4 ++--
 sound/soc/codecs/wm8991.c |    4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 7fea2c3..84b2ddc 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -559,7 +559,7 @@ static struct i2c_driver wm8523_i2c_driver = {
 
 static int __init wm8523_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8523_i2c_driver);
 	if (ret != 0) {
@@ -567,7 +567,7 @@ static int __init wm8523_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8523_modinit);
 
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 0b76d1d..727fb57 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -494,7 +494,7 @@ static struct i2c_driver wm8711_i2c_driver = {
 
 static int __init wm8711_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8711_i2c_driver);
 	if (ret != 0) {
@@ -509,7 +509,7 @@ static int __init wm8711_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8711_modinit);
 
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index ff95e62c..9a19a44 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -728,7 +728,7 @@ static struct spi_driver wm8737_spi_driver = {
 
 static int __init wm8737_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8737_i2c_driver);
 	if (ret != 0) {
@@ -743,7 +743,7 @@ static int __init wm8737_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8737_modinit);
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 296de4e..30bc788 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -4288,7 +4288,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 
 static int __init wm8962_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8962_i2c_driver);
 	if (ret != 0) {
@@ -4296,7 +4296,7 @@ static int __init wm8962_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8962_modinit);
 
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 7ee40da..d877487 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1402,13 +1402,13 @@ static struct i2c_driver wm8991_i2c_driver = {
 
 static int __init wm8991_modinit(void)
 {
-	int ret;
+	int ret = 0;
 	ret = i2c_add_driver(&wm8991_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8991 I2C driver: %d\n",
 		       ret);
 	}
-	return 0;
+	return ret;
 }
 module_init(wm8991_modinit);
 
-- 
1.7.5.4
