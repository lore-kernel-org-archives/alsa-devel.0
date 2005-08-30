From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000162]: Alsa 1.0,4RC1: snd-usb-audio still interfers with pwc.o (Philips based webcams)
Date: Tue, 30 Aug 2005 12:12:48 +0200
Message-ID: <c74f1f969eda048a57501769b9f68079@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45FF41C7
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:12:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=162> 
======================================================================
Reported By:                Schugy
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   162
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               SuSE8.2
Kernel Version:             2.4.25
======================================================================
Date Submitted:             03-28-2004 17:20 CEST
Last Modified:              08-30-2005 12:12 CEST
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
 Schugy - 04-10-04 20:19 
----------------------------------------------------------------------
I've removed that four lines and now I've had an oops again. I'm a little
worried because it finally caused an error in the reiserfs-module. At
least it doesn't crash the pc immediately. My webcam just skipped a frame
when I loaded the snd-usb-audio but when I wanted to halt the system after
a few hours I've recognized that something is wrong.  I've had these two
oopses and 3 others in umount that weren't logged.

I don't know whether this is useful.

----------------------------------------------------------------------
 jdthood - 08-30-05 12:12 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
