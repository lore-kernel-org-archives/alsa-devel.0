From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Delegate to hw specific read for
	volatile registers
Date: Wed, 22 Sep 2010 08:54:27 +0100
Message-ID: <1285142067-4741-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 869EA1037F1
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 09:54:35 +0200 (CEST)
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

Ensure that reads on volatile registers will correctly delegate
to the bus specific read function.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   76 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 6702a3d..c4f31b8 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -19,8 +19,15 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u16 *cache = codec->reg_cache;
-	if (reg >= codec->driver->reg_cache_size)
-		return -1;
+
+	if (reg >= codec->driver->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg)) {
+	    	if (codec->cache_only)
+			return -1;
+
+		return codec->hw_read(codec, reg);
+	}
+	
 	return cache[reg];
 }
 
@@ -31,13 +38,12 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[2];
 	int ret;
 
-	BUG_ON(codec->driver->volatile_register);
-
 	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
 	data[1] = value & 0x00ff;
 
-	if (reg < codec->driver->reg_cache_size)
-		cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+	    reg < codec->driver->reg_cache_size)
+	    	cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -89,8 +95,15 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u16 *cache = codec->reg_cache;
-	if (reg >= codec->driver->reg_cache_size)
-		return -1;
+
+	if (reg >= codec->driver->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg)) {
+	    	if (codec->cache_only)
+			return -1;
+				
+		return codec->hw_read(codec, reg);
+	}
+	
 	return cache[reg];
 }
 
@@ -101,13 +114,12 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[2];
 	int ret;
 
-	BUG_ON(codec->driver->volatile_register);
-
 	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
 	data[1] = value & 0x00ff;
 
-	if (reg < codec->driver->reg_cache_size)
-		cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+	    reg < codec->driver->reg_cache_size)
+	    	cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -161,14 +173,13 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 *cache = codec->reg_cache;
 	u8 data[2];
 
-	BUG_ON(codec->driver->volatile_register);
-
 	reg &= 0xff;
 	data[0] = reg;
 	data[1] = value & 0xff;
 
-	if (reg < codec->driver->reg_cache_size)
-		cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, value) &&
+	    reg < codec->driver->reg_cache_size)
+	    	cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -187,9 +198,16 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u8 *cache = codec->reg_cache;
+
 	reg &= 0xff;
-	if (reg >= codec->driver->reg_cache_size)
-		return -1;
+	if (reg >= codec->driver->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg)) {
+	    	if (codec->cache_only)
+			return -1;
+		
+		return codec->hw_read(codec, reg);
+	}
+	
 	return cache[reg];
 }
 
@@ -344,8 +362,14 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 	u8 *cache = codec->reg_cache;
 
 	reg &= 0xff;
-	if (reg >= codec->driver->reg_cache_size)
-		return -1;
+	if (reg >= codec->driver->reg_cache_size ||
+	    snd_soc_codec_volatile_register(codec, reg)) {
+	    	if (codec->cache_only)
+			return -1;
+
+		return codec->hw_read(codec, reg);
+	}
+	
 	return cache[reg];
 }
 
@@ -356,15 +380,14 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[3];
 	int ret;
 
-	BUG_ON(codec->driver->volatile_register);
-
 	data[0] = (reg >> 8) & 0xff;
 	data[1] = reg & 0xff;
 	data[2] = value;
 
 	reg &= 0xff;
-	if (reg < codec->driver->reg_cache_size)
-		cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+	    reg < codec->driver->reg_cache_size)
+	    	cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -475,8 +498,9 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[2] = (value >> 8) & 0xff;
 	data[3] = value & 0xff;
 
-	if (reg < codec->driver->reg_cache_size)
-		cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, reg) && 
+	    reg < codec->driver->reg_cache_size)
+	    	cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
-- 
1.7.3
