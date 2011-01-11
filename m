From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Clean up the cache
	manipulation code
Date: Tue, 11 Jan 2011 11:29:49 +0000
Message-ID: <1294745389-32760-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC2B3245CF
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:29:51 +0100 (CET)
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

Use Takashi's clean up code to make the cache manipulation code more
readable.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  230 +++++++++++++++++-------------------------------
 1 files changed, 82 insertions(+), 148 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8c2a21a..b0d86cc 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -761,6 +761,49 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
 
+static bool snd_soc_set_cache_val(void *base, unsigned int idx,
+				  unsigned int val, unsigned int word_size)
+{
+	switch (word_size) {
+	case 1: {
+		u8 *cache = base;
+		if (cache[idx] == val)
+			return true;
+		cache[idx] = val;
+		break;
+	}
+	case 2: {
+		u16 *cache = base;
+		if (cache[idx] == val)
+			return true;
+		cache[idx] = val;
+		break;
+	}
+	default:
+		BUG();
+	}
+	return false;
+}
+
+static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
+		unsigned int word_size)
+{
+	switch (word_size) {
+	case 1: {
+		const u8 *cache = base;
+		return cache[idx];
+	}
+	case 2: {
+		const u16 *cache = base;
+		return cache[idx];
+	}
+	default:
+		BUG();
+	}
+	/* unreachable */
+	return -1;
+}
+
 struct snd_soc_rbtree_node {
 	struct rb_node node;
 	unsigned int reg;
@@ -924,7 +967,12 @@ static int snd_soc_rbtree_cache_exit(struct snd_soc_codec *codec)
 
 static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 {
+	struct snd_soc_rbtree_node *rbtree_node;
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
+	unsigned int val;
+	unsigned int word_size;
+	int i;
+	int ret;
 
 	codec->reg_cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
 	if (!codec->reg_cache)
@@ -936,53 +984,25 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	if (!codec->reg_def_copy)
 		return 0;
 
-/*
- * populate the rbtree with the initialized registers.  All other
- * registers will be inserted into the tree when they are first written.
- *
- * The reasoning behind this, is that we need to step through and
- * dereference the cache in u8/u16 increments without sacrificing
- * portability.  This could also be done using memcpy() but that would
- * be slightly more cryptic.
- */
-#define snd_soc_rbtree_populate(cache)					\
-({									\
-	int ret, i;							\
-	struct snd_soc_rbtree_node *rbtree_node;			\
-									\
-	ret = 0;							\
-	cache = codec->reg_def_copy;					\
-	for (i = 0; i < codec->driver->reg_cache_size; ++i) {		\
-		if (!cache[i])						\
-			continue;					\
-		rbtree_node = kzalloc(sizeof *rbtree_node, GFP_KERNEL);	\
-		if (!rbtree_node) {					\
-			ret = -ENOMEM;					\
-			snd_soc_cache_exit(codec);			\
-			break;						\
-		}							\
-		rbtree_node->reg = i;					\
-		rbtree_node->value = cache[i];				\
-		rbtree_node->defval = cache[i];				\
-		snd_soc_rbtree_insert(&rbtree_ctx->root,		\
-				      rbtree_node);			\
-	}								\
-	ret;								\
-})
-
-	switch (codec->driver->reg_word_size) {
-	case 1: {
-		const u8 *cache;
-
-		return snd_soc_rbtree_populate(cache);
-	}
-	case 2: {
-		const u16 *cache;
-
-		return snd_soc_rbtree_populate(cache);
-	}
-	default:
-		BUG();
+	/*
+	 * populate the rbtree with the initialized registers.  All other
+	 * registers will be inserted when they are first modified.
+	 */
+	word_size = codec->driver->reg_word_size;
+	for (i = 0; i < codec->driver->reg_cache_size; ++i) {
+		val = snd_soc_get_cache_val(codec->reg_def_copy, i, word_size);
+		if (!val)
+			continue;
+		rbtree_node = kzalloc(sizeof *rbtree_node, GFP_KERNEL);
+		if (!rbtree_node) {
+			ret = -ENOMEM;
+			snd_soc_cache_exit(codec);
+			break;
+		}
+		rbtree_node->reg = i;
+		rbtree_node->value = val;
+		rbtree_node->defval = val;
+		snd_soc_rbtree_insert(&rbtree_ctx->root, rbtree_node);
 	}
 
 	return 0;
@@ -1165,29 +1185,10 @@ static int snd_soc_lzo_cache_write(struct snd_soc_codec *codec,
 	}
 
 	/* write the new value to the cache */
-	switch (codec->driver->reg_word_size) {
-	case 1: {
-		u8 *cache;
-		cache = lzo_block->dst;
-		if (cache[blkpos] == value) {
-			kfree(lzo_block->dst);
-			goto out;
-		}
-		cache[blkpos] = value;
-	}
-	break;
-	case 2: {
-		u16 *cache;
-		cache = lzo_block->dst;
-		if (cache[blkpos] == value) {
-			kfree(lzo_block->dst);
-			goto out;
-		}
-		cache[blkpos] = value;
-	}
-	break;
-	default:
-		BUG();
+	if (snd_soc_set_cache_val(lzo_block->dst, blkpos, value,
+				  codec->driver->reg_word_size)) {
+		kfree(lzo_block->dst);
+		goto out;
 	}
 
 	/* prepare the source to be the decompressed block */
@@ -1241,25 +1242,10 @@ static int snd_soc_lzo_cache_read(struct snd_soc_codec *codec,
 
 	/* decompress the block */
 	ret = snd_soc_lzo_decompress_cache_block(codec, lzo_block);
-	if (ret >= 0) {
+	if (ret >= 0)
 		/* fetch the value from the cache */
-		switch (codec->driver->reg_word_size) {
-		case 1: {
-			u8 *cache;
-			cache = lzo_block->dst;
-			*value = cache[blkpos];
-		}
-		break;
-		case 2: {
-			u16 *cache;
-			cache = lzo_block->dst;
-			*value = cache[blkpos];
-		}
-		break;
-		default:
-			BUG();
-		}
-	}
+		*value = snd_soc_get_cache_val(lzo_block->dst, blkpos,
+					       codec->driver->reg_word_size);
 
 	kfree(lzo_block->dst);
 	/* restore the pointer and length of the compressed block */
@@ -1414,28 +1400,10 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
-		if (codec_drv->reg_cache_default) {
-			switch (codec_drv->reg_word_size) {
-			case 1: {
-				const u8 *cache;
-
-				cache = codec_drv->reg_cache_default;
-				if (cache[i] == val)
-					continue;
-			}
-			break;
-			case 2: {
-				const u16 *cache;
-
-				cache = codec_drv->reg_cache_default;
-				if (cache[i] == val)
-					continue;
-			}
-			break;
-			default:
-				BUG();
-			}
-		}
+		if (codec_drv->reg_cache_default)
+			if (snd_soc_get_cache_val(codec_drv->reg_cache_default,
+						  i, codec_drv->reg_word_size) == val)
+				continue;
 		ret = snd_soc_write(codec, i, val);
 		if (ret)
 			return ret;
@@ -1448,50 +1416,16 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 static int snd_soc_flat_cache_write(struct snd_soc_codec *codec,
 				    unsigned int reg, unsigned int value)
 {
-	switch (codec->driver->reg_word_size) {
-	case 1: {
-		u8 *cache;
-
-		cache = codec->reg_cache;
-		cache[reg] = value;
-	}
-	break;
-	case 2: {
-		u16 *cache;
-
-		cache = codec->reg_cache;
-		cache[reg] = value;
-	}
-	break;
-	default:
-		BUG();
-	}
-
+	snd_soc_set_cache_val(codec->reg_cache, reg, value,
+			      codec->driver->reg_word_size);
 	return 0;
 }
 
 static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
 				   unsigned int reg, unsigned int *value)
 {
-	switch (codec->driver->reg_word_size) {
-	case 1: {
-		u8 *cache;
-
-		cache = codec->reg_cache;
-		*value = cache[reg];
-	}
-	break;
-	case 2: {
-		u16 *cache;
-
-		cache = codec->reg_cache;
-		*value = cache[reg];
-	}
-	break;
-	default:
-		BUG();
-	}
-
+	*value = snd_soc_get_cache_val(codec->reg_cache, reg,
+				       codec->driver->reg_word_size);
 	return 0;
 }
 
-- 
1.7.3.5
