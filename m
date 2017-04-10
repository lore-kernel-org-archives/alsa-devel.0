From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 6/9] ASoC: add snd_soc_get_dai_id()
Date: Mon, 10 Apr 2017 14:43:56 -0500
Message-ID: <CAL_JsqLp1cg_iJ1V9bk=GW6CF5BmsqkLc04D6EcQcaFaAAL+2g@mail.gmail.com>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com>
 <87wpbthgir.wl%kuninori.morimoto.gx@renesas.com> <CAL_JsqKx9qj=ACowGapaT5hdYcevY6urLn_ntFUxAJVrzhc2AA@mail.gmail.com>
 <87h92nbdgy.wl%kuninori.morimoto.gx@renesas.com> <CAL_JsqJrcG+zczxdjjBXU17EDGANR9Exet5h5R08dStXiV9zzg@mail.gmail.com>
 <874lxx5dcd.wl%kuninori.morimoto.gx@renesas.com> <8737dh5c26.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8737dh5c26.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 9, 2017 at 7:45 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob, again
>
>> > >> > +{
>> > >> > +       struct device_node *node;
>> > >> > +       struct device_node *endpoint;
>> > >> > +       int i, id;
>> > >> > +
>> > >> > +       node = of_graph_get_port_parent(ep);
>> > >> > +
>> > >> > +       i = 0;
>> > >> > +       id = -1;
>> > >> > +       for_each_endpoint_of_node(node, endpoint) {
>> > >> > +               if (endpoint == ep)
>> > >> > +                       id = i;
>> > >>
>> > >> I don't see how this works when you have 1 DAI controller with
>> > >> multiple endpoints versus multiple DAI controllers with a single
>> > >> endpoint each. All the IDs will be 0 in the latter case.
>> > >
>> > > It support 1:1 endpoint pattern only.
>> >
>> > Then the endpoint id is always 0 and this function is pointless.
>>
>> Sorry, I checked my patch-list, and I noticed that
>> this function will be expand to use callback function in next
>> patch-set (= HDMI support).
>> Thus, inded current function is pointless at this point.
>> I will merge this expansion patch in v5
>
> 1 correction.
>
> sound graph might have multi ports (= not multi endpoint), like below.
> Each endpoints are 1:1.
>
> ports {
>         port { endpoint }; /* ID = 0 */

port@0

>         port { endpoint }; /* ID = 1 */

port@1, etc.

>         port { endpoint }; /* ID = 2 */

These ports are audio channels? If these are 3 separate data paths,
then this is correct. If you have a single data path with multiple
connections (e.g. a mux), then that should be a single port with
multiple endpoints. For example, a design that routes the same I2S
interface to HDMI and a codec and their use is mutually exclusive. I
imagine you will need to support both.

The pattern I prefer to see calling graph functions is that drivers
are specific about which port and endpoint number for a parent node
they want. Not just searching the graph for any match.

> };
>
> 1 question
>
> It will support HDMI sound feature, thus I separated
> it into OF-graph (= this patch-set) and HDMI (= next patch-set).
> Should I merge it ?

I think so if it affects the functions here. It seems better to let
the driver controlling the DAI determine the id mapping than trying to
do it in the core.

> Below is the expansion patch for HDMI support
>
> ----------------------
> Subject: [PATCH 14/63] ASoC: add .of_xlate_dai_id() callback
>
> ALSA SoC needs to know connected DAI ID for probing.
> It is not a big problem if device/driver was only for sound,
> but getting DAI ID will be difficult if device includes both
> Video/Sound, like HDMI.
> To solve this issue, this patch adds new .of_xlate_dai_id callback
> on component driver, and use it from snd_soc_get_dai_id()
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  include/sound/soc.h  |  3 +++
>  sound/soc/soc-core.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 95abbcb..0055fa0 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -14,6 +14,7 @@
>  #define __LINUX_SND_SOC_H
>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  #include <linux/notifier.h>
> @@ -793,6 +794,8 @@ struct snd_soc_component_driver {
>         int (*of_xlate_dai_name)(struct snd_soc_component *component,
>                                  struct of_phandle_args *args,
>                                  const char **dai_name);
> +       int (*of_xlate_dai_id)(struct snd_soc_component *comment,
> +                              struct device_node *endpoint);
>         void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
>                 int subseq);
>         int (*stream_event)(struct snd_soc_component *, int event);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 7a10522..07e4eec 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -4042,12 +4042,45 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
>
>  int snd_soc_get_dai_id(struct device_node *ep)
>  {
> +       struct snd_soc_component *pos;
>         struct device_node *node;
>         struct device_node *endpoint;
>         int i, id;
> +       int ret;
>
>         node = of_graph_get_port_parent(ep);
>
> +       /*
> +        * For example HDMI case, HDMI has video/sound port,
> +        * but ALSA SoC needs sound port number only.
> +        * Thus counting HDMI DT port/endpoint doesn't work.
> +        * Then, it should have .of_xlate_dai_id

Perhaps you should always require this function and provide a default
implementation (or several).

> +        */
> +       ret = -ENOTSUPP;
> +       mutex_lock(&client_mutex);
> +       list_for_each_entry(pos, &component_list, list) {
> +               struct device_node *component_of_node = pos->dev->of_node;
> +
> +               if (!component_of_node && pos->dev->parent)
> +                       component_of_node = pos->dev->parent->of_node;
> +
> +               if (component_of_node != node)
> +                       continue;
> +
> +               if (pos->driver->of_xlate_dai_id)
> +                       ret = pos->driver->of_xlate_dai_id(pos, ep);
> +
> +               break;
> +       }
> +       mutex_unlock(&client_mutex);
> +
> +       if (ret != -ENOTSUPP)
> +               return ret;
> +
> +       /*
> +        * Non HDMI sound case, counting port/endpoint on its DT
> +        * is enough. Let's count it.
> +        */
>         i = 0;
>         id = -1;
>         for_each_endpoint_of_node(node, endpoint) {
> --
> 1.9.1
>
> ----------------------
>
> Best regards
> ---
> Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
