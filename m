From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001135]: Build regression 1.0.9rc4a -> 1.0.9 on 2.4.2[012] kernels (usbmidi.c patching).
Date: Sat, 28 May 2005 09:52:10 +0200
Message-ID: <ed8481c8f55af414d154f4bc6c703858@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C09C1220
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 09:52:10 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Status:                     assigned
Distribution:               
Kernel Version:             2.4.20-22
======================================================================
Date Submitted:             05-28-2005 09:52 CEST
Last Modified:              05-28-2005 09:52 CEST
======================================================================
Summary:                    Build regression 1.0.9rc4a -> 1.0.9 on 2.4.2[012]
kernels (usbmidi.c patching).
Description: 
Trying to build alsa-driver 1.0.9 on any 2.4 based RHL (7.3 to 9), FC1 or
RHEL3 kernel the build aborts with:

patching file usbmidi.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 FAILED at 288.
1 out of 4 hunks FAILED -- saving rejects to file usbmidi.c.rej
make[2]: *** [usbmidi.c] Error 1
make[2]: Leaving directory `/var/tmp/BUILD/alsa-driver-1.0.9/usb'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/var/tmp/BUILD/alsa-driver-1.0.9'


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 09:52 thimm          New Issue                                    
05-28-05 09:52 thimm          Kernel Version            => 2.4.20-22       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
