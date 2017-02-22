From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/7] ASoC: add simple-graph-card document
Date: Wed, 22 Feb 2017 09:07:49 -0600
Message-ID: <20170222150749.pxs6gvnbvopvasu6@rob-hp-laptop>
References: <87zihq7mja.wl%kuninori.morimoto.gx@renesas.com>
 <87r3327mdo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87r3327mdo.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 13, 2017 at 04:22:54AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v1 -> v2
> 
>  - no change
> 
>  .../bindings/sound/simple-graph-card.txt           | 137 +++++++++++++++++++++

Drop the "simple". Just graph-card is enough.

>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-graph-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-graph-card.txt b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> new file mode 100644
> index 0000000..5fa7b74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> @@ -0,0 +1,137 @@
> +Simple-Graph-Card:
> +
> +Simple-Graph-Card specifies audio DAI connections of SoC <-> codec.
> +It is based on common bindings for device graphs.
> +see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> +
> +Basically, Simple-Graph-Card property is same as Simple-Card.
> +see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +Below are same as Simple-Card.
> +
> +- simple-audio-card,name
> +- simple-audio-card,format
> +- simple-audio-card,frame-master
> +- simple-audio-card,bitclock-master
> +- simple-audio-card,bitclock-inversion
> +- simple-audio-card,frame-inversion
> +- simple-audio-card,dai-tdm-slot-num
> +- simple-audio-card,dai-tdm-slot-width
> +- clocks / system-clock-frequency
> +
> +These should be implemented

What do you mean by implemented? These are new? For anything new, I 
think you should drop "simple-audio-card,".

> +- simple-audio-card,widgets
> +- simple-audio-card,routing
> +- simple-audio-card,mclk-fs
> +- simple-audio-card,hp-det-gpio
> +- simple-audio-card,mic-det-gpio

-gpios

> +
> +Required properties:
> +
> +- compatible				: "asoc-simple-graph-card";
> +- dais					: list of CPU DAI port{s}
> +
> +Example: Single DAI case
> +
> +	sound_card: sound {
> +		compatible = "asoc-simple-graph-card";
> +
> +		dais = <&cpu_port>;
> +	};
> +
> +	codec {
> +		...
> +		port {
> +			codec_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint>;
> +			};
> +		};
> +	};
> +
> +	cpu {

cpu is already a standard node name, so you need something different. 
This would be the I2S/SSI controller typically, right? Perhaps 
"dai-controller" for a standard name. 

> +		...
> +		cpu_port: port@0 {
> +			cpu_endpoint: endpoint {
> +				remote-endpoint = <&codec_endpoint>;
> +
> +				simple-audio-card,format = "left_j";
> +				simple-audio-card,bitclock-master = <&cpu_endpoint>;
> +				simple-audio-card,frame-master = <&cpu_endpoint>;

It looks silly to have a phandle to yourself. Perhaps these should be 
boolean. Define new properties if you need to.


> +				...
> +			};
> +		};
> +	};
> +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
