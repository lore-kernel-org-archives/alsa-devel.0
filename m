From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002234]: ISA sscape driver does not
	find Soundscape Elite
Date: Thu, 29 Jun 2006 23:17:42 +0200
Message-ID: <576fab7f654a810c8edcf698e5466554@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B01EE2A6
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 23:17:42 +0200 (MEST)
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
Last Modified:              06-29-2006 23:17 CEST
======================================================================
Summary:                    ISA sscape driver does not find Soundscape Elite
Description: 
The ALSA driver builds fine, both as a module and built-in but
the driver does not find the Soundscape Elite card.
======================================================================

----------------------------------------------------------------------
 rankincj - 06-29-06 23:14 
----------------------------------------------------------------------
What does it say in the kernel log when you try and load the snd-sscape
module? As far as I can see, the driver should write something as soon as
it hits a problem. You can examine the kernel log by running the "dmesg"
command.

----------------------------------------------------------------------
 rankincj - 06-29-06 23:17 
----------------------------------------------------------------------
You need to create the following device node, if it doesn't already exist:

crw------- 1 root root 116, 4 Jun 19 20:46 /dev/snd/hwC0D0

And the sscape_ctl program must be run as root.

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
