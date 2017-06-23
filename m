From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document the STM32 SPDIFRX interface
Date: Fri, 23 Jun 2017 13:55:14 -0500
Message-ID: <20170623185514.nc3jqq6ikvwwv6sn@rob-hp-laptop>
References: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
 <1497621452-615-2-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497621452-615-2-git-send-email-olivier.moysan-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 16, 2017 at 03:57:31PM +0200, olivier moysan wrote:
> This adds documentation of device tree bindings for the
> STM32 SPDIFRX interface.
> 
> Signed-off-by: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/st,stm32-spdifrx.txt | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
> new file mode 100644
> index 0000000..33826f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
> @@ -0,0 +1,56 @@
> +STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
> +
> +The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
> +IEC-60958 and IEC-61937.
> +
> +Required properties:
> +  - compatible: should be "st,stm32h7-spdifrx"
> +  - reg: cpu DAI IP base address and size
> +  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
> +  - clock-names: must contain "kclk"
> +  - interrupts: cpu DAI interrupt line
> +  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
> +    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
> +  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
> +
> +Optional properties:
> +  - resets: Reference to a reset controller asserting the SPDIFRX
> +
> +The device node should contain one 'port' child node with one child 'endpoint'
> +node, according to the bindings defined in Documentation/devicetree/bindings/
> +graph.txt.
> +
> +Example:
> +spdifrx: spdifrx@40004000 {
> +	compatible = "st,stm32h7-spdifrx";
> +	reg = <0x40004000 0x400>;
> +	clocks = <&rcc SPDIFRX_CK>;
> +	clock-names = "kclk";
> +	interrupts = <97>;
> +	dmas = <&dmamux1 2 93 0x400 0x0>,
> +	       <&dmamux1 3 94 0x400 0x0>;
> +	dma-names = "rx", "rx-ctrl";
> +	pinctrl-0 = <&spdifrx_pins>;
> +	pinctrl-names = "default";
> +
> +	spdifrx_port: port {
> +		cpu_endpoint: endpoint {
> +			remote-endpoint = <&codec_endpoint>;
> +		};
> +	};
> +};
> +
> +spdif_in: spdif-in {
> +	compatible = "linux,spdif-dir";

What is this? It should go.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
