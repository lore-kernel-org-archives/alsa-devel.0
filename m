From: noreply@alsa-project.org
Subject: [ALSA - driver 0000303]: dxs_support=4 working on my hardware
Date: Fri, 16 Jul 2004 13:00:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110042.E0B5E2600B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 77344244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:00:43 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000303
======================================================================
Reported By:                fxkuehl
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     303
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Debian Sarge
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-25-2004 11:30 CEST
Last Modified:              07-16-2004 13:00 CEST
======================================================================
Summary:                    dxs_support=4 working on my hardware
Description: 
lspci:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
lspci -n:
0000:00:11.5 Class 0401: 1106:3059 (rev 50)
======================================================================

----------------------------------------------------------------------
 tiwai - 05-25-2004 12:39 CEST 
----------------------------------------------------------------------
please provide the output of lspci -nv and the name of your board.

----------------------------------------------------------------------
 fxkuehl - 05-25-2004 13:43 CEST 
----------------------------------------------------------------------
lspci -nv:
0000:00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1071:8375
        Flags: medium devsel, IRQ 5
        I/O ports at e100
        Capabilities: [c0] Power Management version 2

It's in a notebook. Here's the lspci -v output for my host bridge and PCI
bridge. Hope this helps:

0000:00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
        Subsystem: Mitac: Unknown device 8375
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at a0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
 
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
(prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: e0000000-efffffff
        Prefetchable memory behind bridge: 90000000-9fffffff
        Expansion ROM at 0000c000 [disabled] [size=8K]
        Capabilities: [80] Power Management version 2
 
And the same with -nv:

0000:00:00.0 Class 0600: 1106:3156
        Subsystem: 1071:8375
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at a0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
 
0000:00:01.0 Class 0604: 1106:b091
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: e0000000-efffffff
        Prefetchable memory behind bridge: 90000000-9fffffff
        Expansion ROM at 0000c000 [disabled] [size=8K]
        Capabilities: [80] Power Management version 2

----------------------------------------------------------------------
 tiwai - 05-25-2004 14:45 CEST 
----------------------------------------------------------------------
thanks, the pci id is ok, but what is the name of your device, then?
a Mitac laptop?  i'll need the name for the comment.

----------------------------------------------------------------------
 fxkuehl - 05-25-2004 16:53 CEST 
----------------------------------------------------------------------
It's sort of a noname-laptop. It's labeled "Vobis" which is the name of the
computer store where I bought it. I found a very similar thing built by
Yakumo (same case, almost the same specs), so I guess you could call it a
Yakumo notebook. It's about a year old. This is the closest thing I could
find in the archives on the Yakumo website:

Yakumo Notebook Q8 Mobile XD 2000+
http://www.yakumo.de/produkte/index.php?pid=2&artnr=1019533

Except mine came with a 20GB HD and without a preinstalled OS (IBM DOS
;-).

----------------------------------------------------------------------
 tiwai - 05-25-2004 18:38 CEST 
----------------------------------------------------------------------
ok, fixed on cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 11:30 fxkuehl        New Bug                                      
05-25-04 11:30 fxkuehl        Distribution              => Debian Sarge    
05-25-04 11:30 fxkuehl        Kernel Version            => 2.6.6           
05-25-04 12:39 tiwai          Bugnote Added: 0001202                       
05-25-04 13:43 fxkuehl        Bugnote Added: 0001209                       
05-25-04 14:45 tiwai          Bugnote Added: 0001211                       
05-25-04 16:53 fxkuehl        Bugnote Added: 0001221                       
05-25-04 18:38 tiwai          Bugnote Added: 0001225                       
05-25-04 18:38 tiwai          Assigned To               => tiwai           
05-25-04 18:38 tiwai          Resolution               open => fixed       
05-25-04 18:38 tiwai          Status                   new => resolved     
07-16-04 13:00 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
