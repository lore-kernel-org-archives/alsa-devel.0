From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 23 Sep 2014 16:29:55 +0800
Message-ID: <CAN8ccib09wKC-GxASX4Kkh0070e7tRy5KuQER+NqS4R0wWo4XQ@mail.gmail.com>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com> <540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com> <540EC380.6030903@canonical.com>
 <540EC902.2030108@gmail.com>
 <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
 <54202219.9070102@metafoo.de> <542025F7.4000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B7A8265709
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 10:29:56 +0200 (CEST)
Received: by mail-qc0-f182.google.com with SMTP id m20so1360149qcx.13
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 01:29:56 -0700 (PDT)
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
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>>
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
>>
>> Yes. This is why we set the BATCH flag if the granularity is not
>> DMA_RESIDUE_GRANULARITY_BURST so for example pulse audio can disable
>> timer scheduling.
>

The resolution of pulseaudio volume is higher than the number of steps of
the hardware volume control, this mean any volume change by user force
pulseaudio to rewind  because of the change in software volume

As user won't expect the volume change is delayed by one second

Those drivers should not use 2 periods as graunulaity is one period which
is  170ms ~1 second if you are running video conference (e.g. Google
hangout) when video is 15~30 frames per second

The safeguard can only be decreased by reduce the period size

Is it feasible for pulseaudio to use more periods with  suitable period
size/time for the requested latency when there is one and only one client
when the sound card cannot provide precise DMA position instead of maximum
period size/time ?

>
> For the record, disabling timer-based scheduling is IMHO a matter of
further discussion. As long as there is enough safeguard, I think that
timer-based scheduling can still be used, and is useful. A living proof is
the whole story with the snd-usb-audio driver where (justified) addition of
the BATCH flag was perceived as a performance regression and not as a fix
to some real and obvious problem.

The point is some drivers use .periods_min = 1

Pulseaudio select minimum number of period

interrupt driven mode should not use one period per buffer since
granularity is one period

one period per buffer work only when sound card can report granularity
which is less than one period

aplay won't use one period per buffer , default is four but fallback to two
when driver use .periods_max = 2

http://0pointer.net/blog/projects/pulse-glitch-free.html

NFRAGS must >= 2
