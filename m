From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000637]: Laptop volume control & mute buttons don't work
Date: Tue, 9 Nov 2004 17:49:55 +0100
Message-ID: <e4437ad73d592a71a4fc23de70c68ca2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 369561EE
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 17:49:56 +0100 (MET)
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
Status:                     feedback
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2-mm4-VP-S7-noACPI-UMP
======================================================================
Date Submitted:             11-08-2004 18:50 CET
Last Modified:              11-09-2004 17:49 CET
======================================================================
Summary:                    Laptop volume control & mute buttons don't work
Description: 
The Compaq, like may laptops, comes with buttons to increase and decrease
volume, as well as a mute button. Under Linux these buttons do nothing.
The mute button is always lit even when sound is coming out. The volume
control buttons do not adjust volume.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 16:57 
----------------------------------------------------------------------
Calm down, this has *nothing* to do with ALSA although the buttons are
printed as volume up/down.  There is *no* hardware connection between
buttons and the sound chip in your case.  Thus, there is nothing the sound
driver can do for this directly.

To support this feature, the ACPI event must be handled by a certain user
space program such as the window manager (or desktop system).

Windows works because it grabs the ACPI event and processes it properly. 
Linux could handle this but the current system doesn't care it.

----------------------------------------------------------------------
 Mark Knecht - 11-09-04 17:49 
----------------------------------------------------------------------
There's no point discussing this. Bye.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-04 18:50 Mark Knecht    New Issue                                    
11-08-04 18:50 Mark Knecht    Distribution              => Gentoo          
11-08-04 18:50 Mark Knecht    Kernel Version            =>
2.6.9-rc2-mm4-VP-S7-noACPI-UMP
11-09-04 10:35 tiwai          Note Added: 0002317                          
11-09-04 10:36 tiwai          Resolution               open => not an issue
11-09-04 10:37 tiwai          Status                   assigned => resolved
11-09-04 16:13 Mark Knecht    Status                   resolved => feedback
11-09-04 16:13 Mark Knecht    Resolution               not an issue => reopened
11-09-04 16:13 Mark Knecht    Note Added: 0002326                          
11-09-04 16:57 tiwai          Note Added: 0002328                          
11-09-04 17:49 Mark Knecht    Note Added: 0002329                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
