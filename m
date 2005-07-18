From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001262]: Sound-related /dev entries disappear after each reboot
Date: Mon, 18 Jul 2005 20:19:41 +0200
Message-ID: <f99715efeb15c3e157ae3117252f7103@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3E7B1C6
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2005 20:19:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1262> 
======================================================================
Reported By:                loungelizard
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1262
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             07-16-2005 18:16 CEST
Last Modified:              07-18-2005 20:19 CEST
======================================================================
Summary:                    Sound-related /dev entries disappear after each
reboot
Description: 
/dev/snd and other sound-related entries in /dev (created by snddevices)
disappear after each reboot, so I must run snddevices again and again.
With kernel 2.4.31 everything is OK, but I need kernel 2.6.12.2.
======================================================================

----------------------------------------------------------------------
 Henne - 07-18-05 20:19 
----------------------------------------------------------------------
Maybe you have DEVFS_FS enabled?
Reconfigure the kernel with DEVFS_FS disabled, install it and look what
happens.
DEVFS_FS will be removed from the kernel in near future.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 18:16 loungelizard   New Issue                                    
07-16-05 18:16 loungelizard   Distribution              => Slackware       
07-16-05 18:16 loungelizard   Kernel Version            => 2.6.12.2        
07-18-05 20:19 Henne          Note Added: 0005522                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
