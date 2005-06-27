From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001214]: With Terratec DMX6fire, digital inputs cannot be selected correctly -always internal digital source
Date: Mon, 27 Jun 2005 16:05:15 +0200
Message-ID: <8e0edb033561a2124dad973f6fded3ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FFA51C9
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 16:05:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1214> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1214
Category:                   envy24control
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-27-2005 15:27 CEST
Last Modified:              06-27-2005 16:05 CEST
======================================================================
Summary:                    With Terratec DMX6fire, digital inputs cannot be
selected correctly -always internal digital source
Description: 
The DMX6fire sound card has onboard 'digital in' for direct connection from
a CD drive as well as coax and optical front panel in and out. 
Envy24control has no button to select the internal source, but in fact it
seems always selected and works fine.  Consequently the front panel inputs
never work,(I can only test optical, but internal source is always
working) although the selector 'SPDIF input' changes the panel lights
correctly, and the 'SPDIF on/off' swaps the lights whichever way they
were.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-27-05 16:05 
----------------------------------------------------------------------
IIRC, envy24control doesn't support all switches for 6fire.  Start
alsamixer and turn on "Front Digital Input" and "Optical Digital Input"
appropriately.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 15:27 alanmann       New Issue                                    
06-27-05 16:05 tiwai          Note Added: 0005274                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
