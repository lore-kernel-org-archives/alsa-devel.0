From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000482]: alsa.m4 AM_PATH_ALSA broken with libraries starting with m
Date: Sun,  5 Sep 2004 22:26:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040905202605.A46B63B005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7F71926D
	for <alsa-devel@alsa-project.org>; Sun,  5 Sep 2004 22:26:49 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id C50721D48D
	for <alsa-devel@alsa-project.org>; Sun,  5 Sep 2004 22:26:05 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000482
======================================================================
Reported By:                nate
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     482
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-05-2004 22:26 CEST
Last Modified:              09-05-2004 22:26 CEST
======================================================================
Summary:                    alsa.m4 AM_PATH_ALSA broken with libraries starting with m
Description: 
The macro for checking the path of the alsa lib is broken.  If the existing
LIBS includes any libraries that start with 'm', they are clobbered:

56: 	  LIBS=`echo $LIBS | sed 's/-lm//'`
57:   	  LIBS=`echo $LIBS | sed 's/-ldl//'`
58:  	  LIBS=`echo $LIBS | sed 's/-lpthread//'`
59: 	  LIBS=`echo $LIBS | sed 's/ //'`
60:       LIBS="$ALSA_LIBS $LIBS"

There should be a better way of accomplishing this.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-05-04 22:26 nate           New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
