From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to regcache_sync_region()
Date: Fri, 24 Apr 2015 15:36:45 -0700
Message-ID: <1429915008-22015-2-git-send-email-cernekee@chromium.org>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

regcache_sync() and regcache_sync_region() currently assume that the
hardware has just emerged from a clean reset, and that all registers are
in their default states.  But that isn't the only possibility; the device
may have been in a different state in which the registers were
inaccessible but have retained their contents, e.g. clock gating.

So we will extend the more versatile of the two functions,
regcache_sync_region(), to let the caller decide what assumptions should
be made.

One driver that can benefit from this is adau1977, which has hacks to
overwrite the registers that regcache_sync() might have missed.  Also,
the powerdown pin on tas571x does not reset the register contents either,
so a similar feature will be required by that driver.

This commit just adds the new argument by changing the function
declarations and call sites, but doesn't wire it up yet.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---
 drivers/base/regmap/internal.h        |  5 ++-
 drivers/base/regmap/regcache-lzo.c    |  2 +-
 drivers/base/regmap/regcache-rbtree.c |  5 ++-
 drivers/base/regmap/regcache.c        | 75 ++++++++++++++++++++---------------
 drivers/media/radio/radio-si476x.c    | 18 ++++++---
 drivers/mfd/wm8994-core.c             |  5 ++-
 include/linux/regmap.h                |  4 +-
 include/sound/hda_regmap.h            |  3 +-
 sound/soc/codecs/wm8962.c             |  3 +-
 9 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a13587b5c2be..89dfefeb168e 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -155,7 +155,8 @@ struct regcache_ops {
 #endif
 	int (*read)(struct regmap *map, unsigned int reg, unsigned int *value);
 	int (*write)(struct regmap *map, unsigned int reg, unsigned int value);
-	int (*sync)(struct regmap *map, unsigned int min, unsigned int max);
+	int (*sync)(struct regmap *map, unsigned int min, unsigned int max,
+		    bool was_reset);
 	int (*drop)(struct regmap *map, unsigned int min, unsigned int max);
 };
 
@@ -215,7 +216,7 @@ int regcache_sync(struct regmap *map);
 int regcache_sync_block(struct regmap *map, void *block,
 			unsigned long *cache_present,
 			unsigned int block_base, unsigned int start,
-			unsigned int end);
+			unsigned int end, bool was_reset);
 
 static inline const void *regcache_get_val_addr(struct regmap *map,
 						const void *base,
diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
index 2d53f6f138e1..52ed0d03ce69 100644
--- a/drivers/base/regmap/regcache-lzo.c
+++ b/drivers/base/regmap/regcache-lzo.c
@@ -332,7 +332,7 @@ out:
 }
 
 static int regcache_lzo_sync(struct regmap *map, unsigned int min,
-			     unsigned int max)
+			     unsigned int max, bool was_reset)
 {
 	struct regcache_lzo_ctx **lzo_blocks;
 	unsigned int val;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 81751a49d8bf..8fc1727e635c 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -445,7 +445,7 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 }
 
 static int regcache_rbtree_sync(struct regmap *map, unsigned int min,
-				unsigned int max)
+				unsigned int max, bool was_reset)
 {
 	struct regcache_rbtree_ctx *rbtree_ctx;
 	struct rb_node *node;
@@ -477,7 +477,8 @@ static int regcache_rbtree_sync(struct regmap *map, unsigned int min,
 
 		ret = regcache_sync_block(map, rbnode->block,
 					  rbnode->cache_present,
-					  rbnode->base_reg, start, end);
+					  rbnode->base_reg, start, end,
+					  was_reset);
 		if (ret != 0)
 			return ret;
 	}
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7eb7b3b98794..d27b45f50497 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -250,7 +250,7 @@ int regcache_write(struct regmap *map,
 }
 
 static int regcache_default_sync(struct regmap *map, unsigned int min,
-				 unsigned int max)
+				 unsigned int max, bool was_reset)
 {
 	unsigned int reg;
 
@@ -266,10 +266,12 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 		if (ret)
 			return ret;
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, reg);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
-			continue;
+		if (was_reset) {
+			/* Is this the hardware default?  If so skip. */
+			ret = regcache_lookup_reg(map, reg);
+			if (ret >= 0 && val == map->reg_defaults[ret].def)
+				continue;
+		}
 
 		map->cache_bypass = 1;
 		ret = _regmap_write(map, reg, val);
@@ -294,6 +296,10 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
  * volatile.  In general drivers can choose not to use the provided
  * syncing functionality if they so require.
  *
+ * This assumes that the hardware registers contain their default values.
+ * If the cached value matches the default value for a register, the write
+ * operation will be skipped.
+ *
  * Return a negative value on failure, 0 on success.
  */
 int regcache_sync(struct regmap *map)
@@ -331,9 +337,9 @@ int regcache_sync(struct regmap *map)
 	map->cache_bypass = 0;
 
 	if (map->cache_ops->sync)
