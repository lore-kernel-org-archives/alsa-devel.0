From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: soc-cache: Factor-out the hw_write()
	specific code
Date: Tue, 22 Mar 2011 10:36:58 +0000
Message-ID: <1300790223-13308-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3112010389A
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:06 +0100 (CET)
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

The handling of all snd_soc_x_y_write() functions is similar.
Factor it out into a separate function and update all functions
to use it.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  153 +++++++++++--------------------------------------
 1 files changed, 33 insertions(+), 120 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5d76da4..e1ea456 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,6 +20,33 @@
 
 #include <trace/events/asoc.h>
 
+static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value, const void *data, int len)
+{
+	int ret;
+
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+	    reg < codec->driver->reg_cache_size &&
+	    !codec->cache_bypass) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
+
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
+		return 0;
+	}
+
+	ret = codec->hw_write(codec->control_data, data, len);
+	if (ret == len)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -46,31 +73,11 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
 	u8 data[2];
-	int ret;
 
 	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
 	data[1] = value & 0x00ff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	ret = codec->hw_write(codec->control_data, data, 2);
-	if (ret == 2)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 2);
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -129,31 +136,11 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
 	u8 data[2];
-	int ret;
 
 	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
 	data[1] = value & 0x00ff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	ret = codec->hw_write(codec->control_data, data, 2);
-	if (ret == 2)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 2);
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -190,29 +177,12 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
 	u8 data[2];
-	int ret;
 
 	reg &= 0xff;
 	data[0] = reg;
 	data[1] = value & 0xff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 2);
 }
 
 static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
@@ -272,29 +242,12 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
 	u8 data[3];
-	int ret;
 
 	data[0] = reg;
 	data[1] = (value >> 8) & 0xff;
 	data[2] = value & 0xff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	if (codec->hw_write(codec->control_data, data, 3) == 3)
-		return 0;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 3);
 }
 
 static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
@@ -479,33 +432,13 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
 	u8 data[3];
-	int ret;
 
 	data[0] = (reg >> 8) & 0xff;
 	data[1] = reg & 0xff;
 	data[2] = value;
-
 	reg &= 0xff;
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
 
-	ret = codec->hw_write(codec->control_data, data, 3);
-	if (ret == 3)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 3);
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -600,33 +533,13 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int value)
 {
 	u8 data[4];
-	int ret;
 
 	data[0] = (reg >> 8) & 0xff;
 	data[1] = reg & 0xff;
 	data[2] = (value >> 8) & 0xff;
 	data[3] = value & 0xff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size &&
-		!codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
-	ret = codec->hw_write(codec->control_data, data, 4);
-	if (ret == 4)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
+	return do_hw_write(codec, reg, value, data, 4);
 }
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.4.1
