From: noreply@alsa-project.org
Subject: [ALSA - driver 0000136]: Fatal uninstall script
Date: Fri, 16 Jul 2004 12:48:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104812.480F926008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80827255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:48:12 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000136
======================================================================
Reported By:                idea
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     136
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               Mandrake
Kernel Version:             2.6.3-4mdk
======================================================================
Date Submitted:             03-15-2004 11:43 CET
Last Modified:              07-16-2004 12:48 CEST
======================================================================
Summary:                    Fatal uninstall script
Description: 
When uninstalling alsa driver with 'make uninstall', complete
/lib/modules/`uname -r`/kernel/sound directory is deleted, including
important soundcore.ko and other modules. This means, no other (or even
alsa again) sound driver could be installed and loaded (many unresolved
symbols apear in dmesg).
======================================================================

----------------------------------------------------------------------
 perex - 03-27-2004 14:02 CET 
----------------------------------------------------------------------
Fixed in CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 11:43 idea           New Bug                                      
03-15-04 11:43 idea           Distribution              => Mandrake        
03-15-04 11:43 idea           Kernel Version            => 2.6.3-4mdk      
03-27-04 14:02 perex          Bugnote Added: 0000711                       
03-27-04 14:02 perex          Resolution               open => fixed       
03-27-04 14:02 perex          Status                   assigned => resolved
07-16-04 12:48 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
