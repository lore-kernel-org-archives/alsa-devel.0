From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001225]: RMS hardware input and software plaback levels are incorrectly reported under 64 bit linux
Date: Sun, 3 Jul 2005 10:26:54 +0200
Message-ID: <2489e33d79d59df7a1c6276a51da6fef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55027192
	for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2005 10:26:55 +0200 (MEST)
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
Last Modified:              07-03-2005 10:26 CEST
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
 ckg - 07-03-05 05:22 
----------------------------------------------------------------------
Thomas,

This sounds like the same problem. cat /proc/asound/version reports that
I'm running version 1.0.8.  I am using the in-kernal driver.
I took a look at your patch for the problem.  I haven't tried it.  There
seems to be something interesting going on here and I am not able to
completely grasp what is happening.  Here's the situation:
My patch does not appear to introduce a one channel offset.  I have tested
extensively and (unless I am seriously missing something) correct levels
are reported on the correct inputs.
While debuggin my guess was that running 64-bits caused the port space to
be positioned at an 8 byte boundary.  I determined that I needed to jump
backwards four bytes and everything worked great. but... while debugging I
noticed that when I turned the gain up very high on my pre-amp and fed
low-level random noise into channel two the hdspmixer would show the rms
levels changing on channel one.  In fact, as I would turn up the gain on
channel two, the rms level would flucuate up and down repeatedly on
channel one.  My guess was that the least significant bytes of the rms
value on channel one was being read into the most significant bytes of the
rms for channel one.  The trouble is that in order to fix this issue I
would need to offset the port addresses by -12, not -4.
If we assume that your fix is correct then it seems quite logical that my
fix would introduce a one channel offset.  The vise-versa is also true.  I
need to sleep on this and perhaps something bright will occur to me.  In
the mean time, both our fixes seem to work, and I wonder if maybe neither
of them is entirely correct... Hmmm.  Show me what I'm missing.

~ckg

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 20:11 ckg            New Issue                                    
07-01-05 20:11 ckg            File Added: hdsp.patch                       
07-01-05 20:11 ckg            Kernel Version            => 2.6.11          
07-02-05 08:42 charbonnel     Note Added: 0005352                          
07-03-05 05:22 ckg            Note Added: 0005369                          
07-03-05 10:26 charbonnel     Note Added: 0005371                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
