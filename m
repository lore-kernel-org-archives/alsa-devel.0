From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002123]: Power Management is broken following changes from 1.0.10 to 1.0.11.x versions
Date: Sat, 13 May 2006 18:27:46 +0200
Message-ID: <7471217c2e4b9dec38238265624176cb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 676E4141
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2006 18:27:46 +0200 (MEST)
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
Last Modified:              05-13-2006 18:27 CEST
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
 jovial - 05-13-06 17:41 
----------------------------------------------------------------------
i forgot to mention my chipset.
Chip: Realtek ALC260

----------------------------------------------------------------------
 rlrevell - 05-13-06 18:27 
----------------------------------------------------------------------
Try 2.6.17-rc4

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:37 jovial         New Issue                                    
05-13-06 17:37 jovial         Distribution              => gentoo          
05-13-06 17:37 jovial         Kernel Version            => 2.6.16          
05-13-06 17:41 jovial         Note Added: 0009797                          
05-13-06 18:27 rlrevell       Note Added: 0009798                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
