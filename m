From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000435]: No current support for the ICH6R & ALC880 devices
Date: Thu, 12 Aug 2004 07:32:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040812053200.6D8CC1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1094A0
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2004 07:32:00 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000435
======================================================================
Reported By:                snaketails
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     435
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-12-2004 02:50 CEST
Last Modified:              08-12-2004 07:32 CEST
======================================================================
Summary:                    No current support for the ICH6R & ALC880 devices
Description: 
As this is a new mobo, there is no driver configuration that supports this
newer buss interface devices, so there is no sound from the mobo.
The inability for the mobo to run SATA under Linux is not an issue here,
as I am using the SiS SATA driver, only issue is sound
======================================================================

----------------------------------------------------------------------
 pzad - 08-12-2004 07:32 CEST 
----------------------------------------------------------------------
I think in ALSA 1.0.6rc2 is driver for HD audio (azx module). Try it.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 02:50 snaketails     New Bug                                      
08-12-04 02:50 snaketails     Distribution              => Gentoo          
08-12-04 02:50 snaketails     Kernel Version            => 2.6.7           
08-12-04 07:32 pzad           Bugnote Added: 0001551                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
