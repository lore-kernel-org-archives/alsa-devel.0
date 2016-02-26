From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_fields_write() into
	macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:30 +0900
Message-ID: <E1aZ8uI-0008Ad-Gh@finisterre>
References: <87y4amh7lv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50083265173
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:32 +0100 (CET)
In-Reply-To: <87y4amh7lv.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_fields_write() into macro

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

>From bbf2c46f46e23a496337e143cd012c013c6c7910 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:25:15 +0000
Subject: [PATCH] regmap: merge regmap_fields_write() into macro

This patch merges regmap_fields_write() into macro
by using regmap_fields_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 22 ----------------------
 include/linux/regmap.h       |  5 +++--
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0c7773fadd48..4b14745249ba 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1748,28 +1748,6 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 }
 EXPORT_SYMBOL_GPL(regmap_fields_update_bits_base);
 
-/**
- * regmap_fields_write(): Write a value to a single register field with port ID
- *
- * @field: Register field to write to
- * @id: port ID
- * @val: Value to be written
- *
- * A value of zero will be returned on success, a negative errno will
- * be returned in error cases.
- */
-int regmap_fields_write(struct regmap_field *field, unsigned int id,
-			unsigned int val)
-{
-	if (id >= field->id_size)
-		return -EINVAL;
-
-	return regmap_update_bits(field->regmap,
-				  field->reg + (field->id_offset * id),
-				  field->mask, val << field->shift);
-}
-EXPORT_SYMBOL_GPL(regmap_fields_write);
-
 int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
 			unsigned int val)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 2735a3df7eab..5f438a4df5e6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -79,6 +79,9 @@ struct reg_sequence {
 #define	regmap_field_update_bits(field, mask, val)\
 	regmap_field_update_bits_base(field, mask, val, NULL, false, false)
 
+#define	regmap_fields_write(field, id, val) \
+	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, false)
+
 #ifdef CONFIG_REGMAP
 
 enum regmap_endian {
@@ -780,8 +783,6 @@ int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
 				  bool *change, bool async, bool force);
-int regmap_fields_write(struct regmap_field *field, unsigned int id,
-			unsigned int val);
 int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
 			unsigned int val);
 int regmap_fields_read(struct regmap_field *field, unsigned int id,
-- 
2.7.0
