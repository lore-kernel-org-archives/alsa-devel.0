From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000343]: au8820 hangs the system at some occasions
Date: Tue, 19 Apr 2005 10:03:48 +0200
Message-ID: <b4078b658e0e3472faa6891d5edc0ebe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 042441EB
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 10:03:48 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
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
Last Modified:              04-19-2005 10:03 CEST
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
 jdthood - 04-07-05 21:04 
----------------------------------------------------------------------
Submitter: Has there been any improvement with later ALSA releases?

----------------------------------------------------------------------
 sandman - 04-19-05 09:47 
----------------------------------------------------------------------
I currently have FC3 (with alsa-lib 1.0.6) on my box and the problem
remains.
A good way to reproduce this is by having firefox display a site with
flash that
uses sound and run xine at the same time

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
