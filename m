From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: The DSP clock can be calibrated
	by the other clock source
Date: Tue, 7 Nov 2017 12:31:14 +0800
Message-ID: <1510029074-9126-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6398E266E15
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 05:31:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

Add the option for the DSP clock that can be calibrated by the other clock
source.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5514.h        |  2 +
 sound/soc/codecs/rt5514-spi.c |  1 +
 sound/soc/codecs/rt5514.c     | 85 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5514.h     |  5 ++-
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5514.h b/include/sound/rt5514.h
index ef18494..64d027d 100644
--- a/include/sound/rt5514.h
+++ b/include/sound/rt5514.h
@@ -14,6 +14,8 @@
 
 struct rt5514_platform_data {
 	unsigned int dmic_init_delay;
+	const char *dsp_calib_clk_name;
+	unsigned int dsp_calib_clk_rate;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 12f2ecf..b90d6d5 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -370,6 +370,7 @@ int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(rt5514_spi_burst_read);
 
 /**
  * rt5514_spi_burst_write - Write data to SPI by rt5514 address.
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 2a5b5d7..61ccbc6 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -295,6 +295,33 @@ static int rt5514_dsp_voice_wake_up_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt5514_calibration(struct rt5514_priv *rt5514, bool on)
+{
+	if (on) {
+		regmap_write(rt5514->regmap, RT5514_ANA_CTRL_PLL3, 0x0000000a);
+		regmap_update_bits(rt5514->regmap, RT5514_PLL_SOURCE_CTRL, 0xf,
+			0xa);
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA1, 0x301,
+			0x301);
+		regmap_write(rt5514->regmap, RT5514_PLL3_CALIB_CTRL4,
+			0x80000000 | rt5514->pll3_cal_value);
+		regmap_write(rt5514->regmap, RT5514_PLL3_CALIB_CTRL1,
+			0x8bb80800);
+		regmap_update_bits(rt5514->regmap, RT5514_PLL3_CALIB_CTRL5,
+			0xc0000000, 0x80000000);
+		regmap_update_bits(rt5514->regmap, RT5514_PLL3_CALIB_CTRL5,
+			0xc0000000, 0xc0000000);
+	} else {
+		regmap_update_bits(rt5514->regmap, RT5514_PLL3_CALIB_CTRL5,
+			0xc0000000, 0x40000000);
+		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA1, 0x301, 0);
+		regmap_update_bits(rt5514->regmap, RT5514_PLL_SOURCE_CTRL, 0xf,
+			0x4);
+	}
+
+	return 0;
+}
+
 static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
@@ -302,6 +329,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_codec *codec = rt5514->codec;
 	const struct firmware *fw = NULL;
+	u8 buf[8];
 
 	if (ucontrol->value.integer.value[0] == rt5514->dsp_enabled)
 		return 0;
@@ -310,6 +338,35 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 		rt5514->dsp_enabled = ucontrol->value.integer.value[0];
 
 		if (rt5514->dsp_enabled) {
+			if (rt5514->pdata.dsp_calib_clk_name &&
+				!IS_ERR(rt5514->dsp_calib_clk)) {
+				if (clk_set_rate(rt5514->dsp_calib_clk,
+					rt5514->pdata.dsp_calib_clk_rate))
+					dev_err(codec->dev,
+						"Can't set rate for mclk");
+
+				if (clk_prepare_enable(rt5514->dsp_calib_clk))
+					dev_err(codec->dev,
+						"Can't enable dsp_calib_clk");
+
+				rt5514_calibration(rt5514, true);
+
+				msleep(20);
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
+				rt5514_spi_burst_read(RT5514_PLL3_CALIB_CTRL6 |
+					RT5514_DSP_MAPPING,
+					(u8 *)&buf, sizeof(buf));
+#else
+				dev_err(codec->dev, "There is no SPI driver for"
+					" loading the firmware\n");
+#endif
+				rt5514->pll3_cal_value = buf[0] | buf[1] << 8 |
+					buf[2] << 16 | buf[3] << 24;
+
+				rt5514_calibration(rt5514, false);
+				clk_disable_unprepare(rt5514->dsp_calib_clk);
+			}
+
 			rt5514_enable_dsp_prepare(rt5514);
 
 			request_firmware(&fw, RT5514_FIRMWARE1, codec->dev);
@@ -341,6 +398,20 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 			/* DSP run */
 			regmap_write(rt5514->i2c_regmap, 0x18002f00,
 				0x00055148);
+
+			if (rt5514->pdata.dsp_calib_clk_name &&
+				!IS_ERR(rt5514->dsp_calib_clk)) {
+				msleep(20);
+
+				regmap_write(rt5514->i2c_regmap, 0x1800211c,
+					rt5514->pll3_cal_value);
+				regmap_write(rt5514->i2c_regmap, 0x18002124,
+					0x00220012);
+				regmap_write(rt5514->i2c_regmap, 0x18002124,
+					0x80220042);
+				regmap_write(rt5514->i2c_regmap, 0x18002124,
+					0xe0220042);
+			}
 		} else {
 			regmap_multi_reg_write(rt5514->i2c_regmap,
 				rt5514_i2c_patch, ARRAY_SIZE(rt5514_i2c_patch));
@@ -1024,12 +1095,22 @@ static int rt5514_set_bias_level(struct snd_soc_codec *codec,
 static int rt5514_probe(struct snd_soc_codec *codec)
 {
 	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+	struct platform_device *pdev = container_of(codec->dev,
+						   struct platform_device, dev);
 
 	rt5514->mclk = devm_clk_get(codec->dev, "mclk");
 	if (PTR_ERR(rt5514->mclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	if (rt5514->pdata.dsp_calib_clk_name) {
+		rt5514->dsp_calib_clk = devm_clk_get(&pdev->dev,
+				rt5514->pdata.dsp_calib_clk_name);
+		if (PTR_ERR(rt5514->dsp_calib_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	rt5514->codec = codec;
+	rt5514->pll3_cal_value = 0x0078b000;
 
 	return 0;
 }
@@ -1147,6 +1228,10 @@ static int rt5514_parse_dp(struct rt5514_priv *rt5514, struct device *dev)
 {
 	device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
 		&rt5514->pdata.dmic_init_delay);
+	device_property_read_string(dev, "realtek,dsp-calib-clk-name",
+		&rt5514->pdata.dsp_calib_clk_name);
+	device_property_read_u32(dev, "realtek,dsp-calib-clk-rate",
+		&rt5514->pdata.dsp_calib_clk_rate);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 2dc40e6..f0f3400 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -34,7 +34,9 @@
 #define RT5514_CLK_CTRL1			0x2104
 #define RT5514_CLK_CTRL2			0x2108
 #define RT5514_PLL3_CALIB_CTRL1			0x2110
+#define RT5514_PLL3_CALIB_CTRL4			0x2120
 #define RT5514_PLL3_CALIB_CTRL5			0x2124
+#define RT5514_PLL3_CALIB_CTRL6			0x2128
 #define RT5514_DELAY_BUF_CTRL1			0x2140
 #define RT5514_DELAY_BUF_CTRL3			0x2148
 #define RT5514_ASRC_IN_CTRL1			0x2180
@@ -272,7 +274,7 @@ struct rt5514_priv {
 	struct rt5514_platform_data pdata;
 	struct snd_soc_codec *codec;
 	struct regmap *i2c_regmap, *regmap;
-	struct clk *mclk;
+	struct clk *mclk, *dsp_calib_clk;
 	int sysclk;
 	int sysclk_src;
 	int lrck;
@@ -281,6 +283,7 @@ struct rt5514_priv {
 	int pll_in;
 	int pll_out;
 	int dsp_enabled;
+	unsigned int pll3_cal_value;
 };
 
 #endif /* __RT5514_H__ */
-- 
2.7.4
