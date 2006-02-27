From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001874]: USB sound device appears to be loading properly, but all applications report the device is busy
Date: Mon, 27 Feb 2006 16:48:37 +0100
Message-ID: <87e07e1872849280417ae84fb39a71c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A73D2190
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 16:48:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1874> 
======================================================================
Reported By:                oggb4mp3
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1874
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Arch Linux
Kernel Version:             2.6.15-archck4
======================================================================
Date Submitted:             02-24-2006 07:27 CET
Last Modified:              02-27-2006 16:48 CET
======================================================================
Summary:                    USB sound device appears to be loading properly, but
all applications report the device is busy
Description: 
I own a USB audio Device with a TI burr-brown DAC and with my recent
upgrade to 2.6.15-ck4, all apps report that the device is busy.  I found
this bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585 that
I thought might be the culprit, but when I tried to apply the patch, I
found that it was already applied.  I tried to reverse it, thinking that I
might have had one of the devices that worked without it and this patch
actually broke it, but no joy.

The device appears to be present as alsa device hw:1,0, the same as it
always was, and I can select it, but all apps report that it is busy or
blocked.  This all worked properly with a 2.6.14-ck kernel.
======================================================================

----------------------------------------------------------------------
 oggb4mp3 - 02-27-06 02:54 
----------------------------------------------------------------------
Continuing to try and debug, I updated my driver module to the one in
1.0.11rc3 and get the same result.  I also tried to take a diff from my
current kernel source tree against the last known working tree, 2.6.14.4
and apply it to the 2.6.15.4 tree I am currently working with.  The module
compiled fine, but when trying to insert it, I got some unknown symbol
errors in the log

snd_usb_audio: Unknown symbol vfree_nocheck
snd_usb_audio: Unknown symbol vmalloc_nocheck

a quick grep of the 2.4.14.4 source tree turned up include/sound/core.h as
missing a define in the 2.6.15.4 tree, but there are many changes to this
file and I am quickly getting beyond my ability to muck around in the
kernel sources.

Anyway, I hope this is helpful, since I see lot's of changes to usb-audio
2.6.14 => 2.6.15.  It looks like the entire driver was pretty much
rewritten.

----------------------------------------------------------------------
 oggb4mp3 - 02-27-06 16:48 
----------------------------------------------------------------------
Some more info from /proc/asound

$ cat /proc/asound/cards
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xea122000/0xea000000, irq 10
1 [default        ]: USB-Audio - USB Audio CODEC
                     Burr-Brown from TI               USB Audio CODEC  at
usb-0000:00:10.2-2, full s

$ cat /proc/asound/pcm
00-00: CS46xx : CS46xx : playback 31 : capture 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31
01-00: USB Audio : USB Audio : playback 1 : capture 1

$ cat /proc/asound/modules
0 snd_cs46xx
1 snd_usb_audio

$ cat /proc/asound/default/pcm0p/sub0/info
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

$ cat /proc/asound/default/pcm0p/sub0/hw_params
closed

$ cat /proc/asound/default/pcm0p/sub0/sw_params
closed

$ cat /proc/asound/default/pcm0p/sub0/status
closed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-06 07:27 oggb4mp3       New Issue                                    
02-24-06 07:27 oggb4mp3       Distribution              => Arch Linux      
02-24-06 07:27 oggb4mp3       Kernel Version            => 2.6.15-archck4  
02-24-06 07:32 oggb4mp3       Note Added: 0008171                          
02-24-06 14:16 Clemens LadischNote Added: 0008175                          
02-24-06 15:00 oggb4mp3       Note Added: 0008177                          
02-24-06 15:32 Clemens LadischNote Added: 0008178                          
02-25-06 00:49 oggb4mp3       Note Added: 0008183                          
02-27-06 00:37 oggb4mp3       Note Added: 0008210                          
02-27-06 02:54 oggb4mp3       Note Added: 0008211                          
02-27-06 16:48 oggb4mp3       Note Added: 0008224                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
