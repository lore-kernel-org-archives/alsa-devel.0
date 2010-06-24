From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 5/5] ASoC multi-component support : jack
Date: Thu, 24 Jun 2010 20:24:51 +0100
Message-ID: <1277407491.3100.584.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 88D971039A6
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 21:24:48 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 38so2318604wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 12:24:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Cache configuration is now stored as part of the codec driver structure.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/soc-cache.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 472af38..83cd8ed 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -19,7 +19,7 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u16 *cache = codec->reg_cache;
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -1;
 	return cache[reg];
 }
@@ -31,12 +31,12 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[2];
 	int ret;
 
-	BUG_ON(codec->volatile_register);
+	BUG_ON(codec->driver->volatile_register);
 
 	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
 	data[1] = value & 0x00ff;
 
-	if (reg < codec->reg_cache_size)
+	if (reg < codec->driver->reg_cache_size)
 		cache[reg] = value;
 
 	if (codec->cache_only) {
@@ -89,7 +89,7 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u16 *cache = codec->reg_cache;
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -1;
 	return cache[reg];
 }
@@ -101,12 +101,12 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[2];
 	int ret;
 
-	BUG_ON(codec->volatile_register);
+	BUG_ON(codec->driver->volatile_register);
 
 	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
 	data[1] = value & 0x00ff;
 
-	if (reg < codec->reg_cache_size)
+	if (reg < codec->driver->reg_cache_size)
 		cache[reg] = value;
 
 	if (codec->cache_only) {
@@ -161,13 +161,13 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 *cache = codec->reg_cache;
 	u8 data[2];
 
-	BUG_ON(codec->volatile_register);
+	BUG_ON(codec->driver->volatile_register);
 
 	reg &= 0xff;
 	data[0] = reg;
 	data[1] = value & 0xff;
 
-	if (reg < codec->reg_cache_size)
+	if (reg < codec->driver->reg_cache_size)
 		cache[reg] = value;
 
 	if (codec->cache_only) {
@@ -188,7 +188,7 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 {
 	u8 *cache = codec->reg_cache;
 	reg &= 0xff;
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -1;
 	return cache[reg];
 }
@@ -224,7 +224,7 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 {
 	u16 *cache = codec->reg_cache;
 
-	if (reg >= codec->reg_cache_size ||
+	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
 		if (codec->cache_only)
 			return -EINVAL;
@@ -343,7 +343,7 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 	u16 *cache = codec->reg_cache;
 
 	reg &= 0xff;
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -1;
 	return cache[reg];
 }
@@ -355,14 +355,14 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 data[3];
 	int ret;
 
-	BUG_ON(codec->volatile_register);
+	BUG_ON(codec->driver->volatile_register);
 
 	data[0] = (reg >> 8) & 0xff;
 	data[1] = reg & 0xff;
 	data[2] = value;
 
 	reg &= 0xff;
-	if (reg < codec->reg_cache_size)
+	if (reg < codec->driver->reg_cache_size)
 		cache[reg] = value;
 
 	if (codec->cache_only) {
@@ -451,7 +451,7 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 {
 	u16 *cache = codec->reg_cache;
 
-	if (reg >= codec->reg_cache_size ||
+	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
 		if (codec->cache_only)
 			return -EINVAL;
@@ -474,7 +474,7 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[2] = (value >> 8) & 0xff;
 	data[3] = value & 0xff;
 
-	if (reg < codec->reg_cache_size)
+	if (reg < codec->driver->reg_cache_size)
 		cache[reg] = value;
 
 	if (codec->cache_only) {
@@ -571,8 +571,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	codec->write = io_types[i].write;
-	codec->read = io_types[i].read;
+	codec->driver->write = io_types[i].write;
+	codec->driver->read = io_types[i].read;
 
 	switch (control) {
 	case SND_SOC_CUSTOM:
-- 
1.7.0.4
