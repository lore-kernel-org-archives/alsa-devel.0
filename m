From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: race condition between dmaengine_pcm_dma_complete
 and snd_pcm_release
Date: Mon, 12 Oct 2015 14:01:10 +0200
Message-ID: <561BA106.4090002@metafoo.de>
References: <CAMDowVWrLOK1Ysmfe1zTujw0Ev5PjPei1RBH8t_Mve_fsfe2ww@mail.gmail.com>	<56163123.9020106@metafoo.de>	<CAMDowVViAToVdECaJnX4ZdqgoF0rw-tQHsQW6-meWOF=CxcV4w@mail.gmail.com>
 <CAMDowVUdCJi5mrd9o40QpOAAVmQ2b4i7cmSbwOjSHq1R0WcSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-070.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id DB60A2610B1
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:03:21 +0200 (CEST)
In-Reply-To: <CAMDowVUdCJi5mrd9o40QpOAAVmQ2b4i7cmSbwOjSHq1R0WcSqw@mail.gmail.com>
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

On 10/08/2015 03:46 PM, Matt Campbell wrote:
> Hi Lars,
> 
> Note: re-sending this message because I accidentally wasn't plain text
> email so it got bounced from the email list (thanks GMail). Sorry for
> the double mail to those that are CC'd.
> 
> Thanks for the info, this felt like a limitation to the DMA engine
> before I found this older thread so it's good to have that feeling
> validated.
> 
> Just for posterity I'll describe the situation I'm in with the RT
> patch. I'm on an i.MX6 solo processor which uses the imx-sdma driver.
> As far as I can tell, terminate_all properly shuts off the DMA (simply
> disabling the bit in the controller). The issue I'm having is the
> described in the following steps:
> 
> 1) An SDMA interrupt comes in, is handled by the top half and the
> bottom half tasklet is scheduled.
> 
> 2) Control returns to my RT process which is higher priority than the
> tasklet thread. My process decides it is time to shutdown and calls
> snd_pcm_close which will terminate the DMA and deallocates everything
> (including the substream which is the argument data to the tasklet)
> 
> 3) With my process out of the way the dma tasklet can run. It
> eventually calls dmaengine_pcm_dma_complete (or in my case
> imx_pcm_dma_complete). You'll run into problems when dereferencing the
> now invalid substream pointer.
> 
> I have one other note about your proposed fix. In
> dmaengine_pcm_dma_complete you can end up with xrun handling which
> will result in a reset of the stream including calling terminate_all
> on the DMA. I'm worried that even with an API call to the DMA system
> to synchronize completion of DMA tasklets, you could end up with a
> deadlock when this is called from the tasklet itself when resetting
> the stream. I think we need to put the tasklet synchronization just
> before snd_pcm_release is called (as you suggested in the older
> thread). This still makes me uneasy because deadlock is still possible
> if the tasklet takes locks that are held when snd_pcm_release is
> called. Thanks for the input!

Yes, very good analysis. This is the reason why we can't synchronize in
terminate_all() itself and have to introduce a separate synchronization
primitive to the API. Most users will be fine with terminating and syncing
at the same time, hence it makes sense to introduce a new API
terminate_all_sync() to cover those common cases. For cases where it is not
possible, e.g. because they either terminate the DMA from atomic context or
they can end up calling terminate_all() from the completion callback, a new
separate API function (e.g. dmaengine_synchronize()) will be introduced.
Users which use the asynchronous terminate API need to call
dmaengine_synchronize() before they free any resources that are accessed in
either the completion callback or the memory that is accessed by the DMA itself.

> This still makes me uneasy because deadlock is still possible
> if the tasklet takes locks that are held when snd_pcm_release is
> called. Thanks for the input

Good point. If that can happen we properly need to reference count the
struct that is passed to the complete callback.

