From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Remove snd_soc_cache_sync()
	implementation
Date: Sat,  8 Nov 2014 16:38:07 +0100
Message-ID: <1415461087-31162-2-git-send-email-lars@metafoo.de>
References: <1415461087-31162-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E4A74260493
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 16:38:04 +0100 (CET)
In-Reply-To: <1415461087-31162-1-git-send-email-lars@metafoo.de>
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

This function has no more non regmap user, which means we can remove the
implementation of the function and associated functions and structure
fields.

For convenience we keep a static inline version of the function that
forwards calls to regcache_sync() unconditionally.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h         |  19 ++++--
 include/trace/events/asoc.h |  25 --------
 sound/soc/soc-cache.c       | 152 --------------------------------------------
 sound/soc/soc-core.c        |   4 --
 4 files changed, 12 insertions(+), 188 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index edbb07b..8a6215c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -412,13 +412,9 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
-int snd_soc_cache_sync(struct snd_soc_codec *codec);
 int snd_soc_cache_init(struct snd_soc_codec *codec);
 int snd_soc_cache_exit(struct snd_soc_codec *codec);
-int snd_soc_cache_write(struct snd_soc_codec *codec,
-			unsigned int reg, unsigned int value);
-int snd_soc_cache_read(struct snd_soc_codec *codec,
-		       unsigned int reg, unsigned int *value);
+
 int snd_soc_platform_read(struct snd_soc_platform *platform,
 					unsigned int reg);
 int snd_soc_platform_write(struct snd_soc_platform *platform,
@@ -788,13 +784,11 @@ struct snd_soc_codec {
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int cache_init:1; /* codec cache has been initialized */
-	u32 cache_sync; /* Cache needs to be synced to hardware */
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
 	hw_write_t hw_write;
 	void *reg_cache;
-	struct mutex cache_rw_mutex;
 
 	/* component */
 	struct snd_soc_component component;
@@ -1257,6 +1251,17 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val);
 
+/**
+ * snd_soc_cache_sync() - Sync the register cache with the hardware
+ * @codec: CODEC to sync
+ *
+ * Note: This function will call regcache_sync()
+ */
+static inline int snd_soc_cache_sync(struct snd_soc_codec *codec)
+{
+	return regcache_sync(codec->component.regmap);
+}
+
 /* component IO */
 int snd_soc_component_read(struct snd_soc_component *component,
 	unsigned int reg, unsigned int *val);
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index b04ee7e..88cf39d 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -288,31 +288,6 @@ TRACE_EVENT(snd_soc_jack_notify,
 	TP_printk("jack=%s %x", __get_str(name), (int)__entry->val)
 );
 
-TRACE_EVENT(snd_soc_cache_sync,
-
-	TP_PROTO(struct snd_soc_codec *codec, const char *type,
-		 const char *status),
-
-	TP_ARGS(codec, type, status),
-
-	TP_STRUCT__entry(
-		__string(	name,		codec->component.name)
-		__string(	status,		status		)
-		__string(	type,		type		)
-		__field(	int,		id		)
-	),
-
-	TP_fast_assign(
-		__assign_str(name, codec->component.name);
-		__assign_str(status, status);
-		__assign_str(type, type);
-		__entry->id = codec->component.id;
-	),
-
-	TP_printk("codec=%s.%d type=%s status=%s", __get_str(name),
-		  (int)__entry->id, __get_str(type), __get_str(status))
-);
-
 #endif /* _TRACE_ASOC_H */
 
 /* This part must be outside protection */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 6dab817..07f4335 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -15,56 +15,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 
-#include <trace/events/asoc.h>
-
-static bool snd_soc_set_cache_val(void *base, unsigned int idx,
-				  unsigned int val, unsigned int word_size)
-{
-	switch (word_size) {
-	case 1: {
-		u8 *cache = base;
-		if (cache[idx] == val)
-			return true;
-		cache[idx] = val;
-		break;
-	}
-	case 2: {
-		u16 *cache = base;
-		if (cache[idx] == val)
-			return true;
-		cache[idx] = val;
-		break;
-	}
-	default:
-		WARN(1, "Invalid word_size %d\n", word_size);
-		break;
-	}
-	return false;
-}
-
-static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
-		unsigned int word_size)
-{
-	if (!base)
-		return -1;
-
-	switch (word_size) {
-	case 1: {
-		const u8 *cache = base;
-		return cache[idx];
-	}
-	case 2: {
-		const u16 *cache = base;
-		return cache[idx];
-	}
-	default:
-		WARN(1, "Invalid word_size %d\n", word_size);
-		break;
-	}
-	/* unreachable */
-	return -1;
-}
-
 int snd_soc_cache_init(struct snd_soc_codec *codec)
 {
 	const struct snd_soc_codec_driver *codec_drv = codec->driver;
@@ -75,8 +25,6 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	if (!reg_size)
 		return 0;
 
-	mutex_init(&codec->cache_rw_mutex);
-
 	dev_dbg(codec->dev, "ASoC: Initializing cache for %s codec\n",
 				codec->component.name);
 
@@ -103,103 +51,3 @@ int snd_soc_cache_exit(struct snd_soc_codec *codec)
 	codec->reg_cache = NULL;
 	return 0;
 }
