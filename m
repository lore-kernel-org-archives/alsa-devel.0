From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000432]: Impossible de se connecter : NODIALTONE
Date: Wed, 25 Aug 2004 19:11:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825171115.2785014025@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98AAF291
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 19:11:15 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000432
======================================================================
Reported By:                Cyrille
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     432
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10
Kernel Version:             2.4.24
======================================================================
Date Submitted:             08-08-2004 19:02 CEST
Last Modified:              08-25-2004 19:11 CEST
======================================================================
Summary:                    Impossible de se connecter : NODIALTONE
Description: 
I've got a TOSHIBA SATELITTE A30 222 laptop
Sound card and modem are based upon ATI IXP
But I'm not able to run modem in spite of the differents bug-report on
ALSA web site
(https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000422
-
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
 -
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000417
) and on Unixtrix.com (http://www.unixtrix.com/)

Even if I do like Ronis or Netstar say -bugtrack.alsa-project :
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
-, I'm always in the same situation : compilation is OK, modem driver OK
but I'm not able to connect : NODIALTONE
======================================================================

----------------------------------------------------------------------
 sashak - 08-25-2004 19:11 CEST 
----------------------------------------------------------------------
There is similar problem - some BIOSes doesn't report valid MODEM_PRESENT
bit in ATI_REG_CMD register (reg 003, bit 27 - look in
'/proc/asound/card1/atiixp'). Device behaviuor in this case is identical
to reported here - DMA works ok, line still be disconnected.

Uploaded patch solves the problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 19:02 Cyrille        New Bug                                      
08-08-04 19:02 Cyrille        Distribution              => Slackware 10    
08-08-04 19:02 Cyrille        Kernel Version            => 2.4.24          
08-08-04 19:02 Cyrille        Bug Monitored: Cyrille                       
08-25-04 19:04 sashak         File Added: atiixp_modem.patch                    
08-25-04 19:11 sashak         Bugnote Added: 0001624                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
