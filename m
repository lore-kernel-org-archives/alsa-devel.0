From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: Atmel: ClassD: add GCK's parent clock in DT binding
Date: Wed, 25 Nov 2015 17:45:24 -0600
Message-ID: <20151125234524.GA16553@rob-hp-laptop>
References: <1448270399-28728-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448270399-28728-1-git-send-email-songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 23, 2015 at 05:19:58PM +0800, Songjun Wu wrote:
> Set GCK's parent as audio clock.
> 
> Signed-off-by: Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied, thanks.

Rob

> ---
> 
>  .../devicetree/bindings/sound/atmel-classd.txt     |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
> index 0018451..549e701 100644
> --- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
> +++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
> @@ -16,6 +16,10 @@ Required properties:
>  	Required elements: "pclk", "gclk" and "aclk".
>  - clocks
>  	Please refer to clock-bindings.txt.
> +- assigned-clocks
> +	Should be <&classd_gclk>.
> +- assigned-clock-parents
> +	Should be <&audio_pll_pmc>.
>  
>  Optional properties:
>  - pinctrl-names, pinctrl-0
> @@ -43,6 +47,8 @@ classd: classd@fc048000 {
>  		dma-names = "tx";
>  		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
>  		clock-names = "pclk", "gclk", "aclk";
> +		assigned-clocks = <&classd_gclk>;
> +		assigned-clock-parents = <&audio_pll_pmc>;
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_classd_default>;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
