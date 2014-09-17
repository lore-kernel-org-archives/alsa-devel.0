From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Remove return value checking for
	gpiochip_remove()
Date: Wed, 17 Sep 2014 20:58:02 +0800
Message-ID: <1410958682.18482.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CCE265367
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 14:58:27 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id v10so2164193pde.3
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 05:58:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

gpiochip_remove() will return void eventually.
Thus this patch removes return value checking for gpiochip_remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 5 +----
 sound/soc/codecs/wm5100.c | 5 +----
 sound/soc/codecs/wm8903.c | 6 +-----
 sound/soc/codecs/wm8962.c | 5 +----
 sound/soc/codecs/wm8996.c | 6 +-----
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9847473..dc978ad 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3274,11 +3274,8 @@ static void rt5677_init_gpio(struct i2c_client *i2c)
 static void rt5677_free_gpio(struct i2c_client *i2c)
 {
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-	int ret;
 
-	ret = gpiochip_remove(&rt5677->gpio_chip);
-	if (ret != 0)
-		dev_err(&i2c->dev, "Failed to remove GPIOs: %d\n", ret);
+	gpiochip_remove(&rt5677->gpio_chip);
 }
 #else
 static void rt5677_init_gpio(struct i2c_client *i2c)
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 7bb0d36..a01ad62 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2319,11 +2319,8 @@ static void wm5100_init_gpio(struct i2c_client *i2c)
 static void wm5100_free_gpio(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
-	int ret;
 
-	ret = gpiochip_remove(&wm5100->gpio_chip);
-	if (ret != 0)
-		dev_err(&i2c->dev, "Failed to remove GPIOs: %d\n", ret);
+	gpiochip_remove(&wm5100->gpio_chip);
 }
 #else
 static void wm5100_init_gpio(struct i2c_client *i2c)
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index aa09848..c038b3e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1877,11 +1877,7 @@ static void wm8903_init_gpio(struct wm8903_priv *wm8903)
 
 static void wm8903_free_gpio(struct wm8903_priv *wm8903)
 {
-	int ret;
-
-	ret = gpiochip_remove(&wm8903->gpio_chip);
-	if (ret != 0)
-		dev_err(wm8903->dev, "Failed to remove GPIOs: %d\n", ret);
+	gpiochip_remove(&wm8903->gpio_chip);
 }
 #else
 static void wm8903_init_gpio(struct wm8903_priv *wm8903)
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 1098ae3..9077411 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3398,11 +3398,8 @@ static void wm8962_init_gpio(struct snd_soc_codec *codec)
 static void wm8962_free_gpio(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	int ret;
 
-	ret = gpiochip_remove(&wm8962->gpio_chip);
-	if (ret != 0)
-		dev_err(codec->dev, "Failed to remove GPIOs: %d\n", ret);
+	gpiochip_remove(&wm8962->gpio_chip);
 }
 #else
 static void wm8962_init_gpio(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index f16ff4f..b1dcc11 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2216,11 +2216,7 @@ static void wm8996_init_gpio(struct wm8996_priv *wm8996)
 
 static void wm8996_free_gpio(struct wm8996_priv *wm8996)
 {
-	int ret;
-
-	ret = gpiochip_remove(&wm8996->gpio_chip);
-	if (ret != 0)
-		dev_err(wm8996->dev, "Failed to remove GPIOs: %d\n", ret);
+	gpiochip_remove(&wm8996->gpio_chip);
 }
 #else
 static void wm8996_init_gpio(struct wm8996_priv *wm8996)
-- 
1.9.1
