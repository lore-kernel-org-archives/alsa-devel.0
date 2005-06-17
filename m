From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001198]: powermac driver missing 'macio_find' symbol
Date: Fri, 17 Jun 2005 14:35:10 +0200
Message-ID: <52fb096172d0e7c317271aee02998dc5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 30AD117A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 14:35:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1198> 
======================================================================
Reported By:                zwelch
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1198
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.11.12
======================================================================
Date Submitted:             06-17-2005 02:41 CEST
Last Modified:              06-17-2005 14:35 CEST
======================================================================
Summary:                    powermac driver missing 'macio_find' symbol
Description: 
After building alsa-driver-1.0.9a, depmod/modprobe fails with the following
error:

WARNING: //lib/modules/2.6.11.12-fs7/alsa-driver/ppc/snd-powermac.ko needs
unknown symbol macio_find

I'll try to do more digging myself, but this is where I'm starting.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-17-05 14:35 
----------------------------------------------------------------------
It looks like a bug of kernel.  macio_find isn't exported indeed.
Does the attached patch to the kernel fix the problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 02:41 zwelch         New Issue                                    
06-17-05 02:41 zwelch         Distribution              => Gentoo          
06-17-05 02:41 zwelch         Kernel Version            => 2.6.11.12       
06-17-05 14:35 tiwai          Note Added: 0005071                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
