From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001874]: USB sound device appears to be loading properly, but all applications report the device is busy
Date: Thu, 2 Mar 2006 04:34:02 +0100
Message-ID: <7572573a73dadb1f0155b88871e2ecb9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A8FF1CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 04:34:02 +0100 (MET)
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
Last Modified:              03-02-2006 04:34 CET
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
 oggb4mp3 - 03-01-06 03:42 
----------------------------------------------------------------------
Okay, I am still trying to narrow this down, and I have patched the plain
2.6.15 kernel with the uevent patch and the
alsa-usbaudio-2.6.15-revert-001.patch from this bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585.  Kernel
boots, usb device works.  So for sure, something in the usb-audio device
rewrite for 2.6.15 broke support for this device.  Whatever was reverted
as part of the fix for bug 1585 did not fix support for this device.

I am not a coder, but I really want to fix this bug, so what else can I do
to help?



----------------------------------------------------------------------
 oggb4mp3 - 03-02-06 04:34 
----------------------------------------------------------------------
Continuing to investigate so I can narrow it down for you, as I can imagine
you are quite busy, I find that the same patch that broke playback for the
other usb devices as reported in bug 1585 also broke playback for my
device.  

I determined this by taking my now working 2.6.15 kernel, and applied only
the commit entitled "start submitting URBs in the prepared state".  This
broke playback.  The fix applied in 2.6.15.2 did not fix it for this
device.  So I hope this is helpful and it can be fixed soon.

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
02-27-06 18:18 oggb4mp3       Note Added: 0008226                          
02-27-06 18:22 Clemens LadischNote Added: 0008227                          
02-27-06 22:33 oggb4mp3       Note Added: 0008232                          
03-01-06 03:40 oggb4mp3       Note Added: 0008263                          
03-01-06 03:42 oggb4mp3       Note Edited: 0008263                         
03-02-06 04:34 oggb4mp3       Note Added: 0008292                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
