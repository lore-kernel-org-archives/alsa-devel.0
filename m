From: noreply@alsa-project.org
Subject: [ALSA - utils 0000125]: aplay can not be compiled with newer versions of GCC
Date: Fri, 16 Jul 2004 12:59:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105929.7F0BA26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3B91244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:59:29 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000125
======================================================================
Reported By:                Jeff Law
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Bug ID:                     125
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-08-2004 18:59 CET
Last Modified:              07-16-2004 12:59 CEST
======================================================================
Summary:                    aplay can not be compiled with newer versions of GCC
Description: 
aplay.c relies upon a GCC extension that has been removed.
Specifically the "cast as lvalue" extension.
======================================================================

----------------------------------------------------------------------
 perex - 03-09-2004 18:51 CET 
----------------------------------------------------------------------
Patch was applied. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-08-04 18:59 Jeff Law       New Bug                                      
03-08-04 18:59 Jeff Law       File Added: alsa-utils-nolvalue.patch                    
03-09-04 18:49 perex          Assigned To               => perex           
03-09-04 18:49 perex          Status                   new => assigned     
03-09-04 18:51 perex          Bugnote Added: 0000557                       
03-09-04 18:51 perex          Resolution               open => fixed       
03-09-04 18:51 perex          Status                   assigned => resolved
07-16-04 12:59 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
