From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000889]: wrong routings of channels for 5.1 ICH5-Onboard-Card
Date: Wed, 30 Mar 2005 18:04:16 +0200
Message-ID: <3d2464f9de97284cfef380251618169e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A7E4B229
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2005 18:04:16 +0200 (MEST)
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
Last Modified:              03-30-2005 18:04 CEST
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
 jdthood - 03-30-05 09:08 
----------------------------------------------------------------------
Additional info:

With the old kernel module and new drivers (sid) mostely all work
correct. (1.0.7-2)
"speaker-test -D plug:surround51 -c 6" is ok
"speaker-test -c 6" not.

With the newer kernel module the one channel is allways muted. (1.0.8-4)

The test I did on the old kernel with the alpha packages. So there seems
to be several issues with the routing.

Gruß
   Klaus

----------------------------------------------------------------------
 tiwai - 03-30-05 18:04 
----------------------------------------------------------------------
The silence of right rear was fixed on 1.0.9rc2.

The routing _must_ be changed.  It it's not changed, the usage was wrong. 
Check speaker-test program with "-Dsurround51".  If it's still wrong with
1.0.9 configuration, copy ICH4.conf back from 1.0.8.

Also, please update alsa-driver, too.  The segfault occurs when you use
1.0.9 with the older ALSA driver.

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
03-30-05 09:08 jdthood        Note Added: 0004263                          
03-30-05 18:04 tiwai          Note Added: 0004265                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
