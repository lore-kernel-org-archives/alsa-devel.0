From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: soc-cache: Add support for LZO
	register caching
Date: Thu,  4 Nov 2010 14:22:43 +0000
Message-ID: <1288880564-31957-4-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 177CC10389F
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 15:22:56 +0100 (CET)
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

This patch adds support for LZO compression when storing the register
cache.  The initial register defaults cache is marked as __devinitconst
and the only change required for a driver to use LZO compression is
to set the compress_type member in codec->driver to SND_SOC_LZO_COMPRESSION.

For a typical device whose register map would normally occupy 25kB or 50kB
by using the LZO compression technique, one can get down to ~3-5kB.  There
might be a performance penalty associated with each individual read/write
due to decompressing/compressing the underlying cache, however that should not
be noticeable.  The memory benefits depend on whether the target architecture
can get rid of the memory occupied by the original register defaults cache
which is marked as __devinitconst.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    3 +-
 sound/soc/soc-cache.c |  413 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 415 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 90a9b60..8135b3c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -255,7 +255,8 @@ enum snd_soc_control_type {
 };
 
 enum snd_soc_compress_type {
-	SND_SOC_NO_COMPRESSION
+	SND_SOC_NO_COMPRESSION,
+	SND_SOC_LZO_COMPRESSION
 };
 
 int snd_soc_register_platform(struct device *dev,
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index c5d05b8..63b7fe9 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -14,6 +14,8 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
+#include <linux/lzo.h>
+#include <linux/bitmap.h>
 
 /* serialize access to *cache_read() and *cache_write() */
 static DEFINE_MUTEX(cache_rw_mutex);
@@ -757,6 +759,409 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
 
+struct snd_soc_lzo_ctx {
+	void *wmem;
+	void *dst;
+	const void *src;
+	size_t src_len;
+	size_t dst_len;
+	size_t decompressed_size;
+	unsigned long *sync_bmp;
+	int sync_bmp_nbits;
+};
+
+#define LZO_BLOCK_NUM 8
+static int snd_soc_lzo_block_count(void)
+{
+	return LZO_BLOCK_NUM;
+}
+
+static int snd_soc_lzo_prepare(struct snd_soc_lzo_ctx *lzo_ctx)
+{
+	lzo_ctx->wmem = kmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	if (!lzo_ctx->wmem)
+		return -ENOMEM;
+	return 0;
+}
+
+static int snd_soc_lzo_compress(struct snd_soc_lzo_ctx *lzo_ctx)
+{
+	size_t compress_size;
+	int ret;
+
+	ret = lzo1x_1_compress(lzo_ctx->src, lzo_ctx->src_len,
+			       lzo_ctx->dst, &compress_size, lzo_ctx->wmem);
+	if (ret != LZO_E_OK || compress_size > lzo_ctx->dst_len)
+		return -EINVAL;
+	lzo_ctx->dst_len = compress_size;
+	return 0;
+}
+
+static int snd_soc_lzo_decompress(struct snd_soc_lzo_ctx *lzo_ctx)
+{
+	size_t dst_len;
+	int ret;
+
+	dst_len = lzo_ctx->dst_len;
+	ret = lzo1x_decompress_safe(lzo_ctx->src, lzo_ctx->src_len,
+				    lzo_ctx->dst, &dst_len);
+	if (ret != LZO_E_OK || dst_len != lzo_ctx->dst_len)
+		return -EINVAL;
+	return 0;
+}
+
+static int snd_soc_lzo_compress_cache_block(struct snd_soc_codec *codec,
+					struct snd_soc_lzo_ctx *lzo_ctx)
+{
+	int ret;
+
+	lzo_ctx->dst_len = lzo1x_worst_compress(PAGE_SIZE);
+	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
+	if (!lzo_ctx->dst) {
+		lzo_ctx->dst_len = 0;
+		return -ENOMEM;
+	}
+
+	ret = snd_soc_lzo_compress(lzo_ctx);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int snd_soc_lzo_decompress_cache_block(struct snd_soc_codec *codec,
+		struct snd_soc_lzo_ctx *lzo_ctx)
+{
+	int ret;
+
+	lzo_ctx->dst_len = lzo_ctx->decompressed_size;
+	lzo_ctx->dst = kmalloc(lzo_ctx->dst_len, GFP_KERNEL);
+	if (!lzo_ctx->dst) {
+		lzo_ctx->dst_len = 0;
+		return -ENOMEM;
+	}
+
+	ret = snd_soc_lzo_decompress(lzo_ctx);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static inline int snd_soc_lzo_get_blkindex(struct snd_soc_codec *codec,
+		unsigned int reg)
+{
+	struct snd_soc_codec_driver *codec_drv;
+	size_t reg_size;
+
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+	return (reg * codec_drv->reg_word_size) /
+	       DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count());
+}
+
+static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
+		unsigned int reg)
+{
+	struct snd_soc_codec_driver *codec_drv;
+	size_t reg_size;
+
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+	return reg % (DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count()) /
+		      codec_drv->reg_word_size);
+}
+
+static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
+{
+	struct snd_soc_codec_driver *codec_drv;
+	size_t reg_size;
+
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+	return DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count());
+}
+
+static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	unsigned int val;
+	int i;
+
+	lzo_blocks = codec->reg_cache;
+	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
+		snd_soc_cache_read(codec, i, &val);
+		snd_soc_write(codec, i, val);
+		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+			i, val);
+	}
+
+	return 0;
+}
+
+static int snd_soc_lzo_cache_write(struct snd_soc_codec *codec,
+				   unsigned int reg, unsigned int value)
+{
+	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
+	int ret, blkindex, blkpos;
+	size_t blksize, tmp_dst_len;
+	void *tmp_dst;
+
+	/* index of the compressed lzo block */
+	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
+	/* register index within the decompressed block */
+	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
+	/* size of the compressed block */
+	blksize = snd_soc_lzo_get_blksize(codec);
+	lzo_blocks = codec->reg_cache;
+	lzo_block = lzo_blocks[blkindex];
+
+	/* save the pointer and length of the compressed block */
+	tmp_dst = lzo_block->dst;
+	tmp_dst_len = lzo_block->dst_len;
+
+	/* prepare the source to be the compressed block */
+	lzo_block->src = lzo_block->dst;
+	lzo_block->src_len = lzo_block->dst_len;
+
+	/* decompress the block */
+	ret = snd_soc_lzo_decompress_cache_block(codec, lzo_block);
+	if (ret < 0) {
+		kfree(lzo_block->dst);
+		goto out;
+	}
+
+	/* write the new value to the cache */
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		u8 *cache;
+		cache = lzo_block->dst;
+		if (cache[blkpos] == value) {
+			kfree(lzo_block->dst);
+			goto out;
+		}
+		cache[blkpos] = value;
+	}
+		break;
+	case 2: {
+		u16 *cache;
+		cache = lzo_block->dst;
+		if (cache[blkpos] == value) {
+			kfree(lzo_block->dst);
+			goto out;
+		}
+		cache[blkpos] = value;
+	}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* prepare the source to be the decompressed block */
+	lzo_block->src = lzo_block->dst;
+	lzo_block->src_len = lzo_block->dst_len;
+
+	/* compress the block */
+	ret = snd_soc_lzo_compress_cache_block(codec, lzo_block);
+	if (ret < 0) {
+		kfree(lzo_block->dst);
+		kfree(lzo_block->src);
+		goto out;
+	}
+
+	/* set the bit so we know we have to sync this register */
+	set_bit(reg, lzo_block->sync_bmp);
+	kfree(tmp_dst);
+	kfree(lzo_block->src);
+	return 0;
+out:
+	lzo_block->dst = tmp_dst;
+	lzo_block->dst_len = tmp_dst_len;
+	return ret;
+}
+
+static int snd_soc_lzo_cache_read(struct snd_soc_codec *codec,
+				  unsigned int reg, unsigned int *value)
+{
+	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
+	int ret, blkindex, blkpos;
+	size_t blksize, tmp_dst_len;
+	void *tmp_dst;
+
+	*value = 0;
+	/* index of the compressed lzo block */
+	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
+	/* register index within the decompressed block */
+	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
+	/* size of the compressed block */
+	blksize = snd_soc_lzo_get_blksize(codec);
+	lzo_blocks = codec->reg_cache;
+	lzo_block = lzo_blocks[blkindex];
+
+	/* save the pointer and length of the compressed block */
+	tmp_dst = lzo_block->dst;
+	tmp_dst_len = lzo_block->dst_len;
+
+	/* prepare the source to be the compressed block */
+	lzo_block->src = lzo_block->dst;
+	lzo_block->src_len = lzo_block->dst_len;
+
+	/* decompress the block */
+	ret = snd_soc_lzo_decompress_cache_block(codec, lzo_block);
+	if (ret >= 0) {
+		/* fetch the value from the cache */
+		switch (codec->driver->reg_word_size) {
+		case 1: {
+			u8 *cache;
+			cache = lzo_block->dst;
+			*value = cache[blkpos];
+		}
+			break;
+		case 2: {
+			u16 *cache;
+			cache = lzo_block->dst;
+			*value = cache[blkpos];
+		}
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	kfree(lzo_block->dst);
+	/* restore the pointer and length of the compressed block */
+	lzo_block->dst = tmp_dst;
+	lzo_block->dst_len = tmp_dst_len;
+	return 0;
+}
+
+static int snd_soc_lzo_cache_exit(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	int i, blkcount;
+
+	lzo_blocks = codec->reg_cache;
+	if (!lzo_blocks)
+		return 0;
+
+	blkcount = snd_soc_lzo_block_count();
+	/*
+	 * the pointer to the bitmap used for syncing the cache
+	 * is shared amongst all lzo_blocks.  Ensure it is freed
+	 * only once.
+	 */
+	if (lzo_blocks[0])
+		kfree(lzo_blocks[0]->sync_bmp);
+	for (i = 0; i < blkcount; ++i) {
+		if (lzo_blocks[i]) {
+			kfree(lzo_blocks[i]->wmem);
+			kfree(lzo_blocks[i]->dst);
+		}
+		/* each lzo_block is a pointer returned by kmalloc or NULL */
+		kfree(lzo_blocks[i]);
+	}
+	kfree(lzo_blocks);
+	codec->reg_cache = NULL;
+	return 0;
+}
+
+static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	size_t reg_size, bmp_size;
+	struct snd_soc_codec_driver *codec_drv;
+	int ret, tofree, i, blksize, blkcount;
+	const char *p, *end;
+	unsigned long *sync_bmp;
+
+	ret = 0;
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+
+	/*
+	 * If we have not been given a default register cache
+	 * then allocate a dummy zero-ed out region, compress it
+	 * and remember to free it afterwards.
+	 */
+	tofree = 0;
+	if (!codec_drv->reg_cache_default)
+		tofree = 1;
+
+	if (!codec_drv->reg_cache_default) {
+		codec_drv->reg_cache_default = kzalloc(reg_size,
+						       GFP_KERNEL);
+		if (!codec_drv->reg_cache_default)
+			return -ENOMEM;
+	}
+
+	blkcount = snd_soc_lzo_block_count();
+	codec->reg_cache = kzalloc(blkcount * sizeof(*lzo_blocks),
+				   GFP_KERNEL);
+	if (!codec->reg_cache) {
+		ret = -ENOMEM;
+		goto err_tofree;
+	}
+	lzo_blocks = codec->reg_cache;
+
+	/*
+	 * allocate a bitmap to be used when syncing the cache with
+	 * the hardware.  Each time a register is modified, the corresponding
+	 * bit is set in the bitmap, so we know that we have to sync
+	 * that register.
+	 */
+	bmp_size = codec_drv->reg_cache_size;
+	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof(unsigned long),
+			   GFP_KERNEL);
+	if (!sync_bmp) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	bitmap_zero(sync_bmp, reg_size);
+
+	/* allocate the lzo blocks and initialize them */
+	for (i = 0; i < blkcount; ++i) {
+		lzo_blocks[i] = kzalloc(sizeof **lzo_blocks,
+					GFP_KERNEL);
+		if (!lzo_blocks[i]) {
+			kfree(sync_bmp);
+			ret = -ENOMEM;
+			goto err;
+		}
+		lzo_blocks[i]->sync_bmp = sync_bmp;
+		lzo_blocks[i]->sync_bmp_nbits = reg_size;
+		/* alloc the working space for the compressed block */
+		ret = snd_soc_lzo_prepare(lzo_blocks[i]);
+		if (ret < 0)
+			goto err;
+	}
+
+	blksize = snd_soc_lzo_get_blksize(codec);
+	p = codec_drv->reg_cache_default;
+	end = codec_drv->reg_cache_default + reg_size;
+	/* compress the register map and fill the lzo blocks */
+	for (i = 0; i < blkcount; ++i, p += blksize) {
+		lzo_blocks[i]->src = p;
+		if (p + blksize > end)
+			lzo_blocks[i]->src_len = end - p;
+		else
+			lzo_blocks[i]->src_len = blksize;
+		ret = snd_soc_lzo_compress_cache_block(codec,
+						   lzo_blocks[i]);
+		if (ret < 0)
+			goto err;
+		lzo_blocks[i]->decompressed_size =
+			lzo_blocks[i]->src_len;
+	}
+
+	if (tofree)
+		kfree(codec_drv->reg_cache_default);
+	return 0;
+err:
+	snd_soc_cache_exit(codec);
+err_tofree:
+	if (tofree)
+		kfree(codec_drv->reg_cache_default);
+	return ret;
+}
+
 static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 {
 	int i;
@@ -879,6 +1284,14 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.read = snd_soc_flat_cache_read,
 		.write = snd_soc_flat_cache_write,
 		.sync = snd_soc_flat_cache_sync
+	},
+	{
+		.id = SND_SOC_LZO_COMPRESSION,
+		.init = snd_soc_lzo_cache_init,
+		.exit = snd_soc_lzo_cache_exit,
+		.read = snd_soc_lzo_cache_read,
+		.write = snd_soc_lzo_cache_write,
+		.sync = snd_soc_lzo_cache_sync
 	}
 };
 
-- 
1.7.3.2
