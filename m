From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002149]: No sound,
	with Ensoniq 5880 AudioPCI
Date: Fri, 26 May 2006 10:38:26 +0200
Message-ID: <976896ff93ad3e2dc9ad46a4307ea48d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 890EB153
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 10:38:26 +0200 (MEST)
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
Last Modified:              05-26-2006 10:38 CEST
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

----------------------------------------------------------------------
 sergiopr - 05-26-06 10:38 
----------------------------------------------------------------------
It seems to be a problem with acpi. The souncard works booting with
acpi=off in the kernel line. Please, close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 10:25 sergiopr       New Issue                                    
05-23-06 10:25 sergiopr       File Added: buginfo.tar.bz2                    
05-23-06 10:25 sergiopr       Kernel Version            =>
kernel-2.6.16-1.2111_FC5
05-23-06 18:29 Raymond        Note Added: 0009944                          
05-26-06 10:38 sergiopr       Note Added: 0009974                          
======================================================================
