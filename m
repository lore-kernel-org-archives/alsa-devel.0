From: Jens Rottmann <JRottm-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] streamline TLV320AIC23 drivers
Date: Fri, 2 Jun 2017 23:22:05 +0200
Message-ID: <641616fb-1903-12e3-831e-4744e3ab6bfa@gmx.de>
References: <b4127646-565b-ab16-0a8f-1fd6c263389e@ADLINKtech.com>
 <20170428171115.6zc5nhspvkkgevs7@rob-hp-laptop>
 <0ea2a5f8-8af0-598d-ad49-23501176efbb@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0ea2a5f8-8af0-598d-ad49-23501176efbb-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Rob,
repeatedly got no response. Assuming all my mails got blocked, so moved to yet another account. Hope I'll get through this time.
Regards, Jens

-------- Original Message --------
Subject: Re: [PATCH] streamline TLV320AIC23 drivers
Date: Sat, 6 May 2017 00:39:20 +0200
From: Jens Rottmann <JRottm-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
To: Rob Herring
CC: Mark Rutland, Jaroslav Kysela, Takashi Iwai, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood, Mark Brown

Hi Rob,
sorry for the delay.

> On Fri, Apr 21, 2017 at 09:22:02PM +0200, Jens Rottmann wrote:
>> - Remove Eukrea naming, i.MX is from Freescale, TLV320AIC23 is from TI,
>>   driver was written by Eukrea, but it's DT capable, so it's not exclusive:
>>   - Kconfig option title
>>   - 'model' option
>>   - driver 'compatible' string
>> [...]
>> CONFIG variable and files have not been renamed, though, so no need to
>> change old defconfigs.

On 04/28/2017 19:11, Rob Herring answered:
> Perhaps change the filename. [...]

I wanted to avoid the churn, but ok. In that case:

Do you want me to change all indentifiers inside driver, too?
eukrea_tlv320_probe() --> imx_tlv320aic23_probe()

Do you want me to also rename the CONFIG var?
CONFIG_SND_SOC_EUKREA_TLV320 --> CONFIG_SND_SOC_IMX_TLV320
I'd adapt in-tree defconfigs, but would unavoidably break
out-of-tree defconfigs...

>> -  - fsl,mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
>> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
>> +  - fsl,mux-int-port	: Dito, deprecated.
>> -  - fsl,mux-ext-port	: The external port of the i.MX audio muxer.
>> +  - mux-ext-port	: The external port of the i.MX audio muxer.
>> +  - fsl,mux-ext-port	: Dito, deprecated.

> Is this used elsewhere? This is FSL specific, so you should keep the
> prefix.

.../sound/soc/fsl$ egrep 'property.*mux-(int|ext)-port' *
eukrea-tlv320.c: ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
eukrea-tlv320.c: ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
fsl-asoc-card.c: ret = of_property_read_u32(np, "mux-int-port", &int_port);
fsl-asoc-card.c: ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-es8328.c:    ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-es8328.c:    ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-sgtl5000.c:  ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-sgtl5000.c:  ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
imx-wm8962.c:    ret = of_property_read_u32(np, "mux-int-port", &int_port);
imx-wm8962.c:    ret = of_property_read_u32(np, "mux-ext-port", &ext_port);

All drivers use mux-int|ext-port without prefix, tlv320 is the only
odd driver out, that's why I did this streamlining patch in the 1st place.

I would rather not have to change all other drivers to match the tlv320 one.

Thanks,
Jens
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
