From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: merge regmap_field_write() into
	macro" to the asoc tree
Date: Fri, 26 Feb 2016 12:17:36 +0900
Message-ID: <E1aZ8uO-0008C6-Fh@finisterre>
References: <8737suim7w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48C6E2651AC
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:38 +0100 (CET)
In-Reply-To: <8737suim7w.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: merge regmap_field_write() into macro

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

>From 3674124b35894631f8f4d33ab041e713078bfd4b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:24:15 +0000
Subject: [PATCH] regmap: merge regmap_field_write() into macro

This patch merges regmap_field_write() into macro
by using regmap_field_update_bits_base().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 16 ----------------
 include/linux/regmap.h       |  4 +++-
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e534105f47f6..228dce237658 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1717,22 +1717,6 @@ int regmap_field_update_bits_base(struct regmap_field *field,
 EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
 
 /**
- * regmap_field_write(): Write a value to a single register field
- *
- * @field: Register field to write to
- * @val: Value to be written
- *
- * A value of zero will be returned on success, a negative errno will
- * be returned in error cases.
- */
-int regmap_field_write(struct regmap_field *field, unsigned int val)
-{
-	return regmap_update_bits(field->regmap, field->reg,
-				field->mask, val << field->shift);
-}
-EXPORT_SYMBOL_GPL(regmap_field_write);
-
-/**
  * regmap_field_update_bits():	Perform a read/modify/write cycle
  *                              on the register field
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 23bf7657e485..13e9ebdea1c7 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -74,6 +74,9 @@ struct reg_sequence {
 #define	regmap_update_bits_check_async(map, reg, mask, val, change)\
 	regmap_update_bits_base(map, reg, mask, val, change, true, false)
 
+#define	regmap_field_write(field, val) \
+	regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
+
 #ifdef CONFIG_REGMAP
 
 enum regmap_endian {
@@ -772,7 +775,6 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
 void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
 
 int regmap_field_read(struct regmap_field *field, unsigned int *val);
-int regmap_field_write(struct regmap_field *field, unsigned int val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
 				  bool *change, bool async, bool force);
-- 
2.7.0
