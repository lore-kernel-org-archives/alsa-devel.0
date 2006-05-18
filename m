From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002133]: Lacking support for simple USB "wireless" (via bluetooth A2DP) / no mixer
Date: Thu, 18 May 2006 08:12:07 +0200
Message-ID: <f3b8c6fd47850ef726952a97630d0564@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06B0B23A
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2006 08:12:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2133> 
======================================================================
Reported By:                dx9s
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2133
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.2
Kernel Version:             2.6.16.16
======================================================================
Date Submitted:             05-18-2006 08:12 CEST
Last Modified:              05-18-2006 08:12 CEST
======================================================================
Summary:                    Lacking support for simple USB "wireless" (via
bluetooth A2DP) / no mixer
Description: 
was using 2.6.15.6 (packed with alsa-driver 1.0.10rc3), updater to
2.6.16.16 (packed with alsa-driver 1.0.11rc2) and update alsa-driver to
1.0.11 (finial) as well other alsa-*-1.0.11

Hardware: Saitek A-250 http://www.saitekaudio.com/en/a250.asp

according to other resources I've seen, it is a wireless USB audio device
that uses a generic Bluetooth A2DP
(http://en.wikipedia.org/wiki/Bluetooth#Bluetooth_profiles) transport. I
have not used on WinHoles XP but it appears that it uses whatever Native
usb audio support that comes with XP -- so it appears to be generic.

Get error message (enabled advanced alsa debuging, "CONFIG_SND_DEBUG=y")

ALSA /root/src/alsa-driver-1.0.11/usb/usbaudio.c:2670: 3:1:0 : no or
invalid class specific endpoint descriptor

BTW> the Bluetooth transport is not available and only a USB audio device
appears to be present to the system

I have a pure guess that it might ALSO have problem with the hardware not
having a software controllable mixer (mixer is only remote unit). Also
purportedly, it also can function as a HID device from the "remote" (it
has play/pause, next and previous / which it claims will work with
WinHoles Media Player)

Summary: tweaking the driver to support this hardware? It has pretty good
sound for being so small (using the wired LINE input). I've come across
others out there (in the internet) that are interested in using it with
Linux and claim they reached somebody at the company -- which is how I
know it uses A2DP.

--Doug
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-06 08:12 dx9s           New Issue                                    
05-18-06 08:12 dx9s           Distribution              => Slackware 10.2  
05-18-06 08:12 dx9s           Kernel Version            => 2.6.16.16       
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
