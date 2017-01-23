From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: add simple-graph-card document
Date: Mon, 23 Jan 2017 19:14:46 +0100
Message-ID: <6e3976e8-d26c-e39e-e886-4ab00ce79d01@samsung.com>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com>
 <871svymrnt.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqLOwQn_hz3B5gFL-zr-Pm_8PX+b-sAQhLwkioD7E-ODAw@mail.gmail.com>
 <87wpdm1cyq.wl%kuninori.morimoto.gx@renesas.com>
 <CGME20170123091136epcas2p15643b17d26e629545b3848b22e1afa68@epcas2p1.samsung.com>
 <87tw8q1bct.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <87tw8q1bct.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


Hi Morimoto-san,

On 01/23/2017 08:33 AM, Kuninori Morimoto wrote:
> Hi Rob, Mark
> 
> I created OF-graph base simple sound card.
> I want to post this patch-set, but it depends many things.
> Thus, before posting patch-set, I would like to know
> OF-graph sound DT binding was OK or not.
> Can you give me comments ?
> 
> ---
>  .../bindings/sound/simple-graph-card.txt           | 140 +++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-graph-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-graph-card.txt 
> b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> new file mode 100644
> index 0000000..4b29284
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> @@ -0,0 +1,140 @@
> +Simple-Graph-Card:

This binding is likely going to cover most of existing sound system
configuration, at least it looks as it has a potential to be scalable
enough.  So perhaps we could treat is as a more generic binding and
could drop the "Simple" word now?  I'm not 100% sure it's a good idea,
but maybe we could make it "Generic Sound Card DT Binding"?

> +Simple-Graph-Card specifies audio DAI connections of SoC <-> codec.
> +It is based on common bindings for device graphs.
> +see ${LINUX}/Documentation/devicetree/bindings/graph.txt

The DT bindings should be OS agnostic, I think we should drop the 
"${LINUX}/" part here and elsewhere in this documentation.

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
> +- simple-audio-card,widgets
> +- simple-audio-card,routing
> +- simple-audio-card,mclk-fs
> +- simple-audio-card,hp-det-gpio
> +- simple-audio-card,mic-det-gpio
> +
> +Required properties:
> +
> +- compatible				: "asoc-simple-graph-card";

"asoc" is Linux related, we shouldn't be putting this in the compatible string.
Perhaps "generic-sound-card" ? Again, I'm sure if it is expected to have such
a generic kind of DT binding.

> +Optional properties:
> +
> +- dais				: Sound DAI phandle list if Card has
> +					  multi DAI. see Example
> +
> +Each ports
> +
> +- port@0				: CPU setting
> +- port@1				: Codec setting
> +
> +Example: Single DAI case
> +
> +	sound_card: sound {
> +		compatible = "asoc-simple-graph-card";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				sound0_in: endpoint {
> +					remote-endpoint = <&rsnd_port0>;
> +
> +					simple-audio-card,format = "left_j";
> +					simple-audio-card,bitclock-master = <&rsnd_port0>;
> +					simple-audio-card,frame-master = <&rsnd_port0>;
> +				};
> +			};
> +			port@1 {
> +				sound0_out: endpoint {
> +					remote-endpoint = <&ak4613_port>;
> +				};
> +			};
> +		};
> +	};

I wouldn't be making a separate case for single DAI. The 'ports' node can 
be omitted, port@0, port@1 nodes could be put under respective device nodes 
and in the 'sound' node we would have 'dais' property pointing to the CPU 
DAI port,  not the endpoint.  The endpoint is supposed to describe one of 
possible configurations of the port.  I think we want phandles to the 'port' 
nodes, not phandles to the 'endpoint' nodes in the 'sound' node.

> +Example: Multi DAI case
> +
> +	sound_dai0: sound_dai@0 {
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>; 
> +			port@0 {
> +				sound0_in: endpoint {
> +					remote-endpoint = <&rsnd_port0>;
> +
> +					simple-audio-card,format = "left_j";
> +					simple-audio-card,bitclock-master = <&rsnd_port0>;
> +					simple-audio-card,frame-master = <&rsnd_port0>;
> +				};
> +			};
> +			port@1 {
> +				sound0_out: endpoint {
> +					remote-endpoint = <&ak4613_port>;
> +				};
> +			};
> +		};
> +	};
> +
> +	sound_dai1: sound_dai@1 {
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				sound1_in: endpoint {
> +					remote-endpoint = <&rsnd_port1>;
> +
> +					simple-audio-card,format = "i2s";
> +					simple-audio-card,bitclock-master = <&rsnd_port1>;
> +					simple-audio-card,frame-master = <&rsnd_port1>;
> +				};
> +			};
> +			port@1 {
> +				sound1_out: endpoint {
> +					remote-endpoint = <&rcar_dw_hdmi0_snd_in>;
> +				};
> +			};
> +		};
> +	};

> +
> +	rsnd_ak4613: sound {
> +		compatible = "asoc-simple-graph-card";
> +
> +		dais = <&sound_dai0
> +			&sound_dai1
> +			&sound_dai2>;
> +	};

-- 
Regards,
Sylwester
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
