From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000437]: Problem with the spec file
Date: Fri, 13 Aug 2004 10:52:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040813085241.016031102E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 61AE5287
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 10:52:42 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 1596117A2F
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 10:52:42 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000437
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     437
Category:                   OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             08-13-2004 09:56 CEST
Last Modified:              08-13-2004 10:52 CEST
======================================================================
Summary:                    Problem with the spec file
Description: 
There is a problem the spec file generated with the configure.

you might replace this line in alsa-driver.spec.in :
/lib/modules/*/kernel/*
by :
/lib/modules/*/misc/*


======================================================================

----------------------------------------------------------------------
 croiset - 08-13-2004 10:52 CEST 
----------------------------------------------------------------------
There is some more modification in the spec file :

%build
KVER=`uname -r`
%configure --with-moddir=/lib/modules/$KVER/misc

It will permit to install the modules in the good directory KVER instead
of KVERcustom.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-13-04 09:56 croiset        New Bug                                      
08-13-04 09:56 croiset        Kernel Version            => 2.4.7-10        
08-13-04 10:52 croiset        Bugnote Added: 0001561                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
