From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: max9877: Convert to use regmap API
Date: Tue, 13 Aug 2013 13:33:45 +0100
Message-ID: <1376397227-13863-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5890B2610A5
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 14:33:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max9877.c | 187 ++++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 6b6c74c..7e2fe50 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -14,27 +14,21 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
 #include "max9877.h"
 
-static struct i2c_client *i2c;
+static struct regmap *regmap;
 
-static u8 max9877_regs[5] = { 0x40, 0x00, 0x00, 0x00, 0x49 };
-
-static void max9877_write_regs(void)
-{
-	unsigned int i;
-	u8 data[6];
-
-	data[0] = MAX9877_INPUT_MODE;
-	for (i = 0; i < ARRAY_SIZE(max9877_regs); i++)
-		data[i + 1] = max9877_regs[i];
-
-	if (i2c_master_send(i2c, data, 6) != 6)
-		dev_err(&i2c->dev, "i2c write failed\n");
-}
+static struct reg_default max9877_regs[] = {
+	{ 0, 0x40 },
+	{ 1, 0x00 },
+	{ 2, 0x00 },
+	{ 3, 0x00 },
+	{ 4, 0x49 },
+};
 
 static int max9877_get_reg(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
@@ -45,8 +39,14 @@ static int max9877_get_reg(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	unsigned int mask = mc->max;
 	unsigned int invert = mc->invert;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret != 0)
+		return ret;
 
-	ucontrol->value.integer.value[0] = (max9877_regs[reg] >> shift) & mask;
+	ucontrol->value.integer.value[0] = (val >> shift) & mask;
 
 	if (invert)
 		ucontrol->value.integer.value[0] =
@@ -65,18 +65,21 @@ static int max9877_set_reg(struct snd_kcontrol *kcontrol,
 	unsigned int mask = mc->max;
 	unsigned int invert = mc->invert;
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
+	bool change;
+	int ret;
 
 	if (invert)
 		val = mask - val;
 
-	if (((max9877_regs[reg] >> shift) & mask) == val)
-		return 0;
-
-	max9877_regs[reg] &= ~(mask << shift);
-	max9877_regs[reg] |= val << shift;
-	max9877_write_regs();
+	ret = regmap_update_bits_check(regmap, reg, mask << shift,
+				       val << shift, &change);
+	if (ret != 0)
+		return ret;
 
-	return 1;
+	if (change)
+		return 1;
+	else
+		return 0;
 }
 
 static int max9877_get_2reg(struct snd_kcontrol *kcontrol,
@@ -88,9 +91,18 @@ static int max9877_get_2reg(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
 	unsigned int mask = mc->max;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret != 0)
+		return ret;
+	ucontrol->value.integer.value[0] = (val >> shift) & mask;
 
-	ucontrol->value.integer.value[0] = (max9877_regs[reg] >> shift) & mask;
-	ucontrol->value.integer.value[1] = (max9877_regs[reg2] >> shift) & mask;
+	ret = regmap_read(regmap, reg2, &val);
+	if (ret != 0)
+		return ret;
+	ucontrol->value.integer.value[1] = (val >> shift) & mask;
 
 	return 0;
 }
@@ -106,77 +118,99 @@ static int max9877_set_2reg(struct snd_kcontrol *kcontrol,
 	unsigned int mask = mc->max;
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
 	unsigned int val2 = (ucontrol->value.integer.value[1] & mask);
-	unsigned int change = 0;
-
-	if (((max9877_regs[reg] >> shift) & mask) != val)
-		change = 1;
-
-	if (((max9877_regs[reg2] >> shift) & mask) != val2)
-		change = 1;
-
-	if (change) {
-		max9877_regs[reg] &= ~(mask << shift);
-		max9877_regs[reg] |= val << shift;
-		max9877_regs[reg2] &= ~(mask << shift);
-		max9877_regs[reg2] |= val2 << shift;
-		max9877_write_regs();
-	}
-
-	return change;
+	bool change1, change2;
+	int ret;
+
+	ret = regmap_update_bits_check(regmap, reg, mask << shift,
+				       val << shift, &change1);
+	if (ret != 0)
+		return ret;
+
+	ret = regmap_update_bits_check(regmap, reg2, mask << shift,
+				       val2 << shift, &change2);
+	if (ret != 0)
+		return ret;
+
+	if (change1 || change2)
+		return 1;
+	else
+		return 0;
 }
 
 static int max9877_get_out_mode(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	u8 value = max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OUTMODE_MASK;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, MAX9877_OUTPUT_MODE, &val);
+	if (ret != 0)
+		return ret;
+
+	val &= MAX9877_OUTMODE_MASK;
+	if (val)
+		val--;
 
-	if (value)
-		value -= 1;
+	ucontrol->value.integer.value[0] = val;
 
-	ucontrol->value.integer.value[0] = value;
 	return 0;
 }
 
 static int max9877_set_out_mode(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	u8 value = ucontrol->value.integer.value[0];
+	unsigned int val;
+	bool change;
+	int ret;
 
-	value += 1;
+	val = ucontrol->value.integer.value[0] + 1;
 
-	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OUTMODE_MASK) == value)
-		return 0;
+	ret = regmap_update_bits_check(regmap, MAX9877_OUTPUT_MODE,
+				       MAX9877_OUTMODE_MASK, val, &change);
+	if (ret != 0)
+		return ret;
 
