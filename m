From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000489]: With NForce [Patch] With NForce cards "modem" device does not exist.
Date: Wed,  8 Sep 2004 17:24:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908152411.0ED8013002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 875BD29D
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 17:27:38 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000489
======================================================================
Reported By:                sashak
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Bug ID:                     489
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             09-08-2004 17:14 CEST
Last Modified:              09-08-2004 17:24 CEST
======================================================================
Summary:                    With NForce [Patch] With NForce cards "modem" device does not exist.
Description: 
NFORCE-MODEM resonably does not defined in alsa-lib config (it is same as
ICH-MODEM). Since there is no configuration differences just common driver
name 'ICH-MODEM' may be always used.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-08-2004 17:24 CEST 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 17:14 sashak         New Bug                                      
09-08-04 17:14 sashak         File Added: ich_modem-config.patch                    
09-08-04 17:24 tiwai          Bugnote Added: 0001736                       
09-08-04 17:24 tiwai          Resolution               open => fixed       
09-08-04 17:24 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
