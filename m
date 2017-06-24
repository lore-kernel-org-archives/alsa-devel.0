From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v13 13/14] ASoC: sun4i-codec: Add Left Capture
 Select, Right Capture Select.
Date: Sat, 24 Jun 2017 08:24:18 +0200
Message-ID: <20170624062419.23778-14-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBDUMXDFAKGQE2ICKKDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170624062419.23778-1-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add Left Capture Select and Right Capture Select for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 085a603..65a4685 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -676,6 +676,25 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_capture_source[] = {
+	"Line",
+	"FM",
+	"Mic1",
+	"Mic2",
+	"Mic1,Mic2",
+	"Mic1+Mic2",
+	"Output Mixer",
+	"Line,Mic1",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_ADCIS,
+			    sun4i_codec_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
+	SOC_DAPM_ENUM("Capture Source", sun4i_codec_enum_capture_source);
+
 static const char * const sun4i_codec_difflinein_source[] = {
 	"Stereo",
 	"Differential",
@@ -808,6 +827,10 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 			    &sun4i_codec_pa_mute),
 
 	/* MUX */
+	SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
+	SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
 	SND_SOC_DAPM_MUX("Differential Line Source", SND_SOC_NOPM,
 			 0, 0,
 			 &sun4i_codec_difflinein_source_controls),
@@ -875,6 +898,33 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	/* LNRDF Routes */
 	{ "Differential Line Source", "Differential", "Line Left" },
 	{ "Differential Line Source", "Differential", "Line Right" },
+
+	/* Right ADC Input Routes */
+	{ "Right Capture Select", "Line", "Line Right" },
+	{ "Right Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Right Capture Select", "FM", "FM Right" },
+	{ "Right Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1,Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Output Mixer", "Right Mixer" },
+	{ "Right Capture Select", "Line,Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right ADC", NULL, "Right Capture Select" },
+
+	/* Left ADC Input Routes */
+	{ "Left Capture Select", "Line", "Line Left" },
+	{ "Left Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Left Capture Select", "FM", "FM Left" },
+	{ "Left Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1,Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Output Mixer", "Left Mixer" },
+	{ "Left Capture Select", "Line,Mic1", "Line Left" },
+	{ "Left Capture Select", "Line,Mic1", "Differential Line Capture Switch" },
+	{ "Left ADC", NULL, "Left Capture Select" },
 };
 
 struct sun4i_codec_quirks {
-- 
2.1.4
