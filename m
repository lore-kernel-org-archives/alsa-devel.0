From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Question about OF-graph ports
Date: Thu, 19 Jan 2017 08:58:13 -0600
Message-ID: <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r33z4maj.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2017 at 12:07 AM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob, Mark
> and ALSA SoC ML
>
> I'm working for OF-graph base sound card support.
> Now I want to know 1 things which can't solve by myself.
> It is OF-graph ports
>
> ALSA SoC needs CPU, Codec, and Sound Card.
> If CPU <-> Card <-> Codec case, OF-graph will be
>
>         card {
>                 ports {
>                         port@0 {
>                                 card_in: endpoint {
>                                         remote-endpoint = <&cpu_out>;
>                                 };
>                         };
>                         port@1 {
>                                 card_out: endpoint {
>                                         remote-endpoint = <&codec_in>;
>                                 };
>                         };
>                 };
>         };
>
>         cpu {
>                 port {
>                         cpu_out: endpoint {
>                                 remote-endpoint = <&card_in>;
>                         };
>                 };
>         };
>
>         codec {
>                 port {
>                         codec_in: endpoint {
>                                 remote-endpoint = <&card_out>;
>                         };
>                 };
>         };
>
> This is OK.
> If CPU has many ports, then ALSA SoC requests 1 Card which has many
> DAIs (= Digital Audio Interface).
> This case, cpu will have "ports" and many "port", this is OK.
>
>         SoC.0              Codec0
>         SoC.1 <-> Card <-> Codec1
>         SoC.2              Codec2

This looks wrong to me. The card is just a container node to group
things. The card should not be the middle of the graph. There is no
data flow thru the card as it's not a hardware thing. Start with the
codec's port connected to the node controlling the audio port on the
SOC (In the simple case, that's an SSI controller) and expand the
graph from there.


> In "card", CPU/Codec pair is indicated by "ports" now
> (= port0 is CPU, port1 is Codec, etc)
>
> My question is in this case, how to know CPU/Codec pair on "card" ?

The card should only have the entry (or exit) points of the graph.
That may not even need to be graph nodes. It could just be a list of
CPU DAI phandles (which then have graph nodes).

Look at the display side use of OF graph. We have display subsystem
nodes (like a card) with a poorly named ports property (nothing to do
with OF graph) listing display channels. Each phandle there is the
entry point to the graph and is typically the front end display
controller (perhaps a CSC and scaling unit). The graph then goes to a
backend controller (for display timing), then to interface PHY
(DSI/HDMI), then possibly and external bridge chip, then to a
connector or panel node. That's a complex example. In simple cases, we
just have a display controller connected to a panel.

> Can we have *multi ports*, like this ?
>
> card {
>         ports {
>                 ports@0 {
>                         port@0 { /* SoC.0 */ };

This is not the OF graph binding, so don't do this. OF graph is
flexible enough already to describe any topology. If you feel you need
to extend it, then something is wrong.

>                         port@1 { /* Codec0*/ };
>                 };
>                 ports@1 {
>                         port@0 { /* SoC.1 */ };
>                         port@1 { /* Codec1*/ };
>                 };
>                 ports@2 {
>                         port@0 { /* SoC.2 */ };
>                         port@1 { /* Codec2*/ };
>                 };
>         };
> };
>
> Or can I use grouping, like this ?
>
> card {
>         group = <port@0 port@1>,
>                 <port@2 port@3>,
>                 <port@4 port@5>;

If it's not clear by now, the graph is supposed to define the
connections. You are defining connections here in your own custom way.

>         ports {
>                 port@0 { /* SoC.0 */ };
>                 port@1 { /* SoC.1 */ };
>                 port@2 { /* SoC.2 */ };
>                 port@3 { /* Codec0*/ };
>                 port@4 { /* Codec1*/ };
>                 port@5 { /* Codec2*/ };
>         };
> };
>
> Best regards
> ---
> Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
