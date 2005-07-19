From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001266]: Does not detect my sound card as valid
Date: Tue, 19 Jul 2005 06:37:35 +0200
Message-ID: <c056931895ff9a77c7f074911d1c3592@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A4A51C2
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 06:37:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1266> 
======================================================================
Reported By:                darins
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1266
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             
======================================================================
Date Submitted:             07-19-2005 06:37 CEST
Last Modified:              07-19-2005 06:37 CEST
======================================================================
Summary:                    Does not detect my sound card as valid
Description: 
I have an AudioTrak Prodigy 7.1LT sound card.  Modprobing ice-1724 produces
the following output in /var/log/messages:

Jul 18 23:24:45 coruscant kernel: ice1724: No matching model found for ID
0x32315441
Jul 18 23:24:45 coruscant kernel: ice1724: Invalid EEPROM (size = 120)
Jul 18 23:24:45 coruscant kernel: ICE1724: probe of 0000:00:06.0 failed
with error -5

It looks like the driver just can't identify my card.
I upgraded to the latest driver available from atrpms, but got the same
error.

aplay -l doesn't show any devices from this soundcard available, though
lsmod shows the module loaded and using all the normal stuff.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-05 06:37 darins         New Issue                                    
07-19-05 06:37 darins         Distribution              => Fedora Core 3   
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
