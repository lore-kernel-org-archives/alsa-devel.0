From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH v2 04/12] ASoC: sun8i-codec-analog: add support
 for V3s SoC
Date: Sun,  5 Mar 2017 21:37:01 +0800
Message-ID: <20170305133709.6288-5-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBAFK6DCQKGQE5XDFPSA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170305133709.6288-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The V3s SoC features an analog codec with headphone support but without
mic2 and linein.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt | 1 +
 sound/soc/sunxi/sun8i-codec-analog.c                           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
index 779b735781ba..1b6e7c4e50ab 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun8i-a23-codec-analog"
 		- "allwinner,sun8i-h3-codec-analog"
+		- "allwinner,sun8i-v3s-codec-analog"
 
 Required properties if not a sub-node of the PRCM node:
 - reg: must contain the registers location and length
diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index af56afe5c403..d87c75c6ad8e 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -713,6 +713,11 @@ static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
 	.has_mic2	= true,
 };
 
+static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+};
+
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 {
 	struct device *dev = cmpnt->dev;
@@ -786,6 +791,10 @@ static const struct of_device_id sun8i_codec_analog_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-codec-analog",
 		.data = &sun8i_h3_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-v3s-codec-analog",
+		.data = &sun8i_v3s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun8i_codec_analog_of_match);
-- 
2.11.1
