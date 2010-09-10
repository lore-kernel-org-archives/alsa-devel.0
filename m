From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix incorrect register cache size
	configuration
Date: Fri, 10 Sep 2010 18:14:56 +0100
Message-ID: <1284138896-3789-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C623624534
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 19:14:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The reg_cache_size is the number of elements in the register cache,
not the size of the cache itself. This is not a problem if the size
of each element of the cache is 1 byte but it matters in any other
case.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    2 +-
 sound/soc/codecs/wm8711.c |    2 +-
 sound/soc/codecs/wm8728.c |    2 +-
 sound/soc/codecs/wm8731.c |    2 +-
 sound/soc/codecs/wm8741.c |    2 +-
 sound/soc/codecs/wm8750.c |    2 +-
 sound/soc/codecs/wm8753.c |    2 +-
 sound/soc/codecs/wm8776.c |    2 +-
 sound/soc/codecs/wm8900.c |    2 +-
 sound/soc/codecs/wm8940.c |    2 +-
 sound/soc/codecs/wm8961.c |    2 +-
 sound/soc/codecs/wm8988.c |    2 +-
 sound/soc/codecs/wm8993.c |    2 +-
 sound/soc/codecs/wm9081.c |    2 +-
 sound/soc/codecs/wm9705.c |    2 +-
 sound/soc/codecs/wm9712.c |    2 +-
 sound/soc/codecs/wm9713.c |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 910c62a..ad5987e 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -907,7 +907,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.probe =	wm8580_probe,
 	.remove =	wm8580_remove,
 	.set_bias_level = wm8580_set_bias_level,
-	.reg_cache_size = sizeof(wm8580_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8580_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = &wm8580_reg,
 };
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index f8d9c60..52a923a 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -418,7 +418,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.suspend =	wm8711_suspend,
 	.resume =	wm8711_resume,
 	.set_bias_level = wm8711_set_bias_level,
-	.reg_cache_size = sizeof(wm8711_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8711_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8711_reg,
 };
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 5e5a162..32eba85 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -272,7 +272,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.suspend =	wm8728_suspend,
 	.resume =	wm8728_resume,
 	.set_bias_level = wm8728_set_bias_level,
-	.reg_cache_size = sizeof(wm8728_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8728_reg_defaults,
 };
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 56f5408..2827501 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -567,7 +567,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.suspend =	wm8731_suspend,
 	.resume =	wm8731_resume,
 	.set_bias_level = wm8731_set_bias_level,
-	.reg_cache_size = sizeof(wm8731_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8731_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8731_reg,
 };
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index c8e7a26..90e31e9 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -453,7 +453,7 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.probe =	wm8741_probe,
 	.resume =	wm8741_resume,
-	.reg_cache_size = sizeof(wm8741_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = &wm8741_reg_defaults,
 };
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 92d4b2a..4d1ec9d 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -747,7 +747,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.suspend =	wm8750_suspend,
 	.resume =	wm8750_resume,
 	.set_bias_level = wm8750_set_bias_level,
-	.reg_cache_size = sizeof(wm8750_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8750_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8750_reg,
 };
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 4a945d3..0b0e3b3 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1617,7 +1617,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.suspend =	wm8753_suspend,
 	.resume =	wm8753_resume,
 	.set_bias_level = wm8753_set_bias_level,
-	.reg_cache_size = sizeof(wm8753_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8753_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8753_reg,
 };
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 05d98dd..c0b6917 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -448,7 +448,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.suspend = 	wm8776_suspend,
 	.resume =	wm8776_resume,
 	.set_bias_level = wm8776_set_bias_level,
-	.reg_cache_size = sizeof(wm8776_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8776_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8776_reg,
 };
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 1378aab..25c8ccd 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1256,7 +1256,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.resume =	wm8900_resume,
 	.set_bias_level = wm8900_set_bias_level,
 	.volatile_register = wm8900_volatile_register,
-	.reg_cache_size = sizeof(wm8900_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8900_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8900_reg_defaults,
 };
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index d28bf0d..2cb16f8 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -750,7 +750,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
 	.suspend =	wm8940_suspend,
 	.resume =	wm8940_resume,
 	.set_bias_level = wm8940_set_bias_level,
-	.reg_cache_size = sizeof(wm8940_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8940_reg_defaults,
 };
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index bfc6578..4f326f6 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1075,7 +1075,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.suspend =	wm8961_suspend,
 	.resume =	wm8961_resume,
 	.set_bias_level = wm8961_set_bias_level,
-	.reg_cache_size = sizeof(wm8961_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8961_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8961_reg_defaults,
 	.volatile_register = wm8961_volatile_register,
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d070a58..d08b1fe 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -809,7 +809,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.suspend =	wm8988_suspend,
 	.resume =	wm8988_resume,
 	.set_bias_level = wm8988_set_bias_level,
-	.reg_cache_size = sizeof(wm8988_reg),
+	.reg_cache_size = ARRAY_SIZE(wm8988_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8988_reg,
 };
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index a3fd6b9..589e3fa 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1586,7 +1586,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.suspend =	wm8993_suspend,
 	.resume =	wm8993_resume,
 	.set_bias_level = wm8993_set_bias_level,
-	.reg_cache_size = sizeof(wm8993_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm8993_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8993_reg_defaults,
 	.volatile_register = wm8993_volatile,
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 00249d5..ecc7c37 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1317,7 +1317,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.suspend =	wm9081_suspend,
 	.resume =	wm9081_resume,
 	.set_bias_level = wm9081_set_bias_level,
-	.reg_cache_size = sizeof(wm9081_reg_defaults),
+	.reg_cache_size = ARRAY_SIZE(wm9081_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm9081_reg_defaults,
 	.volatile_register = wm9081_volatile_register,
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index e4d8f53..a144acd 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -385,7 +385,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.resume =	wm9705_soc_resume,
 	.read = ac97_read,
 	.write = ac97_write,
-	.reg_cache_size = sizeof(wm9705_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9705_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9705_reg,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index cebeb93..d2f224d 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -674,7 +674,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.read = ac97_read,
 	.write = ac97_write,
 	.set_bias_level = wm9712_set_bias_level,
-	.reg_cache_size = sizeof(wm9712_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9712_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9712_reg,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 463917e..7da13b0 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1257,7 +1257,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.read = ac97_read,
 	.write = ac97_write,
 	.set_bias_level = wm9713_set_bias_level,
-	.reg_cache_size = sizeof(wm9713_reg),
+	.reg_cache_size = ARRAY_SIZE(wm9713_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9713_reg,
-- 
1.7.2.3
