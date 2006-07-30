From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000745]: Crash when unplugging USB
	Headset
Date: Mon, 31 Jul 2006 01:48:28 +0200
Message-ID: <c402761d82bc73ac941bd1322252434e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E882F16C
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 01:48:28 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10-rc3 (also happened with 2.6.9)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-24-2004 12:56 CET
Last Modified:              07-31-2006 01:48 CEST
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
07-31-06 01:48 Adrian Bunk    Status                   assigned => resolved
07-31-06 01:48 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
