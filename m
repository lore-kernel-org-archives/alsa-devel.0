From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 19:13:54 +0800
Message-ID: <AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E9DE103815
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 13:13:55 +0200 (CEST)
Received: by vws9 with SMTP id 9so7089291vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 04:13:55 -0700 (PDT)
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
> localhost pulseaudio[24553]: alsa-util.c:   msbits       : 16
> localhost pulseaudio[24553]: alsa-util.c:   buffer_size  : 4408
> localhost pulseaudio[24553]: alsa-util.c:   period_size  : 1102
> localhost pulseaudio[24553]: alsa-util.c:   period_time  : 24988
> localhost pulseaudio[24553]: alsa-util.c:   tstamp_mode  : ENABLE
> localhost pulseaudio[24553]: alsa-util.c:   period_step  : 1
> localhost pulseaudio[24553]: alsa-util.c:   avail_min    : 1102
> localhost pulseaudio[24553]: alsa-util.c:   period_event : 1
> localhost pulseaudio[24553]: alsa-util.c:   start_threshold  : -1
> localhost pulseaudio[24553]: alsa-util.c:   stop_threshold   :
> 1155530752
> localhost pulseaudio[24553]: alsa-util.c:   silence_threshold: 0
> localhost pulseaudio[24553]: alsa-util.c:   silence_size : 0
> localhost pulseaudio[24553]: alsa-util.c:   boundary     : 1155530752
> localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
> localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
> localhost pulseaudio[24553]: ratelimit.c: 280 events suppressed
> localhost pulseaudio[24553]: asyncq.c: q overrun, queuing locally
>
> Because of the constant disk access when this is happening my system
> becomes almost unusable.
>
>
localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184

This is underrun as you can see appl_ptr is behing hw_ptr

However PA server had disabled the underrun detection.
