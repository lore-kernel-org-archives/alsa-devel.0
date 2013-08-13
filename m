From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: max9877: Convert to standard CODEC
	driver
Date: Tue, 13 Aug 2013 13:33:46 +0100
Message-ID: <1376397227-13863-2-git-send-email-broonie@kernel.org>
References: <1376397227-13863-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C96D2610B6
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 14:33:55 +0200 (CEST)
In-Reply-To: <1376397227-13863-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/max9877.c | 256 ++++++---------------------------------------
 1 file changed, 31 insertions(+), 225 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 7e2fe50..8505b40 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -30,189 +30,6 @@ static struct reg_default max9877_regs[] = {
 	{ 4, 0x49 },
 };
 
-static int max9877_get_reg(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
-	unsigned int invert = mc->invert;
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(regmap, reg, &val);
-	if (ret != 0)
-		return ret;
-
-	ucontrol->value.integer.value[0] = (val >> shift) & mask;
-
-	if (invert)
-		ucontrol->value.integer.value[0] =
-			mask - ucontrol->value.integer.value[0];
-
-	return 0;
-}
-
-static int max9877_set_reg(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
-	unsigned int invert = mc->invert;
-	unsigned int val = (ucontrol->value.integer.value[0] & mask);
-	bool change;
-	int ret;
-
-	if (invert)
-		val = mask - val;
-
-	ret = regmap_update_bits_check(regmap, reg, mask << shift,
-				       val << shift, &change);
-	if (ret != 0)
-		return ret;
-
-	if (change)
-		return 1;
-	else
-		return 0;
-}
-
-static int max9877_get_2reg(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(regmap, reg, &val);
-	if (ret != 0)
-		return ret;
-	ucontrol->value.integer.value[0] = (val >> shift) & mask;
-
-	ret = regmap_read(regmap, reg2, &val);
-	if (ret != 0)
-		return ret;
-	ucontrol->value.integer.value[1] = (val >> shift) & mask;
-
-	return 0;
-}
-
-static int max9877_set_2reg(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
-	unsigned int val = (ucontrol->value.integer.value[0] & mask);
-	unsigned int val2 = (ucontrol->value.integer.value[1] & mask);
-	bool change1, change2;
-	int ret;
-
-	ret = regmap_update_bits_check(regmap, reg, mask << shift,
-				       val << shift, &change1);
-	if (ret != 0)
-		return ret;
-
-	ret = regmap_update_bits_check(regmap, reg2, mask << shift,
-				       val2 << shift, &change2);
-	if (ret != 0)
-		return ret;
-
-	if (change1 || change2)
-		return 1;
-	else
-		return 0;
-}
-
-static int max9877_get_out_mode(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(regmap, MAX9877_OUTPUT_MODE, &val);
-	if (ret != 0)
-		return ret;
-
-	val &= MAX9877_OUTMODE_MASK;
-	if (val)
-		val--;
-
-	ucontrol->value.integer.value[0] = val;
-
-	return 0;
-}
-
-static int max9877_set_out_mode(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	unsigned int val;
-	bool change;
-	int ret;
-
-	val = ucontrol->value.integer.value[0] + 1;
-
-	ret = regmap_update_bits_check(regmap, MAX9877_OUTPUT_MODE,
-				       MAX9877_OUTMODE_MASK, val, &change);
-	if (ret != 0)
-		return ret;
-
-	if (change)
-		return 1;
-	else
-		return 0;
-}
-
-static int max9877_get_osc_mode(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(regmap, MAX9877_OUTPUT_MODE, &val);
-	if (ret != 0)
-		return ret;
-
-	val &= MAX9877_OSC_MASK;
-	val >>= MAX9877_OSC_OFFSET;
-
-	ucontrol->value.integer.value[0] = val;
-
-	return 0;
-}
-
-static int max9877_set_osc_mode(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	unsigned int val;
-	bool change;
-	int ret;
-
-	val = ucontrol->value.integer.value[0] << MAX9877_OSC_OFFSET;
-	ret = regmap_update_bits_check(regmap, MAX9877_OUTPUT_MODE,
-				       MAX9877_OSC_MASK, val, &change);
-	if (ret != 0)
-		return ret;
-
-	if (change)
-		return 1;
-	else
-		return 0;
-}
-
 static const unsigned int max9877_pgain_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
 	0, 1, TLV_DB_SCALE_ITEM(0, 900, 0),
