From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: soc-cache: Add support for flat
	register caching
Date: Thu, 11 Nov 2010 10:04:57 +0000
Message-ID: <1289469899-5787-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADDB11038BD
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 11:05:07 +0100 (CET)
In-Reply-To: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
 include/sound/soc.h   |   27 ++++
 sound/soc/soc-cache.c |  339 ++++++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/soc-core.c  |   37 ++----
 3 files changed, 349 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5d39547..275e411 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,6 +238,7 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+struct snd_soc_cache_ops;
 #include <sound/soc-dapm.h>
 
 #ifdef CONFIG_GPIOLIB
@@ -254,6 +255,10 @@ enum snd_soc_control_type {
 	SND_SOC_SPI,
 };
 
+enum snd_soc_compress_type {
+	SND_SOC_NO_COMPRESSION
+};
+
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
@@ -265,6 +270,13 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
+int snd_soc_cache_sync(struct snd_soc_codec *codec);
+int snd_soc_cache_init(struct snd_soc_codec *codec);
+int snd_soc_cache_exit(struct snd_soc_codec *codec);
+int snd_soc_cache_write(struct snd_soc_codec *codec,
+			unsigned int reg, unsigned int value);
+int snd_soc_cache_read(struct snd_soc_codec *codec,
+		       unsigned int reg, unsigned int *value);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -421,6 +433,18 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
+/* SoC cache ops */
+struct snd_soc_cache_ops {
+	enum snd_soc_compress_type id;
+	int (*init)(struct snd_soc_codec *codec);
+	int (*exit)(struct snd_soc_codec *codec);
+	int (*read)(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int *value);
+	int (*write)(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int value);
+	int (*sync)(struct snd_soc_codec *codec);
+};
+
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
@@ -450,6 +474,8 @@ struct snd_soc_codec {
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
+	const struct snd_soc_cache_ops *cache_ops;
+	struct mutex cache_rw_mutex;
 
 	/* dapm */
 	struct snd_soc_dapm_context dapm;
@@ -482,6 +508,7 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
+	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
 	int (*set_bias_level)(struct snd_soc_codec *,
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index e747998..cbf9694 100644
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
@@ -29,13 +30,15 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
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
 
@@ -43,8 +46,11 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -93,7 +99,8 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
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
@@ -168,16 +180,19 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
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
@@ -193,7 +208,8 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -205,7 +221,10 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 			return codec->hw_read(codec, reg);
 	}
 
-	return cache[reg];
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -241,16 +260,19 @@ static int snd_soc_8_8_spi_write(void *control_data, const char *data,
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
@@ -266,7 +288,8 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 				      unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -275,9 +298,12 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 
 		BUG_ON(!codec->hw_read);
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
@@ -416,7 +442,8 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
@@ -428,13 +455,15 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
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
 
@@ -444,8 +473,11 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
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
@@ -529,7 +561,8 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	int ret;
+	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
@@ -540,13 +573,16 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
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
 
@@ -556,8 +592,11 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
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
@@ -718,3 +757,241 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
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
+			break;
+			case 2: {
+				const u16 *cache;
+
+				cache = codec_drv->reg_cache_default;
+				if (cache[i] == val)
+					continue;
+			}
+			break;
+			default:
+				BUG();
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
+				    unsigned int reg, unsigned int value)
+{
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		u8 *cache;
+
+		cache = codec->reg_cache;
+		cache[reg] = value;
+	}
+	break;
+	case 2: {
+		u16 *cache;
+
+		cache = codec->reg_cache;
+		cache[reg] = value;
+	}
+	break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
+				   unsigned int reg, unsigned int *value)
+{
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		u8 *cache;
+
+		cache = codec->reg_cache;
+		*value = cache[reg];
+	}
+	break;
+	case 2: {
+		u16 *cache;
+
+		cache = codec->reg_cache;
+		*value = cache[reg];
+	}
+	break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
+{
+	if (!codec->reg_cache)
+		return 0;
+	kfree(codec->reg_cache);
+	codec->reg_cache = NULL;
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
+		return -ENOMEM;
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
+	mutex_init(&codec->cache_rw_mutex);
+	codec->cache_ops = &cache_types[i];
+
+	if (codec->cache_ops->init)
+		return codec->cache_ops->init(codec);
+	return -EINVAL;
+}
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
+	mutex_lock(&codec->cache_rw_mutex);
+
+	if (value && codec->cache_ops && codec->cache_ops->read) {
+		ret = codec->cache_ops->read(codec, reg, value);
+		mutex_unlock(&codec->cache_rw_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&codec->cache_rw_mutex);
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
+	mutex_lock(&codec->cache_rw_mutex);
+
+	if (codec->cache_ops && codec->cache_ops->write) {
+		ret = codec->cache_ops->write(codec, reg, value);
+		mutex_unlock(&codec->cache_rw_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&codec->cache_rw_mutex);
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
index c18ce1d..f9f5f07 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3274,29 +3274,21 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
+	codec->dev = dev;
+	codec->driver = codec_drv;
+	codec->num_dai = num_dai;
+	mutex_init(&codec->mutex);
 
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
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
+		ret = snd_soc_cache_init(codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
+				ret);
+			goto error_cache;
 		}
 	}
 
-	codec->dev = dev;
-	codec->driver = codec_drv;
-	codec->num_dai = num_dai;
-	mutex_init(&codec->mutex);
-
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
@@ -3306,7 +3298,7 @@ int snd_soc_register_codec(struct device *dev,
 	if (num_dai) {
 		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
 		if (ret < 0)
-			goto error;
+			goto error_dais;
 	}
 
 	mutex_lock(&client_mutex);
@@ -3317,9 +3309,9 @@ int snd_soc_register_codec(struct device *dev,
 	pr_debug("Registered codec '%s'\n", codec->name);
 	return 0;
 
-error:
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+error_dais:
+	snd_soc_cache_exit(codec);
+error_cache:
 	kfree(codec->name);
 	kfree(codec);
 	return ret;
@@ -3353,8 +3345,7 @@ found:
 
 	pr_debug("Unregistered codec '%s'\n", codec->name);
 
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+	snd_soc_cache_exit(codec);
 	kfree(codec->name);
 	kfree(codec);
 }
-- 
1.7.3.2
