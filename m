From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 07:26:55 +0800
Message-ID: <AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 33B0824339
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 01:26:57 +0200 (CEST)
Received: by vws9 with SMTP id 9so6427074vws.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 16:26:56 -0700 (PDT)
In-Reply-To: <1279062131.24837.22.camel@localhost.localdomain>
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

2010/7/14 Chris <cpollock@embarqmail.com>

> I want to submit a bug report on the below. This issue was noted in
> Mandriva 2010 and is still present in 2010.1
>
> pulseaudio[24553]: alsa-util.c: snd_pcm_delay() returned a value that is
> exceptionally large: -161920 bytes (-917 ms).
> localhost pulseaudio[24553]: alsa-util.c: Most likely this is a bug in
> the ALSA driver 'snd_ens1371'. Please report this issue to the ALSA
> developers.
>

This kind of bug report without a full pulseaudio log is almost useless
without a test case which can reproduce the bug,


> localhost pulseaudio[24553]: alsa-util.c: snd_pcm_dump():
> localhost pulseaudio[24553]: alsa-util.c: Hardware PCM card 0 'Ensoniq
> AudioPCI' device 0 subdevice 0
> localhost pulseaudio[24553]: alsa-util.c: Its setup is:
> localhost pulseaudio[24553]: alsa-util.c:   stream       : PLAYBACK
> localhost pulseaudio[24553]: alsa-util.c:   access       :
> MMAP_INTERLEAVED
> localhost pulseaudio[24553]: alsa-util.c:   format       : S16_LE
> localhost pulseaudio[24553]: alsa-util.c:   subformat    : STD
> localhost pulseaudio[24553]: alsa-util.c:   channels     : 2
> localhost pulseaudio[24553]: alsa-util.c:   rate         : 44100
> localhost pulseaudio[24553]: alsa-util.c:   exact rate   : 44101
> (1445100000/32768)
>

The ens1371 cannot support exactly 44100
