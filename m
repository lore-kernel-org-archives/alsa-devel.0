From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000871]: Distortion in sound output.
Date: Mon, 14 Feb 2005 17:19:23 +0100
Message-ID: <3f03e99348bac9b492afce46ab05a199@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7F19A17C
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 17:19:23 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=871> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   871
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Sarge
Kernel Version:             2.6.8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-31-2005 21:18 CET
Last Modified:              02-14-2005 17:19 CET
======================================================================
Summary:                    Distortion in sound output.
Description: 
There is distortion in the sound output. This occurs in two ways.

1) When the volume in the mixers gets set to high (i.e. into the red)
there is severe distortion in the sound.

2) Occasionally i notice a distortion in the right channel. Not too sure
how to describe it other than its like an intermittant buzz, and isn't
supposed to be in the music.

If you need any more info, gimme a shout. I'm new at this.
======================================================================

----------------------------------------------------------------------
 Mutant_Fruit - 02-14-05 17:15 
----------------------------------------------------------------------
Here's the contents of lspci -nv:
0000:00:00.0 0600: 8086:3580 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, fast devsel, latency 0
        Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] 0000009 [8105]

0000:00:00.1 0880: 8086:3584 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, fast devsel, latency 0

0000:00:00.3 0880: 8086:3585 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, fast devsel, latency 0

0000:00:02.0 0300: 8086:3582 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Memory at faf80000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at c000 [size=8]
        Capabilities: [d0] Power Management version 1

0000:00:02.1 0380: 8086:3582 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Memory at faf00000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1

0000:00:1d.0 0c03: 8086:24c2 (rev 01)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf80 [size=32]

0000:00:1d.1 0c03: 8086:24c4 (rev 01)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf40 [size=32]

0000:00:1d.2 0c03: 8086:24c7 (rev 01)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf20 [size=32]

0000:00:1d.7 0c03: 8086:24cd (rev 01) (prog-if 20)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at faeffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] 0a [2080]

0000:00:1e.0 0604: 8086:2448 (rev 81)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fc000000-fdffffff

0000:00:1f.0 0601: 8086:24cc (rev 01)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 0101: 8086:24ca (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at bfa0 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 0401: 8086:24c5 (rev 01)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 0, IRQ 7
        I/O ports at d800 [size=256]
        I/O ports at dc40 [size=64]
        Memory at faeff800 (32-bit, non-prefetchable) [size=512]
        Memory at faeff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:01:01.0 0607: 104c:ac44 (rev 02)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:01:01.1 0c00: 104c:8029 (prog-if 10)
        Subsystem: 1028:0163
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fcfff800 (32-bit, non-prefetchable) [size=2K]
        Memory at fcff8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:01:03.0 0280: 8086:4220 (rev 05)
        Subsystem: 8086:2722
        Flags: bus master, medium devsel, latency 32, IRQ 7
        Memory at fcffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

0000:01:08.0 0200: 8086:103d (rev 81)
        Subsystem: 1028:2002
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fcffd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ecc0 [size=64]
        Capabilities: [dc] Power Management version 2

----------------------------------------------------------------------
 tiwai - 02-14-05 17:19 
----------------------------------------------------------------------
It's same as https://bugtrack.alsa-project.org/alsa-bug/view.php?id=872 ?  Then
now fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:18 Mutant_Fruit   New Issue                                    
01-31-05 21:18 Mutant_Fruit   Distribution              => Debian Sarge    
01-31-05 21:18 Mutant_Fruit   Kernel Version            => 2.6.8           
02-02-05 11:21 tiwai          Note Added: 0003484                          
02-05-05 01:33 Mutant_Fruit   Note Added: 0003517                          
02-13-05 17:21 Mutant_Fruit   Note Added: 0003585                          
02-14-05 16:11 tiwai          Note Added: 0003592                          
02-14-05 17:15 Mutant_Fruit   Note Added: 0003601                          
02-14-05 17:19 tiwai          Status                   new => resolved     
02-14-05 17:19 tiwai          Resolution               open => fixed       
02-14-05 17:19 tiwai          Assigned To               => tiwai           
02-14-05 17:19 tiwai          Note Added: 0003602                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
