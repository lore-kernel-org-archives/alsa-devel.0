From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: capture buffers on SBLIVE...
Date: Sat, 29 Jun 2002 21:26:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1E09F4.46DDF834@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hello * !

i'm tracking down a nasty problem i have with jack. is there any way to
increase the periods-per-hardware-buffer setting on an sblive for
capture ? jackd refuses to do that, and i wonder whether it's a hardware
limitation.


kleineronkel:~ # jackd -R -d alsa -d hw:0 -n 4 -p 2048
jackd 0.37.1

alsa PCM driver args:
    -d alsa-pcm-name (default: default)
    -r sample-rate (default: 48kHz)
    -p frames-per-period (default: 1024)
    -n periods-per-hardware-buffer (default: 2)
    -H (use hardware monitoring if available, default: no)
    -D (duplex, default: yes)
    -C (capture, default: duplex)
    -P (playback, default: duplex)
    -z[r|t|s|-] (dither, rect|tri|shaped|off, default: off)

Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

creating alsa driver ... hw:0|2048|4|48000|swmon
ALSA: cannot set number of periods to 4 for capture
ALSA: cannot configure capture channel
cannot load driver module alsa
jack main caught signal 15


best,

j=F6rn


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