-		ret = map->cache_ops->sync(map, 0, map->max_register);
+		ret = map->cache_ops->sync(map, 0, map->max_register, true);
 	else
-		ret = regcache_default_sync(map, 0, map->max_register);
+		ret = regcache_default_sync(map, 0, map->max_register, true);
 
 	if (ret == 0)
 		map->cache_dirty = false;
@@ -353,19 +359,18 @@ out:
 EXPORT_SYMBOL_GPL(regcache_sync);
 
 /**
- * regcache_sync_region: Sync part  of the register cache with the hardware.
+ * regcache_sync_region: Sync part of the register cache with the hardware.
  *
  * @map: map to sync.
  * @min: first register to sync
  * @max: last register to sync
- *
- * Write all non-default register values in the specified region to
- * the hardware.
+ * @was_reset: true if the hardware is known to contain default register values
+ * in the given range; false otherwise
  *
  * Return a negative value on failure, 0 on success.
  */
 int regcache_sync_region(struct regmap *map, unsigned int min,
-			 unsigned int max)
+			 unsigned int max, bool was_reset)
 {
 	int ret = 0;
 	const char *name;
@@ -389,9 +394,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	map->async = true;
 
 	if (map->cache_ops->sync)
-		ret = map->cache_ops->sync(map, min, max);
+		ret = map->cache_ops->sync(map, min, max, was_reset);
 	else
-		ret = regcache_default_sync(map, min, max);
+		ret = regcache_default_sync(map, min, max, was_reset);
 
 out:
 	/* Restore the bypass state */
@@ -600,7 +605,8 @@ static bool regcache_reg_present(unsigned long *cache_present, unsigned int idx)
 static int regcache_sync_block_single(struct regmap *map, void *block,
 				      unsigned long *cache_present,
 				      unsigned int block_base,
-				      unsigned int start, unsigned int end)
+				      unsigned int start, unsigned int end,
+				      bool was_reset)
 {
 	unsigned int i, regtmp, val;
 	int ret;
@@ -614,10 +620,12 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
 
 		val = regcache_get_val(map, block, i);
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
-			continue;
+		if (was_reset) {
+			/* Is this the hardware default?  If so skip. */
+			ret = regcache_lookup_reg(map, regtmp);
+			if (ret >= 0 && val == map->reg_defaults[ret].def)
+				continue;
+		}
 
 		map->cache_bypass = 1;
 
@@ -667,7 +675,7 @@ static int regcache_sync_block_raw_flush(struct regmap *map, const void **data,
 static int regcache_sync_block_raw(struct regmap *map, void *block,
 			    unsigned long *cache_present,
 			    unsigned int block_base, unsigned int start,
-			    unsigned int end)
+			    unsigned int end, bool was_reset)
 {
 	unsigned int i, val;
 	unsigned int regtmp = 0;
@@ -689,14 +697,17 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
 
 		val = regcache_get_val(map, block, i);
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def) {
-			ret = regcache_sync_block_raw_flush(map, &data,
-							    base, regtmp);
-			if (ret != 0)
-				return ret;
-			continue;
+		if (was_reset) {
+			/* Is this the hardware default?  If so skip. */
+			ret = regcache_lookup_reg(map, regtmp);
+			if (ret >= 0 && val == map->reg_defaults[ret].def) {
+				ret = regcache_sync_block_raw_flush(map, &data,
+								    base,
+								    regtmp);
+				if (ret != 0)
+					return ret;
+				continue;
+			}
 		}
 
 		if (!data) {
@@ -712,12 +723,14 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
 int regcache_sync_block(struct regmap *map, void *block,
 			unsigned long *cache_present,
 			unsigned int block_base, unsigned int start,
-			unsigned int end)
+			unsigned int end, bool was_reset)
 {
 	if (regmap_can_raw_write(map) && !map->use_single_rw)
 		return regcache_sync_block_raw(map, block, cache_present,
-					       block_base, start, end);
+					       block_base, start, end,
+					       was_reset);
 	else
 		return regcache_sync_block_single(map, block, cache_present,
-						  block_base, start, end);
+						  block_base, start, end,
+						  was_reset);
 }
diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index dccf58691650..ff4785f0416d 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -567,19 +567,22 @@ static int si476x_radio_do_post_powerup_init(struct si476x_radio *radio,
 	/* regcache_mark_dirty(radio->core->regmap); */
 	err = regcache_sync_region(radio->core->regmap,
 				   SI476X_PROP_DIGITAL_IO_INPUT_SAMPLE_RATE,
-				   SI476X_PROP_DIGITAL_IO_OUTPUT_FORMAT);
+				   SI476X_PROP_DIGITAL_IO_OUTPUT_FORMAT,
+				   true);
 		if (err < 0)
 			return err;
 
 	err = regcache_sync_region(radio->core->regmap,
 				   SI476X_PROP_AUDIO_DEEMPHASIS,
-				   SI476X_PROP_AUDIO_PWR_LINE_FILTER);
+				   SI476X_PROP_AUDIO_PWR_LINE_FILTER,
+				   true);
 	if (err < 0)
 		return err;
 
 	err = regcache_sync_region(radio->core->regmap,
 				   SI476X_PROP_INT_CTL_ENABLE,
-				   SI476X_PROP_INT_CTL_ENABLE);
+				   SI476X_PROP_INT_CTL_ENABLE,
+				   true);
 	if (err < 0)
 		return err;
 
