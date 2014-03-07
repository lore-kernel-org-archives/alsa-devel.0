From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Fri, 7 Mar 2014 14:53:15 +0200
Message-ID: <5319C13B.4090101@ti.com>
References: <cover.1393941102.git.jsarha@ti.com> <ba9718f573ca9195c80075a15fe114e0d4557da0.1393941102.git.jsarha@ti.com> <20140305015501.GS13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140305015501.GS13126-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 03/05/2014 03:55 AM, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 03:54:49PM +0200, Jyri Sarha wrote:
>
>> +- ai31xx-micbias-vg - MicBias Voltage required.
>> +        MICBIAS_OFF - MICBIAS output it not powered
>
> Same comment as last time - why is this something which can be selected
> in the binding?
>

Fixed.

>> +        MICBIAS_2_0V - MICBIAS output is powered to 2.0V
>> +        MICBIAS_2_5V - MICBIAS output is powered to 2.5V
>> +        MICBIAS_AVDD - MICBIAS output is connected to AVDD
>
> The numbers still need to be defined in the binding, the point with the
> defines is to make both code and DTs more readable but we need to know
> what is actually going to go into the binary.
>

Numbers added.

>> +	/* Mic Bias */
>> +	SND_SOC_DAPM_SUPPLY("Mic Bias", SND_SOC_NOPM, 0, 0, mic_bias_event,
>> +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
>
> The idiomatic thing would be to use the pin name.
>

In this case the mic bias comes out of the chip trough a separate pin 
and it is up to board designer to connect it with any (or all) of the 
three mic pins.

>> +	/* Make ADC turn on when recording even if not mixed from any inputs */
>> +	{"ADC", NULL, "Internal ADC Source"},
>
> Don't do this (or the equivalent from the DACs) - we don't do this for
> any other drivers, we shouldn't do it for this one.  If we're going to
> do something like this it should be generic not per driver hacks.
>

Similar approach is used at least in wm8400.c, wm8990.c, wm8991.c, and 
in ab8500-codec.c. But I see your point. I'll roll back that change. I 
moved the clock enable/disable code to set_bias_level() to avoid 
unwanted behavior (codec clocks not turning on at playback/capture start 
if damp switches are not set correctly).

>> +	case SND_SOC_BIAS_STANDBY:
>> +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
>> +			aic31xx_set_power(codec, 1);
>> +		break;
>> +	case SND_SOC_BIAS_OFF:
>> +		aic31xx_set_power(codec, 0);
>> +		break;
>
> Just inline the set power function, or at the very least split it into
> separate on and off functions - there is zero shared code between the
> power on and off paths.
>

After adding the clock enable/disable code to set_bias_level, it started 
to look hairy when everything was inlined. I split the set_power 
function to *_on and *_off functions.

In addition to these, after rebasing on top of linux-next branch, I 
started to use use the new SOC_DOUBLE_R_S_TLV macro for the signed 
integer mixers.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
