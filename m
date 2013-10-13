From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: async between dmaengine_pcm_dma_complete and
	snd_pcm_release
Date: Sun, 13 Oct 2013 18:57:01 +0200
Message-ID: <525AD0DD.6070309@metafoo.de>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de> <20131010025408.GV2954@intel.com>
 <52565B5A.9020504@metafoo.de> <20131010161010.GB2954@intel.com>
 <5256E99D.1010207@metafoo.de> <20131013152403.GL2954@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id C289A261ACE
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 18:56:12 +0200 (CEST)
In-Reply-To: <20131013152403.GL2954@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Dan J Williams <dan.j.williams@intel.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 10/13/2013 05:24 PM, Vinod Koul wrote:
> On Thu, Oct 10, 2013 at 07:53:33PM +0200, Lars-Peter Clausen wrote:
>> On 10/10/2013 06:10 PM, Vinod Koul wrote:
>>> On Thu, Oct 10, 2013 at 09:46:34AM +0200, Lars-Peter Clausen wrote:
>>>
>>> + Dan
>>>
>>>> [...]
>>>>>
>>>>>>>> On the other hand that last part could get tricky as the
>>>>>>>> dmaengine_terminate_all() might be call from within the callback.
>>>>>>> It's tricky indeed in case xrun happens. we should avoid possible deadlock.
>>>>>>
>>>>>> I think we'll eventually need to versions of dmaengine_terminate_all(). A
>>>>>> sync version which makes sure that the tasklet has finished and a non-sync
>>>>>> version that only makes sure that no new callbacks are started. I think the
>>>>>> sync version should be the default with an optional async version which must
>>>>>> be used, if it can run from within the callback. So we'd call the async
>>>>>> version in the pcm_trigger callback and the sync version in the pcm_close
>>>>>> callback.
>>>>> Yes this can be done. We can name this disable_callback cmd. The cmd will tell
>>>>> dma driver to disable all callback on the channel. This can be invoked from the
>>>>> TRIGEGR_STOP and then terminate_all in the free
>>>>>
>>>>
>>>> I think we should make it the default behavior of dmaengine_terminate_all()
>>>> to wait for the tasklet to finish.
>>> No we cant since terminate can get invoked from callback itself!
>>
>> That's why I'm suggesting to introduce a
>> dmaenigne_terminate_all_async() which needs to be called in case
>>>> Since this is what almost always want,
>>>> except in this case where you might end up calling dmaeinge_terminate_all()
>>> >from within the callback. Internally this can be implemented as two separate
>>>> commands. So leave the DMA_TERMINATE_ALL as it is and add a new
>>>> DMA_SYNC_CALLBACKS (or whatever it will be named) command. This command will
>>>> internally call tasklet_kill().
>>> Implementations will have tasklet for dmaengine and not per channel. So
>>> tasklet_kill is not option!
>>
>> Most drivers actually have the tasklet per channel.
> But NOT all, so thats why we cant make this as requirement. I saw quite a few
> driver had common taklet. So this cant be ignored!
>
>>>
>>>> Then we have two new functions
>>>> dmaengine_terminate_all_async() which will just issue the DMA_TERMINATE_ALL
>>>> command, the other function is dmaengine_sync_callbacks() which will issue
>>>> the DMA_SYNC_CALLBACKS command. dmaengine_terminate_all() will then first
>>>> call dmaengine_terminate_all_async() and then dmaengine_sync_callbacks().
>>>> The ALSA code would have to be updated first to call
>>>> dmaengine_terminate_all_async() for TRIGGER_STOP and
>>>> dmaengine_sync_callbacks() on the pcm_close path.
>>> In order to avoid the complication for getting called from the callback itself,
>>> I was thinking that we tell dma driver explictly that from now on dont invoke
>>> the callbacks (we might be in callback context), then we return. DMA engine will
>>> not issue any new callbacks. And also give chance to existing callback to
>>> return.
>>> Then the client can safely call terminate_all() to abort the channel from non
>>> callback context!
>>
>> But you'll gain nothing by that. The race condition still exists.
>> You need a mechanism to to synchronize the execution of the callback
>> against dmaengine_terminate_all(). One simple way for drivers with a
>> per channel tasklet is to use tasklet_kill() for this. But other
>> possibilities also exists as well.
> No we are elimnating it. When you tell driver that you dont want it to invoke
> the callback, you give current one which maybe from callback context a chance to
> complete. So from that point no invoking callback on that channel. Disabling the channel
> interrupts will help as well.
>
> The terminate_all is gauranteed to be invoked from a non callback context. So
> driver cna handle it easily

The race we are seeing here is unrelated to terminate_all() being called from 
the callback context. The race we see here is snd_pcm_release_substream() 
racing against the callback.

The code in snd_pcm_release_substream() looks like this:

     ...
     snd_pcm_drop(substream);
     if (substream->hw_opened) {
         if (substream->ops->hw_free != NULL)
             substream->ops->hw_free(substream);
         substream->ops->close(substream);
         substream->hw_opened = 0;
     }
     ...

snd_pcm_drop() will cause the substream to stop if it is currently active. So 
this is where we call terminate_all(). In the close callback, which is called a 
few lines down, we free the data which is accessed in the callback. The race we 
see is this data being accessed in the callback after it has been freed. So the 
callback is running concurrently against this sequence in 
snd_pcm_release_substream(). Moving the position where we call terminate_all() 
in the sequence will not change anything. The callback will still be running 
concurrently against this sequence and the memory will still be used after it 
has been freed. There needs to be explicit synchronization between the callback 
and terminate_all() to solve this.

- Lars
