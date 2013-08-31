From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: Remove infrastructure for supporting
	multiple cache types
Date: Sat, 31 Aug 2013 20:31:15 +0200
Message-ID: <1377973875-2209-5-git-send-email-lars@metafoo.de>
References: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id C97FE26560E
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 20:29:50 +0200 (CEST)
In-Reply-To: <1377973875-2209-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The only cache type left is the flat cache and new other cache types won't be
added since new drivers are supposed to use regmap directly for IO and caching.
This patch removes the snd_soc_cache_ops indirection that was added to support
multiple cache types and modifies the code to always use the flat cache
directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   |  27 -------
 sound/soc/soc-cache.c | 195 +++++++++++++++-----------------------------------
 sound/soc/soc-core.c  |  27 +------
 3 files changed, 58 insertions(+), 191 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cd26858..df40f18 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -330,7 +330,6 @@ struct soc_enum;
 struct snd_soc_jack;
 struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
-struct snd_soc_cache_ops;
 #include <sound/soc-dapm.h>
 #include <sound/soc-dpcm.h>
 
@@ -348,10 +347,6 @@ enum snd_soc_control_type {
 	SND_SOC_REGMAP,
 };
 
-enum snd_soc_compress_type {
-	SND_SOC_FLAT_COMPRESSION = 1,
-};
-
 enum snd_soc_pcm_subclass {
 	SND_SOC_PCM_CLASS_PCM	= 0,
 	SND_SOC_PCM_CLASS_BE	= 1,
@@ -635,19 +630,6 @@ struct snd_soc_compr_ops {
 	int (*trigger)(struct snd_compr_stream *);
 };
 
-/* SoC cache ops */
-struct snd_soc_cache_ops {
-	const char *name;
-	enum snd_soc_compress_type id;
-	int (*init)(struct snd_soc_codec *codec);
-	int (*exit)(struct snd_soc_codec *codec);
-	int (*read)(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int *value);
-	int (*write)(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int value);
-	int (*sync)(struct snd_soc_codec *codec);
-};
-
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
@@ -661,7 +643,6 @@ struct snd_soc_codec {
 	struct list_head list;
 	struct list_head card_list;
 	int num_dai;
-	enum snd_soc_compress_type compress_type;
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 	int (*writable_register)(struct snd_soc_codec *, unsigned int);
@@ -686,7 +667,6 @@ struct snd_soc_codec {
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	void *reg_cache;
-	const struct snd_soc_cache_ops *cache_ops;
 	struct mutex cache_rw_mutex;
 	int val_bytes;
 
@@ -735,7 +715,6 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
-	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
 	int (*set_bias_level)(struct snd_soc_codec *,
@@ -913,12 +892,6 @@ struct snd_soc_codec_conf {
 	 * associated per device
 	 */
 	const char *name_prefix;
-
-	/*
-	 * set this to the desired compression type if you want to
-	 * override the one supplied in codec->driver->compress_type
-	 */
-	enum snd_soc_compress_type compress_type;
 };
 
 struct snd_soc_aux_dev {
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9542c83..1b6663f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -11,12 +11,9 @@
  *  option) any later version.
  */
 
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
 #include <sound/soc.h>
-#include <linux/bitmap.h>
-#include <linux/rbtree.h>
 #include <linux/export.h>
+#include <linux/slab.h>
 
 #include <trace/events/asoc.h>
 
@@ -66,66 +63,18 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 	return -1;
 }
 
-static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
-{
-	int i;
-	int ret;
-	const struct snd_soc_codec_driver *codec_drv;
-	unsigned int val;
-
-	codec_drv = codec->driver;
-	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
-		ret = snd_soc_cache_read(codec, i, &val);
-		if (ret)
-			return ret;
-		if (codec_drv->reg_cache_default)
-			if (snd_soc_get_cache_val(codec_drv->reg_cache_default,
-						  i, codec_drv->reg_word_size) == val)
-				continue;
-
-		WARN_ON(!snd_soc_codec_writable_register(codec, i));
-
-		ret = snd_soc_write(codec, i, val);
-		if (ret)
-			return ret;
-		dev_dbg(codec->dev, "ASoC: Synced register %#x, value = %#x\n",
-			i, val);
-	}
-	return 0;
-}
-
-static int snd_soc_flat_cache_write(struct snd_soc_codec *codec,
-				    unsigned int reg, unsigned int value)
-{
-	snd_soc_set_cache_val(codec->reg_cache, reg, value,
-			      codec->driver->reg_word_size);
-	return 0;
-}
-
-static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
-				   unsigned int reg, unsigned int *value)
-{
-	*value = snd_soc_get_cache_val(codec->reg_cache, reg,
-				       codec->driver->reg_word_size);
-	return 0;
-}
-
-static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
-{
-	if (!codec->reg_cache)
-		return 0;
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-	return 0;
-}
-
-static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
+int snd_soc_cache_init(struct snd_soc_codec *codec)
 {
 	const struct snd_soc_codec_driver *codec_drv = codec->driver;
 	size_t reg_size;
 
 	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
+	mutex_init(&codec->cache_rw_mutex);
+
+	dev_dbg(codec->dev, "ASoC: Initializing cache for %s codec\n",
+				codec->name);
+
 	if (codec_drv->reg_cache_default)
 		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
 					   reg_size, GFP_KERNEL);
@@ -137,60 +86,19 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/* an array of all supported compression types */
-static const struct snd_soc_cache_ops cache_types[] = {
-	/* Flat *must* be the first entry for fallback */
-	{
-		.id = SND_SOC_FLAT_COMPRESSION,
-		.name = "flat",
-		.init = snd_soc_flat_cache_init,
-		.exit = snd_soc_flat_cache_exit,
-		.read = snd_soc_flat_cache_read,
-		.write = snd_soc_flat_cache_write,
-		.sync = snd_soc_flat_cache_sync
-	},
-};
-
-int snd_soc_cache_init(struct snd_soc_codec *codec)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cache_types); ++i)
-		if (cache_types[i].id == codec->compress_type)
-			break;
-
-	/* Fall back to flat compression */
-	if (i == ARRAY_SIZE(cache_types)) {
-		dev_warn(codec->dev, "ASoC: Could not match compress type: %d\n",
-			 codec->compress_type);
-		i = 0;
-	}
-
-	mutex_init(&codec->cache_rw_mutex);
-	codec->cache_ops = &cache_types[i];
-
-	if (codec->cache_ops->init) {
-		if (codec->cache_ops->name)
-			dev_dbg(codec->dev, "ASoC: Initializing %s cache for %s codec\n",
-				codec->cache_ops->name, codec->name);
-		return codec->cache_ops->init(codec);
-	}
-	return -ENOSYS;
-}
-
 /*
  * NOTE: keep in mind that this function might be called
  * multiple times.
  */
 int snd_soc_cache_exit(struct snd_soc_codec *codec)
 {
-	if (codec->cache_ops && codec->cache_ops->exit) {
-		if (codec->cache_ops->name)
-			dev_dbg(codec->dev, "ASoC: Destroying %s cache for %s codec\n",
-				codec->cache_ops->name, codec->name);
-		return codec->cache_ops->exit(codec);
-	}
-	return -ENOSYS;
+	dev_dbg(codec->dev, "ASoC: Destroying cache for %s codec\n",
+			codec->name);
+	if (!codec->reg_cache)
+		return 0;
+	kfree(codec->reg_cache);
+	codec->reg_cache = NULL;
+	return 0;
 }
 
 /**
@@ -203,18 +111,15 @@ int snd_soc_cache_exit(struct snd_soc_codec *codec)
 int snd_soc_cache_read(struct snd_soc_codec *codec,
 		       unsigned int reg, unsigned int *value)
 {
-	int ret;
+	if (!value)
+		return -EINVAL;
 
 	mutex_lock(&codec->cache_rw_mutex);
-
-	if (value && codec->cache_ops && codec->cache_ops->read) {
-		ret = codec->cache_ops->read(codec, reg, value);
-		mutex_unlock(&codec->cache_rw_mutex);
-		return ret;
-	}
-
+	*value = snd_soc_get_cache_val(codec->reg_cache, reg,
+				       codec->driver->reg_word_size);
 	mutex_unlock(&codec->cache_rw_mutex);
-	return -ENOSYS;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_read);
 
@@ -228,20 +133,42 @@ EXPORT_SYMBOL_GPL(snd_soc_cache_read);
 int snd_soc_cache_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value)
 {
+	mutex_lock(&codec->cache_rw_mutex);
+	snd_soc_set_cache_val(codec->reg_cache, reg, value,
+			      codec->driver->reg_word_size);
+	mutex_unlock(&codec->cache_rw_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_cache_write);
+
+static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
+{
+	int i;
 	int ret;
+	const struct snd_soc_codec_driver *codec_drv;
+	unsigned int val;
 
-	mutex_lock(&codec->cache_rw_mutex);
+	codec_drv = codec->driver;
+	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+		ret = snd_soc_cache_read(codec, i, &val);
+		if (ret)
+			return ret;
+		if (codec_drv->reg_cache_default)
+			if (snd_soc_get_cache_val(codec_drv->reg_cache_default,
+						  i, codec_drv->reg_word_size) == val)
+				continue;
 
-	if (codec->cache_ops && codec->cache_ops->write) {
-		ret = codec->cache_ops->write(codec, reg, value);
-		mutex_unlock(&codec->cache_rw_mutex);
-		return ret;
-	}
+		WARN_ON(!snd_soc_codec_writable_register(codec, i));
 
-	mutex_unlock(&codec->cache_rw_mutex);
-	return -ENOSYS;
+		ret = snd_soc_write(codec, i, val);
+		if (ret)
+			return ret;
+		dev_dbg(codec->dev, "ASoC: Synced register %#x, value = %#x\n",
+			i, val);
+	}
+	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_cache_write);
 
 /**
  * snd_soc_cache_sync: Sync the register cache with the hardware.
@@ -254,26 +181,16 @@ EXPORT_SYMBOL_GPL(snd_soc_cache_write);
  */
 int snd_soc_cache_sync(struct snd_soc_codec *codec)
 {
+	const char *name = "flat";
 	int ret;
-	const char *name;
 
-	if (!codec->cache_sync) {
+	if (!codec->cache_sync)
 		return 0;
-	}
-
-	if (!codec->cache_ops || !codec->cache_ops->sync)
-		return -ENOSYS;
-
-	if (codec->cache_ops->name)
-		name = codec->cache_ops->name;
-	else
-		name = "unknown";
 
-	if (codec->cache_ops->name)
-		dev_dbg(codec->dev, "ASoC: Syncing %s cache for %s codec\n",
-			codec->cache_ops->name, codec->name);
+	dev_dbg(codec->dev, "ASoC: Syncing cache for %s codec\n",
+		codec->name);
 	trace_snd_soc_cache_sync(codec, name, "start");
-	ret = codec->cache_ops->sync(codec);
+	ret = snd_soc_flat_cache_sync(codec);
 	if (!ret)
 		codec->cache_sync = 0;
 	trace_snd_soc_cache_sync(codec, name, "end");
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 14cc60c..eca209e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1588,17 +1588,13 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 		soc_remove_codec(codec);
 }
 
