From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000343]: au8820 hangs the system at some occasions
Date: Thu, 25 Aug 2005 18:51:58 +0200
Message-ID: <d3878b54e18fe1f1a9314488c86a04fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DA7E1FF
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 18:51:58 +0200 (MEST)
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
Last Modified:              08-25-2005 18:51 CEST
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
 sandman - 04-19-05 09:47 
----------------------------------------------------------------------
I currently have FC3 (with alsa-lib 1.0.6) on my box and the problem
remains.
A good way to reproduce this is by having firefox display a site with
flash that
uses sound and run xine at the same time

----------------------------------------------------------------------
 Raymond - 08-25-05 18:51 
----------------------------------------------------------------------
Do ALSA support dual Opteron (Dual CPU) ?

The CVS version include the patch "Fixed missing spin_unlock" which may
fix your problem.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
