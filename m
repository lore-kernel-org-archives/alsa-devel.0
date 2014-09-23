From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 23 Sep 2014 16:22:54 +0600
Message-ID: <542149FE.1060500@gmail.com>
References: <540C76E0.9050808@gmail.com>	<540CC53B.7080204@ladisch.de>	<540D5B46.3020904@gmail.com>	<540EBD9A.9000009@ladisch.de>	<540EC08E.4000906@gmail.com>	<540EC380.6030903@canonical.com>	<540EC902.2030108@gmail.com>	<CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>	<54202219.9070102@metafoo.de>	<542025F7.4000708@gmail.com>
 <CAN8ccib09wKC-GxASX4Kkh0070e7tRy5KuQER+NqS4R0wWo4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB16261AE4
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 12:21:31 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id b12so8461210lbj.28
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:21:29 -0700 (PDT)
In-Reply-To: <CAN8ccib09wKC-GxASX4Kkh0070e7tRy5KuQER+NqS4R0wWo4XQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

23.09.2014 14:29, Raymond Yau wrote:
>
>  >>>
>  >>>
>  >>> Does this mean the those sound card can report
>  >>> DMA_RESIDUE_GRANULARITY_BURST and driver use readl in pcm pointer
>  >>> callback ?
>  >>>
>  >>> A few PCI sound cards use SG buffer including hda
>  >>>
>  >>> It seem that pulseaudio expect the driver support
>  >>> DMA_RESIDUE_GRANULARITY_BURST for rewind/ timer scheduling
>  >>
>  >>
>  >> Yes. This is why we set the BATCH flag if the granularity is not
>  >> DMA_RESIDUE_GRANULARITY_BURST so for example pulse audio can disable
>  >> timer scheduling.
>  >
>
> The resolution of pulseaudio volume is higher than the number of steps
> of the hardware volume control, this mean any volume change by user
> force pulseaudio to rewind  because of the change in software volume
>
> As user won't expect the volume change is delayed by one second

Absolutely correct, and a similar thing was already discussed. The 
interesting part of the discussion starts here:

http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-April/020462.html

Please disregard my "factor of 1000" statement - it is no longer true.

> Those drivers should not use 2 periods as graunulaity is one period
> which is  170ms ~1 second if you are running video conference (e.g.
> Google hangout) when video is 15~30 frames per second
>
> The safeguard can only be decreased by reduce the period size

Also correct for the BATCH cards. However, please note that for the 
BATCH cards PulseAudio looks at the default-fragment-size-msec setting 
from daemon.conf by default.

> Is it feasible for pulseaudio to use more periods with  suitable period
> size/time for the requested latency when there is one and only one
> client when the sound card cannot provide precise DMA position instead
> of maximum period size/time ?

Probably not, because the rewinds are exposed in the public PulseAudio 
APIs (in particular, via the last two parameters of pa_stream_write()). 
So it definitely should not use the maximum period time, but should also 
not derive one from the client-requested latency. A hard-coded default 
or a default from the config (i.e. the current situation) is therefore 
as good as one can get on BATCH cards regarding the period size.

>
>  >
>  > For the record, disabling timer-based scheduling is IMHO a matter of
> further discussion. As long as there is enough safeguard, I think that
> timer-based scheduling can still be used, and is useful. A living proof
> is the whole story with the snd-usb-audio driver where (justified)
> addition of the BATCH flag was perceived as a performance regression and
> not as a fix to some real and obvious problem.
>
> The point is some drivers use .periods_min = 1
>
> Pulseaudio select minimum number of period

It does not do that on BATCH cards. Or if it does, it is a bug.

As for the rest of your arguments, you are just stating obvious and 
correct things, so I see no point in quoting them.

Indeed, most of the work on PulseAudio side would mean choosing the 
correct period size, number of periods, wakeup threshold and rewind 
granularity for each possible situation. I should just do it when the 
needed API appears on the ALSA side :)

-- 
Alexander E. Patrakov
