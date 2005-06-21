From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001198]: powermac driver missing 'macio_find' symbol
Date: Tue, 21 Jun 2005 12:20:53 +0200
Message-ID: <f27676286929d11b81e1b1c1773e683b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11F791EC
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 12:20:54 +0200 (MEST)
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
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.11.12
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             06-17-2005 02:41 CEST
Last Modified:              06-21-2005 12:20 CEST
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
 zwelch - 06-19-05 10:06 
----------------------------------------------------------------------
While the simple patch of exporting the proper symbol should solve the
problem for 2.6.11.x, I have gone ahead and upgraded to 2.6.12 and found
that the 1.0.9b alsa-driver package builds and functions as expected
against it (as far as this bug is concerned).  That said, I would
encourage anyone else who encounters this problem to upgrade their kernel.

----------------------------------------------------------------------
 tiwai - 06-21-05 12:20 
----------------------------------------------------------------------
OK, I resolve this issue as WONTFIX.
It's possible to create more ifdefs in the patches in alsa-driver tree,
but I don't think it's worthy to work on that.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 02:41 zwelch         New Issue                                    
06-17-05 02:41 zwelch         Distribution              => Gentoo          
06-17-05 02:41 zwelch         Kernel Version            => 2.6.11.12       
06-17-05 14:35 tiwai          Note Added: 0005071                          
06-17-05 14:35 tiwai          File Added: macio_find_export.diff                
   
06-17-05 14:40 tiwai          Note Added: 0005072                          
06-19-05 10:06 zwelch         Note Added: 0005087                          
06-21-05 12:20 tiwai          Status                   assigned => resolved
06-21-05 12:20 tiwai          Resolution               open => won't fix   
06-21-05 12:20 tiwai          Note Added: 0005106                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
