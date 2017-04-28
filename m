From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] streamline TLV320AIC23 drivers
Date: Fri, 28 Apr 2017 12:11:15 -0500
Message-ID: <20170428171115.6zc5nhspvkkgevs7@rob-hp-laptop>
References: <b4127646-565b-ab16-0a8f-1fd6c263389e@ADLINKtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b4127646-565b-ab16-0a8f-1fd6c263389e-AbX7Xxim+f4qDJ6do+/SaQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jens Rottmann <Jens.Rottmann-AbX7Xxim+f4qDJ6do+/SaQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 21, 2017 at 09:22:02PM +0200, Jens Rottmann wrote:
> The iMX-TLV320AIC23 driver isn't from Freescale, but from a company named
> Eukrea Electromatique, originally for their own boards. From the code I get
> the impression it is a bit older, its DT options use a differing naming
> scheme. Patch it up a bit:

Needs a subject following the format of the subsystem.

> 
> - Remove Eukrea naming, i.MX is from Freescale, TLV320AIC23 is from TI,
>   driver was written by Eukrea, but it's DT capable, so it's not exclusive:
>   - Kconfig option title
>   - 'model' option
>   - driver 'compatible' string
> - Other options just have changed over time, this driver remaining (one of)
>   the last with the old semantics:
>   - 'audio-codec' option (also moved from ssi node)
>   - 'mux-int/ext-port' options
> - All options stay backwards compatible, the DT binding documents new and
>   old names.
> 
> CONFIG variable and files have not been renamed, though, so no need to
> change old defconfigs.
> 
> Signed-off-by: Jens Rottmann <Jens.Rottmann-AbX7Xxim+f4qDJ6do+/SaQ@public.gmane.org>
> ---
> 
> --- a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> +++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt

Perhaps change the filename. The compatible string is a good choice.

> @@ -1,16 +1,23 @@
> -Audio complex for Eukrea boards with tlv320aic23 codec.
> +Audio complex for Freescale i.MX boards with TI TLV320AIC23 I2S codecs,
> +like those from Eukrea Electromatique.
>  
>  Required properties:
>  
> -  - compatible		: "eukrea,asoc-tlv320"
> +  - compatible		: "fsl,imx-audio-tlv320aic23" or
> +			  "eukrea,asoc-tlv320" (deprecated)
>  
> -  - eukrea,model	: The user-visible name of this sound complex.
> +  - model		: The user-visible name of this sound complex.
> +  - eukrea,model	: Dito, deprecated.
>  
>    - ssi-controller	: The phandle of the SSI controller.
>  
> -  - fsl,mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
> +  - fsl,mux-int-port	: Dito, deprecated.
>  
> -  - fsl,mux-ext-port	: The external port of the i.MX audio muxer.
> +  - mux-ext-port	: The external port of the i.MX audio muxer.
> +  - fsl,mux-ext-port	: Dito, deprecated.

Is this used elsewhere? This is FSL specific, so you should keep the 
prefix.

> +
> +  - audio-codec		: The phandle of the audio codec.
>  
>  Note: The AUDMUX port numbering should start at 1, which is consistent with
>  hardware manual.
> @@ -18,9 +25,10 @@ hardware manual.
>  Example:
>  
>  	sound {
> -		compatible = "eukrea,asoc-tlv320";
> -		eukrea,model = "imx51-eukrea-tlv320aic23";
> +		compatible = "fsl,imx-audio-tlv320aic23";
> +		model = "imx51-eukrea-tlv320aic23";
>  		ssi-controller = <&ssi2>;
> -		fsl,mux-int-port = <2>;
> -		fsl,mux-ext-port = <3>;
> +		mux-int-port = <2>;
> +		mux-ext-port = <3>;
> +		audio-codec = <&codec>;
>  	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
