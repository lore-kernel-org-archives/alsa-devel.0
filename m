From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: am335x-pepper: Fix the audio CODEC's
 reset pin
Date: Thu, 30 Nov 2017 08:18:26 -0800
Message-ID: <20171130161826.GP28152@atomide.com>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-6-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129171359.29382-6-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

* Andrew F. Davis <afd@ti.com> [171129 17:16]:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.
> 
> Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")

So it seems this and patch 8/8 are safe for me to pick separately?

Regards,

Tony

> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 03c7d77023c6..9fb7426070ce 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -139,7 +139,7 @@
>  &audio_codec {
>  	status = "okay";
>  
> -	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>  	AVDD-supply = <&ldo3_reg>;
>  	IOVDD-supply = <&ldo3_reg>;
>  	DRVDD-supply = <&ldo3_reg>;
> -- 
> 2.15.0
> 
