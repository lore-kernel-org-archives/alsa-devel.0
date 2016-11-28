From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: erase pop noise by soft mute
Date: Mon, 28 Nov 2016 11:22:40 +0800
Message-ID: <583BA300.9030307@nuvoton.com>
References: <1473839252-18868-1-git-send-email-KCHSU0@nuvoton.com>
 <20160924191156.e6mu2vlhhaltkeua@sirena.org.uk> <57F23F44.40308@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 143D7266A1A
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 04:22:45 +0100 (CET)
In-Reply-To: <57F23F44.40308@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>, MS40 MHKuo <MHKuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

On 10/3/2016 7:21 PM, John Hsu wrote:
> On 9/25/2016 3:11 AM, Mark Brown wrote:
>> On Wed, Sep 14, 2016 at 03:47:32PM +0800, John Hsu wrote:
>>
>>  
>>> + * Enable soft mute to gradually lower DAC volume to zero;
>>> + * Soft unmute will gradually increase DAC volume to volume setting.
>>>     
>>
>>  
>>> +        regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL, 0);
>>> +        regmap_update_bits(nau8825->regmap, NAU8825_REG_MUTE_CTRL,
>>> +            NAU8825_DAC_SOFT_MUTE, NAU8825_DAC_SOFT_MUTE);
>>>     
>>
>> Why are we not just exposing soft mute as a userspace control like other
>> drivers do?  It seems like there's some weird interaction between
>> sidetones and the soft mute which this is trying to work around but
>> that's not really explained, it seems to be the main point here.
>> Basically I can't figure out what's intended here.
>>
>>   
>
> The issue only happens in the begin of playback. The amplitude of
> output signal has abnormal change in a short time and then recover
> to the level by user configuration. The amplitude change makes pop
> noise. For the reason, we use soft mute to fix the pop noise because
> the signal will output from small to normal case gradually. But the
> steps of soft mute is not enough to cover the period of amplitude
> change. Thus, we need to defer the soft mute and put the triggered
> point near the signal output. The userspace control can't catch the
> point as we wish.
>
>>> +EXPORT_SYMBOL_GPL(nau8825_soft_mute);
>>>     
>>
>> Why is this exported, how will it be used?  The function seems to be
>> called from inside this driver as well...
>>   
>
> The function is exported for the machine driver. When the platform
> stops the playback and it makes soft mute. When the playback starts,
> the playform makes soft unmute in trigger start function. The trigger
> function is the closest point of output signal, and the codec driver
> can make the soft unmute deferring as short as possible.
>
>

We want to abandon the patch under reviewing because there is another
study and solution for the pop noise. What should I do to abandon the
patch? Thank you for the advice.
