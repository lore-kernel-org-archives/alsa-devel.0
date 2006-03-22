From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000343]: au8820 hangs the system at some occasions
Date: Wed, 22 Mar 2006 18:05:34 +0100
Message-ID: <e3ad8dc787251bb6b1fa2e05bc1e9638@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4FC019F
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 18:05:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=343> 
======================================================================
Reported By:                sandman
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   343
Category:                   PCI - au88x0
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     acknowledged
Distribution:               RedHat 9
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-23-2004 07:20 CEST
Last Modified:              03-22-2006 18:05 CET
======================================================================
Summary:                    au8820 hangs the system at some occasions
Description: 
At some occasions the system hangs without any means
to recover other than reset button. No mouse, no pings and
even the alt-SysRq feature doesn't help.
As a result I reboot the system a few times a day (sometimes).
The problem is present in 2.6.5, 2.6.6 and 2.6.7 kernels at
least. 
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:01 
----------------------------------------------------------------------
Was this problem solved in later ALSA releases?

----------------------------------------------------------------------
 sandman - 03-22-06 18:05 
----------------------------------------------------------------------
I'm sorry, but I no longer have that PC, so I can not check if this is
fixed. I saw a number of problems with the au88x0 driver on 64 bit
platform - it used to cause kernel panics back then until I made a small
change (it was something related to long being 64 bit on amd64 - I think I
even sent the patch once). Although the hangs were on both 32 and 64 bit
kernels.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-04 07:20 sandman        New Issue                                    
06-23-04 07:20 sandman        Distribution              => RedHat 9        
06-23-04 07:20 sandman        Kernel Version            => 2.6.7           
04-07-05 21:04 jdthood        Note Added: 0004370                          
04-12-05 20:26 alien999999999 Issue Monitored: alien999999999                   

04-19-05 09:47 sandman        Note Added: 0004519                          
04-19-05 10:03 jdthood        Status                   assigned => acknowledged
08-25-05 18:51 Raymond        Note Added: 0005942                          
03-22-06 03:01 rlrevell       Note Added: 0008789                          
03-22-06 18:05 sandman        Note Added: 0008864                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
