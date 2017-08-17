From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add
 rockchip,codec-names property
Date: Thu, 17 Aug 2017 10:10:45 -0500
Message-ID: <20170817140945.ahakyr6vhut5zalf@rob-hp-laptop>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502340898-28403-4-git-send-email-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 10, 2017 at 12:54:58PM +0800, Jeffy Chen wrote:
> Add a new rockchip,codec-names property, so that the driver can parse
> the codecs by name.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2:
> Let rockchip,codec-names be a required property.
> 
>  Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index eac91db..05351df 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - rockchip,cpu: The phandle of the Rockchip I2S controller that's
>    connected to the codecs
>  - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
> +- rockchip,codec-names: The names of the MAX98357A/RT5514/DA7219 codecs

No, just lookup the handle and get the compatible for the codec if you 
need a name.

>  
>  Optional properties:
>  - dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> @@ -18,5 +19,6 @@ sound {
>  	compatible = "rockchip,rk3399-gru-sound";
>  	rockchip,cpu = <&i2s0>;
>  	rockchip,codec = <&max98357a &rt5514 &da7219>;
> +	rockchip,codec-names = "MAX98357A", "RT5514", "DA7219";
>  	dmic-wakeup-delay-ms = <20>;
>  };
> -- 
> 2.1.4
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
