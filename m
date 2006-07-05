From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001970]: Applied dff from 1596 fixed
	high pitched whine out of left chael but on shutdown crashes
	computer
Date: Thu, 6 Jul 2006 01:02:10 +0200
Message-ID: <8f126188bf33125f413b897ba7f81afd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B5BE24D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 01:02:10 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1970> 
======================================================================
Reported By:                dlm1065
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1970
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             03-28-2006 04:16 CEST
Last Modified:              07-06-2006 01:02 CEST
======================================================================
Summary:                    Applied dff from 1596 fixed high pitched whine out
of left chael but on shutdown crashes computer
Description: 
I made an ebuild adding the diff from
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1596 to get d of the
whine.

Ebuild fixes whine but shutdown does NOT release a lock on some resource
and comp locks up
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 19:16 
----------------------------------------------------------------------
Why it shows version 1.0.11rc3 even if you installed rc4?

----------------------------------------------------------------------
 dlm1065 - 03-30-06 01:38 
----------------------------------------------------------------------
Not sure and it's saying worse than that its saying 10r3 not 11r3 weird
checking to see if it pulled that bz in to create the driver maybe the
ebuild is fubar'd in some way checking

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 04:16 dlm1065        New Issue                                    
03-28-06 04:16 dlm1065        File Added: alsa-driver.tar.gz                    
03-28-06 04:16 dlm1065        Distribution              => Gentoo          
03-28-06 04:16 dlm1065        Kernel Version            => 2.6.16          
03-29-06 19:16 tiwai          Note Added: 0009012                          
03-30-06 01:38 dlm1065        Note Added: 0009020                          
07-06-06 01:02 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - hda-intel
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
