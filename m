From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001275]: easly no sound [fm801]
Date: Fri, 22 Jul 2005 21:15:52 +0200
Message-ID: <e06d1b204acd64f62949f0171b0c82b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 670FB190
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 21:15:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1275> 
======================================================================
Reported By:                jsz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1275
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.29
======================================================================
Date Submitted:             07-22-2005 21:15 CEST
Last Modified:              07-22-2005 21:15 CEST
======================================================================
Summary:                    easly no sound [fm801]
Description: 
Dear alsa users, 
i really don't know what else i should to do for my audio system.
I have Fortemedia fm801 soundcard and i really followed the steps
descripted in specific tutorial. 
I remember that the default driver (alsa 1.0.8), after alsaconf &
alsamixer, was function, but so i had not run #alsactl store, so i
installed 1.0.9b to resolve the problem that i believe exists...
-how can i restore the default 1.0.8 drivers? 

-why the 1.0.9b don't functions? this i'have done:
#./configure; make; make install; alsaconf; alsamixer; ./snddevices; 
and everything is well done: driver installed and card present in
/proc/asound/cards.
Of course, the alsamixer settings are all unmuted, created .asoundrc in
home and modules.conf has been modified by alsaconf.
I tried also rebooting after install, but nothing.

Please help me.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 21:15 jsz            New Issue                                    
07-22-05 21:15 jsz            Kernel Version            => 2.4.29          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
