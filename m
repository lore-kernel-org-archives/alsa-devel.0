From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: remove regmap_write_bits()" to the
	asoc tree
Date: Fri, 26 Feb 2016 12:17:27 +0900
Message-ID: <E1aZ8uF-00088f-My@finisterre>
References: <87si0uh7jm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8AF26510A
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:30 +0100 (CET)
In-Reply-To: <87si0uh7jm.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: remove regmap_write_bits()

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

>From 23b92e4cf5fd99e3d58298f6423f106bffb9ca42 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:26:32 +0000
Subject: [PATCH] regmap: remove regmap_write_bits()

We can use _force_ write by regmap_update_bits_base() option.
Let's remove unused regmap_write_bits()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 23 -----------------------
 include/linux/regmap.h       |  9 ---------
 2 files changed, 32 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c7d4a636778d..3fb04c36ae5e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2650,29 +2650,6 @@ int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_update_bits_base);
 
-/**
- * regmap_write_bits: Perform a read/modify/write cycle on the register map
- *
- * @map: Register map to update
- * @reg: Register to update
- * @mask: Bitmask to change
- * @val: New value for bitmask
- *
- * Returns zero for success, a negative number on error.
- */
-int regmap_write_bits(struct regmap *map, unsigned int reg,
-		      unsigned int mask, unsigned int val)
-{
-	int ret;
-
-	map->lock(map->lock_arg);
-	ret = _regmap_update_bits(map, reg, mask, val, NULL, true);
-	map->unlock(map->lock_arg);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(regmap_write_bits);
-
 void regmap_async_complete_cb(struct regmap_async *async, int ret)
 {
 	struct regmap *map = async->map;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e0960b3ff290..5315ff0adb85 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -721,8 +721,6 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    unsigned int mask, unsigned int val,
 			    bool *change, bool async, bool force);
-int regmap_write_bits(struct regmap *map, unsigned int reg,
-		       unsigned int mask, unsigned int val);
 int regmap_get_val_bytes(struct regmap *map);
 int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
@@ -961,13 +959,6 @@ static inline int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
-static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
-				     unsigned int mask, unsigned int val)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-	return -EINVAL;
-}
-
 static inline int regmap_field_update_bits_base(struct regmap_field *field,
 					unsigned int mask, unsigned int val,
 					bool *change, bool async, bool force)
-- 
2.7.0
