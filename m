From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: About snd_dmaengine_pcm_trigger()
Date: Wed, 05 Mar 2014 10:20:57 +0100
Message-ID: <5316EC79.4090202@metafoo.de>
References: <87eh2hql03.wl%kuninori.morimoto.gx@gmail.com>
 <5316D562.3010901@metafoo.de> <874n3dqc4j.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7B5264FF9
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 10:20:30 +0100 (CET)
In-Reply-To: <874n3dqc4j.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/05/2014 09:32 AM, Kuninori Morimoto wrote:
>
> Hi Lars
>
> Thank you for your feedback
>
>>> 3rd, our device needs special method on snd_pcm_ops
>>> int the future.
>>>
>>
>> What kind of special ops?
>
> It would like to use snd_soc_dapm_widget,
> but we can update snd_soc_component instead of platform ?

I'm not sure I fully understand what you mean, by using snd_soc_dapm_widget 
in the pcm ops.

>
>> I don't think using the snd_dmaengine_pcm helpers should be difficult,
>> since, as I said, each of them perform one very specific task. If you'd
>> directly call the dmaengine API you'd end up with pretty much the same code
>> as the dmaengine PCM helpers. What's more of a challenge would be to use the
>> generic dmaengine PCM driver.
>>
>> I think the issue with the sound/soc/sh/ code is that there never was a
>> clean separation between the DMA/PIO and the DAI configuration code. And
>> especially with rcar you seem to be reimplementing a ASoC-like framework
>> on-top of ASoC. Which makes it rather hard to reused generic code, since the
>> generic code doesn't know about all the custom hooks and callbacks. The ASoC
>> framework is not set in stone, if there is something missing to properly
>> support your hardware you should try to extend the framework to support this
>> rather than working around it in your drivers.
>
> I see...
> I need investigate more about this,
> but, before that, can I confirm ?
>
> basically...
>
> platform  : for PIO or DMA transfer method
> component : for DAI configuration = CPU side HW settings etc
>
> Is this correct ?
>

Yes.

> And about ASoC-like framework, rcar driver needs to control many kind of devices,
> and it depends on platform which device is used.
> (each devices have different feature)
> So, I used ASoC-like framework, but in this case, what should I do ?

Make them ASoC components ;) I don't know the hardware, but looking at the 
code it doesn't seem to be that different from other modern host side audio 
processing units. But one step at a time, first maybe try and see if you can 
switch over to using the dmaengine PCM helper functions. Then later thing 
about how this all can be better integrated into the ASoC framework.

- Lars
