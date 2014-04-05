From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Sat, 5 Apr 2014 14:21:27 +0800
Message-ID: <CAN8cciaF9ZbyOoz4A3f3GyTkmzzbvskFtqqKUv2rjgVAXbjCcQ@mail.gmail.com>
References: <loom.20140404T175952-945@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F46E2651CF
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 08:21:28 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id j5so4205090qga.4
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 23:21:28 -0700 (PDT)
In-Reply-To: <loom.20140404T175952-945@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-04-05 0:15 GMT+08:00 andoru <andoru.blah@gmail.com>:

> Continued from here:
> http://article.gmane.org/gmane.linux.alsa.devel/121379
>
> After a few days now I finally got VLC to log everything that happens, and
> finally the bug reappeared, and unlike previously thought, it happens when
> I
> watch a video as well.
> But unfortunately VLC didn't give anything specific that happened at the
> time, just some vague ALSA errors about broken pipes (at line 394) :
> http://pastebin.com/NgZiG9yX
>
> At the time I added the video to VLC's queue I was doing something in the
> background (which I don't remember now unfortunately), but this has
> happened
> even when listening to something without doing anything in the background,
> and not having any background-running apps except Transmission.
>
> Also interestingly lately I've heard a few crackles/pops when listening to
> stuff, followed by a second or so of silence then back to normal when I
> would run CPU intensive stuff. At those points I thought the bug would be
> invoked again, but it didn't happen so.
>
> I still have the crackling problem, not able to change the PCM channel
> volume and screeching on audio that has clipped portions or very high
> frequency waves.
>
>
alsa debug: final HW setup:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 40000
PERIOD_SIZE: 1764
PERIOD_BYTES: 7056
PERIODS: (9 10)
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536


does the hardware really support (16384/1764)  9.27 periods ?

does the error occur in the last period ?



> Can anyone give me any instructions on what I could do to further diagnose
> this problem?
> And more importantly, as I stated in the linked post above, how could I
> shut
> down the sound daemon/server/whatever so I could bring back the OS to
> stability without restarting.
>
>
Do the clippping occur with oss emulation which use power of 2 period size

or

add

snd_pcm_hw_constraint_integer(runtime,
                       SNDRV_PCM_HW_PARAM_PERIODS)
