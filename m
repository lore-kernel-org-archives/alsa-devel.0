From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 7 May 2010 22:12:27 -0500
Message-ID: <s2r6160a5131005072012o24609ce9q421ed2def04e4728@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f193.google.com (mail-yx0-f193.google.com
	[209.85.210.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9B01038D0
	for <alsa-devel@alsa-project.org>;
	Sat,  8 May 2010 05:12:30 +0200 (CEST)
Received: by yxe31 with SMTP id 31so1013648yxe.16
	for <alsa-devel@alsa-project.org>; Fri, 07 May 2010 20:12:28 -0700 (PDT)
In-Reply-To: <20100507232516.GB16910@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
List-Id: alsa-devel@alsa-project.org

> This patch looks very interesting and desirable. This is something have
> long been waiting for.
>
> I wonder how this actually relates to
> snd_pcm_sw_params_set_period_event() though.

snd_pcm_sw_params_set_period_event() defines whether or not you will
have poll wakeups when a period elapses. But if you decide not to have
poll wakeups, you still end-up with interrupts that were generated for
no good reason. You might think that this could be extended to disable
interrupts as well, but this would be hard since this can only be done
when the DMA linked list is created, ie when the hw_params are set.
Plus the sw_params may be changed on-the-fly, which isn't the case for
hw_params/interrupts. We would really need a flag used with
snd_pcm_open or when hw_params are set.

>>  Takashi, Jaroslav, Lennart, what do you think?
> I am sold!
Good to hear.
Cheers
-Pierre
