From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001197]: Realtek ALC650 output problem
Date: Thu, 16 Jun 2005 15:19:00 +0200
Message-ID: <b4733e17814d74db1f85fc087e087b09@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E15AE19D
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 15:19:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1197> 
======================================================================
Reported By:                willits
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1197
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-16-2005 15:07 CEST
Last Modified:              06-16-2005 15:19 CEST
======================================================================
Summary:                    Realtek ALC650 output problem
Description: 
I have got a realtek ALC650 AC97 soundcard on my motherboard Abit BE7.
The problem is that I have got 5.1 speakers, and for have my subwoofer and
central speaker work, I need to put them on the "line in" connector
instead of the black connector (the black connector doesn't work).

I haven't got this problem with Windows.
======================================================================

----------------------------------------------------------------------
 pzad - 06-16-05 15:13 
----------------------------------------------------------------------
Try run alsamixer

find item with name "Line In as Surround" - mute it (with M key)

----------------------------------------------------------------------
 willits - 06-16-05 15:19 
----------------------------------------------------------------------
I have mute "Line In as Surround", I have put the subwoofer connector to
the black connector, and he doesn't work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-05 15:07 willits        New Issue                                    
06-16-05 15:07 willits        Kernel Version            => 2.6.11          
06-16-05 15:13 pzad           Note Added: 0005056                          
06-16-05 15:19 willits        Note Added: 0005057                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
