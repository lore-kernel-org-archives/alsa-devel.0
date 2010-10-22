From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: soc-cache: Add support for LZO based
	register caching
Date: Fri, 22 Oct 2010 15:28:22 +0100
Message-ID: <1287757702-9573-5-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 100FC10388D
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:28:31 +0200 (CEST)
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

This patch adds support for LZO compression when storing the register
cache.  The initial register defaults cache is marked as __devinitconst
and the only change required for a driver to use LZO compression is
to set the compress_type member in codec->driver to SND_SOC_LZO_COMPRESSION.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 379 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a8ec23a..ea9d80f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -14,6 +14,8 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
+#include <linux/lzo.h>
+#include <linux/bitmap.h>
 
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
@@ -764,6 +766,375 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
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
+static int snd_soc_compress_cache_block(struct snd_soc_codec *codec,
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
+static int snd_soc_decompress_cache_block(struct snd_soc_codec *codec,
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
+static inline int snd_soc_get_lzo_blkindex(struct snd_soc_codec *codec,
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
+static inline int snd_soc_get_lzo_blkpos(struct snd_soc_codec *codec,
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
+static inline int snd_soc_get_lzo_blksize(struct snd_soc_codec *codec)
+{
+	struct snd_soc_codec_driver *codec_drv;
+	size_t reg_size;
+
+	codec_drv = codec->driver;
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+	return DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count());
+}
+
+static int snd_soc_cache_lzo_sync(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	unsigned int val;
+	int n;
+
+	lzo_blocks = codec->reg_cache;
+	for_each_set_bit(n, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
+		snd_soc_cache_read(codec, n, &val);
+		snd_soc_write(codec, n, val);
+	}
+
+	return 0;
+}
+
+static int snd_soc_cache_lzo_write(struct snd_soc_codec *codec,
+				   unsigned int reg, unsigned int value)
+{
+	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
+	u8 *cache;
+	int ret, blkindex, blkpos;
+	size_t blksize, tmp_dst_len;
+	void *tmp_dst;
+
+	/* index of the compressed lzo block */
+	blkindex = snd_soc_get_lzo_blkindex(codec, reg);
+	/* register index within the decompressed block */
+	blkpos = snd_soc_get_lzo_blkpos(codec, reg);
+	blkpos *= codec->driver->reg_word_size;
+	/* size of the compressed block */
+	blksize = snd_soc_get_lzo_blksize(codec);
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
+	ret = snd_soc_decompress_cache_block(codec, lzo_block);
+	if (ret < 0) {
+		kfree(lzo_block->dst);
+		goto out;
+	}
+
+	cache = lzo_block->dst;
+	/* bail out early, no change in value */
+	if (!memcmp(&cache[blkpos], &value,
+		    codec->driver->reg_word_size)) {
+		kfree(lzo_block->dst);
+		goto out;
+	}
+	/* set the new register value */
+	memcpy(&cache[blkpos], &value, codec->driver->reg_word_size);
+
+	/* prepare the source to be the decompressed block */
+	lzo_block->src = lzo_block->dst;
+	lzo_block->src_len = lzo_block->dst_len;
+
+	/* compress the block */
+	ret = snd_soc_compress_cache_block(codec, lzo_block);
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
+static int snd_soc_cache_lzo_read(struct snd_soc_codec *codec,
+				  unsigned int reg, unsigned int *value)
+{
+	struct snd_soc_lzo_ctx *lzo_block, **lzo_blocks;
+	u8 *cache;
+	int ret, blkindex, blkpos;
+	size_t blksize, tmp_dst_len;
+	void *tmp_dst;
+
+	*value = 0;
+	/* index of the compressed lzo block */
+	blkindex = snd_soc_get_lzo_blkindex(codec, reg);
+	/* register index within the decompressed block */
+	blkpos = snd_soc_get_lzo_blkpos(codec, reg);
+	blkpos *= codec->driver->reg_word_size;
+	/* size of the compressed block */
+	blksize = snd_soc_get_lzo_blksize(codec);
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
+	ret = snd_soc_decompress_cache_block(codec, lzo_block);
+	if (ret >= 0) {
+		cache = lzo_block->dst;
+		memcpy(value, &cache[blkpos],
+		       codec->driver->reg_word_size);
+	}
+
+	kfree(lzo_block->dst);
+	/* restore the pointer and length of the compressed block */
+	lzo_block->dst = tmp_dst;
+	lzo_block->dst_len = tmp_dst_len;
+	return 0;
+}
+
+static int snd_soc_cache_lzo_deinit(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	int i, blkcount;
+
+	lzo_blocks = codec->reg_cache;
+	if (!lzo_blocks)
+		return -EINVAL;
+
+	blkcount = snd_soc_lzo_block_count();
+	if (lzo_blocks[0])
+		kfree(lzo_blocks[0]->sync_bmp);
+	for (i = 0; i < blkcount; ++i) {
+		if (lzo_blocks[i]) {
+			kfree(lzo_blocks[i]->wmem);
+			kfree(lzo_blocks[i]->dst);
+		}
+		kfree(lzo_blocks[i]);
+		lzo_blocks[i] = NULL;
+	}
+	kfree(lzo_blocks);
+	codec->reg_cache = NULL;
+	return 0;
+}
+
+static int snd_soc_cache_lzo_init(struct snd_soc_codec *codec)
+{
+	struct snd_soc_lzo_ctx **lzo_blocks;
+	size_t reg_size;
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
+	sync_bmp = kmalloc(BITS_TO_LONGS(reg_size) * sizeof(unsigned long),
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
+	blksize = snd_soc_get_lzo_blksize(codec);
+	p = codec_drv->reg_cache_default;
+	end = codec_drv->reg_cache_default + reg_size;
+	/* compress the register map and fill the lzo blocks */
+	for (i = 0; i < blkcount; ++i, p += blksize) {
+		lzo_blocks[i]->src = p;
+		if (p + blksize > end)
+			lzo_blocks[i]->src_len = end - p;
+		else
+			lzo_blocks[i]->src_len = blksize;
+		ret = snd_soc_compress_cache_block(codec,
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
+	snd_soc_cache_deinit(codec);
+err_tofree:
+	if (tofree)
+		kfree(codec_drv->reg_cache_default);
+	return ret;
+}
+
 static int snd_soc_cache_default_sync(struct snd_soc_codec *codec)
 {
 	const u8 *cache;
@@ -842,6 +1213,14 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.read = snd_soc_cache_default_read,
 		.write = snd_soc_cache_default_write,
 		.sync = snd_soc_cache_default_sync
+	},
+	{
+		.id = SND_SOC_LZO_COMPRESSION,
+		.init = snd_soc_cache_lzo_init,
+		.deinit = snd_soc_cache_lzo_deinit,
+		.read = snd_soc_cache_lzo_read,
+		.write = snd_soc_cache_lzo_write,
+		.sync = snd_soc_cache_lzo_sync
 	}
 };
 
-- 
1.7.3.1