-	max9877_regs[MAX9877_OUTPUT_MODE] &= ~MAX9877_OUTMODE_MASK;
-	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
-	max9877_write_regs();
-	return 1;
+	if (change)
+		return 1;
+	else
+		return 0;
 }
 
 static int max9877_get_osc_mode(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	u8 value = (max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OSC_MASK);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, MAX9877_OUTPUT_MODE, &val);
+	if (ret != 0)
+		return ret;
+
+	val &= MAX9877_OSC_MASK;
+	val >>= MAX9877_OSC_OFFSET;
 
-	value = value >> MAX9877_OSC_OFFSET;
+	ucontrol->value.integer.value[0] = val;
 
-	ucontrol->value.integer.value[0] = value;
 	return 0;
 }
 
 static int max9877_set_osc_mode(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	u8 value = ucontrol->value.integer.value[0];
-
-	value = value << MAX9877_OSC_OFFSET;
-	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OSC_MASK) == value)
+	unsigned int val;
+	bool change;
+	int ret;
+
+	val = ucontrol->value.integer.value[0] << MAX9877_OSC_OFFSET;
+	ret = regmap_update_bits_check(regmap, MAX9877_OUTPUT_MODE,
+				       MAX9877_OSC_MASK, val, &change);
+	if (ret != 0)
+		return ret;
+
+	if (change)
+		return 1;
+	else
 		return 0;
-
-	max9877_regs[MAX9877_OUTPUT_MODE] &= ~MAX9877_OSC_MASK;
-	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
-	max9877_write_regs();
-	return 1;
 }
 
 static const unsigned int max9877_pgain_tlv[] = {
@@ -258,19 +292,34 @@ int max9877_add_controls(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(max9877_add_controls);
 
+static const struct regmap_config max9877_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.reg_defaults = max9877_regs,
+	.num_reg_defaults = ARRAY_SIZE(max9877_regs),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int max9877_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	i2c = client;
+	int i;
+
+	regmap = devm_regmap_init_i2c(client, &max9877_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	max9877_write_regs();
+	/* Ensure the device is in reset state */
+	for (i = 0; i < ARRAY_SIZE(max9877_regs); i++)
+		regmap_write(regmap, max9877_regs[i].reg, max9877_regs[i].def);
 
 	return 0;
 }
 
 static int max9877_i2c_remove(struct i2c_client *client)
 {
-	i2c = NULL;
+	regmap = NULL;
 
 	return 0;
 }
-- 
1.8.4.rc2
