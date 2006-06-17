From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001603]: via8235 no sound since kernel
	2.6.13
Date: Sat, 17 Jun 2006 10:14:42 +0200
Message-ID: <2b5cc987b5a163bb0f5b94df4db65937@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14E0917C
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 10:14:42 +0200 (MEST)
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
Status:                     feedback
Distribution:               slackware 10.2
Kernel Version:             2.6.13 - 2.6.14.2
======================================================================
Date Submitted:             11-27-2005 15:06 CET
Last Modified:              06-17-2006 10:14 CEST
======================================================================
Summary:                    via8235 no sound since kernel 2.6.13
Description: 
I have no sound after a kernel upgrade. I seem to have lost it in 2.6.13.
Sound was available in 2.6.12. 2.6.14.2 didn't give sound either. The
problem is in 1.0.9b and 1.0.10. The modules are loaded as supposed
without error messages and alsamixer is set to volume.
======================================================================

----------------------------------------------------------------------
 PitSid - 06-17-06 09:06 
----------------------------------------------------------------------
VIA8235 is still not working, running Alsa 1.0.11 and kernel 2.6.16.19,
Slackware-10.2. Everything looks to be allright but there is no sound at
all.
Any ideas ???

----------------------------------------------------------------------
 Raymond - 06-17-06 10:14 
----------------------------------------------------------------------
Please post the output of


cat /proc/asound/card0/codec97#0/ac97#0-0+regs

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
03-04-06 14:23 picobyte       Status                   resolved => feedback
03-04-06 14:23 picobyte       Resolution               fixed => reopened   
03-04-06 14:23 picobyte       Note Added: 0008348                          
06-03-06 16:02 picobyte       Note Added: 0010062                          
06-17-06 09:06 PitSid         Note Added: 0010264                          
06-17-06 10:14 Raymond        Note Added: 0010265                          
======================================================================
