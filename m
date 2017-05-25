From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 2/9] ASoC: sun8i-codec-analog: prepare a
 mixer control/widget/route set for V3s
Date: Thu, 25 May 2017 11:56:04 +0800
Message-ID: <CAGb2v66VWdBOgNWfVX-SZRr5mPGaKB21xu=0Y7w1iNSUb=C+ZQ@mail.gmail.com>
References: <20170524100607.29790-1-icenowy@aosc.io> <20170524100607.29790-3-icenowy@aosc.io>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBB3FLTHEQKGQEQZZB6FQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170524100607.29790-3-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 24, 2017 at 6:06 PM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
> Allwinner V3s has an analog codec without MIC2 and Line In, which will
> need a special set of mixer controls/widgets/routes, otherwise meaningless
> controls will be exported to userspace and confuse the user.
>
> Add the special set, and use it when the SoC has no MIC2 and Line In.
>
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
> New patch in v3.
>
>  sound/soc/sunxi/sun8i-codec-analog.c | 97 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
> index edcc3eb7cd9a..4c34a12b3739 100644
> --- a/sound/soc/sunxi/sun8i-codec-analog.c
> +++ b/sound/soc/sunxi/sun8i-codec-analog.c
> @@ -219,6 +219,22 @@ static const struct snd_kcontrol_new sun8i_codec_mixer_controls[] = {
>                           SUN8I_ADDA_LOMIXSC_MIC2, 1, 0),
>  };
>
> +/* mixer controls */
> +static const struct snd_kcontrol_new sun8i_v3s_codec_mixer_controls[] = {
> +       SOC_DAPM_DOUBLE_R("DAC Playback Switch",
> +                         SUN8I_ADDA_LOMIXSC,
> +                         SUN8I_ADDA_ROMIXSC,
> +                         SUN8I_ADDA_LOMIXSC_DACL, 1, 0),
> +       SOC_DAPM_DOUBLE_R("DAC Reversed Playback Switch",
> +                         SUN8I_ADDA_LOMIXSC,
> +                         SUN8I_ADDA_ROMIXSC,
> +                         SUN8I_ADDA_LOMIXSC_DACR, 1, 0),
> +       SOC_DAPM_DOUBLE_R("Mic1 Playback Switch",
> +                         SUN8I_ADDA_LOMIXSC,
> +                         SUN8I_ADDA_ROMIXSC,
> +                         SUN8I_ADDA_LOMIXSC_MIC1, 1, 0),
> +};
> +
>  /* ADC mixer controls */
>  static const struct snd_kcontrol_new sun8i_codec_adc_mixer_controls[] = {
>         SOC_DAPM_DOUBLE_R("Mixer Capture Switch",
> @@ -243,6 +259,22 @@ static const struct snd_kcontrol_new sun8i_codec_adc_mixer_controls[] = {
>                           SUN8I_ADDA_LADCMIXSC_MIC2, 1, 0),
>  };
>
> +/* ADC mixer controls */
> +static const struct snd_kcontrol_new sun8i_v3s_codec_adc_mixer_controls[] = {
> +       SOC_DAPM_DOUBLE_R("Mixer Capture Switch",
> +                         SUN8I_ADDA_LADCMIXSC,
> +                         SUN8I_ADDA_RADCMIXSC,
> +                         SUN8I_ADDA_LADCMIXSC_OMIXRL, 1, 0),
> +       SOC_DAPM_DOUBLE_R("Mixer Reversed Capture Switch",
> +                         SUN8I_ADDA_LADCMIXSC,
> +                         SUN8I_ADDA_RADCMIXSC,
> +                         SUN8I_ADDA_LADCMIXSC_OMIXRR, 1, 0),
> +       SOC_DAPM_DOUBLE_R("Mic1 Capture Switch",
> +                         SUN8I_ADDA_LADCMIXSC,
> +                         SUN8I_ADDA_RADCMIXSC,
> +                         SUN8I_ADDA_LADCMIXSC_MIC1, 1, 0),
> +};
> +
>  /* volume / mute controls */
>  static const DECLARE_TLV_DB_SCALE(sun8i_codec_out_mixer_pregain_scale,
>                                   -450, 150, 0);
> @@ -292,8 +324,9 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
>         /* Mic input path */
>         SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
>                          SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
> +};
>
> -       /* Mixers */
> +static const struct snd_soc_dapm_widget sun8i_codec_mixer_widgets[] = {
>         SND_SOC_DAPM_MIXER("Left Mixer", SUN8I_ADDA_DAC_PA_SRC,
>                            SUN8I_ADDA_DAC_PA_SRC_LMIXEN, 0,
>                            sun8i_codec_mixer_controls,
> @@ -312,10 +345,31 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
>                            ARRAY_SIZE(sun8i_codec_adc_mixer_controls)),
>  };
>
> +static const struct snd_soc_dapm_widget sun8i_v3s_codec_mixer_widgets[] = {
> +       SND_SOC_DAPM_MIXER("Left Mixer", SUN8I_ADDA_DAC_PA_SRC,
> +                          SUN8I_ADDA_DAC_PA_SRC_LMIXEN, 0,
> +                          sun8i_v3s_codec_mixer_controls,
> +                          ARRAY_SIZE(sun8i_v3s_codec_mixer_controls)),
> +       SND_SOC_DAPM_MIXER("Right Mixer", SUN8I_ADDA_DAC_PA_SRC,
> +                          SUN8I_ADDA_DAC_PA_SRC_RMIXEN, 0,
> +                          sun8i_v3s_codec_mixer_controls,
> +                          ARRAY_SIZE(sun8i_v3s_codec_mixer_controls)),
> +       SND_SOC_DAPM_MIXER("Left ADC Mixer", SUN8I_ADDA_ADC_AP_EN,
> +                          SUN8I_ADDA_ADC_AP_EN_ADCLEN, 0,
> +                          sun8i_v3s_codec_adc_mixer_controls,
> +                          ARRAY_SIZE(sun8i_v3s_codec_adc_mixer_controls)),
> +       SND_SOC_DAPM_MIXER("Right ADC Mixer", SUN8I_ADDA_ADC_AP_EN,
> +                          SUN8I_ADDA_ADC_AP_EN_ADCREN, 0,
> +                          sun8i_v3s_codec_adc_mixer_controls,
> +                          ARRAY_SIZE(sun8i_v3s_codec_adc_mixer_controls)),
> +};
> +
>  static const struct snd_soc_dapm_route sun8i_codec_common_routes[] = {
>         /* Microphone Routes */
>         { "Mic1 Amplifier", NULL, "MIC1"},
> +};
>
> +static const struct snd_soc_dapm_route sun8i_codec_mixer_routes[] = {
>         /* Left Mixer Routes */
>         { "Left Mixer", "DAC Playback Switch", "Left DAC" },
>         { "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
> @@ -714,6 +768,46 @@ static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
>         .has_mic2       = true,
>  };
>
> +static int sun8i_codec_analog_add_mixer(struct snd_soc_component *cmpnt,
> +                                       const struct sun8i_codec_analog_quirks *quirks)
> +{
> +       struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
> +       struct device *dev = cmpnt->dev;
> +       int ret;
> +
> +       if (!quirks->has_mic2 && !quirks->has_linein) {

Please leave a TODO note saying that not all special cases are handled.

> +               /*
> +                * Apply the special widget set which has uses a control
> +                * without MIC2 and Line In, for SoCs without these (V3s).
> +                */
> +               ret = snd_soc_dapm_new_controls(dapm,
> +                                               sun8i_v3s_codec_mixer_widgets,
> +                                               ARRAY_SIZE(sun8i_v3s_codec_mixer_widgets));
> +               if (ret) {
> +                       dev_err(dev, "Failed to add V3s Mixer DAPM widgets: %d\n", ret);
> +                       return ret;
> +               }
> +       } else {
> +               /* Apply the generic mixer widget set. */
> +               ret = snd_soc_dapm_new_controls(dapm,
> +                                               sun8i_codec_mixer_widgets,
> +                                               ARRAY_SIZE(sun8i_codec_mixer_widgets));
> +               if (ret) {
> +                       dev_err(dev, "Failed to add Mixer DAPM widgets: %d\n", ret);
> +                       return ret;
> +               }
> +       }

I was thinking maybe having separate probe functions saved in the quirks
structure might be better. The quirk-specific probe function would add
the mixer widget, then chain to sun8i_codec_analog_cmpnt_probe to add
the rest. That would make it harder to read though, and doesn't offer
much improvement in terms of code size.

Lets stick with what you have already.

> +
> +       ret = snd_soc_dapm_add_routes(dapm, sun8i_codec_mixer_routes,
> +                                     ARRAY_SIZE(sun8i_codec_mixer_routes));
> +       if (ret) {
> +               dev_err(dev, "Failed to add Mixer DAPM routes: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
>  {
>         struct device *dev = cmpnt->dev;
> @@ -728,6 +822,7 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
>         quirks = of_device_get_match_data(dev);
>
>         /* Add controls, widgets, and routes for individual features */
> +       sun8i_codec_analog_add_mixer(cmpnt, quirks);

You should check for errors.

Thanks
ChenYu

>
>         if (quirks->has_headphone) {
>                 ret = sun8i_codec_add_headphone(cmpnt);
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
