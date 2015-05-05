From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V4 1/5] regmap: Add a helper function for regcache sync test
Date: Tue,  5 May 2015 15:14:13 -0700
Message-ID: <1430864057-3848-2-git-send-email-cernekee@chromium.org>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430864057-3848-1-git-send-email-cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

We're going to add another "does this register need syncing?" check, so
rather than repeating it in three places, we'll separate all of the
relevant logic into a helper function.

Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/base/regmap/regcache.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7eb7b3b98794..c58493eaf050 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -249,6 +249,18 @@ int regcache_write(struct regmap *map,
 	return 0;
 }
 
+static bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
+				    unsigned int val)
+{
+	int ret;
+
+	/* Is this the hardware default?  If so skip. */
+	ret = regcache_lookup_reg(map, reg);
+	if (ret >= 0 && val == map->reg_defaults[ret].def)
+		return false;
+	return true;
+}
+
 static int regcache_default_sync(struct regmap *map, unsigned int min,
 				 unsigned int max)
 {
@@ -266,9 +278,7 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 		if (ret)
 			return ret;
 
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, reg);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
+		if (!regcache_reg_needs_sync(map, reg, val))
 			continue;
 
 		map->cache_bypass = 1;
@@ -613,10 +623,7 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
 			continue;
 
 		val = regcache_get_val(map, block, i);
-
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def)
+		if (!regcache_reg_needs_sync(map, regtmp, val))
 			continue;
 
 		map->cache_bypass = 1;
@@ -688,10 +695,7 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
 		}
 
 		val = regcache_get_val(map, block, i);
-
-		/* Is this the hardware default?  If so skip. */
-		ret = regcache_lookup_reg(map, regtmp);
-		if (ret >= 0 && val == map->reg_defaults[ret].def) {
+		if (!regcache_reg_needs_sync(map, regtmp, val)) {
 			ret = regcache_sync_block_raw_flush(map, &data,
 							    base, regtmp);
 			if (ret != 0)
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
