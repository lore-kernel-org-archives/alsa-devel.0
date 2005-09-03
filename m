From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001395]: USB sound device does not work
Date: Sat, 3 Sep 2005 19:12:53 +0200
Message-ID: <c17144c9620eef498d6327a88f94e4d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D22F1121
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 19:12:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1395> 
======================================================================
Reported By:                draft
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1395
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398_FC4
======================================================================
Date Submitted:             09-03-2005 19:12 CEST
Last Modified:              09-03-2005 19:12 CEST
======================================================================
Summary:                    USB sound device does not work
Description: 
The device is a (lsusb): Bus 001 Device 003: ID 0e6a:0310 Megawin
Technology Co., Ltd. According to the manual, it is fully compliant with
USB audio device class spec v 1.0, fully compliant with USB DCD for HID
spec v. 1.11 and supports more than 44.1Khz sample frequency. However,
this device does not work with snd_usb_audio. Xmms gives an immediate
Feedback, that the device is not configured properly. Aplay does not
output any message, but there is no sound. The fancy fedora sound card
detection setup does not work either.

dmesg:

ALSA /usr/src/alsa-driver-1.0.10rc1/usb/usbaudio.c:1212: current rate
33024 is different from the runtime rate 46875
usbcore: registered new driver snd-usb-audio

Tested alsa driver versions: 1.0.10rc1, 1.09b
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-03-05 19:12 draft          New Issue                                    
09-03-05 19:12 draft          Distribution              => Fedora Core 4   
09-03-05 19:12 draft          Kernel Version            => 2.6.12-1.1398_FC4
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
