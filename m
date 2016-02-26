From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_field_update_bits() into
	macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:32 +0900
Message-ID: <E1aZ8uK-0008Bc-4M@finisterre>
References: <871t8eim7d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 691DE2606F5
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:37 +0100 (CET)
In-Reply-To: <871t8eim7d.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_field_update_bits() into macro

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

>From 721ed64dda3774c619874866ca4f9a38ae6750af Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:24:33 +0000
Subject: [PATCH] regmap: merge regmap_field_update_bits() into macro

This patch merges regmap_field_update_bits() into macro
by using regmap_field_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 20 --------------------
 include/linux/regmap.h       |  4 ++--
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 228dce237658..606c9b53526b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1717,26 +1717,6 @@ int regmap_field_update_bits_base(struct regmap_field *field,
 EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
 
 /**
- * regmap_field_update_bits():	Perform a read/modify/write cycle
- *                              on the register field
- *
- * @field: Register field to write to
- * @mask: Bitmask to change
- * @val: Value to be written
- *
- * A value of zero will be returned on success, a negative errno will
- * be returned in error cases.
- */
-int regmap_field_update_bits(struct regmap_field *field, unsigned int mask, unsigned int val)
-{
-	mask = (mask << field->shift) & field->mask;
-
-	return regmap_update_bits(field->regmap, field->reg,
-				  mask, val << field->shift);
-}
-EXPORT_SYMBOL_GPL(regmap_field_update_bits);
-
-/**
  * regmap_fields_write(): Write a value to a single register field with port ID
  *
  * @field: Register field to write to
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 13e9ebdea1c7..e525beeaa2c6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -76,6 +76,8 @@ struct reg_sequence {
 
 #define	regmap_field_write(field, val) \
 	regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
+#define	regmap_field_update_bits(field, mask, val)\
+	regmap_field_update_bits_base(field, mask, val, NULL, false, false)
 
 #ifdef CONFIG_REGMAP
 
@@ -778,8 +780,6 @@ int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
 				  bool *change, bool async, bool force);
-int regmap_field_update_bits(struct regmap_field *field,
-			     unsigned int mask, unsigned int val);
 int regmap_fields_write(struct regmap_field *field, unsigned int id,
 			unsigned int val);
 int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
-- 
2.7.0
