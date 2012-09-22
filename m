From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm2000: Add regulator support
Date: Sat, 22 Sep 2012 18:35:39 -0400
Message-ID: <1348353339-11880-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1348353339-11880-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5ED48260728
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2012 00:41:43 +0200 (CEST)
In-Reply-To: <1348353339-11880-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   53 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 6675477..b723e91 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -31,6 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/debugfs.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -43,6 +44,14 @@
 
 #include "wm2000.h"
 
+#define WM2000_NUM_SUPPLIES 3
+
+static const char *wm2000_supplies[WM2000_NUM_SUPPLIES] = {
+	"SPKVDD",
+	"DBVDD",
+	"DCVDD",
+};
+
 enum wm2000_anc_mode {
 	ANC_ACTIVE = 0,
 	ANC_BYPASS = 1,
@@ -54,6 +63,8 @@ struct wm2000_priv {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
 
+	struct regulator_bulk_data supplies[WM2000_NUM_SUPPLIES];
+
 	enum wm2000_anc_mode anc_mode;
 
 	unsigned int anc_active:1;
@@ -126,6 +137,12 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 
 	dev_dbg(&i2c->dev, "Beginning power up\n");
 
+	ret = regulator_bulk_enable(WM2000_NUM_SUPPLIES, wm2000->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	if (!wm2000->mclk_div) {
 		dev_dbg(&i2c->dev, "Disabling MCLK divider\n");
 		wm2000_write(i2c, WM2000_REG_SYS_CTL2,
@@ -143,12 +160,14 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT,
 			     WM2000_ANC_ENG_IDLE)) {
 		dev_err(&i2c->dev, "ANC engine failed to reset\n");
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 		return -ETIMEDOUT;
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
 			     WM2000_STATUS_BOOT_COMPLETE)) {
 		dev_err(&i2c->dev, "ANC engine failed to initialise\n");
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 		return -ETIMEDOUT;
 	}
 
@@ -163,11 +182,13 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 			      wm2000->anc_download_size);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "i2c_transfer() failed: %d\n", ret);
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 		return ret;
 	}
 	if (ret != wm2000->anc_download_size) {
 		dev_err(&i2c->dev, "i2c_transfer() failed, %d != %d\n",
 			ret, wm2000->anc_download_size);
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 		return -EIO;
 	}
 
@@ -201,6 +222,7 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
 			     WM2000_STATUS_MOUSE_ACTIVE)) {
 		dev_err(&i2c->dev, "Timed out waiting for device\n");
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 		return -ETIMEDOUT;
 	}
 
@@ -238,6 +260,8 @@ static int wm2000_power_down(struct i2c_client *i2c, int analogue)
 		return -ETIMEDOUT;
 	}
 
+	regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
+
 	dev_dbg(&i2c->dev, "powered off\n");
 	wm2000->anc_mode = ANC_OFF;
 
@@ -747,7 +771,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	struct wm2000_platform_data *pdata;
 	const char *filename;
 	const struct firmware *fw = NULL;
-	int ret;
+	int ret, i;
 	int reg;
 	u16 id;
 
@@ -768,6 +792,22 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 		goto out;
 	}
 
+	for (i = 0; i < WM2000_NUM_SUPPLIES; i++)
+		wm2000->supplies[i].supply = wm2000_supplies[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, WM2000_NUM_SUPPLIES,
+				      wm2000->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to get supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(WM2000_NUM_SUPPLIES, wm2000->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	/* Verify that this is a WM2000 */
 	reg = wm2000_read(i2c, WM2000_REG_ID1);
 	id = reg << 8;
@@ -777,7 +817,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (id != 0x2000) {
 		dev_err(&i2c->dev, "Device is not a WM2000 - ID %x\n", id);
 		ret = -ENODEV;
-		goto out;
+		goto err_supplies;
 	}
 
 	reg = wm2000_read(i2c, WM2000_REG_REVISON);
@@ -796,7 +836,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	ret = request_firmware(&fw, filename, &i2c->dev);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to acquire ANC data: %d\n", ret);
-		goto out;
+		goto err_supplies;
 	}
 
 	/* Pre-cook the concatenation of the register address onto the image */
@@ -807,7 +847,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (wm2000->anc_download == NULL) {
 		dev_err(&i2c->dev, "Out of memory\n");
 		ret = -ENOMEM;
-		goto out;
+		goto err_supplies;
 	}
 
 	wm2000->anc_download[0] = 0x80;
@@ -822,8 +862,9 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	wm2000_reset(wm2000);
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm2000, NULL, 0);
-	if (!ret)
-		goto out;
+
+err_supplies:
+	regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
 
 out:
 	release_firmware(fw);
-- 
1.7.10.4
