From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 11/14] ASoC: add simple-graph-card document
Date: Tue, 6 Dec 2016 09:03:21 -0600
Message-ID: <CAL_JsqLyYE_nmGfPEF_H9NxKK1HX1BbwWkUmw-PSWo6TANr5ZQ@mail.gmail.com>
References: <87k2bowckx.wl%kuninori.morimoto.gx@renesas.com>
 <874m2swcbx.wl%kuninori.morimoto.gx@renesas.com> <20161202135048.tzvrv7pzv2dubcy3@rob-hp-laptop>
 <87lgvvw92p.wl%kuninori.morimoto.gx@renesas.com> <20161205225802.ye4tcjwpjmarbfxh@rob-hp-laptop>
 <87h96hc1us.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h96hc1us.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 5, 2016 at 6:57 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob
>
>> I'd expect the top level node to be the card node that knows how to find
>> all the components. The graph should reflect the data flow. For example,
>> the data goes to audio DSP to I2S host to codec to amp.
>
> Do you mean, is this OK for OF graph ?

Yes, something like this.

> in driver point of view, "I2S" is sound card here.

Well, that seems odd to me because I2S should just be the h/w block
that interfaces to I2S/SSI signals. I'd expect you still have a card
node that references these nodes. Maybe it just references the DSP and
then you walk the graph from there to find the I2S controller and
codec.

>
> I2S {
>         port {
>                 i2s-dsp: endpoint {
>                         remote-endpoint = <&dsp>;
>                 }
>                 i2s-codec: endpoint {
>                         remote-endpoint = <&codec>;
>                 }
>         }
> }
>
> DSP {
>         port {
>                 dsp: endpoint {
>                         remote-endpoint = <&i2s-dsp>;
>                 }
>         }
> }
>
> Codec {
>         port {
>                 codec: endpoint {
>                         remote-endpoint = <&i2s-codec>;
>                 }
>         }
> }
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
