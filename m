From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000637]: Laptop volume control & mute buttons don't work
Date: Tue, 9 Nov 2004 10:35:14 +0100
Message-ID: <b29fb260259bc8de7d7b8a1ea890371f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1570259
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 10:35:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=637> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   637
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2-mm4-VP-S7-noACPI-UMP
======================================================================
Date Submitted:             11-08-2004 18:50 CET
Last Modified:              11-09-2004 10:35 CET
======================================================================
Summary:                    Laptop volume control & mute buttons don't work
Description: 
The Compaq, like may laptops, comes with buttons to increase and decrease
volume, as well as a mute button. Under Linux these buttons do nothing.
The mute button is always lit even when sound is coming out. The volume
control buttons do not adjust volume.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 10:35 
----------------------------------------------------------------------
Usually these buttons are controlled over ACPI.
In some cases, you can get a key event in X server, then you can configure
the window manager to do the right thing.

Anyway, this is not a bug or a missing feature of the sound driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-04 18:50 Mark Knecht    New Issue                                    
11-08-04 18:50 Mark Knecht    Distribution              => Gentoo          
11-08-04 18:50 Mark Knecht    Kernel Version            =>
2.6.9-rc2-mm4-VP-S7-noACPI-UMP
11-09-04 10:35 tiwai          Note Added: 0002317                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
