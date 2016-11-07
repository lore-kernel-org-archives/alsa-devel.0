From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 2/6] ASoC: sun4i-codec: Add support for A31
 ADC capture path
Date: Mon,  7 Nov 2016 18:06:59 +0800
Message-ID: <20161107100703.5586-3-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBSVEQHAQKGQEDEGC5MA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161107100703.5586-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The A31's internal codec capture path has a mixer in front of the ADC
for each channel, capable of selecting various inputs, including
microphones, line in, phone in, and the main output mixer.

This patch adds the various controls, widgets and routes needed for
audio capture from the already supported inputs on the A31.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index b28b82a5ec62..6379efd21f00 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -788,6 +788,30 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
 			SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC2, 1, 0),
 };
 
+/* ADC mixer controls */
+static const struct snd_kcontrol_new sun6i_codec_adc_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("Mixer Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXL,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXR, 1, 0),
+	SOC_DAPM_DOUBLE("Mixer Reversed Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXR,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXL, 1, 0),
+	SOC_DAPM_DOUBLE("Line In Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_LINEINL,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_LINEINR, 1, 0),
+	SOC_DAPM_DOUBLE("Mic1 Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC1,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC1, 1, 0),
+	SOC_DAPM_DOUBLE("Mic2 Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC2,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC2, 1, 0),
+};
+
 /* headphone controls */
 static const char * const sun6i_codec_hp_src_enum_text[] = {
 	"DAC", "Mixer",
@@ -887,6 +911,10 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN6I_CODEC_MIC_CTRL,
 		       SUN6I_CODEC_MIC_CTRL_MIC2BOOST, 0x7, 0,
 		       sun6i_codec_mic_gain_scale),
+	SOC_DOUBLE_TLV("ADC Capture Volume",
+		       SUN6I_CODEC_ADC_ACTL, SUN6I_CODEC_ADC_ACTL_ADCLG,
+		       SUN6I_CODEC_ADC_ACTL_ADCRG, 0x7, 0,
+		       sun6i_codec_out_mixer_pregain_scale),
 };
 
 static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
@@ -912,6 +940,23 @@ static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
 	/* Line In */
 	SND_SOC_DAPM_INPUT("LINEIN"),
 
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUN6I_CODEC_ADC_FIFOC,
+			    SUN6I_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("Left ADC", "Codec Capture", SUN6I_CODEC_ADC_ACTL,
+			 SUN6I_CODEC_ADC_ACTL_ADCLEN, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Codec Capture", SUN6I_CODEC_ADC_ACTL,
+			 SUN6I_CODEC_ADC_ACTL_ADCREN, 0),
+
+	/* ADC Mixers */
+	SOC_MIXER_ARRAY("Left ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun6i_codec_adc_mixer_controls),
+	SOC_MIXER_ARRAY("Right ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun6i_codec_adc_mixer_controls),
+
 	/* Digital parts of the DACs */
 	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
 			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
@@ -975,6 +1020,20 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
+	/* Left ADC Mixer Routes */
+	{ "Left ADC Mixer", "Mixer Capture Switch", "Left Mixer" },
+	{ "Left ADC Mixer", "Mixer Reversed Capture Switch", "Right Mixer" },
+	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+
+	/* Right ADC Mixer Routes */
+	{ "Right ADC Mixer", "Mixer Capture Switch", "Right Mixer" },
+	{ "Right ADC Mixer", "Mixer Reversed Capture Switch", "Left Mixer" },
+	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+
 	/* Headphone Routes */
 	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
 	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
@@ -989,6 +1048,12 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
 	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+
+	/* ADC Routes */
+	{ "Left ADC", NULL, "ADC Enable" },
+	{ "Right ADC", NULL, "ADC Enable" },
+	{ "Left ADC", NULL, "Left ADC Mixer" },
+	{ "Right ADC", NULL, "Right ADC Mixer" },
 };
 
 static struct snd_soc_codec_driver sun6i_codec_codec = {
-- 
2.10.2
