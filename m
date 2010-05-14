From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 13 May 2010 23:39:22 -0500
Message-ID: <AANLkTil47RvspYnd0cTgCU-_y0d6PRHgaakns17edstr@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
	<20100512141653.GB4312@sirena.org.uk>
	<AANLkTimQ8I3NWwCuOV7M8mTpzBMwDkrmhb5wWYao_CGs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f222.google.com (mail-gx0-f222.google.com
	[209.85.217.222])
	by alsa0.perex.cz (Postfix) with ESMTP id A662B2441D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 06:39:23 +0200 (CEST)
Received: by gxk22 with SMTP id 22so1232875gxk.4
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 21:39:22 -0700 (PDT)
In-Reply-To: <AANLkTimQ8I3NWwCuOV7M8mTpzBMwDkrmhb5wWYao_CGs@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> AFAIU, the only issue is lack of ability to fine-tune period size of
> DMA runtime.
> Otherwise, for the requirement, having period-size almost equal
> to ring-buffer serves better than disabling interrupts and using timer
> based updating, more so for VMs with inaccurate timer source.
>
> Then I think, rather then providing a way to disable hw-intr, we'd
> better provide
> a way to modify runtime period-size at DMA Driver level, and
> snd_pcm_period_elapsed seems already capable to handle that.
> That way, disabled interrupts would just be a special case with
> period-size := ULONG_MAX.

Is this a realistic option? With the majority of existing hardware
period interrupts are programmed with a flag set in a descriptor when
the DMA linked list is created. That includes HDAudio and numerous
others. I am skeptical that one could reliably modify these
descriptors at run-time, specifically in the case where the controller
caches the descriptors. Modifying the linked list would likewise
generate race conditions.
I still view timers are the lesser of two evils.
