From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/9] ASoC: add snd_soc_get_dai_id()
Date: Fri, 7 Apr 2017 14:16:54 -0500
Message-ID: <CAL_JsqJrcG+zczxdjjBXU17EDGANR9Exet5h5R08dStXiV9zzg@mail.gmail.com>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com>
 <87wpbthgir.wl%kuninori.morimoto.gx@renesas.com> <CAL_JsqKx9qj=ACowGapaT5hdYcevY6urLn_ntFUxAJVrzhc2AA@mail.gmail.com>
 <87h92nbdgy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h92nbdgy.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 8:59 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob
>
> Thank you for your review
>
>> > +{
>> > +       struct device_node *node;
>> > +       struct device_node *endpoint;
>> > +       int i, id;
>> > +
>> > +       node = of_graph_get_port_parent(ep);
>> > +
>> > +       i = 0;
>> > +       id = -1;
>> > +       for_each_endpoint_of_node(node, endpoint) {
>> > +               if (endpoint == ep)
>> > +                       id = i;
>>
>> I don't see how this works when you have 1 DAI controller with
>> multiple endpoints versus multiple DAI controllers with a single
>> endpoint each. All the IDs will be 0 in the latter case.
>
> It support 1:1 endpoint pattern only.

Then the endpoint id is always 0 and this function is pointless.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
