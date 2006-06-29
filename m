From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002234]: ISA sscape driver does not
	find Soundscape Elite
Date: Fri, 30 Jun 2006 01:45:30 +0200
Message-ID: <790c3b8a61058db51173fb8b4faf93c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 742BB2AA
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 01:45:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2234> 
======================================================================
Reported By:                tjallen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2234
Category:                   ISA - sscape
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.2
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             06-26-2006 15:52 CEST
Last Modified:              06-30-2006 01:45 CEST
======================================================================
Summary:                    ISA sscape driver does not find Soundscape Elite
Description: 
The ALSA driver builds fine, both as a module and built-in but
the driver does not find the Soundscape Elite card.
======================================================================

----------------------------------------------------------------------
 rankincj - 06-29-06 23:17 
----------------------------------------------------------------------
You need to create the following device node, if it doesn't already exist:

crw------- 1 root root 116, 4 Jun 19 20:46 /dev/snd/hwC0D0

And the sscape_ctl program must be run as root.

----------------------------------------------------------------------
 tjallen - 06-30-06 01:45 
----------------------------------------------------------------------
I thought that I had found the problem when I just noticed that
/etc/modules.conf should have port=0x534 instead of port=0x539, but fixing
that goof didn't help
the snd-sscape module to find the hardware;
the kernel log still said "sscape: hardware not detected at 0x534".
I do have /dev/snd/hwC0D0, but with different owner and permissions:
crw-rw-r--  1 root audio 116, 4 2003-08-29 03:47 /dev/snd/hwC0D0
I did run the sscape_ctl program as root.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 15:52 tjallen        New Issue                                    
06-26-06 15:52 tjallen        Distribution              => Slackware 10.2  
06-26-06 15:52 tjallen        Kernel Version            => 2.6.17.1        
06-26-06 22:57 Adrian Bunk    Issue Monitored: Adrian Bunk                    
06-28-06 23:25 rankincj       Note Added: 0010628                          
06-29-06 00:40 tjallen        Note Added: 0010630                          
06-29-06 17:57 tiwai          Note Added: 0010679                          
06-29-06 20:30 tjallen        Note Added: 0010701                          
06-29-06 23:14 rankincj       Note Added: 0010703                          
06-29-06 23:17 rankincj       Note Added: 0010704                          
06-30-06 01:45 tjallen        Note Added: 0010708                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
