From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: async between dmaengine_pcm_dma_complete and
 snd_pcm_release
Date: Thu, 10 Oct 2013 08:24:08 +0530
Message-ID: <20131010025408.GV2954@intel.com>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 51007261693
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 05:46:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52553738.9000200@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 09, 2013 at 01:00:08PM +0200, Lars-Peter Clausen wrote:
> Added Vinod to Cc.
> 
> On 10/09/2013 12:23 PM, Qiao Zhou wrote:
> > On 10/09/2013 04:30 PM, Lars-Peter Clausen wrote:
> >> On 10/09/2013 10:19 AM, Lars-Peter Clausen wrote:
> >>> On 10/09/2013 09:29 AM, Qiao Zhou wrote:
> >>>> Hi Mark, Liam, Jaroslav, Takashi
> >>>>
> >>>> I met an issue in which kernel panic appears in dmaengine_pcm_dma_complete
> >>>> function on a quad-core system. The dmaengine_pcm_dma_complete is running
> >>>> core0, while snd_pcm_release has already been executed on core1, due to in
> >>>> low memory stress oom killer kills the audio thread to release some memory.
> >>>>
> >>>> snd_pcm_release frees the runtime parameters, and runtime is used in
> >>>> dmaengine_pcm_dma_complete, which is a callback from tasklet in dmaengine.
> >>>> In current audio driver, we can't promise that
> >>>> dmaengine_pcm_dma_complete is
> >>>> not executed after snd_pcm_release on multi cores. Maybe we should add some
> >>>> protection. Do you have any suggestion?
> >>>>
> >>>> I have tried to apply below workaround, which can fix the panic, but I'm
> >>>> not
> >>>> confident it's proper. Need your comment and better suggestion.
> >>>
> >>> I think this is a general problem with your dmaengine driver, nothing audio
> >>> specific. If the callback is able to run after dmaengine_terminate_all() has
> >>> returned successfully there is a bug in the dmaengine driver. You need to
> > The terminate_all runs after callback, and they run just very close on
> > different cores. should soc-dmaengine add such protection anyway?
> 
> The problem is that if there is a race, that the callback races against the
> freeing of the prtd, then there is also the chance that the callback races
> against the freeing of the substream. So in that case, e.g. with your patch,
> you'd try to lock a mutex for which the memory already has been freed. So we
> need a way to synchronize against the callbacks, i.e. makes sure that non of
> the callbacks are running anymore at a given point. And only after that
> point we are allowed to free the memory that is referenced in the callback.
Okay reading thru the mail series and code:

Since we are using cyclic dma here, we will get callback based on periods. So
it is a very common case that you terminate and the callback is invoked.

Now callback can be invoked by
1) the thread terminating audio, in TRIGGER_STOP
2) in the callback context, you invoked callback which would then go and call
the period_elapsed ultimately leading to TRIGGER_STOP (xrun)

We need to take care of these conditions:

1. In dma driver, once terminate_all in invoked, grab the lock, disable the
tasklet, pause/stop the dmaengine remove all the descriptors from the lists.
This ensures that dmaengine doesnt trigger anything new. And if it does we dont
call into client

2. If we get an interrupt or tasklet invoked after this, then it is the
resposiblity of dma driver to clear interrupt and return

3. While you have invoked the terminate_all you might get a callback, in that
case the substream is still valid (you are still in TRIGGER_STOP). There should
be no harm in calling period_elapsed, but it would be good if we detect that and
return from here.

4. My only worry is that during callback we drop the locks held, so callback can
be running on different CPU while you process the terminate all. This is very
racy and possibly the issue being seen in this thread. This gets complicated by
that fact that xrun would invoke the stop thus terminate_all.

> >> On the other hand that last part could get tricky as the
> >> dmaengine_terminate_all() might be call from within the callback.
> > It's tricky indeed in case xrun happens. we should avoid possible deadlock.
> 
> I think we'll eventually need to versions of dmaengine_terminate_all(). A
> sync version which makes sure that the tasklet has finished and a non-sync
> version that only makes sure that no new callbacks are started. I think the
> sync version should be the default with an optional async version which must
> be used, if it can run from within the callback. So we'd call the async
> version in the pcm_trigger callback and the sync version in the pcm_close
> callback.
Yes this can be done. We can name this disable_callback cmd. The cmd will tell
dma driver to disable all callback on the channel. This can be invoked from the
TRIGEGR_STOP and then terminate_all in the free

Which dma driver are you guys using in this? I will send a patch for the core
and pcm layer. Someone need to test on actual hardware with driver fix :)

-- 
~Vinod
