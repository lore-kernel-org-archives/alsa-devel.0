From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000889]: wrong routings of channels for 5.1 ICH5-Onboard-Card
Date: Wed, 30 Mar 2005 08:53:10 +0200
Message-ID: <bc869e7de0f92f6d069a38fe9f1548e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 40F08277
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2005 08:53:10 +0200 (MEST)
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


The following issue is now in status NEW (again)
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
Last Modified:              03-30-2005 08:53 CEST
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
 tiwai - 02-09-05 17:11 
----------------------------------------------------------------------
Fixed on CVS.

----------------------------------------------------------------------
 jdthood - 03-30-05 08:52 
----------------------------------------------------------------------
The submitter of Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=293928 writes:

[I tried 1.0.9rc2 and had] no success. The routing is also wrong like in
my first post [http://bugs.debian.org/293928]. The only think what is
fixed is that the wrong routed rear right is not muted. So all channels
do sound but wrong routed.

So now we have the following picture:

source          mixer           speaker
- -------------------------------------------
front left ---> front left ---> front left
front right --> front right --> front right
rear left ----> center -------> center
read right ---> lfe ----------> lfe
center -------> rear left ----> rear left
lfe ----------> rear right ---> rear right

This whouldn't be such a problem if the mixer whould be the same than
the sound source as I could change the plugs... But the situation above
is strange.

Moreover, xmms or xine will dump core with the prepackaged packages. I
was only able to test this with speaker-test.

Gruß
   Klaus

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 13:18 jdthood        New Issue                                    
02-09-05 11:38 tiwai          Note Added: 0003539                          
02-09-05 12:34 jdthood        Note Added: 0003550                          
02-09-05 16:13 jdthood        Note Added: 0003554                          
02-09-05 16:57 tiwai          Note Added: 0003555                          
02-09-05 17:11 tiwai          Status                   new => resolved     
02-09-05 17:11 tiwai          Resolution               open => fixed       
02-09-05 17:11 tiwai          Assigned To               => tiwai           
02-09-05 17:11 tiwai          Note Added: 0003556                          
02-09-05 17:11 tiwai          Assigned To              tiwai =>            
03-30-05 08:52 jdthood        Status                   resolved => feedback
03-30-05 08:52 jdthood        Resolution               fixed => reopened   
03-30-05 08:52 jdthood        Note Added: 0004262                          
03-30-05 08:53 jdthood        Status                   feedback => new     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
