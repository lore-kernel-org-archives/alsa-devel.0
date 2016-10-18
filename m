From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 20/23] ASoC: add simple-graph-card document
Date: Tue, 18 Oct 2016 10:53:31 -0500
Message-ID: <CAL_JsqJY-KtoR7C-vKBP1p3XRKkiVHBM9mzCdV3_P2DSp-xw9A@mail.gmail.com>
References: <87shrv4c8x.wl%kuninori.morimoto.gx@renesas.com> <87zim32xbo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zim32xbo.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2016 at 3:38 AM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/sound/simple-graph-card.txt           | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-graph-card.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/simple-graph-card.txt b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> new file mode 100644
> index 0000000..c191c0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> @@ -0,0 +1,65 @@
> +Simple-Graph-Card:
> +
> +Simple-Graph-Card specifies audio DAI connections of SoC <-> codec.
> +It is based on common bindings for device graphs.
> +see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> +
> +Basically, Simple-Graph-Card is same as Simple-Card, but using graph style.
> +see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +Below are same as Simple-Card.
> +
> +- simple-audio-card,name
> +- simple-audio-card,widgets
> +- simple-audio-card,routing
> +- simple-audio-card,mclk-fs
> +- simple-audio-card,hp-det-gpio
> +- simple-audio-card,mic-det-gpio
> +- simple-audio-card,format
> +- simple-audio-card,frame-master
> +- simple-audio-card,bitclock-master
> +- simple-audio-card,bitclock-inversion
> +- simple-audio-card,frame-inversion
> +- simple-audio-card,mclk-fs
> +- simple-audio-card,dai-tdm-slot-num
> +- simple-audio-card,dai-tdm-slot-width
> +- clocks / system-clock-frequency
> +
> +This Simple-Graph-Card should be located as CPU driver's port[s].
> +And then, CPU driver need to probe it by itself.
> +
> +Required properties:
> +
> +- compatible                           : "asoc-simple-graph-card";
> +- type                                 : "sound";
> +
> +Example
> +
> +ak4643: codec@12 {
> +       compatible = "asahi-kasei,ak4643";
> +       ...
> +       port {
> +               type = "sound";
> +               ak4643_port: endpoint {
> +                       remote-endpoint = <&rcar_ak4643_port>;
> +                       clocks = <&audio_clock>;

This belongs in the codec node.

> +               };
> +       };
> +};
> +
> +rcar_sound {
> +       ...
> +       port {
> +               compatible = "asoc-simple-graph-card";
> +
> +               simple-audio-card,format = "left_j";
> +               simple-audio-card,bitclock-master = <&ak4643_port>;
> +               simple-audio-card,frame-master = <&ak4643_port>;

Don't add a bunch of properties with in port and endpoint nodes. The
purpose is to describe the graph. Put these in the parent node or
perhaps the codec node.

> +               type = "sound";

I'm still not convinced this is necessary. This is implied either by
the fact there is only one port or perhaps the compatible string.

> +               rcar_ak4643_port: endpoint {
> +                       remote-endpoint = <&ak4643_port>;
> +                       playback = <&ssi0 &src2 &dvc0>;
> +                       capture  = <&ssi1 &src3 &dvc1>;
> +               };
> +       };
> +};
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
