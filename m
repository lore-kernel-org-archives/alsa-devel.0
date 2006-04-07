From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002008]: No Sound with snd-hda-intel driver Asus P5VDC-MX
Date: Fri, 7 Apr 2006 02:35:57 +0200
Message-ID: <ac9fdad9c5c023b859c6fe6e96dccfb8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F73C150
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 02:35:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2008> 
======================================================================
Reported By:                mborsick
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2008
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat/Fedora
Kernel Version:             2.6.16-1.2080 and with Xen
======================================================================
Date Submitted:             04-07-2006 00:43 CEST
Last Modified:              04-07-2006 02:35 CEST
======================================================================
Summary:                    No Sound with snd-hda-intel driver Asus P5VDC-MX
Description: 
Kernel is up-to-date Xen kernel.

Initial install did not recognize the sound on an ASUS P5VDC-MX
motherboard.
Motherboard has southbridge VIA VT8251. CODEC is Realtek ACL653 AC'97 6
channel
Audio. Tried the updated drivers in 002404, but was unsuccessful. Also
tried
drivers on VIA site and Realltek site. The last couple of tries show no
errors
in compiling, make, etc. However, as I am just above novice in
understanding
everything about Linux, this has thrown me for a loop.

======================================================================

----------------------------------------------------------------------
 mborsick - 04-07-06 02:13 
----------------------------------------------------------------------
lspci -vn output is as follows:

00:00.0 0600: 1106:0314
        Subsystem: 1106:0314
        Flags: bus master, medium devsel, latency 8
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [50] Power Management version 2

00:00.1 0600: 1106:1314
        Subsystem: 1106:1314
        Flags: bus master, medium devsel, latency 0

00:00.2 0600: 1106:2314
        Subsystem: 1106:2314
        Flags: bus master, medium devsel, latency 0

00:00.3 0600: 1106:3208
        Flags: bus master, medium devsel, latency 0

00:00.4 0600: 1106:4314
        Subsystem: 1106:4314
        Flags: bus master, medium devsel, latency 0

00:00.7 0600: 1106:7314
        Flags: bus master, medium devsel, latency 0

00:01.0 0604: 1106:b198
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: cff00000-dfefffff
        Capabilities: [70] Power Management version 2

00:0f.0 0101: 1106:3349 (prog-if 8f)
        Subsystem: 1106:3349
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at ec00 [size=8]
        I/O ports at e880 [size=4]
        I/O ports at e800 [size=8]
        I/O ports at e480 [size=4]
        I/O ports at e400 [size=16]
        Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [c0] Power Management version 2
        Capabilities: [e0] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:0f.1 0101: 1106:0571 (rev 07) (prog-if 8a)
        Subsystem: 1106:0571
        Flags: bus master, medium devsel, latency 32
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:10.0 0c03: 1106:3038 (rev 90)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at e080 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 90)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 64, IRQ 19
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 90)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 64, IRQ 20
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3038 (rev 90)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at d880 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 0c03: 1106:3104 (rev 90) (prog-if 20)
        Subsystem: 1106:3104
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at febff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
        Capabilities: [88] Debug port

00:11.0 0601: 1106:3287
        Subsystem: 1106:3287
        Flags: medium devsel
        Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 70)
        Subsystem: 1043:81b9
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2

00:11.7 0600: 1106:287e
        Subsystem: 1106:287e
        Flags: bus master, medium devsel, latency 128
        Capabilities: [58] HyperTransport: Interrupt Discovery and
Configuration
00:12.0 0200: 1106:3065 (rev 7c)
        Subsystem: 1043:80a7
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at d000 [size=256]
        Memory at febff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

00:13.0 0604: 1106:287b
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        Memory behind bridge: 20000000-200fffff

00:13.1 0604: 1106:287a (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0

01:00.0 0300: 10de:0185 (rev c1)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at feae0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:00.0 0604: 1106:287c
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        Capabilities: [40] Express Root Port (Slot-) IRQ 0
        Capabilities: [68] Power Management version 2
        Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [180] Unknown (5)

02:00.1 0604: 1106:287d
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        Capabilities: [40] Express Root Port (Slot-) IRQ 0
        Capabilities: [68] Power Management version 2
        Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [180] Unknown (5)

02:01.0 0403: 1106:3288
        Subsystem: 1043:818f
        Flags: fast devsel, IRQ 17
        Memory at 20000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [70] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 rlrevell - 04-07-06 02:35 
----------------------------------------------------------------------
Try adding { .subvendor = 0x1043, .subdevice = 0x81b9, .action =
VIA_DXS_SRC    } to the PCI ids in via82xx.c for the first device.

As for the "VIA high definition audio controller", I think that's a new
device that isn't supported yet.  tiwai?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 00:43 mborsick       New Issue                                    
04-07-06 00:43 mborsick       Distribution              => Redhat/Fedora   
04-07-06 00:43 mborsick       Kernel Version            => 2.6.16-1.2080 and
with Xen
04-07-06 01:07 rlrevell       Note Added: 0009129                          
04-07-06 02:13 mborsick       Note Added: 0009130                          
04-07-06 02:35 rlrevell       Note Added: 0009131                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
