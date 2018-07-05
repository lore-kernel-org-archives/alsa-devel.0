From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] regmap: slimbus: add support to raw read/writes
Date: Thu,  5 Jul 2018 12:37:00 +0100
Message-ID: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

SLIMbus supports upto 16 bytes in value management messages,
so add support to raw read/writes upto 16 bytes.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-slimbus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 91d501eda8a9..fc07518666b2 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -31,11 +31,30 @@ static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
 	return slim_writeb(sdev, reg, val);
 }
 
+static int regmap_slimbus_write(void *context, const void *data, size_t count)
+{
+	struct slim_device *sdev = context;
+
+	return slim_write(sdev, *(u16 *)data, count - 2, (u8 *)data + 2);
+}
+
+static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
+{
+	struct slim_device *sdev = context;
+
+	return slim_read(sdev, *(u16 *)reg, val_size, val);
+}
+
 static struct regmap_bus regmap_slimbus_bus = {
 	.reg_write = regmap_slimbus_byte_reg_write,
 	.reg_read = regmap_slimbus_byte_reg_read,
-	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
-	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.max_raw_write	= 16,
+	.max_raw_read	= 16,
+	.write = regmap_slimbus_write,
+	.read = regmap_slimbus_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 };
 
 static const struct regmap_bus *regmap_get_slimbus(struct slim_device *slim,
-- 
2.16.2
