From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: using plug for sample format conversion
Date: Thu, 29 Jul 2010 07:43:14 +0800
Message-ID: <AANLkTi=VsObweAi2+KbTt4GD2OOeAjUEjL4=Y=89xAY_@mail.gmail.com>
References: <AANLkTik=MskE7rGhBmuyDtJTe5BAie7AckiANrheJ8Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CC81910391F
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 01:43:16 +0200 (CEST)
Received: by vws20 with SMTP id 20so16602vws.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 16:43:15 -0700 (PDT)
In-Reply-To: <AANLkTik=MskE7rGhBmuyDtJTe5BAie7AckiANrheJ8Qi@mail.gmail.com>
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

2010/7/29 Adam Rosenberg <adam@alcorn.com>

> >> I am trying to use plug to play audio files that are S16_LE but my
> >> hardware only supports S32_LE.  It is not working.  Here is an example
> >> of the problem using speaker-test.  First I use S32_LE and it works as
> >> expected.  I then try S16_LE but it fails.  Does this mean the plug
> >> plugin cannot convert between these sample formats?
> >>
> >> Thanks,
> >> Adam
> >>
> >
> >Please use latest version of speaker-test and alsa-lib.
> >
> >and post struct  snd_pcm_hardware of you driver
> >
>
> I am using the latest release of uClinux for Blackfin BF537 and do not
> know how to configure and install the latest version of alsa-lib and
> alsa-utils.  I am starting to understand how struct snd_pcm_hardware
> is used by the ALSA PCM code but you are correct to assume I may have
> something wrong.  Here is the struct:
>
> static struct snd_pcm_hardware ourCS42448PcmHw =
> {
>        .info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER
> ),
>        .formats = SNDRV_PCM_FMTBIT_S32_LE,
>        .rates = SNDRV_PCM_RATE_48000,
>        .rate_min = 48000,
>        .rate_max = 48000,
>        .buffer_bytes_max = 32768,
>        .channels_min = 1,
>        .channels_max = 2,
>        .period_bytes_max = 32768,
>        .periods_min = 1,
>        .period_bytes_min = 8,
>        .periods_max = 4096,
> };
>

Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument


This will tell you which argument is invalid

export LIB_LIBASOUND_DEBUG=1
speaker-test -l 1 -r 48000 -c 2 -F S16_LE -Dplughw:0,0,0



If the above still cannot help you find out the problem

you will need to enable RULES_DEBUG in core/pcm_native.c and check the
system log to find out how those hw parameters are refined

if you cannot use latest version of speaker-test , read the history of
speaker-test

http://git.alsa-project.org/?p=alsa-utils.git;a=history;f=speaker-test/speaker-test.c
