From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000895]: Es1968 driver seems not to support full duplex mode
Date: Wed, 9 Feb 2005 13:00:44 +0100
Message-ID: <5a773faad9293ca43757b865ccb07827@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B0AFD1E6
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 13:00:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=895> 
======================================================================
Reported By:                woweil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   895
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             02-09-2005 13:00 CET
Last Modified:              02-09-2005 13:00 CET
======================================================================
Summary:                    Es1968 driver seems not to support full duplex mode
Description: 
When I tried a talk with the application "skype", I recognized that the
soundcard solo-1 was not in full duplex mode. Every time when I have
connection, there is a gread banging. The other part of the talk hears the
banging too. A conversation is impossible, because no word can be
recognized.

After that I tried an installation with Windows 2000. The software worked
well and a conversation is possible without problems. So I suppose, that
the duplexmode is not possible with the driver.

I use a Thinkpad 390X
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 13:00 woweil         New Issue                                    
02-09-05 13:00 woweil         Distribution              => Debian          
02-09-05 13:00 woweil         Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
