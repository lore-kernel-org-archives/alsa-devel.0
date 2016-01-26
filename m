From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Mon, 25 Jan 2016 20:29:48 -0600
Message-ID: <20160126022948.GA21187@rob-hp-laptop>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453744403-12268-1-git-send-email-eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Felipe F. Tonello" <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 25, 2016 at 05:53:23PM +0000, Felipe F. Tonello wrote:
> This is the initial imx-cs427x device-tree-only machine driver working with
> fsl_ssi driver. More features can be added on top of it later.
> 
> Signed-off-by: Felipe F. Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/imx-audio-cs427x.txt |  47 +++++
>  sound/soc/fsl/Kconfig                              |  12 ++
>  sound/soc/fsl/Makefile                             |   2 +
>  sound/soc/fsl/imx-cs427x.c                         | 218 +++++++++++++++++++++
>  4 files changed, 279 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
>  create mode 100644 sound/soc/fsl/imx-cs427x.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
> new file mode 100644
> index 000000000000..295f60b19418
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
> @@ -0,0 +1,47 @@
> +Freescale i.MX audio complex with CS4271 or CS4272 codec

Do all the i.MX audio bindings really vary more that the codec? Seems 
like a lot of duplication.

> +
> +Required properties:
> +
> +  - compatible		: "fsl,imx-audio-cs427x"
> +
> +  - model		: The user-visible name of this sound complex
> +
> +  - ssi-controller	: The phandle of the i.MX SSI controller
> +
> +  - audio-codec	: The phandle of the CS4271 audio codec
> +
> +  - audio-routing	: A list of the connections between audio components.
> +			  Each entry is a pair of strings, the first being the
> +			  connection's sink, the second being the connection's
> +			  source. Valid names could be power supplies, CS427x
> +			  pins, and the jacks on the board:
> +
> +			  Board connectors:
> +			   * Mic Jack
> +			   * Headphone Jack

This should be an exact list of possible strings and valid combinations.

> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
> +
> +  - mux-ext-port	: The external port of the i.MX audio muxer
> +
> +Note: The AUDMUX port numbering should start at 1, which is consistent with
> +hardware manual.
> +
> +Example:
> +
> +sound {
> +	compatible = "fsl,imx6-rex-cs427x",
> +		"fsl,imx-audio-cs427x";
> +	model = "audio-cs427x";
> +	ssi-controller = <&ssi1>;
> +	audio-codec = <&cs4271>;
> +	audio-routing =
> +		"Mic Jack", "AINA",
> +		"Mic Jack", "AINB",
> +		"Headphone Jack", "AOUTA+",
> +		"Headphone Jack", "AOUTA-",
> +		"Headphone Jack", "AOUTB+",
> +		"Headphone Jack", "AOUTB-";
> +	mux-int-port = <1>;
> +	mux-ext-port = <3>;
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
