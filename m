From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000889]: wrong routings of channels for 5.1 ICH5-Onboard-Card
Date: Wed, 9 Feb 2005 16:57:25 +0100
Message-ID: <117a252fece93875b74c65cacaa61432@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 950E0262
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 16:57:25 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=889> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   889
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-08-2005 13:18 CET
Last Modified:              02-09-2005 16:57 CET
======================================================================
Summary:                    wrong routings of channels for 5.1 ICH5-Onboard-Card
Description: 
This is forwarded Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=293928.  Please see
http://bugs.debian.org/293928 for the full report.

The submitter reports that the sound output goes to the wrong places
-- Front Speakers are OK.
-- Rear left will be routed and controlled by the mixer of the center box
-- Rear right is muted and will not output any sound
-- Center goes to the read left and is controled with this mixer
-- And LFE goes to rear right with the rear right mixer.


======================================================================

----------------------------------------------------------------------
 jdthood - 02-09-05 16:13 
----------------------------------------------------------------------
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC655 at 0xfa101000, irq 17

----------------------------------------------------------------------
 tiwai - 02-09-05 16:57 
----------------------------------------------------------------------
It seems that ICH4/5/6 sets the slot 3/4/7/8/6/9 for L/R/SL/SR/C/LFE as
well as codecs.  OK, let's remove the routing in ICH4.conf.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 13:18 jdthood        New Issue                                    
02-09-05 11:38 tiwai          Note Added: 0003539                          
02-09-05 12:34 jdthood        Note Added: 0003550                          
02-09-05 16:13 jdthood        Note Added: 0003554                          
02-09-05 16:57 tiwai          Note Added: 0003555                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
