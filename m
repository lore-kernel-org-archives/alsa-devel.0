From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Master Plan on rewinding
Date: Mon, 22 Sep 2014 15:44:08 +0200
Message-ID: <542027A8.1060300@metafoo.de>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com> <540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com> <540EC380.6030903@canonical.com>
 <540EC902.2030108@gmail.com>
 <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
 <54202219.9070102@metafoo.de> <542025F7.4000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-048.synserver.de (smtp-out-049.synserver.de
 [212.40.185.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F765265350
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 15:44:04 +0200 (CEST)
In-Reply-To: <542025F7.4000708@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 09/22/2014 03:36 PM, Alexander E. Patrakov wrote:
> 22.09.2014 19:20, Lars-Peter Clausen wrote:
>>>
>>> Does this mean the those sound card can report
>>> DMA_RESIDUE_GRANULARITY_BURST and driver use readl in pcm pointer
>>> callback ?
>>>
>>> A few PCI sound cards use SG buffer including hda
>>>
>>> It seem that pulseaudio expect the driver support
>>> DMA_RESIDUE_GRANULARITY_BURST for rewind/ timer scheduling
>>
>> Yes. This is why we set the BATCH flag if the granularity is not
>> DMA_RESIDUE_GRANULARITY_BURST so for example pulse audio can disable
>> timer scheduling.
>
> For the record, disabling timer-based scheduling is IMHO a matter of further
> discussion. As long as there is enough safeguard, I think that timer-based
> scheduling can still be used, and is useful. A living proof is the whole
> story with the snd-usb-audio driver where (justified) addition of the BATCH
> flag was perceived as a performance regression and not as a fix to some real
> and obvious problem.
>
> I do agree that such devices need to be marked up with the BATCH flag, so
> that PulseAudio chooses reasonable hardware parameters.
>

When I tried things it looks like it was more than just the safeguard 
threshold. It looked as if the algorithm that adjusts the wake-up time gets 
confused if the granularity is not good enough and just wakes up at the 
wrong point which leads to glitches. This can probably be fixed though by 
modifying the algorithm to take the granularity into account.

- Lars
