From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000583]: xruns when playing audio or video files
Date: Fri, 15 Oct 2004 18:51:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041015165116.EFD4E3B007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 45BDB30C
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2004 18:51:17 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000583
======================================================================
Reported By:                KAtiOS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     583
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9_rc4
======================================================================
Date Submitted:             10-15-2004 16:27 CEST
Last Modified:              10-15-2004 18:51 CEST
======================================================================
Summary:                    xruns when playing audio or video files
Description: 
I get xruns when playing files.
I tested with lots of 2.6 kernels, up to 2.6.9_rc4 with the same results.
It seems that mplayer with sdl output works fine, but xruns with alsa.
Using acpi=off or pci=noacpi helps in mplayer but not in vdr (with
softdevice plugin - using alsa).



======================================================================

----------------------------------------------------------------------
 lee - 10-15-2004 18:43 CEST 
----------------------------------------------------------------------
This is a kernel issue, not an ALSA bug.  If you want xrun-free operation
you HAVE to use a kernel patched for low latency.  Please close this bug.

----------------------------------------------------------------------
 KAtiOS - 10-15-2004 18:51 CEST 
----------------------------------------------------------------------
Since when a low latency [so.. patched] kernel is needed to listen to music
and play video correctly?
Given that the processor isn't particulary weak and that's the only task
of the system, it shouldn't be hard to keep pace.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 16:27 KAtiOS         New Bug                                      
10-15-04 16:27 KAtiOS         Distribution              => Gentoo Linux    
10-15-04 16:27 KAtiOS         Kernel Version            => 2.6.9_rc4       
10-15-04 18:43 lee            Bugnote Added: 0002168                       
10-15-04 18:51 KAtiOS         Bugnote Added: 0002169                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
