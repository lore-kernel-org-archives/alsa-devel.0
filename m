From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_write_bits()" to the asoc
	tree
Date: Fri, 10 Jul 2015 11:40:00 +0100
Message-ID: <E1ZDViq-0002Fp-JU@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A322604EB
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

   regmap: add regmap_write_bits()

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

>From fd4b7286ccc469bf5dde22db6b8fcc455c3c4a66 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jun 2015 08:52:39 +0000
Subject: [PATCH] regmap: add regmap_write_bits()

regmap_write_bits() is similar to regmap_update_bits(),
but regmap_write_bits() write data to register even though
it is same value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 23 +++++++++++++++++++++++
 include/linux/regmap.h       |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 69ec411ce722..d93bb9a8ab98 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2375,6 +2375,29 @@ int regmap_update_bits(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_update_bits);
 
 /**
+ * regmap_write_bits: Perform a read/modify/write cycle on the register map
+ *
+ * @map: Register map to update
+ * @reg: Register to update
+ * @mask: Bitmask to change
+ * @val: New value for bitmask
+ *
+ * Returns zero for success, a negative number on error.
+ */
+int regmap_write_bits(struct regmap *map, unsigned int reg,
+		      unsigned int mask, unsigned int val)
+{
+	int ret;
+
+	map->lock(map->lock_arg);
+	ret = _regmap_update_bits(map, reg, mask, val, NULL, true);
+	map->unlock(map->lock_arg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_write_bits);
+
+/**
  * regmap_update_bits_async: Perform a read/modify/write cycle on the register
  *                           map asynchronously
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea0f0b5..e4b9ad4f05ef 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -424,6 +424,8 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits(struct regmap *map, unsigned int reg,
 		       unsigned int mask, unsigned int val);
+int regmap_write_bits(struct regmap *map, unsigned int reg,
+		       unsigned int mask, unsigned int val);
 int regmap_update_bits_async(struct regmap *map, unsigned int reg,
 			     unsigned int mask, unsigned int val);
 int regmap_update_bits_check(struct regmap *map, unsigned int reg,
@@ -645,6 +647,13 @@ static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_update_bits_async(struct regmap *map,
 					   unsigned int reg,
 					   unsigned int mask, unsigned int val)
-- 
2.1.4
