From: noreply@alsa-project.org
Subject: [ALSA - driver 0000260]: "make clean" cleans to good ...
Date: Fri, 16 Jul 2004 12:58:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105844.8F6A126008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C675D244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:58:44 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000260
======================================================================
Reported By:                prodigy7
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     260
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.5
======================================================================
Date Submitted:             05-07-2004 09:46 CEST
Last Modified:              07-16-2004 12:58 CEST
======================================================================
Summary:                    "make clean" cleans to good ...
Description: 
I'd found following reproducable problem:
When i'd call the configure script, found my kernel and sets symlinks and
then i call "make clean", the clean delete the version.h from
include/linux ... ok, I'd backups where i can restore the file, but i
think, it shouln'd be :-)
======================================================================

----------------------------------------------------------------------
 tiwai - 05-28-2004 17:05 CEST 
----------------------------------------------------------------------
fixed on 1.0.5.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-07-04 09:46 prodigy7       New Bug                                      
05-07-04 09:46 prodigy7       Kernel Version            => 2.6.5           
05-28-04 17:05 tiwai          Bugnote Added: 0001268                       
05-28-04 17:05 tiwai          Assigned To              perex => tiwai      
05-28-04 17:05 tiwai          Resolution               open => fixed       
05-28-04 17:05 tiwai          Status                   assigned => resolved
07-16-04 12:58 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
