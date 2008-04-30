From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] soc - tlv320aic3x - add GPIO support
Date: Wed, 30 Apr 2008 10:10:19 +0100
Message-ID: <1209546619-14389-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209546619-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C29BD103875
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 11:10:21 +0200 (CEST)
In-Reply-To: <1209546619-14389-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

From: Daniel Mack <daniel@caiaq.org>

This patch adds support for AIC3x GPIO lines. They can be configured for
many possible functions as well as be driven manually. I also introduced
i2c read functionality since the GPIO state register has to be read from
hardware every time and can not be served from cache.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |   53 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.h |   49 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d76fa35..6e4bc69 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -138,6 +138,20 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
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
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -911,6 +925,33 @@ static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
 	return 0;
 }
 
+void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state)
+{
+	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
+	u8 bit = gpio ? 3: 0;
+	u8 val = aic3x_read_reg_cache(codec, reg) & ~(1 << bit);
+	aic3x_write(codec, reg, val | (!!state << bit));
+}
+EXPORT_SYMBOL_GPL(aic3x_set_gpio);
+
+int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
+{
+	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
+	u8 val, bit = gpio ? 2: 1;
+
+	aic3x_read(codec, reg, &val);
+	return (val >> bit) & 1;
+}
+EXPORT_SYMBOL_GPL(aic3x_get_gpio);
+
+int aic3x_headset_detected(struct snd_soc_codec *codec)
+{
+	u8 val;
+	aic3x_read(codec, AIC3X_RT_IRQ_FLAGS_REG, &val);
+	return (val >> 2) & 1;
+}
+EXPORT_SYMBOL_GPL(aic3x_headset_detected);
+
 #define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
@@ -977,6 +1018,7 @@ static int aic3x_resume(struct platform_device *pdev)
 static int aic3x_init(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
+	struct aic3x_setup_data *setup = socdev->codec_data;
 	int reg, ret = 0;
 
 	codec->name = "aic3x";
@@ -1067,6 +1109,10 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	/* off, with power on */
 	aic3x_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
 
+	/* setup GPIO functions */
+	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
+	aic3x_write(codec, AIC3X_GPIO2_REG, (setup->gpio_func[1] & 0xf) << 4);
+
 	aic3x_add_controls(codec);
 	aic3x_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
@@ -1174,6 +1220,12 @@ static struct i2c_client client_template = {
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
@@ -1208,6 +1260,7 @@ static int aic3x_probe(struct platform_device *pdev)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t) i2c_master_send;
+		codec->hw_read = (hw_read_t) aic3x_i2c_read;
 		ret = i2c_add_driver(&aic3x_i2c_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add i2c driver");
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index d49d001..c1dd1ac 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -108,8 +108,14 @@
 #define DACR1_2_RLOPM_VOL		92
 #define LLOPM_CTRL			86
 #define RLOPM_CTRL			93
-/* Clock generation control register */
+/* GPIO/IRQ registers */
+#define AIC3X_STICKY_IRQ_FLAGS_REG	96
+#define AIC3X_RT_IRQ_FLAGS_REG		97
+#define AIC3X_GPIO1_REG			98
+#define AIC3X_GPIO2_REG			99
+#define AIC3X_GPIOA_REG			100
 #define AIC3X_GPIOB_REG			101
+/* Clock generation control register */
 #define AIC3X_CLKGEN_CTRL_REG		102
 
 /* Page select register bits */
@@ -175,8 +181,49 @@
 /* Default input volume */
 #define DEFAULT_GAIN    0x20
 
+/* GPIO API */
+enum {
+	AIC3X_GPIO1_FUNC_DISABLED		= 0,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX		= 2,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
+	AIC3X_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
+	AIC3X_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
+	AIC3X_GPIO1_FUNC_INPUT			= 8,
+	AIC3X_GPIO1_FUNC_OUTPUT			= 9,
+	AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
+	AIC3X_GPIO1_FUNC_BUTTON_IRQ		= 12,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
+	AIC3X_GPIO1_FUNC_ALL_IRQ		= 16
+};
+
+enum {
+	AIC3X_GPIO2_FUNC_DISABLED		= 0,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
+	AIC3X_GPIO2_FUNC_INPUT			= 3,
+	AIC3X_GPIO2_FUNC_OUTPUT			= 4,
+	AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
+	AIC3X_GPIO2_FUNC_AUDIO_BITCLK		= 8,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
+	AIC3X_GPIO2_FUNC_ALL_IRQ		= 10,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
+	AIC3X_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
+	AIC3X_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
+	AIC3X_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
+};
+
+void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
+int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
+int aic3x_headset_detected(struct snd_soc_codec *codec);
+
 struct aic3x_setup_data {
 	unsigned short i2c_address;
+	unsigned int gpio_func[2];
 };
 
 extern struct snd_soc_codec_dai aic3x_dai;
-- 
1.5.5.1
