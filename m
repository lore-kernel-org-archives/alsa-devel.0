From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 4/4] dts: bcm283x.dtsi: Add analog audio/headphone jack
 for bcm2835
Date: Tue, 14 Mar 2017 09:05:54 +0100
Message-ID: <a5ae562f-6843-f137-6470-36c53cfd1799@i2se.com>
References: <20170312063820.19313-1-mzoran@crowfest.net>
 <20170312063820.19313-4-mzoran@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170312063820.19313-4-mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am 12.03.2017 um 07:38 schrieb Michael Zoran:
> Add the DT nodes for the analog audio/headphone jack for the BCM2835
>
> Signed-off-by: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 9798bc9293d8..bf2cd463a6e6 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -338,7 +338,12 @@
>  				brcm,pins = <42 43>;
>  				brcm,function = <BCM2835_FSEL_ALT5>;
>  			};
> -		};
> +
> +                        analog_audio_pins: analog_audio_pins {
> +                                brcm,pins = <40 45>;
> +                                brcm,function = <4 4>; /* Alt0 */

Please look at the other pin groups and adapt accordingly (defines, naming).

> +                        };
> +                };
>  
>  		uart0: serial@7e201000 {
>  			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
> @@ -464,6 +469,17 @@
>  			status = "disabled";
>  		};
>  
> +                analogaudio: analogaudio@7e20c000 {
> +                        compatible = "brcm,bcm2835-analog-audio";
> +                        reg = <0x7e20c000 0x28>;
> +                        clocks = <&clocks BCM2835_CLOCK_PWM>;
> +                        assigned-clocks = <&clocks BCM2835_CLOCK_PWM>;
> +                        pinctrl-names = "default";
> +                        pinctrl-0 = <&analog_audio_pins>;

This isn't future-proof. Don't define pintrl at SoC level. This should
be done on board level.

AFAIK the Raspberry Pi 3 uses pin 40 and 41.

Thanks
Stefan

> +                        dmas = <&dma 5>;
> +                        dma-names = "tx";
> +                };
> +
>  		sdhci: sdhci@7e300000 {
>  			compatible = "brcm,bcm2835-sdhci";
>  			reg = <0x7e300000 0x100>;

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
