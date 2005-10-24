From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001496]: JAck won't run on the CMedia 8738
Date: Mon, 24 Oct 2005 18:30:32 +0200
Message-ID: <25515a4da6022dc987ab98857a1448ad@85.132.177.35>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from 85.132.177.35 (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0AAC192
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2005 18:30:33 +0200 (MEST)
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
<https://85.132.177.35/alsa-bug/view.php?id=1496> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1496
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14-rc5-rt5 && 2.6.12-gentoo-r10
======================================================================
Date Submitted:             10-24-2005 18:30 CEST
Last Modified:              10-24-2005 18:30 CEST
======================================================================
Summary:                    JAck won't run on the CMedia 8738
Description: 
I have a machine with 3 sound devices in it:

mark@gigastudio ~ $ cat /proc/asound/cards
0 [M2496          ]: ICE1712 - M Audio Audiophile 24/96
                    M Audio Audiophile 24/96 at 0xa400, irq 10
1 [R15            ]: RME9636 - RME Digi9636 (Rev 1.5)
                    RME Digi9636 (Rev 1.5) at 0xe2000000, irq 9
2 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                    C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 11
mark@gigastudio ~ $

  Jack is installed and runs fine on the AP2496 and the Hammerfall.
Jack does not run correctly on the 8738. I first saw this on
2.6.12-gentoo-r10 so I updated to 2.6.14-rc5-rt5 and see the same
problem. The problem is independent of JAck timings. It's as bad with
1024/2 as it is with 128/2.

1) If I use QJackCtl to start Jack it fails immediately:

09:07:02.736 JACK is starting...
09:07:02.737 /usr/bin/jackd -R -P80 -dalsa -dhw:2 -r44100 -p128 -n2
09:07:02.752 JACK was started with PID=6191 (0x182f).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:2|hw:2|128|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:2
configuring for 44100Hz, period = 128 frames, buffer = 2 periods
Note: audio device hw:2 doesn't support a 32bit sample format so JACK
will try a 24bit format instead
Note: audio device hw:2 doesn't support a 24bit sample format so JACK
will try a 16bit format instead
nperiods = 2 for capture
Note: audio device hw:2 doesn't support a 32bit sample format so JACK
will try a 24bit format instead
Note: audio device hw:2 doesn't support a 24bit sample format so JACK
will try a 16bit format instead
nperiods = 2 for playback
09:07:04.844 Server configuration saved to "/home/mark/.jackdrc".
09:07:04.845 Statistics reset.
09:07:04.965 Client activated.
09:07:04.966 Audio connection change.
09:07:04.973 Audio connection graph change.
09:07:04.974 XRUN callback (1).
09:07:06.977 XRUN callback (342 skipped).
jackd watchdog: timeout - killing jackd
zombified - calling shutdown handler
09:07:07.952 Shutdown notification.
09:07:07.953 Client deactivated.
09:07:07.954 JACK was stopped successfully.
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)

2) If I change the settings to support capture only it seems to work.
I have not tested that I can actually receive audio as it isn;t
important in my application:

09:07:53.784 JACK is starting...
09:07:53.786 /usr/bin/jackd -R -P80 -dalsa -dhw:2 -r44100 -p128 -n2 -C
09:07:53.793 JACK was started with PID=6198 (0x1836).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... -|hw:2|128|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:2
configuring for 44100Hz, period = 128 frames, buffer = 2 periods
Note: audio device hw:2 doesn't support a 32bit sample format so JACK
will try a 24bit format instead
Note: audio device hw:2 doesn't support a 24bit sample format so JACK
will try a 16bit format instead
nperiods = 2 for capture
09:07:55.902 Server configuration saved to "/home/mark/.jackdrc".
09:07:55.904 Statistics reset.
09:07:55.909 Client activated.
09:07:55.911 Audio connection change.
09:07:55.921 Audio connection graph change.

