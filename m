From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [resend][PATCH v5 05/10] ASoC: simple-card-utils: enable "label"
 on asoc_simple_card_parse_card_name
Date: Mon, 17 Apr 2017 08:21:41 -0500
Message-ID: <CAL_JsqKPJ6WF08hEtx2Y7Z5WqUXQ0OBOeohEaPujX891ksZS2A@mail.gmail.com>
References: <87bmrvvqgs.wl%kuninori.morimoto.gx@renesas.com> <874lxnvqcm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874lxnvqcm.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 16, 2017 at 7:22 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Current asoc_simple_card_parse_card_name() detect [prefix]name,
> but in generally, we uses "label" for user visible names.
> This patch enables [prefix]label too.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v4 -> v5
>
>  - don't exchange simle-xxx-card side
>
>  sound/soc/generic/simple-card-utils.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 4924575..4dfd9a2 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -82,14 +82,24 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
>                                      char *prefix)
>  {
>         char prop[128];
> +       char *names[] = {
> +               "label", "name"
> +       };
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

"<prefix>label" is not a valid property name.

> +               ret = snd_soc_of_parse_card_name(card, prop);
> +               if (ret < 0)
> +                       return ret;
> +               if (card->name)
> +                       break;
> +       }
>
>         if (!card->name && card->dai_link)
>                 card->name = card->dai_link->name;
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