-
-/**
- * snd_soc_cache_read: Fetch the value of a given register from the cache.
- *
- * @codec: CODEC to configure.
- * @reg: The register index.
- * @value: The value to be returned.
- */
-int snd_soc_cache_read(struct snd_soc_codec *codec,
-		       unsigned int reg, unsigned int *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	mutex_lock(&codec->cache_rw_mutex);
-	if (!ZERO_OR_NULL_PTR(codec->reg_cache))
-		*value = snd_soc_get_cache_val(codec->reg_cache, reg,
-					       codec->driver->reg_word_size);
-	mutex_unlock(&codec->cache_rw_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_cache_read);
-
-/**
- * snd_soc_cache_write: Set the value of a given register in the cache.
- *
- * @codec: CODEC to configure.
- * @reg: The register index.
- * @value: The new register value.
- */
-int snd_soc_cache_write(struct snd_soc_codec *codec,
-			unsigned int reg, unsigned int value)
-{
-	mutex_lock(&codec->cache_rw_mutex);
-	if (!ZERO_OR_NULL_PTR(codec->reg_cache))
-		snd_soc_set_cache_val(codec->reg_cache, reg, value,
-				      codec->driver->reg_word_size);
-	mutex_unlock(&codec->cache_rw_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_cache_write);
-
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
-		ret = snd_soc_write(codec, i, val);
-		if (ret)
-			return ret;
-		dev_dbg(codec->dev, "ASoC: Synced register %#x, value = %#x\n",
-			i, val);
-	}
-	return 0;
-}
-
-/**
- * snd_soc_cache_sync: Sync the register cache with the hardware.
- *
- * @codec: CODEC to configure.
- *
- * Any registers that should not be synced should be marked as
- * volatile.  In general drivers can choose not to use the provided
- * syncing functionality if they so require.
- */
-int snd_soc_cache_sync(struct snd_soc_codec *codec)
-{
-	const char *name = "flat";
-	int ret;
-
-	if (codec->component.regmap)
-		return regcache_sync(codec->component.regmap);
-
-	if (!codec->cache_sync)
-		return 0;
-
-	dev_dbg(codec->dev, "ASoC: Syncing cache for %s codec\n",
-		codec->component.name);
-	trace_snd_soc_cache_sync(codec, name, "start");
-	ret = snd_soc_flat_cache_sync(codec);
-	if (!ret)
-		codec->cache_sync = 0;
-	trace_snd_soc_cache_sync(codec, name, "end");
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 333f112..397d00a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -309,9 +309,6 @@ static void soc_init_codec_debugfs(struct snd_soc_component *component)
 {
 	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	debugfs_create_bool("cache_sync", 0444, codec->component.debugfs_root,
-			    &codec->cache_sync);
-
 	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
 						 codec->component.debugfs_root,
 						 codec, &codec_reg_fops);
@@ -651,7 +648,6 @@ int snd_soc_suspend(struct device *dev)
 				if (codec->driver->suspend)
 					codec->driver->suspend(codec);
 				codec->suspended = 1;
-				codec->cache_sync = 1;
 				if (codec->component.regmap)
 					regcache_mark_dirty(codec->component.regmap);
 				/* deactivate pins to sleep state */
-- 
1.8.0
