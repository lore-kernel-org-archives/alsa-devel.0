From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000469]: volume of sblive mic recording too low
Date: Sat, 28 Aug 2004 01:36:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827233637.D02E32C00A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 51213187
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2004 01:36:38 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000469
======================================================================
Reported By:                wouter
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     469
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             08-28-2004 01:36 CEST
Last Modified:              08-28-2004 01:36 CEST
======================================================================
Summary:                    volume of sblive mic recording too low
Description: 
The recordings made with the Mic input on my sblive (5.1) are substantially
lower in volume than direct playback output. If fact, they are too low to
be really useful in for instance video conferencing, barely reaching 1/4
in the VU meter of the gnomemeeting voip program - with Mic boost on.

Setting "Capture" to anything but zero stops any sound from being
captured.

"AC97 Capture" seems to be controlling the volume of the recording, but it
is too low even with the slider on 100%.

People on the users mailinglist seem to indicate that "Capture" actually
should work, which it doesn't.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-28-04 01:36 wouter         New Bug                                      
08-28-04 01:36 wouter         File Added: amixer.txt                       
08-28-04 01:36 wouter         Distribution              => Debian          
08-28-04 01:36 wouter         Kernel Version            => 2.6.8           
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
