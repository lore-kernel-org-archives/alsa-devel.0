From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320aic32x4: Add gpio
	configuration to the codec
Date: Wed, 12 Jul 2017 13:37:00 -0500
Message-ID: <20170712183700.15310-2-dmurphy@ti.com>
References: <20170712183700.15310-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E9526705E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 20:37:24 +0200 (CEST)
In-Reply-To: <20170712183700.15310-1-dmurphy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dan Murphy <dmurphy@ti.com>, broonie@kernel.org, linux-kernel@vger.kernel.org, javier.martin@vista-silicon.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add the ability to configure the MFP1->MFP5 registers
as GPIOs.  In addition adding ALSA controls to get and set
the GPIO state.

Per the data sheet each MFP can be configured as a GPIO
input only, output only or either an input or output.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |   9 +
 include/sound/tlv320aic32x4.h                      |  23 +++
 sound/soc/codecs/tlv320aic32x4.c                   | 206 +++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.h                   |   3 +
 4 files changed, 241 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 9651fc7503a4..ca75890f0d07 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -20,6 +20,8 @@ Optional properties:
  - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
  - clocks/clock-names: Clock named 'mclk' for the master clock of the codec.
    See clock/clock-bindings.txt for information about the detailed format.
+ - aic32x4-gpio-func - <array of 5 int>
+	- Types are defined in include/sound/tlv320aic32x4.h
 
 
 Example:
@@ -29,4 +31,11 @@ codec: tlv320aic32x4@18 {
 	reg = <0x18>;
 	clocks = <&clks 201>;
 	clock-names = "mclk";
+	aic32x4-gpio-func= <
+			0xff /* AIC32X4_MFPX_DEFAULT_VALUE */
+			0xff /* AIC32X4_MFPX_DEFAULT_VALUE */
+			0x04 /* MFP3 AIC32X4_MFP3_GPIO_ENABLED */
+			0xff /* AIC32X4_MFPX_DEFAULT_VALUE */
+			0x08 /* MFP5 AIC32X4_MFP5_GPIO_INPUT */
+		>;
 };
diff --git a/include/sound/tlv320aic32x4.h b/include/sound/tlv320aic32x4.h
index 24e5d991f148..22305c0ab31a 100644
--- a/include/sound/tlv320aic32x4.h
+++ b/include/sound/tlv320aic32x4.h
@@ -22,7 +22,30 @@
 #define AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K	0x00000001
 #define AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K	0x00000002
 
