From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000368]: vxpocket.c missing from 1.0.5 releases
Date: Tue,  7 Sep 2004 16:40:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907144050.68CEEE01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D188128E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:40:50 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000368
======================================================================
Reported By:                benjif
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     368
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 duplicate
Duplicate:                  379
======================================================================
Date Submitted:             07-06-2004 18:40 CEST
Last Modified:              09-07-2004 16:40 CEST
======================================================================
Summary:                    vxpocket.c missing from 1.0.5 releases
Description: 
The file pcmcia/vx/vxpocket.c is missing from 1.0.5rc1, 1.0.5, and 1.0.5a. 
This causes make to fail when attempting to build the vxp440 driver. 
1.0.4 builds just fine with the same ./configure line.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-06-04 18:40 benjif         New Bug                                      
09-07-04 16:40 perex          duplicate_id             0 => 379            
09-07-04 16:40 perex          Resolution               open => duplicate   
09-07-04 16:40 perex          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
