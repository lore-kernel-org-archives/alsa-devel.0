From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000343]: au8820 hangs the system at
	some occasions
Date: Wed, 28 Jun 2006 11:48:20 +0200
Message-ID: <9e0fa716171bd1935ec99544ff120873@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07127251
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 11:48:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              06-28-2006 11:48 CEST
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
 sandman - 03-22-06 18:05 
----------------------------------------------------------------------
I'm sorry, but I no longer have that PC, so I can not check if this is
fixed. I saw a number of problems with the au88x0 driver on 64 bit
platform - it used to cause kernel panics back then until I made a small
change (it was something related to long being 64 bit on amd64 - I think I
even sent the patch once). Although the hangs were on both 32 and 64 bit
kernels.

----------------------------------------------------------------------
 Raymond - 06-28-06 11:48 
----------------------------------------------------------------------
It's possible for au88x0 to hang the computer if you open too many
applications especially OSS applications on 32/64 bits machines. 

This hang is more likely to happen in au8820 than au8810/au8830 since
au8820 only has 16 MIXIN and au8810/au8830 has 32 MIXIN 

Please note that if you follow the step in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2228 and use a browser to
open a flash, tons of error messages are generated in the system log
immediately.

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
03-23-06 08:59 Raymond        Note Added: 0008879                          
03-23-06 09:05 Raymond        Note Edited: 0008879                         
03-23-06 09:21 Raymond        Note Edited: 0008879                         
03-23-06 11:00 Raymond        Note Edited: 0008879                         
03-30-06 10:29 Raymond        Note Added: 0009025                          
03-30-06 10:30 Raymond        Note Deleted: 0009025                        
05-24-06 15:35 Raymond        Note Deleted: 0008879                        
06-28-06 11:48 Raymond        Note Added: 0010614                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
