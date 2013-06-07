From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/4] ASoC: codecs: adau1701: allow
	configuration of PLL mode pins
Date: Fri,  7 Jun 2013 13:53:05 +0200
Message-ID: <1370605987-19290-3-git-send-email-zonque@gmail.com>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 314EC2656EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 13:52:50 +0200 (CEST)
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

The ADAU1701 has 2 hardware pins to configure the PLL mode in accordance
to the MCLK-to-LRCLK ratio. These pins have to be stable before the chip
is released from reset, and a full reset cycle, including a new firmware
download is needed whenever they change.

This patch adds GPIO properties to the DT bindings of the Codec, and
implements a callback for the set_clkdiv callback of the DAI.

To avoid excessive reset cycles and firmware downloads, the default
clock divider can be specified in DT as well.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/adi,adau1701.txt     | 13 ++++
 sound/soc/codecs/adau1701.c                        | 74 ++++++++++++++++++++++
 sound/soc/codecs/adau1701.h                        |  4 ++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
index 3afeda7..c9c6e98 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
@@ -11,6 +11,19 @@ Optional properties:
  - reset-gpio: 		A GPIO spec to define which pin is connected to the
 			chip's !RESET pin. If specified, the driver will
 			assert a hardware reset at probe time.
+ - adi,pll-clkdiv: 	The PLL clock divider, specifing the ratio between
+			MCLK and fsclk. The value is used to determine the
+			correct state of the two mode pins below.
+			Note that this value can be overridden at runtime
+			by passing the ADAU1701_CLKDIV_MCLK_LRCLK divider
+			with ASoC calls. However, the chips needs a full
+			reset cycle and a new firmware download each time
+			the configuration changes.
+ - adi,pll-mode0-gpio,
+   adi,pll-mode1-gpio:	GPIO specs to describe the GPIOs the ADAU's PLL config
+			pins are connected to. The state of the pins are set
+			according to the configured clock divider on ASoC side
+			before the firmware is loaded.
 
 Examples:
 
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index b6b1a77..4e1ec57 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -91,7 +91,10 @@
 
 struct adau1701 {
 	int gpio_nreset;
+	int gpio_pll_mode0;
+	int gpio_pll_mode1;
 	unsigned int dai_fmt;
+	unsigned int pll_clkdiv;
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -191,6 +194,29 @@ static void adau1701_reset(struct snd_soc_codec *codec)
 	if (!gpio_is_valid(adau1701->gpio_nreset))
 		return;
 
+	if (gpio_is_valid(adau1701->gpio_pll_mode0) &&
+	    gpio_is_valid(adau1701->gpio_pll_mode1)) {
+		switch (adau1701->pll_clkdiv) {
+		case 64:
+			gpio_set_value(adau1701->gpio_pll_mode0, 0);
+			gpio_set_value(adau1701->gpio_pll_mode1, 0);
+			break;
+		case 256:
+			gpio_set_value(adau1701->gpio_pll_mode0, 0);
+			gpio_set_value(adau1701->gpio_pll_mode1, 1);
+			break;
+		case 384:
+			gpio_set_value(adau1701->gpio_pll_mode0, 1);
+			gpio_set_value(adau1701->gpio_pll_mode1, 0);
+			break;
+		case 512:
+		default:
+			gpio_set_value(adau1701->gpio_pll_mode0, 1);
+			gpio_set_value(adau1701->gpio_pll_mode1, 1);
+			break;
+		}
+	}
+
 	gpio_set_value(adau1701->gpio_nreset, 0);
 	/* minimum reset time is 20ns */
 	udelay(1);
@@ -452,6 +478,21 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	return 0;
 }
 
+static int adau1701_set_clkdiv(struct snd_soc_dai *codec_dai,
+			       int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+
+	switch (div_id) {
+	case ADAU1701_CLKDIV_MCLK_LRCLK:
+		adau1701->pll_clkdiv = div;
+		return adau1701_init(codec);
+	default:
+		return -EINVAL;
+	}
+}
+
 #define ADAU1701_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
 	SNDRV_PCM_RATE_192000)
 
@@ -462,6 +503,7 @@ static const struct snd_soc_dai_ops adau1701_dai_ops = {
 	.set_fmt	= adau1701_set_dai_fmt,
 	.hw_params	= adau1701_hw_params,
 	.digital_mute	= adau1701_digital_mute,
+	.set_clkdiv	= adau1701_set_clkdiv,
 };
 
 static struct snd_soc_dai_driver adau1701_dai = {
@@ -534,6 +576,8 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	struct adau1701 *adau1701;
 	struct device *dev = &client->dev;
 	int gpio_nreset = -EINVAL;
+	int gpio_pll_mode0 = -EINVAL;
+	int gpio_pll_mode1 = -EINVAL;
 	int ret;
 
 	adau1701 = devm_kzalloc(dev, sizeof(*adau1701), GFP_KERNEL);
@@ -544,6 +588,19 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
 		if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
 			return gpio_nreset;
+
+		gpio_pll_mode0 = of_get_named_gpio(dev->of_node,
+						   "adi,pll-mode0-gpio", 0);
+		if (gpio_pll_mode0 < 0 && gpio_pll_mode0 != -ENOENT)
+			return gpio_pll_mode0;
+
+		gpio_pll_mode1 = of_get_named_gpio(dev->of_node,
+						   "adi,pll-mode1-gpio", 0);
+		if (gpio_pll_mode1 < 0 && gpio_pll_mode1 != -ENOENT)
+			return gpio_pll_mode1;
+
+		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
+				     &adau1701->pll_clkdiv);
 	}
 
 	if (gpio_is_valid(gpio_nreset)) {
@@ -553,7 +610,24 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	if (gpio_is_valid(gpio_pll_mode0) &&
+	    gpio_is_valid(gpio_pll_mode1)) {
+		ret = devm_gpio_request_one(dev, gpio_pll_mode0,
+					    GPIOF_OUT_INIT_LOW,
+					    "ADAU1701 PLL mode 0");
+		if (ret < 0)
+			return ret;
+
+		ret = devm_gpio_request_one(dev, gpio_pll_mode1,
+					    GPIOF_OUT_INIT_LOW,
+					    "ADAU1701 PLL mode 1");
+		if (ret < 0)
+			return ret;
+	}
+
 	adau1701->gpio_nreset = gpio_nreset;
+	adau1701->gpio_pll_mode0 = gpio_pll_mode0;
+	adau1701->gpio_pll_mode1 = gpio_pll_mode1;
 
 	i2c_set_clientdata(client, adau1701);
 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
diff --git a/sound/soc/codecs/adau1701.h b/sound/soc/codecs/adau1701.h
index 8d0949a..bdcdddc 100644
--- a/sound/soc/codecs/adau1701.h
+++ b/sound/soc/codecs/adau1701.h
@@ -14,4 +14,8 @@ enum adau1701_clk_src {
 	ADAU1701_CLK_SRC_MCLK,
 };
 
+enum adau1701_clkdiv {
+	ADAU1701_CLKDIV_MCLK_LRCLK,
+};
+
 #endif
-- 
1.8.1.4