@@ -246,51 +63,40 @@ static const char *max9877_osc_mode[] = {
 };
 
 static const struct soc_enum max9877_enum[] = {
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max9877_out_mode), max9877_out_mode),
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max9877_osc_mode), max9877_osc_mode),
+	SOC_ENUM_SINGLE(MAX9877_OUTPUT_MODE, 0, ARRAY_SIZE(max9877_out_mode),
+			max9877_out_mode),
+	SOC_ENUM_SINGLE(MAX9877_OUTPUT_MODE, MAX9877_OSC_OFFSET,
+			ARRAY_SIZE(max9877_osc_mode), max9877_osc_mode),
 };
 
 static const struct snd_kcontrol_new max9877_controls[] = {
-	SOC_SINGLE_EXT_TLV("MAX9877 PGAINA Playback Volume",
-			MAX9877_INPUT_MODE, 0, 2, 0,
-			max9877_get_reg, max9877_set_reg, max9877_pgain_tlv),
-	SOC_SINGLE_EXT_TLV("MAX9877 PGAINB Playback Volume",
-			MAX9877_INPUT_MODE, 2, 2, 0,
-			max9877_get_reg, max9877_set_reg, max9877_pgain_tlv),
-	SOC_SINGLE_EXT_TLV("MAX9877 Amp Speaker Playback Volume",
-			MAX9877_SPK_VOLUME, 0, 31, 0,
-			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
-	SOC_DOUBLE_R_EXT_TLV("MAX9877 Amp HP Playback Volume",
-			MAX9877_HPL_VOLUME, MAX9877_HPR_VOLUME, 0, 31, 0,
-			max9877_get_2reg, max9877_set_2reg, max9877_output_tlv),
-	SOC_SINGLE_EXT("MAX9877 INB Stereo Switch",
-			MAX9877_INPUT_MODE, 4, 1, 1,
-			max9877_get_reg, max9877_set_reg),
-	SOC_SINGLE_EXT("MAX9877 INA Stereo Switch",
-			MAX9877_INPUT_MODE, 5, 1, 1,
-			max9877_get_reg, max9877_set_reg),
-	SOC_SINGLE_EXT("MAX9877 Zero-crossing detection Switch",
-			MAX9877_INPUT_MODE, 6, 1, 0,
-			max9877_get_reg, max9877_set_reg),
-	SOC_SINGLE_EXT("MAX9877 Bypass Mode Switch",
-			MAX9877_OUTPUT_MODE, 6, 1, 0,
-			max9877_get_reg, max9877_set_reg),
-	SOC_SINGLE_EXT("MAX9877 Shutdown Mode Switch",
-			MAX9877_OUTPUT_MODE, 7, 1, 1,
-			max9877_get_reg, max9877_set_reg),
-	SOC_ENUM_EXT("MAX9877 Output Mode", max9877_enum[0],
-			max9877_get_out_mode, max9877_set_out_mode),
-	SOC_ENUM_EXT("MAX9877 Oscillator Mode", max9877_enum[1],
-			max9877_get_osc_mode, max9877_set_osc_mode),
+	SOC_SINGLE_TLV("MAX9877 PGAINA Playback Volume",
+		       MAX9877_INPUT_MODE, 0, 2, 0, max9877_pgain_tlv),
+	SOC_SINGLE_TLV("MAX9877 PGAINB Playback Volume",
+		       MAX9877_INPUT_MODE, 2, 2, 0, max9877_pgain_tlv),
+	SOC_SINGLE_TLV("MAX9877 Amp Speaker Playback Volume",
+		       MAX9877_SPK_VOLUME, 0, 31, 0, max9877_output_tlv),
+	SOC_DOUBLE_R_TLV("MAX9877 Amp HP Playback Volume",
+			 MAX9877_HPL_VOLUME, MAX9877_HPR_VOLUME, 0, 31, 0,
+			 max9877_output_tlv),
+	SOC_SINGLE("MAX9877 INB Stereo Switch",
+		   MAX9877_INPUT_MODE, 4, 1, 1),
+	SOC_SINGLE("MAX9877 INA Stereo Switch",
+		   MAX9877_INPUT_MODE, 5, 1, 1),
+	SOC_SINGLE("MAX9877 Zero-crossing detection Switch",
+		   MAX9877_INPUT_MODE, 6, 1, 0),
+	SOC_SINGLE("MAX9877 Bypass Mode Switch",
+		   MAX9877_OUTPUT_MODE, 6, 1, 0),
+	SOC_SINGLE("MAX9877 Shutdown Mode Switch",
+		   MAX9877_OUTPUT_MODE, 7, 1, 1),
+	SOC_ENUM("MAX9877 Output Mode", max9877_enum[0]),
+	SOC_ENUM("MAX9877 Oscillator Mode", max9877_enum[1]),
 };
 
-/* This function is called from ASoC machine driver */
-int max9877_add_controls(struct snd_soc_codec *codec)
-{
-	return snd_soc_add_codec_controls(codec, max9877_controls,
-			ARRAY_SIZE(max9877_controls));
-}
-EXPORT_SYMBOL_GPL(max9877_add_controls);
+static const struct snd_soc_codec_driver max9877_codec = {
+	.controls = max9877_controls,
+	.num_controls = ARRAY_SIZE(max9877_controls),
+};
 
 static const struct regmap_config max9877_regmap = {
 	.reg_bits = 8,
@@ -314,12 +120,12 @@ static int max9877_i2c_probe(struct i2c_client *client,
 	for (i = 0; i < ARRAY_SIZE(max9877_regs); i++)
 		regmap_write(regmap, max9877_regs[i].reg, max9877_regs[i].def);
 
-	return 0;
+	return snd_soc_register_codec(&client->dev, &max9877_codec, NULL, 0);
 }
 
 static int max9877_i2c_remove(struct i2c_client *client)
 {
-	regmap = NULL;
+	snd_soc_unregister_codec(&client->dev);
 
 	return 0;
 }
-- 
1.8.4.rc2