@@ -589,13 +592,15 @@ static int si476x_radio_do_post_powerup_init(struct si476x_radio *radio,
 	 */
 	err = regcache_sync_region(radio->core->regmap,
 				   SI476X_PROP_VALID_MAX_TUNE_ERROR,
-				   SI476X_PROP_VALID_MAX_TUNE_ERROR);
+				   SI476X_PROP_VALID_MAX_TUNE_ERROR,
+				   true);
 	if (err < 0)
 		return err;
 
 	err = regcache_sync_region(radio->core->regmap,
 				   SI476X_PROP_VALID_SNR_THRESHOLD,
-				   SI476X_PROP_VALID_RSSI_THRESHOLD);
+				   SI476X_PROP_VALID_RSSI_THRESHOLD,
+				   true);
 	if (err < 0)
 		return err;
 
@@ -609,7 +614,8 @@ static int si476x_radio_do_post_powerup_init(struct si476x_radio *radio,
 
 		err = regcache_sync_region(radio->core->regmap,
 					   SI476X_PROP_FM_RDS_INTERRUPT_SOURCE,
-					   SI476X_PROP_FM_RDS_CONFIG);
+					   SI476X_PROP_FM_RDS_CONFIG,
+					   true);
 		if (err < 0)
 			return err;
 	}
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 53ae5af5d6e4..d5632634a362 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -158,14 +158,15 @@ static int wm8994_suspend(struct device *dev)
 	 * pin configurations.
 	 */
 	ret = regcache_sync_region(wm8994->regmap, WM8994_GPIO_1,
-				   WM8994_GPIO_11);
+				   WM8994_GPIO_11, true);
 	if (ret != 0)
 		dev_err(dev, "Failed to restore GPIO registers: %d\n", ret);
 
 	/* In case one of the GPIOs is used as a wake input. */
 	ret = regcache_sync_region(wm8994->regmap,
 				   WM8994_INTERRUPT_STATUS_1_MASK,
-				   WM8994_INTERRUPT_STATUS_1_MASK);
+				   WM8994_INTERRUPT_STATUS_1_MASK,
+				   true);
 	if (ret != 0)
 		dev_err(dev, "Failed to restore interrupt mask: %d\n", ret);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 116655d92269..ece122a6fdeb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -438,7 +438,7 @@ bool regmap_can_raw_write(struct regmap *map);
 
 int regcache_sync(struct regmap *map);
 int regcache_sync_region(struct regmap *map, unsigned int min,
-			 unsigned int max);
+			 unsigned int max, bool was_reset);
 int regcache_drop_region(struct regmap *map, unsigned int min,
 			 unsigned int max);
 void regcache_cache_only(struct regmap *map, bool enable);
@@ -683,7 +683,7 @@ static inline int regcache_sync(struct regmap *map)
 }
 
 static inline int regcache_sync_region(struct regmap *map, unsigned int min,
-				       unsigned int max)
+				       unsigned int max, bool was_reset)
 {
 	WARN_ONCE(1, "regmap API is disabled");
 	return -EINVAL;
diff --git a/include/sound/hda_regmap.h b/include/sound/hda_regmap.h
index 53a18b3635e2..f6bb68137ca4 100644
--- a/include/sound/hda_regmap.h
+++ b/include/sound/hda_regmap.h
@@ -211,7 +211,8 @@ static inline void
 snd_hdac_regmap_sync_node(struct hdac_device *codec, hda_nid_t nid)
 {
 	regcache_mark_dirty(codec->regmap);
-	regcache_sync_region(codec->regmap, nid << 20, ((nid + 1) << 20) - 1);
+	regcache_sync_region(codec->regmap, nid << 20,
+			     ((nid + 1) << 20) - 1, true);
 }
 
 #endif /* __SOUND_HDA_REGMAP_H */
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 118b0034ba23..3a25d2d93705 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1483,7 +1483,8 @@ static int wm8962_dsp2_write_config(struct snd_soc_codec *codec)
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 
 	return regcache_sync_region(wm8962->regmap,
-				    WM8962_HDBASS_AI_1, WM8962_MAX_REGISTER);
+				    WM8962_HDBASS_AI_1, WM8962_MAX_REGISTER,
+				    true);
 }
 
 static int wm8962_dsp2_set_enable(struct snd_soc_codec *codec, u16 val)
-- 
2.2.0.rc0.207.ga3a616c
