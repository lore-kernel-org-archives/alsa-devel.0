From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Master Plan on rewinding
Date: Mon, 22 Sep 2014 15:20:25 +0200
Message-ID: <54202219.9070102@metafoo.de>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com> <540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com> <540EC380.6030903@canonical.com>
 <540EC902.2030108@gmail.com>
 <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-048.synserver.de
 [212.40.185.48])
 by alsa0.perex.cz (Postfix) with ESMTP id BFB5026525F
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 15:20:21 +0200 (CEST)
In-Reply-To: <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 09/21/2014 04:02 AM, Raymond Yau wrote:
[...]
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/soc/soc-generic-dmaengine-pcm.c?id=478028e088d6a94666d8a776be2cd2291faf3bbd
>
> a) Set the SNDRV_PCM_INFO_BATCH if the granularity is per period or worse.
> b) Fallback to the (race condition prone) period counting if the driver
> does not support any residue reporting.
>
> Seem soc already have this granularity
>
> How can the granularity worse more than one period ?

The granularity is the granularity that the DMA driver is able to report. In 
some cases the DMA driver is only able to tell whether a transfer has 
finished or not, but is not able tell any intermediate position. In case of 
a cyclic transfer the transfer never stops, so the DMA driver will only ever 
tell us that it hasn't finished the transfer yet. But the DMA driver will 
still generate a interrupt after every finished period. So we use this as a 
fallback mechanism and simply increase the pointer position after each 
interrupt by one period size. So userspace will never see a granularity that 
is worse than one descriptor. This is just something kernel internal.

On a side node, this period counting scheme is prone to race conditions and 
we strongly discourage new drivers from using it. Its mainly for supporting 
old DMA drivers which do not implement progress reporting (yet).

>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/linux/dmaengine.h
>
> enum dma_residue_granularity {
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
> DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
> DMA_RESIDUE_GRANULARITY_BURST = 2,
> };
>
> There are three type of granularity

Only SEGMENT and BURST granularity are relevant for audio userspace.

For ALSA we'd probably see different kind of categories of granularity 
though. E.g. one field which is the unit of the granularity

PERIOD: The granularity is a multiple of the period size
FRAME: The granularity is a multiple of the frame size
BYTE: The granularity is a fixed number of bytes
MS: The granularity is a fixed amount of time

and then a second field that has a integer number of the granularity in that 
unit.


And then there is of course the issue that for some chips you can trade 
granularity for e.g. power efficiency or similar (e.g. by changing the 
transfer burst size). And this needs to be modeled somehow as well.

>
> Does this mean the those sound card can report
> DMA_RESIDUE_GRANULARITY_BURST and driver use readl in pcm pointer callback ?
>
> A few PCI sound cards use SG buffer including hda
>
> It seem that pulseaudio expect the driver support
> DMA_RESIDUE_GRANULARITY_BURST for rewind/ timer scheduling

Yes. This is why we set the BATCH flag if the granularity is not 
DMA_RESIDUE_GRANULARITY_BURST so for example pulse audio can disable timer 
scheduling.

- Lars
