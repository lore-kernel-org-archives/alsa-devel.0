From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000574]: bad sound reproduction
Date: Mon, 11 Oct 2004 12:10:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011101033.58F2011030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AF1EE2BE
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 12:10:33 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000574
======================================================================
Reported By:                nicola
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     574
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 2
Kernel Version:             kernel 2.6.5-1.358
======================================================================
Date Submitted:             10-09-2004 15:03 CEST
Last Modified:              10-11-2004 12:10 CEST
======================================================================
Summary:                    bad sound reproduction
Description: 
Sound isn't reproduced rigth way, sound play and stop, play and stop. I
can't hear a fluid sound, the only way to hear sound is moving continously
the mouse. 
I can't hear system sounds, totem (and xine based programs) doesn't
reproduce fluid sounds, while mplayer and helix can (but sometimes stream
is shifted on).

======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-2004 12:10 CEST 
----------------------------------------------------------------------
Did you try boot options related with ACPI?  Try pci=noacpi or pci=off.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 15:03 nicola         New Bug                                      
10-09-04 15:03 nicola         Distribution              => fedora core 2   
10-09-04 15:03 nicola         Kernel Version            => kernel 2.6.5-1.358
10-11-04 12:10 tiwai          Bugnote Added: 0002074                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
