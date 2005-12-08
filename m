From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001534]: Mixer channel problems
Date: Thu, 8 Dec 2005 17:23:44 +0100
Message-ID: <5dc0c06d90f4cb189d161bc0e2f2dc5f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3ADCB173
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 17:23:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1534> 
======================================================================
Reported By:                mrblur
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1534
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.14
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-08-2005 08:41 CET
Last Modified:              12-08-2005 17:23 CET
======================================================================
Summary:                    Mixer channel problems
Description: 
I'm using Acer AS5002WLMi with SiS 7012 soundcard. It works quite good,
but... unfortunately if I would like to change sound volume I have to do
it on headphones channel, master channel stereo/mona are not working.
======================================================================

----------------------------------------------------------------------
 mrblur - 12-07-05 22:07 
----------------------------------------------------------------------
00:00.0 Class 0600: 1039:0760 (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at e0000000 (32-bit, non-prefetchable) [size=32M]
	Capabilities: [a0] AGP version 3.0
	Capabilities: [d0] #08 [0120]
	Capabilities: [f0] #08 [8000]

00:01.0 Class 0604: 1039:0002
	Flags: bus master, 66Mhz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e2100000-e21fffff
	Prefetchable memory behind bridge: e8000000-efffffff

00:02.0 Class 0601: 1039:0963 (rev 25)
	Flags: bus master, medium devsel, latency 0

00:02.5 Class 0101: 1039:5513 (prog-if 80 [Master])
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 128, IRQ 185
	I/O ports at 2000 [size=16]

00:02.6 Class 0703: 1039:7013 (rev a0)
	Subsystem: 1025:0083
	Flags: medium devsel, IRQ 177
	I/O ports at 1000 [size=256]
	I/O ports at 1c00 [size=128]
	Capabilities: [48] Power Management version 2

00:02.7 Class 0401: 1039:7012 (rev a0)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 173, IRQ 177
	I/O ports at 1400 [size=256]
	I/O ports at 1c80 [size=128]
	Capabilities: [48] Power Management version 2

00:03.0 Class 0c03: 1039:7001 (rev 0f) (prog-if 10)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 64, IRQ 201
	Memory at e2002000 (32-bit, non-prefetchable) [size=4K]

00:03.1 Class 0c03: 1039:7001 (rev 0f) (prog-if 10)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 64, IRQ 209
	Memory at e2003000 (32-bit, non-prefetchable) [size=4K]

00:03.2 Class 0c03: 1039:7002 (prog-if 20)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 64, IRQ 193
	Memory at e2004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2

00:04.0 Class 0200: 1039:0900 (rev 91)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 173, IRQ 169
	I/O ports at 1800 [size=256]
	Memory at e2005000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 34000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2

00:06.0 Class 0607: 104c:ac50 (rev 02)
	Subsystem: 1025:0083
	Flags: bus master, medium devsel, latency 168, IRQ 169
	Memory at 34020000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001

00:0b.0 Class 0280: 14e4:4318 (rev 02)
	Subsystem: 1468:0312
	Flags: fast devsel, IRQ 4
	Memory at e2000000 (32-bit, non-prefetchable) [size=8K]

00:18.0 Class 0600: 1022:1100
	Flags: fast devsel
	Capabilities: [80] #08 [2101]

00:18.1 Class 0600: 1022:1101
	Flags: fast devsel

00:18.2 Class 0600: 1022:1102
	Flags: fast devsel

00:18.3 Class 0600: 1022:1103
	Flags: fast devsel

01:00.0 Class 0300: 1039:6330
	Subsystem: 1025:0083
	Flags: 66Mhz, medium devsel, IRQ 7
	BIST result: 00
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at e2100000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a000 [size=128]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 3.0

----------------------------------------------------------------------
 tiwai - 12-08-05 17:23 
----------------------------------------------------------------------
This seems to have been already fixed in the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 08:41 mrblur         New Issue                                    
11-08-05 08:41 mrblur         Kernel Version            => 2.6.14          
11-08-05 17:48 tiwai          Note Added: 0006628                          
11-28-05 13:48 mrblur         Note Added: 0006859                          
11-28-05 18:51 tiwai          Note Added: 0006863                          
11-29-05 09:22 mrblur         Note Added: 0006871                          
12-06-05 09:40 mrblur         Note Added: 0006921                          
12-06-05 15:51 tiwai          Note Added: 0006924                          
12-07-05 22:07 mrblur         Note Added: 0006949                          
12-08-05 17:23 tiwai          Status                   new => resolved     
12-08-05 17:23 tiwai          Resolution               open => fixed       
12-08-05 17:23 tiwai          Assigned To               => tiwai           
12-08-05 17:23 tiwai          Note Added: 0006959                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
