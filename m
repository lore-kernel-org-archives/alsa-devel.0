From: Alex Walker <alex@x3ja.co.uk>
Subject: ALSA 0.90beta11 from Kernel 2.5.5 SBLive hiss
Date: Mon, 25 Feb 2002 23:54:27 +0000
Message-ID: <20020225235427.A15157@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from smokey.blackcatnetworks.co.uk (smokey.blackcatnetworks.co.uk [212.135.138.139])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06443
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2002 00:54:48 +0100
Received: from alex by smokey.blackcatnetworks.co.uk with local (Exim 3.12 #1 (Debian))
	id 16fUwt-0007Bp-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2002 23:54:27 +0000
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

Sorry, posted this to alsa-user, but recieved no reply, so I'm going to
try on here.

I have compiled kernel 2.5.5 and enabled ALSA support for my SBLive! PCI
card.

All the modules compiled except rtctimer, which I then disabled and
recompiled without a problem.

I modprobed the snd-emu10k1 driver - at this point a noticable hiss
started in my speakers.  but I wasn't sure if it was just because I had
them up loud, so I continued.

I ran alsamixer, put up all the volumes (just to be sure) and then used
alsaplayer to play an Ogg Vorbis file.  This was when I realised the
hiss was not just background noise - under the music the hiss was very
noticable.  Using OSS from 2.4.x on the same hardware there is no such
hiss (or at least not noticable)

Has anyone seen this problem before and/or knows how to fix it?

Some potentially useful outputs, hope they help:

/proc/asound/cards:
0 [card0          ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! at 0xdf80, irq 11

/proc/asound/devices:
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

/proc/asound/oss-devices:
  2: [0- 2]: raw midi

/proc/asound/timers:
G0: system timer : 10000.0us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-2: PCM playback 0-0-2 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-16: PCM playback 0-0-16 : SLAVE
P0-0-18: PCM playback 0-0-18 : SLAVE
P0-0-20: PCM playback 0-0-20 : SLAVE
P0-0-22: PCM playback 0-0-22 : SLAVE
P0-0-24: PCM playback 0-0-24 : SLAVE
P0-0-26: PCM playback 0-0-26 : SLAVE
P0-0-28: PCM playback 0-0-28 : SLAVE
P0-0-30: PCM playback 0-0-30 : SLAVE
P0-0-32: PCM playback 0-0-32 : SLAVE
P0-0-34: PCM playback 0-0-34 : SLAVE
P0-0-36: PCM playback 0-0-36 : SLAVE
P0-0-38: PCM playback 0-0-38 : SLAVE
P0-0-40: PCM playback 0-0-40 : SLAVE
P0-0-42: PCM playback 0-0-42 : SLAVE
P0-0-44: PCM playback 0-0-44 : SLAVE
P0-0-46: PCM playback 0-0-46 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-16: PCM playback 0-0-16 : SLAVE
P0-0-18: PCM playback 0-0-18 : SLAVE
P0-0-20: PCM playback 0-0-20 : SLAVE
P0-0-22: PCM playback 0-0-22 : SLAVE
P0-0-24: PCM playback 0-0-24 : SLAVE
P0-0-26: PCM playback 0-0-26 : SLAVE
P0-0-28: PCM playback 0-0-28 : SLAVE
P0-0-30: PCM playback 0-0-30 : SLAVE
P0-0-32: PCM playback 0-0-32 : SLAVE
P0-0-34: PCM playback 0-0-34 : SLAVE
P0-0-36: PCM playback 0-0-36 : SLAVE
P0-0-38: PCM playback 0-0-38 : SLAVE
P0-0-40: PCM playback 0-0-40 : SLAVE
P0-0-42: PCM playback 0-0-42 : SLAVE
P0-0-44: PCM playback 0-0-44 : SLAVE
P0-0-46: PCM playback 0-0-46 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-50: PCM playback 0-0-50 : SLAVE
P0-0-52: PCM playback 0-0-52 : SLAVE
P0-0-54: PCM playback 0-0-54 : SLAVE
P0-0-56: PCM playback 0-0-56 : SLAVE
P0-0-58: PCM playback 0-0-58 : SLAVE
P0-0-60: PCM playback 0-0-60 : SLAVE
P0-0-62: PCM playback 0-0-62 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P0-3-2: PCM playback 0-3-2 : SLAVE
P0-3-4: PCM playback 0-3-4 : SLAVE
P0-3-6: PCM playback 0-3-6 : SLAVE
P0-3-8: PCM playback 0-3-8 : SLAVE
P0-3-10: PCM playback 0-3-10 : SLAVE
P0-3-12: PCM playback 0-3-12 : SLAVE
P0-3-14: PCM playback 0-3-14 : SLAVE

/proc/asound/pcm:
00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
00-01: emu10k1 mic : EMU10K1 MIC : capture 1
00-02: emu10k1 efx : EMU10K1 EFX : capture 1
00-03: emu10k1 : EMU10K1 FX8010 : playback 8

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
