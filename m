From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001009]: NVidia CK8S 8ch: a center speaker is always silent in native alsa mode (through alsa-lib), works with oss emulation though
Date: Sun, 3 Apr 2005 17:47:23 +0200
Message-ID: <5027b52a00a388ecb497d08b342cfaba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 351EF1DD
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 17:47:24 +0200 (MEST)
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
Last Modified:              04-03-2005 17:47 CEST
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
 modax - 03-30-05 23:28 
----------------------------------------------------------------------
The patch does not help, i.e. it does not change anything. And the bug
doesn't seem to be mixer related, because I am sometimes able to hear some
sound coming with -Dsurround51. That's what I observed:

Firstly, I execute a command:

$ speaker-test -Dfront -c2 -f1000

This one plays continuous 1000Hz tone (sharp) to Front speakers and
everything works as expected. Next I run a command:

$ speaker-test -Dsurround51 -c6 -f75

This one should play continuous 75Hz tone (bass) to my 5.1 speakers.
However, I get the same 1000Hz tone (or something near it, but it's
definitely not 75hz) which I played before instead. In addition, the tone
is jerky and is *always* played on the Front Left and Rear Surround Left
speakers, i.e. as speaker-test circles through the Front L/R -> Rear L/R
-> Center -> LFE the tone is always played on Front and Rear Left speakers
no matter what speaker-test says it should be played on.

To sum up, it seems that alsa-lib 1.0.9rc1+ (I guess it's a fault of the
library, because downgrading to alsa-lib 1.0.8 helps) with -Dsurround51
repeats the last tone played (with some disortion) endlessly ignoring the
sound the application sends to it. This explains why I got no sound at all
with my previous -Dsurround51 tests. Most audio streams end with silence
and because -Dsurround51 repeats the last tone (tones) played, it ends up
with repeating silence.

I performed these tests with alsa-driver & alsa-lib compiled from CVS as
of 2005-03-29 23:00 UTC with your patch applied (as I state above, your
patch doesn't have any effect). I used speaker-test from alsa-utils 1.0.8
but, I guess, that shouldn't matter.

----------------------------------------------------------------------
 modax - 04-03-05 17:47 
----------------------------------------------------------------------
The bug I described in note
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0004275 is a completely
different one. I
submited a new bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1034
for it. Let's go back to the original problem as
it seems it's not fixed in alsa 1.0.9rc2+cvs20050403

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
