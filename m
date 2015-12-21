From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 2/2] sun4i-codec: Add FM, Line and Mic inputs
Date: Mon, 21 Dec 2015 12:06:50 +1100
Message-ID: <CAJzetvvC3LBr+2LUKthKkhcHZ2xLMN+jwOSMduCHgHJNL0=uZQ@mail.gmail.com>
References: <20151219034511.372575d3@dayas>
	<20151219035936.1880d07f@dayas>
Reply-To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e0149c028a0c23105275e1a8b
Return-path: <linux-sunxi+bncBDCKXM7WZYLRBK5B3WZQKGQEOUMG7UQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151219035936.1880d07f@dayas>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--089e0149c028a0c23105275e1a8b
Content-Type: text/plain; charset=UTF-8

Hi Danny

+       {"Capture Source", "Line-In", "Line-In"},
+       {"Capture Source", "FM", "FM"},
The ADC Capturing Sources routing doesn't look right.
There is no FM/Line-In source widgets for this routing n your patch.
+       {"Capture Source", "Line-In,Mic1", "Line-In"},
+       {"Capture Source", "Line-In,Mic1", "MIC1 Pre-Amplifier"},
and her too.

I'm not familiar with the CODEC ADC mux but you may want to use
        {"Capture Source", "Line-In", "Line-In Right"},
        {"Capture Source", "Line-In", "Line-In Left"},
        {"Capture Source", "FM", "FM Right"},
        {"Capture Source", "FM", "FM Left"},

Regards

On Sat, Dec 19, 2015 at 1:59 PM, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
> wrote:

