From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001874]: USB sound device appears to be loading properly, but all applications report the device is busy
Date: Mon, 22 May 2006 05:04:54 +0200
Message-ID: <87c6982b5ca36fcae27ecf7fb5604632@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2683F230
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 05:04:55 +0200 (MEST)
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
Last Modified:              05-22-2006 05:04 CEST
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
 oggb4mp3 - 03-07-06 17:09 
----------------------------------------------------------------------
Now that this device is running, is there any other information that I can
provide from /proc/asound that might be helpful in debugging this?

----------------------------------------------------------------------
 oggb4mp3 - 05-22-06 05:04 
----------------------------------------------------------------------
On a whim, I tried kernel 2.6.16.16 and the driver was working again.  Then
I tried it with the ck patchset and it didn't work.  Is it possible that
the problem lies elsewhere, like in the usb system?  I don't see a lot of
changes to usbaudio 2.6.15 to 2.6.16.16, so perhaps something in the usb
system was changed that fixed it in the stock kernel, and then a change in
the ck patchset broke it again.

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
03-02-06 14:37 oggb4mp3       Note Added: 0008305                          
03-02-06 14:38 oggb4mp3       File Added: fix_burr_brown.patch                  
 
03-02-06 17:18 oggb4mp3       Note Edited: 0008305                         
03-07-06 17:09 oggb4mp3       Note Added: 0008369                          
05-22-06 05:04 oggb4mp3       Note Added: 0009905                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
