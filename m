From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_writei returns -EAGAIN after poll
Date: Sun, 20 Mar 2011 10:40:59 +0800
Message-ID: <AANLkTik4KBOqVTVnxwmacZZEjaZOrbbUg5GKrBKY_pav@mail.gmail.com>
References: <4D85649D.20107@rain.ifmo.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C162D10380B
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 03:40:59 +0100 (CET)
Received: by fxm6 with SMTP id 6so4461809fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2011 19:40:59 -0700 (PDT)
In-Reply-To: <4D85649D.20107@rain.ifmo.ru>
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

2011/3/20 Ivan Sorokin <sorokin@rain.ifmo.ru>

> Hello!
>
> I use slightly modified test/pcm.c in write_and_poll mode.
>
> My program looks like this:
>
> snd_pcm_open with SND_PCM_NONBLOCK
> snd_pcm_set_params
>
> infinite loop
>    poll for snd_pcm_poll_descriptors
>    snd_pcm_poll_descriptors_revents
>    if POLLOUT flag is set
>       snd_pcm_writei
>
> Everything works, but snd_pcm_writei sometimes returns -EAGAIN. The
> probability of when snd_pcm_writei returns -EAGAIN depends on buffer
> size that I pass to it. ExperimentallyI found out that when I call
> snd_pcm_writei with 940 bytes buffers (maybe something related to period
> size?) it never returns -EAGAIN.
>
> Why poll returns when there is no place for new data? Is it ok to ignore
> EAGAIN and just start another poll? Is there any recommended buffer size
> for snd_pcm_writei?
>
> My test program:
> https://github.com/sorokin/asoundpp/blob/master/sine_async.cpp (94 LOC)
>


Most sound cards does not have 0.5 second buffer , only a few sound card
(e.g. snd-hda-intel has 4Mb buffer but snd-intel8x0 only has 64Kb buffer


d.set_params(SND_PCM_FORMAT_S16,
                   SND_PCM_ACCESS_RW_INTERLEAVED,
                   1,
                   RATE,
                   true,
                   500000);
