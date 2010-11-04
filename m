From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: soc-cache: Add support for flat
	register caching
Date: Thu,  4 Nov 2010 14:22:42 +0000
Message-ID: <1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23484103854
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 15:22:54 +0100 (CET)
In-Reply-To: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

This patch introduces the new caching API and migrates the
old caching interface into the new one.  The flat register caching
technique does not use compression at all and it is equivalent to
the old caching technique.  One can still access codec->reg_cache
directly but this is not advised as that will not be portable
across different caching strategies.

None of the existing drivers need to be changed to adapt to this
caching technique.  There should be no noticeable overhead associated
with using the new caching API.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  342 ++++++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/soc-core.c  |   38 ++----
 2 files changed, 326 insertions(+), 54 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8785a0c..c5d05b8 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -15,10 +15,14 @@
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
 
+/* serialize access to *cache_read() and *cache_write() */
+static DEFINE_MUTEX(cache_rw_mutex);
+
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 		snd_soc_codec_volatile_register(codec, reg)) {
@@ -28,13 +32,15 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
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
 
@@ -42,8 +48,11 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -92,7 +101,8 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 		snd_soc_codec_volatile_register(codec, reg)) {
@@ -102,13 +112,15 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
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
 
@@ -116,8 +128,11 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -166,16 +181,19 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
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
@@ -191,7 +209,8 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -202,7 +221,10 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -238,16 +260,19 @@ static int snd_soc_8_8_spi_write(void *control_data, const char *data,
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
@@ -263,7 +288,8 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 				      unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -271,9 +297,12 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
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
@@ -412,7 +441,8 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -423,13 +453,15 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
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
 
@@ -439,8 +471,11 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
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
@@ -524,7 +559,8 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -534,13 +570,16 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
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
 
@@ -550,8 +589,11 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -680,6 +722,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
+	mutex_init(&cache_rw_mutex);
+
 	codec->driver->write = io_types[i].write;
 	codec->driver->read = io_types[i].read;
 
@@ -712,3 +756,239 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
+
+static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
+{
+	int i;
+	struct snd_soc_codec_driver *codec_drv;
+	unsigned int val;
+
+	codec_drv = codec->driver;
+	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+		snd_soc_cache_read(codec, i, &val);
+		if (codec_drv->reg_cache_default) {
+			switch (codec_drv->reg_word_size) {
+			case 1: {
+				const u8 *cache;
+
+				cache = codec_drv->reg_cache_default;
+				if (cache[i] == val)
+					continue;
+			}
+				break;
+			case 2: {
+				const u16 *cache;
+
+				cache = codec_drv->reg_cache_default;
+				if (cache[i] == val)
+					continue;
+			}
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+		snd_soc_write(codec, i, val);
+		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+			i, val);
+	}
+	return 0;
+}
+
+static int snd_soc_flat_cache_write(struct snd_soc_codec *codec,
+				       unsigned int reg, unsigned int value)
+{
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		u8 *cache;
+
+		cache = codec->reg_cache;
+		cache[reg] = value;
+	}
+		break;
+	case 2: {
+		u16 *cache;
+
+		cache = codec->reg_cache;
+		cache[reg] = value;
+	}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
+				      unsigned int reg, unsigned int *value)
+{
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		u8 *cache;
+
+		cache = codec->reg_cache;
+		*value = cache[reg];
+	}
+		break;
+	case 2: {
+		u16 *cache;
+
+		cache = codec->reg_cache;
+		*value = cache[reg];
+	}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
+{
+	kfree(codec->reg_cache);
+	return 0;
+}
+
+static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
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
+		.init = snd_soc_flat_cache_init,
+		.exit = snd_soc_flat_cache_exit,
+		.read = snd_soc_flat_cache_read,
+		.write = snd_soc_flat_cache_write,
+		.sync = snd_soc_flat_cache_sync
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
+/*
+ * NOTE: keep in mind that this function might be called
+ * multiple times.
+ */
+int snd_soc_cache_exit(struct snd_soc_codec *codec)
+{
+	if (codec->cache_ops && codec->cache_ops->exit)
+		return codec->cache_ops->exit(codec);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_exit);
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
+	int ret;
+
+	mutex_lock(&cache_rw_mutex);
+
+	if (value && codec->cache_ops && codec->cache_ops->read) {
+		ret = codec->cache_ops->read(codec, reg, value);
+		mutex_unlock(&cache_rw_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&cache_rw_mutex);
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
+	int ret;
+
+	mutex_lock(&cache_rw_mutex);
+
+	if (codec->cache_ops && codec->cache_ops->write) {
+		ret = codec->cache_ops->write(codec, reg, value);
+		mutex_unlock(&cache_rw_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&cache_rw_mutex);
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
+ * volatile.  In general drivers can choose not to use the provided
+ * syncing functionality if they so require.
+ */
+int snd_soc_cache_sync(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	if (!codec->cache_sync) {
+		return 0;
+	}
+
+	if (codec->cache_ops && codec->cache_ops->sync) {
+		ret = codec->cache_ops->sync(codec);
+		if (!ret)
+			codec->cache_sync = 0;
+		return ret;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4360436..ab84a34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3236,23 +3236,6 @@ int snd_soc_register_codec(struct device *dev,
 		return -ENOMEM;
 	}
 
-	/* allocate CODEC register cache */
-	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
-
-		if (codec_drv->reg_cache_default)
-			codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
-				codec_drv->reg_cache_size * codec_drv->reg_word_size, GFP_KERNEL);
-		else
-			codec->reg_cache = kzalloc(codec_drv->reg_cache_size *
-				codec_drv->reg_word_size, GFP_KERNEL);
-
-		if (codec->reg_cache == NULL) {
-			kfree(codec->name);
-			kfree(codec);
-			return -ENOMEM;
-		}
-	}
-
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->bias_level = SND_SOC_BIAS_OFF;
@@ -3261,6 +3244,16 @@ int snd_soc_register_codec(struct device *dev,
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
+	/* allocate CODEC register cache */
+	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
+		ret = snd_soc_cache_init(codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
+				ret);
+			goto error_cache;
+		}
+	}
+
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
@@ -3270,7 +3263,7 @@ int snd_soc_register_codec(struct device *dev,
 	if (num_dai) {
 		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
 		if (ret < 0)
-			goto error;
+			goto error_dais;
 	}
 
 	mutex_lock(&client_mutex);
@@ -3281,12 +3274,12 @@ int snd_soc_register_codec(struct device *dev,
 	pr_debug("Registered codec '%s'\n", codec->name);
 	return 0;
 
-error:
+error_dais:
 	for (i--; i >= 0; i--)
 		snd_soc_unregister_dai(dev);
 
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+	snd_soc_cache_exit(codec);
+error_cache:
 	kfree(codec->name);
 	kfree(codec);
 	return ret;
@@ -3320,8 +3313,7 @@ found:
 
 	pr_debug("Unregistered codec '%s'\n", codec->name);
 
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+	snd_soc_cache_exit(codec);
 	kfree(codec->name);
 	kfree(codec);
 }
-- 
1.7.3.2
