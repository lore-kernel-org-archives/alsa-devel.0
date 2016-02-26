From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge
	regmap_update_bits_check_async() into macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:38 +0900
Message-ID: <E1aZ8uQ-0008D4-9w@finisterre>
References: <8760xqim8z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECADF2651B9
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:39 +0100 (CET)
In-Reply-To: <8760xqim8z.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_update_bits_check_async() into macro

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

>From 89d8d4b833b0b29e0e95bd0cd51e80f5ee7a6b0a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:23:37 +0000
Subject: [PATCH] regmap: merge regmap_update_bits_check_async() into macro

Current regmap has many similar update functions like below,
but the difference is very few.
	regmap_update_bits()
	regmap_update_bits_async()
	regmap_update_bits_check()
	regmap_update_bits_check_async()
Furthermore, we can add *force* write option too in the future.

This patch merges regmap_update_bits_check_async() into macro
by using regmap_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 37 -------------------------------------
 include/linux/regmap.h       | 15 ++-------------
 2 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ce24e9688b05..015135a656b7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2710,43 +2710,6 @@ int regmap_write_bits(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_write_bits);
 
-/**
- * regmap_update_bits_check_async: Perform a read/modify/write cycle on the
- *                                 register map asynchronously and report if
- *                                 updated
- *
- * @map: Register map to update
- * @reg: Register to update
- * @mask: Bitmask to change
- * @val: New value for bitmask
- * @change: Boolean indicating if a write was done
- *
- * With most buses the read must be done synchronously so this is most
- * useful for devices with a cache which do not need to interact with
- * the hardware to determine the current register value.
- *
- * Returns zero for success, a negative number on error.
- */
-int regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
-				   unsigned int mask, unsigned int val,
-				   bool *change)
-{
-	int ret;
-
-	map->lock(map->lock_arg);
-
-	map->async = true;
-
-	ret = _regmap_update_bits(map, reg, mask, val, change, false);
-
-	map->async = false;
-
-	map->unlock(map->lock_arg);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(regmap_update_bits_check_async);
-
 void regmap_async_complete_cb(struct regmap_async *async, int ret)
 {
 	struct regmap *map = async->map;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index dd227dd5e5f8..4d8e1edb4407 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -71,6 +71,8 @@ struct reg_sequence {
 	regmap_update_bits_base(map, reg, mask, val, NULL, true, false)
 #define	regmap_update_bits_check(map, reg, mask, val, change)\
 	regmap_update_bits_base(map, reg, mask, val, change, false, false)
+#define	regmap_update_bits_check_async(map, reg, mask, val, change)\
+	regmap_update_bits_base(map, reg, mask, val, change, true, false)
 
 #ifdef CONFIG_REGMAP
 
@@ -703,9 +705,6 @@ int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    bool *change, bool async, bool force);
 int regmap_write_bits(struct regmap *map, unsigned int reg,
 		       unsigned int mask, unsigned int val);
-int regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
-				   unsigned int mask, unsigned int val,
-				   bool *change);
 int regmap_get_val_bytes(struct regmap *map);
 int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
@@ -955,16 +954,6 @@ static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
-static inline int regmap_update_bits_check_async(struct regmap *map,
-						 unsigned int reg,
-						 unsigned int mask,
-						 unsigned int val,
-						 bool *change)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-	return -EINVAL;
-}
-
 static inline int regmap_get_val_bytes(struct regmap *map)
 {
 	WARN_ONCE(1, "regmap API is disabled");
-- 
2.7.0
