From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001264]: Mixer defaults to mute when computer reboots.
Date: Mon, 18 Jul 2005 16:26:33 +0200
Message-ID: <2ec90029d73e29d967a4f6026fbde916@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAED31C6
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2005 16:26:33 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1264> 
======================================================================
Reported By:                92b16vx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1264
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-16-2005 22:40 CEST
Last Modified:              07-18-2005 16:26 CEST
======================================================================
Summary:                    Mixer defaults to mute when computer reboots.
Description: 
When computer reboots, Alsamixer is reset to mute. Fix is opening the mixer
through command line, and unmuting, and turning up volumes.
======================================================================

----------------------------------------------------------------------
 jdthood - 07-18-05 16:26 
----------------------------------------------------------------------
This is working as intended.

Use alsactl to save mixer levels before you shut down and
to restore them after you reboot.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 22:40 92b16vx        New Issue                                    
07-16-05 22:40 92b16vx        Distribution              => Fedora Core 4   
07-16-05 22:40 92b16vx        Kernel Version            => 2.6.11-1.1369_FC4
07-18-05 16:26 jdthood        Note Added: 0005521                          
07-18-05 16:26 jdthood        Status                   new => closed       
07-18-05 16:26 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
