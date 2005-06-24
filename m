From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001052]: Riptide/Context Audio Drivers
Date: Fri, 24 Jun 2005 15:09:22 +0200
Message-ID: <1749e2d760ff2c93345beeb0534283ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C82571F6
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 15:09:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1052> 
======================================================================
Reported By:                JKnife
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1052
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-13-2005 21:59 CEST
Last Modified:              06-24-2005 15:09 CEST
======================================================================
Summary:                    Riptide/Context Audio Drivers
Description: 
there is a set but its only for the 2.4 kernel.
i would like you toinclude them in alsa.
the 2.4 drivers can be found here
http://www.linuxant.com/drivers/
======================================================================

----------------------------------------------------------------------
 nokos - 06-23-05 15:35 
----------------------------------------------------------------------
liuxant guys:I have already geiven them the code last year and again this
year, but they didn't use it so far. I guess they couldn't easily convert
it to an external kernel module due to the dependends on the AC97 stuff.

Have you experience with the request_frmware() stuff, then maybe you can
add it.
I don't use the laptop with the riptide chipset anymore, so I hope someone
else wants to convert it to a more recent ALSA (it shouldn't be that hard,
has the scatter/gather/memory stuff changed again?)

----------------------------------------------------------------------
 tiwai - 06-24-05 15:09 
----------------------------------------------------------------------
The changes are trivial in most cases.  SG-buffer should be same.

But I'd work on this only if someone can test quickly the patch (and if I
have time left...)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:59 JKnife         New Issue                                    
04-13-05 22:01 JKnife         Note Added: 0004479                          
06-06-05 10:51 perex          Assigned To              perex =>            
06-06-05 10:51 perex          Category                 ISA - GUS (classic, max,
extreme, interwave) => OTHERS
06-08-05 15:15 tiwai          Note Added: 0004932                          
06-08-05 23:25 JKnife         Note Added: 0004976                          
06-15-05 14:41 nokos          Note Added: 0005027                          
06-23-05 12:07 tiwai          Note Added: 0005176                          
06-23-05 15:10 nokos          Note Added: 0005187                          
06-23-05 15:21 tiwai          Note Added: 0005188                          
06-23-05 15:26 tiwai          Note Added: 0005189                          
06-23-05 15:35 nokos          Note Added: 0005190                          
06-24-05 15:09 tiwai          Note Added: 0005226                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
