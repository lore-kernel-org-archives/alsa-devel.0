From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001009]: NVidia CK8S 8ch: a center speaker is always silent in native alsa mode (through alsa-lib), works with oss emulation though
Date: Mon, 4 Apr 2005 09:59:59 +0200
Message-ID: <bf3416fba5d225c4caef73de47893f82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7655B1DD
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 09:59:59 +0200 (MEST)
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
Last Modified:              04-04-2005 09:59 CEST
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
 modax - 04-03-05 17:47 
----------------------------------------------------------------------
The bug I described in note
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0004275 is a completely
different one. I
submited a new bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1034
for it. Let's go back to the original problem as
it seems it's not fixed in alsa 1.0.9rc2+cvs20050403

----------------------------------------------------------------------
 modax - 04-04-05 09:59 
----------------------------------------------------------------------
This bug is a dupe of
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0000891. I have seperate
sockets for surround,
center and side channels (8ch) on my board. Disabling hooks helped to get
the center speaker & LFE back. Forcing and especially *locking* "Line-In
As Surround" and "Mic As Center/LFE" is not an universal solution anymore.
It may confuse lots of people. What you should do at least is *not to
lock* those switches. Locking effect is not reflected by mixers and people
like me may get confused because turning on/off the switches doesn't make
any difference although actually it would if locking were disabled. Please
disable locking or better yet do not force those switches on. Thanks!

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
