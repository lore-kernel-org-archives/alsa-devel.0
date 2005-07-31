From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001295]: async capture doesn't seem to work
Date: Sun, 31 Jul 2005 22:28:28 +0200
Message-ID: <ddb810ff2d4b52f003484f938c01177f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8F5BE164
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 22:28:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1295> 
======================================================================
Reported By:                arunarunarun
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1295
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-31-2005 22:28 CEST
Last Modified:              07-31-2005 22:28 CEST
======================================================================
Summary:                    async capture doesn't seem to work
Description: 
I've got a little program up at
http://nemesis.accosted.net/misc/capture2.cpp that initialises pcm for
capture, sets up an async callback and then busy-waits. The callback never
gets called, even though everything else seems to be going fine. Any help
would be appreciated.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 22:28 arunarunarun   New Issue                                    
07-31-05 22:28 arunarunarun   File Added: capture.cpp                      
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
