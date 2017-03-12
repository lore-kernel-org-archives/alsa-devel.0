From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 6/7] ASoC: add audio-graph-card document
Date: Sun, 12 Mar 2017 06:43:55 -0500
Message-ID: <20170312114355.q2sftbljlvkvgc7j@rob-hp-laptop>
References: <87fuiwmeya.wl%kuninori.morimoto.gx@renesas.com>
 <8760jsmers.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8760jsmers.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 02, 2017 at 05:28:24AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> "Audio Graph Card" = "Simple Card" + "OF-graph"
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v2 -> v3
> 
>  - simple-graph-card -> audio-graph-card
>  - cleanup unnecessary comments
> 
>  .../devicetree/bindings/sound/audio-graph-card.txt | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> new file mode 100644
> index 0000000..81213ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> @@ -0,0 +1,126 @@
> +Audio Graph Card:
> +
> +Audio Graph Card specifies audio DAI connections of SoC <-> codec.
> +It is based on common bindings for device graphs.
> +see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> +
> +Basically, Audio Graph Card property is same as Simple Card.
> +see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +Below are same as Simple-Card.
> +
> +- audio-graph-card,name
> +- audio-graph-card,format
> +- audio-graph-card,frame-master
> +- audio-graph-card,bitclock-master
> +- audio-graph-card,bitclock-inversion
> +- audio-graph-card,frame-inversion
> +- audio-graph-card,dai-tdm-slot-num
> +- audio-graph-card,dai-tdm-slot-width

Sorry, I meant we should drop prefix ("audio-graph-card,") as these are 
common properties and don't need a vendor prefix. We generally only do 
prefixes when properties are vendor specifc and these are common. The 
"simple-audio-card,*" prefix was a bit of an odd pattern.

Though if we do drop the prefix, just 'name' and 'format' are a bit 
vague. Maybe dai-format instead of format. For name, I'm not sure how 
that gets used. Does it really need to be per port? For user visible 
names for things like identifying connectors on boards we use 'label', 
so maybe that is appropriate here.

> +- clocks / system-clock-frequency
> +
> +Required properties:
> +
> +- compatible				: "asoc-audio-graph-card";

Just audio-graph-card. asoc is a Linux term.

> +- dais					: list of CPU DAI port{s}
> +
> +Example: Single DAI case
> +
> +	sound_card {
> +		compatible = "asoc-audio-graph-card";
> +
> +		dais = <&cpu_port>;
> +	};
> +
> +	dai-controller@0 {
> +		...
> +		cpu_port: port {
> +			cpu_endpoint: endpoint {
> +				remote-endpoint = <&codec_endpoint>;
> +
> +				audio-graph-card,format = "left_j";
> +				audio-graph-card,xxx = ...
> +				...
> +			};
> +		};
> +	};
> +
> +	dai-controller@1 {
> +		...
> +		port {
> +			codec_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint>;
> +			};
> +		};
> +	};
> +
> +Example: Multi DAI case
> +
> +	sound_card {
> +		compatible = "asoc-audio-graph-card";
> +
> +		dais = <&cpu_port0
> +			&cpu_port1
> +			&cpu_port2>;
> +	};
> +
> +	dai-controller@0 {

These should be audio-codec@...

> +		...
> +		port {
> +			codec0_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint0>;
> +			};
> +		};
> +	};
> +
> +	dai-controller@1 {
> +		...
> +		port {
> +			codec1_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint1>;
> +			};
> +		};
> +	};
> +
> +	dai-controller@2 {
> +		...
> +		port {
> +			codec2_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint2>;
> +			};
> +		};
> +	};
> +
> +	dai-controller@3 {
> +		...
> +		ports {
> +			cpu_port0: port@0 {
> +				cpu_endpoint0: endpoint {
> +					remote-endpoint = <&codec0_endpoint>;
> +
> +					audio-graph-card,format = "left_j";
> +					audio-graph-card,xxx = ...
> +					...
> +				};
> +			};
> +			cpu_port1: port@1 {
> +				cpu_endpoint1: endpoint {
> +					remote-endpoint = <&codec1_endpoint>;
> +
> +					audio-graph-card,format = "i2s";
> +					audio-graph-card,xxx = ...
> +					...
> +				};
> +			};
> +			cpu_port2: port@2 {
> +				cpu_endpoint2: endpoint {
> +					remote-endpoint = <&codec2_endpoint>;
> +
> +					audio-graph-card,format = "i2s";
> +					audio-graph-card,xxx = ...
> +					...
> +				};
> +			};
> +		};
> +	};
> +
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
