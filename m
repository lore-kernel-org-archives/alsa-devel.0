From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/9] ASoC: add snd_soc_get_dai_id()
Date: Mon, 20 Mar 2017 15:20:29 -0500
Message-ID: <CAL_JsqKx9qj=ACowGapaT5hdYcevY6urLn_ntFUxAJVrzhc2AA@mail.gmail.com>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com> <87wpbthgir.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wpbthgir.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 12:53 AM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> ALSA SoC needs to know connected DAI ID for probing.
> On OF-graph case, basically we can check DT port location.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v3 -> v4
>
>  - no change
>
>  include/sound/soc.h  |  1 +
>  sound/soc/soc-core.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index cdfb55f..ab4639e 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1664,6 +1664,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>                                      const char *prefix,
>                                      struct device_node **bitclkmaster,
>                                      struct device_node **framemaster);
> +int snd_soc_get_dai_id(struct device_node *ep);
>  int snd_soc_get_dai_name(struct of_phandle_args *args,
>                          const char **dai_name);
>  int snd_soc_of_get_dai_name(struct device_node *of_node,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 175ade0..c91010d 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/ctype.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/dmi.h>
>  #include <sound/core.h>
>  #include <sound/jack.h>
> @@ -4040,6 +4041,28 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
>
> +int snd_soc_get_dai_id(struct device_node *ep)

Shouldn't the DAI id be the index of the "dais" property?

> +{
> +       struct device_node *node;
> +       struct device_node *endpoint;
> +       int i, id;
> +
> +       node = of_graph_get_port_parent(ep);
> +
> +       i = 0;
> +       id = -1;
> +       for_each_endpoint_of_node(node, endpoint) {
> +               if (endpoint == ep)
> +                       id = i;

I don't see how this works when you have 1 DAI controller with
multiple endpoints versus multiple DAI controllers with a single
endpoint each. All the IDs will be 0 in the latter case.

> +               i++;
> +       }
> +       if (id < 0)
> +               return -ENODEV;
> +
> +       return id;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_get_dai_id);
> +
>  int snd_soc_get_dai_name(struct of_phandle_args *args,
>                                 const char **dai_name)
>  {
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
