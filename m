From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_fields_force_write()" to
	the asoc tree
Date: Fri, 10 Jul 2015 11:39:59 +0100
Message-ID: <E1ZDVip-0002FH-Oh@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF81F2604C3
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

   regmap: add regmap_fields_force_write()

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

>From e874e6c7edc43436f73cf84157d9221f8b807c36 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jun 2015 08:52:55 +0000
Subject: [PATCH] regmap: add regmap_fields_force_write()

regmap_fields_force_write() is similar to regmap_fields_write(),
but regmap_fields_force_write() write data to register even though
it is same value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 12 ++++++++++++
 include/linux/regmap.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d93bb9a8ab98..dd63bcbbf8a5 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1624,6 +1624,18 @@ int regmap_fields_write(struct regmap_field *field, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(regmap_fields_write);
 
+int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
+			unsigned int val)
+{
+	if (id >= field->id_size)
+		return -EINVAL;
+
+	return regmap_write_bits(field->regmap,
+				  field->reg + (field->id_offset * id),
+				  field->mask, val << field->shift);
+}
+EXPORT_SYMBOL_GPL(regmap_fields_force_write);
+
 /**
  * regmap_fields_update_bits():	Perform a read/modify/write cycle
  *                              on the register field
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e4b9ad4f05ef..519c96231a91 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -505,6 +505,8 @@ int regmap_field_update_bits(struct regmap_field *field,
 
 int regmap_fields_write(struct regmap_field *field, unsigned int id,
 			unsigned int val);
+int regmap_fields_force_write(struct regmap_field *field, unsigned int id,
+			unsigned int val);
 int regmap_fields_read(struct regmap_field *field, unsigned int id,
 		       unsigned int *val);
 int regmap_fields_update_bits(struct regmap_field *field,  unsigned int id,
-- 
2.1.4
