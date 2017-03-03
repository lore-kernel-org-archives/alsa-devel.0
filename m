From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 03/10] Removed the secondary device
	initialization from the primary device initialization.
	Removed manual register configuration from devicetree
Date: Fri, 3 Mar 2017 23:52:41 +0900
Message-ID: <1488552768-14901-4-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0117.outbound.protection.outlook.com [104.47.34.117])
 by alsa0.perex.cz (Postfix) with ESMTP id ACBC9266B6F
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:53:58 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Keeping seperate regmaps for each instance of the amplifier was not good idea. So this part has been removed.
Manual register configuration from devicetree was also removed.

 sound/soc/codecs/max98927.c | 223 +++++++-------------------------------------
 sound/soc/codecs/max98927.h |  14 +--
 2 files changed, 33 insertions(+), 204 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index ae082ec..5627279c 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -140,24 +140,6 @@ static struct reg_default max98927_reg[] = {
 	{MAX98927_R01FF_REV_ID,  0x40},
 };
 
-void max98927_wrapper_write(struct max98927_priv *max98927,
-	unsigned int reg, unsigned int val)
-{
-	if (max98927->regmap)
-		regmap_write(max98927->regmap, reg, val);
-	if (max98927->sub_regmap)
-		regmap_write(max98927->sub_regmap, reg, val);
-}
-
-void max98927_wrap_update_bits(struct max98927_priv *max98927,
-	unsigned int reg, unsigned int mask, unsigned int val)
-{
-	if (max98927->regmap)
-		regmap_update_bits(max98927->regmap, reg, mask, val);
-	if (max98927->sub_regmap)
-		regmap_update_bits(max98927->sub_regmap, reg, mask, val);
-}
-
 static int max98927_reg_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
 		unsigned int mask, unsigned int shift)
@@ -180,7 +162,7 @@ static int max98927_reg_put(struct snd_kcontrol *kcontrol,
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
-	max98927_wrap_update_bits(max98927, reg, mask, sel << shift);
+	regmap_update_bits(max98927->regmap, reg, mask, sel << shift);
 	dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
 				__func__, reg, sel);
 	return 0;
@@ -196,20 +178,20 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0021_PCM_MASTER_MODE,
 			MAX98927_PCM_MASTER_MODE_MASK,
 			MAX98927_PCM_MASTER_MODE_SLAVE);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		max98927->master = true;
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0021_PCM_MASTER_MODE,
 			MAX98927_PCM_MASTER_MODE_MASK,
 			MAX98927_PCM_MASTER_MODE_MASTER);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0021_PCM_MASTER_MODE,
 			MAX98927_PCM_MASTER_MODE_MASK,
 			MAX98927_PCM_MASTER_MODE_HYBRID);
@@ -233,13 +215,13 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		max98927->iface |= SND_SOC_DAIFMT_I2S;
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			max98927->iface, max98927->iface);
 	break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			max98927->iface, max98927->iface);
 	break;
@@ -249,16 +231,16 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
 
 	/* pcm channel configuration */
 	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
-		max98927_wrapper_write(max98927,
+		regmap_write(max98927->regmap,
 			MAX98927_R0018_PCM_RX_EN_A,
 			MAX98927_PCM_RX_CH0_EN|
 			MAX98927_PCM_RX_CH1_EN);
-		max98927_wrapper_write(max98927,
+		regmap_write(max98927->regmap,
 			MAX98927_R0021_PCM_MASTER_MODE,
 			MAX98927_PCM_TX_CH0_EN|
 			MAX98927_PCM_TX_CH1_EN);
 	}
-	max98927_wrap_update_bits(max98927, MAX98927_R0020_PCM_MODE_CFG,
+	regmap_update_bits(max98927->regmap, MAX98927_R0020_PCM_MODE_CFG,
 		MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE, invert);
 	return 0;
 }
@@ -291,7 +273,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 				__func__);
 			return -EINVAL;
 		}
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0021_PCM_MASTER_MODE,
 			MAX98927_PCM_MASTER_MODE_MCLK_MASK,
 			i << MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT);
@@ -310,7 +292,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 	default:
 		return -EINVAL;
 	}
-	max98927_wrap_update_bits(max98927,
+	regmap_update_bits(max98927->regmap,
 		reg, mask, value);
 	return 0;
 }
