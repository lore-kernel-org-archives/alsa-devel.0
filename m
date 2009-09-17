From: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Subject: Re: Questions regarding workaround for VMware
Date: Wed, 16 Sep 2009 17:27:00 -0700
Message-ID: <4eccebac0909161727r540b42c6l4cf9a0cb994c0c93@mail.gmail.com>
References: <4eccebac0908281129n1b2206bbo37ea80e64d4d1d4b@mail.gmail.com>
	<s5hskfblnsw.wl%tiwai@suse.de>
	<4eccebac0909131117s1dce8e5al264fb3ac0a0dc17c@mail.gmail.com>
	<s5hvdjkbhhr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B9B2E103803
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 02:27:21 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c5so333anc.2
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2009 17:27:20 -0700 (PDT)
In-Reply-To: <s5hvdjkbhhr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, akataria@vmware.com, bbhavsar@vmware.com
List-Id: alsa-devel@alsa-project.org

>> > The problem is that the irq timing emulated on vmware isn't always
>> > accurate. =A0The sound hardware is supposed to issue an irq at the
>> > programmed buffer period. =A0On VMware, this irq generation seems to be
>> > done based on the system timer (or alike), thus it's not generated
>> > at the accurate timing that the hardware should give.

For Linux guests virtual sound device generated 50 interrupts per sec.
This was leading to hw_ptr_base re-calculation in
snd_pcm_update_hw_ptr_interrupt() on every interrupt
after this commit
http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Ded3da3d=
9a0ef13c6fe1414ec73c9c1be12747b62

We are fixing our sound card emulation for Linux guest OSes such that
interrupts are generated
at programmed buffer period. This helps improve playback quality with
2.6.31rc9+ kernels.

Thanks for the pointers, Takashi!

On a side-note there seems to be some change in PulseAudio bring
shipped with Ubuntu 9.10 over 9.04 that affects sound playback
quality.
With PulseAudio in 9.10, programmed DMA buffer is 64k and num_periods
is always 1 and thereby number of interrupts generated per sec is just
2 for 16-bit, 44Khz, stereo.
IMO the number interrupts is too low and this leads to under-runs.
Whats the reason for choosing always 1 period and having large
buffer/period size (power-savings?)?

If I disable PulseAudio in 9.10,  programmed DMA buffer is 64k with 16
periods each of size 4k and virtual sound device would generate 46-48
interrupts per sec. With this setting sound playback quality is good.

--Bankim.
