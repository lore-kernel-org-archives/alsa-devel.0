From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002210]: poll() behaving anomalously,
	returning alternate streams on each interrupt,
	playback then capture but never both together
Date: Thu, 15 Jun 2006 04:17:02 +0200
Message-ID: <954a7c9791d11a5fcfe9f7e9b092e779@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 948D81A8
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 04:17:02 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2210> 
======================================================================
Reported By:                cmorgan
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2210
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.16-2-amd64-k8 (Debian 2.6.16-14)
======================================================================
Date Submitted:             06-14-2006 23:56 CEST
Last Modified:              06-15-2006 04:17 CEST
======================================================================
Summary:                    poll() behaving anomalously, returning alternate
streams on each interrupt, playback then capture but never both together
Description: 
poll() behaving anomalously, returning alternate streams on each interrupt,
playback then capture but never both together.  Causes jack audio server
to be unable to play back audio.

Running jack with the alsa plugin and giving it the -P option puts the
jack alsa driver into playback only mode.  This makes jack work again.
======================================================================

----------------------------------------------------------------------
 cmorgan - 06-15-06 02:47 
----------------------------------------------------------------------
I apologize for not providing more information.  I haven't developed with
alsa before so its tough to know what is enough information to provide.

Here is the trace from the case where jackd is poll()ing on playback and
capture:

1150332186452694: checked 1 fds, 22954 usecs since poll entered
capture: revents & POLLERR, setting xrun_detected
1150332186452694 capture stream ready
capture_avail == -EPIPE, setting xrun_detected
playback_avail == -EPIPE, setting xrun_detected
xrun_detected, calling alsa_driver_xrun_recovery() and returning 0

1150332186529668: checked 2 fds, 20899 usecs since poll entered
1150332186529668 playback stream ready
1150332186529668 capture stream timed out

1150332186556790: checked 1 fds, 27109 usecs since poll entered
capture: revents & POLLERR, setting xrun_detected
1150332186556790 capture stream ready
capture_avail == -EPIPE, setting xrun_detected
playback_avail == -EPIPE, setting xrun_detected
xrun_detected, calling alsa_driver_xrun_recovery() and returning 0

1150332186636694: checked 2 fds, 23851 usecs since poll entered
...



and the one from just playback:

1150332304773422: checked 1 fds, 21313 usecs since poll entered
1150332304773422 playback stream ready
wakeup complete, avail = 1024, pavail = 1024 cavail = 2147483647

1150332304794754: checked 1 fds, 21318 usecs since poll entered
1150332304794754 playback stream ready
wakeup complete, avail = 1024, pavail = 1024 cavail = 2147483647

1150332304816085: checked 1 fds, 21315 usecs since poll entered
1150332304816085 playback stream ready
wakeup complete, avail = 1024, pavail = 1024 cavail = 2147483647

1150332304837422: checked 1 fds, 21320 usecs since poll entered
...


So, in the case of just playback jack doesn't detect an xrun every other
poll() and works like it should

Chris

----------------------------------------------------------------------
 cmorgan - 06-15-06 04:17 
----------------------------------------------------------------------
Paul requested that I add our discussion from irc:

<las> cmorgan: add another note that the expected wakeup interval is
21msecs
<las> cmorgan: which then makes it clearer that the behaviour is
sort-of-correct-but-not-really
<cmorgan> las: right, so its broken because every 21msec alsa should be
asking for more playback data right?
<cmorgan> and right now its asking every 42?
<las> cmorgan: no, it wakes up every 21msec as it should, but only
alternating fd's are marked as ready
<las> cmorgan: if JACK was written incorrectly, this wouldn't work for
*any* interface
<las> cmorgan: but it clearly does work for all of them that do duplex
properly.
<cmorgan> las: right.  so shouldn't it be waking up every 21msec asking
for playback data at the very least?
<las> cmorgan: so there are 2 choices: either your card can't do duplex
properly (possible) or the ALSA driver is broken
<las> cmorgan: if it is doing duplex, every 21msec both the playback and
capture file descriptors should be ready for i/o
<cmorgan> right
<cmorgan> las: why the capture one as well? because they are at the same
settings(sr etc) as playback due to hardware imposed restrictions?
<las> cmorgan: think of it this way. at time N, the playback stream is
ready, but for some reason not capture.
<las> cmorgan: then at time N+21msecs, the capture stream is ready 
<cmorgan> las: i guess i'm not understanding why capture has any bearing
on this :-)
<cmorgan> since we are playing back
<las> cmorgan: since JACK didn't do anything in the meantime, the playback
fd should be ready as well
<las> cmorgan: but instead, its timed out with an xrun
<las> cmorgan: so either the h/w is broken by design (i.e. the capture +
playback streams are always 1 period out of sync, or the driver is broken
<las> cmorgan: another interesting thing to try for you would be to drop
the -P but increase the number of periods per h/w buffer to at least 3 (-n
3)
<cmorgan> las: i guess i'm not sure why we care about capturing in this
case though since we are only playing back
<cmorgan> las: looks the same with -n 3, -n 4
<las> cmorgan: it works for playback only. thats the whole point.
<las> cmorgan: i am talking about the non-working case. now i have to go
clean up dinner etc.
<cmorgan> las: ok :-)
<las> cmorgan: paste this conversation in bugzilla if you like

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 23:56 cmorgan        New Issue                                    
06-14-06 23:56 cmorgan        Distribution              => Debian          
06-14-06 23:56 cmorgan        Kernel Version            => 2.6.16-2-amd64-k8
(Debian 2.6.16-14)
06-15-06 00:31 rlrevell       Note Added: 0010217                          
06-15-06 02:47 cmorgan        Note Added: 0010224                          
06-15-06 04:17 cmorgan        Note Added: 0010230                          
======================================================================
