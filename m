From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: race condition between dmaengine_pcm_dma_complete
 and snd_pcm_release
Date: Fri, 16 Oct 2015 15:55:07 +0200
Message-ID: <562101BB.5010001@metafoo.de>
References: <CAMDowVWrLOK1Ysmfe1zTujw0Ev5PjPei1RBH8t_Mve_fsfe2ww@mail.gmail.com>	<56163123.9020106@metafoo.de>	<CAMDowVViAToVdECaJnX4ZdqgoF0rw-tQHsQW6-meWOF=CxcV4w@mail.gmail.com>
 <CAMDowVUdCJi5mrd9o40QpOAAVmQ2b4i7cmSbwOjSHq1R0WcSqw@mail.gmail.com>
 <561BA106.4090002@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 268922606BB
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 15:55:10 +0200 (CEST)
In-Reply-To: <561BA106.4090002@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Campbell <mcampbell@izotope.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Jonah Petri <jpetri@izotope.com>
List-Id: alsa-devel@alsa-project.org

On 10/12/2015 02:01 PM, Lars-Peter Clausen wrote:
> On 10/08/2015 03:46 PM, Matt Campbell wrote:
>> Hi Lars,
>>
>> Note: re-sending this message because I accidentally wasn't plain text
>> email so it got bounced from the email list (thanks GMail). Sorry for
>> the double mail to those that are CC'd.
>>
>> Thanks for the info, this felt like a limitation to the DMA engine
>> before I found this older thread so it's good to have that feeling
>> validated.
>>
>> Just for posterity I'll describe the situation I'm in with the RT
>> patch. I'm on an i.MX6 solo processor which uses the imx-sdma driver.
>> As far as I can tell, terminate_all properly shuts off the DMA (simply
>> disabling the bit in the controller). The issue I'm having is the
>> described in the following steps:
>>
>> 1) An SDMA interrupt comes in, is handled by the top half and the
>> bottom half tasklet is scheduled.
>>
>> 2) Control returns to my RT process which is higher priority than the
>> tasklet thread. My process decides it is time to shutdown and calls
>> snd_pcm_close which will terminate the DMA and deallocates everything
>> (including the substream which is the argument data to the tasklet)
>>
>> 3) With my process out of the way the dma tasklet can run. It
>> eventually calls dmaengine_pcm_dma_complete (or in my case
>> imx_pcm_dma_complete). You'll run into problems when dereferencing the
>> now invalid substream pointer.
>>
>> I have one other note about your proposed fix. In
>> dmaengine_pcm_dma_complete you can end up with xrun handling which
>> will result in a reset of the stream including calling terminate_all
>> on the DMA. I'm worried that even with an API call to the DMA system
>> to synchronize completion of DMA tasklets, you could end up with a
>> deadlock when this is called from the tasklet itself when resetting
>> the stream. I think we need to put the tasklet synchronization just
>> before snd_pcm_release is called (as you suggested in the older
>> thread). This still makes me uneasy because deadlock is still possible
>> if the tasklet takes locks that are held when snd_pcm_release is
>> called. Thanks for the input!
> 
> Yes, very good analysis. This is the reason why we can't synchronize in
> terminate_all() itself and have to introduce a separate synchronization
> primitive to the API. Most users will be fine with terminating and syncing
> at the same time, hence it makes sense to introduce a new API
> terminate_all_sync() to cover those common cases. For cases where it is not
> possible, e.g. because they either terminate the DMA from atomic context or
> they can end up calling terminate_all() from the completion callback, a new
> separate API function (e.g. dmaengine_synchronize()) will be introduced.
> Users which use the asynchronous terminate API need to call
> dmaengine_synchronize() before they free any resources that are accessed in
> either the completion callback or the memory that is accessed by the DMA itself.
> 
>> This still makes me uneasy because deadlock is still possible
>> if the tasklet takes locks that are held when snd_pcm_release is
>> called. Thanks for the input
> 
> Good point. If that can happen we properly need to reference count the
> struct that is passed to the complete callback.
> 

Thinking a bit more about this, this shouldn't be possible to happen. The
completion callback runs in atomic context, which means in can only use
spinlocks etc. On the other hand the dmaengine_synchronize() function must
not be called from atomic context, this means it can't be called while
holding a lock that can be taken from within the complete callback.
