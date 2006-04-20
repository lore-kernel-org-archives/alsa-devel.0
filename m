From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002045]: playback stops after 1 second on Intel D945GPM
Date: Thu, 20 Apr 2006 20:10:32 +0200
Message-ID: <94435a5c29045da5db8c9d2c97d84ef9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F6B9166
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 20:10:32 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2045> 
======================================================================
Reported By:                mda2376
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2045
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r7
======================================================================
Date Submitted:             04-20-2006 20:00 CEST
Last Modified:              04-20-2006 20:10 CEST
======================================================================
Summary:                    playback stops after 1 second on Intel D945GPM
Description: 
Playback stops after a very brief period, about one second, and the
application playing sound locks up, but can be killed with Ctrl-C.

This is an Intel Desktop motherboard, sku: BOXD945GPMLKR with a SigmaTel
STAC9220D/9223D A2 according to alsamixer. hda-intel is compiled as a
module and loaded with model=5stack-digout. Processor is a Pentium D dual
core, with everything compiled with -O2 -march=nocona -fomit-frame-pointer
-pipe.

When the module is loaded, dmesg reports:
GSI 21 sharing vector 0x5A and IRQ 21
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 90
PCI: Setting latency timer of device 0000:00:1b.0 to 64


Output from mplayer trying to play an mp3:
..
Starting playback...
alsa-play: write error: Broken pipe0) ??,?%
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe 0.8%
alsa-play: trying to reset soundcard
A:   0.7 (00.6) of 328.0 (05:28.0)  0.8%

If I use alsa-driver-1.0.10-r2 the two alsa-play: messages are not
displayed but the same sound problem exists. Trying to play sound again
results in the same issue.
======================================================================

----------------------------------------------------------------------
 mda2376 - 04-20-06 20:10 
----------------------------------------------------------------------
Almost forgot,

lspci -nv
00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 8086:1112
        Flags: bus master, fast devsel, latency 0, IRQ 90
        Memory at a2200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-06 20:00 mda2376        New Issue                                    
04-20-06 20:00 mda2376        Distribution              => Gentoo          
04-20-06 20:00 mda2376        Kernel Version            => 2.6.15-gentoo-r7
04-20-06 20:10 mda2376        Note Added: 0009397                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
