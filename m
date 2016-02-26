From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_fields_force_xxx() macros"
	to the asoc tree
Date: Fri, 26 Feb 2016 12:17:28 +0900
Message-ID: <E1aZ8uG-000899-Db@finisterre>
References: <87twlah7k3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEED264EFA
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:30 +0100 (CET)
In-Reply-To: <87twlah7k3.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: add regmap_fields_force_xxx() macros

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

>From e6ef243fa4660f3206137bd5f3e69b13a9b7c28a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:26:14 +0000
Subject: [PATCH] regmap: add regmap_fields_force_xxx() macros

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 12 ------------
 include/linux/regmap.h       |  6 ++++--
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 79d7f51019d7..c7d4a636778d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1748,18 +1748,6 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 }
 EXPORT_SYMBOL_GPL(regmap_fields_update_bits_base);
 
-int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
-			unsigned int val)
-{
-	if (id >= field->id_size)
-		return -EINVAL;
-
-	return regmap_write_bits(field->regmap,
-				  field->reg + (field->id_offset * id),
-				  field->mask, val << field->shift);
-}
-EXPORT_SYMBOL_GPL(regmap_fields_force_write);
-
 /*
  * regmap_bulk_write(): Write multiple registers to the device
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d36ea89adc50..e0960b3ff290 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -85,8 +85,12 @@ struct reg_sequence {
 
 #define	regmap_fields_write(field, id, val) \
 	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, false)
+#define	regmap_fields_force_write(field, id, val) \
+	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, true)
 #define	regmap_fields_update_bits(field, id, mask, val)\
 	regmap_fields_update_bits_base(field, id, mask, val, NULL, false, false)
+#define	regmap_fields_force_update_bits(field, id, mask, val) \
+	regmap_fields_update_bits_base(field, id, mask, val, NULL, false, true)
 
 #ifdef CONFIG_REGMAP
 
@@ -789,8 +793,6 @@ int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
 				  bool *change, bool async, bool force);
-int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
-			unsigned int val);
 int regmap_fields_read(struct regmap_field *field, unsigned int id,
 		       unsigned int *val);
 int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
-- 
2.7.0
