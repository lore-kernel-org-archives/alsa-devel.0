From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/4] ASoC: codecs: adau1701: add support for
	pin muxing
Date: Fri,  7 Jun 2013 13:53:07 +0200
Message-ID: <1370605987-19290-5-git-send-email-zonque@gmail.com>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E8ED62656EE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 13:52:52 +0200 (CEST)
In-Reply-To: <1370605987-19290-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The ADAU1701 has 12 pins that can be configured depending on the system
configuration. Allow settting the corresponding registers from DT.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/adi,adau1701.txt     |  4 +++
 sound/soc/codecs/adau1701.c                        | 34 ++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
index c9c6e98..e1b44a0 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
@@ -25,6 +25,10 @@ Optional properties:
 			according to the configured clock divider on ASoC side
 			before the firmware is loaded.
 
+ - adi,pin-config:	An array of 12 numerical values selecting one of the
+			pin configurations as described in the datasheet,
+			table 53.
+
 Examples:
 
 	i2c_bus {
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 8d2804c..fca9cac 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -29,6 +29,8 @@
 #define ADAU1701_SEROCTL	0x1e
 #define ADAU1701_SERICTL	0x1f
 
+#define ADAU1701_PINCONF_0	0x20
+#define ADAU1701_PINCONF_1	0x21
 #define ADAU1701_AUXNPOW	0x22
 
 #define ADAU1701_OSCIPOW	0x26
@@ -97,6 +99,7 @@ struct adau1701 {
 	unsigned int dai_fmt;
 	unsigned int pll_clkdiv;
 	struct regmap *regmap;
+	unsigned char pin_config[12];
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -132,6 +135,9 @@ static unsigned int adau1701_register_size(struct device *dev,
 		unsigned int reg)
 {
 	switch (reg) {
+	case ADAU1701_PINCONF_0:
+	case ADAU1701_PINCONF_1:
+		return 3;
 	case ADAU1701_DSPCTRL:
 	case ADAU1701_SEROCTL:
 	case ADAU1701_AUXNPOW:
@@ -162,7 +168,7 @@ static int adau1701_reg_write(void *context, unsigned int reg,
 	struct i2c_client *client = context;
 	unsigned int i;
 	unsigned int size;
-	uint8_t buf[4];
+	uint8_t buf[5];
 	int ret;
 
 	size = adau1701_register_size(&client->dev, reg);
@@ -580,7 +586,8 @@ MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
 
 static int adau1701_probe(struct snd_soc_codec *codec)
 {
-	int ret;
+	int ret, i;
+	unsigned int val;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 
 	ret = adau1701_init(codec);
@@ -589,6 +596,19 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 
 	regmap_write(adau1701->regmap, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
 
+	/* set up pin config */
+	val = 0;
+	for (i = 0; i < 6; i++)
+		val |= adau1701->pin_config[i] << (i * 4);
+
+	regmap_write(adau1701->regmap, ADAU1701_PINCONF_0, val);
+
+	val = 0;
+	for (i = 0; i < 6; i++)
+		val |= adau1701->pin_config[i + 6] << (i * 4);
+
+	regmap_write(adau1701->regmap, ADAU1701_PINCONF_1, val);
+
 	return 0;
 }
 
@@ -637,6 +657,9 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(adau1701->regmap);
 
 	if (dev->of_node) {
+		const u32 *pin_config32;
+		u32 size, i;
+
 		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
 		if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
 			return gpio_nreset;
@@ -653,6 +676,13 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 
 		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
 				     &adau1701->pll_clkdiv);
+		pin_config32 = of_get_property(dev->of_node,
+					       "adi,pin-config", &size);
+		size /= sizeof(u32);
+		size = min(ARRAY_SIZE(adau1701->pin_config), size);
+
+		for (i = 0; i < size; i++)
+			adau1701->pin_config[i] = be32_to_cpup(pin_config32 + i);
 	}
 
 	if (gpio_is_valid(gpio_nreset)) {
-- 
1.8.1.4
