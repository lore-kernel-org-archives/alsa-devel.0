From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000242]: No S/PDIF for Cirrus Logic CS4299 rev 4
Date: Sun, 3 Apr 2005 20:04:37 +0200
Message-ID: <706afa94e336af50337cebb4461dab19@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3B0561EF
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 20:04:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=242> 
======================================================================
Reported By:                sziwan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   242
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-28-2004 01:05 CEST
Last Modified:              04-03-2005 20:04 CEST
======================================================================
Summary:                    No S/PDIF for Cirrus Logic CS4299 rev 4
Description: 
S/PDIF passthrough seems not to be fully implemented for this card. While
there is a mixer toggle called IEC958 (which seems to control the LED),
there is no appropriate playback device.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-05-04 11:05 
----------------------------------------------------------------------
-R sends the AC3 stream as it is (just like PCM) to the SPDIF.
usually, AC3 is packed into the SPDIF packets, but apparently
it doesn't work on your board...

----------------------------------------------------------------------
 jdthood - 04-03-05 20:04 
----------------------------------------------------------------------
Can this report be closed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 01:05 sziwan         New Issue                                    
04-30-04 10:57 tiwai          Note Added: 0000975                          
04-30-04 11:27 sziwan         Note Added: 0000978                          
05-01-04 10:42 tiwai          Note Added: 0000995                          
05-01-04 10:42 tiwai          File Added: ich-conf.dif                     
05-01-04 10:43 tiwai          Note Added: 0000996                          
05-04-04 10:36 sziwan         Note Added: 0001040                          
05-04-04 17:06 tiwai          Note Added: 0001043                          
05-05-04 00:04 sziwan         Note Added: 0001046                          
05-05-04 11:05 tiwai          Note Added: 0001050                          
04-03-05 20:04 jdthood        Note Added: 0004317                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
