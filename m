From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001135]: Build regression 1.0.9rc4a -> 1.0.9 on 2.4.2[012] kernels (usbmidi.c patching).
Date: Tue, 9 Aug 2005 13:46:21 +0200
Message-ID: <b112055115f6b2d0d2f3f0c49fc2914e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B1D6E219
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:46:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1135> 
======================================================================
Reported By:                thimm
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1135
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.20-22
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-28-2005 09:52 CEST
Last Modified:              08-09-2005 13:46 CEST
======================================================================
Summary:                    Build regression 1.0.9rc4a -> 1.0.9 on 2.4.2[012]
kernels (usbmidi.c patching).
Description: 
Trying to build alsa-driver 1.0.9 on any 2.4 based RHL (7.3 to 9), FC1 or
RHEL3 kernel the build aborts with:

patching file usbmidi.c
Hunk #2 FAILED at 288.
1 out of 4 hunks FAILED -- saving rejects to file usbmidi.c.rej
make[2]: *** [usbmidi.c] Error 1
make[2]: Leaving directory `/var/tmp/BUILD/alsa-driver-1.0.9/usb'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/var/tmp/BUILD/alsa-driver-1.0.9'


======================================================================

----------------------------------------------------------------------
 ZlatkO - 05-28-05 12:04 
----------------------------------------------------------------------
Trivial patch attached. :-)

----------------------------------------------------------------------
 tiwai - 05-31-05 12:57 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 09:52 thimm          New Issue                                    
05-28-05 09:52 thimm          Kernel Version            => 2.4.20-22       
05-28-05 11:57 ZlatkO         Note Added: 0004761                          
05-28-05 12:03 ZlatkO         File Added: alsa-driver-1.0.9.diff                
   
05-28-05 12:04 ZlatkO         Note Added: 0004762                          
05-31-05 12:57 tiwai          Status                   assigned => resolved
05-31-05 12:57 tiwai          Resolution               open => fixed       
05-31-05 12:57 tiwai          Note Added: 0004824                          
08-09-05 13:46 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
