From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000482]: alsa.m4 AM_PATH_ALSA broken with libraries starting with m
Date: Wed,  8 Sep 2004 17:17:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908151747.C04CC13002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 18F9A29D
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 17:17:50 +0200 (MEST)
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
Last Modified:              09-08-2004 17:17 CEST
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

----------------------------------------------------------------------
 tiwai - 09-08-2004 17:17 CEST 
----------------------------------------------------------------------
We can simply remove these sed replacements.  It's nothing but an
optimization...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-05-04 22:26 nate           New Bug                                      
09-08-04 17:17 tiwai          Bugnote Added: 0001735                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
