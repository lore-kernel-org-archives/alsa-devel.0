From: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
Date: Sun, 6 Sep 2015 17:44:30 +0800
Message-ID: <55EC0AFE.3080809@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903114316.GV12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 9/3/2015 19:43, Mark Brown wrote:
> On Tue, Sep 01, 2015 at 01:41:41PM +0800, Songjun Wu wrote:
>
>> +classd: classd@fc048000 {
>> +		compatible = "atmel,sama5d2-classd";
>> +		reg = <0xfc048000 0x100>;
>> +		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
>> +		dmas = <&dma0
>> +			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
>> +			| AT91_XDMAC_DT_PERID(47))>;
>> +		dma-names = "tx";
>> +		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
>> +		clock-names = "pclk", "gclk", "aclk";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_classd_default>;
>> +		atmel,pwm-type = "diff";
>> +		atmel,non-overlap-time = <10>;
>> +};
>
>> +Example:
>> +sound {
>> +		compatible = "atmel,asoc-classd";
>> +
>> +		atmel,model = "classd @ SAMA5D2-Xplained";
>> +		atmel,audio-platform = <&classd>;
>> +		atmel,audio-cpu-dai-name = "fc048000.classd";
>> +		atmel,audio-codec = <&classd>;
>> +};
>
> Why is this a separate DT node?  It seems that this IP is entirely self
> contained so I'm not clear why we need a separate node for the card, the
> card is usually a separate node because it ties together multiple
> different devices in the system but that's not the case here.
>
The classD can finish the audio function without other devices.
But I want to reuse the code in ASoC, leave many things(like creating 
PCM, DMA operations) to ASoC, then the driver can only focus on how to 
configure classD.
The classD IP is divided to tree parts logically, platform, CPU dai,
and codec, and these parts are registered to ASoC.

This separate DT node is needed in ASoC, ties these tree parts in ClassD.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
