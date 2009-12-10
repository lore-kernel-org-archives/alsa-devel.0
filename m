From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Thu, 10 Dec 2009 08:44:39 -0600
Message-ID: <6160a5130912100644m7f090fdaxaa193737441c337d@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
	<4f3252890912091941y34509e3brd235360485c8c967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 742E724360
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 15:44:40 +0100 (CET)
Received: by pzk9 with SMTP id 9so687502pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 06:44:39 -0800 (PST)
In-Reply-To: <4f3252890912091941y34509e3brd235360485c8c967@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> 2) why PA use =A0snd_pcm_hw_params_get_buffer_size_max() instead of
> snd_pcm_hw_params_get_buffer_size() after snd_pcm_hw_params() ?

Precisely to use the maximum preallocated buffer size.

> I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time =
is
> 46.44ms
> D: alsa-util.c: =A0 buffer_size =A0: 2048
> D: alsa-util.c: =A0 period_size =A0: 1024

With small buffers like this, I don't see the point of the timer-based
scheduling, you will have one interrupt every 23ms.


> 5) it seem bug in snd_pcm_sw_params_set_avail_min() since 4661 is larger
> than the buffer size 2048 since PA still think that 371ms is the maximum
> buffer size
>
>
> D: alsa-util.c: =A0 buffer_size =A0: 2048
> D: alsa-util.c: =A0 period_size =A0: 1024
> D: alsa-util.c: =A0 period_time =A0: 23219
> D: alsa-util.c: =A0 tstamp_mode =A0: NONE
> D: alsa-util.c: =A0 period_step =A0: 1
> D: alsa-util.c: =A0 avail_min =A0 =A0: 4661

This doesn't make sense. But avail_min isn't really used with the
timer-based scheduling

>
> For pulseaudio-0.9.14 on Fedora 10

Man, you are using an old version here, the alsa sink code was changed
several times already.
