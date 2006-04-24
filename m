From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002021]: No sound from speakers (only headphone) after resume to suspend-to-ram
Date: Mon, 24 Apr 2006 16:44:44 +0200
Message-ID: <82f72dbed1fb1dede5ecf604491419e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA0A116F
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 16:44:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2021> 
======================================================================
Reported By:                tsaiming
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2021
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             suspend2-2.6.16-r2
======================================================================
Date Submitted:             04-15-2006 13:19 CEST
Last Modified:              04-24-2006 16:44 CEST
======================================================================
Summary:                    No sound from speakers (only headphone) after resume
to suspend-to-ram
Description: 
After suspend2-to-ram (but it happens also with the suspend kernel built
in) I have no more sound from speakers but only from headphones.
With suspend to disk all works good 
Also tried to stop alsasound and unload modules before suspending and
restart service after resume with no change.

======================================================================

----------------------------------------------------------------------
 mmp - 04-22-06 15:14 
----------------------------------------------------------------------
I have made snapshot of register states just before and just after resume;
attaching diff.

----------------------------------------------------------------------
 tiwai - 04-24-06 16:44 
----------------------------------------------------------------------
Try to restore the values of 0x5a, 0x5e and 0x60 via proc file after
resume, such as (only by root)

    # echo 5a 8221 > /proc/asound/card0/codec97#0/ac97#0-0+regs

Note that this is available only when the drivers are built with debug
option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-06 13:19 tsaiming       New Issue                                    
04-15-06 13:19 tsaiming       File Added: codec97#0.txt                    
04-15-06 13:19 tsaiming       Distribution              => Gentoo          
04-15-06 13:19 tsaiming       Kernel Version            => suspend2-2.6.16-r2
04-22-06 15:12 mmp            Issue Monitored: mmp                         
04-22-06 15:14 mmp            Note Added: 0009435                          
04-22-06 15:15 mmp            File Added: regs.diff                        
04-24-06 16:44 tiwai          Note Added: 0009470                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
