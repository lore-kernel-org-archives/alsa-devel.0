From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: stm32: add bindings for SAI
Date: Fri, 28 Apr 2017 15:53:58 -0500
Message-ID: <20170428205358.fxjqaki44xqim4ta@rob-hp-laptop>
References: <1491837596-2924-1-git-send-email-olivier.moysan@st.com>
 <1491837596-2924-2-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491837596-2924-2-git-send-email-olivier.moysan-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 10, 2017 at 05:19:55PM +0200, olivier moysan wrote:
> This patch adds documentation of device tree bindings for the
> STM32 SAI ASoC driver.
> 
> Signed-off-by: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/st,stm32-sai.txt     | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> new file mode 100644
> index 0000000..c59a3d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> @@ -0,0 +1,89 @@
> +STMicroelectronics STM32 Serial Audio Interface (SAI).

[...]

> +	sai1b: audio-controller@40015824 {
> +		#sound-dai-cells = <0>;
> +		compatible = "st,stm32-sai-sub-b";
> +		reg = <0x40015824 0x1C>;
> +		clocks = <&rcc 1 CLK_SAI2>;
> +		clock-names = "sai_ck";
> +		dmas = <&dma2 5 0 0x400 0x0>;
> +		dma-names = "tx";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sai1b>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sai1b_port: port@0 {
> +				reg = <0>;
> +				cpu_endpoint: endpoint {
> +					remote-endpoint = <&codec_endpoint>;
> +					audio-graph-card,format = "i2s";
> +					audio-graph-card,bitclock-master = <&codec_endpoint>;
> +					audio-graph-card,frame-master = <&codec_endpoint>;

These property names are wrong.

> +				};
> +			};
> +		};
> +	};
> +};
> +
> +audio-codec {
> +	codec_port: port {
> +		codec_endpoint: endpoint {
> +			remote-endpoint = <&cpu_endpoint>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
