From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000721]: System stops completely when playing audio
Date: Sun, 12 Dec 2004 14:52:51 +0100
Message-ID: <e2340c5a8ab144227e29256ea7f20c17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E8A32313
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 14:52:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=721> 
======================================================================
Reported By:                spirou
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   721
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-12-2004 13:58 CET
Last Modified:              12-12-2004 14:52 CET
======================================================================
Summary:                    System stops completely when playing audio
Description: 
I have a Tascam US-428. Wehen I connect to the USB, the driver is loaded,
the USB-LED of the 428 lights up. When I try to play audio (e.g. with
aplay or XMMS), the computer immedeately stops working. All I can do is to
push the reset-button. No log-entrys, nothing.
======================================================================

----------------------------------------------------------------------
 karsten - 12-12-04 14:20 
----------------------------------------------------------------------
more details please!
$ modinfo snd_usb_usx2y
$ lspci

----------------------------------------------------------------------
 spirou - 12-12-04 14:52 
----------------------------------------------------------------------
modinfo:
author:         Karsten Wiese <annabellesgarden@yahoo.de>
description:    TASCAM US-X2Y Version 0.7.2
license:        GPL
parm:           index:Index value for US-X2Y.
parm:           id:ID string for US-X2Y.
parm:           enable:Enable US-X2Y.
vermagic:       2.6.9-gentoo-r9 preempt K7 gcc-3.3
depends:        snd-usb-lib,snd-page-alloc,snd-pcm,snd,usbcore,snd-hwdep
alias:          usb:v1604p8001dl*dh*dc*dsc*dp*ic*isc*ip*
alias:          usb:v1604p8007dl*dh*dc*dsc*dp*ic*isc*ip*
alias:          usb:v1604p8005dl*dh*dc*dsc*dp*ic*isc*ip*

lspci:
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev
02)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL
Media IO] (rev 25)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller
0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
PCI Fast Ethernet (rev 90)
0000:00:0a.0 Multimedia controller: Marian - Electronic & Software Marc-8
MIDI 8 channel audio card (rev 01)
0000:00:0c.0 Multimedia audio controller: RME Digi32 (rev c0)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev b2)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-04 13:58 spirou         New Issue                                    
12-12-04 13:58 spirou         Distribution              => Gentoo          
12-12-04 13:58 spirou         Kernel Version            => 2.6.9           
12-12-04 14:20 karsten        Note Added: 0002816                          
12-12-04 14:52 spirou         Note Added: 0002817                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
