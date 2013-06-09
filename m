From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Sun, 09 Jun 2013 15:51:09 +0200
Message-ID: <51B4884D.3010904@metafoo.de>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk> <51B4850C.5090508@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id C7276261AE9
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 15:47:49 +0200 (CEST)
In-Reply-To: <51B4850C.5090508@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/09/2013 03:37 PM, Lars-Peter Clausen wrote:
> On 06/07/2013 04:34 PM, Mark Brown wrote:
>> On Fri, Jun 07, 2013 at 07:57:29PM +0800, Qiao Zhou wrote:
>>> the dmaengine_pcm_dma_complete callback is usually executed after
>>> the dma interrupt, which uses tasklet_schedule, workqueue, or other
>>> method for quick int handler return.
>>>
>>> in some corner case, where pcm stream is released unexpected, like
>>> media server is killed, the runtime parameter will be freed. if it
>>> happens between the t1 and t2 in below chart, then the callback
>>> will try to access members of paramters which is already freed,
>>> and kernel panics.
>>>
>>> to avoid this issue, add runtime checking before other handling in
>>> dmaengine_pcm_dma_complete. if pcm stream is already released,
>>> just ignore the current handling and return.
>>
>> This doesn't seem like a good or robust way of fixing this, if we're
>> tearing down the resources the DMA is using while the DMA is in progress
>> then in the worst case that might include the memory being DMAed and of
>> course there's races if you just check the pointer - the pointer can be
>> checked at the same time as it's being freed (or between the free and
>> the clear).
>>
>> I think we should be either halting the DMA or waiting for it to finish
>> here.
> 
> I haven't see the original patch, but the proper solution to this problem
> should be to add a check to snd_dmaengine_pcm_close() to see if the DMA is
> still running.

Ok, since this will never happen, I suppose the problem is rather that the DMA
callback is called after dma_terminate_all() has been called. Which sounds like
it is a bug in the dmaengine driver. And this will likely also be a problem for
other users of that dmaengine driver and not only the ASoC driver, so it should
be fixed in the dmaengine driver.

- Lars
