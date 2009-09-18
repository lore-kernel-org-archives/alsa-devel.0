From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Questions regarding workaround for VMware
Date: Fri, 18 Sep 2009 15:00:26 +0800
Message-ID: <4f3252890909180000w6d350decg5e708277c5f2fccc@mail.gmail.com>
References: <4eccebac0908281129n1b2206bbo37ea80e64d4d1d4b@mail.gmail.com>
	<s5hskfblnsw.wl%tiwai@suse.de>
	<4eccebac0909131117s1dce8e5al264fb3ac0a0dc17c@mail.gmail.com>
	<s5hvdjkbhhr.wl%tiwai@suse.de>
	<4eccebac0909161727r540b42c6l4cf9a0cb994c0c93@mail.gmail.com>
	<h8tc7s$fg7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id EB74A243E2
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 09:00:27 +0200 (CEST)
Received: by pzk14 with SMTP id 14so592943pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2009 00:00:26 -0700 (PDT)
In-Reply-To: <h8tc7s$fg7$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/9/17 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Bankim Bhavsar at 17/09/09 01:27 did gyre and gimble:
> > On a side-note there seems to be some change in PulseAudio bring
> > shipped with Ubuntu 9.10 over 9.04 that affects sound playback
> > quality.
> > With PulseAudio in 9.10, programmed DMA buffer is 64k and num_periods
> > is always 1 and thereby number of interrupts generated per sec is just
> > 2 for 16-bit, 44Khz, stereo.
> > IMO the number interrupts is too low and this leads to under-runs.
> > Whats the reason for choosing always 1 period and having large
> > buffer/period size (power-savings?)?
> >
> > If I disable PulseAudio in 9.10,  programmed DMA buffer is 64k with 16
> > periods each of size 4k and virtual sound device would generate 46-48
> > interrupts per sec. With this setting sound playback quality is good.
>
> I'm not sure about Ubuntu setup but the disabling of interupts and using
> timers is indeed all about power savings. The wakeup time is dynamically
> adjusted when an underrun occurs so as to avoid it in the future.
>
>
Is it correct to use the term "the disabling of interrupt" ?

If the hardware interrupt is disabled , you will need the driver to use the
timer to update the hardware pointer.

"ping pong" buffering need at least two periods per buffer

aplay does not accept  one period per buffer

Why do PA server use one period per buffer ?
Is it a driver bug ? ( e.g emu10k1 and intel8x0 have special code to handle
one period

An application using mmap read/write should not allow underrun/overrun occur




> Some Nokia/Intel folks (can't remember which) are experimenting with
> very large latencies (e.g. up to about 10s) in order to get maximum
> power savings.
>
> You can read more about it here:
> http://0pointer.de/blog/projects/pulse-glitch-free.html
>
> You can disable this timer based scheduling by passing the argument
> tsched=0 to module-hal-detect or module-udev-detect (whichever is in
> use: the latter obsoleting the former) in /etc/pulse/default.pa
>
> Col
>
> --
>
> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
>
> Day Job:
>   Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
>   Mandriva Linux Contributor [http://www.mandriva.com/]
>   PulseAudio Hacker [http://www.pulseaudio.org/]
>   Trac Hacker [http://trac.edgewall.org/]
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
