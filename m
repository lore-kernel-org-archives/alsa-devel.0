From: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 08/10] ASoC: sun4i-codec: Add support for
 Allwinner suniv F1C100s
Date: Mon,  3 Dec 2018 00:23:15 +0300
Message-ID: <697a9cb417b6d77080ebf7ca2fc5b2dc216ce953.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Reply-To: mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDI4VHO5SYLBBYM2SHQAKGQEZBNVINQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1543782328.git.mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allwinner suniv F1C100s has similar but primitive audio codec
comparared to sun4i. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 358 ++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 358 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7a9f84e..08a3cb0 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -4,6 +4,7 @@
  * Copyright 2015 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
  * Copyright 2015 Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
  * Copyright 2016 Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
+ * Copyright 2018 Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -226,6 +227,62 @@
=20
 #define SUN4I_DMA_MAX_BURST			(8)
=20
+/* suniv specific registers */
+
+#define SUNIV_DMA_MAX_BURST			(4)
+
+/* Codec DAC digital controls and FIFO registers */
+#define SUNIV_CODEC_ADC_FIFOC			(0x10)
+#define SUNIV_CODEC_ADC_FIFOC_EN_AD		(28)
+#define SUNIV_CODEC_ADC_FIFOS			(0x14)
+#define SUNIV_CODEC_ADC_RXDATA			(0x18)
+
+/* Output mixer and gain controls */
+#define SUNIV_CODEC_OM_DACA_CTRL			(0x20)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACAREN		(31)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACALEN		(30)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXEN			(29)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXEN			(28)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE		(27)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE		(26)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPIS			(25)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPIS			(24)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL		(22)
+#define SUNIV_CODEC_OM_DACA_CTRL_COMPTEN		(21)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN		(20)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN	(19)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN		(18)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC		(17)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC		(16)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPPAEN			(15)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN		(12)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN	(11)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN		(10)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC		(9)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC		(8)
+#define SUNIV_CODEC_OM_DACA_CTRL_LTLNMUTE		(7)
+#define SUNIV_CODEC_OM_DACA_CTRL_RTLNMUTE		(6)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPVOL			(0)
+
+/* Analog Input Mixer controls */
+#define SUNIV_CODEC_ADC_ACTL		(0x24)
+#define SUNIV_CODEC_ADC_ADCEN		(31)
+#define SUNIV_CODEC_ADC_MICG		(24)
+#define SUNIV_CODEC_ADC_LINEINVOL	(21)
+#define SUNIV_CODEC_ADC_ADCG		(16)
+#define SUNIV_CODEC_ADC_ADCMIX_MIC	(13)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINL	(12)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINR	(11)
+#define SUNIV_CODEC_ADC_ADCMIX_LINEIN	(10)
+#define SUNIV_CODEC_ADC_ADCMIX_LOUT	(9)
+#define SUNIV_CODEC_ADC_ADCMIX_ROUT	(8)
+#define SUNIV_CODEC_ADC_PASPEEDSELECT	(7)
+#define SUNIV_CODEC_ADC_FMINVOL		(4)
+#define SUNIV_CODEC_ADC_MICAMPEN	(3)
+#define SUNIV_CODEC_ADC_MICBOOST	(0)
+
+#define SUNIV_CODEC_ADC_DBG		(0x4c)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1143,6 +1200,233 @@ static const struct snd_soc_component_driver sun8i_=
a23_codec_codec =3D {
 	.non_legacy_dai_naming	=3D 1,
 };
