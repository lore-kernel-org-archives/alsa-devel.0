From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001793]: No sound on ASUS A8N-VM CSM
Date: Sun, 5 Feb 2006 06:26:47 +0100
Message-ID: <5d90f7cda569608923c1b134ce468740@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C61EF1AF
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 06:26:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1793> 
======================================================================
Reported By:                labene
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1793
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15 standard
======================================================================
Date Submitted:             01-29-2006 18:31 CET
Last Modified:              02-05-2006 06:26 CET
======================================================================
Summary:                    No sound on ASUS A8N-VM CSM
Description: 
No sound on ASUS A8N-VM CSM, chipset nForce 430 (HDA nvidia) don't have
sound on the speaker but found by kernel 2.6.15 and exist with alsamixer
!
I don't any issue in the line :
options snd-hda-intel model=???? position_fix=1

I don't know where is the problem !


cat /proc/asound/cards :
0 [NVidia         ]: HDA-Intel - HDA NVidia
                     HDA NVidia at 0xfebd8000 irq 5

lspci -nv :


0000:00:00.0 0500: 10de:02f0 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:00.1 0500: 10de:02fa (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.2 0500: 10de:02fe (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.3 0500: 10de:02f8 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.4 0500: 10de:02f9 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:00.5 0500: 10de:02ff (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:00.6 0500: 10de:027f (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.7 0500: 10de:027e (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:02.0 0604: 10de:02fc (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: <available only to root>

0000:00:03.0 0604: 10de:02fd (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: <available only to root>

0000:00:04.0 0604: 10de:02fb (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Capabilities: <available only to root>

0000:00:05.0 0300: 10de:0240 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Memory at fc000000 (64-bit, non-prefetchable) [size=16M]
        Expansion ROM at febe0000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:00:09.0 0500: 10de:0270 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:0a.0 0601: 10de:0260 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:0a.1 0c05: 10de:0264 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel, IRQ 5
        I/O ports at 0600 [size=64]
        I/O ports at 0700 [size=64]
        Capabilities: <available only to root>

0000:00:0b.0 0c03: 10de:026d (rev a2) (prog-if 10)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at febde000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:0b.1 0c03: 10de:026e (rev a2) (prog-if 20)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 3
        Memory at febdfc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:0d.0 0101: 10de:0265 (rev a1) (prog-if 8a [Master SecP PriP])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at ffa0 [size=16]
        Capabilities: <available only to root>

0000:00:0e.0 0101: 10de:0266 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at e800 [size=8]
        I/O ports at e480 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e080 [size=4]
        I/O ports at e000 [size=16]
        Memory at febdd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:0f.0 0101: 10de:0267 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at dc00 [size=8]
        I/O ports at d880 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at d480 [size=4]
        I/O ports at d400 [size=16]
        Memory at febdc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:10.0 0604: 10de:026f (rev a2) (prog-if 01)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=128
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: faa00000-faafffff
        Capabilities: <available only to root>

0000:00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

0000:00:18.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: <available only to root>

0000:00:18.1 0600: 1022:1101
        Flags: fast devsel

0000:00:18.2 0600: 1022:1102
        Flags: fast devsel

0000:00:18.3 0600: 1022:1103
        Flags: fast devsel

0000:04:05.0 0c00: 1106:3044 (rev 80) (prog-if 10)
        Subsystem: 1043:808a
        Flags: bus master, medium devsel, latency 128, IRQ 5
        Memory at faaff800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at cc00 [size=128]
        Capabilities: <available only to root>

0000:04:08.0 0200: 10ec:8139 (rev 10)
        Subsystem: 10ec:8139
        Flags: bus master, medium devsel, latency 128, IRQ 5
        I/O ports at c800 [size=256]
        Memory at faaff400 (32-bit, non-prefetchable) [size=256]

======================================================================

----------------------------------------------------------------------
 Arnaud Patard - 02-04-06 20:23 
----------------------------------------------------------------------
Lee, there was a similar patch send on alsa-devel@. Look for the thread
called "AD1986a". iirc Takashi said he'll try to contact AD about this.

[ Side note : afaik this bug is a dup of other open bugs reports ]

----------------------------------------------------------------------
 gerick - 02-05-06 06:26 
----------------------------------------------------------------------
RE: the patch
It was my understanding that the patch disables surround sound (5.1) and
gives only stereo.  So it is a work around only, not a solutions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-06 18:31 labene         New Issue                                    
01-29-06 18:31 labene         Distribution              => Debian          
01-29-06 18:31 labene         Kernel Version            => 2.6.15 standard 
01-29-06 18:54 labene         Note Added: 0007833                          
01-29-06 19:13 labene         Note Added: 0007834                          
02-01-06 15:38 thorstenl      Issue Monitored: thorstenl                    
02-04-06 02:20 rbenech        Issue Monitored: rbenech                     
02-04-06 02:23 rbenech        Note Added: 0007909                          
02-04-06 02:28 rbenech        Note Edited: 0007909                         
02-04-06 15:36 labene         Note Added: 0007916                          
02-04-06 15:44 labene         Note Edited: 0007916                         
02-04-06 19:15 rlrevell       Note Added: 0007920                          
02-04-06 20:23 Arnaud Patard  Note Added: 0007924                          
02-05-06 06:26 gerick         Note Added: 0007931                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
