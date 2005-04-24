From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001009]: NVidia CK8S 8ch: a center speaker is always silent in native alsa mode (through alsa-lib), works with oss emulation though
Date: Mon, 25 Apr 2005 00:03:58 +0200
Message-ID: <6bc7f04a5ada8d9d4099bdac89511c25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C8B6B19C
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 00:03:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1009> 
======================================================================
Reported By:                modax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1009
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.11.5 with self-compiled alsa-driver
1.0.9rc1
======================================================================
Date Submitted:             03-22-2005 22:34 CET
Last Modified:              04-25-2005 00:03 CEST
======================================================================
Summary:                    NVidia CK8S 8ch: a center speaker is always silent
in native alsa mode (through alsa-lib), works with oss emulation though
Description: 
A center speaker stays quiet while playing 5.1 audio directly through
alsa-lib (eg. with kaffeine (xine) or mplayer using alsa plugin). As a
result, I'm unable to hear what people are speaking in movies because the
speech is usually sent to the center speaker (correct me if i'm wrong. i'm
new to all this 5.1 business). Anyway, adjusting the volume,
muting/unmuting "Center" section, enabling/disabling "Mic As Center/LFE"
doesn't have any effect on the center speaker. It stays silent. However,
as I noted in the summary, the center speaker works with oss audio driver
of xine/mplayer (using oss emulation). However, that mode is not perfect
as the center speaker plays the role of left surround and vice versa. In
addition, a right surround speaker stays always silent (i guess that's
because the RS channel needs to be swapped with LFE; at least I got this
impression by having a look at
/usr/share/alsa/cards/NForce.conf:surround51). To sum up, my problem is
that I can't get the center speaker (which, I guess, is channel 2 on my
hardware) working with native alsa apps playing ac3/5.1 audio.
======================================================================

----------------------------------------------------------------------
 modax - 04-08-05 01:55 
----------------------------------------------------------------------
Yes, Current surround51 channel routing is OK.

----------------------------------------------------------------------
 modax - 04-25-05 00:03 
----------------------------------------------------------------------
I've tested alsa-driver and alsa-lib CVS as of 2005-04-24 and I really like
the new way of surround jacks management. I can confim, that "Independent"
works as expected here, not sure about "Shared", but I can test it if you
wish. Thanks for your work on this issue. 

In addition, I want to propose a suggestion to make surround support
completely flawless. The "Duplicate Front" switch makes no sence in
surround{40,51} modes because it replaces real sound information going to
surround channels with front speaker soundstream. "Duplicate Front" is
acceptible only in 2ch mode as these is no original surround soundstream.
But in 4ch and 6ch it results in original surround soundstream loss. So
I've prepared a patch to NFORCE.conf, which resolves the issue by
disabling "Duplicate Front" in 4ch and 6ch modes. The patch is against
alsa-lib CVS 2005-04-24.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 22:34 modax          New Issue                                    
03-22-05 22:34 modax          Distribution              => Debian unstable 
03-22-05 22:34 modax          Kernel Version            => vanilla 2.6.11.5 with
self-compiled alsa-driver 1.0.9rc1
03-23-05 13:01 tiwai          Note Added: 0004156                          
03-25-05 00:37 modax          Note Added: 0004204                          
03-25-05 00:37 modax          File Added: bug-1009.tar.gz                    
03-30-05 18:22 tiwai          Note Added: 0004268                          
03-30-05 18:22 tiwai          File Added: nforce-conf-test.diff                 
  
03-30-05 23:28 modax          Note Added: 0004275                          
04-03-05 17:47 modax          Note Added: 0004311                          
04-04-05 09:59 modax          Note Added: 0004324                          
04-07-05 16:28 tiwai          Note Added: 0004358                          
04-08-05 01:55 modax          Note Added: 0004371                          
04-25-05 00:03 modax          Note Added: 0004568                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
