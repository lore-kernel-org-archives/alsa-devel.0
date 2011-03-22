From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: soc-cache: Factor-out the hw_read()
	specific code
Date: Tue, 22 Mar 2011 10:36:59 +0000
Message-ID: <1300790223-13308-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 591DD103865
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:07 +0100 (CET)
In-Reply-To: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The handling of all snd_soc_x_y_read() functions is similar.
Factor it out into a separate function and update all callers.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  114 ++++++++-----------------------------------------
 1 files changed, 18 insertions(+), 96 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index e1ea456..874e435 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -47,20 +47,19 @@ static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
-static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
-				     unsigned int reg)
+static unsigned int do_hw_read(struct snd_soc_codec *codec, unsigned int reg)
 {
 	int ret;
 	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg) ||
-		codec->cache_bypass) {
-			if (codec->cache_only)
-				return -1;
+	    snd_soc_codec_volatile_register(codec, reg) ||
+	    codec->cache_bypass) {
+		if (codec->cache_only)
+			return -1;
 
-			BUG_ON(!codec->hw_read);
-			return codec->hw_read(codec, reg);
+		BUG_ON(!codec->hw_read);
+		return codec->hw_read(codec, reg);
 	}
 
 	ret = snd_soc_cache_read(codec, reg, &val);
@@ -69,6 +68,12 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 	return val;
 }
 
+static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	return do_hw_read(codec, reg);
+}
+
 static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
@@ -113,23 +118,7 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	int ret;
-	unsigned int val;
-
-	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg) ||
-		codec->cache_bypass) {
-			if (codec->cache_only)
-				return -1;
-
-			BUG_ON(!codec->hw_read);
-			return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-	return val;
+	return do_hw_read(codec, reg);
 }
 
 static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
@@ -188,24 +177,7 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	int ret;
-	unsigned int val;
-
-	reg &= 0xff;
-	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg) ||
-		codec->cache_bypass) {
-			if (codec->cache_only)
-				return -1;
-
-			BUG_ON(!codec->hw_read);
-			return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-	return val;
+	return do_hw_read(codec, reg);
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -253,23 +225,7 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 				      unsigned int reg)
 {
-	int ret;
-	unsigned int val;
-
-	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg) ||
-	    codec->cache_bypass) {
-		if (codec->cache_only)
-			return -1;
-
-		BUG_ON(!codec->hw_read);
-		return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-	return val;
+	return do_hw_read(codec, reg);
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -408,24 +364,7 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	int ret;
-	unsigned int val;
-
-	reg &= 0xff;
-	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg) ||
-		codec->cache_bypass) {
-			if (codec->cache_only)
-				return -1;
-
-			BUG_ON(!codec->hw_read);
-			return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-	return val;
+	return do_hw_read(codec, reg);
 }
 
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
@@ -509,24 +448,7 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
-	int ret;
-	unsigned int val;
-
-	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg) ||
-	    codec->cache_bypass) {
-		if (codec->cache_only)
-			return -1;
-
-		BUG_ON(!codec->hw_read);
-		return codec->hw_read(codec, reg);
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
-		return -1;
-
-	return val;
+	return do_hw_read(codec, reg);
 }
 
 static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
-- 
1.7.4.1
