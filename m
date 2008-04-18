From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Fri, 18 Apr 2008 20:12:14 +0200
Message-ID: <20080418181214.GB26197@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BF4AB24BC4
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 20:12:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 2B54C7F4039
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 20:12:23 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rO+zFC0ubSh for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 20:12:15 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds support for AIC3x GPIO lines. They can be configured for
many possible functions as well as be driven manually. I also introduced
i2c read functionality since the GPIO state register has to be read from
hardware every time and can not be served from cache.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--LQksG6bCIzRHxTLp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-gpio.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index dd6d495..2c86283 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -138,6 +138,42 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
+/*
+ * read from the aic3x register space
+ */
+static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
+		      u8 *value)
+{
+	*value = reg & 0xff;
+	if (codec->hw_read(codec->control_data, value, 1) != 1)
+		return -EIO;
+
+	aic3x_write_reg_cache(codec, reg, *value);
+	return 0;
+}
+
+#define SOC_SINGLE_AIC3X_GPIO(xname, reg, shift, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_gpio_aic3x, .put = snd_soc_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
+
+static int snd_soc_get_gpio_aic3x(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	u8 val = 0;
+
+	aic3x_read(codec, reg, &val);
+	if (reg == AIC3X_GPIO1_REG)
+		ucontrol->value.integer.value[0] = (val >> 1) & 1;
+	else
+		ucontrol->value.integer.value[0] = (val >> 2) & 1;
+
+	return 0;
+}
+
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -210,6 +246,25 @@ static const char *aic3x_right_hpcom_mux[] =
       "differential of HPLCOM", "external feedback" };
 static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
 
+static const char *aic3x_gpio1_modes[] = {
+	"Disabled", "Audio word clock",	"Clock mux/1",	"Clock mux/2",
+	"Clock mux/4", "Clock mux/8", "Short circuit IRQ", "AGC noise IRQ",
+	"Input", "Output", "Digital microphone modulator clock",
+	"Audio word clock", "Button press IRQ", "Headset detect IRQ",
+	"Button press or headset detect IRQ", "All IRQ"
+};
+
+static const char *aic3x_gpio2_modes[] = {
+	"Disabled", "Invalid", "Headset detect IRQ", "Input",
+	"Output", "Digital microphone input", "Audio bitclock",
+	"Audio bitclock", "Audio bitclock",
+	"Button press or headset detect IRQ",
+	"All IRQ", "Short-circuit detect or AGC noise IRQ",
+	"Headset detect or button press or short-circuit IRQ",
+	"Short-circuit detect IRQ", "AGC noise detect IRQ",
+	"Button press IRQ"
+};
+
 #define LDAC_ENUM	0
 #define RDAC_ENUM	1
 #define LHPCOM_ENUM	2
@@ -218,6 +273,8 @@ static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
 #define LINE1R_ENUM	5
 #define LINE2L_ENUM	6
 #define LINE2R_ENUM	7
+#define GPIO1_ENUM	8
+#define GPIO2_ENUM	9
 
 static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
@@ -228,6 +285,8 @@ static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE(AIC3X_GPIO1_REG, 4, 16, aic3x_gpio1_modes),
+	SOC_ENUM_SINGLE(AIC3X_GPIO2_REG, 4, 16, aic3x_gpio2_modes),
 };
 
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
@@ -278,6 +337,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Input */
 	SOC_DOUBLE_R("PGA Capture Volume", LADC_VOL, RADC_VOL, 0, 0x7f, 0),
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
+
+	/* GPIOs */
+	SOC_SINGLE_AIC3X_GPIO("GPIO1 value", AIC3X_GPIO1_REG, 0, 0x01, 0),
+	SOC_SINGLE_AIC3X_GPIO("GPIO2 value", AIC3X_GPIO2_REG, 3, 0x01, 0),
 };
 
 /* add non dapm controls */
@@ -358,6 +421,14 @@ SOC_DAPM_ENUM("Route", aic3x_enum[LINE2L_ENUM]);
 static const struct snd_kcontrol_new aic3x_right_line2_mux_controls =
 SOC_DAPM_ENUM("Route", aic3x_enum[LINE2R_ENUM]);
 
+/* GPIO1 mode */
+static const struct snd_kcontrol_new aic3x_gpio1_controls =
+SOC_DAPM_ENUM("GPIO1", aic3x_enum[GPIO1_ENUM]);
+
+/* GPIO2 mode */
+static const struct snd_kcontrol_new aic3x_gpio2_controls =
+SOC_DAPM_ENUM("GPIO2", aic3x_enum[GPIO2_ENUM]);
+
 /* Left PGA Bypass Mixer */
 static const struct snd_kcontrol_new aic3x_left_pga_bp_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Line Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
@@ -481,6 +552,11 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINE1R"),
 	SND_SOC_DAPM_INPUT("LINE2L"),
 	SND_SOC_DAPM_INPUT("LINE2R"),
+
+	SND_SOC_DAPM_MUX("GPIO1 mode", SND_SOC_NOPM, 0, 0,
+			 &aic3x_gpio1_controls),
+	SND_SOC_DAPM_MUX("GPIO2 mode", SND_SOC_NOPM, 0, 0,
+			 &aic3x_gpio2_controls),
 };
 
 static const char *intercon[][3] = {
@@ -1235,6 +1311,12 @@ static struct i2c_client client_template = {
 	.name = "AIC3X",
 	.driver = &aic3x_i2c_driver,
 };
+
+static int aic3x_i2c_read(struct i2c_client *client, u8 *value, int len)
+{
+	value[0] = i2c_smbus_read_byte_data(client, value[0]);
+	return (len == 1);
+}
 #endif
 
 static int aic3x_probe(struct platform_device *pdev)
@@ -1269,6 +1351,7 @@ static int aic3x_probe(struct platform_device *pdev)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t) i2c_master_send;
+		codec->hw_read = (hw_read_t) aic3x_i2c_read;
 		ret = i2c_add_driver(&aic3x_i2c_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add i2c driver");
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index d49d001..dc05964 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -108,8 +108,14 @@
 #define DACR1_2_RLOPM_VOL		92
 #define LLOPM_CTRL			86
 #define RLOPM_CTRL			93
-/* Clock generation control register */
+/* GPIO/IRQ registers */
+#define AIC3X_STICKY_IRQ_FLAGS_REG	96
+#define AIC3X_REALTIME_IRQ_FLAGS_REG	97
+#define AIC3X_GPIO1_REG			98
+#define AIC3X_GPIO2_REG			99
+#define AIC3X_GPIOA_REG			100
 #define AIC3X_GPIOB_REG			101
+/* Clock generation control register */
 #define AIC3X_CLKGEN_CTRL_REG		102
 
 /* Page select register bits */

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--LQksG6bCIzRHxTLp--
