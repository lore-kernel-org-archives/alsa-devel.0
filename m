From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: async between dmaengine_pcm_dma_complete and
 snd_pcm_release
Date: Thu, 10 Oct 2013 21:17:40 +0530
Message-ID: <20131010154740.GZ2954@intel.com>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de> <20131010025408.GV2954@intel.com>
 <5256403E.6090803@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 7866A2619E4
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 18:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5256403E.6090803@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 10, 2013 at 01:50:54PM +0800, Qiao Zhou wrote:
> >1. In dma driver, once terminate_all in invoked, grab the lock, disable the
> >tasklet, pause/stop the dmaengine remove all the descriptors from the lists.
> >This ensures that dmaengine doesnt trigger anything new. And if it does we dont
> >call into client
> what lock do you refer to? is it "snd_pcm_stream_lock" or a new one
> in dma driver?
We are ref dma driver so it would be a dma driver lock.

> >2. If we get an interrupt or tasklet invoked after this, then it is the
> >resposiblity of dma driver to clear interrupt and return
> >
> >3. While you have invoked the terminate_all you might get a callback, in that
> >case the substream is still valid (you are still in TRIGGER_STOP). There should
> >be no harm in calling period_elapsed, but it would be good if we detect that and
> >return from here.
> >
> >4. My only worry is that during callback we drop the locks held, so callback can
> >be running on different CPU while you process the terminate all. This is very
> >racy and possibly the issue being seen in this thread. This gets complicated by
> >that fact that xrun would invoke the stop thus terminate_all.
> The timing is very racy. we have two platforms, of which the only
> difference is that one is 2 * a9 cpu, and the other is 4 * a7 cpu.
> all other components and peripherals are the same. The result is we
> can't reproduce the panic issue after more than 4 days stress test
> on 2-cpu platform, but can reproduce the issue in ~10 hours level on
> the 4-cpu platform.
The only reason I see if dma driver is NOT buggy is that you dma driver already
invoked callback and on different CPU you decided to terminate the audio and
call terminate_all

> >>>>On the other hand that last part could get tricky as the
> >>>>dmaengine_terminate_all() might be call from within the callback.
> >>>It's tricky indeed in case xrun happens. we should avoid possible deadlock.
> >>
> >>I think we'll eventually need to versions of dmaengine_terminate_all(). A
> >>sync version which makes sure that the tasklet has finished and a non-sync
> >>version that only makes sure that no new callbacks are started. I think the
> >>sync version should be the default with an optional async version which must
> >>be used, if it can run from within the callback. So we'd call the async
> >>version in the pcm_trigger callback and the sync version in the pcm_close
> >>callback.
> >Yes this can be done. We can name this disable_callback cmd. The cmd will tell
> >dma driver to disable all callback on the channel. This can be invoked from the
> >TRIGEGR_STOP and then terminate_all in the free
> >
> >Which dma driver are you guys using in this? I will send a patch for the core
> >and pcm layer. Someone need to test on actual hardware with driver fix :)
> >
> I'm using the mmp_tdma driver under /drivers/dma/, and I can test
> the patch on our 4-cpu platform. thanks.
Ok, let me check the driver and also see what needs to be done for this

--
~Vinod
