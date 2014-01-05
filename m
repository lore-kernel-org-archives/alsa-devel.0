From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 5/5] ASoC: mc13783: Add devicetree support
Date: Sun,  5 Jan 2014 11:38:35 +0400
Message-ID: <1388907515-18975-5-git-send-email-shc_work@mail.ru>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 by alsa0.perex.cz (Postfix) with ESMTP id A4679261B23
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 08:38:50 +0100 (CET)
In-Reply-To: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This patch adds devicetree support for mc13783-codec.
Since we have not compatible string for this codec, just override
of_node for allow using phandle of node in the DT.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt |  4 +++-
 drivers/mfd/mc13xxx-core.c                        | 12 +++++++-----
 sound/soc/codecs/mc13783.c                        | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
index abd9e3c..f3047c9 100644
--- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -5,11 +5,13 @@ Required properties:
 
 Optional properties:
 - fsl,mc13xxx-uses-adc : Indicate the ADC is being used
-- fsl,mc13xxx-uses-codec : Indicate the Audio Codec is being used
 - fsl,mc13xxx-uses-rtc : Indicate the RTC is being used
 - fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being used
 
 Sub-nodes:
+- codec: Contain the Audio Codec node.
+  - adc-port: Contain PMIC SSI port used for ADC.
+  - dac-port: Contain PMIC SSI port used for DAC.
 - regulators : Contain the regulator nodes. The regulators are bound using
   their names as listed below with their registers and bits for enabling.
 
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 06e64b6..7d144aa 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -618,7 +618,7 @@ static int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
 	if (of_get_property(np, "fsl,mc13xxx-uses-adc", NULL))
 		mc13xxx->flags |= MC13XXX_USE_ADC;
 
-	if (of_get_property(np, "fsl,mc13xxx-uses-codec", NULL))
+	if (of_find_node_by_name(np, "codec"))
 		mc13xxx->flags |= MC13XXX_USE_CODEC;
 
 	if (of_get_property(np, "fsl,mc13xxx-uses-rtc", NULL))
@@ -673,10 +673,6 @@ int mc13xxx_common_init(struct device *dev)
 	if (mc13xxx->flags & MC13XXX_USE_ADC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
-	if (mc13xxx->flags & MC13XXX_USE_CODEC)
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
-					pdata->codec, sizeof(*pdata->codec));
-
 	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
 
@@ -691,10 +687,16 @@ int mc13xxx_common_init(struct device *dev)
 				pdata->leds, sizeof(*pdata->leds));
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
+		if (mc13xxx->flags & MC13XXX_USE_CODEC)
+			mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
+						    pdata->codec,
+						    sizeof(*pdata->codec));
 	} else {
 		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
 		mc13xxx_add_subdevice(mc13xxx, "%s-led");
 		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
+		if (mc13xxx->flags & MC13XXX_USE_CODEC)
+			mc13xxx_add_subdevice(mc13xxx, "%s-codec");
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 582c2bb..cd0181f 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/mfd/mc13xxx.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -760,13 +761,32 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	pdev->dev.of_node = of_find_node_by_name(pdev->dev.parent->of_node,
+						 "codec");
+
 	if (pdata) {
 		priv->adc_ssi_port = pdata->adc_ssi_port;
 		priv->dac_ssi_port = pdata->dac_ssi_port;
+	} else if (pdev->dev.of_node) {
+		ret = of_property_read_u32(pdev->dev.of_node, "adc-port",
+					   &priv->adc_ssi_port);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(pdev->dev.of_node, "dac-port",
+					   &priv->dac_ssi_port);
+		if (ret)
+			return ret;
 	} else {
 		return -ENOSYS;
 	}
 
+	if (priv->adc_ssi_port != MC13783_SSI1_PORT &&
+	    priv->adc_ssi_port != MC13783_SSI2_PORT)
+		return -EINVAL;
+	if (priv->dac_ssi_port != MC13783_SSI1_PORT &&
+	    priv->dac_ssi_port != MC13783_SSI2_PORT)
+		return -EINVAL;
+
 	dev_set_drvdata(&pdev->dev, priv);
 	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
 
-- 
1.8.3.2
