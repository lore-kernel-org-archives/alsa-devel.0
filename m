From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Mon, 10 Mar 2014 10:47:15 +0200
Message-ID: <531D7C13.4050007@ti.com>
References: <cover.1393941102.git.jsarha@ti.com> <ba9718f573ca9195c80075a15fe114e0d4557da0.1393941102.git.jsarha@ti.com> <20140305015501.GS13126@sirena.org.uk> <5319C13B.4090101@ti.com> <20140309081229.GM28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140309081229.GM28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 03/09/2014 10:12 AM, Mark Brown wrote:
> On Fri, Mar 07, 2014 at 02:53:15PM +0200, Jyri Sarha wrote:
>> On 03/05/2014 03:55 AM, Mark Brown wrote:
>
>>>> +	/* Mic Bias */
>>>> +	SND_SOC_DAPM_SUPPLY("Mic Bias", SND_SOC_NOPM, 0, 0, mic_bias_event,
>>>> +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
>
>>> The idiomatic thing would be to use the pin name.
>
>> In this case the mic bias comes out of the chip trough a separate
>> pin and it is up to board designer to connect it with any (or all)
>> of the three mic pins.
>
> Yes, exactly - you should be using the name of the pin that supplies the
> bias.  This is how essentially all microphone biases work.
>

Changed widget name from "Mic Bias" to "MICBIAS".

BR,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
