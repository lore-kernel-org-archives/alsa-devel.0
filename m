From: ted <ted@2600.COM>
Subject: Re: No sound output on PowerBook Titanium II (TAS3001c)
 - interesting new discovery
Date: Thu, 28 Aug 2003 16:18:20 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.NEB.4.44.0308281537000.14997-100000@phalse.2600.com>
References: <Pine.NEB.4.44.0308271818370.14997-100000@phalse.2600.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.44.0308271818370.14997-100000@phalse.2600.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It seems I can load the ALSA drivers, suspend the system, and upon
restoring, the sound output just magically starts working!

MPlayer still gets caught in the "unknown status, trying to reset
soundcard" loop on _most_ media files I've tried.  With one MPEG I've
tried, it actually starts playing, but it sounds terrible
(jitters/stutters).  I've included the relevant output below in hopes that
someone might have an idea what's going on:

[snip]
Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, big endian signed int
AF_pre: 44100Hz 2ch Signed 16-bit (Big-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
(Big-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 44100 Hz/2 channels/2 bpf/16384 bytes buffer/Signed 16 bit Big
Endian
AO: [alsa9] 44100Hz 2ch Signed 16-bit (Big-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
Starting playback...
[snip]

FWIW, the same MPEG sounds fine using the OSS emulation.  Any thoughts
anyone?  So close, yet so far away.  :(



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
