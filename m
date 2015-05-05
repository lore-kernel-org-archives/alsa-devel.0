From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V4 2/5] regmap: Use regcache_mark_dirty() to
	indicate power loss or reset
Date: Tue,  5 May 2015 15:14:14 -0700
Message-ID: <1430864057-3848-3-git-send-email-cernekee@chromium.org>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id BBEB62604C6
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:14:26 +0200 (CEST)
Received: by iecnq11 with SMTP id nq11so880275iec.3
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 15:14:26 -0700 (PDT)
In-Reply-To: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, abrestic@chromium.org, linux-kernel@vger.kernel.org, dgreid@chromium.org, olofj@chromium.org
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

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---
 drivers/base/regmap/internal.h |  3 +++
 drivers/base/regmap/regcache.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

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
index c58493eaf050..b9862d741a56 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -254,6 +254,10 @@ static bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
 {
 	int ret;
 
+	/* If we don't know the chip just got reset, then sync everything. */
+	if (!map->no_sync_defaults)
+		return true;
+
 	/* Is this the hardware default?  If so skip. */
 	ret = regcache_lookup_reg(map, reg);
 	if (ret >= 0 && val == map->reg_defaults[ret].def)
@@ -352,6 +356,7 @@ out:
 	/* Restore the bypass state */
 	map->async = false;
 	map->cache_bypass = bypass;
+	map->no_sync_defaults = false;
 	map->unlock(map->lock_arg);
 
 	regmap_async_complete(map);
@@ -407,6 +412,7 @@ out:
 	/* Restore the bypass state */
 	map->cache_bypass = bypass;
 	map->async = false;
+	map->no_sync_defaults = false;
 	map->unlock(map->lock_arg);
 
 	regmap_async_complete(map);
@@ -471,18 +477,23 @@ void regcache_cache_only(struct regmap *map, bool enable)
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
-- 
2.2.0.rc0.207.ga3a616c
