From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Fri, 14 Jun 2013 17:10:07 +0800
Message-ID: <51BADDEF.6080501@marvell.com>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk> <51B4850C.5090508@metafoo.de>
 <51B4884D.3010904@metafoo.de> <20130610093155.GK31367@sirena.org.uk>
 <51B5AE9C.6020207@metafoo.de> <20130612074337.GH4107@intel.com>
 <51B8665C.7070109@metafoo.de> <20130612143944.GF1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
 [74.125.149.205])
 by alsa0.perex.cz (Postfix) with ESMTP id C2EE5261A69
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 11:12:16 +0200 (CEST)
In-Reply-To: <20130612143944.GF1403@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/12/2013 10:39 PM, Mark Brown wrote:
> On Wed, Jun 12, 2013 at 02:15:24PM +0200, Lars-Peter Clausen wrote:
>> On 06/12/2013 09:43 AM, Vinod Koul wrote:
>
>>> Yes you need to call dmaengine_terminate_all(). But even then we might have
>>> trasaction in flight or some dma controllers cant abort immediately (need to
>>> wait till FIFOs are flushed etc). In general it is a good practice to call
>>> dma_sync_wait() before you tear down the client.
>>> If you still see an issue, then it a buggy driver :)
>
>> Even though if the driver can't abort the transfer immediately, I'd still
>> expect to not see any calls to the descriptors callback after
>> dmaengine_terminate_all() has been called.
>
> It'd certainly be much less surprising - if something's terminated it
> really oughtn't to be generating callbacks.
>
>> We should probably still call dma_sync_wait() though before we free any of
>> the DMA transfer buffers. But I guess this will open a whole new can of
>> bugs, since none of the drivers actually seem to mark a descriptor as
>> completed if the transfer is aborted using dmaengine_terminate_all()
>
> Oh joy.
>
Mark, Lars, Vinod

Indeed it's a DMA handling issue, and I'm preparing to implement a 
proper handling in DMA driver. thanks a lot for these suggestions.
-- 

Best Regards
Qiao
