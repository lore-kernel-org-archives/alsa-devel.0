From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002149]: No sound, with Ensoniq 5880 AudioPCI
Date: Tue, 23 May 2006 18:29:07 +0200
Message-ID: <e59dcf7d604719e6ba03351d41c47e46@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBAAC15C
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 18:29:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2149> 
======================================================================
Reported By:                sergiopr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2149
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             kernel-2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 10:25 CEST
Last Modified:              05-23-2006 18:29 CEST
======================================================================
Summary:                    No sound, with Ensoniq 5880 AudioPCI
Description: 
After a fresh install of Fedora Core 5, firstboot and
system-config-souncard utilities correctly detect the sound card, but no
sound comes from the speakers.

Furthermore, aplay -l gives:
aplay: device_list:222: no soundcards found...
======================================================================

----------------------------------------------------------------------
 Raymond - 05-23-06 18:29 
----------------------------------------------------------------------
According to your dmesg

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 10 (level, low)
-> IRQ 10
PCI: Unable to reserve I/O region #1:40@de00 for device 0000:00:0c.0
ENS1371: probe of 0000:00:0c.0 failed with error -16

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 10:25 sergiopr       New Issue                                    
05-23-06 10:25 sergiopr       File Added: buginfo.tar.bz2                    
05-23-06 10:25 sergiopr       Kernel Version            =>
kernel-2.6.16-1.2111_FC5
05-23-06 18:29 Raymond        Note Added: 0009944                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