-static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
-				    enum snd_soc_compress_type compress_type)
+static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
 {
 	int ret;
 
 	if (codec->cache_init)
 		return 0;
 
-	/* override the compress_type if necessary */
-	if (compress_type && codec->compress_type != compress_type)
-		codec->compress_type = compress_type;
 	ret = snd_soc_cache_init(codec);
 	if (ret < 0) {
 		dev_err(codec->dev,
@@ -1613,8 +1609,6 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
-	struct snd_soc_codec_conf *codec_conf;
-	enum snd_soc_compress_type compress_type;
 	struct snd_soc_dai_link *dai_link;
 	int ret, i, order, dai_fmt;
 
@@ -1638,19 +1632,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
 			continue;
-		/* by default we don't override the compress_type */
-		compress_type = 0;
-		/* check to see if we need to override the compress_type */
-		for (i = 0; i < card->num_configs; ++i) {
-			codec_conf = &card->codec_conf[i];
-			if (!strcmp(codec->name, codec_conf->dev_name)) {
-				compress_type = codec_conf->compress_type;
-				if (compress_type && compress_type
-				    != codec->compress_type)
-					break;
-			}
-		}
-		ret = snd_soc_init_codec_cache(codec, compress_type);
+		ret = snd_soc_init_codec_cache(codec);
 		if (ret < 0)
 			goto base_error;
 	}
@@ -4173,11 +4155,6 @@ int snd_soc_register_codec(struct device *dev,
 		goto fail_codec;
 	}
 
-	if (codec_drv->compress_type)
-		codec->compress_type = codec_drv->compress_type;
-	else
-		codec->compress_type = SND_SOC_FLAT_COMPRESSION;
-
 	codec->write = codec_drv->write;
 	codec->read = codec_drv->read;
 	codec->volatile_register = codec_drv->volatile_register;
-- 
1.8.0
