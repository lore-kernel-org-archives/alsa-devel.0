From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000467]: Need quirk added for Sony S1XP laptop
Date: Thu, 26 Aug 2004 23:46:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040826214612.1F9D22500C@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 754211F6
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 23:46:12 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 2C2AC1B1E2
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 23:46:12 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000467
======================================================================
Reported By:                hadess
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     467
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               FC2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             08-26-2004 23:35 CEST
Last Modified:              08-26-2004 23:46 CEST
======================================================================
Summary:                    Need quirk added for Sony S1XP laptop
Description: 
Sound on the Sony S1XP only works with ac97_quirk=-1

lspci -vn output:
00:1f.5 Class 0401: 8086:24c5 (rev 03)
        Subsystem: 104d:8197
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at 1c00
        I/O ports at 18c0 [size=64]
        Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at d0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

Let me know if you need any more details.
======================================================================

----------------------------------------------------------------------
 hadess - 08-26-2004 23:37 CEST 
----------------------------------------------------------------------
Forgot that the driver is snd-intel8x0

----------------------------------------------------------------------
 hadess - 08-26-2004 23:46 CEST 
----------------------------------------------------------------------
My apologies, again. The quirk isn't needed. To get the sound working, the
"External Amplifier" needs to be disabled with:
$ amixer set 'External Amplifier' mute

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 23:35 hadess         New Bug                                      
08-26-04 23:35 hadess         Distribution              => FC2             
08-26-04 23:35 hadess         Kernel Version            => 2.6.6-1.435.2.3 
08-26-04 23:37 hadess         Bugnote Added: 0001638                       
08-26-04 23:46 hadess         Bugnote Added: 0001639                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
