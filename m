From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001354]: Mixer problem on Logitech Quickcam Zoom with Integrated mic
Date: Sun, 4 Sep 2005 09:29:55 +0200
Message-ID: <a7aa0a2a38430d801b792a4194fe5bb7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCAEF168
	for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2005 09:29:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1354> 
======================================================================
Reported By:                Bourrindebase
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1354
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrivalinux
Kernel Version:             2.6.12-10mdk
======================================================================
Date Submitted:             08-21-2005 18:17 CEST
Last Modified:              09-04-2005 09:29 CEST
======================================================================
Summary:                    Mixer problem on Logitech Quickcam Zoom with
Integrated mic
Description: 
When I plug the webcam I get an error on mixer settings. Then the mic
integrated on the webcam is not usable. There is no sound available from
the webcam. I get the same error with Cooker Mandrivalinux and 10.2 (2005
Limited Edition) Mandrivalinux. So mixer settings for the cam are note
available under alsamixer.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 08-22-05 13:11 
----------------------------------------------------------------------
What do you mean with "error on mixer settings"?

What are the contents of /proc/asound/cards?
What is the output of "amixer -c <cardnumber> contents"?

----------------------------------------------------------------------
 Bourrindebase - 09-04-05 09:29 
----------------------------------------------------------------------
Sorry for to answer lately, but I got some personnal problem.

cat /proc/asound/cards give me:
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC658 at 0xf2101000, irq 17
1 [U0x46d0x8b4    ]: USB-Audio - USB Device 0x46d:0x8b4
                     USB Device 0x46d:0x8b4 at usb-0000:00:1d.2-2, full
speed


and amixer on the usb webcam give me:
Simple mixer control 'Mic',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 3
  Mono: Capture 0 [0%] [off]

cat /proc/asound/card1/stream0
USB Device 0x46d:0x8b4 at usb-0000:00:1d.2-2, full speed : USB Audio

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 44100
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 22050
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 11025
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 1
    Endpoint: 4 IN (NONE)
    Rates: 8000

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 18:17 Bourrindebase  New Issue                                    
08-21-05 18:17 Bourrindebase  Distribution              => Mandrivalinux   
08-21-05 18:17 Bourrindebase  Kernel Version            => 2.6.12-10mdk    
08-22-05 13:11 Clemens LadischNote Added: 0005896                          
09-04-05 09:29 Bourrindebase  Note Added: 0006036                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
