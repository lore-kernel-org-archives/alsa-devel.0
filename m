From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_field_update_bits_base()"
	to the asoc tree
Date: Fri, 26 Feb 2016 12:17:37 +0900
Message-ID: <E1aZ8uP-0008Ca-DF@finisterre>
References: <874mdaim8e.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C192651B8
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:39 +0100 (CET)
In-Reply-To: <874mdaim8e.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: add regmap_field_update_bits_base()

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

>From 28972eaa34f384eef5e33f36e00d8fa21ca44375 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:23:55 +0000
Subject: [PATCH] regmap: add regmap_field_update_bits_base()

This patch adds new regmap_field_update_bits_base() which is using
regmap_update_bits_base().
Current regmap_field_xxx() can be merged into it by macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 27 +++++++++++++++++++++++++++
 include/linux/regmap.h       | 12 +++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 015135a656b7..e534105f47f6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1690,6 +1690,33 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_raw_write);
 
 /**
+ * regmap_field_update_bits_base():
+ *	Perform a read/modify/write cycle on the register field
+ *	with change, async, force option
+ *
+ * @field: Register field to write to
+ * @mask: Bitmask to change
+ * @val: Value to be written
+ * @change: Boolean indicating if a write was done
+ * @async: Boolean indicating asynchronously
+ * @force: Boolean indicating use force update
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+int regmap_field_update_bits_base(struct regmap_field *field,
+				  unsigned int mask, unsigned int val,
+				  bool *change, bool async, bool force)
+{
+	mask = (mask << field->shift) & field->mask;
+
+	return regmap_update_bits_base(field->regmap, field->reg,
+				       mask, val << field->shift,
+				       change, async, force);
+}
+EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
+
+/**
  * regmap_field_write(): Write a value to a single register field
  *
  * @field: Register field to write to
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4d8e1edb4407..23bf7657e485 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -773,9 +773,11 @@ void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
 
 int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_write(struct regmap_field *field, unsigned int val);
+int regmap_field_update_bits_base(struct regmap_field *field,
+				  unsigned int mask, unsigned int val,
+				  bool *change, bool async, bool force);
 int regmap_field_update_bits(struct regmap_field *field,
 			     unsigned int mask, unsigned int val);
-
 int regmap_fields_write(struct regmap_field *field, unsigned int id,
 			unsigned int val);
 int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
@@ -954,6 +956,14 @@ static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_field_update_bits_base(struct regmap_field *field,
+					unsigned int mask, unsigned int val,
+					bool *change, bool async, bool force)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_get_val_bytes(struct regmap *map)
 {
 	WARN_ONCE(1, "regmap API is disabled");
-- 
2.7.0
