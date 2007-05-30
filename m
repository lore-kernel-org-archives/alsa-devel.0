From: "Zoltan Devai" <zdevai@gmail.com>
Subject: Re: [RFC] [PATCH 0/2] ASoC sound support
	forSMDK2440boards
Date: Wed, 30 May 2007 17:30:18 +0200
Message-ID: <5b7270f40705300830g7aef9faajc0b9e82d6d983d@mail.gmail.com>
References: <5b7270f40705240728p4f579269g1ddc8e8db8d59f81@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FD65@MAIL.eldorado.org.br>
	<5b7270f40705241445t59a89b24sacbd3abf0a1b129d@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FE77@MAIL.eldorado.org.br>
	<5b7270f40705250750u1ba4619dm973fcb297c8fefb1@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D6B8B8@MAIL.eldorado.org.br>
	<5b7270f40705251040r56bee4dfqdb2e66fd2b7fbdcd@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D6BE87@MAIL.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DA3B2449F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 17:36:33 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so751682ana
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2007 08:36:30 -0700 (PDT)
In-Reply-To: <AC2729D6E3A3314A922E4E0FBE513F65D6BE87@MAIL.eldorado.org.br>
Content-Disposition: inline
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

2007/5/29, Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>:
> I used speaker-test as indicated above and the result is:
>
> pendrive $ ./speaker-test -r 44100
>
> speaker-test 1.0.11
>
> Playback device is default
> Stream parameters are 44100Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> Playback open error: -2,No such file or directory
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> Playback open error: -2,No such file or directory
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> Playback open error: -2,No such file or directory
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> Playback open error: -2,No such file or directory
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> Playback open error: -2,No such file or directory
>
> I have also tried:
>
> /pendrive $ ./aplay -f cd 01-jack_johnson-times_like_these-rns.wav
> ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:547: audio open error: No such file or directory
> /pendrive $
>
> so I don't know what is happening here.
> Does anyone have any idea?

You seem to have two problems:
1. Using OSS applications which try to set the sample rate to 8000Hz,
which is not supported by the hardware
2. A non-working ALSA installation, with some alsa-lib or device file
misconfiguration

Try to fix both...
