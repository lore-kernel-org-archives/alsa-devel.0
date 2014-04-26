From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: mc13783: Add devicetree support
Date: Sat, 26 Apr 2014 10:57:03 +0400
Message-ID: <1398495423-2223-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9B0260818
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 08:57:15 +0200 (CEST)
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
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds devicetree support for mc13783-codec.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt |  3 +++
 drivers/mfd/mc13xxx-core.c                        | 10 +++++++---
 sound/soc/codecs/mc13783.c                        | 14 +++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

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
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 06e64b6..0c6c21c 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -673,9 +673,13 @@ int mc13xxx_common_init(struct device *dev)
 	if (mc13xxx->flags & MC13XXX_USE_ADC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
-	if (mc13xxx->flags & MC13XXX_USE_CODEC)
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
-					pdata->codec, sizeof(*pdata->codec));
+	if (mc13xxx->flags & MC13XXX_USE_CODEC) {
+		if (pdata)
+			mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
+				pdata->codec, sizeof(*pdata->codec));
+		else
+			mc13xxx_add_subdevice(mc13xxx, "%s-codec");
+	}
 
 	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
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
