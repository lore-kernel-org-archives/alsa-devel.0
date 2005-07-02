From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001225]: RMS hardware input and software plaback levels are incorrectly reported under 64 bit linux
Date: Sat, 2 Jul 2005 08:42:46 +0200
Message-ID: <fb85270a929971e92d19d27ba5768df2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B8CE187
	for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2005 08:42:47 +0200 (MEST)
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
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             07-01-2005 20:11 CEST
Last Modified:              07-02-2005 08:42 CEST
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
 charbonnel - 07-02-05 08:42 
----------------------------------------------------------------------
Hi,

It sounds similar to a bug in the byte swapping code that was fixed some
time ago.
(see ALSA BUG https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0000801)
Do you use the in-kernel alsa driver with 2.6.11 ? If so they may be a
little old.
What's the version reported by cat /proc/asound/version ?
I suspect your patch seems to fix the problem but introduces a one channel
offset in the metering values.

Thomas

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 20:11 ckg            New Issue                                    
07-01-05 20:11 ckg            File Added: hdsp.patch                       
07-01-05 20:11 ckg            Kernel Version            => 2.6.11          
07-02-05 08:42 charbonnel     Note Added: 0005352                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
