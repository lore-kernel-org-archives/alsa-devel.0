From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002177]: Logitech USB headset fails to
	work when used through usb hub
Date: Wed, 31 May 2006 23:38:38 +0200
Message-ID: <a08e79c8d694cefb8a9d2f790aabfd42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD62C140
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 23:38:38 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2177> 
======================================================================
Reported By:                harking
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2177
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             05-31-2006 23:38 CEST
Last Modified:              05-31-2006 23:38 CEST
======================================================================
Summary:                    Logitech USB headset fails to work when used through
usb hub
Description: 
Hello, I'm having some issues getting my Logtech USB headset to work when
used through a Dell Monitor USB Hub. The headset works fine when plugged
into the pc directly.

I think it might be related to Bug 0000061

Here are the errors from dmesg when trying to play through the device
using alsa:

usb 1-7.4: new full speed USB device using ehci_hcd and address 7
usb 1-7.4: configuration #1 chosen from 1 choice
input: Logitech Logitech USB Headset as /class/input/input3
input: USB HID v1.00 Device [Logitech Logitech USB Headset] on
usb-0000:00:1d.7-7.4
usbcore: registered new driver snd-usb-audio
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38

The errors will appear every time an application tries to open the sound
device.

This error is being generated from linux-2.6.16/sound/usb/usbaudio.c

Thanks for all of your help!

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-06 23:38 harking        New Issue                                    
05-31-06 23:38 harking        Distribution              => Gentoo          
05-31-06 23:38 harking        Kernel Version            => 2.6.16          
======================================================================
