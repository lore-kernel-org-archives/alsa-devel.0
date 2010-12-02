From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy instead
	of reg_cache_default
Date: Thu,  2 Dec 2010 16:11:05 +0000
Message-ID: <1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A2C3244BB
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:11:14 +0100 (CET)
In-Reply-To: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

Make sure to use codec->reg_def_copy instead of codec_drv->reg_cache_default
wherever necessary.  This change is necessary because in the next patch we
move the cache initialization code outside snd_soc_register_codec() and by that
time any data marked as __devinitconst such as the original reg_cache_default
array might have already been freed by the kernel.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   36 ++++++++++++++++++++++++------------
 sound/soc/soc-core.c  |   17 +++++++++++++++++
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4409e97..4cdba68 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -478,6 +478,7 @@ struct snd_soc_codec {
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
+	const void *reg_def_copy;
 	const struct snd_soc_cache_ops *cache_ops;
 	struct mutex cache_rw_mutex;
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 081221d..f8e285d 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -933,7 +933,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	rbtree_ctx = codec->reg_cache;
 	rbtree_ctx->root = RB_ROOT;
 
-	if (!codec->driver->reg_cache_default)
+	if (!codec->reg_def_copy)
 		return 0;
 
 /*
@@ -951,7 +951,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	struct snd_soc_rbtree_node *rbtree_node;			\
 									\
 	ret = 0;							\
-	cache = codec->driver->reg_cache_default;			\
+	cache = codec->reg_def_copy;					\
 	for (i = 0; i < codec->driver->reg_cache_size; ++i) {		\
 		if (!cache[i])						\
 			continue;					\
@@ -1316,13 +1316,13 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 	 * and remember to free it afterwards.
 	 */
 	tofree = 0;
-	if (!codec_drv->reg_cache_default)
+	if (!codec->reg_def_copy)
 		tofree = 1;
 
-	if (!codec_drv->reg_cache_default) {
-		codec_drv->reg_cache_default = kzalloc(reg_size,
+	if (!codec->reg_def_copy) {
+		codec->reg_def_copy = kzalloc(reg_size,
 						       GFP_KERNEL);
-		if (!codec_drv->reg_cache_default)
+		if (!codec->reg_def_copy)
 			return -ENOMEM;
 	}
 
@@ -1368,8 +1368,8 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 	}
 
 	blksize = snd_soc_lzo_get_blksize(codec);
-	p = codec_drv->reg_cache_default;
-	end = codec_drv->reg_cache_default + reg_size;
+	p = codec->reg_def_copy;
+	end = codec->reg_def_copy + reg_size;
 	/* compress the register map and fill the lzo blocks */
 	for (i = 0; i < blkcount; ++i, p += blksize) {
 		lzo_blocks[i]->src = p;
@@ -1385,14 +1385,18 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 			lzo_blocks[i]->src_len;
 	}
 
-	if (tofree)
-		kfree(codec_drv->reg_cache_default);
+	if (tofree) {
+		kfree(codec->reg_def_copy);
+		codec->reg_def_copy = NULL;
+	}
 	return 0;
 err:
 	snd_soc_cache_exit(codec);
 err_tofree:
-	if (tofree)
-		kfree(codec_drv->reg_cache_default);
+	if (tofree) {
+		kfree(codec->reg_def_copy);
+		codec->reg_def_copy = NULL;
+	}
 	return ret;
 }
 
@@ -1506,6 +1510,14 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 	codec_drv = codec->driver;
 	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
+	/*
+	 * for flat compression, we don't need to keep a copy of the
+	 * original defaults register cache as it will definitely not
+	 * be marked as __devinitconst
+	 */
+	kfree(codec->reg_def_copy);
+	codec->reg_def_copy = NULL;
+
 	if (codec_drv->reg_cache_default)
 		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
 					   reg_size, GFP_KERNEL);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a6565eb..9d9364a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3430,6 +3430,7 @@ int snd_soc_register_codec(struct device *dev,
 		struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai)
 {
+	size_t reg_size;
 	struct snd_soc_codec *codec;
 	int ret, i;
 
@@ -3463,6 +3464,19 @@ int snd_soc_register_codec(struct device *dev,
 
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
+		reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+		/* it is necessary to make a copy of the default register cache
+		 * because in the case of using a compression type that requires
+		 * the default register cache to be marked as __devinitconst the
+		 * kernel might have freed the array by the time we initialize
+		 * the cache.
+		 */
+		codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
+					      reg_size, GFP_KERNEL);
+		if (!codec->reg_def_copy) {
+			ret = -ENOMEM;
+			goto error_cache;
+		}
 		ret = snd_soc_cache_init(codec);
 		if (ret < 0) {
 			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
@@ -3494,6 +3508,8 @@ int snd_soc_register_codec(struct device *dev,
 error_dais:
 	snd_soc_cache_exit(codec);
 error_cache:
+	kfree(codec->reg_def_copy);
+	codec->reg_def_copy = NULL;
 	kfree(codec->name);
 	kfree(codec);
 	return ret;
@@ -3528,6 +3544,7 @@ found:
 	pr_debug("Unregistered codec '%s'\n", codec->name);
 
 	snd_soc_cache_exit(codec);
+	kfree(codec->reg_def_copy);
 	kfree(codec->name);
 	kfree(codec);
 }
-- 
1.7.3.2
