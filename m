From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Thu, 23 Sep 2004 20:52:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923185244.DEB903E00F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 640C413F
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 20:52:45 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425
======================================================================
Reported By:                rncbc
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     425
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.0 Official
Kernel Version:             2.6.8-rc2
======================================================================
Date Submitted:             08-06-2004 10:53 CEST
Last Modified:              09-23-2004 20:52 CEST
======================================================================
Summary:                    usb-usx2y: System lockup on PCM device open (OHCI)
Description: 
As of ALSA 1.0.6rc1, the US-x2y PCM device driver module exposes a hard
conflict on OHCI based USB controllers, causing a complete system lockup
-- kernel oops on an interrupt handler -- exactly upon starting or
openning the PCM device for audio playback. 
======================================================================

----------------------------------------------------------------------
 rncbc - 08-06-2004 12:16 CEST 
----------------------------------------------------------------------
Just to add, that this issue does not occur as of previous
alsa-driver-1.0.5a, same platform, kernel or hardware. Seems to have been
introduced on CVS semewhere since mid-July. Something about "no sleeping"
in ALSA's pcm START/STOP callbacks, but no sure.

----------------------------------------------------------------------
 karsten - 09-23-2004 20:52 CEST 
----------------------------------------------------------------------
that seams to have something to do with a threaded IRQ10?
Does it also happen with hardirq_preempting off?
Please geneate oops traces from the 2.6.9-rc2-mmx-Sy kernel also. 
If those traces also happen in non usx2y-module area,
find out, which snd_*() call triggers the oops.
Check wether it happens if you disable hyperthreads.
Erm, did I fail to include some important errorchecks after calling
kernel/usb functions?
Run with at least ALSA debug options enabled. Other kernel debug options
may help too.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-06-04 10:53 rncbc          New Bug                                      
08-06-04 10:53 rncbc          File Added: usx2y-oops3.png                    
08-06-04 10:53 rncbc          Distribution              => Mandrake 10.0 Official
08-06-04 10:53 rncbc          Kernel Version            => 2.6.8-rc2       
08-06-04 12:16 rncbc          Bugnote Added: 0001538                       
09-23-04 20:52 karsten        Bugnote Added: 0001849                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
