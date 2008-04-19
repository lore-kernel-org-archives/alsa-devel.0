From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Sat, 19 Apr 2008 18:24:18 +0200
Message-ID: <20080419162418.GA3177@buzzloop.caiaq.de>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
	<20080419121838.GA1680@buzzloop.caiaq.de>
	<20080419145005.GA23492@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D29CA24378
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 18:24:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080419145005.GA23492@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 19, 2008 at 03:50:06PM +0100, Mark Brown wrote:
> > Ok, but why not let the codec driver expose all the functionality it can
> > offer for setting up a certain GPIO and use this alsa control either
> > from user space or from the asoc machine part? I think that's the most
> > flexible way at all, no?
> 
> The CODEC driver can't safely give user space control of multi-function
> pins in general, including GPIOs, since their usage depends very
> strongly on how they have been connected to the system.  At best much of
> the functionality won't be useful on a given board due to a lack of
> appropriate connections.  At worst the consequences of misusing them can
> include things like causing one or more chips in the system to fall
> over, perhaps even the entire system.  For example, if you've got two
> chips each trying to drive a signal to different voltages then it is
> possible that one or both of them will do something like attempt to
> consume too much power and cause supplies to collapse.

Ok, agreed to this point. I wanted to implement this feature as generic
as possbile, but you're right, that might cause some trouble.

> In the case of jack detect I'm actually currently working on a
> generalisation of that since it's such a common feature.  I hope to have
> something in the next week or two but it depends on my other work.

I attached a patch for a proprietary interface - is that what you were
talking about? Would that approach be mergeable with your generic jack
detect code?

Thanks and best regards,
Daniel



--r5Pyd7+fXNt84Ff3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-gpio.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index dd6d495..75ef421 100644
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
@@ -972,6 +986,26 @@ static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
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
+	u8 bit = gpio ? 2: 1;
+	u8 val = 0;
+
+	aic3x_read(codec, reg, &val);
+	return !!(val & (1 << bit));
+}
+EXPORT_SYMBOL_GPL(aic3x_get_gpio);
+
 #define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
@@ -1038,6 +1072,7 @@ static int aic3x_resume(struct platform_device *pdev)
 static int aic3x_init(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
+	struct aic3x_setup_data *setup = socdev->codec_data;
 	int reg, ret = 0;
 
 	codec->name = "aic3x";
@@ -1128,6 +1163,10 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	/* off, with power on */
 	aic3x_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
 
+	/* setup GPIO functions */
+	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
+	aic3x_write(codec, AIC3X_GPIO2_REG, (setup->gpio_func[1] & 0xf) << 4);
+
 	aic3x_add_controls(codec);
 	aic3x_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
@@ -1235,6 +1274,12 @@ static struct i2c_client client_template = {
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
@@ -1269,6 +1314,7 @@ static int aic3x_probe(struct platform_device *pdev)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t) i2c_master_send;
+		codec->hw_read = (hw_read_t) aic3x_i2c_read;
 		ret = i2c_add_driver(&aic3x_i2c_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add i2c driver");
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index d49d001..c72867b 100644
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
@@ -175,8 +181,48 @@
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
+
 struct aic3x_setup_data {
 	unsigned short i2c_address;
+	unsigned int gpio_func[2];
 };
 
 extern struct snd_soc_codec_dai aic3x_dai;

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--r5Pyd7+fXNt84Ff3--
