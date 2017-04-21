From: Jens Rottmann <Jens.Rottmann@ADLINKtech.com>
Subject: [PATCH] streamline TLV320AIC23 drivers
Date: Fri, 21 Apr 2017 21:22:02 +0200
Message-ID: <b4127646-565b-ab16-0a8f-1fd6c263389e@ADLINKtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The iMX-TLV320AIC23 driver isn't from Freescale, but from a company named
Eukrea Electromatique, originally for their own boards. From the code I get
the impression it is a bit older, its DT options use a differing naming
scheme. Patch it up a bit:

- Remove Eukrea naming, i.MX is from Freescale, TLV320AIC23 is from TI,
  driver was written by Eukrea, but it's DT capable, so it's not exclusive:
  - Kconfig option title
  - 'model' option
  - driver 'compatible' string
- Other options just have changed over time, this driver remaining (one of)
  the last with the old semantics:
  - 'audio-codec' option (also moved from ssi node)
  - 'mux-int/ext-port' options
- All options stay backwards compatible, the DT binding documents new and
  old names.

CONFIG variable and files have not been renamed, though, so no need to
change old defconfigs.

Signed-off-by: Jens Rottmann <Jens.Rottmann@ADLINKtech.com>
---

--- a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
+++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
@@ -1,16 +1,23 @@
-Audio complex for Eukrea boards with tlv320aic23 codec.
+Audio complex for Freescale i.MX boards with TI TLV320AIC23 I2S codecs,
+like those from Eukrea Electromatique.
 
 Required properties:
 
-  - compatible		: "eukrea,asoc-tlv320"
+  - compatible		: "fsl,imx-audio-tlv320aic23" or
+			  "eukrea,asoc-tlv320" (deprecated)
 
-  - eukrea,model	: The user-visible name of this sound complex.
+  - model		: The user-visible name of this sound complex.
+  - eukrea,model	: Dito, deprecated.
 
   - ssi-controller	: The phandle of the SSI controller.
 
-  - fsl,mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
+  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
+  - fsl,mux-int-port	: Dito, deprecated.
 
-  - fsl,mux-ext-port	: The external port of the i.MX audio muxer.
+  - mux-ext-port	: The external port of the i.MX audio muxer.
+  - fsl,mux-ext-port	: Dito, deprecated.
+
+  - audio-codec		: The phandle of the audio codec.
 
 Note: The AUDMUX port numbering should start at 1, which is consistent with
 hardware manual.
@@ -18,9 +25,10 @@ hardware manual.
 Example:
 
 	sound {
-		compatible = "eukrea,asoc-tlv320";
-		eukrea,model = "imx51-eukrea-tlv320aic23";
+		compatible = "fsl,imx-audio-tlv320aic23";
+		model = "imx51-eukrea-tlv320aic23";
 		ssi-controller = <&ssi2>;
-		fsl,mux-int-port = <2>;
-		fsl,mux-ext-port = <3>;
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+		audio-codec = <&codec>;
 	};
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -220,7 +220,7 @@ config SND_SOC_PHYCORE_AC97
 	  and phyCARD boards in AC97 mode
 
 config SND_SOC_EUKREA_TLV320
-	tristate "Eukrea TLV320"
+	tristate "SoC Audio support for i.MX boards with TLV320AIC23"
 	depends on ARCH_MXC && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -92,11 +92,13 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 
 	eukrea_tlv320.dev = &pdev->dev;
 	if (np) {
-		ret = snd_soc_of_parse_card_name(&eukrea_tlv320,
-						 "eukrea,model");
+		ret = snd_soc_of_parse_card_name(&eukrea_tlv320, "model");
+		if (ret) /* backwards compatible */
+			ret = snd_soc_of_parse_card_name(&eukrea_tlv320,
+			                                 "eukrea,model");
 		if (ret) {
 			dev_err(&pdev->dev,
-				"eukrea,model node missing or invalid.\n");
+			        "model node missing or invalid.\n");
 			goto err;
 		}
 
@@ -109,22 +111,28 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		codec_np = of_parse_phandle(ssi_np, "codec-handle", 0);
+		codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
+		if (!codec_np) /* backwards compatible */
+			codec_np = of_parse_phandle(ssi_np, "codec-handle", 0);
 		if (codec_np)
 			eukrea_tlv320_dai.codec_of_node = codec_np;
 		else
-			dev_err(&pdev->dev, "codec-handle node missing or invalid.\n");
+			dev_err(&pdev->dev, "audio-codec node missing or invalid.\n");
 
-		ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
+		ret = of_property_read_u32(np, "mux-int-port", &int_port);
+		if (ret) /* backwards compatible */
+			ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
 		if (ret) {
 			dev_err(&pdev->dev,
-				"fsl,mux-int-port node missing or invalid.\n");
+			        "mux-int-port node missing or invalid.\n");
 			return ret;
 		}
-		ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
+		ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+		if (ret) /* backwards compatible */
+			ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
 		if (ret) {
 			dev_err(&pdev->dev,
-				"fsl,mux-ext-port node missing or invalid.\n");
+			        "mux-ext-port node missing or invalid.\n");
 			return ret;
 		}
 
@@ -213,7 +221,8 @@ static int eukrea_tlv320_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_tlv320_dt_ids[] = {
-	{ .compatible = "eukrea,asoc-tlv320"},
+	{ .compatible = "eukrea,asoc-tlv320"}, /* backwards compatible */
+	{ .compatible = "fsl,imx-audio-tlv320aic23"},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_tlv320_dt_ids);
_
