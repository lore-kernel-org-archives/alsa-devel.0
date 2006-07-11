From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002183]: Silence on riptide card
Date: Tue, 11 Jul 2006 08:38:40 +0200
Message-ID: <3ee94159014a57e00b6215236b5d69e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A608718F
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 08:38:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2183> 
======================================================================
Reported By:                Hawk777
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2183
Category:                   PCI - riptide
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             Linux hp 2.6.16-gentoo-r7 #8 Thu Jun 1 22:10:53 PDT
2006 i686 Celeron (Mendocino) GNU/Linux
======================================================================
Date Submitted:             06-02-2006 21:03 CEST
Last Modified:              07-11-2006 08:38 CEST
======================================================================
Summary:                    Silence on riptide card
Description: 
The summary says it all: everything works perfectly, except that no matter
what I do, no sound ever comes out. I've tried the CVS version from
SourceForge as well as 1.0.11: same result.

I have some programming skill (though little experience in drivers); I can
work with you to debug this.
======================================================================

----------------------------------------------------------------------
 nokos - 07-06-06 16:21 
----------------------------------------------------------------------
Can you include the contents of /proc/asound/card0/riptide
while playing (multiple) streams and/or recording?
is there a difference if xou play 44100 Hz streams in comparison to
48000 Hz signed 16bit Little Endian streams.
(They take different paths through the sound HW)

----------------------------------------------------------------------
 Hawk777 - 07-11-06 08:38 
----------------------------------------------------------------------
Nothing playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (0)5022
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00003f3f 14: 00000000 18: 00000001 1c: 00000001
20: 00000004 24: 00004001 28: 00000006 2c: 00004003
30: 00000000 34: 00000000 38: 00000000 3c: 00000000
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 6926 6926
 1: 6926 6926
 2: 6926 6926
 3: 6926 6926
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 978 failed: 1 time: 2107 max: 7 min: 0
Open streams 0:
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 1e->10 29->d b->0



One 44100Hz 16bit stereo playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (196)19817
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00000000 14: 000c3fcc 18: 00000001 1c: 000c3fcd
20: 00000004 24: 00004001 28: 00000006 2c: 00004003
30: 00000000 34: 00000000 38: 00000000 3c: 00000000
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 32767 32767
 1: 32767 32767
 2: 6926 6926
 3: 6926 6926
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 1156 failed: 1 time: 2385 max: 7 min: 0
Open streams 1:
stream: 4 mixer: 0 source: 4 (8,255)
rate: 44100
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 1e->10 29->d 8->4 b->0



Two 44100Hz 16bit stereo playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (1464)21187
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00000000 14: 0004400a 18: 00000001 1c: 0004400b
20: 00000005 24: 00004001 28: 00000006 2c: 00004003
30: 00000001 34: 00000001 38: 00000000 3c: 00000001
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 32767 32767
 1: 32767 32767
 2: 32767 32767
 3: 32767 32767
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 1871 failed: 1 time: 3677 max: 7 min: 0
Open streams 2:
stream: 4 mixer: 0 source: 4 (8,255)
rate: 44100
stream: 1 mixer: 1 source: 1 (9,255)
rate: 44100
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 1f->11 1e->10 29->d 8->4 9->1 b->0



One 48000Hz 16bit stereo playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (3169)23068
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00000000 14: 00034008 18: 00000001 1c: 00034009
20: 00000005 24: 00004001 28: 00000006 2c: 00004003
30: 00000001 34: 00000001 38: 00000000 3c: 00000001
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 32767 32767
 1: 32767 32767
 2: 0 0
 3: 0 0
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 2891 failed: 1 time: 5576 max: 7 min: 0
Open streams 1:
stream: 4 mixer: 0 source: 4 (255,255)
rate: 0
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 29->d 1e->4 b->0



Two 48000Hz 16bit stereo playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (4180)24186
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00000000 14: 003a000c 18: 00000001 1c: 003a000d
20: 00000005 24: 00004001 28: 00000006 2c: 00004003
30: 00000001 34: 00000001 38: 00000000 3c: 00000001
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 32767 32767
 1: 32767 32767
 2: 32767 32767
 3: 32767 32767
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 3473 failed: 1 time: 6639 max: 7 min: 0
Open streams 2:
stream: 4 mixer: 0 source: 4 (255,255)
rate: 0
stream: 1 mixer: 1 source: 1 (255,255)
rate: 0
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 29->d 1e->4 1f->1 b->0



One of each playing:
Riptide at 0x1080, irq 11 mpu 0x330 opl3 0x388

Device ID: 0x4320
Received IRQs: (5699)25841
Ports:
00: 00000004 04: 00004001 08: 00000005 0c: 00004001
10: 00000000 14: 00048010 18: 00000001 1c: 00048011
20: 00000004 24: 00004001 28: 00000006 2c: 00004003
30: 00000000 34: 00000000 38: 00000000 3c: 00000000
Version: ASIC: 3 CODEC: 2 AUXDSP: 3 PROG: 773
Digital mixer:
 0: 32767 32767
 1: 32767 32767
 2: 32767 32767
 3: 32767 32767
 4: 0 0
 5: 0 0
 6: 0 0
 7: 0 0
 8: 0 0
 9: 0 0
 10: 0 0
 11: 0 0
ARM Commands num: 4332 failed: 1 time: 8365 max: 7 min: 0
Open streams 2:
stream: 4 mixer: 0 source: 4 (8,255)
rate: 44100
stream: 1 mixer: 1 source: 1 (255,255)
rate: 0
Paths:
1b->30 1d->2a 2f->26 27->22 25->13 1e->10 29->d 8->4 1f->1 b->0



All sounds are little-endian.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-06 21:03 Hawk777        New Issue                                    
06-02-06 21:03 Hawk777        Distribution              => Gentoo          
06-02-06 21:03 Hawk777        Kernel Version            => Linux hp
2.6.16-gentoo-r7 #8 Thu Jun 1 22:10:53 PDT 2006 i686 Celeron (Mendocino)
GNU/Linux
06-02-06 21:16 Hawk777        Issue Monitored: Hawk777                     
06-02-06 21:21 Hawk777        Note Added: 0010055                          
07-06-06 16:21 nokos          Note Added: 0010867                          
07-06-06 16:22 nokos          Issue Monitored: nokos                       
07-11-06 08:38 Hawk777        Note Added: 0010968                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
