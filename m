From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: snd-intel8x0 Line-In right channel always muted
Date: Tue, 11 Nov 2003 13:03:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0311111249120.22683@dot.kde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
When using the Line-In port to record audio on a SiS SI7012 chip [PCI ID 
1039:7012, Subvendor 1462:5350], the right channel is always muted (even 
if I explicitly tell alsamixer to set Capture and Line to maximum volume 
on both channels), using ALSA 0.9.8 on kernel 2.4.23.

Using kernel 2.6.0-test9-mm2 with the included ALSA, the same thing works 
fine.

I'm using this to initialize/try out everything:
amixer sset Capture 60% cap
amixer sset Line capture cap mute
amixer sset Mic capture nocap
amixer sset CD capture nocap
amixer sset 'Mic As Center/LFE' off
amixer sset 'Line-In As Surround' off
amixer sset 'Duplicate Front' off
amixer sset 'Master' 50%
arecord -f dat - |aplay -

Amixer sget Capture shows the expected
Capabilities: cvolume cswitch cswitch-joined
Capture channels: Front Left - Front Right
Limits: Capture 0 - 15
Front Left: Capture 9 [60%] on
Front Right: Capture 9 [60%] on

Still the right channel remains empty.

Any ideas?

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
