From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove LZO cache type
Date: Thu, 10 Nov 2011 13:07:42 +0000
Message-ID: <1320930462-4797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25EAB103AC4
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 14:07:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There are no current users and new drivers ought to be using the regmap
API and its cache implementation directly so just delete the ASoC copy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 -
 sound/soc/Kconfig     |   15 --
 sound/soc/soc-cache.c |  384 -------------------------------------------------
 3 files changed, 0 insertions(+), 400 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c39ac19..c12cee6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -273,7 +273,6 @@ enum snd_soc_control_type {
 
 enum snd_soc_compress_type {
 	SND_SOC_FLAT_COMPRESSION = 1,
-	SND_SOC_LZO_COMPRESSION,
 	SND_SOC_RBTREE_COMPRESSION
 };
 
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1381db8..35e662d 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -22,21 +22,6 @@ menuconfig SND_SOC
 
 if SND_SOC
 
-config SND_SOC_CACHE_LZO
-	bool "Support LZO compression for register caches"
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-	---help---
-	   Select this to enable LZO compression for register caches.
-	   This will allow machine or CODEC drivers to compress register
-	   caches in memory, reducing the memory consumption at the
-	   expense of performance.  If this is not present and is used
-	   the system will fall back to uncompressed caches.
-
-	   Usually it is safe to disable this option, where cache
-	   compression in used the rbtree option will typically perform
-	   better.
-
 config SND_SOC_AC97_BUS
 	bool
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9077aa4..18bb6b3 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -14,7 +14,6 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
-#include <linux/lzo.h>
 #include <linux/bitmap.h>
 #include <linux/rbtree.h>
 #include <linux/export.h>
@@ -439,378 +438,6 @@ err:
 	return ret;
 }
 