=20
+/*suniv F1C100s codec */
+
+/* headphone controls */
+static const char * const suniv_codec_hp_src_enum_text[] =3D {
+	"DAC", "Mixer",
+};
+
+static SOC_ENUM_DOUBLE_DECL(suniv_codec_hp_src_enum,
+			    SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_LHPIS,
+			    SUNIV_CODEC_OM_DACA_CTRL_RHPIS,
+			    suniv_codec_hp_src_enum_text);
+
+static const struct snd_kcontrol_new suniv_codec_hp_src[] =3D {
+	SOC_DAPM_ENUM("Headphone Source Playback Route",
+		      suniv_codec_hp_src_enum),
+};
+
+
+/* mixer controls */
+static const struct snd_kcontrol_new suniv_codec_adc_mixer_controls[] =3D =
{
+	SOC_DAPM_SINGLE("Right Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_ROUT, 1, 0),
+	SOC_DAPM_SINGLE("Left Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LOUT, 1, 0),
+	SOC_DAPM_SINGLE("Line In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Right FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINR, 1, 0),
+	SOC_DAPM_SINGLE("Left FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINL, 1, 0),
+	SOC_DAPM_SINGLE("Mic Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_MIC, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_lmixer_controls[] =3D=
 {
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_rmixer_controls[] =3D=
 {
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN, 1, 0),
+};
+
+
+static const DECLARE_TLV_DB_SCALE(suniv_codec_dvol_scale, -7308, 116, 0);
+static const DECLARE_TLV_DB_SCALE(suniv_codec_hp_vol_scale, -6300, 100, 1)=
;
+static const DECLARE_TLV_DB_SCALE(suniv_codec_out_mixer_pregain_scale,
+				  -450, 150, 0);
+
+static const DECLARE_TLV_DB_RANGE(suniv_codec_mic_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0),
+);
+
+
+static const struct snd_kcontrol_new suniv_codec_codec_widgets[] =3D {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       suniv_codec_dvol_scale),
+	SOC_SINGLE_TLV("Headphone Playback Volume",
+		       SUNIV_CODEC_OM_DACA_CTRL,
+		       SUNIV_CODEC_OM_DACA_CTRL_HPVOL, 0x3f, 0,
+		       suniv_codec_hp_vol_scale),
+	SOC_DOUBLE("Headphone Playback Switch",
+		   SUNIV_CODEC_OM_DACA_CTRL,
+		   SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE,
+		   SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Line In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_LINEINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("FM In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_FMINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("Mic In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_MICG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+
+	/* Microphone Amp boost gains */
+	SOC_SINGLE_TLV("Mic Boost Volume", SUNIV_CODEC_ADC_ACTL,
+		       SUNIV_CODEC_ADC_MICBOOST, 0x7, 0,
+		       suniv_codec_mic_gain_scale),
+	SOC_SINGLE_TLV("ADC Capture Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_ADCG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+};
+
+static const struct snd_soc_dapm_widget suniv_codec_codec_dapm_widgets[] =
=3D {
+	/* Microphone inputs */
+	SND_SOC_DAPM_INPUT("MIC"),
+
+	/* Microphone Bias */
+	/* deleted: HBIAS, MBIAS */
+
+	/* Mic input path */
+	SND_SOC_DAPM_PGA("Mic Amplifier", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_MICAMPEN, 0, NULL, 0),
+
+	/* Line In */
+	SND_SOC_DAPM_INPUT("LINEIN"),
+
+	/* FM In */
+	SND_SOC_DAPM_INPUT("FMINR"),
+	SND_SOC_DAPM_INPUT("FMINL"),
+
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUNIV_CODEC_ADC_FIFOC,
+			    SUNIV_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("ADC", "Codec Capture", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_ADCEN, 0),
+
+	/* ADC Mixers */
+	SOC_MIXER_ARRAY("ADC Mixer", SUNIV_CODEC_ADC_ACTL,
+			 SND_SOC_NOPM, 0,
+			 suniv_codec_adc_mixer_controls),
+
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
+			    NULL, 0),
+
+	/* Analog parts of the DACs */
+	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACALEN, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACAREN, 0),
+
+	/* Mixers */
+	SOC_MIXER_ARRAY("Left Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXEN, 0,
+			suniv_codec_dac_lmixer_controls),
+	SOC_MIXER_ARRAY("Right Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXEN, 0,
+			suniv_codec_dac_rmixer_controls),
+
+	/* Headphone output path */
+	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, suniv_codec_hp_src),
+	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUNIV_CODEC_OM_DACA_CTRL,
+			     SUNIV_CODEC_OM_DACA_CTRL_HPPAEN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HPCOM Protection", SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_COMPTEN, 0, NULL, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL, 0x3, 0x3, 0),
+	SND_SOC_DAPM_OUTPUT("HP"),
+};
+
+static const struct snd_soc_dapm_route suniv_codec_codec_dapm_routes[] =3D=
 {
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+
+	/* Microphone Routes */
+	{ "Mic Amplifier", NULL, "MIC"},
+
+	/* Left Mixer Routes */
+	{ "Left Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM In Playback Switch", "FMINL" },
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Left Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* Right Mixer Routes */
+	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "FM In Playback Switch", "FMINR" },
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Right Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* ADC Mixer Routes */
+	{ "ADC Mixer", "Right Out Capture Switch", "Right Mixer" },
+	{ "ADC Mixer", "Left Out Capture Switch", "Left Mixer" },
+	{ "ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "ADC Mixer", "Right FM In Capture Switch", "FMINR" },
+	{ "ADC Mixer", "Left FM In Capture Switch", "FMINL" },
+	{ "ADC Mixer", "Mic Capture Switch", "Mic Amplifier" },
+
+	/* Headphone Routes */
+	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
+	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
+	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
+	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
+	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "HP", NULL, "Headphone Amp" },
+	{ "HPCOM", NULL, "HPCOM Protection" },
+
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Mixer" },
+	{ "ADC", NULL, "ADC Enable" },
+};
+
+static const struct snd_soc_component_driver suniv_codec_codec =3D {
+	.controls		=3D suniv_codec_codec_widgets,
+	.num_controls		=3D ARRAY_SIZE(suniv_codec_codec_widgets),
+	.dapm_widgets		=3D suniv_codec_codec_dapm_widgets,
+	.num_dapm_widgets	=3D ARRAY_SIZE(suniv_codec_codec_dapm_widgets),
+	.dapm_routes		=3D suniv_codec_codec_dapm_routes,
+	.num_dapm_routes	=3D ARRAY_SIZE(suniv_codec_codec_dapm_routes),
+	.idle_bias_on		=3D 1,
+	.use_pmdown_time	=3D 1,
+	.endianness		=3D 1,
+	.non_legacy_dai_naming	=3D 1,
+};
+
+
 static const struct snd_soc_component_driver sun4i_codec_component =3D {
 	.name =3D "sun4i-codec",
 };
@@ -1414,6 +1698,57 @@ static struct snd_soc_card *sun8i_v3s_codec_create_c=
ard(struct device *dev)
 	return card;
 };
=20
+static const struct snd_soc_dapm_widget suniv_codec_card_dapm_widgets[] =
=3D {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Right FM In", NULL),
+	SND_SOC_DAPM_LINE("Left FM In", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
+/* Connect digital side enables to analog side widgets */
+static const struct snd_soc_dapm_route suniv_codec_card_routes[] =3D {
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Enable" },
+	{ "Codec Capture", NULL, "ADC" },
+
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+	{ "Left DAC", NULL, "Codec Playback" },
+	{ "Right DAC", NULL, "Codec Playback" },
+};
+
+
+static struct snd_soc_card *suniv_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card =3D devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	card->dai_link =3D sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev		=3D dev;
+	card->name		=3D "F1C100s Audio Codec";
+	card->dapm_widgets	=3D suniv_codec_card_dapm_widgets;
+	card->num_dapm_widgets	=3D ARRAY_SIZE(suniv_codec_card_dapm_widgets);
+	card->dapm_routes	=3D suniv_codec_card_routes;
+	card->num_dapm_routes	=3D ARRAY_SIZE(suniv_codec_card_routes);
+	card->fully_routed	=3D true;
+
+	ret =3D snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config =3D {
 	.reg_bits	=3D 32,
 	.reg_stride	=3D 4,
@@ -1456,6 +1791,13 @@ static const struct regmap_config sun8i_v3s_codec_re=
gmap_config =3D {
 	.max_register	=3D SUN8I_H3_CODEC_ADC_DBG,
 };
=20
+static const struct regmap_config suniv_codec_regmap_config =3D {
+	.reg_bits	=3D 32,
+	.reg_stride	=3D 4,
+	.val_bits	=3D 32,
+	.max_register	=3D SUNIV_CODEC_ADC_DBG,
+};
+
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
 	const struct snd_soc_component_driver *codec;
@@ -1540,6 +1882,17 @@ static const struct sun4i_codec_quirks sun8i_v3s_cod=
ec_quirks =3D {
 	.dma_max_burst	=3D SUN4I_DMA_MAX_BURST,
 };
=20
+static const struct sun4i_codec_quirks suniv_f1c100s_codec_quirks =3D {
+	.regmap_config	=3D &suniv_codec_regmap_config,
+	.codec		=3D &suniv_codec_codec,
+	.create_card	=3D suniv_codec_create_card,
+	.reg_adc_fifoc	=3D REG_FIELD(SUNIV_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	=3D SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	=3D SUNIV_CODEC_ADC_RXDATA,
+	.has_reset	=3D true,
+	.dma_max_burst	=3D SUNIV_DMA_MAX_BURST,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] =3D {
 	{
 		.compatible =3D "allwinner,sun4i-a10-codec",
@@ -1565,6 +1918,10 @@ static const struct of_device_id sun4i_codec_of_matc=
h[] =3D {
 		.compatible =3D "allwinner,sun8i-v3s-codec",
 		.data =3D &sun8i_v3s_codec_quirks,
 	},
+	{
+		.compatible =3D "allwinner,suniv-f1c100s-codec",
+		.data =3D &suniv_f1c100s_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
@@ -1746,4 +2103,5 @@ MODULE_AUTHOR("Emilio L=C3=B3pez <emilio-0Z03zUJReD6cUqNHhU5XLw@public.gmane.org=
r>");
 MODULE_AUTHOR("Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
 MODULE_AUTHOR("Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>");
+MODULE_AUTHOR("Mesih Kilinc <mesikilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_LICENSE("GPL");
--=20
2.7.4

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
