From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000745]: Crash when unplugging USB Headset
Date: Mon, 25 Apr 2005 10:53:41 +0200
Message-ID: <28b58772d6b237dad51810be208c6216@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DB2EB14C
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 10:53:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=745> 
======================================================================
Reported By:                greve
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   745
Category:                   USB - usb-audio
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10-rc3 (also happened with 2.6.9)
======================================================================
Date Submitted:             12-24-2004 12:56 CET
Last Modified:              04-25-2005 10:53 CEST
======================================================================
Summary:                    Crash when unplugging USB Headset
Description: 
Discovered this when trying to get a Logitech USB Headset to work.

All this with 2.6.9:

When first plugging it in, snd-usb-audio was missing, so recompiled
kernel, loaded module without rebooting (yes. i know. i was lazy.) and the
Headset worked perfectly fine.

When booting the machine the next time, headset was recognized propely,
usb-audio driver loaded, /proc/asound showed Headset soundcard, mixer
worked fine, no warning messages, but: NO SOUND. Everything CLAIMED to be
working fine, but the headset remained silent.

Tried around a couple of times with different settings of compiling things
into the kernel/as module and eventually gave kernel 2.6.10-rc3 a try.

While trying around with 2.6.9 and 2.6.10-rc3 both, at some time the
keyboard would stop to work while fiddling with the USB Headset
(pluggin/unplugging), while the mouse (also USB) was still working fine.
The machine would hang during reboot and had to be reset by button.

Below is the syslog output from the kernel for the latest crash.

I know this may not be the most helpful error report ever written -- but I
don't quite know where to look. Help appreciated.

If you need more info, please let me know.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-08-05 09:01 
----------------------------------------------------------------------
Doesn't happen with my 2.6.11 kernel (hotplug and preempt enabled).

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:53 
----------------------------------------------------------------------
There was a bug in the USB audio driver that resulted in the kernel input
event thread being blocked when unplugging.  This has been fixed in CVS.

As to the "no sound": Did you unmute and raise the volume of the
appropriate mixer controls?  What is the output of "amixer contents"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-04 12:56 greve          New Issue                                    
12-24-04 12:56 greve          Distribution              => Debian GNU/Linux
12-24-04 12:56 greve          Kernel Version            => 2.6.10-rc3 (also
happened with 2.6.9)
12-24-04 13:03 greve          Note Added: 0002930                          
12-26-04 18:13 greve          Note Added: 0002941                          
12-26-04 18:14 greve          Note Deleted: 0002930                        
12-26-04 20:39 greve          Note Edited: 0002941                         
12-27-04 12:55 greve          Note Added: 0002959                          
03-05-05 14:27 therp          Note Added: 0003803                          
03-08-05 09:01 Clemens LadischNote Added: 0003811                          
04-25-05 10:53 Clemens LadischNote Added: 0004573                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
