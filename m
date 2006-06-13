From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001395]: USB sound device does not work
Date: Tue, 13 Jun 2006 13:22:27 +0200
Message-ID: <645f657b221f6985be605340e1085ac4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50AB4175
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 13:22:27 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Last Modified:              06-13-2006 13:22 CEST
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

----------------------------------------------------------------------
 csuwi1 - 06-13-06 13:22 
----------------------------------------------------------------------
I have a pair of these speakers with similar issues. I have tried to set up
rate conversion using asoundrc with no joy.

If it helps I can plug the speakers into a machine with internet access
and provide an account so you can experiment.

Alsa version: 1.0.10rc3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-03-05 19:12 draft          New Issue                                    
09-03-05 19:12 draft          Distribution              => Fedora Core 4   
09-03-05 19:12 draft          Kernel Version            => 2.6.12-1.1398_FC4
06-13-06 13:22 csuwi1         Note Added: 0010192                          
======================================================================
