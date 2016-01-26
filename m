From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
Date: Tue, 26 Jan 2016 09:58:57 +0100
Message-ID: <87egd4d8dq.fsf@free-electrons.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
	<1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453588600-14831-2-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org> (Aaro
	Koskinen's message of "Sun, 24 Jan 2016 00:36:39 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Aaro,
 
 On sam., janv. 23 2016, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> wrote:

> Fix audio on kirkwood-openrd-client:
>
> 1) The audio-controller was left disabled.
>
> 2) The probe fails because cs42l51 is missing #sound-dai-cells.
>
> 	/sound/simple-audio-card,codec: could not get #sound-dai-cells for /ocp@f1000000/i2c@11000/cs42l51@4a
> 	asoc-simple-card sound: parse error -22
> 	asoc-simple-card: probe of sound failed with error -22
>
> 3) The mapping is incorrect:
>
> 	asoc-simple-card sound: cs42l51-hifi <-> spdif mapping ok
>
>    should be:
>
> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
>
> Reported-by: Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

Applied on mvebu/dt with Reviewed-by tag from Andrew Lunn and Tested-by
tag from Rick Thomas.

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/kirkwood-openrd-client.dts | 6 +++++-
>  arch/arm/boot/dts/kirkwood.dtsi              | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> index 887b9c1..96ff59d 100644
> --- a/arch/arm/boot/dts/kirkwood-openrd-client.dts
> +++ b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> @@ -20,6 +20,9 @@
>  	compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>  
>  	ocp@f1000000 {
> +		audio-controller@a0000 {
> +			status = "okay";
> +		};
>  		i2c@11000 {
>  			status = "okay";
>  			clock-frequency = <400000>;
> @@ -27,6 +30,7 @@
>  			cs42l51: cs42l51@4a {
>  				compatible = "cirrus,cs42l51";
>  				reg = <0x4a>;
> +				#sound-dai-cells = <0>;
>  			};
>  		};
>  	};
> @@ -37,7 +41,7 @@
>  		simple-audio-card,mclk-fs = <256>;
>  
>  		simple-audio-card,cpu {
> -			sound-dai = <&audio0>;
> +			sound-dai = <&audio0 0>;
>  		};
>  
>  		simple-audio-card,codec {
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7b5a4a1..7445a15 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -381,7 +381,7 @@
>  
>  		audio0: audio-controller@a0000 {
>  			compatible = "marvell,kirkwood-audio";
> -			#sound-dai-cells = <0>;
> +			#sound-dai-cells = <1>;
>  			reg = <0xa0000 0x2210>;
>  			interrupts = <24>;
>  			clocks = <&gate_clk 9>;
> -- 
> 2.4.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
