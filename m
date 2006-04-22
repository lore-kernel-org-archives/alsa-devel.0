From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002056]: UA-20 unusable in "advanced mode"
Date: Sat, 22 Apr 2006 06:14:55 +0200
Message-ID: <96ec3b6034e2408de3819e9384a2e847@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 66AE8174
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2006 06:14:55 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2056> 
======================================================================
Reported By:                jp30
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2056
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-22-2006 06:14 CEST
Last Modified:              04-22-2006 06:14 CEST
======================================================================
Summary:                    UA-20 unusable in "advanced mode"
Description: 
I have an Edirol UA-20, and was hoping to use it for recording 24 bit
sound.  When I start jack 0.100.7 with "jackd -d alsa -d hw:2", I see
this:

creating alsa driver ... hw:2|hw:2|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:2
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
Note: audio device hw:2 doesn't support a 32bit sample format so JACK will
try a 24bit format instead
nperiods = 2 for capture
Note: audio device hw:2 doesn't support a 32bit sample format so JACK will
try a 24bit format instead
nperiods = 2 for playback
ALSA: could not start playback (Broken pipe)
DRIVER NT: could not start driver
cannot start driver

At that point jackd locks up (only responding to SIGKILL), loadavg goes to
1.0, and I see this message in the kernel log:

cannot submit datapipe for urb 0, err = -90

This message, and the strange loadavg behavior makes me think this is an
alsa problem rather than a jack problem, but this is hard to check as I
know of no other apps that will speak the 24bit format this device uses.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-22-06 06:14 jp30           New Issue                                    
04-22-06 06:14 jp30           Distribution              => gentoo          
04-22-06 06:14 jp30           Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
