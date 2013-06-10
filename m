From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Mon, 10 Jun 2013 12:46:52 +0200
Message-ID: <51B5AE9C.6020207@metafoo.de>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk> <51B4850C.5090508@metafoo.de>
 <51B4884D.3010904@metafoo.de> <20130610093155.GK31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-059.synserver.de (smtp-out-061.synserver.de
 [212.40.185.61])
 by alsa0.perex.cz (Postfix) with ESMTP id D82B22610A9
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 12:46:48 +0200 (CEST)
In-Reply-To: <20130610093155.GK31367@sirena.org.uk>
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

On 06/10/2013 11:31 AM, Mark Brown wrote:
> On Sun, Jun 09, 2013 at 03:51:09PM +0200, Lars-Peter Clausen wrote:
>> On 06/09/2013 03:37 PM, Lars-Peter Clausen wrote:
> 
>>> I haven't see the original patch, but the proper solution to this problem
>>> should be to add a check to snd_dmaengine_pcm_close() to see if the DMA is
>>> still running.
> 
>> Ok, since this will never happen, I suppose the problem is rather that the DMA
>> callback is called after dma_terminate_all() has been called. Which sounds like
>> it is a bug in the dmaengine driver. And this will likely also be a problem for
>> other users of that dmaengine driver and not only the ASoC driver, so it should
>> be fixed in the dmaengine driver.
> 
> Just to clarify what is it makes you say that this will never happen?

At least that is my understanding of snd_pcm_release_substream(), that it
will first make sure that the stream is stopped, by calling snd_pcm_drop(),
before closing the stream.

- Lars
