From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: async between dmaengine_pcm_dma_complete and
	snd_pcm_release
Date: Thu, 10 Oct 2013 13:54:12 +0800
Message-ID: <52564104.9050007@marvell.com>
References: <525505C2.4070201@marvell.com> <5255119D.9020303@metafoo.de>
 <52551416.9020004@metafoo.de> <52552EA5.4010109@marvell.com>
 <52553738.9000200@metafoo.de> <5255FD3E.8040009@marvell.com>
 <20131010025625.GW2954@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA54261729
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 07:54:36 +0200 (CEST)
In-Reply-To: <20131010025625.GW2954@intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 10/10/2013 10:56 AM, Vinod Koul wrote:
> On Thu, Oct 10, 2013 at 09:05:02AM +0800, Qiao Zhou wrote:
>> On 10/09/2013 07:00 PM, Lars-Peter Clausen wrote:
>>> I think we'll eventually need to versions of dmaengine_terminate_all(). A
>>> sync version which makes sure that the tasklet has finished and a non-sync
>>> version that only makes sure that no new callbacks are started. I think the
>>> sync version should be the default with an optional async version which must
>>> be used, if it can run from within the callback. So we'd call the async
>>> version in the pcm_trigger callback and the sync version in the pcm_close
>>> callback.
>> In our current dmaengine driver, the dma interrupt is disabled in
>> terminate_all, so there is no new callback after it. This is the
>> async version. Takashi also mentions the requirement for such sync
>> version. I'll investigate the sync version more. thanks a lot.
> Your issue seems to be more on the case callback has been onvoked while the
> terminate_all in processing and after that case when sound core freed the
> pointers. If you get a new callback after the terminate_all then taht would only
> be a driver bug!
Agree. No new callback should be invoked after terminate_all.
>
> --
> ~Vinod
>


-- 

Best Regards
Qiao
