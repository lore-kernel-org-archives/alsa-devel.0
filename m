From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: Add support for CS35L32 Boosted
 Amplifier
Date: Tue, 05 Aug 2014 16:38:04 +0200
Message-ID: <53E0EC4C.9050700@metafoo.de>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com> <53E05458.6080605@gmail.com> <alpine.DEB.2.02.1408050928220.7394@heelrod> <53E0EB20.7040800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E0EB20.7040800-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 08/05/2014 04:33 PM, Varka Bhadram wrote:
>
> On Tuesday 05 August 2014 08:01 PM, Brian Austin wrote:
>> On Mon, 4 Aug 2014, Varka Bhadram wrote:
>>
>>> On 08/05/2014 01:41 AM, Brian Austin wrote:
>>>> +#include <linux/module.h>
>>>> +#include <linux/moduleparam.h>
>>>> +#include <linux/version.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/gpio.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +#include <linux/gpio/consumer.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/slab.h>
>>>> +#include <sound/core.h>
>>>> +#include <sound/pcm.h>
>>>> +#include <sound/pcm_params.h>
>>>> +#include <sound/soc.h>
>>>> +#include <sound/soc-dapm.h>
>>>> +#include <sound/initval.h>
>>>> +#include <sound/tlv.h>
>>>> +#include <dt-bindings/sound/cs35l32.h>
>>>> +
>>>> +#include "cs35l32.h"
>>>> +
>>> includes in alphabetical order...
>> I don't think that applies to included files outside of standard include
>> directories does it?
>>>> +{
>>>> +    struct snd_soc_codec *codec = dai->codec;
>>>> +
>>>> +    return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
>>>> +                    CS35L32_SDOUT_3ST, tristate << 3);
>>> return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
>>>                CS35L32_SDOUT_3ST, tristate << 3);
>>>
>> If that is a style issue for submission checkpatch should warn on this
>> correct?
>>
>>> should match open parenthesis's...
>>>
>>>   devm_kzalloc(&i2c_client->dev,
>>>           sizeof(struct cs35l32_platform_data),
>>>           GFP_KERNEL);
>>>
>> checkpatch?
>>
> checkpatch should generate warning for this...

Only in --subjective mode. Which is what this is, highly subjective. Some 
people prefer alignment to opening bracket, some people prefer 1 tab 
indention. Both has its advantages and disadvantages and both is usually 
fine as long as it stays consistent within the file.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
