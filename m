From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000564]: Hercules digifire 7.1 - only 3 analog devices detected, not 4
Date: Wed,  6 Oct 2004 12:12:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006101252.40D2912009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8389527C
	for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2004 12:12:52 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000564
======================================================================
Reported By:                rrrozman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     564
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-03-2004 20:46 CEST
Last Modified:              10-06-2004 12:12 CEST
======================================================================
Summary:                    Hercules digifire 7.1 - only 3 analog devices detected, not 4
Description: 
I have this card and I suspect there should be 5 devices detected
alltogether (according that card is 7.1 + SPDIF).
I'm getting 4 devices - SPDIF being one of them:
aplay -l gives:
- device 0: CS46xx
- device 1: CS46xx - Rear
- device 2: CS46xx - IEC958
- device 3: CS46xx - Center LFE

and that's it.

Thanks,

Robi.

======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-2004 12:12 CEST 
----------------------------------------------------------------------
This feature is not supported yet.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 20:46 rrrozman       New Bug                                      
10-04-04 00:28 rrrozman       Bug Monitored: rrrozman                      
10-06-04 12:12 tiwai          Bugnote Added: 0002022                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
