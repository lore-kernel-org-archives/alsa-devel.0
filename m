From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V3 1/4] regmap: Use regcache_mark_dirty() to indicate power loss or reset
Date: Sun,  3 May 2015 17:00:16 -0700
Message-ID: <1430697619-22773-2-git-send-email-cernekee@chromium.org>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430697619-22773-1-git-send-email-cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Existing regmap users call regcache_mark_dirty() as part of the
suspend/resume sequence, to tell regcache that non-default values need to
be resynced post-resume.  Add an internal "no_sync_defaults" regmap flag
to remember this state, so that regcache_sync() can differentiate between
these two cases:

1) HW was reset, so any cache values that match map->reg_defaults can be
safely skipped.  On some chips there are a lot of registers in the
reg_defaults list, so this optimization speeds things up quite a bit.

2) HW was not reset (maybe it was just clock-gated), so if we cached
any writes, they should be sent to the hardware regardless of whether
they match the HW default.  Currently this will write out all values in
the regcache, since we don't maintain per-register dirty bits.

Suggested-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/base/regmap/internal.h |  3 +++
 drivers/base/regmap/regcache.c | 61 ++++++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a13587b5c2be..b2b2849fc6d3 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -131,7 +131,10 @@ struct regmap {
 	struct reg_default *reg_defaults;
 	const void *reg_defaults_raw;
 	void *cache;
+	/* if set, the cache contains newer data than the HW */
 	u32 cache_dirty;
+	/* if set, the HW registers are known to match map->reg_defaults */
+	bool no_sync_defaults;
 
 	struct reg_default *patch;
 	int patch_regs;
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7eb7b3b98794..63af3103d0c6 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -253,6 +253,9 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 				 unsigned int max)
 {
 	unsigned int reg;
+	bool no_sync_defaults = map->no_sync_defaults;
+
+	map->no_sync_defaults = false;
 
 	for (reg = min; reg <= max; reg += map->reg_stride) {
 		unsigned int val;
@@ -266,10 +269,12 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 		if (ret)
 			return ret;
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, reg);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
-			continue;
+		if (no_sync_defaults) {
+			/* Is this the hardware default?  If so skip. */
+			ret = regcache_lookup_reg(map, reg);
+			if (ret >= 0 && val == map->reg_defaults[ret].def)
+				continue;
+		}
 
 		map->cache_bypass = 1;
 		ret = _regmap_write(map, reg, val);
@@ -461,18 +466,23 @@ void regcache_cache_only(struct regmap *map, bool enable)
 EXPORT_SYMBOL_GPL(regcache_cache_only);
 
 /**
- * regcache_mark_dirty: Mark the register cache as dirty
+ * regcache_mark_dirty: Indicate that HW registers were reset to default values
  *
  * @map: map to mark
  *
- * Mark the register cache as dirty, for example due to the device
- * having been powered down for suspend.  If the cache is not marked
- * as dirty then the cache sync will be suppressed.
+ * Inform regcache that the device has been powered down or reset, so that
+ * on resume, regcache_sync() knows to write out all non-default values
+ * stored in the cache.
+ *
+ * If this function is not called, regcache_sync() will assume that
+ * the hardware state still matches the cache state, modulo any writes that
+ * happened when cache_only was true.
  */
 void regcache_mark_dirty(struct regmap *map)
 {
 	map->lock(map->lock_arg);
 	map->cache_dirty = true;
+	map->no_sync_defaults = true;
 	map->unlock(map->lock_arg);
 }
 EXPORT_SYMBOL_GPL(regcache_mark_dirty);
@@ -604,6 +614,9 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
 {
 	unsigned int i, regtmp, val;
 	int ret;
+	bool no_sync_defaults = map->no_sync_defaults;
+
+	map->no_sync_defaults = false;
 
 	for (i = start; i < end; i++) {
 		regtmp = block_base + (i * map->reg_stride);
@@ -614,10 +627,12 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
 
 		val = regcache_get_val(map, block, i);
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
-			continue;
+		if (no_sync_defaults) {
+			/* Is this the hardware default?  If so skip. */
+			ret = regcache_lookup_reg(map, regtmp);
+			if (ret >= 0 && val == map->reg_defaults[ret].def)
+				continue;
+		}
 
 		map->cache_bypass = 1;
 
@@ -674,6 +689,9 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
 	unsigned int base = 0;
 	const void *data = NULL;
 	int ret;
+	bool no_sync_defaults = map->no_sync_defaults;
+
+	map->no_sync_defaults = false;
 
 	for (i = start; i < end; i++) {
 		regtmp = block_base + (i * map->reg_stride);
@@ -689,14 +707,17 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
 
 		val = regcache_get_val(map, block, i);
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def) {
-			ret = regcache_sync_block_raw_flush(map, &data,
-							    base, regtmp);
-			if (ret != 0)
-				return ret;
-			continue;
+		if (no_sync_defaults) {
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
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
