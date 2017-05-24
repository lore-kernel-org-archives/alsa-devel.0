From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH v3 1/9] ASoC: sun8i-codec-analog: split out mbias
Date: Wed, 24 May 2017 18:05:59 +0800
Message-ID: <20170524100607.29790-2-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBLVWSXEQKGQEGLO6JTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170524100607.29790-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>

Allwinner V3s features an analog codec without MBIAS pin.

Split out this part, in order to prepare for the V3s analog codec.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
Changes in v3:
- Fixed a missing line in v2.

 sound/soc/sunxi/sun8i-codec-analog.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 6c17c99c2c8d..edcc3eb7cd9a 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -289,11 +289,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	/* Microphone input */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
-	/* Microphone Bias */
-	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
-			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
-			    0, NULL, 0),
-
 	/* Mic input path */
 	SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
 			 SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
@@ -453,6 +448,27 @@ static int sun8i_codec_add_headphone(struct snd_soc_component *cmpnt)
 	return 0;
 }
 
+/* mbias specific widget */
+static const struct snd_soc_dapm_widget sun8i_codec_mbias_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
+			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
+			    0, NULL, 0),
+};
+
+static int sun8i_codec_add_mbias(struct snd_soc_component *cmpnt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
+	struct device *dev = cmpnt->dev;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_mbias_widgets,
+					ARRAY_SIZE(sun8i_codec_mbias_widgets));
+	if (ret)
+		dev_err(dev, "Failed to add MBIAS DAPM widgets: %d\n", ret);
+
+	return ret;
+}
+
 /* hmic specific widget */
 static const struct snd_soc_dapm_widget sun8i_codec_hmic_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("HBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
@@ -679,6 +695,7 @@ struct sun8i_codec_analog_quirks {
 	bool has_hmic;
 	bool has_linein;
 	bool has_lineout;
+	bool has_mbias;
 	bool has_mic2;
 };
 
@@ -686,12 +703,14 @@ static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
 	.has_headphone	= true,
 	.has_hmic	= true,
 	.has_linein	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
 	.has_linein	= true,
 	.has_lineout	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
@@ -734,6 +753,12 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 			return ret;
 	}
 
+	if (quirks->has_mbias) {
+		ret = sun8i_codec_add_mbias(cmpnt);
+		if (ret)
+			return ret;
+	}
+
 	if (quirks->has_mic2) {
 		ret = sun8i_codec_add_mic2(cmpnt);
 		if (ret)
-- 
2.12.2
