From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002210]: poll() behaving anomalously,
	returning alternate streams on each interrupt,
	playback then capture but never both together
Date: Thu, 15 Jun 2006 02:47:15 +0200
Message-ID: <28549e55d9ba1f15e02836750e92049b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0CE6F15D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 02:47:15 +0200 (MEST)
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
Last Modified:              06-15-2006 02:47 CEST
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
 rlrevell - 06-15-06 00:31 
----------------------------------------------------------------------
That's normal behavior - on most sound cards the capture and playback are
independent.  JACK should handle it.  I think it might be a bug in JACK.

What exactly are the symptoms - "it doesn't work" is not helpful.  Please
post the exact error messages.

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 23:56 cmorgan        New Issue                                    
06-14-06 23:56 cmorgan        Distribution              => Debian          
06-14-06 23:56 cmorgan        Kernel Version            => 2.6.16-2-amd64-k8
(Debian 2.6.16-14)
06-15-06 00:31 rlrevell       Note Added: 0010217                          
06-15-06 02:47 cmorgan        Note Added: 0010224                          
======================================================================
