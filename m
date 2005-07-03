From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001224]: artsd-like style
Date: Sun, 3 Jul 2005 14:09:44 +0200
Message-ID: <c73d5b01cda650cf82766c01c7a05d3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62FCA1BF
	for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2005 14:09:44 +0200 (MEST)
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
Last Modified:              07-03-2005 14:09 CEST
======================================================================
Summary:                    artsd-like style
Description: 
i'd like to know if that's a roadmap to let alsa drivers have a artsd (or
windows) style, i mean, multiple streams at once.

that could be very important for example using skype voip and listening
music at the same time.
======================================================================

----------------------------------------------------------------------
 Hetfield - 07-03-05 09:25 
----------------------------------------------------------------------
i tested your patch.

it doesn't crash skype, nor i get "error with audio device" as before

but i can't hear nothing, as you said..

ready to test new fixes :)

----------------------------------------------------------------------
 pzad - 07-03-05 14:09 
----------------------------------------------------------------------
I can make skype work with dmix (but only if dmix is mono). In this mode it
works ok. Problem is skype doesn't check return value (channel count and
assume mono is supported, but this is not case when dmix is used in stereo
mode).

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
