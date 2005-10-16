From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001477]: inserting maestro3 hangs system
Date: Sun, 16 Oct 2005 17:03:20 +0200
Message-ID: <cf328a4a2a86fb723c9c988f84f19317@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8344193
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2005 17:03:20 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1477> 
======================================================================
Reported By:                cra
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1477
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5 (development)
Kernel Version:             2.6.13-1.1600_FC5
======================================================================
Date Submitted:             10-16-2005 17:03 CEST
Last Modified:              10-16-2005 17:03 CEST
======================================================================
Summary:                    inserting maestro3 hangs system
Description: 
Kernel hangs upon loading snd-maestro3 driver during hardware
initialization.  The system only hangs if Windows was not booted prior to
booting Linux.  So it seems that the Windows driver is poking the hardware
in some way that "helps" the Linux driver, and basically the ALSA driver
is not initializing the hardware correctly.

Bug cross-reference:

https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000376
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134507

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-16-05 17:03 cra            New Issue                                    
10-16-05 17:03 cra            Distribution              => Fedora Core 5
(development)
10-16-05 17:03 cra            Kernel Version            => 2.6.13-1.1600_FC5
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
