From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: ssm4567: Add driver for Analog
	Devices SSM4567 amplifier
Date: Fri, 26 Sep 2014 13:38:47 -0700
Message-ID: <CAOMFOmUOzO1M_1TKPommxuj9G8d42_DxQMwF7KVcK=8G022EBw@mail.gmail.com>
References: <1411747721-38619-1-git-send-email-anatol.pomozov@gmail.com>
 <54259EC9.3060109@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 912272604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 22:38:51 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id hq11so653451vcb.7
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 13:38:49 -0700 (PDT)
In-Reply-To: <54259EC9.3060109@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Sep 26, 2014 at 10:13 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/26/2014 06:08 PM, Anatol Pomozov wrote:
>>
>> Analog Devices SSM4567 is a boost class-D audio amplifier.
>>
>> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>
>
> Looks mostly okay. I also have a driver for this chip which is getting ready
> for upstream. It is a bit more complete feature wise,

D'oh I wish I knew it before start working on the driver.

> but I can rebase it  ontop of your driver.

Thanks!

>
> https://github.com/analogdevicesinc/linux/blob/asoc-ssm4329/sound/soc/codecs/ssm4567.c
>
> [...]
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index 8ab1547..da45b5a 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -94,6 +94,7 @@ config SND_SOC_ALL_CODECS
>
> [...]
>>
>> +config SND_SOC_SSM4567
>> +       tristate "Analog Devices ssm4567 amplifier driver support"
>
>
>         depends on I2C
>
>> +
>>   config SND_SOC_STA32X
>>         tristate
>>
>> diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
>> new file mode 100644
>> index 0000000..fb92248
>> --- /dev/null
>> +++ b/sound/soc/codecs/ssm4567.c
>
> [...]
>>
>> +#include <linux/gpio.h>
>> +#include <linux/of_gpio.h>
>
>
> No gpios in this driver
>
> [...]
>>
>> +
>> +static const struct snd_kcontrol_new ssm4567_snd_controls[] = {
>
> [...]
>>
>> +       SOC_SINGLE("Master Playback Switch", SSM4567_REG_DAC_CTRL, 6, 1,
>> 1),
>
>
> This one and ...
>
> [...]
>>
>> +};
>> +
>
> [...]
>>
>> +static int ssm4567_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +       struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(dai->codec);
>> +       unsigned int val;
>> +
>> +       val = mute ? SSM4567_DAC_MUTE : 0;
>> +       return regmap_update_bits(ssm4567->regmap, SSM4567_REG_DAC_CTRL,
>> +                       SSM4567_DAC_MUTE, val);
>
>
>
> ... this one control the same bit, so there will be conflicts.
>
>> +}
>> +

I've fixed the items you mentioned.

One difference I spotted between your and mine patches is that you
don't call regcache_cache_only(regmap) before powering down the
device. Is it because I2C alive in power down mode? I guess I need to
remove regcache_cache_only() then.
