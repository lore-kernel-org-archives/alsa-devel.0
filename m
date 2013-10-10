From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: async between dmaengine_pcm_dma_complete and
 snd_pcm_release
Date: Thu, 10 Oct 2013 08:26:25 +0530
Message-ID: <20131010025625.GW2954@intel.com>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de> <5255FD3E.8040009@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B8AB8261691
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 05:48:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5255FD3E.8040009@marvell.com>
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

On Thu, Oct 10, 2013 at 09:05:02AM +0800, Qiao Zhou wrote:
> On 10/09/2013 07:00 PM, Lars-Peter Clausen wrote:
> >I think we'll eventually need to versions of dmaengine_terminate_all(). A
> >sync version which makes sure that the tasklet has finished and a non-sync
> >version that only makes sure that no new callbacks are started. I think the
> >sync version should be the default with an optional async version which must
> >be used, if it can run from within the callback. So we'd call the async
> >version in the pcm_trigger callback and the sync version in the pcm_close
> >callback.
> In our current dmaengine driver, the dma interrupt is disabled in
> terminate_all, so there is no new callback after it. This is the
> async version. Takashi also mentions the requirement for such sync
> version. I'll investigate the sync version more. thanks a lot.
Your issue seems to be more on the case callback has been onvoked while the
terminate_all in processing and after that case when sound core freed the
pointers. If you get a new callback after the terminate_all then taht would only
be a driver bug!

--
~Vinod
