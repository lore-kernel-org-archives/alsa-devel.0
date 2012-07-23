From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 19:07:35 +0530
Message-ID: <CAJe_Zhe6mPfL=AzSybs6TtQdGAoys5tPL0Dqa7hYLFCQpOWNZA@mail.gmail.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <CABb+yY1-RyuCigCYM-dwsc1D1vSvy+QX1nunrc8G+3bT2n134g@mail.gmail.com>
 <1343039998.1726.4833.camel@vkoul-udesk3>
 <CAJe_ZhfnSkYz_zWbHTs43GtCdvisiq4xztV9xcbW6i0jj7boCA@mail.gmail.com>
 <1343042227.1726.4899.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B60E264FFA
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 15:37:33 +0200 (CEST)
Received: by vcbf11 with SMTP id f11so4630082vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 06:37:35 -0700 (PDT)
In-Reply-To: <1343042227.1726.4899.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 23 July 2012 16:47, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-07-23 at 16:20 +0530, Jassi Brar wrote:
>> >> Couldn't we employ snd_pcm_hw_params.fifo_size for the purpose ?
>> > Nope, that should be used to represent the delay in samples being
>> output
>> > not the sample which are buffered and processed in a DSP
>> >
>> After leaving alsa ring buffer, don't the samples incur extra delay of
>> your internal  buffer ?
> Yes they do.
>
> And they are two types.
> a) constant delay in DMA FIFO, aptly represented by delay
> b) dynamic buffering on input DMA at DSP and during post-processing.
> This is before the circular DMA at output, and this patch attempts to
> represent this buffering.
>
Correct, but I think (a) and (b) are not that different.
I too might like to buy some time when the ring buffer is empty but my
I2S controller's "deep fifo" still has a few millisecs of data
'buffered'. I don't see how your scenario is  effectively different
from mine.
 And I can't see how it matters if the the "DSP buffer" is before or
after the ring-buffer. So perhaps we should abstract out any data
outside of the ring-buffer to be in "fifo" and start taking fifo_size
into account before warning XRUNs ?
