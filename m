From: noreply@alsa-project.org
Subject: [ALSA - utils 0000100]: arecord has a limit on the --duration-setting
Date: Fri, 16 Jul 2004 14:31:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123101.6057D2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B1401244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:31:01 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000100
======================================================================
Reported By:                centic
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Bug ID:                     100
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             02-29-2004 11:22 CET
Last Modified:              07-16-2004 14:31 CEST
======================================================================
Summary:                    arecord has a limit on the --duration-setting
Description: 
When I try to record a full day into a file by specifying --duration=86400
as duration, arecord just writes 44 bytes to the file and exits without
any error message!
======================================================================

----------------------------------------------------------------------
 perex - 03-09-2004 14:26 CET 
----------------------------------------------------------------------
Attached patch will solve this problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-29-04 11:22 centic         New Bug                                      
02-29-04 11:24 centic         Bug Monitored: centic                        
02-29-04 19:37 perex          Assigned To               => perex           
02-29-04 19:37 perex          Status                   new => assigned     
03-09-04 14:26 perex          File Added: aplay.patch                      
03-09-04 14:26 perex          Bugnote Added: 0000544                       
03-09-04 14:26 perex          Resolution               open => fixed       
03-09-04 14:26 perex          Status                   assigned => resolved
07-16-04 14:31 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
