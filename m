From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Replace custom debug macros with pr_
	equivalents
Date: Mon, 23 Jun 2008 14:51:29 +0100
Message-ID: <1214229089-26991-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1214229089-26991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BDD0103831
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 15:51:38 +0200 (CEST)
In-Reply-To: <1214229089-26991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Several ASoC codec drivers use custom macros equivalent to the standard
pr_ macros, most of which are not actually used. Replace these custom
macros with the standard ones.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |   25 +++----------------------
 sound/soc/codecs/wm8731.c |   25 +++----------------------
 sound/soc/codecs/wm8750.c |   25 +++----------------------
 sound/soc/codecs/wm8753.c |   25 +++----------------------
 sound/soc/codecs/wm8990.c |   25 +++----------------------
 5 files changed, 15 insertions(+), 110 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 152e6f2..b549f67 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -30,25 +30,6 @@
 #define AUDIO_NAME "wm8510"
 #define WM8510_VERSION "0.6"
 
-/*
- * Debug
- */
-
-#define WM8510_DEBUG 0
-
-#ifdef WM8510_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-#define err(format, arg...) \
-	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
-#define info(format, arg...) \
-	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
-#define warn(format, arg...) \
-	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
-
 struct snd_soc_codec_device soc_codec_dev_wm8510;
 
 /*
@@ -721,13 +702,13 @@ static int wm8510_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 
 	ret = i2c_attach_client(i2c);
 	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
+		pr_err("failed to attach codec at addr %x\n", addr);
 		goto err;
 	}
 
 	ret = wm8510_init(socdev);
 	if (ret < 0) {
-		err("failed to initialise WM8510\n");
+		pr_err("failed to initialise WM8510\n");
 		goto err;
 	}
 	return ret;
@@ -777,7 +758,7 @@ static int wm8510_probe(struct platform_device *pdev)
 	struct snd_soc_codec *codec;
 	int ret = 0;
 
-	info("WM8510 Audio Codec %s", WM8510_VERSION);
+	pr_info("WM8510 Audio Codec %s", WM8510_VERSION);
 
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7788053..3ff42ad 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -31,25 +31,6 @@
 #define AUDIO_NAME "wm8731"
 #define WM8731_VERSION "0.13"
 
-/*
- * Debug
- */
-
-#define WM8731_DEBUG 0
-
-#ifdef WM8731_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-#define err(format, arg...) \
-	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
-#define info(format, arg...) \
-	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
-#define warn(format, arg...) \
-	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
-
 struct snd_soc_codec_device soc_codec_dev_wm8731;
 
 /* codec private data */
@@ -624,13 +605,13 @@ static int wm8731_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 
 	ret = i2c_attach_client(i2c);
 	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
+		pr_err("failed to attach codec at addr %x\n", addr);
 		goto err;
 	}
 
 	ret = wm8731_init(socdev);
 	if (ret < 0) {
-		err("failed to initialise WM8731\n");
+		pr_err("failed to initialise WM8731\n");
 		goto err;
 	}
 	return ret;
@@ -681,7 +662,7 @@ static int wm8731_probe(struct platform_device *pdev)
 	struct wm8731_priv *wm8731;
 	int ret = 0;
 
-	info("WM8731 Audio Codec %s", WM8731_VERSION);
+	pr_info("WM8731 Audio Codec %s", WM8731_VERSION);
 
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 1ae670a..eb460c9 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -31,25 +31,6 @@
 #define AUDIO_NAME "WM8750"
 #define WM8750_VERSION "0.12"
 
-/*
- * Debug
- */
-
-#define WM8750_DEBUG 0
-
-#ifdef WM8750_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-#define err(format, arg...) \
-	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
-#define info(format, arg...) \
-	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
-#define warn(format, arg...) \
-	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
-
 /* codec private data */
 struct wm8750_priv {
 	unsigned int sysclk;
@@ -896,13 +877,13 @@ static int wm8750_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 
 	ret = i2c_attach_client(i2c);
 	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
+		pr_err("failed to attach codec at addr %x\n", addr);
 		goto err;
 	}
 
 	ret = wm8750_init(socdev);
 	if (ret < 0) {
-	err("failed to initialise WM8750\n");
+		pr_err("failed to initialise WM8750\n");
 		goto err;
 	}
 	return ret;
@@ -953,7 +934,7 @@ static int wm8750_probe(struct platform_device *pdev)
 	struct wm8750_priv *wm8750;
 	int ret = 0;
 
-	info("WM8750 Audio Codec %s", WM8750_VERSION);
+	pr_info("WM8750 Audio Codec %s", WM8750_VERSION);
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 00b4811..be01a73 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -55,25 +55,6 @@
 #define AUDIO_NAME "wm8753"
 #define WM8753_VERSION "0.16"
 
-/*
- * Debug
- */
-
-#define WM8753_DEBUG 0
-
-#ifdef WM8753_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-#define err(format, arg...) \
-	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
-#define info(format, arg...) \
-	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
-#define warn(format, arg...) \
-	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
-
 static int caps_charge = 2000;
 module_param(caps_charge, int, 0);
 MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
@@ -1689,13 +1670,13 @@ static int wm8753_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 
 	ret = i2c_attach_client(i2c);
 	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
+		pr_err("failed to attach codec at addr %x\n", addr);
 		goto err;
 	}
 
 	ret = wm8753_init(socdev);
 	if (ret < 0) {
-		err("failed to initialise WM8753\n");
+		pr_err("failed to initialise WM8753\n");
 		goto err;
 	}
 
@@ -1747,7 +1728,7 @@ static int wm8753_probe(struct platform_device *pdev)
 	struct wm8753_priv *wm8753;
 	int ret = 0;
 
-	info("WM8753 Audio Codec %s", WM8753_VERSION);
+	pr_info("WM8753 Audio Codec %s", WM8753_VERSION);
 
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index a7d25e2..a1371b7 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -33,25 +33,6 @@
 #define AUDIO_NAME "wm8990"
 #define WM8990_VERSION "0.2"
 
-/*
- * Debug
- */
-
-#define WM8990_DEBUG 0
-
-#ifdef WM8990_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-#define err(format, arg...) \
-	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
-#define info(format, arg...) \
-	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
-#define warn(format, arg...) \
-	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
-
 /* codec private data */
 struct wm8990_priv {
 	unsigned int sysclk;
@@ -1524,13 +1505,13 @@ static int wm8990_codec_probe(struct i2c_adapter *adap, int addr, int kind)
 
 	ret = i2c_attach_client(i2c);
 	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
+		pr_err("failed to attach codec at addr %x\n", addr);
 		goto err;
 	}
 
 	ret = wm8990_init(socdev);
 	if (ret < 0) {
-		err("failed to initialise WM8990\n");
+		pr_err("failed to initialise WM8990\n");
 		goto err;
 	}
 	return ret;
@@ -1579,7 +1560,7 @@ static int wm8990_probe(struct platform_device *pdev)
 	struct wm8990_priv *wm8990;
 	int ret = 0;
 
-	info("WM8990 Audio Codec %s\n", WM8990_VERSION);
+	pr_info("WM8990 Audio Codec %s\n", WM8990_VERSION);
 
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-- 
1.5.6