@@ -326,21 +308,21 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 	/* pcm mode configuration */
 	switch (snd_pcm_format_width(params_format(params))) {
 	case 16:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			MAX98927_PCM_MODE_CFG_CHANSZ_16,
 			MAX98927_PCM_MODE_CFG_CHANSZ_16);
 		max98927->ch_size = 16;
 		break;
 	case 24:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			MAX98927_PCM_MODE_CFG_CHANSZ_24,
 			MAX98927_PCM_MODE_CFG_CHANSZ_24);
 		max98927->ch_size = 24;
 		break;
 	case 32:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			MAX98927_PCM_MODE_CFG_CHANSZ_32,
 			MAX98927_PCM_MODE_CFG_CHANSZ_32);
@@ -389,11 +371,11 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		goto err;
 	}
 	/* set DAI_SR to correct LRCLK frequency */
-	max98927_wrap_update_bits(max98927, MAX98927_R0023_PCM_SR_SETUP1,
+	regmap_update_bits(max98927->regmap, MAX98927_R0023_PCM_SR_SETUP1,
 		MAX98927_PCM_SR_SET1_SR_MASK, sampling_rate);
-	max98927_wrap_update_bits(max98927, MAX98927_R0024_PCM_SR_SETUP2,
+	regmap_update_bits(max98927->regmap, MAX98927_R0024_PCM_SR_SETUP2,
 		MAX98927_PCM_SR_SET2_SR_MASK, sampling_rate<<4);
-	max98927_wrap_update_bits(max98927, MAX98927_R0024_PCM_SR_SETUP2,
+	regmap_update_bits(max98927->regmap, MAX98927_R0024_PCM_SR_SETUP2,
 		MAX98927_PCM_SR_SET2_IVADC_SR_MASK, sampling_rate);
 	return max98927_set_clock(max98927, params);
 err:
@@ -421,42 +403,6 @@ static const struct snd_soc_dai_ops max98927_dai_ops = {
 	.hw_params = max98927_dai_hw_params,
 };
 
-static void max98927_handle_pdata(struct snd_soc_codec *codec)
-{
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	struct max98927_reg_default *regInfo;
-	int cfg_size = 0;
-	int x;
-
-	if (max98927->regcfg != NULL)
-		cfg_size = max98927->regcfg_sz / sizeof(uint32_t);
-
-	if (cfg_size <= 0) {
-		dev_dbg(codec->dev,
-			"Register configuration is not required.\n");
-		return;
-	}
-
-	/* direct configuration from device tree */
-	for (x = 0; x < cfg_size; x += 3) {
-		regInfo = (struct max98927_reg_default *)&max98927->regcfg[x];
-		dev_info(codec->dev, "CH:%d, reg:0x%02x, value:0x%02x\n",
-			be32_to_cpu(regInfo->ch),
-			be32_to_cpu(regInfo->reg),
-			be32_to_cpu(regInfo->def));
-		if (be32_to_cpu(regInfo->ch) == 0 /* Primary amp */
-			&& max98927->regmap)
-			regmap_write(max98927->regmap,
-				be32_to_cpu(regInfo->reg),
-				be32_to_cpu(regInfo->def));
-		else if (be32_to_cpu(regInfo->ch) == 1 /* Secondary amp */
-			&& max98927->sub_regmap)
-			regmap_write(max98927->sub_regmap,
-				be32_to_cpu(regInfo->reg),
-				be32_to_cpu(regInfo->def));
-	}
-}
-
 static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -465,31 +411,31 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN, 1, 1);
 		/* enable the v and i for vi feedback */
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
 			MAX98927_MEAS_V_EN,
 			MAX98927_MEAS_V_EN);
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
 			MAX98927_MEAS_I_EN,
 			MAX98927_MEAS_I_EN);
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_GLOBAL_EN_MASK, 1, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R00FF_GLOBAL_SHDN, 1, 0);
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN, 1, 0);
 		/* disable the v and i for vi feedback */
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
 			MAX98927_MEAS_V_EN,
 			0);
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
 			MAX98927_MEAS_I_EN,
 			0);