3) If I set it for playback only it fails with lots of xruns:

09:08:36.228 JACK is starting...
09:08:36.230 /usr/bin/jackd -R -P80 -dalsa -dhw:2 -r44100 -p128 -n2 -P
09:08:36.248 JACK was started with PID=6205 (0x183d).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:2|-|128|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:2
configuring for 44100Hz, period = 128 frames, buffer = 2 periods
Note: audio device hw:2 doesn't support a 32bit sample format so JACK
will try a 24bit format instead
Note: audio device hw:2 doesn't support a 24bit sample format so JACK
will try a 16bit format instead
nperiods = 2 for playback
09:08:38.388 Server configuration saved to "/home/mark/.jackdrc".
09:08:38.390 Statistics reset.
09:08:38.395 Client activated.
09:08:38.397 Audio connection change.
09:08:38.404 Audio connection graph change.
09:08:41.458 XRUN callback (1).
delay of 5809.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5697.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5675.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5675.000 usecs exceeds estimated spare time of 2872.000; restart
...

<SNIP>

delay of 5660.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5665.000 usecs exceeds estimated spare time of 2872.000; restart
...
09:08:42.322 Client deactivated.
09:08:42.323 JACK is stopping...
delay of 5667.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5641.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5734.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5743.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5758.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5683.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5750.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5739.000 usecs exceeds estimated spare time of 2872.000; restart
...
delay of 5769.000 usecs exceeds estimated spare time of 2872.000; restart
...
jack main caught signal 15
delay of 5656.000 usecs exceeds estimated spare time of 2872.000; restart
...
no message buffer overruns
09:08:42.392 JACK was stopped successfully.

The hardware is pretty generic:

gigastudio ~ # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
0000:00:05.0 Multimedia audio controller: C-Media Electronics Inc
CM8738 (rev 10)
0000:00:06.0 Mass storage controller: Promise Technology, Inc.
PDC20265 (FastTrak100 Lite/Ultra100) (rev 02)
0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23
IEEE-1394 Controller
0000:00:0d.0 Ethernet controller: Intel Corporation 82557/8/9
[Ethernet Pro 100] (rev 05)
0000:00:0f.0 Multimedia audio controller: Xilinx Corporation RME
Digi9652 (Hammerfall) (rev 08)
0000:00:10.0 Multimedia audio controller: VIA Technologies Inc.
ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 1b)
0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 1b)
0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 1b)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18
[GeForce4 MX 4000 AGP 8x] (rev c1)
gigastudio ~ #


It runs fine with the Hammerfall:

09:13:57.183 JACK is starting...
09:13:57.185 /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
09:13:57.218 JACK was started with PID=6240 (0x1860).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:1|hw:1|128|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:1
configuring for 44100Hz, period = 128 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
09:13:59.375 Server configuration saved to "/home/mark/.jackdrc".
09:13:59.377 Statistics reset.
09:13:59.500 Client activated.
09:13:59.503 Audio connection change.
09:13:59.510 Audio connection graph change.

It runs fine with the AP2496:

09:14:41.826 JACK is starting...
09:14:41.828 /usr/bin/jackd -R -dalsa -dhw:0 -r44100 -p128 -n2
09:14:41.845 JACK was started with PID=6247 (0x1867).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:0|hw:0|128|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 44100Hz, period = 128 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
09:14:43.933 Server configuration saved to "/home/mark/.jackdrc".
09:14:43.935 Statistics reset.
09:14:43.941 Client activated.
09:14:43.943 Audio connection change.
09:14:43.951 Audio connection graph change.

gigastudio ~ # cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
gigastudio ~ #



======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-05 18:30 Mark Knecht    New Issue                                    
10-24-05 18:30 Mark Knecht    Distribution              => Gentoo          
10-24-05 18:30 Mark Knecht    Kernel Version            => 2.6.14-rc5-rt5 &&
2.6.12-gentoo-r10
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
