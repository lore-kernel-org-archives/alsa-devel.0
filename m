From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 22 Sep 2014 19:36:55 +0600
Message-ID: <542025F7.4000708@gmail.com>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
 <540D5B46.3020904@gmail.com> <540EBD9A.9000009@ladisch.de>
 <540EC08E.4000906@gmail.com> <540EC380.6030903@canonical.com>
 <540EC902.2030108@gmail.com>
 <CAN8cciYhJxJz1ZCctYzPsDj7J2OzNFFm11O29u3YP+aMN+xsyQ@mail.gmail.com>
 <54202219.9070102@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D7095265350
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 15:36:58 +0200 (CEST)
Received: by mail-la0-f43.google.com with SMTP id gi9so6773941lab.30
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 06:36:58 -0700 (PDT)
In-Reply-To: <54202219.9070102@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

22.09.2014 19:20, Lars-Peter Clausen wrote:
>>
>> Does this mean the those sound card can report
>> DMA_RESIDUE_GRANULARITY_BURST and driver use readl in pcm pointer
>> callback ?
>>
>> A few PCI sound cards use SG buffer including hda
>>
>> It seem that pulseaudio expect the driver support
>> DMA_RESIDUE_GRANULARITY_BURST for rewind/ timer scheduling
>
> Yes. This is why we set the BATCH flag if the granularity is not
> DMA_RESIDUE_GRANULARITY_BURST so for example pulse audio can disable
> timer scheduling.

For the record, disabling timer-based scheduling is IMHO a matter of 
further discussion. As long as there is enough safeguard, I think that 
timer-based scheduling can still be used, and is useful. A living proof 
is the whole story with the snd-usb-audio driver where (justified) 
addition of the BATCH flag was perceived as a performance regression and 
not as a fix to some real and obvious problem.

I do agree that such devices need to be marked up with the BATCH flag, 
so that PulseAudio chooses reasonable hardware parameters.

-- 
Alexander E. Patrakov
