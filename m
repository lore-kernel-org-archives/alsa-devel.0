From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000162]: Alsa 1.0,4RC1: snd-usb-audio still interfers with pwc.o (Philips based webcams)
Date: Thu, 16 Mar 2006 19:53:49 +0100
Message-ID: <e0c034ebc0fb4a58eed33eeddda69fea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 002281A9
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 19:53:49 +0100 (MET)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=162> 
======================================================================
Reported By:                Schugy
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   162
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
Distribution:               SuSE8.2
Kernel Version:             2.4.25
======================================================================
Date Submitted:             03-28-2004 17:20 CEST
Last Modified:              03-16-2006 19:53 CET
======================================================================
Summary:                    Alsa 1.0,4RC1: snd-usb-audio still interfers with
pwc.o (Philips based webcams)
Description: 
Like other people using Mandrake's Cooker (google), I have crashes when
loading snd-usb-audio.o after pwc.o.

I boot my system, hotplug recognizes my webcam and my usb-Headset. pwc.o
is loaded but not snd-usb-audio.o, because hotplug wants to load audio.o
(OSS).

Now I can either modprobe snd-usb-audio or I can e.g. start TeamSpeak on
/dev/dsp1 and my kernel registers snd-usb-audio automagically for
sound-slot-1. After that I have weird colorful lines on my screen. Apache
and sshd still work but it hangs during the reboot script.

Sometimes my PC doesn't crash immediately but I've had some kernel oops.
At first some libraries in the memory become corrupted and e.g. all
QT-Apps crash.

I can use my webcam for 10h without its mic or I can use my USB-Headset
but I can't use pwc.o and snd-usb-audio.o simultaniously. In a testcase
I've used my webcam with the mic as my only usb hardware.
 My 3 Gamepads, the cyberjack pinpad (usb-serial) and my USB-Mouse can be
connected too, they have no bad influence.

My hardware is error free, RAM @ standard speed.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:37 
----------------------------------------------------------------------
No response

----------------------------------------------------------------------
 Schugy - 03-16-06 19:53 
----------------------------------------------------------------------
These crashes were gone with kernel 2.6.X (think it was 2.6.7) on SuSE 8.2.
Updating is quite difficult (udev, modutils). Maybe there were some
changes in the usbcore. I'm no developer. I don't know. I'm using Ubuntu
Warty now with kernel 2.6.13 and pwc-driver from http://www.saillard.org.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-04 17:20 Schugy         New Issue                                    
03-28-04 17:20 Schugy         Distribution              => SuSE8.2         
03-28-04 17:20 Schugy         Kernel Version            => 2.4.25          
04-02-04 17:47 paperclip      Note Added: 0000733                          
04-03-04 15:16 Schugy         Note Added: 0000736                          
04-05-04 16:33 Clemens LadischNote Added: 0000753                          
04-09-04 14:13 Schugy         Note Added: 0000775                          
04-10-04 20:10 Schugy         File Added: oops.zip                         
04-10-04 20:19 Schugy         Note Added: 0000778                          
08-30-05 12:12 jdthood        Note Added: 0005965                          
03-16-06 08:37 rlrevell       Status                   assigned => closed  
03-16-06 08:37 rlrevell       Note Added: 0008595                          
03-16-06 19:44 Schugy         Issue Monitored: Schugy                      
03-16-06 19:53 Schugy         Assigned To              Clemens Ladisch =>
rlrevell
03-16-06 19:53 Schugy         Status                   closed => feedback  
03-16-06 19:53 Schugy         Resolution               open => reopened    
03-16-06 19:53 Schugy         Note Added: 0008620                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
