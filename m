From: Alex Walker <alex@x3ja.co.uk>
Subject: ALSA 0.90beta11 from Kernel 2.5.5 VIA686 errors
Date: Mon, 25 Feb 2002 23:59:39 +0000
Message-ID: <20020225235939.B15157@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from smokey.blackcatnetworks.co.uk (smokey.blackcatnetworks.co.uk [212.135.138.139])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06497
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2002 00:59:41 +0100
Received: from alex by smokey.blackcatnetworks.co.uk with local (Exim 3.12 #1 (Debian))
	id 16fV1v-0006kk-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2002 23:59:39 +0000
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry to post another problem, but this is from my other machine...

[ Note: I never got this working with the OSS modules either ]

I have compiled kernel 2.5.5 and enabled ALSA support for my onboard
VIA, on a separate machine.

All the modules except rtctimer, which I then disabled and recompiled
without a problem.

I do modprobe snd-via686, adjust the volumes in alsamixer.

Then when I try and play using alsaplayer I get:
> AlsaPlayer 0.99.36
> (C) 1999-2001 Andy Lo A Foe <andy@alsaplayer.org> and others.
> Output plugin: ALSA output v1.9.0beta7
> Unavailable hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: [16 32]
> CHANNELS: [1 2]
> RATE: 48000
> PERIOD_TIME: (166 682667)
> PERIOD_SIZE: [8 32768]
> PERIOD_BYTES: [32 131072]
> PERIODS: [1 32]
> BUFFER_TIME: (166 682667)
> BUFFER_SIZE: [8 32768]
> BUFFER_BYTES: [32 65536]
> TICK_TIME: 10000
> ERROR: failed to set fragment size/count. Exiting...

If I compile all the debug options in, I get the following spooled down
the screen:

ALSA via686.c:245: codec_valid: codec 0 is not valid [0xfc0000]
ALSA via686.c:245: codec_valid: codec 0 is not valid [0xfe0000]
...
ALSA via686.c:245: codec_valid: codec 0 is not valid [0xa60000]

over 100 times.

I don't know what this means really, but it looks bad :o)

Any ideas what could be wrong?

Here's some outputs that might be useful:

/proc/asound/version:
Advanced Linux Sound Architecture Driver Version 0.9.0beta11 (Tue Feb 19 08:14:59 2002 UTC).
Compiled on Feb 21 2002 for kernel 2.5.5.

/proc/asound/cards:
0 [card0          ]: VIA686A - VIA 82C686A/B
                     VIA 82C686A/B at 0xdc00, irq 5

/proc/asound/devices:
  0: [0- 0]: ctl
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
  33:       : t

/proc/asound/oss-devices:
  0: [0- 0]: mixer
  3: [0- 3]: digital audio

/proc/asound/timers:
G0: system timer : 10000.0us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

/proc/asound/pcm:
00-00: VIA 82C686A : VIA 82C686A : playback 1 : capture 1

Cheers,

Alex

-- 
      ALEX|X3JA
   alex@x3ja.co.uk
    ICQ: 1523424
MSN: x3ja@hotmail.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
