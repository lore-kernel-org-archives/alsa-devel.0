From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_fields_update_bits()
	into macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:29 +0900
Message-ID: <E1aZ8uH-0008A9-Q6@finisterre>
References: <87wpq6h7l9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB55265150
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:31 +0100 (CET)
In-Reply-To: <87wpq6h7l9.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_fields_update_bits() into macro

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

>From 48138609135fc9c363f034596e14bff5dbf9f33f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:25:32 +0000
Subject: [PATCH] regmap: merge regmap_fields_update_bits() into macro

This patch merges regmap_fields_update_bits() into macro
by using regmap_field_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 26 --------------------------
 include/linux/regmap.h       |  4 ++--
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4b14745249ba..79d7f51019d7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1760,32 +1760,6 @@ int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(regmap_fields_force_write);
 
-/**
- * regmap_fields_update_bits():	Perform a read/modify/write cycle
- *                              on the register field
- *
- * @field: Register field to write to
- * @id: port ID
- * @mask: Bitmask to change
- * @val: Value to be written
- *
- * A value of zero will be returned on success, a negative errno will
- * be returned in error cases.
- */
-int regmap_fields_update_bits(struct regmap_field *field,  unsigned int id,
-			      unsigned int mask, unsigned int val)
-{
-	if (id >= field->id_size)
-		return -EINVAL;
-
-	mask = (mask << field->shift) & field->mask;
-
-	return regmap_update_bits(field->regmap,
-				  field->reg + (field->id_offset * id),
-				  mask, val << field->shift);
-}
-EXPORT_SYMBOL_GPL(regmap_fields_update_bits);
-
 /*
  * regmap_bulk_write(): Write multiple registers to the device
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 5f438a4df5e6..7d3d498fd3e8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -81,6 +81,8 @@ struct reg_sequence {
 
 #define	regmap_fields_write(field, id, val) \
 	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, false)
+#define	regmap_fields_update_bits(field, id, mask, val)\
+	regmap_fields_update_bits_base(field, id, mask, val, NULL, false, false)
 
 #ifdef CONFIG_REGMAP
 
@@ -787,8 +789,6 @@ int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
 			unsigned int val);
 int regmap_fields_read(struct regmap_field *field, unsigned int id,
 		       unsigned int *val);
-int regmap_fields_update_bits(struct regmap_field *field,  unsigned int id,
-			      unsigned int mask, unsigned int val);
 int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force);
-- 
2.7.0
