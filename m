From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000448]: System hangs up
Date: Mon, 23 Aug 2004 14:59:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040823125926.7760A1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CDB9E2D7
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 14:59:26 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000448
======================================================================
Reported By:                zadnica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     448
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-17-2004 13:02 CEST
Last Modified:              08-23-2004 14:59 CEST
======================================================================
Summary:                    System hangs up
Description: 
Systems hangs up, when modules snd-via82xx is loaded. When I using OSS
module via82cxxx_audio everything works fine.
======================================================================

----------------------------------------------------------------------
 sventura - 08-22-2004 09:51 CEST 
----------------------------------------------------------------------
same crash on vaio pcg-fxa78 VT/82C686 AC97
havent tried propoused "via82cxxx_audio" preload workaround
verified in ver: from 0.9.2 to 1.0.5a
native 2.4 kernel oss support works ok, so I compared initialization
sequences
and made this (attached) quick patch-module workaround. It's not a final
solution but provides a close idea as of what is missing in current code
initialization sequence.

----------------------------------------------------------------------
 tiwai - 08-23-2004 14:59 CEST 
----------------------------------------------------------------------
Does the attached patch fix?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-17-04 13:02 zadnica        New Bug                                      
08-22-04 09:51 sventura       Bugnote Added: 0001607                       
08-22-04 09:52 sventura       File Added: myvia82xx.tar.gz                    
08-23-04 14:59 tiwai          Bugnote Added: 0001611                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
