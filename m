From: Dmitry Lavnikevich <D.Lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH v5 2/3] ARM: dts: pbab01: enable I2S audio on
 phyFLEX-i.MX6 boards
Date: Tue, 4 Nov 2014 11:40:32 +0000
Message-ID: <76742380-95D6-4E0C-8622-E9FA27993A42@sam-solutions.com>
References: <1414590424-25585-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1414590424-25585-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <20141103061408.GA21210@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141103061408.GA21210@tiger>
Content-Language: en-US
Content-ID: <21147BB21AF23B4987237294F68A1FEC-H6HfJ9slvY2ikuSvNLsyVV6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On 3Nov, 2014, at 09:14, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Oct 29, 2014 at 04:47:03PM +0300, Dmitry Lavnikevich wrote:
>> +		fsl,audmux-port = <4>;
>> +		fsl,port-config = <
>> +			0x00000000
>> +			IMX_AUDMUX_V2_PDCR_RXDSEL(1)
>> +		>;
>> +	};
>> +};
>> +
>> &i2c2 {
>> 	status = "okay";
>> 
>> -	tlv320@18 {
>> -		compatible = "ti,tlv320aic3x";
>> +	codec: tlv320@18 {
>> +		compatible = "ti,tlv320aic3007";
> 
> Both compatible strings are documented in
> Documentation/devicetree/bindings/sound/tlv320aic3x.txt.  But I hope
> this change will not cause any DT compatible issues.

This change is needed because unlike other tlv320aic3x-codecs tlv320aic3007 has D-class amplifier which is controlled by set of registers that in case of 3x-codecs control mono output.

I will correct patches according to other notes and soon will resend patchset.--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
