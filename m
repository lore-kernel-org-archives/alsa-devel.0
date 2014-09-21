From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 21 Sep 2014 10:02:57 +0800
Message-ID: <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com> <540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com> <540EC380.6030903@canonical.com>
 <540EC902.2030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A7F4261A9C
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 04:02:58 +0200 (CEST)
Received: by mail-qg0-f47.google.com with SMTP id z107so1493735qgd.6
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 19:02:57 -0700 (PDT)
In-Reply-To: <540EC902.2030108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

>>>>>
>>>>> |---------|---------P----h----p---------|-a-------|---------|
>>>>>
>>>>> So, what should alsa-lib return for snd_pcm_avail() and
>>>>> snd_pcm_rewind()?
>>>>> The driver only knows that "P" is already used, can infer that "p"
>>>>> isn't
>>>>> used yet, and knows nothing about samples in the middle.
>>>>
>>>> Indeed.  However, the DMA pointer moves asynchronously, so it is
>>>> possible
>>>> that it has already moved beyond p when snd_pcm_rewindable() returns.
>>>> For the samples between P and p, the risk is larger than for those
after
>>>> p, but p is not a boundary where the risk abruptly decreases.
>>>>
>>>> It would make sense to report the pointer update granularity, but not
>>>> to adjust the return value of snd_pcm_avail/rewindable().
>>>
>>>
>>> OK, I understand your viewpoint, and the phrase "some indicator of the
>>> actual rewind granularity and/or safeguard ... should be enough for PA
>>> to be able to pick a suitable default latency" from David indicates that
>>> he has a similar opinion.
>>>
>>> Now the remaining question is: can the proposed heuristic (minimum
>>> period size for a given sample rate, number of channels and sample
>>> format) be useful as an upper-bound approximation of the pointer update
>>> granularity for cards that are "rewindable even further than the nearest
>>> period"?
>>
>>
>> Aha, thanks for the explanation. Now I understand that approximation
idea.
>> I don't know if that's a reasonable approximation, but even if it is,
>> how would you determine if a card actually has that pointer granularity,
>> or if the pointer granularity varies with period size? (I e without
>> actually running a stream and measure it)
>
>
> Currently, as you have already said, we have no such information. This
information is, however, static for a given card model and should, in the
future, come from the kernel. Therefore:
>
> 1. We need a new flag alongside SNDRV_PCM_INFO_BATCH that kernel drivers
would set, and alsa-lib to act upon. As indicated in the following posts,
SNDRV_PCM_INFO_BATCH means a different and not-useful-here thing:
>
>
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073816.html
>
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073817.html
>
> 2. We need a volunteer to crawl through kernel sources and mark drivers
that cannot report the pointer position with a better-than-one-period
granularity.
>
> 3. Until this is done, we have to either assume that all cards are good,
or that all cards are bad, or maybe misuse the SNDRV_PCM_INFO_BATCH flag as
a pessimistic approximation of what we want (and document this
approximation) if anyone thinks that such misuse will be beneficial in the
short term.
>
> This leaves the question of "old kernel + new alsa-lib" open.
>
> --

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/soc/soc-generic-dmaengine-pcm.c?id=478028e088d6a94666d8a776be2cd2291faf3bbd

a) Set the SNDRV_PCM_INFO_BATCH if the granularity is per period or worse.
b) Fallback to the (race condition prone) period counting if the driver
does not support any residue reporting.

Seem soc already have this granularity

How can the granularity worse more than one period ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/linux/dmaengine.h

enum dma_residue_granularity {
DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
DMA_RESIDUE_GRANULARITY_BURST = 2,
};

There are three type of granularity

Does this mean the those sound card can report
DMA_RESIDUE_GRANULARITY_BURST and driver use readl in pcm pointer callback ?

A few PCI sound cards use SG buffer including hda

It seem that pulseaudio expect the driver support
DMA_RESIDUE_GRANULARITY_BURST for rewind/ timer scheduling

/**
* enum dma_residue_granularity - Granularity of the reported transfer
residue
* @DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support.
The  DMA channel is only able to tell whether a descriptor has been
completed or not, which means residue reporting is not supported by this
channel. The residue field of the dma_tx_state field will always be 0.
* @DMA_RESIDUE_GRANULARITY_SEGMENT: Residue is updated after each
successfully completed segment of the transfer (For cyclic transfers this
is after each  period). This is typically implemented by having the
hardware generate an  interrupt after each transferred segment and then the
drivers updates the outstanding residue by the size of the segment. Another
possibility is if the hardware supports scatter-gather and the segment
descriptor has a field  which gets set after the segment has been
completed. The driver then counts the number of segments without the flag
set to compute the residue.
* @DMA_RESIDUE_GRANULARITY_BURST: Residue is updated after each transferred
burst. This is typically only supported if the hardware has a progress
register of some sort (E.g. a register with the current read/write address
or a register with the amount of bursts/beats/bytes that have been
transferred or still need to be transferred).
*/
