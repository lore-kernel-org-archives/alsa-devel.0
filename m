From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001869]: Playing surround sound
	produces 100% CPU load
Date: Sun, 23 Jul 2006 13:49:57 +0200
Message-ID: <daa2f3e5d08693bae43847f38f7a4531@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33E7C222
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 13:49:58 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1869> 
======================================================================
Reported By:                bitmage2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1869
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 10.0
Kernel Version:             Linux 2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC
2006 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             02-23-2006 00:48 CET
Last Modified:              07-23-2006 13:49 CEST
======================================================================
Summary:                    Playing surround sound produces 100% CPU load
Description: 
I am using the CS46xx with a Hercules Gametheater XP 5.1 . It plays back
stereo without problems.
I wanted to use the rest of my 5.1 speaker set, so for a test I ran the
speaker-test program. Running it without parameters or with 2 or 4.0
channels works also fine. So far so good.

But when I run it with 5.0 channels or 5.1 channels the CPU load of
speaker-test goes to 100%. I'll show the output of top along with the
command lines below (for the 2.0 and 5.1 case) in the "Additional
Information" box.



======================================================================

----------------------------------------------------------------------
 bitmage2 - 07-23-06 11:34 
----------------------------------------------------------------------
chris@bjork:~> cat /proc/asound/pcm
00-00: CS46xx : CS46xx : playback 31 : capture 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31
01-00: Intel ICH : NVidia nForce2 : playback 1 : capture 1
01-01: Intel ICH - MIC ADC : NVidia nForce2 - MIC ADC : capture 1
01-02: Intel ICH - IEC958 : NVidia nForce2 - IEC958 : playback 1

bjork:~ # lspci -vn
00:00.0 Class 0600: 10de:01e0 (rev a2)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [40] AGP version 3.0
        Capabilities: [60] HyperTransport: Host or Secondary Interface

00:00.1 Class 0500: 10de:01eb (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel

00:00.2 Class 0500: 10de:01ee (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel

00:00.3 Class 0500: 10de:01ed (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel

00:00.4 Class 0500: 10de:01ec (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel

00:00.5 Class 0500: 10de:01ef (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel

00:01.0 Class 0601: 10de:0060 (rev a3)
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [48] HyperTransport: Slave or Primary Interface

00:01.1 Class 0c05: 10de:0064 (rev a2)
        Subsystem: 1695:1000
        Flags: 66MHz, fast devsel, IRQ 255
        I/O ports at e400 [size=32]
        Capabilities: [44] Power Management version 2

00:02.0 Class 0c03: 10de:0067 (rev a3) (prog-if 10)
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at ed003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 Class 0c03: 10de:0067 (rev a3) (prog-if 10)
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 4
        Memory at ed004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.2 Class 0c03: 10de:0068 (rev a3) (prog-if 20)
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 3
        Memory at ed005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:06.0 Class 0401: 10de:006a (rev a1)
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at ed001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:08.0 Class 0604: 10de:006c (rev a3)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ec000000-ecffffff
        Prefetchable memory behind bridge: 40000000-400fffff

00:09.0 Class 0101: 10de:0065 (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: 1695:1000
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2

00:1e.0 Class 0604: 10de:01e8 (rev a2)
        Flags: bus master, 66MHz, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

01:06.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 10ec:8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c000 [size=256]
        Memory at ec112000 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at 40000000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

01:07.0 Class 0200: 10ec:8029
        Flags: medium devsel, IRQ 11
        I/O ports at c400 [size=32]
        [virtual] Expansion ROM at 40010000 [disabled] [size=32K]

01:08.0 Class 0280: 1050:6692 (rev 01)
        Subsystem: 1234:5678
        Flags: medium devsel, IRQ 12
        Memory at ec110000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [size=256]

01:09.0 Class 0401: 1013:6003 (rev 01)
        Subsystem: 1681:0051
        Flags: bus master, slow devsel, latency 32, IRQ 5
        Memory at ec111000 (32-bit, non-prefetchable) [size=4K]
        Memory at ec000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

01:0a.0 Class 0000: 1000:0001 (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at cc00 [size=256]
        Memory at ec113000 (32-bit, non-prefetchable) [size=256]

02:00.0 Class 0300: 10de:0281 (rev a1)
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        [virtual] Expansion ROM at eb000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

----------------------------------------------------------------------
 Raymond - 07-23-06 13:49 
----------------------------------------------------------------------
Please update alsa-utils to the same version of alsa-lib

speaker-test -c 2 -t wav

speaker-test -c 4 -Dsurround40 -t wav

speaker-test -c 6 -Dsurround51 -t wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 00:48 bitmage2       New Issue                                    
02-23-06 00:48 bitmage2       Distribution              => SuSE Linux 10.0 
02-23-06 00:48 bitmage2       Kernel Version            => Linux
2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC 2006 i686 athlon i386 GNU/Linux
02-23-06 00:54 bitmage2       Note Added: 0008164                          
02-23-06 00:55 bitmage2       Issue Monitored: bitmage2                    
07-11-06 05:58 Raymond        Note Added: 0010964                          
07-14-06 20:57 bitmage2       Note Added: 0011004                          
07-14-06 20:59 bitmage2       Note Added: 0011005                          
07-14-06 21:25 rlrevell       Note Added: 0011006                          
07-14-06 22:40 bitmage2       Note Added: 0011008                          
07-14-06 22:57 rlrevell       Note Added: 0011009                          
07-15-06 01:28 bitmage2       Note Added: 0011013                          
07-15-06 01:45 rlrevell       Note Added: 0011014                          
07-15-06 05:09 Raymond        Note Added: 0011017                          
07-15-06 07:17 Raymond        Note Edited: 0011017                         
07-23-06 11:34 bitmage2       Note Added: 0011183                          
07-23-06 13:49 Raymond        Note Added: 0011185                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
