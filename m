From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: Remove snd_soc_bulk_write_raw()
Date: Sat, 31 Aug 2013 20:31:12 +0200
Message-ID: <1377973875-2209-2-git-send-email-lars@metafoo.de>
References: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A346B261AF4
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 20:29:47 +0200 (CEST)
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

No users of snd_soc_bulk_write_raw() are left and new drivers are going to use
regmap directly for this, so the function can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  3 ---
 sound/soc/soc-core.c |  7 -------
 sound/soc/soc-io.c   | 26 --------------------------
 3 files changed, 36 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ae6efc6d..c72b7b3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -686,7 +686,6 @@ struct snd_soc_codec {
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-	int (*bulk_write_raw)(struct snd_soc_codec *, unsigned int, const void *, size_t);
 	void *reg_cache;
 	const void *reg_def_copy;
 	const struct snd_soc_cache_ops *cache_ops;
@@ -1093,8 +1092,6 @@ struct soc_enum {
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
 			   unsigned int reg, unsigned int val);
-unsigned int snd_soc_bulk_write_raw(struct snd_soc_codec *codec,
-				    unsigned int reg, const void *data, size_t len);
 
 /* device driver data */
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b78fa93..d25feed 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2296,13 +2296,6 @@ unsigned int snd_soc_write(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
 
-unsigned int snd_soc_bulk_write_raw(struct snd_soc_codec *codec,
-				    unsigned int reg, const void *data, size_t len)
-{
-	return codec->bulk_write_raw(codec, reg, data, len);
-}
-EXPORT_SYMBOL_GPL(snd_soc_bulk_write_raw);
-
 /**
  * snd_soc_update_bits - update codec register bits
  * @codec: audio codec
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 8ca9ecc..0b20cf2 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -65,31 +65,6 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 	return val;
 }
 
-/* Primitive bulk write support for soc-cache.  The data pointed to by
- * `data' needs to already be in the form the hardware expects.  Any
- * data written through this function will not go through the cache as
- * it only handles writing to volatile or out of bounds registers.
- *
- * This is currently only supported for devices using the regmap API
- * wrappers.
- */
-static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec,
-				     unsigned int reg,
-				     const void *data, size_t len)
-{
-	/* To ensure that we don't get out of sync with the cache, check
-	 * whether the base register is volatile or if we've directly asked
-	 * to bypass the cache.  Out of bounds registers are considered
-	 * volatile.
-	 */
-	if (!codec->cache_bypass
-	    && !snd_soc_codec_volatile_register(codec, reg)
-	    && reg < codec->driver->reg_cache_size)
-		return -EINVAL;
-
-	return regmap_raw_write(codec->control_data, reg, data, len);
-}
-
 /**
  * snd_soc_codec_set_cache_io: Set up standard I/O functions.
  *
@@ -119,7 +94,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	memset(&config, 0, sizeof(config));
 	codec->write = hw_write;
 	codec->read = hw_read;
-	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
 
 	config.reg_bits = addr_bits;
 	config.val_bits = data_bits;
-- 
1.8.0
