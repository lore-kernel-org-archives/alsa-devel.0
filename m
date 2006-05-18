From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002133]: Lacking support for simple USB "wireless" (via bluetooth A2DP) / no mixer
Date: Thu, 18 May 2006 09:45:14 +0200
Message-ID: <6edf2e9618a11daed6173fa6c90a1cbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7EB261A2
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2006 09:45:14 +0200 (MEST)
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
Last Modified:              05-18-2006 09:45 CEST
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

----------------------------------------------------------------------
 dx9s - 05-18-06 08:42 
----------------------------------------------------------------------
I just looked at the lsusb -v in more detail and went back and looked at
the error message:

ALSA /root/src/alsa-driver-1.0.11/usb/usbaudio.c:2670: 3:1:0 : no or
invalid class specific endpoint descriptor


and the end of the lsusb -v:
...
      Endpoint Descriptor:
        bLength 7
        bDescriptorType 5
        bEndpointAddress 0x81 EP 1 IN
        bmAttributes 3
          Transfer Type Interrupt
          Synch Type None
          Usage Type Data
        wMaxPacketSize 0x0010 bytes 16 once
        bInterval 1
        HID Device Descriptor:
          bLength 9
          bDescriptorType 33
          bcdHID 1.11
          bCountryCode 0 Not supported
          bNumDescriptors 1
          bDescriptorType 34 Report
          wDescriptorLength 44

Hey.. the last descriptor has something that isn't usb-sound related ...
this is the entry that describes the HID functionality.... 

I HAVE A STRONG HUNCH that *THIS* is causes the error message reported in
dmesg... "no or invalid class specific endpoint descriptor" .. I wonder!
could it be this simple?

work around would be to read this descripter and ignore it...??? the HID
function are secondary to getting the primary function (sound) to work!?

Just a thought!

--Doug

----------------------------------------------------------------------
 Clemens Ladisch - 05-18-06 09:45 
----------------------------------------------------------------------
This error message has nothing to do with either the lack of mixer controls
or the HID interface.

In this case, "no or invalid class specific endpoint descriptor" means
that this device does not have the class-specific endpoint descriptor that
is required by the USB Audio specification.

Please try the patch (it makes the driver guess some endpoint attributes
that hopefully will work).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-06 08:12 dx9s           New Issue                                    
05-18-06 08:12 dx9s           Distribution              => Slackware 10.2  
05-18-06 08:12 dx9s           Kernel Version            => 2.6.16.16       
05-18-06 08:14 dx9s           Issue Monitored: dx9s                        
05-18-06 08:42 dx9s           Note Added: 0009862                          
05-18-06 09:45 Clemens LadischNote Added: 0009863                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
