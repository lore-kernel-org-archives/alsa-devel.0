From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_update_bits() into
	macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:40 +0900
Message-ID: <E1aZ8uS-0008Eb-DG@finisterre>
References: <87a8n2imag.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09325265274
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:42 +0100 (CET)
In-Reply-To: <87a8n2imag.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_update_bits() into macro

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

>From ca7a94464b5457a8dc5add19f6fc3bea59d6193f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:22:42 +0000
Subject: [PATCH] regmap: merge regmap_update_bits() into macro

Current regmap has many similar update functions like below,
but the difference is very few.
	regmap_update_bits()
	regmap_update_bits_async()
	regmap_update_bits_check()
	regmap_update_bits_check_async()
Furthermore, we can add *force* write option too in the future.

This patch merges regmap_update_bits() into macro
by using regmap_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 23 -----------------------
 include/linux/regmap.h       | 12 +++---------
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4e35b2f41304..281898a97e8f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2688,29 +2688,6 @@ int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_update_bits_base);
 
 /**
- * regmap_update_bits: Perform a read/modify/write cycle on the register map
- *
- * @map: Register map to update
- * @reg: Register to update
- * @mask: Bitmask to change
- * @val: New value for bitmask
- *
- * Returns zero for success, a negative number on error.
- */
-int regmap_update_bits(struct regmap *map, unsigned int reg,
-		       unsigned int mask, unsigned int val)
-{
-	int ret;
-
-	map->lock(map->lock_arg);
-	ret = _regmap_update_bits(map, reg, mask, val, NULL, false);
-	map->unlock(map->lock_arg);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(regmap_update_bits);
-
-/**
  * regmap_write_bits: Perform a read/modify/write cycle on the register map
  *
  * @map: Register map to update
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 28e50a3d2872..500b36cbc7aa 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -65,6 +65,9 @@ struct reg_sequence {
 	unsigned int delay_us;
 };
 
+#define	regmap_update_bits(map, reg, mask, val) \
+	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
+
 #ifdef CONFIG_REGMAP
 
 enum regmap_endian {
@@ -694,8 +697,6 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    unsigned int mask, unsigned int val,
 			    bool *change, bool async, bool force);
-int regmap_update_bits(struct regmap *map, unsigned int reg,
-		       unsigned int mask, unsigned int val);
 int regmap_write_bits(struct regmap *map, unsigned int reg,
 		       unsigned int mask, unsigned int val);
 int regmap_update_bits_async(struct regmap *map, unsigned int reg,
@@ -948,13 +949,6 @@ static inline int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
-static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
-				     unsigned int mask, unsigned int val)
-{
-	WARN_ONCE(1, "regmap API is disabled");
-	return -EINVAL;
-}
-
 static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 				     unsigned int mask, unsigned int val)
 {
-- 
2.7.0
