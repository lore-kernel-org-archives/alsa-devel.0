From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 6/9] ASoC: simple-card-utils: enable "label" on asoc_simple_card_parse_card_name
Date: Wed, 19 Apr 2017 15:31:02 -0500
Message-ID: <CAL_JsqKEuV38kGreCm4z4aEFVRjPaBhqRbELk9W2x1UL4KpMOQ@mail.gmail.com>
References: <87o9vuxx4e.wl%kuninori.morimoto.gx@renesas.com> <87fuh6xwt1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fuh6xwt1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 17, 2017 at 9:44 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Current asoc_simple_card_parse_card_name() detect [prefix]name,
> but in generally, we uses "label" for user visible names.
> This patch enables [prefix]label too.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v5 -> v6
>
>  - used const for names[]
>
>  sound/soc/generic/simple-card-utils.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 343b291..94ceaca 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -81,15 +81,25 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
>  int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
>                                      char *prefix)
>  {
> +       char * const names[] = {
> +               "label", "name"
> +       };
>         char prop[128];
> +       int i;
>         int ret;
>
> -       snprintf(prop, sizeof(prop), "%sname", prefix);
> +       if (!prefix)
> +               prefix = "";
>
>         /* Parse the card name from DT */
> -       ret = snd_soc_of_parse_card_name(card, prop);
> -       if (ret < 0)
> -               return ret;
> +       for (i = 0; i < ARRAY_SIZE(names); i++) {
> +               snprintf(prop, sizeof(prop), "%s%s", prefix, names[i]);
> +               ret = snd_soc_of_parse_card_name(card, prop);
> +               if (ret < 0)
> +                       return ret;
> +               if (card->name)
> +                       break;
> +       }

This is still wrong as you are allowing "<prefix>label" for property
names. I think you want something like this:

ret = snd_soc_of_parse_card_name(card, "label");
if (ret < 0) {
  char prop[128];
  snprintf(prop, sizeof(prop), "%sname", prefix);
  /* Parse the card name from DT */
  ret = snd_soc_of_parse_card_name(card, prop);
  if (ret < 0)
    return ret;
}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
