From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001603]: via8235 no sound since kernel
	2.6.13
Date: Mon, 26 Jun 2006 22:56:44 +0200
Message-ID: <8b6e162bb4c29c307ae45d72f52f61df@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04EFD17A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 22:56:44 +0200 (MEST)
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
Last Modified:              06-26-2006 22:56 CEST
======================================================================
Summary:                    via8235 no sound since kernel 2.6.13
Description: 
I have no sound after a kernel upgrade. I seem to have lost it in 2.6.13.
Sound was available in 2.6.12. 2.6.14.2 didn't give sound either. The
problem is in 1.0.9b and 1.0.10. The modules are loaded as supposed
without error messages and alsamixer is set to volume.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-17-06 17:22 
----------------------------------------------------------------------
Please post the output of

cat /proc/asound/cards

cat /proc/asound/card0/codec97#0/ac97#0-0+regs



----------------------------------------------------------------------
 picobyte - 06-26-06 22:56 
----------------------------------------------------------------------
I am sorry but I am not on the computer with the problem, and it doesn't
have internet, so I am unable to post the requested files. But, I solved
the problem at last, I had to mute headphone and then it worked. While
this seems something logical, it is not so straightforward when you're
using a headphone.

I am not sure wether other problems were also bugging at first, there are
more people reporting issues possibly version related, but this did solve
it after several upgrades of alsa and kernel.

I am using another sounddevice as well now, b.t.w. : an audigy 2 platinum
ex, and thats working now as well.

Thanks for reading.

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
06-17-06 17:22 Raymond        Note Edited: 0010265                         
06-26-06 22:56 picobyte       Note Added: 0010562                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
