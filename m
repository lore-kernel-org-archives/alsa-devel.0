From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000611]: Can't access Digi32 with kernel 2.6.9
Date: Wed, 10 Nov 2004 12:08:26 +0100
Message-ID: <72e1a31fea9651b4c9cf73f1ae467353@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 18256241
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 12:08:27 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=611> 
======================================================================
Reported By:                spirou
Assigned To:                martin
======================================================================
Project:                    ALSA - driver
Issue ID:                   611
Category:                   PCI - RME 32
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9-gentoo-r1
======================================================================
Date Submitted:             10-27-2004 03:44 CEST
Last Modified:              11-10-2004 12:08 CET
======================================================================
Summary:                    Can't access Digi32 with kernel 2.6.9
Description: 
The Driver for the digi32 in kernel 2.6.9 doesn't let me access the card.
All I get is a "Device busy". With 2.6.8 everything is fine.
lsmod shows the driver as loaded, permissions are the same as with 2.6.8.
======================================================================

----------------------------------------------------------------------
 martin - 11-10-04 11:04 
----------------------------------------------------------------------
Oh, I haven't noticed this bugreport here...
I think you see some kind of mmap bug (aka bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=209) here.
See https://bugtrack.alsa-project.org/alsa-bug/view.php?id=209

----------------------------------------------------------------------
 tiwai - 11-10-04 12:08 
----------------------------------------------------------------------
Does this happen on yours, Martin?
It sounds like the app reopen the device before closing properly.

If this problem is reproducible, please try strace to check which call
sequence triggers the problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 03:44 spirou         New Issue                                    
10-27-04 03:44 spirou         Distribution              => Gentoo Linux    
10-27-04 03:44 spirou         Kernel Version            => 2.6.9-gentoo-r1 
11-09-04 19:16 tiwai          Note Added: 0002341                          
11-10-04 02:47 spirou         Note Added: 0002354                          
11-10-04 11:04 martin         Note Added: 0002360                          
11-10-04 12:08 tiwai          Note Added: 0002363                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
