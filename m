From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001603]: via8235 no sound since kernel 2.6.13
Date: Wed, 1 Mar 2006 19:39:41 +0100
Message-ID: <06f8f9f0d89d68c38ddfae3945ab30d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E233D1B7
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 19:39:41 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1603> 
======================================================================
Reported By:                picobyte
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1603
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               slackware 10.2
Kernel Version:             2.6.13 - 2.6.14.2
Resolution:                 fixed
Fixed in Version:           1.0.11rc3
======================================================================
Date Submitted:             11-27-2005 15:06 CET
Last Modified:              03-01-2006 19:39 CET
======================================================================
Summary:                    via8235 no sound since kernel 2.6.13
Description: 
I have no sound after a kernel upgrade. I seem to have lost it in 2.6.13.
Sound was available in 2.6.12. 2.6.14.2 didn't give sound either. The
problem is in 1.0.9b and 1.0.10. The modules are loaded as supposed
without error messages and alsamixer is set to volume.
======================================================================

----------------------------------------------------------------------
 picobyte - 01-18-06 00:41 
----------------------------------------------------------------------
yes, actually, the problem seems to have been resolved in 2.6.15 :)
Is there any way I can/should change this bugs' status?



----------------------------------------------------------------------
 picobyte - 03-01-06 19:27 
----------------------------------------------------------------------
It wasn't the kernel upgrade, but the upgrade to alsa 1.0.11-rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-05 15:06 picobyte       New Issue                                    
11-27-05 15:06 picobyte       Distribution              => slackware 10.2  
11-27-05 15:06 picobyte       Kernel Version            => 2.6.13 - 2.6.14.2
12-31-05 03:38 rlrevell       Note Added: 0007330                          
01-18-06 00:38 picobyte       Note Added: 0007704                          
01-18-06 00:38 picobyte       Issue Monitored: picobyte                    
01-18-06 00:39 picobyte       Issue End Monitor: picobyte                    
01-18-06 00:41 picobyte       Note Edited: 0007704                         
03-01-06 19:27 picobyte       Note Added: 0008287                          
03-01-06 19:39 rlrevell       Status                   new => resolved     
03-01-06 19:39 rlrevell       Fixed in Version          => 1.0.11rc3       
03-01-06 19:39 rlrevell       Resolution               open => fixed       
03-01-06 19:39 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
