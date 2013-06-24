From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 4/4] ASoC: codecs: adau1701: add support for
	pin muxing
Date: Mon, 24 Jun 2013 16:31:32 +0200
Message-ID: <1372084292-4859-5-git-send-email-zonque@gmail.com>
References: <1372084292-4859-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CE8E2650D3
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:31:08 +0200 (CEST)
In-Reply-To: <1372084292-4859-1-git-send-email-zonque@gmail.com>
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
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 .../devicetree/bindings/sound/adi,adau1701.txt     |  6 ++++
 sound/soc/codecs/adau1701.c                        | 32 ++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
index a9fbed1..547a49b 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
@@ -16,6 +16,10 @@ Optional properties:
 			The state of the pins are set according to the
 			configured clock divider on ASoC side before the
 			firmware is loaded.
+ - adi,pin-config:	An array of 12 numerical values selecting one of the
+			pin configurations as described in the datasheet,
+			table 53. Note that the value of this property has
+			to be prefixed with '/bits/ 8'.
 
 Examples:
 
@@ -25,5 +29,7 @@ Examples:
 			reg = <0x34>;
 			reset-gpio = <&gpio 23 0>;
 			adi,pll-mode-gpios = <&gpio 24 0 &gpio 25 0>;
+			adi,pin-config = /bits/ 8 <0x4 0x7 0x5 0x5 0x4 0x4
+                                                   0x4 0x4 0x4 0x4 0x4 0x4>;
 		};
 	};
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 881bab4..0e250f1 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -30,6 +30,9 @@
 #define ADAU1701_SERICTL	0x081f
 
 #define ADAU1701_AUXNPOW	0x0822
+#define ADAU1701_PINCONF_0	0x0820
+#define ADAU1701_PINCONF_1	0x0821
+#define ADAU1701_AUXNPOW	0x0822
 
 #define ADAU1701_OSCIPOW	0x0826
 #define ADAU1701_DACSET		0x0827
@@ -99,6 +102,7 @@ struct adau1701 {
 	unsigned int pll_clkdiv;
 	unsigned int sysclk;
 	struct regmap *regmap;
+	u8 pin_config[12];
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -134,6 +138,9 @@ static unsigned int adau1701_register_size(struct device *dev,
 		unsigned int reg)
 {
 	switch (reg) {
+	case ADAU1701_PINCONF_0:
+	case ADAU1701_PINCONF_1:
+		return 3;
 	case ADAU1701_DSPCTRL:
 	case ADAU1701_SEROCTL:
 	case ADAU1701_AUXNPOW:
@@ -164,7 +171,7 @@ static int adau1701_reg_write(void *context, unsigned int reg,
 	struct i2c_client *client = context;
 	unsigned int i;
 	unsigned int size;
-	uint8_t buf[4];
+	uint8_t buf[5];
 	int ret;
 
 	size = adau1701_register_size(&client->dev, reg);
@@ -584,7 +591,8 @@ MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
 
 static int adau1701_probe(struct snd_soc_codec *codec)
 {
-	int ret;
+	int i, ret;
+	unsigned int val;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 
 	codec->control_data = to_i2c_client(codec->dev);
@@ -602,6 +610,19 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
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
 
@@ -662,6 +683,13 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 						   "adi,pll-mode-gpios", 1);
 		if (gpio_pll_mode[1] < 0 && gpio_pll_mode[1] != -ENOENT)
 			return gpio_pll_mode[1];
+
+		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
+				     &adau1701->pll_clkdiv);
+
+		of_property_read_u8_array(dev->of_node, "adi,pin-config",
+					  adau1701->pin_config,
+					  ARRAY_SIZE(adau1701->pin_config));
 	}
 
 	if (gpio_is_valid(gpio_nreset)) {
-- 
1.8.1.4