+/* GPIO API */
+#define AIC32X4_MFPX_DEFAULT_VALUE	0xff
+
+#define AIC32X4_MFP1_DIN_DISABLED	0
+#define AIC32X4_MFP1_DIN_ENABLED	0x2
+#define AIC32X4_MFP1_GPIO_IN		0x4
+
+#define AIC32X4_MFP2_GPIO_OUT_LOW	0x0
+#define AIC32X4_MFP2_GPIO_OUT_HIGH	0x1
+
+#define AIC32X4_MFP_GPIO_ENABLED	0x4
+
+#define AIC32X4_MFP5_GPIO_DISABLED	0x0
+#define AIC32X4_MFP5_GPIO_INPUT		0x8
+#define AIC32X4_MFP5_GPIO_OUTPUT	0xc
+#define AIC32X4_MFP5_GPIO_OUT_LOW	0x0
+#define AIC32X4_MFP5_GPIO_OUT_HIGH	0x1
+
+struct aic32x4_setup_data {
+	unsigned int gpio_func[5];
+};
+
 struct aic32x4_pdata {
+	struct aic32x4_setup_data *setup;
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 28fdfc5ec544..300ee2890df3 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -74,6 +74,152 @@ struct aic32x4_priv {
 	struct regulator *supply_iov;
 	struct regulator *supply_dv;
 	struct regulator *supply_av;
+
+	struct aic32x4_setup_data *setup;
+	struct device *dev;
+};
+
+static int aic32x4_get_mfp1_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+
+	val = snd_soc_read(codec, AIC32X4_DINCTL);
+
+	ucontrol->value.integer.value[0] = (val & 0x01);
+
+	return 0;
+};
+
+static int aic32x4_set_mfp2_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+	u8 gpio_check;
+
+	val = snd_soc_read(codec, AIC32X4_DOUTCTL);
+	gpio_check = (val & AIC32X4_MFP_GPIO_ENABLED);
+	if (gpio_check != AIC32X4_MFP_GPIO_ENABLED) {
+		printk(KERN_ERR "%s: MFP2 is not configure as a GPIO output\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (ucontrol->value.integer.value[0] == (val & AIC32X4_MFP2_GPIO_OUT_HIGH))
+		return 0;
+
+	if (ucontrol->value.integer.value[0])
+		val |= ucontrol->value.integer.value[0];
+	else
+		val &= ~AIC32X4_MFP2_GPIO_OUT_HIGH;
+
+	snd_soc_write(codec, AIC32X4_DOUTCTL, val);
+
+	return 0;
+};
+
+static int aic32x4_get_mfp3_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+
+	val = snd_soc_read(codec, AIC32X4_SCLKCTL);
+
+	ucontrol->value.integer.value[0] = (val & 0x01);
+
+	return 0;
+};
+
+static int aic32x4_set_mfp4_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+	u8 gpio_check;
+
+	val = snd_soc_read(codec, AIC32X4_MISOCTL);
+	gpio_check = (val & AIC32X4_MFP_GPIO_ENABLED);
+	if (gpio_check != AIC32X4_MFP_GPIO_ENABLED) {
+		printk(KERN_ERR "%s: MFP4 is not configure as a GPIO output\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (ucontrol->value.integer.value[0] == (val & AIC32X4_MFP5_GPIO_OUT_HIGH))
+		return 0;
+
+	if (ucontrol->value.integer.value[0])
+		val |= ucontrol->value.integer.value[0];
+	else
+		val &= ~AIC32X4_MFP5_GPIO_OUT_HIGH;
+
+	snd_soc_write(codec, AIC32X4_MISOCTL, val);
+
+	return 0;
+};
+
+static int aic32x4_get_mfp5_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+
+	val = snd_soc_read(codec, AIC32X4_GPIOCTL);
+	ucontrol->value.integer.value[0] = ((val & 0x2) >> 1);
+
+	return 0;
+};
+
+static int aic32x4_set_mfp5_gpio(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+	u8 gpio_check;
+
+	val = snd_soc_read(codec, AIC32X4_GPIOCTL);
+	gpio_check = (val & AIC32X4_MFP5_GPIO_OUTPUT);
+	if (gpio_check != AIC32X4_MFP5_GPIO_OUTPUT) {
+		printk(KERN_ERR "%s: MFP5 is not configure as a GPIO output\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (ucontrol->value.integer.value[0] == (val & 0x1))
+		return 0;
+
+	if (ucontrol->value.integer.value[0])
+		val |= ucontrol->value.integer.value[0];
+	else
+		val &= 0xfe;
+
+	snd_soc_write(codec, AIC32X4_GPIOCTL, val);
+
+	return 0;
+};
+
+static const struct snd_kcontrol_new aic32x4_mfp1[] = {
+	SOC_SINGLE_BOOL_EXT("MFP1 GPIO", 0, aic32x4_get_mfp1_gpio, NULL),
+};
+
+static const struct snd_kcontrol_new aic32x4_mfp2[] = {
+	SOC_SINGLE_BOOL_EXT("MFP2 GPIO", 0, NULL, aic32x4_set_mfp2_gpio),
+};
+
+static const struct snd_kcontrol_new aic32x4_mfp3[] = {
+	SOC_SINGLE_BOOL_EXT("MFP3 GPIO", 0, aic32x4_get_mfp3_gpio, NULL),
+};
+
+static const struct snd_kcontrol_new aic32x4_mfp4[] = {
+	SOC_SINGLE_BOOL_EXT("MFP4 GPIO", 0, NULL, aic32x4_set_mfp4_gpio),
+};
+
+static const struct snd_kcontrol_new aic32x4_mfp5[] = {
+	SOC_SINGLE_BOOL_EXT("MFP5 GPIO", 0, aic32x4_get_mfp5_gpio,
+		aic32x4_set_mfp5_gpio),
 };
 
 /* 0dB min, 0.5dB steps */
@@ -734,6 +880,52 @@ static struct snd_soc_dai_driver aic32x4_dai = {
 	.symmetric_rates = 1,
 };
 
+static void aic32x4_setup_gpios(struct snd_soc_codec *codec)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+
+	/* setup GPIO functions */
+	/* MFP1 */
+	if (aic32x4->setup->gpio_func[0] != AIC32X4_MFPX_DEFAULT_VALUE) {
+		snd_soc_write(codec, AIC32X4_DINCTL,
+		      aic32x4->setup->gpio_func[0]);
+		snd_soc_add_codec_controls(codec, aic32x4_mfp1,
+			ARRAY_SIZE(aic32x4_mfp1));
+	}
+
+	/* MFP2 */
+	if (aic32x4->setup->gpio_func[1] != AIC32X4_MFPX_DEFAULT_VALUE) {
+		snd_soc_write(codec, AIC32X4_DOUTCTL,
+		      aic32x4->setup->gpio_func[1]);
+		snd_soc_add_codec_controls(codec, aic32x4_mfp2,
+			ARRAY_SIZE(aic32x4_mfp2));
+	}
+
+	/* MFP3 */
+	if (aic32x4->setup->gpio_func[2] != AIC32X4_MFPX_DEFAULT_VALUE) {
+		snd_soc_write(codec, AIC32X4_SCLKCTL,
+		      aic32x4->setup->gpio_func[2]);
+		snd_soc_add_codec_controls(codec, aic32x4_mfp3,
+			ARRAY_SIZE(aic32x4_mfp3));
+	}
+
+	/* MFP4 */
+	if (aic32x4->setup->gpio_func[3] != AIC32X4_MFPX_DEFAULT_VALUE) {
+		snd_soc_write(codec, AIC32X4_MISOCTL,
+		      aic32x4->setup->gpio_func[3]);
+		snd_soc_add_codec_controls(codec, aic32x4_mfp4,
+			ARRAY_SIZE(aic32x4_mfp4));
+	}
+
+	/* MFP5 */
+	if (aic32x4->setup->gpio_func[4] != AIC32X4_MFPX_DEFAULT_VALUE) {
+		snd_soc_write(codec, AIC32X4_GPIOCTL,
+		      aic32x4->setup->gpio_func[4]);
+		snd_soc_add_codec_controls(codec, aic32x4_mfp5,
+			ARRAY_SIZE(aic32x4_mfp5));
+	}
+}
+
 static int aic32x4_codec_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
@@ -746,6 +938,9 @@ static int aic32x4_codec_probe(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, AIC32X4_RESET, 0x01);
 
+	if (aic32x4->setup)
+		aic32x4_setup_gpios(codec);
+
 	/* Power platform configuration */
 	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
 		snd_soc_write(codec, AIC32X4_MICBIAS, AIC32X4_MICBIAS_LDOIN |
@@ -810,10 +1005,20 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
 		struct device_node *np)
 {
+	struct aic32x4_setup_data *aic32x4_setup;
+
+	aic32x4_setup = devm_kzalloc(aic32x4->dev, sizeof(*aic32x4_setup),
+							GFP_KERNEL);
+	if (!aic32x4_setup)
+		return -ENOMEM;
+
 	aic32x4->swapdacs = false;
 	aic32x4->micpga_routing = 0;
 	aic32x4->rstn_gpio = of_get_named_gpio(np, "reset-gpios", 0);
 
+	if (of_property_read_u32_array(np, "aic32x4-gpio-func",
+				aic32x4_setup->gpio_func, 5) >= 0)
+		aic32x4->setup = aic32x4_setup;
 	return 0;
 }
 
@@ -932,6 +1137,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 	if (aic32x4 == NULL)
 		return -ENOMEM;
 
+	aic32x4->dev = dev;
 	dev_set_drvdata(dev, aic32x4);
 
 	if (pdata) {
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index a197dd51addc..da7cec482bcb 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -44,8 +44,11 @@ int aic32x4_remove(struct device *dev);
 #define AIC32X4_IFACE4		31
 #define AIC32X4_IFACE5		32
 #define AIC32X4_IFACE6		33
+#define AIC32X4_GPIOCTL		52
 #define AIC32X4_DOUTCTL		53
 #define AIC32X4_DINCTL		54
+#define AIC32X4_MISOCTL		55
+#define AIC32X4_SCLKCTL		56
 #define AIC32X4_DACSPB		60
 #define AIC32X4_ADCSPB		61
 #define AIC32X4_DACSETUP	63
-- 
2.13.2.516.ge629a7d28
