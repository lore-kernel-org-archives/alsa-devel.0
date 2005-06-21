From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001203]: mtpav driver locks X on 64 bit native system
Date: Tue, 21 Jun 2005 11:25:10 +0200
Message-ID: <64429f3097c70a96ab3748a664c4cc4a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 117A91EE
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 11:25:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1203> 
======================================================================
Reported By:                sonofzev
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1203
Category:                   GENERIC - mtpav
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2004.3 - 64-bit native
Kernel Version:             2.6.9 or 2.6.11 or 2.6.12
======================================================================
Date Submitted:             06-19-2005 08:51 CEST
Last Modified:              06-21-2005 11:25 CEST
======================================================================
Summary:                    mtpav driver locks X on 64 bit native system
Description: 
Locks system completely when loading X if mtpav module is already loaded. 

If loading the module after loading X, the system completely lock when
firing up any sequencer app. 

This does not happen on my 32-bit Pentium 4 

======================================================================

----------------------------------------------------------------------
 sonofzev - 06-20-05 13:47 
----------------------------------------------------------------------
This is still happening after changing the parallel port mode... 

now set to ECP + EPP... 

my apologies for a hasty solved report

----------------------------------------------------------------------
 tiwai - 06-21-05 11:25 
----------------------------------------------------------------------
Is the interrupt correct?  As default, it's set to irq 7.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-05 08:51 sonofzev       New Issue                                    
06-19-05 08:51 sonofzev       Distribution              => Gentoo 2004.3 -
64-bit native
06-19-05 08:51 sonofzev       Kernel Version            => 2.6.9 or 2.6.11 or
2.6.12
06-19-05 16:05 sonofzev       Note Added: 0005089                          
06-19-05 16:24 sonofzev       Note Deleted: 0005089                        
06-20-05 13:47 sonofzev       Note Added: 0005097                          
06-21-05 11:25 tiwai          Note Added: 0005104                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
