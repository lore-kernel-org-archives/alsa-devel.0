From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000482]: alsa.m4 AM_PATH_ALSA broken with libraries starting with m
Date: Tue, 9 Nov 2004 16:32:51 +0100
Message-ID: <3a7ca8102edb6311cc551210a06a561a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E5BB2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:32:51 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=482> 
======================================================================
Reported By:                nate
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   482
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-05-2004 22:26 CEST
Last Modified:              11-09-2004 16:32 CET
======================================================================
Summary:                    alsa.m4 AM_PATH_ALSA broken with libraries starting
with m
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
 tiwai - 09-08-04 17:17 
----------------------------------------------------------------------
We can simply remove these sed replacements.  It's nothing but an
optimization...

----------------------------------------------------------------------
 tiwai - 09-16-04 12:00 
----------------------------------------------------------------------
Removed these sed lines on cvs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-05-04 22:26 nate           New Issue                                    
09-08-04 17:17 tiwai          Note Added: 0001735                          
09-16-04 12:00 tiwai          Status                   new => resolved     
09-16-04 12:00 tiwai          Resolution               open => fixed       
09-16-04 12:00 tiwai          Assigned To               => tiwai           
09-16-04 12:00 tiwai          Note Added: 0001770                          
11-09-04 16:32 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
