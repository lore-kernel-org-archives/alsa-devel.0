From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000636]: Setting volume controls to 0 does not turn off speakers completely
Date: Mon, 8 Nov 2004 19:04:45 +0100
Message-ID: <847bda51888272581c4d824e23ea283a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2CD812A0
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 19:04:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=636> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   636
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2-mm4-VP-S7-noACPI-UMP
======================================================================
Date Submitted:             11-08-2004 18:41 CET
Last Modified:              11-08-2004 19:04 CET
======================================================================
Summary:                    Setting volume controls to 0 does not turn off
speakers completely
Description: 
On my Compaq R3070 laptop setting Master and Master Mono controls to 0 does
not result in no sound out. I still get audio at a low level.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-08-04 19:04 
----------------------------------------------------------------------
Which ALSA version? (/proc/asound/version)
Which AC'97 codec? (see alsamixer)
Does the Mute control work?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-04 18:41 Mark Knecht    New Issue                                    
11-08-04 18:41 Mark Knecht    Distribution              => Gentoo          
11-08-04 18:41 Mark Knecht    Kernel Version            =>
2.6.9-rc2-mm4-VP-S7-noACPI-UMP
11-08-04 19:04 Clemens LadischNote Added: 0002312                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
