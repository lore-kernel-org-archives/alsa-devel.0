From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000908]: suport for ESI Juli@ - ICE1724
Date: Tue, 22 Feb 2005 10:07:04 +0100
Message-ID: <4d4db700238e60a2ddae2a5a1fb7d602@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41C60174
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 10:07:04 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=908> 
======================================================================
Reported By:                arsen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   908
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.11-rc4
======================================================================
Date Submitted:             02-14-2005 19:38 CET
Last Modified:              02-22-2005 10:07 CET
======================================================================
Summary:                    suport for ESI Juli@ - ICE1724
Description: 
Hello. I have soundcard ESI Juli@ on chipset ICE1724.
I tried run her with alsa 1.0.8 on kernel 2.6.10 and 2.6.11.
Unfortunely soundcard don't work. In my logs i found that:

- ice1724: No matching model found for ID 0x31305345
- ice1724: Invalid EEPROM (size = 120)
- ICE1724: probe of 0000:00:0a.0 failed with error -5
- ALSA device list:
- No soundcards found

I know that other cards work correctly on this chipset and
if it's necesarry i could help in tests of driver for this
soundcard.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-14-05 19:38 arsen          New Issue                                    
02-14-05 19:38 arsen          Distribution              => Gentoo          
02-14-05 19:38 arsen          Kernel Version            => 2.6.11-rc4      
02-15-05 07:32 arsen          Issue Monitored: arsen                       
02-22-05 10:07 perex          Status                   new => assigned     
02-22-05 10:07 perex          Assigned To               => perex           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
