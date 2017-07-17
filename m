From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add bindings for TAS6424
Date: Mon, 17 Jul 2017 15:24:55 -0500
Message-ID: <20170717202455.tgewq6kldoml6g2k@rob-hp-laptop>
References: <1500308747-27973-1-git-send-email-m-stecklein@ti.com>
 <1500308747-27973-2-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500308747-27973-2-git-send-email-m-stecklein-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Stecklein <m-stecklein-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 17, 2017 at 11:25:46AM -0500, Michael Stecklein wrote:
> Add the bindings for the TAS6424 digital amplifier.
> 
> Signed-off-by: Michael Stecklein <m-stecklein-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/ti,tas6424.txt       | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
> new file mode 100644
> index 0000000..27227b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
> @@ -0,0 +1,31 @@
> +Texas Instruments TAS6424 Quad-Channel Audio amplifier
> +
> +The TAS6424 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +	- compatible - One of: "ti,tas6424" - TAS6424
> +	- reg - I2C slave address
> +	- sound-dai-cells: must be equal to 0
> +
> +Optional properties:
> +	- pinctrl-names, pinctrl-0 - Please refer to pinctrl-bindings.txt
> +	- interrupts-extended - describe the interrupt line used to inform the
> +	  host. Please refer to interrupt-controller/interrupts.txt

There's no need for interrupts-extended here. Generally, we just 
document "interrupts" though interrupts-extended can be used instead as 
needed.

> +
> +Example:
> +
> +tas6424: tas6424@6a {
> +	#sound-dai-cells = <0>;
> +
> +	status = "okay";

Don't show status for examples.

> +
> +	compatible = "ti,tas6424";

Generally, this comes first style-wise.

> +	reg = <0x6a>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&tas6424_int_pin>;
> +	interrupts-extended = <&gpio1 28 IRQ_TYPE_EDGE_FALLING>;
> +};
> +
> +For more product information please see the link below:
> +http://www.ti.com/product/TAS6424-Q1
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
