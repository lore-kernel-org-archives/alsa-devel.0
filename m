From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001603]: via8235 no sound since kernel 2.6.13
Date: Wed, 18 Jan 2006 00:38:20 +0100
Message-ID: <7db098be268bd73ee28c4040da6fa183@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5152816C
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 00:38:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1603> 
======================================================================
Reported By:                picobyte
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1603
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware 10.2
Kernel Version:             2.6.13 - 2.6.14.2
======================================================================
Date Submitted:             11-27-2005 15:06 CET
Last Modified:              01-18-2006 00:38 CET
======================================================================
Summary:                    via8235 no sound since kernel 2.6.13
Description: 
I have no sound after a kernel upgrade. I seem to have lost it in 2.6.13.
Sound was available in 2.6.12. 2.6.14.2 didn't give sound either. The
problem is in 1.0.9b and 1.0.10. The modules are loaded as supposed
without error messages and alsamixer is set to volume.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:38 
----------------------------------------------------------------------
Any improvement with later releases?

----------------------------------------------------------------------
 picobyte - 01-18-06 00:38 
----------------------------------------------------------------------
yes, actually, the problem seems to have been resolved in 2.6.15 :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-05 15:06 picobyte       New Issue                                    
11-27-05 15:06 picobyte       Distribution              => slackware 10.2  
11-27-05 15:06 picobyte       Kernel Version            => 2.6.13 - 2.6.14.2
12-31-05 03:38 rlrevell       Note Added: 0007330                          
01-18-06 00:38 picobyte       Note Added: 0007704                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