@@ -531,7 +477,7 @@ static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
 	unsigned int sel = ucontrol->value.integer.value[0];
 
 	if (sel < ((1 << MAX98927_Speaker_Gain_Width) - 1)) {
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R003C_SPK_GAIN,
 			MAX98927_SPK_PCM_GAIN_MASK, sel);
 		max98927->spk_gain = sel;
@@ -559,7 +505,7 @@ static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
 	unsigned int sel = ucontrol->value.integer.value[0];
 
 	if (sel < ((1 << MAX98927_AMP_VOL_WIDTH) - 1)) {
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R0036_AMP_VOL_CTRL,
 			MAX98927_AMP_VOL_MASK, sel);
 		max98927->digital_gain = sel;
@@ -792,17 +738,17 @@ static struct snd_soc_dai_driver max98927_dai[] = {
 static int max98927_probe(struct snd_soc_codec *codec)
 {
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0, reg = 0, i;
+	int ret = 0, reg = 0;
 
 	max98927->codec = codec;
 	codec->control_data = max98927->regmap;
 	codec->cache_bypass = 1;
 
 	/* Software Reset */
-	max98927_wrapper_write(max98927,
+	regmap_write(max98927->regmap,
 		MAX98927_R0100_SOFT_RESET, MAX98927_SOFT_RESET);
 
-	/* Check Revision ID for the primary MAX98927*/
+	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
 		MAX98927_R01FF_REV_ID, &reg);
 	if (ret < 0)
@@ -812,25 +758,6 @@ static int max98927_probe(struct snd_soc_codec *codec)
 		dev_info(codec->dev,
 			"MAX98927 revisionID: 0x%02X\n", reg);
 
-	/* Check Revision ID for the secondary MAX98927*/
-	if (max98927->sub_regmap) {
-		ret = regmap_read(max98927->sub_regmap,
-			MAX98927_R01FF_REV_ID, &reg);
-		if (ret < 0)
-			dev_err(codec->dev,
-				"Failed to read: 0x%02X from secodnary device\n"
-				, MAX98927_R01FF_REV_ID);
-		else
-			dev_info(codec->dev,
-				"Secondary device revisionID: 0x%02X\n", reg);
-	}
-
-	/* Register initialization */
-	for (i = 0; i < sizeof(max98927_reg)/
-			sizeof(max98927_reg[0]); i++)
-		max98927_wrapper_write(max98927,
-			max98927_reg[i].reg,
-			max98927_reg[i].def);
 
 	if (max98927->regmap)
 		regmap_write(max98927->regmap,
@@ -838,22 +765,13 @@ static int max98927_probe(struct snd_soc_codec *codec)
 			(max98927->i_l_slot
 				<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
 				max98927->v_l_slot)&0xFF);
-	if (max98927->sub_regmap)
-		regmap_write(max98927->sub_regmap,
-			MAX98927_R001E_PCM_TX_CH_SRC_A,
-			(max98927->i_r_slot
-				<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
-				max98927->v_r_slot)&0xFF);
 
 	/* Set interleave mode */
 	if (max98927->interleave_mode)
-		max98927_wrap_update_bits(max98927,
+		regmap_update_bits(max98927->regmap,
 			MAX98927_R001F_PCM_TX_CH_SRC_B,
 			MAX98927_PCM_TX_CH_INTERLEAVE_MASK,
 			MAX98927_PCM_TX_CH_INTERLEAVE_MASK);
-
-	max98927_handle_pdata(codec);
-
 	return ret;
 }
 
@@ -879,36 +797,6 @@ static const struct regmap_config max98927_regmap = {
 	.cache_type       = REGCACHE_RBTREE,
 };
 
-static struct i2c_board_info max98927_i2c_sub_board[] = {
-	{
-		I2C_BOARD_INFO("max98927_sub", 0x39),
-	}
-};
-
-static struct i2c_driver max98927_i2c_sub_driver = {
-	.driver = {
-		.name = "max98927_sub",
-		.owner = THIS_MODULE,
-	},
-};
-
-struct i2c_client *max98927_add_sub_device(int bus_id, int slave_addr)
-{
-	struct i2c_client *i2c = NULL;
-	struct i2c_adapter *adapter;
-
-	max98927_i2c_sub_board[0].addr = slave_addr;
-
-	adapter = i2c_get_adapter(bus_id);
-	if (adapter) {
-		i2c = i2c_new_device(adapter, max98927_i2c_sub_board);
-		if (i2c)
-			i2c->dev.driver = &max98927_i2c_sub_driver.driver;
-	}
-
-	return i2c;
-}
-
 int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
 {
 	int ret = 0, value;
@@ -921,14 +809,6 @@ int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
-	if (!of_property_read_u32(i2c->dev.of_node, "vmon-r-slot", &value))
-		max98927->v_r_slot = value & 0xF;
-	else
-		max98927->v_r_slot = 2;
-	if (!of_property_read_u32(i2c->dev.of_node, "imon-r-slot", &value))
-		max98927->i_r_slot = value & 0xF;
-	else
-		max98927->i_r_slot = 3;
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
 		max98927_dai, ARRAY_SIZE(max98927_dai));
@@ -964,25 +844,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	} else
 		max98927->interleave_mode = 0;
 
-	/* update direct configuration info */
-	max98927->regcfg = of_get_property(i2c->dev.of_node,
-			"maxim,regcfg", &max98927->regcfg_sz);
-
-	/* check for secondary MAX98927 */
-	ret = of_property_read_u32(i2c->dev.of_node,
-			"maxim,sub_reg", &max98927->sub_reg);
-	if (ret) {
-		dev_err(&i2c->dev, "Sub-device slave address was not found.\n");
-		max98927->sub_reg = -1;
-	}
-	ret = of_property_read_u32(i2c->dev.of_node,
-			"maxim,sub_bus", &max98927->sub_bus);
-	if (ret) {
-		dev_err(&i2c->dev, "Sub-device bus information was not found.\n");
-		max98927->sub_bus = i2c->adapter->nr;
-	}
-
-	/* regmap initialization for primary device */
+	/* regmap initialization */
 	max98927->regmap
 		= devm_regmap_init_i2c(i2c, &max98927_regmap);
 	if (IS_ERR(max98927->regmap)) {
@@ -992,27 +854,6 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		goto err;
 	}
 
-	/* regmap initialization for secondary device */
-	if (max98927->sub_reg > 0)	{
-		max98927->sub_i2c = max98927_add_sub_device(max98927->sub_bus,
-			max98927->sub_reg);
-		if (IS_ERR(max98927->sub_i2c)) {
-			dev_err(&max98927->sub_i2c->dev,
-					"Second MAX98927 was not found\n");
-			ret = PTR_ERR(max98927->regmap);
-			goto err;
-		} else {
-			max98927->sub_regmap = regmap_init_i2c(
-					max98927->sub_i2c, &max98927_regmap);
-			if (IS_ERR(max98927->sub_regmap)) {
-				ret = PTR_ERR(max98927->sub_regmap);
-				dev_err(&max98927->sub_i2c->dev,
-					"Failed to allocate sub_regmap: %d\n",
-					ret);
-				goto err;
-			}
-		}
-	}
 
 	/* codec registeration */
 	ret = probe_common(i2c, max98927);
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 0d8daa5..2de8504 100755
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -249,33 +249,21 @@
 /* MAX98927_R00FF_GLOBAL_SHDN */
 #define MAX98927_GLOBAL_EN_MASK (0x1 << 0)
 
-struct max98927_reg_default {
-	unsigned int ch;
-	unsigned int reg;
-	unsigned int def;
-};
 struct max98927_priv {
 	struct regmap *regmap;
-	struct regmap *sub_regmap;
 	struct snd_soc_codec *codec;
 	struct max98927_pdata *pdata;
-	const uint32_t *regcfg;
-	uint32_t regcfg_sz;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
 	unsigned int i_l_slot;
-	unsigned int v_r_slot;
-	unsigned int i_r_slot;
 	bool interleave_mode;
 	unsigned int ch_size;
 	unsigned int rate;
 	unsigned int iface;
 	unsigned int master;
 	unsigned int digital_gain;
-	struct i2c_client *sub_i2c;
-	int sub_reg;
-	int sub_bus;
 };
 #define MAX98927_Speaker_Gain_Width 3
+#define MAX98927_AMP_VOL_LOCATION_SHIFT 7
 #endif
-- 
2.7.4
