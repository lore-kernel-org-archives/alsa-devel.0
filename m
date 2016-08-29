From: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 1/2] ASoC: imx-sgtl5000: Support non-ssi cpu-dai
Date: Mon, 29 Aug 2016 18:51:54 +0800
Message-ID: <1472467915-21317-2-git-send-email-wente.wang@nxp.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472467915-21317-1-git-send-email-wente.wang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The current imx-sgtl5000 driver always attaches the cpu-dai to ssi while
in fact it could be attached to other cpu-dais like SAI. Thus this patch
use a general code to support another cpu-dai.

Signed-off-by: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          |  4 +--
 sound/soc/fsl/imx-sgtl5000.c                       | 41 ++++++++++++++--------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
index 2f89db8..cf59521 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -6,7 +6,7 @@ Required properties:
 
   - model		: The user-visible name of this sound complex
 
-  - ssi-controller	: The phandle of the i.MX SSI controller
+  - cpu-dai		: The phandle of CPU dai
 
   - audio-codec		: The phandle of the SGTL5000 audio codec
 
@@ -45,7 +45,7 @@ sound {
 	compatible = "fsl,imx51-babbage-sgtl5000",
 		     "fsl,imx-audio-sgtl5000";
 	model = "imx51-babbage-sgtl5000";
-	ssi-controller = <&ssi1>;
+	cpu-dai = <&ssi1>;
 	audio-codec = <&sgtl5000>;
 	audio-routing =
 		"MIC_IN", "Mic Jack",
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b99e0b5..ed652ae 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012-2016 Freescale Semiconductor, Inc.
  * Copyright 2012 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -55,13 +55,9 @@ static const struct snd_soc_dapm_widget imx_sgtl5000_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
-static int imx_sgtl5000_probe(struct platform_device *pdev)
+static int imx_sgtl5000_audmux_config(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *ssi_np, *codec_np;
-	struct platform_device *ssi_pdev;
-	struct i2c_client *codec_dev;
-	struct imx_sgtl5000_data *data = NULL;
 	int int_port, ext_port;
 	int ret;
 
@@ -101,16 +97,33 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
+	return 0;
+}
+
+static int imx_sgtl5000_probe(struct platform_device *pdev)
+{
+	struct device_node *cpu_np, *codec_np;
+	struct platform_device *cpu_pdev;
+	struct i2c_client *codec_dev;
+	struct imx_sgtl5000_data *data = NULL;
+	int ret;
+
+	cpu_np = of_parse_phandle(pdev->dev.of_node, "cpu-dai", 0);
 	codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
-	if (!ssi_np || !codec_np) {
+	if (!cpu_np || !codec_np) {
 		dev_err(&pdev->dev, "phandle missing or invalid\n");
 		ret = -EINVAL;
 		goto fail;
 	}
 
-	ssi_pdev = of_find_device_by_node(ssi_np);
-	if (!ssi_pdev) {
+	if (strstr(cpu_np->name, "ssi")) {
+		ret = imx_sgtl5000_audmux_config(pdev);
+		if (ret)
+			goto fail;
+	}
+
+	cpu_pdev = of_find_device_by_node(cpu_np);
+	if (!cpu_pdev) {
 		dev_err(&pdev->dev, "failed to find SSI platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
@@ -139,8 +152,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->dai.stream_name = "HiFi";
 	data->dai.codec_dai_name = "sgtl5000";
 	data->dai.codec_of_node = codec_np;
-	data->dai.cpu_of_node = ssi_np;
-	data->dai.platform_of_node = ssi_np;
+	data->dai.cpu_of_node = cpu_np;
+	data->dai.platform_of_node = cpu_np;
 	data->dai.init = &imx_sgtl5000_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBM_CFM;
@@ -167,7 +180,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	of_node_put(ssi_np);
+	of_node_put(cpu_np);
 	of_node_put(codec_np);
 
 	return 0;
@@ -175,7 +188,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 fail:
 	if (data && !IS_ERR(data->codec_clk))
 		clk_put(data->codec_clk);
-	of_node_put(ssi_np);
+	of_node_put(cpu_np);
 	of_node_put(codec_np);
 
 	return ret;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
