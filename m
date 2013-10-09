From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: async between dmaengine_pcm_dma_complete and
	snd_pcm_release
Date: Wed, 9 Oct 2013 18:23:33 +0800
Message-ID: <52552EA5.4010109@marvell.com>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 89DAF2608D8
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 12:23:43 +0200 (CEST)
In-Reply-To: <52551416.9020004@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 10/09/2013 04:30 PM, Lars-Peter Clausen wrote:
> On 10/09/2013 10:19 AM, Lars-Peter Clausen wrote:
>> On 10/09/2013 09:29 AM, Qiao Zhou wrote:
>>> Hi Mark, Liam, Jaroslav, Takashi
>>>
>>> I met an issue in which kernel panic appears in dmaengine_pcm_dma_complete
>>> function on a quad-core system. The dmaengine_pcm_dma_complete is running
>>> core0, while snd_pcm_release has already been executed on core1, due to in
>>> low memory stress oom killer kills the audio thread to release some memory.
>>>
>>> snd_pcm_release frees the runtime parameters, and runtime is used in
>>> dmaengine_pcm_dma_complete, which is a callback from tasklet in dmaengine.
>>> In current audio driver, we can't promise that dmaengine_pcm_dma_complete is
>>> not executed after snd_pcm_release on multi cores. Maybe we should add some
>>> protection. Do you have any suggestion?
>>>
>>> I have tried to apply below workaround, which can fix the panic, but I'm not
>>> confident it's proper. Need your comment and better suggestion.
>>
>> I think this is a general problem with your dmaengine driver, nothing audio
>> specific. If the callback is able to run after dmaengine_terminate_all() has
>> returned successfully there is a bug in the dmaengine driver. You need to
The terminate_all runs after callback, and they run just very close on 
different cores. should soc-dmaengine add such protection anyway?
>> make sure that none of the callbacks is called after terminate_all() has
>> finished and you probably also have to make sure that the tasklet has
>> completed, if it is running at the same time as the call to
>> dmaengine_terminate_all().
In case the callback is executed no later than terminate_all on 
different cores, then we have to wait until the callback finishes. 
right? anything better method?
>
> On the other hand that last part could get tricky as the
> dmaengine_terminate_all() might be call from within the callback.
It's tricky indeed in case xrun happens. we should avoid possible deadlock.
>
>>
>> - Lars
>>
>>
>>>
>>>
>>>  From d568a88e8f66ee21d44324bdfb48d2a3106cf0d1 Mon Sep 17 00:00:00 2001
>>> From: Qiao Zhou <zhouqiao@marvell.com>
>>> Date: Wed, 9 Oct 2013 15:24:29 +0800
>>> Subject: [PATCH] ASoC: soc-dmaengine: add mutex to protect runtime param
>>>
>>> under SMP arch, the dmaengine_pcm_dma_complete callback has the
>>> chance to run on one cpu while at the same time, the substream is
>>> released on another cpu. thus it may access param which is already
>>> freed. we need to add mutes to protect such access, and check PCM
>>> availability before using it.
>>>
>>> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
>>> ---
>>>   sound/soc/soc-dmaengine-pcm.c |   11 ++++++++++-
>>>   1 files changed, 10 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
>>> index 111b7d9..5917029 100644
>>> --- a/sound/soc/soc-dmaengine-pcm.c
>>> +++ b/sound/soc/soc-dmaengine-pcm.c
>>> @@ -125,13 +125,22 @@ EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
>>>   static void dmaengine_pcm_dma_complete(void *arg)
>>>   {
>>>       struct snd_pcm_substream *substream = arg;
>>> -    struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
>>> +    struct dmaengine_pcm_runtime_data *prtd;
>>> +
>>> +    mutex_lock(&substream->pcm->open_mutex);
>>> +    if (!substream || !substream->runtime) {
>>> +        mutex_unlock(&substream->pcm->open_mutex);
>>> +        return;
>>> +    }
>>> +
>>> +    prtd = substream_to_prtd(substream);
>>>
>>>       prtd->pos += snd_pcm_lib_period_bytes(substream);
>>>       if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
>>>           prtd->pos = 0;
>>>
>>>       snd_pcm_period_elapsed(substream);
>>> +    mutex_unlock(&substream->pcm->open_mutex);
>>>   }
>>>
>>>   static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream
>>> *substream)
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>


-- 

Best Regards
Qiao
