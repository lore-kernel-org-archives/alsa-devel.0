From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v13 12/14] ASoC: sun4i-codec: Add Differential
 Line Source.
Date: Sat, 24 Jun 2017 08:24:17 +0200
Message-ID: <20170624062419.23778-13-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBDEMXDFAKGQEOCSKTUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Add Differential Line Source for Allwinner A10 and Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcd665d..085a603 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -110,6 +110,7 @@
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_LNPREG			(13)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -675,6 +676,20 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_difflinein_source[] = {
+	"Stereo",
+	"Differential",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_LNRDF,
+			    sun4i_codec_difflinein_source);
+
+static const struct snd_kcontrol_new sun4i_codec_difflinein_source_controls =
+	SOC_DAPM_ENUM("Differential Line Source",
+		      sun4i_codec_enum_difflinein_source);
+
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
@@ -792,6 +807,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	/* MUX */
+	SND_SOC_DAPM_MUX("Differential Line Source", SND_SOC_NOPM,
+			 0, 0,
+			 &sun4i_codec_difflinein_source_controls),
+
 	SND_SOC_DAPM_INPUT("Line Right"),
 	SND_SOC_DAPM_INPUT("Line Left"),
 	SND_SOC_DAPM_INPUT("FM Right"),
@@ -851,6 +871,10 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
 	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
 	{ "Mic2", NULL, "VMIC" },
+
+	/* LNRDF Routes */
+	{ "Differential Line Source", "Differential", "Line Left" },
+	{ "Differential Line Source", "Differential", "Line Right" },
 };
 
 struct sun4i_codec_quirks {
-- 
2.1.4
