From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000453]: it is impossible to select spdif as capture source
Date: Wed, 25 Aug 2004 19:55:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825175552.7C6C214026@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C6686257
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 19:55:52 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000453
======================================================================
Reported By:                Andrew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     453
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-18-2004 13:16 CEST
Last Modified:              08-25-2004 19:55 CEST
======================================================================
Summary:                    it is impossible to select spdif as capture source
Description: 
There are no anything spdif-input-related among
capture source enumeration.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 19:55 CEST 
----------------------------------------------------------------------
Did you use 'iec958' pcm?

    % arecord -Diec958 -fdat foo.wav

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 13:16 Andrew         New Bug                                      
08-25-04 19:55 tiwai          Bugnote Added: 0001625                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
