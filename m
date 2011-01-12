From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Add reg_size as a member to
	snd_soc_codec
Date: Wed, 12 Jan 2011 10:38:58 +0000
Message-ID: <1294828738-22198-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A65A7244E6
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 11:39:01 +0100 (CET)
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

Simplify the use of reg_size, by calculating it once and storing it in
the codec structure for later reference.  The value of reg_size is
reg_cache_size * reg_word_size.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   26 ++++++++------------------
 sound/soc/soc-core.c  |    1 +
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c477058..d609232 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -459,6 +459,7 @@ struct snd_soc_codec {
 	struct list_head card_list;
 	int num_dai;
 	enum snd_soc_compress_type compress_type;
+	size_t reg_size;	/* reg_cache_size * reg_word_size */
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 2f1d596..1a36b36 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1100,34 +1100,28 @@ static inline int snd_soc_lzo_get_blkindex(struct snd_soc_codec *codec,
 		unsigned int reg)
 {
 	const struct snd_soc_codec_driver *codec_drv;
-	size_t reg_size;
 
 	codec_drv = codec->driver;
-	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 	return (reg * codec_drv->reg_word_size) /
-	       DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count());
+	       DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count());
 }
 
 static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
 		unsigned int reg)
 {
 	const struct snd_soc_codec_driver *codec_drv;
-	size_t reg_size;
 
 	codec_drv = codec->driver;
-	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
-	return reg % (DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count()) /
+	return reg % (DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count()) /
 		      codec_drv->reg_word_size);
 }
 
 static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
 {
 	const struct snd_soc_codec_driver *codec_drv;
-	size_t reg_size;
 
 	codec_drv = codec->driver;
-	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
-	return DIV_ROUND_UP(reg_size, snd_soc_lzo_block_count());
+	return DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count());
 }
 
 static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
@@ -1287,7 +1281,7 @@ static int snd_soc_lzo_cache_exit(struct snd_soc_codec *codec)
 static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 {
 	struct snd_soc_lzo_ctx **lzo_blocks;
-	size_t reg_size, bmp_size;
+	size_t bmp_size;
 	const struct snd_soc_codec_driver *codec_drv;
 	int ret, tofree, i, blksize, blkcount;
 	const char *p, *end;
@@ -1295,7 +1289,6 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 
 	ret = 0;
 	codec_drv = codec->driver;
-	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
 	/*
 	 * If we have not been given a default register cache
@@ -1307,8 +1300,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 		tofree = 1;
 
 	if (!codec->reg_def_copy) {
-		codec->reg_def_copy = kzalloc(reg_size,
-						       GFP_KERNEL);
+		codec->reg_def_copy = kzalloc(codec->reg_size, GFP_KERNEL);
 		if (!codec->reg_def_copy)
 			return -ENOMEM;
 	}
@@ -1356,7 +1348,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 
 	blksize = snd_soc_lzo_get_blksize(codec);
 	p = codec->reg_def_copy;
-	end = codec->reg_def_copy + reg_size;
+	end = codec->reg_def_copy + codec->reg_size;
 	/* compress the register map and fill the lzo blocks */
 	for (i = 0; i < blkcount; ++i, p += blksize) {
 		lzo_blocks[i]->src = p;
@@ -1441,16 +1433,14 @@ static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
 static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 {
 	const struct snd_soc_codec_driver *codec_drv;
-	size_t reg_size;
 
 	codec_drv = codec->driver;
-	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
 	if (codec->reg_def_copy)
 		codec->reg_cache = kmemdup(codec->reg_def_copy,
-					   reg_size, GFP_KERNEL);
+					   codec->reg_size, GFP_KERNEL);
 	else
-		codec->reg_cache = kzalloc(reg_size, GFP_KERNEL);
+		codec->reg_cache = kzalloc(codec->reg_size, GFP_KERNEL);
 	if (!codec->reg_cache)
 		return -ENOMEM;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 04475c1..cbac50b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3500,6 +3500,7 @@ int snd_soc_register_codec(struct device *dev,
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
 		reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
+		codec->reg_size = reg_size;
 		/* it is necessary to make a copy of the default register cache
 		 * because in the case of using a compression type that requires
 		 * the default register cache to be marked as __devinitconst the
-- 
1.7.3.5
