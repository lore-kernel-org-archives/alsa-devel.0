From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 2/2] ASoC: imx-wm8958: add headphone detected
	gpio support
Date: Tue, 8 Dec 2015 17:40:14 +0800
Message-ID: <f803a02b2e80bc750f67e4eced99093ab9f66100.1449567072.git.zidan.wang@freescale.com>
References: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A77265E38
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 10:38:32 +0100 (CET)
In-Reply-To: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

Add headphone detected gpio support for sound card.
When plug in headphone Jack, it will enable headphone audio route and
disable speaker audio route.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 .../devicetree/bindings/sound/imx-audio-wm8958.txt |   5 +
 sound/soc/fsl/imx-wm8958.c                         | 121 ++++++++++++++++++++-
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
index 81775e4..7164ec8 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
@@ -42,6 +42,10 @@ Required properties:
 			     (disabled) when the dai is not sending or
 			     receiving PCM data in a frame.
 
+Optional properties:
+
+- hp-det-gpios		   : set headphone detected gpio for sound card.
+
 Example:
 
 sound {
@@ -50,6 +54,7 @@ sound {
 		model = "wm8960-audio";
 		cpu-dai = <&sai1>;
 		audio-codec = <&codec>;
+		hp-det-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		audio-routing =
 			"Headphone Jack", "HPOUT1L",
 			"Headphone Jack", "HPOUT1R",
diff --git a/sound/soc/fsl/imx-wm8958.c b/sound/soc/fsl/imx-wm8958.c
index 920bc9e..c3c8677 100644
--- a/sound/soc/fsl/imx-wm8958.c
+++ b/sound/soc/fsl/imx-wm8958.c
@@ -21,8 +21,11 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-dapm.h>
 #include <linux/mfd/wm8994/registers.h>
+#include <linux/gpio/machine.h>
+#include <linux/bitops.h>
 #include "../fsl/fsl_sai.h"
 #include "../codecs/wm8994.h"
+#include "../../../drivers/gpio/gpiolib.h"
 
 #define DAI_NAME_SIZE	32
 
@@ -51,6 +54,99 @@ static const struct snd_soc_dapm_widget imx_wm8958_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
+struct gpio_data {
+	int gpio;
+	unsigned long flags;
+};
+
+struct imx_priv {
+	struct gpio_data hp_gpio;
+};
+
+static struct imx_priv card_priv;
+
+static struct snd_soc_jack imx_hp_jack;
+static struct snd_soc_jack_pin imx_hp_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+static struct snd_soc_jack_gpio imx_hp_jack_gpio = {
+	.name = "headphone detect",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 250,
+	.invert = 0,
+};
+
+static int hpjack_status_check(void *data)
+{
+	struct snd_soc_jack *jack = &imx_hp_jack;
+	int enable, ret;
+
+	enable = gpiod_get_value_cansleep(imx_hp_jack_gpio.desc);
+
+	if (enable) {
+		snd_soc_dapm_disable_pin(&jack->card->dapm, "Ext Spk");
+		ret = imx_hp_jack_gpio.report;
+	} else {
+		snd_soc_dapm_enable_pin(&jack->card->dapm, "Ext Spk");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int imx_wm8958_gpio_init(struct snd_soc_card *card)
+{
+	struct imx_priv *priv = &card_priv;
+	int ret;
+
+	imx_hp_jack_gpio.gpio = priv->hp_gpio.gpio;
+	imx_hp_jack_gpio.jack_status_check = hpjack_status_check;
+
+	ret = snd_soc_card_jack_new(card, "Headphone Jack",
+			SND_JACK_HEADPHONE, &imx_hp_jack,
+			imx_hp_jack_pins, ARRAY_SIZE(imx_hp_jack_pins));
+	if (ret) {
+		dev_err(card->dev,
+			"failed to create Headphone Jack (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_jack_add_gpios(&imx_hp_jack, 1, &imx_hp_jack_gpio);
+	if (ret) {
+		dev_err(card->dev,
+			"failed to add Headphone Jack gpio (%d)\n", ret);
+		return ret;
+	}
+
+	if (priv->hp_gpio.flags & GPIO_ACTIVE_LOW)
+		set_bit(FLAG_ACTIVE_LOW, &imx_hp_jack_gpio.desc->flags);
+	else
+		clear_bit(FLAG_ACTIVE_LOW, &imx_hp_jack_gpio.desc->flags);
+
+	return 0;
+}
+
+static ssize_t show_headphone(struct device_driver *driver, char *buf)
+{
+	struct imx_priv *priv = &card_priv;
+	int enable;
+
+	/* Check if headphone is plugged in */
+	enable = gpiod_get_value_cansleep(gpio_to_desc(priv->hp_gpio.gpio));
+
+	if (enable)
+		strcpy(buf, "headphone\n");
+	else
+		strcpy(buf, "speaker\n");
+
+	return strlen(buf);
+}
+
+static DRIVER_ATTR(headphone, S_IRUGO | S_IWUSR, show_headphone, NULL);
+
 static int imx_wm8958_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
@@ -87,7 +183,6 @@ static int imx_wm8958_hw_params(struct snd_pcm_substream *substream,
 			hifi_dai_sysclk_dir = SND_SOC_CLOCK_IN;
 
 		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, 0, !hifi_dai_sysclk_dir);
-
 		if (ret) {
 			dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
 			return ret;
@@ -282,6 +377,7 @@ static int imx_wm8958_probe(struct platform_device *pdev)
 	struct platform_device *cpu_pdev;
 	struct i2c_client *codec_dev;
 	struct imx_wm8958_data *data;
+	struct imx_priv *priv = &card_priv;
 	char tmp[8];
 	u32 dai_fmt;
 	int ret, i;
@@ -389,6 +485,21 @@ static int imx_wm8958_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	priv->hp_gpio.gpio = of_get_named_gpio_flags(np, "hp-det-gpios", 0,
+			(enum of_gpio_flags *)&priv->hp_gpio.flags);
+
+	if (!gpio_is_valid(priv->hp_gpio.gpio))
+		goto out;
+
+	imx_wm8958_gpio_init(&data->card);
+
+	ret = driver_create_file(pdev->dev.driver, &driver_attr_headphone);
+	if (ret) {
+		dev_warn(&pdev->dev, "create hp attr failed (%d)\n", ret);
+		goto out;
+	}
+out:
+	ret = 0;
 fail:
 	of_node_put(cpu_np);
 	of_node_put(codec_np);
@@ -396,6 +507,13 @@ fail:
 	return ret;
 }
 
+static int imx_wm8958_remove(struct platform_device *pdev)
+{
+	driver_remove_file(pdev->dev.driver, &driver_attr_headphone);
+	snd_soc_jack_free_gpios(&imx_hp_jack, 1, &imx_hp_jack_gpio);
+	return 0;
+}
+
 static const struct of_device_id imx_wm8958_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-wm8958", },
 	{ /* sentinel */ }
@@ -409,6 +527,7 @@ static struct platform_driver imx_wm8958_driver = {
 		.of_match_table = imx_wm8958_dt_ids,
 	},
 	.probe = imx_wm8958_probe,
+	.remove = imx_wm8958_remove,
 };
 module_platform_driver(imx_wm8958_driver);
 
-- 
1.9.1
