From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 19/21] ASoC: Convert wm2000 to use regmap API
Date: Sat,  3 Dec 2011 21:33:27 +0000
Message-ID: <1322948009-27658-19-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B2370243CC
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:40 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver wasn't even using the ASoC common code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   75 ++++++++++++++++++--------------------------
 1 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 2726f66..a5f57ce 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -51,6 +52,7 @@ enum wm2000_anc_mode {
 
 struct wm2000_priv {
 	struct i2c_client *i2c;
+	struct regmap *regmap;
 
 	enum wm2000_anc_mode anc_mode;
 
@@ -70,54 +72,21 @@ static struct i2c_client *wm2000_i2c;
 static int wm2000_write(struct i2c_client *i2c, unsigned int reg,
 			unsigned int value)
 {
-	u8 data[3];
-	int ret;
-
-	data[0] = (reg >> 8) & 0xff;
-	data[1] = reg & 0xff;
-	data[2] = value & 0xff;
-
-	dev_vdbg(&i2c->dev, "write %x = %x\n", reg, value);
-
-	ret = i2c_master_send(i2c, data, 3);
-	if (ret == 3)
-		return 0;
-	if (ret < 0)
-		return ret;
-	else
-		return -EIO;
+	struct wm2000_priv *wm2000 = i2c_get_clientdata(i2c);
+	return regmap_write(wm2000->regmap, reg, value);
 }
 
 static unsigned int wm2000_read(struct i2c_client *i2c, unsigned int r)
 {
-	struct i2c_msg xfer[2];
-	u8 reg[2];
-	u8 data;
+	struct wm2000_priv *wm2000 = i2c_get_clientdata(i2c);
+	unsigned int val;
 	int ret;
 
-	/* Write register */
-	reg[0] = (r >> 8) & 0xff;
-	reg[1] = r & 0xff;
-	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = sizeof(reg);
-	xfer[0].buf = &reg[0];
-
-	/* Read data */
-	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 1;
-	xfer[1].buf = &data;
-
-	ret = i2c_transfer(i2c->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&i2c->dev, "i2c_transfer() returned %d\n", ret);
-		return 0;
-	}
-
-	dev_vdbg(&i2c->dev, "read %x from %x\n", data, r);
+	ret = regmap_read(wm2000->regmap, r, &val);
+	if (ret < 0)
+		return -1;
 
-	return data;
+	return val;
 }
 
 static void wm2000_reset(struct wm2000_priv *wm2000)
@@ -725,6 +694,11 @@ int wm2000_add_controls(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(wm2000_add_controls);
 
+static const struct regmap_config wm2000_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
@@ -747,6 +721,16 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
+	dev_set_drvdata(&i2c->dev, wm2000);
+
+	wm2000->regmap = regmap_init_i2c(i2c, &wm2000_regmap);
+	if (IS_ERR(wm2000->regmap)) {
+		ret = PTR_ERR(wm2000->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err;
+	}
+
 	/* Verify that this is a WM2000 */
 	reg = wm2000_read(i2c, WM2000_REG_ID1);
 	id = reg << 8;
@@ -756,7 +740,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (id != 0x2000) {
 		dev_err(&i2c->dev, "Device is not a WM2000 - ID %x\n", id);
 		ret = -ENODEV;
-		goto err;
+		goto err_regmap;
 	}
 
 	reg = wm2000_read(i2c, WM2000_REG_REVISON);
@@ -775,7 +759,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	ret = request_firmware(&fw, filename, &i2c->dev);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to acquire ANC data: %d\n", ret);
-		goto err;
+		goto err_regmap;
 	}
 
 	/* Pre-cook the concatenation of the register address onto the image */
@@ -795,7 +779,6 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 
 	release_firmware(fw);
 
-	dev_set_drvdata(&i2c->dev, wm2000);
 	wm2000->anc_eng_ena = 1;
 	wm2000->anc_active = 1;
 	wm2000->spk_ena = 1;
@@ -812,6 +795,8 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 
 err_fw:
 	release_firmware(fw);
+err_regmap:
+	regmap_exit(wm2000->regmap);
 err:
 	return ret;
 }
@@ -822,6 +807,8 @@ static __devexit int wm2000_i2c_remove(struct i2c_client *i2c)
 
 	wm2000_anc_transition(wm2000, ANC_OFF);
 
+	regmap_exit(wm2000->regmap);
+
 	wm2000_i2c = NULL;
 
 	return 0;
-- 
1.7.7.3
