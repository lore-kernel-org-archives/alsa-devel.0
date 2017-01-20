From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Question about OF-graph ports
Date: Fri, 20 Jan 2017 08:22:00 -0600
Message-ID: <CAL_JsqLOwQn_hz3B5gFL-zr-Pm_8PX+b-sAQhLwkioD7E-ODAw@mail.gmail.com>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com> <871svymrnt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871svymrnt.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2017 at 7:46 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob
>
> Thank you for your feedback
>
>> >         SoC.0              Codec0
>> >         SoC.1 <-> Card <-> Codec1
>> >         SoC.2              Codec2
> (snip)
>> The card should only have the entry (or exit) points of the graph.
>> That may not even need to be graph nodes. It could just be a list of
>> CPU DAI phandles (which then have graph nodes).
>>
>> Look at the display side use of OF graph. We have display subsystem
>> nodes (like a card) with a poorly named ports property (nothing to do
>> with OF graph) listing display channels. Each phandle there is the
>> entry point to the graph and is typically the front end display
>> controller (perhaps a CSC and scaling unit). The graph then goes to a
>> backend controller (for display timing), then to interface PHY
>> (DSI/HDMI), then possibly and external bridge chip, then to a
>> connector or panel node. That's a complex example. In simple cases, we
>> just have a display controller connected to a panel.
>
> If my understanding here was correct, do you mean like this ?

I need a drawing of what the hw looks like to really tell you.

>
>         sound_dai0 {
>                 ports {
>                         port { /* Card.0  */ }
>                         port { /* SoC.0  */ }
>                         port { /* Codec0 */ }

This tells me that the DAI0 h/w block has 2 inputs and 1 output or has
1 input and 2 outputs. I assume that is not what you meant.

>                 };
>         };
>
>         sound_dai1 {
>                 ports {
>                         port { /* Card.1  */ }
>                         port { /* SoC.1  */ }
>                         port { /* Codec1 */ }
>                 };
>         };
>
>         sound_dai2 {
>                 ports {
>                         port { /* Card.2  */ }
>                         port { /* SoC.2  */ }
>                         port { /* Codec2 */ }
>                 };
>         };
>
>         card {
>                 ports {
>                         port { /* sound_dai0 */ }
>                         port { /* sound_dai1 */ }
>                         port { /* sound_dai2 */ }
>                 };
>         };
>
>
> Or this ?
>
>         sound_dai0 {
>                 ports {
>                         port { /* SoC.0  */ }
>                         port { /* Codec0 */ }

This is probably closer, but I don't know what SoC.0 is. The input
should be some audio processor I guess.

>                 };
>         };
>
>         sound_dai1 {
>                 ports {
>                         port { /* SoC.1  */ }
>                         port { /* Codec1 */ }
>                 };
>         };
>
>         sound_dai2 {
>                 ports {
>                         port { /* SoC.2  */ }
>                         port { /* Codec2 */ }
>                 };
>         };
>
>         card {
>                 dais = <&sound_dai0
>                         &sound_dai1
>                         &sound_dai2>;
>         };
>
>
> Best regards
> ---
> Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
