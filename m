From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001561]: Edirol UA-25 won't run with capture in jack
Date: Wed, 16 Nov 2005 16:38:11 +0100
Message-ID: <9f2d2cb90d91984ddd8daf70d60402c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DE7D1C5
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 16:38:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1561> 
======================================================================
Reported By:                plekter
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1561
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-15-2005 19:47 CET
Last Modified:              11-16-2005 16:38 CET
======================================================================
Summary:                    Edirol UA-25 won't run with capture in jack
Description: 
If i run jackd with -P, then it works perfectly. If i use -C or -D, then it
produces this error:

jackd 0.100.0
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:1|hw:1|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:1
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
Note: audio device hw:1 doesn't support a 32bit sample format so JACK will
try a 24bit format instead
nperiods = 2 for capture
Note: audio device hw:1 doesn't support a 32bit sample format so JACK will
try a 24bit format instead
nperiods = 2 for playback
ALSA: could not start playback (Broken pipe)
DRIVER NT: could not start driver
cannot start driver

In the kernel logs i find

cannot submit datapipe for urb 3, err = -28

======================================================================

----------------------------------------------------------------------
 plekter - 11-16-05 10:04 
----------------------------------------------------------------------
With 2.6.15-rc1 i can not have period sizes larger than 512. The same error
message appears in the kernel log if i try running jack with -p 1024.

(cannot submit datapipe for urb 3, err = -28)

Capture still does not work, same error.

----------------------------------------------------------------------
 Clemens Ladisch - 11-16-05 16:38 
----------------------------------------------------------------------
28 is ENOSPC and means that the kernel thinks that there isn't enough
bandwidth.

The bandwidth checking code is broken; disable it in the kernel
configuration, and file a bug report with your distribution.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-15-05 19:47 plekter        New Issue                                    
11-15-05 19:47 plekter        Distribution              => Debian          
11-15-05 19:47 plekter        Kernel Version            => 2.6.14          
11-15-05 19:57 plekter        Issue Monitored: plekter                     
11-16-05 10:04 plekter        Note Added: 0006738                          
11-16-05 16:38 Clemens LadischNote Added: 0006744                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
