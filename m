From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001793]: No sound on ASUS A8N-VM CSM
Date: Mon, 13 Mar 2006 23:19:37 +0100
Message-ID: <f892928766f86e247d3fd1075d128317@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C393B1CF
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 23:19:37 +0100 (MET)
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
Last Modified:              03-13-2006 23:19 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001632 suse 10.0,  yast, no ad1986a listed,  i...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-13-06 17:56 
----------------------------------------------------------------------
If you still have the same problem with the CVS version, try to add
"model=laptop" module option manually.  If this solves the problem, let me
know the output of your laptop and the output of "lspci -nv".

----------------------------------------------------------------------
 tassilo80 - 03-13-06 23:19 
----------------------------------------------------------------------
Hi rlrevell, hi tiwai,

I tried the latest alsa-driver from CVS, but the don't work:

  * No sound at all (no internal speakers and no headphones)
    * with model=laptop: no sound, but alsamixer only has Master and PCM
  * My internal speakers are not listed

Heres the output of `lspci -nv':

(#:~)lspci -nv
00:00.0 0600: 8086:27a0 (rev 03)
        Subsystem: 144d:c024
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:01.0 0604: 8086:27a1 (rev 03)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge:
00000000c0000000-00000000cff00000
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at de400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:27d0 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.1 0604: 8086:27d2 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory behind bridge: de100000-de1fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.2 0604: 8086:27d4 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
        I/O behind bridge: 00005000-00005fff
        Prefetchable memory behind bridge:
00000000d2000000-00000000d3f00000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.3 0604: 8086:27d6 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=06, subordinate=07, sec-latency=0
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: da000000-dbffffff
        Prefetchable memory behind bridge:
00000000d4000000-00000000d5f00000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:27c8 (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 22
        I/O ports at 4800 [size=32]

00:1d.1 0c03: 8086:27c9 (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at 4820 [size=32]

00:1d.2 0c03: 8086:27ca (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 4840 [size=32]

00:1d.3 0c03: 8086:27cb (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 4860 [size=32]

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 22
        Memory at de404000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: de000000-de0fffff
        Prefetchable memory behind bridge:
0000000050000000-0000000051f00000
        Capabilities: [50] #0d [0000]

00:1f.0 0601: 8086:27b9 (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 4880 [size=16]

00:1f.3 0c05: 8086:27da (rev 02)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 5
        I/O ports at 48a0 [size=32]

01:00.0 0300: 10de:01d8 (rev a1)
        Subsystem: 144d:c024
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at dc000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [78] Express Endpoint IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting

03:00.0 0280: 8086:4222 (rev 02)
        Subsystem: 8086:1001
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at de100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 0f-31-09-ff-ff-02-13-00

08:05.0 0200: 14e4:170c (rev 02)
        Subsystem: 144d:c024
        Flags: bus master, fast devsel, latency 64, IRQ 21
        Memory at de000000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

08:09.0 0607: 1180:0476 (rev b4)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at de004000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=09, subordinate=0c, sec-latency=176
        Memory window 0: 50000000-51fff000 (prefetchable)
        Memory window 1: 52000000-53fff000 (prefetchable)
        I/O window 0: 00002000-000020ff
        I/O window 1: 00002400-000024ff
        16-bit legacy interface ports at 0001

08:09.1 0c00: 1180:0552 (rev 09) (prog-if 10)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at de002000 (32-bit, non-prefetchable) [disabled]
[size=2K]
        Capabilities: [dc] Power Management version 2

08:09.2 0805: 1180:0822 (rev 18)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at de002800 (32-bit, non-prefetchable) [disabled]
[size=256]
        Capabilities: [80] Power Management version 2

08:09.3 0880: 1180:0843
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at de002c00 (32-bit, non-prefetchable) [disabled]
[size=256]
        Capabilities: [80] Power Management version 2

08:09.4 0880: 1180:0592 (rev 09)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at de003000 (32-bit, non-prefetchable) [disabled]
[size=256]
        Capabilities: [80] Power Management version 2

08:09.5 0880: 1180:0852 (rev 04)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at de003400 (32-bit, non-prefetchable) [disabled]
[size=256]
        Capabilities: [80] Power Management version 2

@tiwai: What did you mean with "output of my laptop"?

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
02-05-06 06:32 gerick         Issue Monitored: gerick                      
02-06-06 20:16 quagga         Note Added: 0007951                          
02-08-06 13:04 simonckenyon   Issue Monitored: simonckenyon                    
02-13-06 14:00 ukrcald        Note Added: 0008048                          
02-13-06 14:56 awjb           Issue Monitored: awjb                        
02-13-06 15:02 awjb           Note Added: 0008051                          
02-13-06 21:29 chalvorson     Issue Monitored: chalvorson                    
03-01-06 13:09 tassilo80      Note Added: 0008280                          
03-01-06 13:13 tassilo80      Note Edited: 0008280                         
03-07-06 15:20 quagga         Issue Monitored: quagga                      
03-13-06 17:39 rlrevell       Relationship added       duplicate of 0001632
03-13-06 17:50 rlrevell       Note Added: 0008451                          
03-13-06 17:56 tiwai          Note Added: 0008452                          
03-13-06 23:19 tassilo80      Note Added: 0008467                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
