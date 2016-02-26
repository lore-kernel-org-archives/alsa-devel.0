From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_update_bits_check() into
	macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:39 +0900
Message-ID: <E1aZ8uR-0008DY-1S@finisterre>
References: <877fi6im9g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1DFE2651CB
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:40 +0100 (CET)
In-Reply-To: <877fi6im9g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: merge regmap_update_bits_check() into macro

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 98c2dc48694a47109fff430a216fc13a9b45a4a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:23:17 +0000
Subject: [PATCH] regmap: merge regmap_update_bits_check() into macro

Current regmap has many similar update functions like below,
but the difference is very few.
	regmap_update_bits()
	regmap_update_bits_async()
	regmap_update_bits_check()
	regmap_update_bits_check_async()
Furthermore, we can add *force* write option too in the future.

This patch merges regmap_update_bits_check() into macro
by using regmap_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 25 -------------------------
 include/linux/regmap.h       | 14 ++------------
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c2255f604c03..ce24e9688b05 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2711,31 +2711,6 @@ int regmap_write_bits(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_write_bits);
 
 /**
- * regmap_update_bits_check: Perform a read/modify/write cycle on the
- *                           register map and report if updated
- *
- * @map: Register map to update
- * @reg: Register to update
- * @mask: Bitmask to change
- * @val: New value for bitmask
- * @change: Boolean indicating if a write was done
- *
- * Returns zero for success, a negative number on error.
- */
-int regmap_update_bits_check(struct regmap *map, unsigned int reg,
-			     unsigned int mask, unsigned int val,
-			     bool *change)
-{
-	int ret;
-
-	map->lock(map->lock_arg);
-	ret = _regmap_update_bits(map, reg, mask, val, change, false);
-	map->unlock(map->lock_arg);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(regmap_update_bits_check);
-
-/**
  * regmap_update_bits_check_async: Perform a read/modify/write cycle on the
  *                                 register map asynchronously and report if
  *                                 updated
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 90c8b0e99f9d..dd227dd5e5f8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -69,6 +69,8 @@ struct reg_sequence {
 	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
 #define	regmap_update_bits_async(map, reg, mask, val)\
 	regmap_update_bits_base(map, reg, mask, val, NULL, true, false)
+#define	regmap_update_bits_check(map, reg, mask, val, change)\
+	regmap_update_bits_base(map, reg, mask, val, change, false, false)
 
 #ifdef CONFIG_REGMAP
 
@@ -701,9 +703,6 @@ int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    bool *change, bool async, bool force);
 int regmap_write_bits(struct regmap *map, unsigned int reg,
 		       unsigned int mask, unsigned int val);
-int regmap_update_bits_check(struct regmap *map, unsigned int reg,
-			     unsigned int mask, unsigned int val,
-			     bool *change);
 int regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 				   unsigned int mask, unsigned int val,
 				   bool *change);
@@ -956,15 +955,6 @@ static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
-static inline int regmap_update_bits_check(struct regmap *map,
-					   unsigned int reg,
-					   unsigned int mask, unsigned int val,
-					   bool *change)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-	return -EINVAL;
-}
-
 static inline int regmap_update_bits_check_async(struct regmap *map,
 						 unsigned int reg,
 						 unsigned int mask,
-- 
2.7.0
