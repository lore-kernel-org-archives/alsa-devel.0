From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001872]: Riptide firmware loading fails on my hardware
Date: Thu, 2 Mar 2006 15:52:27 +0100
Message-ID: <803c8511cdbd1ef85229539335b87861@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4A731CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 15:52:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1872> 
======================================================================
Reported By:                hobbified
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1872
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             Various, this data from 2.6.15-rc2-ck2
======================================================================
Date Submitted:             02-23-2006 03:10 CET
Last Modified:              03-02-2006 15:52 CET
======================================================================
Summary:                    Riptide firmware loading fails on my hardware
Description: 
When I try to use the snd-riptide module on this machine (actually a
friend's), it fails to load the firmware properly, and so the module
doesn't initialize. The device has PCI ID 127a:4310, which isn't in the
PCI database, but the other function of the same device has ID 4311, which
reports as a Riptide modem. It's an onboard device in an HP Presario. The
problem is the same on 1.0.10 and 1.0.11rc3, but I used rc3 to produce the
debugging output below. Also, I used the 'riptide.hex' firmware from the
linuxant distribution (riptide-0.6lnxtbeta03122800), which I verified to
be the same as in the Windows driver.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 15:52 
----------------------------------------------------------------------
Try the CVS version.  Some bugs on riptide driver were fixed, including the
support of a differentl model.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 03:10 hobbified      New Issue                                    
02-23-06 03:10 hobbified      File Added: log.txt                          
02-23-06 03:10 hobbified      Distribution              => Ubuntu          
02-23-06 03:10 hobbified      Kernel Version            => Various, this data
from 2.6.15-rc2-ck2
02-23-06 09:22 hobbified      Issue Monitored: hobbified                    
03-02-06 15:52 tiwai          Note Added: 0008313                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
