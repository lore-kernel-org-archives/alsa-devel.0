From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001225]: RMS hardware input and software plaback levels are incorrectly reported under 64 bit linux
Date: Sun, 3 Jul 2005 10:30:25 +0200
Message-ID: <2fbbde67cbfffadbb109a38869960a59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB959193
	for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2005 10:30:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1225> 
======================================================================
Reported By:                ckg
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   1225
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           1.0.9
======================================================================
Date Submitted:             07-01-2005 20:11 CEST
Last Modified:              07-03-2005 10:30 CEST
======================================================================
Summary:                    RMS hardware input and software plaback levels are
incorrectly reported under 64 bit linux
Description: 
I'm using the PCI HDSP with a Multiface interface,  Everything appears to
be correct with the audio, but the hdspmixer reports bogus valus for
hardware input and software playback RMS levels.  The peak leavels are
correct.  The problem happens when the driver is compiled into the kernel
and when it is a module.

I think the problem is caused because the rms regesters are positioned at
a 4 byte but not an 8 byte boundary on a 32 bit system, but on a 64 bit
system, they are movd back 4 bytes to an 8 byte alignment
======================================================================

----------------------------------------------------------------------
 charbonnel - 07-03-05 10:26 
----------------------------------------------------------------------
"While debuggin my guess was that running 64-bits caused the port space to
be positioned at an 8 byte boundary"

The values you're modifying are offsets in the iomapped card memory. They
are correct wherever the memory is mapped. This has nothing to do with the
platform.

What's happening is that you're mixing data belonging to different
channels. On those 8 bytes values, you get the most significant ones right
(somehow compensating for the bug in the alsa version you're using) but
the least significant have a one channels offset. For channel one, what
you're reading for the least significant bytes is undefined. So it looks
right, but you're loosing precision. I invite you to do some tests
generating sine waves with pure-data at a given level, and comparing the
values read by the card and those calculated by Fons' excellent JAAA. I
also invite you to upgrade to the latest alsa version...

Thomas

----------------------------------------------------------------------
 charbonnel - 07-03-05 10:30 
----------------------------------------------------------------------
This is the same bug as ALSA BUG
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0000801 and has been
fixed in alsa 1.0.9

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 20:11 ckg            New Issue                                    
07-01-05 20:11 ckg            File Added: hdsp.patch                       
07-01-05 20:11 ckg            Kernel Version            => 2.6.11          
07-02-05 08:42 charbonnel     Note Added: 0005352                          
07-03-05 05:22 ckg            Note Added: 0005369                          
07-03-05 10:26 charbonnel     Note Added: 0005371                          
07-03-05 10:30 charbonnel     Status                   assigned => resolved
07-03-05 10:30 charbonnel     Fixed in Version          => 1.0.9           
07-03-05 10:30 charbonnel     Resolution               open => fixed       
07-03-05 10:30 charbonnel     Note Added: 0005372                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
