From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: Remove support for
	reg_access_defaults
Date: Sat, 31 Aug 2013 20:31:11 +0200
Message-ID: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id DFE37261AE5
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 20:29:46 +0200 (CEST)
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

No users of reg_access_defaults are left and new drivers are going to use regmap
for this, so support for it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   | 24 --------------------
 sound/soc/soc-cache.c | 63 ---------------------------------------------------
 sound/soc/soc-core.c  |  9 --------
 3 files changed, 96 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7184805..ae6efc6d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -403,12 +403,6 @@ int snd_soc_cache_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value);
 int snd_soc_cache_read(struct snd_soc_codec *codec,
 		       unsigned int reg, unsigned int *value);
-int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
-				      unsigned int reg);
-int snd_soc_default_readable_register(struct snd_soc_codec *codec,
-				      unsigned int reg);
-int snd_soc_default_writable_register(struct snd_soc_codec *codec,
-				      unsigned int reg);
 int snd_soc_platform_read(struct snd_soc_platform *platform,
 					unsigned int reg);
 int snd_soc_platform_write(struct snd_soc_platform *platform,
@@ -542,22 +536,6 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 
 /**
- * struct snd_soc_reg_access - Describes whether a given register is
- * readable, writable or volatile.
- *
- * @reg: the register number
- * @read: whether this register is readable
- * @write: whether this register is writable
- * @vol: whether this register is volatile
- */
-struct snd_soc_reg_access {
-	u16 reg;
-	u16 read;
-	u16 write;
-	u16 vol;
-};
-
-/**
  * struct snd_soc_jack_pin - Describes a pin to update based on jack detection
  *
  * @pin:    name of the pin to update
@@ -760,8 +738,6 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
-	short reg_access_size;
-	const struct snd_soc_reg_access *reg_access_default;
 	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index e72f554..eaa898f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -275,66 +275,3 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
-
-static int snd_soc_get_reg_access_index(struct snd_soc_codec *codec,
-					unsigned int reg)
-{
-	const struct snd_soc_codec_driver *codec_drv;
-	unsigned int min, max, index;
-
-	codec_drv = codec->driver;
-	min = 0;
-	max = codec_drv->reg_access_size - 1;
-	do {
-		index = (min + max) / 2;
-		if (codec_drv->reg_access_default[index].reg == reg)
-			return index;
-		if (codec_drv->reg_access_default[index].reg < reg)
-			min = index + 1;
-		else
-			max = index;
-	} while (min <= max);
-	return -1;
-}
-
-int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	int index;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return 1;
-	index = snd_soc_get_reg_access_index(codec, reg);
-	if (index < 0)
-		return 0;
-	return codec->driver->reg_access_default[index].vol;
-}
-EXPORT_SYMBOL_GPL(snd_soc_default_volatile_register);
-
-int snd_soc_default_readable_register(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	int index;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return 1;
-	index = snd_soc_get_reg_access_index(codec, reg);
-	if (index < 0)
-		return 0;
-	return codec->driver->reg_access_default[index].read;
-}
-EXPORT_SYMBOL_GPL(snd_soc_default_readable_register);
-
-int snd_soc_default_writable_register(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	int index;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return 1;
-	index = snd_soc_get_reg_access_index(codec, reg);
-	if (index < 0)
-		return 0;
-	return codec->driver->reg_access_default[index].write;
-}
-EXPORT_SYMBOL_GPL(snd_soc_default_writable_register);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7d13c4f..b78fa93 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4222,15 +4222,6 @@ int snd_soc_register_codec(struct device *dev,
 		}
 	}
 
-	if (codec_drv->reg_access_size && codec_drv->reg_access_default) {
-		if (!codec->volatile_register)
-			codec->volatile_register = snd_soc_default_volatile_register;
-		if (!codec->readable_register)
-			codec->readable_register = snd_soc_default_readable_register;
-		if (!codec->writable_register)
-			codec->writable_register = snd_soc_default_writable_register;
-	}
-
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
-- 
1.8.0
