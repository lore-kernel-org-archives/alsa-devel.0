From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001649]: No surround sound on ICH5 (AC'97 AD1980)
Date: Wed, 14 Dec 2005 02:41:04 +0100
Message-ID: <9a0e2dd65f42852cd2d6e51a70f0fce3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CA54196
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 02:41:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1649> 
======================================================================
Reported By:                znerd
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1649
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-14-2005 02:37 CET
Last Modified:              12-14-2005 02:41 CET
======================================================================
Summary:                    No surround sound on ICH5 (AC'97 AD1980)
Description: 
I cannot get my AC'97 device (AD1980) to produce any sound other than
stereo output. I have tried various settings on alsamixer and I used
various speaker-test forms to validate settings. When I use:

   speaker-test -Dplug:surround40 -c4

then I hear just Front-Left and Front-Right. There is total silence on the
rear channels. I plugged the rear speakers plug into the 2nd sound output
jack.

Some hints would be appreciated. I have been searching around the internet
and have found other issues regarding the AD1980, but not this one. I do
realize it may be my setup that's wrong, but the chance is getting quite
small by now.
======================================================================

----------------------------------------------------------------------
 znerd - 12-14-05 02:41 
----------------------------------------------------------------------
Here's the output of lspci -nv:

00:00.0 0600: 8086:2578 (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] Vendor Specific Information
        Capabilities: [a0] AGP version 3.0

00:01.0 0604: 8086:2579 (rev 02)
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fd000000-feafffff
        Prefetchable memory behind bridge: d8000000-efffffff

00:1d.0 0c03: 8086:24d2 (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at ff80 [size=32]

00:1d.1 0c03: 8086:24d4 (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at ff60 [size=32]

00:1d.2 0c03: 8086:24d7 (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at ff40 [size=32]

00:1d.3 0c03: 8086:24de (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at ff20 [size=32]

00:1d.7 0c03: 8086:24dd (rev 02) (prog-if 20)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 18
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 0604: 8086:244e (rev c2)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fce00000-fcffffff
        Prefetchable memory behind bridge: 50000000-500fffff

00:1f.0 0601: 8086:24d0 (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 0101: 8086:24db (rev 02) (prog-if 8a)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]
        Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

00:1f.2 0101: 8086:24d1 (rev 02) (prog-if 8f)
        Subsystem: 1028:0156
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
        I/O ports at fe00 [size=8]
        I/O ports at fe10 [size=4]
        I/O ports at fe20 [size=8]
        I/O ports at fe30 [size=4]
        I/O ports at fea0 [size=16]

00:1f.3 0c05: 8086:24d3 (rev 02)
        Subsystem: 1028:0156
        Flags: medium devsel, IRQ 10
        I/O ports at eda0 [size=32]

00:1f.5 0401: 8086:24d5 (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at ee00 [size=256]
        I/O ports at edc0 [size=64]
        Memory at febffa00 (32-bit, non-prefetchable) [size=512]
        Memory at febff900 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 0300: 10de:0326 (rev a1)
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 19
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        [virtual] Expansion ROM at fea00000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:02.0 0100: 9005:0010
        Subsystem: 9005:a180
        Flags: bus master, medium devsel, latency 64, IRQ 17
        BIST result: 00
        I/O ports at de00 [disabled] [size=256]
        Memory at fcedf000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

02:0c.0 0200: 8086:100e (rev 02)
        Subsystem: 1028:0156
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
        Memory at fcee0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at ddc0 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-14-05 02:37 znerd          New Issue                                    
12-14-05 02:37 znerd          Distribution              => Gentoo Linux    
12-14-05 02:37 znerd          Kernel Version            => 2.6.14          
12-14-05 02:41 znerd          Note Added: 0007026                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
