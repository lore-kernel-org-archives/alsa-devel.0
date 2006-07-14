From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000949]: Randomly,
	left and right tracks are swaped
Date: Fri, 14 Jul 2006 21:01:14 +0200
Message-ID: <f4bddb7b3e6d94d1d657417ba0a3060b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA882197
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 21:01:14 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=949> 
======================================================================
Reported By:                NorbertB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   949
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:              2.4.21-20.ELsmp
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-28-2005 00:08 CET
Last Modified:              07-14-2006 21:01 CEST
======================================================================
Summary:                    Randomly, left and right tracks are swaped
Description: 
I'm running ALSA 1.0.8 on an APro 6224 (AMD8111, ac97' chipset Realtek
ALC655).
alsamixer is on, I can hear my audio OK but sometimes, randomly, left and
right channels are swapped.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000059 On au8820 left and right channels are s...
has duplicate       0000403 intel8x0 driver swaps channels
======================================================================

----------------------------------------------------------------------
 phox - 03-23-05 02:30 
----------------------------------------------------------------------
I should mention that I (the reporter of bug 0000403 mentioned above) am
also using an AMD8111-based board, the Tyan Thunder K8W (S2885ANRF), and
of course using the integrated Analog Devices 1981B chip.

----------------------------------------------------------------------
 jdthood - 12-13-05 12:50 
----------------------------------------------------------------------
NorbertB, phox: Any improvement in 1.0.10?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-05 00:08 NorbertB       New Issue                                    
02-28-05 00:08 NorbertB       Kernel Version            =>  2.4.21-20.ELsmp
03-22-05 22:30 jdthood        Relationship added       has duplicate 0000403
03-22-05 22:33 jdthood        Relationship added       related to 0000059  
03-23-05 02:30 phox           Note Added: 0004149                          
12-13-05 12:50 jdthood        Note Added: 0007004                          
07-14-06 21:01 Adrian Bunk    Status                   new => resolved     
07-14-06 21:01 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
