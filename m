From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000637]: Laptop volume control & mute buttons don't work
Date: Tue, 9 Nov 2004 16:13:17 +0100
Message-ID: <86d1ebdb50925c6ef9b61fc07a1b2a3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AB00A244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:13:17 +0100 (MET)
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


The following issue has been REOPENED.
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
Last Modified:              11-09-2004 16:13 CET
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

----------------------------------------------------------------------
 Mark Knecht - 11-09-04 16:13 
----------------------------------------------------------------------
This was not filed as a bug. It was filed as a feature request. Please do
not be so dismissive. What did you spend? Maybe 3 seconds and then blew it
off?

Under Windows the buttons control volume. Pushing the buttons raises or
lowers volume in the applications. you can see the volume controls go up
and down. 

Why should Linux *not* work this way? I am requesting that Alsa consider
how to be more user friendly. I am not filing a bug report. 

If they are already handled under ACPI (which I do not use on my laptop as
it causes kernel timing problems) then please simply state that Alsa
already handles this. However, I do not beleive that these specific
buttons are handled by ACPI, but that's just my guess.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
