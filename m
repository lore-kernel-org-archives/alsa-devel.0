From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001253]: My kernel doesn't find my sound cards anymore !!!
Date: Mon, 24 Oct 2005 21:20:34 +0200
Message-ID: <40a28f7e451bf19ea2efa8cf33b046d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31E3E196
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2005 21:20:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1253> 
======================================================================
Reported By:                fabien
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1253
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-12-2005 14:04 CEST
Last Modified:              10-24-2005 21:20 CEST
======================================================================
Summary:                    My kernel doesn't find my sound cards anymore !!!
Description: 
My kernel stop working with my soundcards !!!
It use to work in 2.6.8 (not in 2.6.10, 2.6.11 & 2.6.12)


My sound cards :
- ENS1370
- SIS 7012

Motherboard :
- K7S5A

Linux Box :
- Debian on x86 AMD
======================================================================

----------------------------------------------------------------------
 fabien - 10-24-05 21:20 
----------------------------------------------------------------------
Style the same problem in 2.6.13.4 :


$ dmesg
usbaudio: device 2 audiocontrol interface 1 has 1 input and 0 output
AudioStreaming interfaces
usbaudio: device 2 interface 2 altsetting 0 FORMAT_TYPE descriptor not
found
usbaudio: valid input sample rate 8000
usbaudio: valid input sample rate 48000
usbaudio: valid input sample rate 44100
usbaudio: valid input sample rate 32000
usbaudio: valid input sample rate 22050
usbaudio: valid input sample rate 16000
usbaudio: valid input sample rate 10257
usbaudio: device 2 interface 2 altsetting 1: format 0x00000010 sratelo
8000 sratehi 48000 attributes 0x01
usbaudio: registered dsp 14,3
usbaudio: constructing mixer for Terminal 3 type 0x0101
usbaudio: warning: found 1 of 0 logical channels.
usbaudio: assuming the channel found is the master channel (got a Philips
camera?). Should be fine.
usbaudio: registered mixer 14,0
usb_audio_parsecontrol: usb_audio_state at dfc588e0
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
12:20:13 2005 UTC).
unable to register OSS PCM device 0:0
unable to register OSS mixer device 0:0
codec read timeout (final) at 0xd414, reg = 0x7c [0xf00000]
codec read timeout (final) at 0xd414, reg = 0x7e [0xf00000]
codec read timeout (final) at 0xd414, reg = 0x0 [0x800000]
codec read timeout (final) at 0xd414, reg = 0x7c [0xf00000]
codec read timeout (final) at 0xd414, reg = 0x7e [0xf00000]
codec read timeout (final) at 0xd414, reg = 0x7c [0xf00000]
codec read timeout (final) at 0xd414, reg = 0x7e [0xf00000]
ENS1371: probe of 0000:00:0b.0 failed with error -5
intel8x0_measure_ac97_clock: measured 50676 usecs
intel8x0: clocking to 48000
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: Dummy 1
  #1: MPU-401 UART at 0x300, irq 10
  #2: SiS SI7012 with ALC100,100P at 0xdc00, irq 11


$ lspci

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
0000:00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97]
(rev 08)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-05 14:04 fabien         New Issue                                    
07-12-05 14:04 fabien         Distribution              => Debian Sarge    
07-12-05 14:04 fabien         Kernel Version            => 2.6.12          
10-24-05 21:20 fabien         Note Added: 0006523                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
