From: noreply@alsa-project.org
Subject: [ALSA - driver 0000132]: Build error making rpms
Date: Fri, 16 Jul 2004 12:44:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104420.4034C26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A4DD4255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:44:20 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000132
======================================================================
Reported By:                simbad
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     132
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Red Hat 9
Kernel Version:             2.4.20-8
======================================================================
Date Submitted:             03-14-2004 13:57 CET
Last Modified:              07-16-2004 12:44 CEST
======================================================================
Summary:                    Build error making rpms
Description: 
Launching ./build rpms causes the error unknow option -ba, the buildrpm
scripts use rpm -ba <specfile> and not rpmbuild -ba <specfile>, this is
also for alsa-lib and alsa-utils.
======================================================================

----------------------------------------------------------------------
 perex - 03-14-2004 18:15 CET 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-14-04 13:57 simbad         New Bug                                      
03-14-04 13:57 simbad         Distribution              => Red Hat 9       
03-14-04 13:57 simbad         Kernel Version            => 2.4.20-8        
03-14-04 18:15 perex          Bugnote Added: 0000601                       
03-14-04 18:15 perex          Resolution               open => fixed       
03-14-04 18:15 perex          Status                   assigned => resolved
07-16-04 12:44 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
