From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002123]: Power Management is broken following changes from 1.0.10 to 1.0.11.x versions
Date: Sun, 14 May 2006 02:32:42 +0200
Message-ID: <d729e50c930ff21d1cfd5b0f95487d81@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 90DB8173
	for <alsa-devel@alsa-project.org>; Sun, 14 May 2006 02:32:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2123> 
======================================================================
Reported By:                jovial
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2123
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             05-13-2006 17:37 CEST
Last Modified:              05-14-2006 02:32 CEST
======================================================================
Summary:                    Power Management is broken following changes from
1.0.10 to 1.0.11.x versions
Description: 
I had linux kernel 2.6.15 on my machine (with alsa version 1.0.10).
I could place my laptop on standby while playing music, and onced resumed
the playback would also continue..... proper functionality and power
management.

following an upgrade to kernel 2.6.16 with latest patches (includes alsa
1.0.11-rc4), the power management does not function correctly.
basically, i have to restart the alsasound service after resume to have
any sound again.
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-14-06 00:27 
----------------------------------------------------------------------
It sounds like an upstream kernel bug.  What are the exact symptoms (dmesg
output, etc) when you try to suspend?

----------------------------------------------------------------------
 jovial - 05-14-06 02:32 
----------------------------------------------------------------------
2.6.17-rc4 is too unstable for my system.
the kernels 2.6.15 and 2.6.16 (which i have) are heavily patched to enable
suspend-to-ram and other features working on my system.

if you feel a newer version of alsa is the solution to this problem,
i can try compiling cvs snapshot of alsa-kernel module (from alsa-project
cvs tree) and integrating it with kernel 2.6.16; unless you feel 2.6.16 is
too old for that...

alternatively, if you think my problem is kernel related and the 2.6.17 is
the solution, i'll go after fixing my suspend feature... that'll take some
time, and i don't want to hassle you with kernel bugs/etc....

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:37 jovial         New Issue                                    
05-13-06 17:37 jovial         Distribution              => gentoo          
05-13-06 17:37 jovial         Kernel Version            => 2.6.16          
05-13-06 17:41 jovial         Note Added: 0009797                          
05-13-06 18:27 rlrevell       Note Added: 0009798                          
05-14-06 00:11 jovial         Note Added: 0009801                          
05-14-06 00:27 rlrevell       Note Added: 0009802                          
05-14-06 02:32 jovial         Note Added: 0009804                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
