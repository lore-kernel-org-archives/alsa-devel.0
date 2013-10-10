From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: async between dmaengine_pcm_dma_complete and
	snd_pcm_release
Date: Thu, 10 Oct 2013 09:46:34 +0200
Message-ID: <52565B5A.9020504@metafoo.de>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de> <20131010025408.GV2954@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id E46672619D7
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 09:44:35 +0200 (CEST)
In-Reply-To: <20131010025408.GV2954@intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

[...]
> 
>>>> On the other hand that last part could get tricky as the
>>>> dmaengine_terminate_all() might be call from within the callback.
>>> It's tricky indeed in case xrun happens. we should avoid possible deadlock.
>>
>> I think we'll eventually need to versions of dmaengine_terminate_all(). A
>> sync version which makes sure that the tasklet has finished and a non-sync
>> version that only makes sure that no new callbacks are started. I think the
>> sync version should be the default with an optional async version which must
>> be used, if it can run from within the callback. So we'd call the async
>> version in the pcm_trigger callback and the sync version in the pcm_close
>> callback.
> Yes this can be done. We can name this disable_callback cmd. The cmd will tell
> dma driver to disable all callback on the channel. This can be invoked from the
> TRIGEGR_STOP and then terminate_all in the free
> 

I think we should make it the default behavior of dmaengine_terminate_all()
to wait for the tasklet to finish. Since this is what almost always want,
except in this case where you might end up calling dmaeinge_terminate_all()
from within the callback. Internally this can be implemented as two separate
commands. So leave the DMA_TERMINATE_ALL as it is and add a new
DMA_SYNC_CALLBACKS (or whatever it will be named) command. This command will
internally call tasklet_kill(). Then we have two new functions
dmaengine_terminate_all_async() which will just issue the DMA_TERMINATE_ALL
command, the other function is dmaengine_sync_callbacks() which will issue
the DMA_SYNC_CALLBACKS command. dmaengine_terminate_all() will then first
call dmaengine_terminate_all_async() and then dmaengine_sync_callbacks().
The ALSA code would have to be updated first to call
dmaengine_terminate_all_async() for TRIGGER_STOP and
dmaengine_sync_callbacks() on the pcm_close path.

- Lars
