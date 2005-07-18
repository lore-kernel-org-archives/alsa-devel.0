From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001224]: artsd-like style
Date: Mon, 18 Jul 2005 03:33:24 +0200
Message-ID: <bb01a39425fe18e085895661dd5fb254@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EFBB81AA
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2005 03:33:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1224> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1224
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             07-01-2005 14:49 CEST
Last Modified:              07-18-2005 03:33 CEST
======================================================================
Summary:                    artsd-like style
Description: 
i'd like to know if that's a roadmap to let alsa drivers have a artsd (or
windows) style, i mean, multiple streams at once.

that could be very important for example using skype voip and listening
music at the same time.
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-17-05 23:43 
----------------------------------------------------------------------
Well, it's not a bug-for-bug compatible emulation.  There are always areas
in any API that are ambiguous or implementation dependent.  The fact that
it works with another OSS implementation does not rule out an application
bug.

Most of the cases we have seen so far where aoss breaks something involve
buggy apps, that just happen to work with OSS or the in kernel emulation. 
They are just as likely to fail under a different OSS implementation.  For
example skype assumes it gets 48KHz stereo, even though the stream is
mono.  Although this particular case is due to a quirk of dmix, it would
also fail if the hardware only supported 48Khz mono.  They just didn't
bother to test it under an OSS implementation where this can happen.

----------------------------------------------------------------------
 rlrevell - 07-18-05 03:33 
----------------------------------------------------------------------
That being said, after looking at the code a bit this is almost certainly a
dmix bug.

It would be nice to know what all those ioctls are.  Any idea why strace
can't resolve them?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 14:49 Hetfield       New Issue                                    
07-01-05 14:49 Hetfield       Kernel Version            => 2.6.x           
07-01-05 20:16 Hetfield       Note Added: 0005337                          
07-01-05 20:33 rlrevell       Note Added: 0005338                          
07-01-05 22:56 Hetfield       Note Added: 0005343                          
07-02-05 18:53 pzad           Note Added: 0005356                          
07-02-05 20:11 Hetfield       Note Added: 0005357                          
07-02-05 21:46 pzad           File Added: aoss-fcntl.patch                    
07-02-05 21:47 pzad           Note Added: 0005361                          
07-03-05 09:25 Hetfield       Note Added: 0005370                          
07-03-05 14:09 pzad           Note Added: 0005376                          
07-03-05 15:57 Hetfield       Note Added: 0005378                          
07-04-05 11:49 pzad           File Added: aoss.patch                       
07-04-05 11:53 pzad           Note Added: 0005384                          
07-04-05 14:02 Hetfield       Note Added: 0005385                          
07-08-05 12:16 tiwai          Note Added: 0005417                          
07-08-05 12:27 Hetfield       Note Added: 0005418                          
07-17-05 10:25 Hetfield       Note Added: 0005503                          
07-17-05 10:29 rlrevell       Note Added: 0005504                          
07-17-05 10:46 rlrevell       Note Added: 0005505                          
07-17-05 11:10 Hetfield       Note Added: 0005506                          
07-17-05 11:11 Hetfield       File Added: log.tar.gz                       
07-17-05 19:41 rlrevell       Note Added: 0005508                          
07-17-05 19:50 Hetfield       Note Added: 0005509                          
07-17-05 19:51 rlrevell       Note Added: 0005510                          
07-17-05 20:21 Hetfield       Note Added: 0005511                          
07-17-05 21:14 rlrevell       Note Added: 0005512                          
07-17-05 21:22 Hetfield       File Added: log2.tar.gz                      
07-17-05 21:22 Hetfield       File Added: log2                             
07-17-05 21:23 Hetfield       Note Added: 0005513                          
07-17-05 22:21 rlrevell       Note Added: 0005514                          
07-17-05 23:28 Hetfield       Note Added: 0005515                          
07-17-05 23:43 rlrevell       Note Added: 0005516                          
07-18-05 03:33 rlrevell       Note Added: 0005517                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