> 
> On Thu, Oct 8, 2015 at 9:38 AM, Matt Campbell <mcampbell@izotope.com> wrote:
>> Hi Lars,
>>
>> Thanks for the info, this felt like a limitation to the DMA engine before I
>> found this older thread so it's good to have that feeling validated.
>>
>> Just for posterity I'll describe the situation I'm in with the RT patch. I'm
>> on an i.MX6 solo processor which uses the imx-sdma driver. As far as I can
>> tell, terminate_all properly shuts off the DMA (simply disabling the bit in
>> the controller). The issue I'm having is the described in the following
>> steps:
>>
>> 1) An SDMA interrupt comes in, is handled by the top half and the bottom
>> half tasklet is scheduled.
>>
>> 2) Control returns to my RT process which is higher priority than the
>> tasklet thread. My process decides it is time to shutdown and calls
>> snd_pcm_close which will terminate the DMA and deallocates everything
>> (including the substream which is the argument data to the tasklet)
>>
>> 3) With my process out of the way the dma tasklet can run. It eventually
>> calls dmaengine_pcm_dma_complete (or in my case imx_pcm_dma_complete).
>> You'll run into problems when dereferencing the now invalid substream
>> pointer.
>>
>> I have one other note about your proposed fix. In dmaengine_pcm_dma_complete
>> you can end up with xrun handling which will result in a reset of the stream
>> including calling terminate_all on the DMA. I'm worried that even with an
>> API call to the DMA system to synchronize completion of DMA tasklets, you
>> could end up with a deadlock when this is called from the tasklet itself
>> when resetting the stream. I think we need to put the tasklet
>> synchronization just before snd_pcm_release is called (as you suggested in
>> the older thread). This still makes me uneasy because deadlock is still
>> possible if the tasklet takes locks that are held when snd_pcm_release is
>> called. Thanks for the input!
>>
>> ~Matt
>>
>> On Thu, Oct 8, 2015 at 5:02 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>
>>> On 10/06/2015 11:45 PM, Matt Campbell wrote:
>>>> Hi All,
>>>>
>>>> I've been trying to track down a kernel crash I've been getting when
>>>> closing ALSA devices. There is a race condition between the bottom half
>>>> interrupt handler for the DMA system (dmaengine_pcm_dma_complete in
>>>> pcm_dmaengine.c) and the releasing of the sub-stream resources it
>>>> receives
>>>> as an argument (when snd_pcm_release is called). An older thread from
>>>> 2013
>>>> discussed this to a good extent so I wont go into the details here. I've
>>>> been unable to track down either a patch to fix this or even a good
>>>> solution that I could implement. I've spent a couple days trying to
>>>> think
>>>> of an elegant solution and come up with nothing so far. Any input would
>>>> be
>>>> appreciated.
>>>>
>>>> Link to original thread:
>>>>
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067111.html
>>>>
>>>> It's worth nothing that the original thread points out how this can
>>>> arise
>>>> on multi-core systems. In my case I'm on a single core system, but with
>>>> the
>>>> real-time patch enabled and the userspace ALSA thread running at a
>>>> higher
>>>> priority than the kernel's tasklet thread which can reproduce this
>>>> almost
>>>> 100% of the time.
>>>
>>> Hi,
>>>
>>> The answer is still the same. This is an inherent issue with the DMAengine
>>> API that needs to be fixed by adding a synchronization primitive that
>>> allows
>>> consumers to make sure that all completion tasklets have stopped running.
>>> Unfortunately this wasn't implemented yet, but I need this in other places
>>> outside of ASoC and it's on my TODO list and I'll hopefully get to it in
>>> the
>>> next 2 months.
>>>
>>> But in your case on a single CPU system it could also be an issue with the
>>> DMA controller driver itself not properly stopping the transfer when
>>> dma_terminate_all() is called.
>>>
>>> - Lars
>>>
>>
>>
>>
>> --
>> Matthew Campbell
>> Senior Embedded Systems Engineer
>> mcampbell@izotope.com
>>
>> iZotope, Inc.
>> www.izotope.com
> 
> 
> 
