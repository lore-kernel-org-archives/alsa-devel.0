From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001538]: Latency was better on earlier version
Date: Tue, 22 Nov 2005 16:18:30 +0100
Message-ID: <0f0f57f3dfd554051480046efdb7de7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A5E9197
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 16:18:30 +0100 (MET)
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
Last Modified:              11-22-2005 16:18 CET
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
 pesalomo - 11-10-05 21:55 
----------------------------------------------------------------------
aplay -D hw:0 -v --period-size=32 --buffer-size=64 -t raw -f dat /dev/zero
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Hardware PCM card 0 'Intel 82801DB-ICH4' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 64
period_size  : 32
period_time  : 666
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 32
xfer_align   : 32
start_threshold  : 64
stop_threshold   : 64
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
underrun!!! (at least 8.179 ms long)
Status:
state       : XRUN
trigger_time: 1131656091.89497000
tstamp      : 1131656091.97657000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 18.193 ms long)
Status:
state       : XRUN
trigger_time: 1131656091.113515000
tstamp      : 1131656091.131707000
delay       : 0
avail       : 64
avail_max   : 64
underrun!!! (at least 0.243 ms long)

----------------------------------------------------------------------
 pesalomo - 11-22-05 16:18 
----------------------------------------------------------------------
OK.. I withdraw this.. The reason for the difference was because of a
kernel parameter Timer frequency. (Under CPU type and features). A
recently added parameter?

I've set this to 1000 Hz and then it's perfect.

Sorry for false alarm.

Peter

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
11-10-05 21:55 pesalomo       Note Added: 0006673                          
11-22-05 16:18 pesalomo       Note Added: 0006787                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
