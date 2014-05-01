From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/2] ASoC: mc13783: Add devicetree support
Date: Thu,  1 May 2014 10:49:12 +0400
Message-ID: <1398926952-21820-1-git-send-email-shc_work@mail.ru>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds devicetree support for mc13783-codec.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt |  3 +++
 sound/soc/codecs/mc13783.c                        | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
index 1413f39..8aba488 100644
--- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -10,6 +10,9 @@ Optional properties:
 - fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being used
 
 Sub-nodes:
+- codec: Contain the Audio Codec node.
+  - adc-port: Contain PMIC SSI port number used for ADC.
+  - dac-port: Contain PMIC SSI port number used for DAC.
 - leds : Contain the led nodes and initial register values in property
   "led-control". Number of register depends of used IC, for MC13783 is 6,
   for MC13892 is 4, for MC34708 is 1. See datasheet for bits definitions of
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 0b0a4ca..9965277 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -22,6 +22,7 @@
  */
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/mfd/mc13xxx.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -748,6 +749,7 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 {
 	struct mc13783_priv *priv;
 	struct mc13xxx_codec_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -758,7 +760,17 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		priv->adc_ssi_port = pdata->adc_ssi_port;
 		priv->dac_ssi_port = pdata->dac_ssi_port;
 	} else {
-		return -ENOSYS;
+		np = of_get_child_by_name(pdev->dev.parent->of_node, "codec");
+		if (!np)
+			return -ENOSYS;
+
+		ret = of_property_read_u32(np, "adc-port", &priv->adc_ssi_port);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32(np, "dac-port", &priv->dac_ssi_port);
+		if (ret)
+			return ret;
 	}
 
 	dev_set_drvdata(&pdev->dev, priv);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
