From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] regmap: slimbus: add support to multi
	read/write
Date: Fri,  6 Jul 2018 16:05:27 +0100
Message-ID: <20180706150527.8811-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B22682673C7
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 17:07:39 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id k7-v6so4519286wrq.0
 for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2018 08:07:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SLIMbus supports upto 16 bytes in value management messages,
so add support to read/writes upto 16 bytes.

This also removes redundant single register reg_read/reg_write.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.16.2
