From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000889]: wrong routings of channels for 5.1 ICH5-Onboard-Card
Date: Mon, 30 May 2005 13:40:14 +0200
Message-ID: <3ad7a191df67aa6f764d455f8d32b102@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28DBB1C7
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:40:15 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=889> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   889
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-08-2005 13:18 CET
Last Modified:              05-30-2005 13:40 CEST
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
 tiwai - 03-30-05 18:04 
----------------------------------------------------------------------
The silence of right rear was fixed on 1.0.9rc2.

The routing _must_ be changed.  It it's not changed, the usage was wrong. 
Check speaker-test program with "-Dsurround51".  If it's still wrong with
1.0.9 configuration, copy ICH4.conf back from 1.0.8.

Also, please update alsa-driver, too.  The segfault occurs when you use
1.0.9 with the older ALSA driver.

----------------------------------------------------------------------
 perex - 05-30-05 13:40 
----------------------------------------------------------------------
No activity.

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
05-30-05 13:40 perex          Status                   new => resolved     
05-30-05 13:40 perex          Resolution               reopened => fixed   
05-30-05 13:40 perex          Assigned To               => perex           
05-30-05 13:40 perex          Note Added: 0004812                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
