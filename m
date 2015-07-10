From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add force_write option on
	_regmap_update_bits()" to the asoc tree
Date: Fri, 10 Jul 2015 11:40:02 +0100
Message-ID: <E1ZDVis-0002GL-5z@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E129D2604E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 12:40:08 +0200 (CEST)
In-Reply-To: 
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

   regmap: add force_write option on _regmap_update_bits()

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

>From 7ff0589c7bff4ca31b255ac2028f633f14047762 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jun 2015 08:52:22 +0000
Subject: [PATCH] regmap: add force_write option on _regmap_update_bits()

Sometimes we want to write data even though it doesn't change value.
Then, force_write option on _regmap_update_bits() helps this purpose.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7111d04f2621..69ec411ce722 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -34,7 +34,7 @@
 
 static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
-			       bool *change);
+			       bool *change, bool force_write);
 
 static int _regmap_bus_reg_read(void *context, unsigned int reg,
 				unsigned int *val);
@@ -1178,7 +1178,7 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 		ret = _regmap_update_bits(map, range->selector_reg,
 					  range->selector_mask,
 					  win_page << range->selector_shift,
-					  &page_chg);
+					  &page_chg, false);
 
 		map->work_buf = orig_work_buf;
 
@@ -2327,7 +2327,7 @@ EXPORT_SYMBOL_GPL(regmap_bulk_read);
 
 static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
-			       bool *change)
+			       bool *change, bool force_write)
 {
 	int ret;
 	unsigned int tmp, orig;
@@ -2339,7 +2339,7 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 	tmp = orig & ~mask;
 	tmp |= val & mask;
 
-	if (tmp != orig) {
+	if (force_write || (tmp != orig)) {
 		ret = _regmap_write(map, reg, tmp);
 		if (change)
 			*change = true;
@@ -2367,7 +2367,7 @@ int regmap_update_bits(struct regmap *map, unsigned int reg,
 	int ret;
 
 	map->lock(map->lock_arg);
-	ret = _regmap_update_bits(map, reg, mask, val, NULL);
+	ret = _regmap_update_bits(map, reg, mask, val, NULL, false);
 	map->unlock(map->lock_arg);
 
 	return ret;
@@ -2398,7 +2398,7 @@ int regmap_update_bits_async(struct regmap *map, unsigned int reg,
 
 	map->async = true;
 
-	ret = _regmap_update_bits(map, reg, mask, val, NULL);
+	ret = _regmap_update_bits(map, reg, mask, val, NULL, false);
 
 	map->async = false;
 
@@ -2427,7 +2427,7 @@ int regmap_update_bits_check(struct regmap *map, unsigned int reg,
 	int ret;
 
 	map->lock(map->lock_arg);
-	ret = _regmap_update_bits(map, reg, mask, val, change);
+	ret = _regmap_update_bits(map, reg, mask, val, change, false);
 	map->unlock(map->lock_arg);
 	return ret;
 }
@@ -2460,7 +2460,7 @@ int regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 
 	map->async = true;
 
-	ret = _regmap_update_bits(map, reg, mask, val, change);
+	ret = _regmap_update_bits(map, reg, mask, val, change, false);
 
 	map->async = false;
 
-- 
2.1.4
