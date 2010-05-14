From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 14 May 2010 11:09:55 +0800
Message-ID: <AANLkTilBG98HqtiZiVCaVPwtGp1kV9NFbI291B3il6LN@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
	<AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
	<AANLkTiktH0kLxDKL_zyOlxvsl5IaEQ9WP0Gr6LTO3Dye@mail.gmail.com>
	<AANLkTimFWD6-muOEWBD_kaDeLmMBDDPUvZ4IUQHYCYjm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 65C3A243A3
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 05:09:57 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1199281pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 20:09:56 -0700 (PDT)
In-Reply-To: <AANLkTimFWD6-muOEWBD_kaDeLmMBDDPUvZ4IUQHYCYjm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/14 pl bossart <bossart.nospam@gmail.com>

> > Refer to your patch "add rewind-safeguard parameter"
> >
> >
> http://git.0pointer.de/?p=pulseaudio.git;a=commit;h=4df443bbe682055a41e7c2248877dcc7682a69b8
> >
> > you mention glitch occur because application cannot rewind appl pointer
> to
> > hardware ptr.
> >
> > In another word, app ptr must be 128/256 bytes ahead of hardware ptr at
> any
> > time to prevent glitch occur. this mean that the glitch was due to DMA
> brust
> > size since "PulseAudio modilfies its watermark when underflows occur".
>
> Man, you are seriously confused. You ought to do some reading, look at
> the code, use your brain and figure things out instead of spamming
> this thread.
>


underrun is application pointer behind hardware pointer

"Rewinding the ring buffer completely causes audible issues with DMAs."

rewinding ring buffer compleletly mean hardware pointer = application
pointer

"Glitch free" can only be achieved when PA adjust the watermark before any
unnder run occur not "until underrrun occur" since it is too late
