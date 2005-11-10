From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001538]: Latency was better on earlier version
Date: Thu, 10 Nov 2005 21:11:55 +0100
Message-ID: <9f34fb071a7585b6440c3a25b1b2bbd2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD1951D9
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 21:11:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1538> 
======================================================================
Reported By:                pesalomo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1538
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-09-2005 21:01 CET
Last Modified:              11-10-2005 21:11 CET
======================================================================
Summary:                    Latency was better on earlier version
Description: 
I don't know what category which is best for this - but I'm comparing Linux
kernel 2.6.10 and 2.6.14. 

Using I82801DBICH4, version 1.0.10rc1, which is bundled with Linux 2.6.14
- the performance is much weaker than when using kernel 2.6.10 (don't
remember the driver version there).

On 2.6.10 I was able to use a buffer size down to 128 bytes, but now the
lowest I can go is 512. And the sound is still crispy.
======================================================================

----------------------------------------------------------------------
 pesalomo - 11-10-05 19:11 
----------------------------------------------------------------------
This is some of the output of "aplay -D hw:0 -v --period-size=32
--buffer-size=64 -t raw -f dat /dev/zero" using kernel 2.6.14

Status:
state       : XRUN
trigger_time: 1131646180.600730000
tstamp      : 1131646180.600815000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 2.237 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.617336000
tstamp      : 1131646180.619571000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 0.033 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.632774000
tstamp      : 1131646180.632805000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.898 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.634022000
tstamp      : 1131646180.635918000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 0.191 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.637126000
tstamp      : 1131646180.637316000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.944 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.653834000
tstamp      : 1131646180.655776000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.959 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.669669000
tstamp      : 1131646180.671626000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 2.220 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.685502000
tstamp      : 1131646180.687720000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.991 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.701584000
tstamp      : 1131646180.703573000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 2.132 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.717439000
tstamp      : 1131646180.719569000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 2.060 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.733440000
tstamp      : 1131646180.735498000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 2.118 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.749384000
tstamp      : 1131646180.751500000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 0.105 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.764712000
tstamp      : 1131646180.764815000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.782 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.766023000
tstamp      : 1131646180.767804000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 0.120 ms long)
Status:
state       : XRUN
trigger_time: 1131646180.769001000
tstamp      : 1131646180.769119000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 1.813 ms long)

----------------------------------------------------------------------
 Clemens Ladisch - 11-10-05 21:11 
----------------------------------------------------------------------
I wanted to see the beginning of the output.  But the "avail" values show
that the buffer has a size of 64 frames.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-09-05 21:01 pesalomo       New Issue                                    
11-09-05 21:01 pesalomo       Distribution              => Gentoo Linux    
11-09-05 21:01 pesalomo       Kernel Version            => 2.6.14          
11-09-05 21:02 pesalomo       Issue Monitored: pesalomo                    
11-10-05 08:57 Clemens LadischNote Added: 0006660                          
11-10-05 19:11 pesalomo       Note Added: 0006668                          
11-10-05 21:11 Clemens LadischNote Added: 0006671                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
