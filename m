From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: sound: add binding for pcm1792a
Date: Fri, 20 Nov 2015 08:42:45 -0600
Message-ID: <20151120144245.GA12767@rob-hp-laptop>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
 <1448014157-36526-4-git-send-email-raphael.poggi@avalun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448014157-36526-4-git-send-email-raphael.poggi@avalun.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raphael Poggi <poggi.raph@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 20, 2015 at 11:09:16AM +0100, Raphael Poggi wrote:
> From: Raphael Poggi <poggi.raph@gmail.com>
> 
> Add a binding for specify channel selection.
> 
> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/pcm1792a.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm1792a.txt
> index 970ba1e..6e87a3a 100644
> --- a/Documentation/devicetree/bindings/sound/pcm1792a.txt
> +++ b/Documentation/devicetree/bindings/sound/pcm1792a.txt
> @@ -9,10 +9,15 @@ Required properties:
>  For required properties on SPI, please consult
>  Documentation/devicetree/bindings/spi/spi-bus.txt
>  
> +Optional properties:
> +- ti,side: specifie the channel side

typo

> +  insertion, removal.

why the line wrap?

I don't understand what this property is/does. Both the name and 
description are a bit terse.

> +
>  Examples:
>  
>  	codec_spi: 1792a@0 {
>  		compatible = "ti,pcm1792a";
>  		spi-max-frequency = <600000>;
> +		ti,side = <left>
                                ^
missing ;

>  	};
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
