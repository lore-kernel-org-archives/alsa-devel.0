From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000915]: When compiled with SND_HWDEP enabled, the intel8x0 driver is no longer able to share an IRQ with other devices
Date: Thu, 17 Feb 2005 10:17:42 +0100
Message-ID: <5aa2e40d335ee8af14713106e83db4ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3239A25E
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 10:17:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=915> 
======================================================================
Reported By:                Jochen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   915
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10-gentoo-r7
======================================================================
Date Submitted:             02-17-2005 10:17 CET
Last Modified:              02-17-2005 10:17 CET
======================================================================
Summary:                    When compiled with SND_HWDEP enabled, the intel8x0
driver is no longer able to share an IRQ with other devices
Description: 
On my System an intel8x0 card and a Intel PRO Wireless 2200BG card share
irq5 which works perfectly with SND_HWDEP.

I recently enabled SND_HWDEP for another audio driver. since then all
commands the ipw2200 driver issues to the wlan card time out, the audio
driver however is still working.

Since I didn't change the ipw2200 driver but only an alsa related option,
I guess it's an alsa bug
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-05 10:17 Jochen         New Issue                                    
02-17-05 10:17 Jochen         Distribution              => Gentoo          
02-17-05 10:17 Jochen         Kernel Version            => 2.6.10-gentoo-r7
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
