From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001103]: Please support /dev/snd/aload* as well
Date: Tue, 13 Dec 2005 12:33:53 +0100
Message-ID: <797331836efa5bc828b9acbe4be38427@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9A8C1C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:33:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1103> 
======================================================================
Reported By:                jordi
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1103
Category:                   0_general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-13-2005 13:49 CEST
Last Modified:              12-13-2005 12:33 CET
======================================================================
Summary:                    Please support /dev/snd/aload* as well
Description: 
Currently, alsa-lib looks for aload* files in /dev.

I think it would be nice if these files could live in /dev/snd, with the
rest of ALSA devices.

Can alsa-lib be modified to support aload* devices in both /dev and
/dev/snd?

Maybe in the future, after people have transitioned, support for
/dev/aload* could be dropped. Defaulting to /dev/snd and falling back to
/dev could be the way to work for now.

The udev maintainer thinks this would be a good enhancement.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-13-05 19:46 
----------------------------------------------------------------------
More exactly: the problem is by the combination of udev + aload + resmgr +
modprobe, IIRC.

----------------------------------------------------------------------
 jdthood - 12-13-05 12:33 
----------------------------------------------------------------------
Wontfix

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-05 13:49 jordi          New Issue                                    
05-13-05 14:15 tiwai          Note Added: 0004644                          
05-13-05 15:36 jdthood        Note Added: 0004649                          
05-13-05 19:45 tiwai          Note Added: 0004653                          
05-13-05 19:46 tiwai          Note Added: 0004654                          
05-24-05 14:02 jdthood        Severity                 minor => feature    
12-13-05 12:33 jdthood        Status                   new => closed       
12-13-05 12:33 jdthood        Note Added: 0006994                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