-#ifdef CONFIG_SND_SOC_CACHE_LZO
-struct snd_soc_lzo_ctx {
-	void *wmem;
-	void *dst;
-	const void *src;
-	size_t src_len;
-	size_t dst_len;
-	size_t decompressed_size;
-	unsigned long *sync_bmp;
-	int sync_bmp_nbits;
-};
-
-#define LZO_BLOCK_NUM 8
-static int snd_soc_lzo_block_count(void)
-{
-	return LZO_BLOCK_NUM;
-}
-
-static int snd_soc_lzo_prepare(struct snd_soc_lzo_ctx *lzo_ctx)
-{
-	lzo_ctx->wmem = kmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
-	if (!lzo_ctx->wmem)
-		return -ENOMEM;
-	return 0;
-}
-
-static int snd_soc_lzo_compress(struct snd_soc_lzo_ctx *lzo_ctx)
-{
-	size_t compress_size;
-	int ret;
-
-	ret = lzo1x_1_compress(lzo_ctx->src, lzo_ctx->src_len,
-			       lzo_ctx->dst, &compress_size, lzo_ctx->wmem);
-	if (ret != LZO_E_OK || compress_size > lzo_ctx->dst_len)
-		return -EINVAL;
-	lzo_ctx->dst_len = compress_size;
-	return 0;
-}
-
-static int snd_soc_lzo_decompress(struct snd_soc_lzo_ctx *lzo_ctx)
-{
-	size_t dst_len;
-	int ret;
-
-	dst_len = lzo_ctx->dst_len;
-	ret = lzo1x_decompress_safe(lzo_ctx->src, lzo_ctx->src_len,
-				    lzo_ctx->dst, &dst_len);
-	if (ret != LZO_E_OK || dst_len != lzo_ctx->dst_len)
-		return -EINVAL;
-	return 0;
-}
-
-static int snd_soc_lzo_compress_cache_block(struct snd_soc_codec *codec,
-		struct snd_soc_lzo_ctx *lzo_ctx)
-{
-	int ret;
-
-	lzo_ctx->dst_len = lzo1x_worst_compress(PAGE_SIZE);
-	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
-	if (!lzo_ctx->dst) {
-		lzo_ctx->dst_len = 0;
-		return -ENOMEM;
-	}
-
-	ret = snd_soc_lzo_compress(lzo_ctx);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static int snd_soc_lzo_decompress_cache_block(struct snd_soc_codec *codec,
-		struct snd_soc_lzo_ctx *lzo_ctx)
-{
-	int ret;
-
-	lzo_ctx->dst_len = lzo_ctx->decompressed_size;
-	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
-	if (!lzo_ctx->dst) {
-		lzo_ctx->dst_len = 0;
-		return -ENOMEM;
-	}
-
-	ret = snd_soc_lzo_decompress(lzo_ctx);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static inline int snd_soc_lzo_get_blkindex(struct snd_soc_codec *codec,
-		unsigned int reg)
-{
-	const struct snd_soc_codec_driver *codec_drv;
-
-	codec_drv = codec->driver;
-	return (reg * codec_drv->reg_word_size) /
-	       DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count());
-}
-
-static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
-		unsigned int reg)
-{
-	const struct snd_soc_codec_driver *codec_drv;
-
-	codec_drv = codec->driver;
-	return reg % (DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count()) /
-		      codec_drv->reg_word_size);
-}
-
-static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
-{
-	return DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count());
-}
-
-static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
-{
-	struct snd_soc_lzo_ctx **lzo_blocks;
-	unsigned int val;
-	int i;
-	int ret;
-
-	lzo_blocks = codec->reg_cache;
-	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
-		WARN_ON(!snd_soc_codec_writable_register(codec, i));
-		ret = snd_soc_cache_read(codec, i, &val);
-		if (ret)
-			return ret;
-		codec->cache_bypass = 1;
-		ret = snd_soc_write(codec, i, val);
-		codec->cache_bypass = 0;
-		if (ret)
-			return ret;
-		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
-			i, val);
-	}
-
-	return 0;
-}
-
-static int snd_soc_lzo_cache_write(struct snd_soc_codec *codec,
-				   unsigned int reg, unsigned int value)
-{
-	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
-	int ret, blkindex, blkpos;
-	size_t blksize, tmp_dst_len;
-	void *tmp_dst;
-
-	/* index of the compressed lzo block */
-	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
-	/* register index within the decompressed block */
-	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
-	/* size of the compressed block */
-	blksize = snd_soc_lzo_get_blksize(codec);
-	lzo_blocks = codec->reg_cache;
-	lzo_block = lzo_blocks[blkindex];
-
-	/* save the pointer and length of the compressed block */
-	tmp_dst = lzo_block->dst;
-	tmp_dst_len = lzo_block->dst_len;
-
-	/* prepare the source to be the compressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* decompress the block */
-	ret = snd_soc_lzo_decompress_cache_block(codec, lzo_block);
-	if (ret < 0) {
-		kfree(lzo_block->dst);
-		goto out;
-	}
-
-	/* write the new value to the cache */
-	if (snd_soc_set_cache_val(lzo_block->dst, blkpos, value,
-				  codec->driver->reg_word_size)) {
-		kfree(lzo_block->dst);
-		goto out;
-	}
-
-	/* prepare the source to be the decompressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* compress the block */
-	ret = snd_soc_lzo_compress_cache_block(codec, lzo_block);
-	if (ret < 0) {
-		kfree(lzo_block->dst);
-		kfree(lzo_block->src);
-		goto out;
-	}
-
-	/* set the bit so we know we have to sync this register */
-	set_bit(reg, lzo_block->sync_bmp);
-	kfree(tmp_dst);
-	kfree(lzo_block->src);
-	return 0;
-out:
-	lzo_block->dst = tmp_dst;
-	lzo_block->dst_len = tmp_dst_len;
-	return ret;
-}
-
-static int snd_soc_lzo_cache_read(struct snd_soc_codec *codec,
-				  unsigned int reg, unsigned int *value)
-{
-	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
-	int ret, blkindex, blkpos;
-	size_t blksize, tmp_dst_len;
-	void *tmp_dst;
-
-	*value = 0;
-	/* index of the compressed lzo block */
-	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
-	/* register index within the decompressed block */
-	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
-	/* size of the compressed block */
-	blksize = snd_soc_lzo_get_blksize(codec);
-	lzo_blocks = codec->reg_cache;
-	lzo_block = lzo_blocks[blkindex];
-
-	/* save the pointer and length of the compressed block */
-	tmp_dst = lzo_block->dst;
-	tmp_dst_len = lzo_block->dst_len;
-
-	/* prepare the source to be the compressed block */
-	lzo_block->src = lzo_block->dst;
-	lzo_block->src_len = lzo_block->dst_len;
-
-	/* decompress the block */
-	ret = snd_soc_lzo_decompress_cache_block(codec, lzo_block);
-	if (ret >= 0)
-		/* fetch the value from the cache */
-		*value = snd_soc_get_cache_val(lzo_block->dst, blkpos,
-					       codec->driver->reg_word_size);
-
-	kfree(lzo_block->dst);
-	/* restore the pointer and length of the compressed block */
-	lzo_block->dst = tmp_dst;
-	lzo_block->dst_len = tmp_dst_len;
-	return 0;
-}
-
-static int snd_soc_lzo_cache_exit(struct snd_soc_codec *codec)
-{
-	struct snd_soc_lzo_ctx **lzo_blocks;
-	int i, blkcount;
-
-	lzo_blocks = codec->reg_cache;
-	if (!lzo_blocks)
-		return 0;
-
-	blkcount = snd_soc_lzo_block_count();
-	/*
-	 * the pointer to the bitmap used for syncing the cache
-	 * is shared amongst all lzo_blocks.  Ensure it is freed
-	 * only once.
-	 */
-	if (lzo_blocks[0])
-		kfree(lzo_blocks[0]->sync_bmp);
-	for (i = 0; i < blkcount; ++i) {
-		if (lzo_blocks[i]) {
-			kfree(lzo_blocks[i]->wmem);
-			kfree(lzo_blocks[i]->dst);
-		}
-		/* each lzo_block is a pointer returned by kmalloc or NULL */
-		kfree(lzo_blocks[i]);
-	}
-	kfree(lzo_blocks);
-	codec->reg_cache = NULL;
-	return 0;
-}
-
-static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
-{
-	struct snd_soc_lzo_ctx **lzo_blocks;
-	size_t bmp_size;
-	const struct snd_soc_codec_driver *codec_drv;
-	int ret, tofree, i, blksize, blkcount;
-	const char *p, *end;
-	unsigned long *sync_bmp;
-
-	ret = 0;
-	codec_drv = codec->driver;
-
-	/*
-	 * If we have not been given a default register cache
-	 * then allocate a dummy zero-ed out region, compress it
-	 * and remember to free it afterwards.
-	 */
-	tofree = 0;
-	if (!codec->reg_def_copy)
-		tofree = 1;
-
-	if (!codec->reg_def_copy) {
-		codec->reg_def_copy = kzalloc(codec->reg_size, GFP_KERNEL);
-		if (!codec->reg_def_copy)
-			return -ENOMEM;
-	}
-
-	blkcount = snd_soc_lzo_block_count();
-	codec->reg_cache = kzalloc(blkcount * sizeof *lzo_blocks,
-				   GFP_KERNEL);
-	if (!codec->reg_cache) {
-		ret = -ENOMEM;
-		goto err_tofree;
-	}
-	lzo_blocks = codec->reg_cache;
-
-	/*
-	 * allocate a bitmap to be used when syncing the cache with
-	 * the hardware.  Each time a register is modified, the corresponding
-	 * bit is set in the bitmap, so we know that we have to sync
-	 * that register.
-	 */
-	bmp_size = codec_drv->reg_cache_size;
-	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof(long),
-			   GFP_KERNEL);
-	if (!sync_bmp) {
-		ret = -ENOMEM;
-		goto err;
-	}
-	bitmap_zero(sync_bmp, bmp_size);
-
-	/* allocate the lzo blocks and initialize them */
-	for (i = 0; i < blkcount; ++i) {
-		lzo_blocks[i] = kzalloc(sizeof **lzo_blocks,
-					GFP_KERNEL);
-		if (!lzo_blocks[i]) {
-			kfree(sync_bmp);
-			ret = -ENOMEM;
-			goto err;
-		}
-		lzo_blocks[i]->sync_bmp = sync_bmp;
-		lzo_blocks[i]->sync_bmp_nbits = bmp_size;
-		/* alloc the working space for the compressed block */
-		ret = snd_soc_lzo_prepare(lzo_blocks[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	blksize = snd_soc_lzo_get_blksize(codec);
-	p = codec->reg_def_copy;
-	end = codec->reg_def_copy + codec->reg_size;
-	/* compress the register map and fill the lzo blocks */
-	for (i = 0; i < blkcount; ++i, p += blksize) {
-		lzo_blocks[i]->src = p;
-		if (p + blksize > end)
-			lzo_blocks[i]->src_len = end - p;
-		else
-			lzo_blocks[i]->src_len = blksize;
-		ret = snd_soc_lzo_compress_cache_block(codec,
-						       lzo_blocks[i]);
-		if (ret < 0)
-			goto err;
-		lzo_blocks[i]->decompressed_size =
-			lzo_blocks[i]->src_len;
-	}
-
-	if (tofree) {
-		kfree(codec->reg_def_copy);
-		codec->reg_def_copy = NULL;
-	}
-	return 0;
-err:
-	snd_soc_cache_exit(codec);
-err_tofree:
-	if (tofree) {
-		kfree(codec->reg_def_copy);
-		codec->reg_def_copy = NULL;
-	}
-	return ret;
-}
-#endif
-
 static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 {
 	int i;
@@ -889,17 +516,6 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.write = snd_soc_flat_cache_write,
 		.sync = snd_soc_flat_cache_sync
 	},
-#ifdef CONFIG_SND_SOC_CACHE_LZO
-	{
-		.id = SND_SOC_LZO_COMPRESSION,
-		.name = "LZO",
-		.init = snd_soc_lzo_cache_init,
-		.exit = snd_soc_lzo_cache_exit,
-		.read = snd_soc_lzo_cache_read,
-		.write = snd_soc_lzo_cache_write,
-		.sync = snd_soc_lzo_cache_sync
-	},
-#endif
 	{
 		.id = SND_SOC_RBTREE_COMPRESSION,
 		.name = "rbtree",
-- 
1.7.7.2
