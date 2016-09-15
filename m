From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 1/3] ASoC: sun4i-codec: rename
 "sun4i_codec_widgets" to "sun4i_codec_controls" for consistency with the
 struct field name.
Date: Thu, 15 Sep 2016 23:22:20 +0800
Message-ID: <CAGb2v64hv9eU8g42JxSLWoyw=UcRsi=WKQKh5jUwRN-DZAD=Qg@mail.gmail.com>
References: <20160915143922.4890-1-dannym@scratchpost.org> <20160915143922.4890-2-dannym@scratchpost.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBRHZ5K7AKGQEYUOOMQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160915143922.4890-2-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2016 at 10:39 PM, Danny Milosavljevic
<dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> ASoC: sun4i-codec: rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
> consistency with the struct field name.

Subject is way too long. The commit messages should be straight
forward sentences,
not in the format of patch subjects.

Subject could read "ASoC: sun4i-codec: rename sun4i_codec_widgets for
consistency".
Then in the commit message you could elaborate on consistency with what, as you
did here in the subject.

Regards
ChenYu

>
> Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 0e19c50..c2c0583 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -509,7 +509,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>
> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>         SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>                        SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
>                        sun4i_codec_pa_volume_scale),
> @@ -629,8 +629,8 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
>         .component_driver = {
> -               .controls               = sun4i_codec_widgets,
> -               .num_controls           = ARRAY_SIZE(sun4i_codec_widgets),
> +               .controls               = sun4i_codec_controls,
> +               .num_controls           = ARRAY_SIZE(sun4i_codec_controls),
>                 .dapm_widgets           = sun4i_codec_codec_dapm_widgets,
>                 .num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
>                 .dapm_routes            = sun4i_codec_codec_dapm_routes,
