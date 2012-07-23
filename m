From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 16:47:07 +0530
Message-ID: <1343042227.1726.4899.camel@vkoul-udesk3>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <CABb+yY1-RyuCigCYM-dwsc1D1vSvy+QX1nunrc8G+3bT2n134g@mail.gmail.com>
 <1343039998.1726.4833.camel@vkoul-udesk3>
 <CAJe_ZhfnSkYz_zWbHTs43GtCdvisiq4xztV9xcbW6i0jj7boCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 78BC7260324
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 13:16:45 +0200 (CEST)
In-Reply-To: <CAJe_ZhfnSkYz_zWbHTs43GtCdvisiq4xztV9xcbW6i0jj7boCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-07-23 at 16:20 +0530, Jassi Brar wrote:
> >> Couldn't we employ snd_pcm_hw_params.fifo_size for the purpose ?
> > Nope, that should be used to represent the delay in samples being
> output
> > not the sample which are buffered and processed in a DSP
> >
> After leaving alsa ring buffer, don't the samples incur extra delay of
> your internal  buffer ? 
Yes they do.

And they are two types. 
a) constant delay in DMA FIFO, aptly represented by delay
b) dynamic buffering on input DMA at DSP and during post-processing.
This is before the circular DMA at output, and this patch attempts to
represent this buffering.

I guess soc_delay is not a best of name and is causing quite a churn!

-- 
~Vinod
