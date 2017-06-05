From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH v4 2/3] ASoC: sun8i-codec-analog: add support
 for V3s SoC
Date: Mon,  5 Jun 2017 21:27:21 +0800
Message-ID: <20170605132722.6459-3-icenowy@aosc.io>
References: <20170605132722.6459-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBXNY2XEQKGQE7YQPJCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170605132722.6459-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>

The V3s SoC features an analog codec with headphone support but without
mic2 and linein.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Changes in v4:
- Added Chen-Yu's Reviewed-By.
- Added Rob's ACK.

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
index 29c446068151..485e79f292c4 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -810,6 +810,11 @@ static int sun8i_codec_analog_add_mixer(struct snd_soc_component *cmpnt,
 	return 0;
 }
 
+static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+};
+
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 {
 	struct device *dev = cmpnt->dev;
@@ -886,6 +891,10 @@ static const struct of_device_id sun8i_codec_analog_of_match[] = {
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
2.12.2
