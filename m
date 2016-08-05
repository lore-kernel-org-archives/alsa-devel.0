From: Rob Nertney <rob@rob-otics.com>
Subject: Re: Stale data interleaved in capture driver
Date: Fri, 5 Aug 2016 08:42:50 -0700
Message-ID: <CALAeOVNc4GZ3LZTqM4eBZgVfz06B6ckp2fi9uU=ivd-h0dygPw@mail.gmail.com>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
 <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
 <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
 <9db62b13-f027-0986-5458-8ff9495a0cd0@ladisch.de>
 <CALAeOVPavUscy-wRmY=QTqfCOM8AD5ZqLh+D23bsTa9js9UnaA@mail.gmail.com>
 <ee683e13-52e0-5b21-c468-563b36cb4641@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A1EE426688E
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 17:42:54 +0200 (CEST)
Received: by mail-vk0-f43.google.com with SMTP id n129so193897215vke.3
 for <alsa-devel@alsa-project.org>; Fri, 05 Aug 2016 08:42:54 -0700 (PDT)
In-Reply-To: <ee683e13-52e0-5b21-c468-563b36cb4641@ladisch.de>
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

It was just easier to code it to do an exact /2 rather than a programmable
periodic value, which is what i'm going to implement next.

I notice that after 1 full buffer, the IRQ handle time (from entry to
handled) for snd_pcm_period_elapsed is almost 1/2 of a second. Is that
expected for large (64K) buffers, especially with only 2 periods?

Does the buffer copy at the period intervals for period sizes? or at the
buffer_bytes size? If the copy is on the period size, then I really should
implement the programmable periods in the DMA.

On Fri, Aug 5, 2016 at 1:18 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rob Nertney wrote:
> > I've rewritten the DMA to fire an IRQ only at the write-completion of
> > (buffer_bytes/2) and (buffer_bytes)
>
> Is the DMA actually restricted to two interrupts per buffer?  If not,
> your driver should support arbitrary period sizes.
>
>
> Regards,
> Clemens
>
