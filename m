From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000490]:  Choppy sound when playing on Acer TravelMate 2000
Date: Thu, 15 Sep 2005 15:14:10 +0200
Message-ID: <afcc34471a202d349e4c0dddf3bd1861@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 68D33175
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:14:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=490> 
======================================================================
Reported By:                feixm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   490
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               linuxfromscratch, everything compiled from original
sources
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-08-2004 21:16 CEST
Last Modified:              09-15-2005 15:14 CEST
======================================================================
Summary:                     Choppy sound when playing on Acer TravelMate 2000
Description: 
Hello,

when playing any audio file from my new Acer TravelMate 2000, the sound is
very choppy. I tried playing using xmms, mplayer and others. From lspci I
see, it is an ATI IXP 150. I understand that this bugreport alone won't
help you guys, so if I can give any more info, pls let me know.

When playing movies with mplayer, I see lots of messages like:

alsa-play: xrun of at least 0,131 msecs. resetting stream%  0%  0,0% 1 0
0%
alsa-play: xrun of at least 0,026 msecs. resetting stream 0%  0%  0,0% 7 0
0%

These appear even more where skipping back and forward in the movie.

I found, that playing movies through SDL helps a little, but sound is
still choppy and cannot be listened to.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000583 xruns when playing audio or video files
======================================================================

----------------------------------------------------------------------
 feixm - 01-22-05 13:30 
----------------------------------------------------------------------
Yes, I tried OSS emulation in my very first attempts to solve this problem.
Since I've found, that there is no difference in using directly Alsa or
indirectly alsa through OSS emulation, I completelly stoped to compile
programs with deprecated OSS support. So, the answer is - yes, I tried OSS
emulation about 3 months ago, when I installed Linux on this notebook and
discovered this problem.

Another note regarding Mplayer. It's not only mplayer, it's XMMS, it's
virtualy everything in my KDE desktop, which is using ARTS daemon, which
in turn is configured to use Alsa, or OSS few months ago. No matter what I
use, the symptomps are still the same.

Everything is fine, say for about 3 to 10 minutes (this is VERY random),
that suddenly sounds gets scrambled for few hunderds of miliseconds up to
two seconds and then it continues to play normaly. After random number of
seconds (minutes) it happens again.

Yesterday I've installed into my XMMS a crossfading module. When it's set
up to use Alsa as output device, it plays "fine", with the behaviour
described above. But when I use ARTS as an output device, it plays one
second of music, then it skips about 10 seconds, plays another second of
music, then skips another 10 secods... Looks like it's filling some sound
buffer but the buffer gets flushed sooner, then it's actually played. When
using ARTS as direct output (without Crossfader module as intermediate) it
plays "fine", with the mentioned behaviour.

Maybe this helps, maybe it's a description of a XMMS or ARTSd bug and it
has nothing to do with this problem. Who knows. I definitelly don't :).

----------------------------------------------------------------------
 jdthood - 09-15-05 15:14 
----------------------------------------------------------------------
> alsa-play: xrun of at least 0,019 msecs. resetting stream

See bug #583.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 21:16 feixm          New Issue                                    
09-08-04 21:16 feixm          Distribution              => linuxfromscratch,
everything compiled from original sources
09-08-04 21:16 feixm          Kernel Version            => 2.6.8.1         
01-18-05 07:56 rounin         Note Added: 0003242                          
01-18-05 07:59 rounin         Issue Monitored: rounin                      
01-18-05 08:09 rounin         Note Added: 0003245                          
01-18-05 11:32 tiwai          Note Added: 0003247                          
01-18-05 21:25 rlrevell       Note Added: 0003260                          
01-18-05 22:47 feixm          Note Added: 0003261                          
01-19-05 15:17 feixm          Note Added: 0003282                          
01-19-05 15:20 tiwai          Note Added: 0003285                          
01-21-05 14:19 feixm          Note Added: 0003347                          
01-21-05 17:30 tiwai          Note Added: 0003350                          
01-21-05 19:13 rlrevell       Note Added: 0003351                          
01-22-05 13:30 feixm          Note Added: 0003376                          
09-15-05 15:13 jdthood        Relationship added       duplicate of 0000583
09-15-05 15:14 jdthood        Note Added: 0006205                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
