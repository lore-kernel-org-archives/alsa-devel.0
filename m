From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_update_bits_base()" to the
	asoc tree
Date: Fri, 26 Feb 2016 12:17:41 +0900
Message-ID: <E1aZ8uT-0008F5-5M@finisterre>
References: <87bn7iimb5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C175B265150
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:42 +0100 (CET)
In-Reply-To: <87bn7iimb5.wl%kuninori.morimoto.gx@renesas.com>
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

   regmap: add regmap_update_bits_base()

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

>From 91d31b9f8e7662726f273fc32b25f4099d78de4a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:22:18 +0000
Subject: [PATCH] regmap: add regmap_update_bits_base()

Current regmap has many similar update functions like below,
but the difference is very few.
	regmap_update_bits()
	regmap_update_bits_async()
	regmap_update_bits_check()
	regmap_update_bits_check_async()
Furthermore, we can add *force* write option too in the future.

This patch adds new regmap_update_bits_base() which is feature
merged function. Above functions can be merged into it by macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee54e841de4a..4e35b2f41304 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2648,6 +2648,46 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 }
 
 /**
+ * regmap_update_bits_base:
+ *	Perform a read/modify/write cycle on the
+ *	register map with change, async, force option
+ *
+ * @map: Register map to update
+ * @reg: Register to update
+ * @mask: Bitmask to change
+ * @val: New value for bitmask
+ * @change: Boolean indicating if a write was done
+ * @async: Boolean indicating asynchronously
+ * @force: Boolean indicating use force update
+ *
+ * if async was true,
+ * With most buses the read must be done synchronously so this is most
+ * useful for devices with a cache which do not need to interact with
+ * the hardware to determine the current register value.
+ *
+ * Returns zero for success, a negative number on error.
+ */
+int regmap_update_bits_base(struct regmap *map, unsigned int reg,
+			    unsigned int mask, unsigned int val,
+			    bool *change, bool async, bool force)
+{
+	int ret;
+
+	map->lock(map->lock_arg);
+
+	map->async = async;
+
+	ret = _regmap_update_bits(map, reg, mask, val, change, force);
+
+	map->async = false;
+
+	map->unlock(map->lock_arg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_update_bits_base);
+
+/**
  * regmap_update_bits: Perform a read/modify/write cycle on the register map
  *
  * @map: Register map to update
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 18394343f489..28e50a3d2872 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -691,6 +691,9 @@ int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
+int regmap_update_bits_base(struct regmap *map, unsigned int reg,
+			    unsigned int mask, unsigned int val,
+			    bool *change, bool async, bool force);
 int regmap_update_bits(struct regmap *map, unsigned int reg,
 		       unsigned int mask, unsigned int val);
 int regmap_write_bits(struct regmap *map, unsigned int reg,
@@ -937,6 +940,14 @@ static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_update_bits_base(struct regmap *map, unsigned int reg,
+					  unsigned int mask, unsigned int val,
+					  bool *change, bool async, bool force)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
 				     unsigned int mask, unsigned int val)
 {
-- 
2.7.0
