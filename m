From: Rob Nertney <rob@rob-otics.com>
Subject: Re: Stale data interleaved in capture driver
Date: Thu, 4 Aug 2016 09:58:35 -0700
Message-ID: <CALAeOVPavUscy-wRmY=QTqfCOM8AD5ZqLh+D23bsTa9js9UnaA@mail.gmail.com>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
 <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
 <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
 <9db62b13-f027-0986-5458-8ff9495a0cd0@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 615372667D3
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 18:58:37 +0200 (CEST)
Received: by mail-vk0-f46.google.com with SMTP id n129so172029420vke.3
 for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2016 09:58:37 -0700 (PDT)
In-Reply-To: <9db62b13-f027-0986-5458-8ff9495a0cd0@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens. Remind me to buy you a beer next time I'm in Germany, or
you're on the West Coast of the US :)

I think it was because of the IRQ counting I implemented the handler. I
noticed in hardware that during a buffer_bytes loop-around, the IRQ handle
time would go up drastically, and I would miss other IRQs from the DMA,
breaking the offset that ALSA thought it was at, and where the DMA was
actually at. I am running more tests tonight.

I've rewritten the DMA to fire an  IRQ only at the write-completion of
(buffer_bytes/2) and (buffer_bytes) (which will always be a multiple of my
frame length). The pointer callback now reads a hardware frame-position
too. I think this will emulate an actual sound card much more closely. The
IRQ handler simply calls snd_pcm_period_elapsed, and the pointer callback
simply returns the hardware frame count I am currently at in the buffer.


64K buffer / 64Byte frames = 1024 frames/buffer.
2 periods in the buffer = 512 Frames/IRQ

buffer_bytes_max = 65535
period_bytes_min = 32768
period_bytes_max = 32768
periods_min = 2
periods_max = 2

Hopefully my testing tonight goes well.

Thanks,
Rob





On Thu, Aug 4, 2016 at 1:53 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rob Nertney wrote:
> > I've made changes to remove the high-frequency. I originally tried
> > that method because my DMA IRQ fires whenever it writes 1/2 frame (it
> > doesn't have coalescing support yet).
>
> The snd_pcm_hardware is supposed to describe the hardware.
>
> > I have a DMA which is looping across 64Kbytes.
>
> This is buffer_bytes.
>
> > The DMA is configured to interrupt at 32Bytes
>
> This is period_bytes.
>
> > From what I can tell (please correct me if I'm wrong), the periods_min
> > and periods_max are up to me to define
>
> They describe how often the *hardware* can interrupt.
>
> > since i don't interrupt on a period boundary.
>
> Periods are *defined* as the data between two interrupts.
>
> Mapping ALSA periods to something else makes sense only if the hardware
> cannot interrupt after a fixed number of bytes.
>
>
> Regards,
> Clemens
>
