From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: soc-cache: Add support for standard
	register caching
Date: Fri, 22 Oct 2010 15:28:20 +0100
Message-ID: <1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 701C6103845
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:28:27 +0200 (CEST)
In-Reply-To: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

This patch adds support for normal caching (no compression).  One
can still access codec->reg_cache directly but this is not advised
as that will not be portable across different caching strategies.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  267 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 236 insertions(+), 31 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d214f02..a8ec23a 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -18,7 +18,8 @@
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 		snd_soc_codec_volatile_register(codec, reg)) {
@@ -28,13 +29,15 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u16 *cache = codec->reg_cache;
 	u8 data[2];
 	int ret;
 
@@ -42,8 +45,11 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0x00ff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size)
-			cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -94,7 +100,8 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 		snd_soc_codec_volatile_register(codec, reg)) {
@@ -104,13 +111,15 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u16 *cache = codec->reg_cache;
 	u8 data[2];
 	int ret;
 
@@ -118,8 +127,11 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0x00ff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size)
-			cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -170,16 +182,19 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
 static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u8 *cache = codec->reg_cache;
 	u8 data[2];
+	int ret;
 
 	reg &= 0xff;
 	data[0] = reg;
 	data[1] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size)
-			cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -197,7 +212,8 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -208,7 +224,10 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -244,16 +263,19 @@ static int snd_soc_8_8_spi_write(void *control_data, const char *data,
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
-	u16 *reg_cache = codec->reg_cache;
 	u8 data[3];
+	int ret;
 
 	data[0] = reg;
 	data[1] = (value >> 8) & 0xff;
 	data[2] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-	    reg < codec->driver->reg_cache_size)
-		reg_cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -271,7 +293,8 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 				      unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -279,9 +302,12 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 			return -1;
 
 		return codec->hw_read(codec, reg);
-	} else {
-		return cache[reg];
 	}
+
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -420,7 +446,8 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -431,13 +458,15 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u8 *cache = codec->reg_cache;
 	u8 data[3];
 	int ret;
 
@@ -447,8 +476,11 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	reg &= 0xff;
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size)
-			cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -534,7 +566,8 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -544,13 +577,16 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 		return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+
+	return val;
 }
 
 static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int value)
 {
-	u16 *cache = codec->reg_cache;
 	u8 data[4];
 	int ret;
 
@@ -560,8 +596,11 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[3] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size)
-			cache[reg] = value;
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
@@ -724,3 +763,169 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
+
+static int snd_soc_cache_default_sync(struct snd_soc_codec *codec)
+{
+	const u8 *cache;
+	struct snd_soc_codec_driver *codec_drv;
+	unsigned int val;
+	int n;
+
+	codec_drv = codec->driver;
+	for (n = 0; n < codec_drv->reg_cache_size; ++n) {
+		snd_soc_cache_read(codec, n, &val);
+		if (codec_drv->reg_cache_default) {
+			cache = codec_drv->reg_cache_default;
+			cache += (n * codec_drv->reg_word_size);
+			if (!memcmp(&val, cache, codec_drv->reg_word_size))
+				continue;
+		}
+		snd_soc_write(codec, n, val);
+	}
+	return 0;
+}
+
+static int snd_soc_cache_default_write(struct snd_soc_codec *codec,
+				       unsigned int reg, unsigned int value)
+{
+	u8 *cache;
+
+	cache = codec->reg_cache;
+	memcpy(&cache[reg * codec->driver->reg_word_size],
+	       &value, codec->driver->reg_word_size);
+	return 0;
+}
+
+static int snd_soc_cache_default_read(struct snd_soc_codec *codec,
+				      unsigned int reg, unsigned int *value)
+{
+	u8 *cache;
+
+	*value = 0;
+	cache = codec->reg_cache;
+	memcpy(value, &cache[reg * codec->driver->reg_word_size],
+	       codec->driver->reg_word_size);
+	return 0;
+}
+
+static int snd_soc_cache_default_deinit(struct snd_soc_codec *codec)
+{
+	kfree(codec->reg_cache);
+	return 0;
+};
+
+static int snd_soc_cache_default_init(struct snd_soc_codec *codec)
+{
+	struct snd_soc_codec_driver *codec_drv;
+	size_t reg_size;
+
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+
+	if (codec_drv->reg_cache_default)
+		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
+					   reg_size, GFP_KERNEL);
+	else
+		codec->reg_cache = kzalloc(reg_size, GFP_KERNEL);
+	if (!codec->reg_cache)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* an array of all supported compression types */
+static const struct snd_soc_cache_ops cache_types[] = {
+	{
+		.id = SND_SOC_NO_COMPRESSION,
+		.init = snd_soc_cache_default_init,
+		.deinit = snd_soc_cache_default_deinit,
+		.read = snd_soc_cache_default_read,
+		.write = snd_soc_cache_default_write,
+		.sync = snd_soc_cache_default_sync
+	}
+};
+
+int snd_soc_cache_init(struct snd_soc_codec *codec)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cache_types); ++i)
+		if (cache_types[i].id == codec->driver->compress_type)
+			break;
+	if (i == ARRAY_SIZE(cache_types)) {
+		dev_err(codec->dev, "Could not match compress type: %d\n",
+			codec->driver->compress_type);
+		return -EINVAL;
+	}
+
+	codec->cache_ops = &cache_types[i];
+
+	if (codec->cache_ops->init)
+		return codec->cache_ops->init(codec);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_init);
+
+int snd_soc_cache_deinit(struct snd_soc_codec *codec)
+{
+	if (codec->cache_ops && codec->cache_ops->deinit)
+		return codec->cache_ops->deinit(codec);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_deinit);
+
+/**
+ * snd_soc_cache_read: Fetch the value of a given register from the cache.
+ *
+ * @codec: CODEC to configure.
+ * @reg: The register index.
+ * @value: The value to be returned.
+ */
+int snd_soc_cache_read(struct snd_soc_codec *codec,
+		       unsigned int reg, unsigned int *value)
+{
+	if (value && codec->cache_ops && codec->cache_ops->read)
+		return codec->cache_ops->read(codec, reg, value);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_read);
+
+/**
+ * snd_soc_cache_write: Set the value of a given register in the cache.
+ *
+ * @codec: CODEC to configure.
+ * @reg: The register index.
+ * @value: The new register value.
+ */
+int snd_soc_cache_write(struct snd_soc_codec *codec,
+			unsigned int reg, unsigned int value)
+{
+	if (codec->cache_ops && codec->cache_ops->write)
+		return codec->cache_ops->write(codec, reg, value);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_write);
+
+/**
+ * snd_soc_cache_sync: Sync the register cache with the hardware.
+ *
+ * @codec: CODEC to configure.
+ *
+ * Any registers that should not be synced should be marked as
+ * volatile.
+ */
+int snd_soc_cache_sync(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	if (!codec->cache_sync)
+		return 0;
+	if (codec->cache_ops && codec->cache_ops->sync) {
+		ret = codec->cache_ops->sync(codec);
+		if (!ret)
+			codec->cache_sync = 0;
+		return ret;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
-- 
1.7.3.1
