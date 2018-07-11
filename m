From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: slimbus: add support to multi read/write" to the regmap tree
Date: Wed, 11 Jul 2018 11:59:14 +0100
Message-ID: <E1fdCq2-0007z5-D1@debutante>
References: <20180706150527.8811-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706150527.8811-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.orglinux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: slimbus: add support to multi read/write

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From e76ad18b56775aa20c0fb8e6203fae2aaee57e5c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 6 Jul 2018 16:05:27 +0100
Subject: [PATCH] regmap: slimbus: add support to multi read/write

SLIMbus supports upto 16 bytes in value management messages,
so add support to read/writes upto 16 bytes.

This also removes redundant single register reg_read/reg_write.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-slimbus.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 91d501eda8a9..0968059f1ef5 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -7,33 +7,24 @@
 
 #include "internal.h"
 
-static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
-					unsigned int *val)
+static int regmap_slimbus_write(void *context, const void *data, size_t count)
 {
 	struct slim_device *sdev = context;
-	int v;
 
-	v = slim_readb(sdev, reg);
-
-	if (v < 0)
-		return v;
-
-	*val = v;
-
-	return 0;
+	return slim_write(sdev, *(u16 *)data, count - 2, (u8 *)data + 2);
 }
 
-static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
-					 unsigned int val)
+static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
 {
 	struct slim_device *sdev = context;
 
-	return slim_writeb(sdev, reg, val);
+	return slim_read(sdev, *(u16 *)reg, val_size, val);
 }
 
 static struct regmap_bus regmap_slimbus_bus = {
-	.reg_write = regmap_slimbus_byte_reg_write,
-	.reg_read = regmap_slimbus_byte_reg_read,
+	.write = regmap_slimbus_write,
+	.read = regmap_slimbus_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
-- 
2.18.0.rc2
