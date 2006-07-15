From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001869]: Playing surround sound
	produces 100% CPU load
Date: Sat, 15 Jul 2006 05:09:25 +0200
Message-ID: <902705f6489716aa100c27b7adf7ebc8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4EB8A16F
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 05:09:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1869> 
======================================================================
Reported By:                bitmage2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1869
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 10.0
Kernel Version:             Linux 2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC
2006 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             02-23-2006 00:48 CET
Last Modified:              07-15-2006 05:09 CEST
======================================================================
Summary:                    Playing surround sound produces 100% CPU load
Description: 
I am using the CS46xx with a Hercules Gametheater XP 5.1 . It plays back
stereo without problems.
I wanted to use the rest of my 5.1 speaker set, so for a test I ran the
speaker-test program. Running it without parameters or with 2 or 4.0
channels works also fine. So far so good.

But when I run it with 5.0 channels or 5.1 channels the CPU load of
speaker-test goes to 100%. I'll show the output of top along with the
command lines below (for the 2.0 and 5.1 case) in the "Additional
Information" box.



======================================================================

----------------------------------------------------------------------
 rlrevell - 07-15-06 01:45 
----------------------------------------------------------------------
Well, you could just install over your current drivers, then if it does not
work, reinstall the version that your distro supplies.

"PS: I am still somewhat astonished, that a driver/library/whatsoever
being younger than a year cannot be fixed. Actually, if installing drivers
wouldn't be so complicated and time-wating on Linux, I wouldn't care so
much. :-|"

Sorry, that's just how Linux works.  There is very limited manpower to
support an insane amount of hardware and we don't have the resources to go
back and fix 50 old versions every time a bug is found.  If you want
support for the latest and greatest hardware you need to run a recent
version.  A year is a LONG time in the Linux world.

----------------------------------------------------------------------
 Raymond - 07-15-06 05:09 
----------------------------------------------------------------------
Please post output of

cat /proc/asound/pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 00:48 bitmage2       New Issue                                    
02-23-06 00:48 bitmage2       Distribution              => SuSE Linux 10.0 
02-23-06 00:48 bitmage2       Kernel Version            => Linux
2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC 2006 i686 athlon i386 GNU/Linux
02-23-06 00:54 bitmage2       Note Added: 0008164                          
02-23-06 00:55 bitmage2       Issue Monitored: bitmage2                    
07-11-06 05:58 Raymond        Note Added: 0010964                          
07-14-06 20:57 bitmage2       Note Added: 0011004                          
07-14-06 20:59 bitmage2       Note Added: 0011005                          
07-14-06 21:25 rlrevell       Note Added: 0011006                          
07-14-06 22:40 bitmage2       Note Added: 0011008                          
07-14-06 22:57 rlrevell       Note Added: 0011009                          
07-15-06 01:28 bitmage2       Note Added: 0011013                          
07-15-06 01:45 rlrevell       Note Added: 0011014                          
07-15-06 05:09 Raymond        Note Added: 0011017                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
