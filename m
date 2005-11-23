From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001535]: The sound card is detected. No sound from the speakers or headphones.
Date: Wed, 23 Nov 2005 20:45:35 +0100
Message-ID: <b96b2a4e562f24e3d0fe113386c4e5cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 033B71BA
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:45:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1535> 
======================================================================
Reported By:                h4ndr3s
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1535
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-08-2005 12:17 CET
Last Modified:              11-23-2005 20:45 CET
======================================================================
Summary:                    The sound card is detected. No sound from the
speakers or headphones.
Description: 
I have a Motherboard Intel D915GAV with a sound card Intel HDA onboard,
chipset Realtek ALC880. The Sound Card is detected, the modules are
loaded, but no sound come from the speakers or headphones. 
======================================================================

----------------------------------------------------------------------
 h4ndr3s - 11-15-05 12:19 
----------------------------------------------------------------------
Sorry for not to post in the past few days, but i dont have any time, and i
only can post from my job. Well, the 3stack-digout its supporting all the
functions of my card, so in this days i gives you the out from "lspci
-nv". See you later.

EDIT: Ok, here is the output from lspci -nv:

00:00.0 Class 0600: 8086:2580 (rev 04)
	Subsystem: 8086:4156
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

00:01.0 Class 0604: 8086:2581 (rev 04)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f4000000-fbffffff
	Prefetchable memory behind bridge: c0000000-dfffffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [a0] #10 [0141]

00:1b.0 Class 0403: 8086:2668 (rev 03)
	Subsystem: 8086:e203
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at f3afc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [70] #10 [0091]

00:1c.0 Class 0604: 8086:2660 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Memory behind bridge: f3c00000-f3cfffff
	Prefetchable memory behind bridge: 00000000bfc00000-00000000bfc00000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.1 Class 0604: 8086:2662 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Memory behind bridge: f3d00000-f3dfffff
	Prefetchable memory behind bridge: 00000000bfd00000-00000000bfd00000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.2 Class 0604: 8086:2664 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: f3e00000-f3efffff
	Prefetchable memory behind bridge: 00000000bfe00000-00000000bfe00000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.3 Class 0604: 8086:2666 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: f3f00000-f3ffffff
	Prefetchable memory behind bridge: 00000000bff00000-00000000bff00000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 Class 0c03: 8086:2658 (rev 03)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at cc00 [size=32]

00:1d.1 Class 0c03: 8086:2659 (rev 03)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at d000 [size=32]

00:1d.2 Class 0c03: 8086:265a (rev 03)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at d400 [size=32]

00:1d.3 Class 0c03: 8086:265b (rev 03)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at d800 [size=32]

00:1d.7 Class 0c03: 8086:265c (rev 03) (prog-if 20)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 20
	Memory at f3afbc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 Class 0604: 8086:244e (rev d3) (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	Memory behind bridge: f3b00000-f3bfffff
	Prefetchable memory behind bridge: 00000000bfb00000-00000000bfb00000
	Capabilities: [50] #0d [0000]

00:1f.0 Class 0601: 8086:2640 (rev 03)
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0

00:1f.1 Class 0101: 8086:266f (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: 8086:4156
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]

00:1f.2 Class 0101: 8086:2651 (rev 03) (prog-if 8f [Master SecP SecO PriP
PriO])
	Subsystem: 8086:4156
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 Class 0c05: 8086:266a (rev 03)
	Subsystem: 8086:4156
	Flags: medium devsel, IRQ 10
	I/O ports at c800 [size=32]

01:00.0 Class 0300: 10de:0141 (rev a2)
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
	Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Memory at f8000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [78] #10 [0001]

The 00:1b.0 is the Sound card. Well, if anything more is needed, just let
me know.



----------------------------------------------------------------------
 rlrevell - 11-23-05 20:45 
----------------------------------------------------------------------
Probably the same issue as bug #1563, which may be fixed in CVS, please
test.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 12:17 h4ndr3s        New Issue                                    
11-08-05 12:17 h4ndr3s        Distribution              => Slackware       
11-08-05 12:17 h4ndr3s        Kernel Version            => 2.6.13          
11-08-05 17:46 tiwai          Note Added: 0006627                          
11-09-05 12:18 h4ndr3s        Note Added: 0006645                          
11-09-05 12:24 h4ndr3s        Note Edited: 0006645                         
11-09-05 13:34 tiwai          Note Added: 0006648                          
11-09-05 14:22 h4ndr3s        Note Added: 0006653                          
11-10-05 16:00 jrgns          Note Added: 0006664                          
11-14-05 11:58 h4ndr3s        Note Added: 0006720                          
11-15-05 12:19 h4ndr3s        Note Edited: 0006720                         
11-23-05 20:45 rlrevell       Note Added: 0006831                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
