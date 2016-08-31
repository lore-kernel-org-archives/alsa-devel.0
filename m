From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish sun4i
 from sun7i
Date: Wed, 31 Aug 2016 11:22:14 +0800
Message-ID: <CAGb2v66z-5+zHzjVp-zWEAMo0v9fykY=USTGkbSxzexJE=am2A@mail.gmail.com>
References: <20160830054403.7878-1-dannym@scratchpost.org> <20160830054403.7878-2-dannym@scratchpost.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB742TG7AKGQESFKDM6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160830054403.7878-2-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 1:44 PM, Danny Milosavljevic
<dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> This distinguishes sun4i from sun7i. It is necessary because they use
> different registers for the audio mixer.
> ---
>  sound/soc/sunxi/sun4i-codec.c | 44 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 0e19c50..30f4ea2 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -96,8 +96,9 @@
>  /* Other various ADC registers */
>  #define SUN4I_CODEC_DAC_TXCNT                  (0x30)
>  #define SUN4I_CODEC_ADC_RXCNT                  (0x34)
> -#define SUN4I_CODEC_AC_SYS_VERI                        (0x38)
> -#define SUN4I_CODEC_AC_MIC_PHONE_CAL           (0x3c)
> +
> +#define SUN7I_CODEC_AC_DAC_CAL                 (0x38)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL           (0x3c)
>
>  struct sun4i_codec {
>         struct device   *dev;
> @@ -509,10 +510,17 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>
> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> -       SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> -                      SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
> -                      sun4i_codec_pa_volume_scale),
> +#define SUN4I_COMMON_CODEC_CONTROLS \
> +       SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> +                      SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> +                      sun4i_codec_pa_volume_scale)

This is slightly worrying. It will get messy as you add more widgets.

> +
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
> +       SUN4I_COMMON_CODEC_CONTROLS,
> +};
> +
> +static const struct snd_kcontrol_new sun7i_codec_controls[] = {
> +       SUN4I_COMMON_CODEC_CONTROLS,
>  };
>
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> @@ -629,8 +637,18 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
>         .component_driver = {
> -               .controls               = sun4i_codec_widgets,
> -               .num_controls           = ARRAY_SIZE(sun4i_codec_widgets),
> +               .controls               = sun4i_codec_controls,
> +               .num_controls           = ARRAY_SIZE(sun4i_codec_controls),
> +               .dapm_widgets           = sun4i_codec_codec_dapm_widgets,
> +               .num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
> +               .dapm_routes            = sun4i_codec_codec_dapm_routes,
> +               .num_dapm_routes        = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
> +       },
> +};
> +static struct snd_soc_codec_driver sun7i_codec_codec = {
> +       .component_driver = {
> +               .controls               = sun7i_codec_controls,
> +               .num_controls           = ARRAY_SIZE(sun7i_codec_controls),
>                 .dapm_widgets           = sun4i_codec_codec_dapm_widgets,
>                 .num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
>                 .dapm_routes            = sun4i_codec_codec_dapm_routes,
> @@ -682,7 +700,7 @@ static const struct regmap_config sun4i_codec_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = SUN4I_CODEC_AC_MIC_PHONE_CAL,
> +       .max_register   = SUN7I_CODEC_AC_MIC_PHONE_CAL,
>  };

On sun4i the registers only go as far as SUN4I_CODEC_ADC_RXCNT.
Could you add a separate regmap_config as well?

>
>  static const struct of_device_id sun4i_codec_of_match[] = {
> @@ -760,6 +778,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>         struct snd_soc_card *card;
>         struct sun4i_codec *scodec;
> +       struct snd_soc_codec_driver *codec;
>         struct resource *res;
>         void __iomem *base;
>         int ret;
> @@ -822,7 +841,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>         scodec->capture_dma_data.maxburst = 4;
>         scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>
> -       ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "allwinner,sun7i-a20-codec"))
> +               codec = &sun7i_codec_codec;
> +       else
> +               codec = &sun4i_codec_codec;
> +       ret = snd_soc_register_codec(&pdev->dev, codec,

This will get reworked into something like in

https://github.com/wens/linux/commit/54a58e3087fb67572ca416256bc000e08b163480

I haven't gotten around to posting this series yet though.

ChenYu

>                                      &sun4i_codec_dai, 1);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to register our codec\n");
