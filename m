From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001301]: Kernel OSS emulation stops
	working after a few seconds when used with VoIP softphones
Date: Sat, 1 Jul 2006 17:22:59 +0200
Message-ID: <9ae938400a56f40ecf89e0371b82b93b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DB1B243
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 17:22:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1301> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1301
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             vanilla 2.6.11.12, vanilla 2.6.10 and Debians
2.6.8-2
======================================================================
Date Submitted:             08-02-2005 17:16 CEST
Last Modified:              07-01-2006 17:22 CEST
======================================================================
Summary:                    Kernel OSS emulation stops working after a few
seconds when used with VoIP softphones
Description: 
Kernel OSS emulation fails a few seconds after a call is established when
used with kphone(Debian) or iaxcomm(self made) softphones. Examining the
process using strace reveals, that the file descriptor of the sound device
is no longer listed in the readset or writeset when the select() syscall
returns. Audio Playback using XMMS is working fine using the OSS API
 
Also the native OSS driver is working fine with both VoIP phones on the
same system and kernel.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001300 modprobe goes into D-state when inserti...
======================================================================

----------------------------------------------------------------------
 tek01 - 11-07-05 13:20 
----------------------------------------------------------------------
Sorry for the long delay. I've been very busy during the last few month.

I did some tests further with Linux 2.6.14 vanilla with preemtion either
enabled or disabled using the in kernel ALSA, ALSA 1.0.10rc2 and ALSA CVS
from last Friday.
The problem is still the same as described in my first report independent
from preemtion and ALSA version used.
I also removed the card from my AMD K7@800 and plugged it into an old
Pentium 133 running a Debian Linux 2.6.8 kernel without any noticable
difference.



----------------------------------------------------------------------
 Adrian Bunk - 07-01-06 17:22 
----------------------------------------------------------------------
Is this issue still present in kernel 2.6.17?

If yes, can you check whether it also occurs when using aoss?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:16 tek01          New Issue                                    
08-02-05 17:16 tek01          Distribution              => Debian Sarge    
08-02-05 17:16 tek01          Kernel Version            => vanilla 2.6.11.12,
vanilla 2.6.10 and Debians 2.6.8-2
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-03-05 10:10 perex          Relationship added       related to 0001300  
08-03-05 10:47 perex          Note Added: 0005614                          
08-05-05 11:20 tek01          Note Added: 0005664                          
08-18-05 13:18 perex          Note Added: 0005847                          
10-31-05 17:44 rlrevell       Note Added: 0006587                          
11-07-05 13:00 tek01          Note Added: 0006613                          
11-07-05 13:20 tek01          Note Edited: 0006613                         
07-01-06 17:22 Adrian Bunk    Note Added: 0010763                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
