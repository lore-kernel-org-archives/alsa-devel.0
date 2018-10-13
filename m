From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 03/10] ASoC: sun8i-codec: add support for
	speaker amp GPIO
Date: Fri, 12 Oct 2018 20:32:23 -0700
Message-ID: <20181013033230.6506-4-anarsoul@gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F1E1F26794F
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 05:32:48 +0200 (CEST)
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so7086880pfb.13
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 20:32:48 -0700 (PDT)
In-Reply-To: <20181013033230.6506-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some boards may have external amplifier for speaker that is controlled
via GPIO, add support for it in similar way as it's done in sun4i-codec

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/sound/sun8i-a33-codec.txt        |  3 +++
 sound/soc/sunxi/sun8i-codec.c                 | 27 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
index 2ca3d138528e..21ab72b29ee4 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
@@ -25,6 +25,9 @@ Required properties:
    - "bus": the parent APB clock for this controller
    - "mod": the parent module clock
 
+Optional properties:
+- allwinner,pa-gpios: gpio to enable external amplifier
+
 Here is an example to add a sound card and the codec binding on sun8i SoCs that
 are similar to A33 using simple-card:
 
diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index e681e194ad4c..96879dad3425 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -97,8 +98,22 @@ struct sun8i_codec {
 	struct regmap	*regmap;
 	struct clk	*clk_module;
 	struct clk	*clk_bus;
+	struct gpio_desc *gpio_pa;
 };
 
+static int sun8i_codec_spk_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(component);
+
+	gpiod_set_value_cansleep(scodec->gpio_pa,
+				 !!SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
 static int sun8i_codec_runtime_resume(struct device *dev)
 {
 	struct sun8i_codec *scodec = dev_get_drvdata(dev);
@@ -432,6 +447,9 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SOC_MIXER_ARRAY("Right Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_input_mixer_controls),
 
+	/* Speaker */
+	SND_SOC_DAPM_SPK("Speaker", sun8i_codec_spk_event),
+
 	/* Clocks */
 	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
@@ -570,6 +588,15 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_bus);
 	}
 
+	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "allwinner,pa",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(scodec->gpio_pa)) {
+		ret = PTR_ERR(scodec->gpio_pa);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get pa gpio: %d\n", ret);
+		return ret;
+	}
+
 	res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res_base);
 	if (IS_ERR(base)) {
-- 
2.19.0