> This is the second part, actually adding FM, Line and Mic inputs.
>
> Signed-off-by: Danny Milosavljevic <dannym+a-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> ---
>  b/sound/soc/sunxi/sun4i-codec.c |  182
> +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 178 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 6628e6e..9a9ad62 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -59,9 +59,20 @@
>  #define SUN4I_CODEC_DAC_ACTL_DACAENR                   (31)
>  #define SUN4I_CODEC_DAC_ACTL_DACAENL                   (30)
>  #define SUN4I_CODEC_DAC_ACTL_MIXEN                     (29)
> +#define SUN4I_CODEC_DAC_ACTL_LNG                       (26)
> +#define SUN4I_CODEC_DAC_ACTL_FMG                       (23)
> +#define SUN4I_CODEC_DAC_ACTL_MICG                      (20)
> +#define SUN4I_CODEC_DAC_ACTL_LLNS                      (19)
> +#define SUN4I_CODEC_DAC_ACTL_RLNS                      (18)
> +#define SUN4I_CODEC_DAC_ACTL_LFMS                      (17)
> +#define SUN4I_CODEC_DAC_ACTL_RFMS                      (16)
>  #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS                 (15)
>  #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS                 (14)
>  #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS                 (13)
> +#define SUN4I_CODEC_DAC_ACTL_MIC1LS                    (12)
> +#define SUN4I_CODEC_DAC_ACTL_MIC1RS                    (11)
> +#define SUN4I_CODEC_DAC_ACTL_MIC2LS                    (10)
> +#define SUN4I_CODEC_DAC_ACTL_MIC2RS                    (9)
>  #define SUN4I_CODEC_DAC_ACTL_DACPAS                    (8)
>  #define SUN4I_CODEC_DAC_ACTL_MIXPAS                    (7)
>  #define SUN4I_CODEC_DAC_ACTL_PA_MUTE                   (6)
> @@ -87,8 +98,11 @@
>  #define SUN4I_CODEC_ADC_ACTL_PREG1EN                   (29)
>  #define SUN4I_CODEC_ADC_ACTL_PREG2EN                   (28)
>  #define SUN4I_CODEC_ADC_ACTL_VMICEN                    (27)
> -#define SUN4I_CODEC_ADC_ACTL_VADCG                     (20)
> +#define SUN4I_CODEC_ADC_ACTL_PREG1_A10                 (25)
> +#define SUN4I_CODEC_ADC_ACTL_PREG2_A10                 (23)
> +#define SUN4I_CODEC_ADC_ACTL_ADCG                      (20)
>  #define SUN4I_CODEC_ADC_ACTL_ADCIS                     (17)
> +#define SUN4I_CODEC_ADC_ACTL_LNRDF                     (16)
>  #define SUN4I_CODEC_ADC_ACTL_PA_EN                     (4)
>  #define SUN4I_CODEC_ADC_ACTL_DDE                       (3)
>  #define SUN4I_CODEC_ADC_DEBUG                  (0x2c)
> @@ -100,6 +114,16 @@
>  #define SUN7I_CODEC_AC_DAC_CAL                 (0x38)
>  #define SUN7I_CODEC_AC_MIC_PHONE_CAL           (0x3c)
>
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1      (29)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2      (26)
> +/* note: no idea where the output pins for the following are. */
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTG  (5)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTEN (4)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS3 (3)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS2 (2)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS1 (1)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS0 (0)
> +
>  struct sun4i_codec {
>         struct device   *dev;
>         struct regmap   *regmap;
> @@ -509,19 +533,102 @@ static const struct snd_kcontrol_new
> sun4i_codec_pa_mute =
>                         SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
>
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale,
> +                           -150,
> +                           150,
> +                           0);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale,
> +                           -450,
> +                           150,
> +                           0);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale,
> +                           -450,
> +                           150,
> +                           0);
> +static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale_a10,
> +                           0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +                           1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);
> +/* Sources:
> + *   A10 User Manual v1.5 20130820
> + *   A20 User Manual v1.4 20150510
> + */
> +static const char * const sun4i_codec_capture_source[] = {
> +       "Line-In",
> +       "FM",
> +       "Mic1",
> +       "Mic2",
> +       "Mic1,Mic2",
> +       "Mic1+Mic2",
> +       "Output Mixer",
> +       "Line-In,Mic1",
> +};
> +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> +                           SUN4I_CODEC_ADC_ACTL,
> +                           SUN4I_CODEC_ADC_ACTL_ADCIS,
> +                           sun4i_codec_capture_source);
> +
> +static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
> +       SOC_DAPM_ENUM("Route", sun4i_codec_enum_capture_source);
>
>  #define SUN4I_COMMON_CODEC_WIDGETS \
> -       SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> -                      SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> -                      sun4i_codec_pa_volume_scale)
> +       SOC_SINGLE_TLV("Power Amplifier Playback Volume",
> SUN4I_CODEC_DAC_ACTL,\
> +                      SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0, \
> +                      sun4i_codec_pa_volume_scale), \
> +       /* Line-In, FM, Mic1, Mic2 */ \
> +       SOC_SINGLE_TLV("Line-In Playback Volume", \
> +                      SUN4I_CODEC_DAC_ACTL, \
> +                      SUN4I_CODEC_DAC_ACTL_LNG, \
> +                      1, \
> +                      0, \
> +                      sun4i_codec_linein_loopback_gain_scale), \
> +       SOC_SINGLE_TLV("FM Playback Volume", \
> +                      SUN4I_CODEC_DAC_ACTL, \
> +                      SUN4I_CODEC_DAC_ACTL_FMG, \
> +                      3, \
> +                      0, \
> +                      sun4i_codec_fmin_loopback_gain_scale), \
> +       SOC_SINGLE_TLV("Mic Playback Volume", \
> +                      SUN4I_CODEC_DAC_ACTL, \
> +                      SUN4I_CODEC_DAC_ACTL_MICG, \
> +                      7, \
> +                      0, \
> +                      sun4i_codec_micin_loopback_gain_scale), \
> +       /* ADC */ \
> +       SOC_SINGLE_TLV("Capture Volume", \
> +                      SUN4I_CODEC_ADC_ACTL, \
> +                      SUN4I_CODEC_ADC_ACTL_ADCG, \
> +                      4, \
> +                      0, \
> +                      sun4i_codec_adc_gain_scale)
>
>  static const struct snd_kcontrol_new sun4i_codec_widgets_a10[] = {
>         SUN4I_COMMON_CODEC_WIDGETS,
> +       SOC_SINGLE_TLV("Mic1 Capture Volume",
> +                      SUN4I_CODEC_ADC_ACTL,
> +                      SUN4I_CODEC_ADC_ACTL_PREG1_A10,
> +                      3,
> +                      0,
> +                      sun4i_codec_micin_preamp_gain_scale_a10),
> +       SOC_SINGLE_TLV("Mic2 Capture Volume",
> +                      SUN4I_CODEC_ADC_ACTL,
> +                      SUN4I_CODEC_ADC_ACTL_PREG2_A10,
> +                      3,
> +                      0,
> +                      sun4i_codec_micin_preamp_gain_scale_a10),
>  };
>
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
>         SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> +       SOC_DAPM_SINGLE("Left Line-In Playback Switch",
> SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_LLNS, 1, 0),
> +       SOC_DAPM_SINGLE("Left FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_LFMS, 1, 0),
> +       SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_MIC1LS, 1, 0),
> +       SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_MIC2LS, 1, 0),
>  };
>
>  static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] =
> {
> @@ -529,6 +636,14 @@ static const struct snd_kcontrol_new
> sun4i_codec_right_mixer_controls[] = {
>                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>         SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
> +       SOC_DAPM_SINGLE("Right Line-In Playback Switch",
> SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
> +       SOC_DAPM_SINGLE("Right FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
> +       SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
> +       SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +                       SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
>  };
>
>  static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
> @@ -561,6 +676,10 @@ static const struct snd_soc_dapm_widget
> sun4i_codec_codec_dapm_widgets[] = {
>         SND_SOC_DAPM_DAC("Right DAC", "Codec Playback",
> SUN4I_CODEC_DAC_ACTL,
>                          SUN4I_CODEC_DAC_ACTL_DACAENR, 0),
>
> +       /* MUX */
> +       SND_SOC_DAPM_MUX("Capture Source", SND_SOC_NOPM, 0, 0,
> +                        &sun4i_codec_capture_source_controls),
> +
>         /* Mixers */
>         SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
>                            sun4i_codec_left_mixer_controls,
> @@ -580,6 +699,8 @@ static const struct snd_soc_dapm_widget
> sun4i_codec_codec_dapm_widgets[] = {
>         /* Mic Pre-Amplifiers */
>         SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
>                          SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
> +       SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
> +                        SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
>
>         /* Power Amplifier */
>         SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
> @@ -590,9 +711,15 @@ static const struct snd_soc_dapm_widget
> sun4i_codec_codec_dapm_widgets[] = {
>                             &sun4i_codec_pa_mute),
>
>         SND_SOC_DAPM_INPUT("Mic1"),
> +       SND_SOC_DAPM_INPUT("Mic2"),
>
>         SND_SOC_DAPM_OUTPUT("HP Right"),
>         SND_SOC_DAPM_OUTPUT("HP Left"),
> +
> +       SND_SOC_DAPM_INPUT("Line-In Right"),
> +       SND_SOC_DAPM_INPUT("Line-In Left"),
> +       SND_SOC_DAPM_INPUT("FM Right"),
> +       SND_SOC_DAPM_INPUT("FM Left"),
>  };
>
>  static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
> @@ -629,6 +756,36 @@ static const struct snd_soc_dapm_route
> sun4i_codec_codec_dapm_routes[] = {
>         { "Right ADC", NULL, "MIC1 Pre-Amplifier" },
>         { "MIC1 Pre-Amplifier", NULL, "Mic1"},
>         { "Mic1", NULL, "VMIC" },
> +       { "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
> +       { "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
> +
> +       /* Mic2 Routes */
> +       { "Left ADC", NULL, "MIC2 Pre-Amplifier" },
> +       { "Right ADC", NULL, "MIC2 Pre-Amplifier" },
> +       { "MIC2 Pre-Amplifier", NULL, "Mic2"},
> +       { "Mic2", NULL, "VMIC" },
> +       { "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
> +       { "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
> +
> +       /* Line-In, FM Routes */
> +       { "Right Mixer", "Right Line-In Playback Switch", "Line-In Right"
> },
> +       { "Left Mixer", "Left Line-In Playback Switch", "Line-In Left" },
> +       { "Right Mixer", "Right FM Playback Switch", "FM Right" },
> +       { "Left Mixer", "Left FM Playback Switch", "FM Left" },
> +
> +       /* ADC Capturing Sources */
> +       {"Capture Source", "Line-In", "Line-In"},
> +       {"Capture Source", "FM", "FM"},
> +       {"Capture Source", "Mic1", "MIC1 Pre-Amplifier"},
> +       {"Capture Source", "Mic2", "MIC2 Pre-Amplifier"},
> +       {"Capture Source", "Mic1,Mic2", "MIC1 Pre-Amplifier"},
> +       {"Capture Source", "Mic1,Mic2", "MIC2 Pre-Amplifier"},
> +       {"Capture Source", "Mic1+Mic2", "MIC1 Pre-Amplifier"},
> +       {"Capture Source", "Mic1+Mic2", "MIC2 Pre-Amplifier"},
> +       {"Capture Source", "Output Mixer", "Left Mixer"},
> +       {"Capture Source", "Output Mixer", "Right Mixer"},
> +       {"Capture Source", "Line-In,Mic1", "Line-In"},
> +       {"Capture Source", "Line-In,Mic1", "MIC1 Pre-Amplifier"},
>  };
>
>  static struct snd_soc_codec_driver sun4i_codec_codec_a10 = {
> @@ -757,8 +914,25 @@ static struct snd_soc_card
> *sun4i_codec_create_card(struct device *dev)
>         return card;
>  };
>
> +static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
> +       0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +       1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0)
> +);
> +
>  static const struct snd_kcontrol_new sun7i_codec_widgets[] = {
>         SUN4I_COMMON_CODEC_WIDGETS,
> +       SOC_SINGLE_TLV("Mic1 Capture Volume",
> +                      SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +                      SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,
> +                      7,
> +                      0,
> +                      sun7i_codec_micin_preamp_gain_scale),
> +       SOC_SINGLE_TLV("Mic2 Capture Volume",
> +                      SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +                      SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,
> +                      7,
> +                      0,
> +                      sun7i_codec_micin_preamp_gain_scale),
>  };
>
>  static struct snd_soc_codec_driver sun7i_codec_codec = {
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--089e0149c028a0c23105275e1a8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Danny<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0{&quot;Capture Source&quot;, &quot;Line-In&quot;, &quot;Line-In&quot;},<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;FM&quot;, &q=
uot;FM&quot;},<br>The ADC Capturing Sources routing doesn&#39;t look right.=
 <br></div>There is no FM/Line-In source widgets for this routing n your pa=
tch.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Line-In,Mic1=
&quot;, &quot;Line-In&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Line-In,Mic1=
&quot;, &quot;MIC1 Pre-Amplifier&quot;},<br></div>and her too.<br><br></div=
>I&#39;m not familiar with the CODEC ADC mux but you may want to use<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {&quot;Capture Source&quot;, &quot;=
Line-In&quot;, &quot;Line-In Right&quot;},<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 {&quot;Capture Source&quot;, &quot;Line-In&quot;, &quot;Lin=
e-In Left&quot;},<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {&quot;Capt=
ure Source&quot;, &quot;FM&quot;, &quot;FM Right&quot;},<br>=C2=A0=C2=A0 =
=C2=A0 =C2=A0=C2=A0 {&quot;Capture Source&quot;, &quot;FM&quot;, &quot;FM L=
eft&quot;},<br><div><br><div>Regards<br></div><div><span class=3D"im"></spa=
n></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Sat, Dec 19, 2015 at 1:59 PM, Danny Milosavljevic <span dir=3D"ltr">&=
lt;<a href=3D"mailto:dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org" target=3D"_blank">dannym@scrat=
chpost.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This is =
the second part, actually adding FM, Line and Mic inputs.<br>
<span class=3D""><br>
Signed-off-by: Danny Milosavljevic &lt;<a href=3D"mailto:dannym%2Ba@scratch=
post.org">dannym+a-bxPqe3T81XXwRsdMLXbzog@public.gmane.org</a>&gt;<br>
---<br>
</span>=C2=A0b/sound/soc/sunxi/sun4i-codec.c |=C2=A0 182 ++++++++++++++++++=
+++++++++++++++++++++-<br>
=C2=A01 file changed, 178 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c<=
br>
index 6628e6e..9a9ad62 100644<br>
--- a/sound/soc/sunxi/sun4i-codec.c<br>
+++ b/sound/soc/sunxi/sun4i-codec.c<br>
@@ -59,9 +59,20 @@<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_DACAENR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(31)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_DACAENL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(30)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_MIXEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(29)<br>
+#define SUN4I_CODEC_DAC_ACTL_LNG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(26)<br>
+#define SUN4I_CODEC_DAC_ACTL_FMG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(23)<br>
+#define SUN4I_CODEC_DAC_ACTL_MICG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (20)<br>
+#define SUN4I_CODEC_DAC_ACTL_LLNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (19)<br>
+#define SUN4I_CODEC_DAC_ACTL_RLNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (18)<br>
+#define SUN4I_CODEC_DAC_ACTL_LFMS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (17)<br>
+#define SUN4I_CODEC_DAC_ACTL_RFMS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (16)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_LDACLMIXS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(15)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_RDACRMIXS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(14)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_LDACRMIXS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(13)<br>
+#define SUN4I_CODEC_DAC_ACTL_MIC1LS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (12)<br>
+#define SUN4I_CODEC_DAC_ACTL_MIC1RS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (11)<br>
+#define SUN4I_CODEC_DAC_ACTL_MIC2LS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (10)<br>
+#define SUN4I_CODEC_DAC_ACTL_MIC2RS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (9)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_DACPAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (8)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_MIXPAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (7)<br>
=C2=A0#define SUN4I_CODEC_DAC_ACTL_PA_MUTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(6)<br>
@@ -87,8 +98,11 @@<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_PREG1EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(29)<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_PREG2EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(28)<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_VMICEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (27)<br>
-#define SUN4I_CODEC_ADC_ACTL_VADCG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(20)<br>
+#define SUN4I_CODEC_ADC_ACTL_PREG1_A10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(25)<br>
+#define SUN4I_CODEC_ADC_ACTL_PREG2_A10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(23)<br>
+#define SUN4I_CODEC_ADC_ACTL_ADCG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (20)<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_ADCIS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(17)<br>
+#define SUN4I_CODEC_ADC_ACTL_LNRDF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(16)<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_PA_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(4)<br>
=C2=A0#define SUN4I_CODEC_ADC_ACTL_DDE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(3)<br>
=C2=A0#define SUN4I_CODEC_ADC_DEBUG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (0x2c)<br>
@@ -100,6 +114,16 @@<br>
=C2=A0#define SUN7I_CODEC_AC_DAC_CAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(0x38)<br>
=C2=A0#define SUN7I_CODEC_AC_MIC_PHONE_CAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x3c)<br>
<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1=C2=A0 =C2=A0 =C2=A0 (29)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2=C2=A0 =C2=A0 =C2=A0 (26)<br>
+/* note: no idea where the output pins for the following are. */<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTG=C2=A0 (5)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTEN (4)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS3 (3)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS2 (2)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS1 (1)<br>
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS0 (0)<br>
+<br>
<span class=3D"">=C2=A0struct sun4i_codec {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device=C2=A0 =C2=A0*dev;<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct regmap=C2=A0 =C2=A0*regmap;<br>
@@ -509,19 +533,102 @@ static const struct snd_kcontrol_new sun4i_codec_pa_=
mute =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);<br>
<span class=3D""><br>
=C2=A0static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, =
1);<br>
</span>+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-150,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0150,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00);<br>
+static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-450,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0150,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00);<br>
+static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-450,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0150,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00);<br>
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale_a10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00, 0, TLV_DB_SCALE_ITEM(0, 0, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));<br>
+static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);<br>
+/* Sources:<br>
+ *=C2=A0 =C2=A0A10 User Manual v1.5 20130820<br>
+ *=C2=A0 =C2=A0A20 User Manual v1.4 20150510<br>
+ */<br>
+static const char * const sun4i_codec_capture_source[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Line-In&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;FM&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Mic1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Mic2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Mic1,Mic2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Mic1+Mic2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Output Mixer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Line-In,Mic1&quot;,<br>
+};<br>
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0SUN4I_CODEC_ADC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0SUN4I_CODEC_ADC_ACTL_ADCIS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sun4i_codec_capture_source);<br>
+<br>
+static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_ENUM(&quot;Route&quot;, sun4i_codec_en=
um_capture_source);<br>
<br>
=C2=A0#define SUN4I_COMMON_CODEC_WIDGETS \<br>
<span class=3D"">-=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Power Amp=
lifier Volume&quot;, SUN4I_CODEC_DAC_ACTL,\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_pa_volume_scale)<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Power Amplifier Pla=
yback Volume&quot;, SUN4I_CODEC_DAC_ACTL,\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_pa_volume_scale), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Line-In, FM, Mic1, Mic2 */ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Line-In Playback Volume&qu=
ot;, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL_LNG, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_linein_loopback_gain_scale), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;FM Playback Volume&quot;, =
\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL_FMG, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_fmin_loopback_gain_scale), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Mic Playback Volume&quot;,=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_DAC_ACTL_MICG, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 7, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_micin_loopback_gain_scale), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ADC */ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Capture Volume&quot;, \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL_ADCG, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_adc_gain_scale)<br>
<span class=3D""><br>
=C2=A0static const struct snd_kcontrol_new sun4i_codec_widgets_a10[] =3D {<=
br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SUN4I_COMMON_CODEC_WIDGETS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Mic1 Capture Volume&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL_PREG1_A10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_micin_preamp_gain_scale_a10),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Mic2 Capture Volume&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN4I_CODEC_ADC_ACTL_PREG2_A10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun4i_codec_micin_preamp_gain_scale_a10),<br>
<span class=3D"">=C2=A0};<br>
<br>
=C2=A0static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[=
] =3D {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SOC_DAPM_SINGLE(&quot;Left DAC Playback =
Switch&quot;, SUN4I_CODEC_DAC_ACTL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Left Line-In Playback Swi=
tch&quot;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_LLNS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Left FM Playback Switch&q=
uot;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_LFMS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Mic1 Playback Switch&quot=
;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_MIC1LS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Mic2 Playback Switch&quot=
;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_MIC2LS, 1, 0),<br>
=C2=A0};<br>
<br>
=C2=A0static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls=
[] =3D {<br>
@@ -529,6 +636,14 @@ static const struct snd_kcontrol_new sun4i_codec_right=
_mixer_controls[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SOC_DAPM_SINGLE(&quot;Left DAC Playback Switch&=
quot;, SUN4I_CODEC_DAC_ACTL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Right Line-In Playback Sw=
itch&quot;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Right FM Playback Switch&=
quot;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Mic1 Playback Switch&quot=
;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DAPM_SINGLE(&quot;Mic2 Playback Switch&quot=
;, SUN4I_CODEC_DAC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),<br>
=C2=A0};<br>
<br>
=C2=A0static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] =
=3D {<br>
@@ -561,6 +676,10 @@ static const struct snd_soc_dapm_widget sun4i_codec_co=
dec_dapm_widgets[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_DAC(&quot;Right DAC&quot;, &quot;C=
odec Playback&quot;, SUN4I_CODEC_DAC_ACTL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SUN4I_CODEC_DAC_ACTL_DACAENR, 0),<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* MUX */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_MUX(&quot;Capture Source&quot;, SN=
D_SOC_NOPM, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;sun4i_codec_capture_source_controls),<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mixers */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_MIXER(&quot;Left Mixer&quot;, SND_=
SOC_NOPM, 0, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sun4i_codec_left_mixer_controls,<br>
@@ -580,6 +699,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_cod=
ec_dapm_widgets[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mic Pre-Amplifiers */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_PGA(&quot;MIC1 Pre-Amplifier&quot;=
, SUN4I_CODEC_ADC_ACTL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_PGA(&quot;MIC2 Pre-Amplifier&quot;=
, SUN4I_CODEC_ADC_ACTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Power Amplifier */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_MIXER(&quot;Power Amplifier&quot;,=
 SUN4I_CODEC_ADC_ACTL,<br>
@@ -590,9 +711,15 @@ static const struct snd_soc_dapm_widget sun4i_codec_co=
dec_dapm_widgets[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;sun4i_codec_pa_mute),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_INPUT(&quot;Mic1&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_INPUT(&quot;Mic2&quot;),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_OUTPUT(&quot;HP Right&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SND_SOC_DAPM_OUTPUT(&quot;HP Left&quot;),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_INPUT(&quot;Line-In Right&quot;),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_INPUT(&quot;Line-In Left&quot;),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_INPUT(&quot;FM Right&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SND_SOC_DAPM_INPUT(&quot;FM Left&quot;),<br>
=C2=A0};<br>
<span class=3D""><br>
=C2=A0static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[=
] =3D {<br>
</span>@@ -629,6 +756,36 @@ static const struct snd_soc_dapm_route sun4i_co=
dec_codec_dapm_routes[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;Right ADC&quot;, NULL, &quot;MIC1 Pre-A=
mplifier&quot; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;MIC1 Pre-Amplifier&quot;, NULL, &quot;M=
ic1&quot;},<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;Mic1&quot;, NULL, &quo=
t;VMIC&quot; },<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Right Mixer&quot;, &quot;Mic1 Pl=
ayback Switch&quot;, &quot;MIC1 Pre-Amplifier&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Left Mixer&quot;, &quot;Mic1 Playback S=
witch&quot;, &quot;MIC1 Pre-Amplifier&quot; },<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mic2 Routes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Left ADC&quot;, NULL, &quot;MIC2 Pre-Am=
plifier&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Right ADC&quot;, NULL, &quot;MIC2 Pre-A=
mplifier&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;MIC2 Pre-Amplifier&quot;, NULL, &quot;M=
ic2&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Mic2&quot;, NULL, &quot;VMIC&quot; },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Right Mixer&quot;, &quot;Mic2 Playback =
Switch&quot;, &quot;MIC2 Pre-Amplifier&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Left Mixer&quot;, &quot;Mic2 Playback S=
witch&quot;, &quot;MIC2 Pre-Amplifier&quot; },<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Line-In, FM Routes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Right Mixer&quot;, &quot;Right Line-In =
Playback Switch&quot;, &quot;Line-In Right&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Left Mixer&quot;, &quot;Left Line-In Pl=
ayback Switch&quot;, &quot;Line-In Left&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Right Mixer&quot;, &quot;Right FM Playb=
ack Switch&quot;, &quot;FM Right&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;Left Mixer&quot;, &quot;Left FM Playbac=
k Switch&quot;, &quot;FM Left&quot; },<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ADC Capturing Sources */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Line-In&quot=
;, &quot;Line-In&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;FM&quot;, &q=
uot;FM&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic1&quot;, =
&quot;MIC1 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic2&quot;, =
&quot;MIC2 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic1,Mic2&qu=
ot;, &quot;MIC1 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic1,Mic2&qu=
ot;, &quot;MIC2 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic1+Mic2&qu=
ot;, &quot;MIC1 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Mic1+Mic2&qu=
ot;, &quot;MIC2 Pre-Amplifier&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Output Mixer=
&quot;, &quot;Left Mixer&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Output Mixer=
&quot;, &quot;Right Mixer&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Line-In,Mic1=
&quot;, &quot;Line-In&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;Capture Source&quot;, &quot;Line-In,Mic1=
&quot;, &quot;MIC1 Pre-Amplifier&quot;},<br>
=C2=A0};<br>
<br>
=C2=A0static struct snd_soc_codec_driver sun4i_codec_codec_a10 =3D {<br>
@@ -757,8 +914,25 @@ static struct snd_soc_card *sun4i_codec_create_card(st=
ruct device *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return card;<br>
=C2=A0};<br>
<br>
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, TLV_DB_SCALE_ITEM(0, 0, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A01, 7, TLV_DB_SCALE_ITEM(2400, 300, 0)<br>
+);<br>
+<br>
<span class=3D"">=C2=A0static const struct snd_kcontrol_new sun7i_codec_wid=
gets[] =3D {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 SUN4I_COMMON_CODEC_WIDGETS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Mic1 Capture Volume&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN7I_CODEC_AC_MIC_PHONE_CAL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 7,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun7i_codec_micin_preamp_gain_scale),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_SINGLE_TLV(&quot;Mic2 Capture Volume&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN7I_CODEC_AC_MIC_PHONE_CAL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 7,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sun7i_codec_micin_preamp_gain_scale),<br>
=C2=A0};<br>
<br>
=C2=A0static struct snd_soc_codec_driver sun7i_codec_codec =3D {<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi%2Bunsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux=
-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" rel=
=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/optout</a>.<b=
r>
</div></div></blockquote></div><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--089e0149c028a0c23105275e1a8b--
