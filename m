From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000061]: Creative Audigy 2 NX (USB) not working
Date: Thu, 15 Sep 2005 15:05:16 +0200
Message-ID: <5395b4354a68ece487c99f74fc77a482@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E557DC8
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:05:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=61> 
======================================================================
Reported By:                Davin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   61
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-14-2004 19:02 CET
Last Modified:              09-15-2005 15:05 CEST
======================================================================
Summary:                    Creative Audigy 2 NX (USB) not working
Description: 
While I've found a single success report of someone getting this device to
work (http://www.qbik.ch/usb/devices/showdev.php?id=2375), the details as
to how he did it are sparse and I've recieved no e-mail reply. There are a
handful of reports of this device not working, and it is not listed in
alsa-project.org's list of known sound cards. (as such, whether or not it
is or is not supported lacks mention)

As far as I can tell, it does not work. The device will show up in
alsamixer if one uses the snd-usb-audio. The first 'speaker 2' channel is
muted by default, which APPEARS to be the 'front' speaker jack. Unmuting
this channel makes the mute light on the device turn off.

Attempts to use this device with userland devices will fail, returning the
program-specific "can't initialize audio" error. By increasing verbosity
further, I found the exact error being returned by alsalib:

"SNDRV_PCM_IOCTL_HW_PARAMS failed"

On further investigation, messages are also appearing in the kernel
message log, coinciding with these errors:

Feb 14 06:57:13 napalm 2:1:3 : invalid synch pipe
Feb 14 06:57:13 napalm 2:1:1 : invalid synch pipe 

2:1:X bears little relevance I'm guessing, since I assume those to be the
USB subdevice IDs.

In short, I suspect this device does not work with the usb-audio driver as
it currently stands.
======================================================================

----------------------------------------------------------------------
 sw25481 - 01-19-05 00:56 
----------------------------------------------------------------------
Micmac

Thanks to the help of you and others on this thread I have my Audigy NX
working with 2 channels.  I used Windows to upgrade the firmware and used
the .asoundrc file posted here.

You say you managed test 48k audio from a DVD.  Was this just an audio
track or have you or anybody managed to get the NX working with mplayer,
xine or simmilar?  I get nothing with gentoo-2.6.10-r4 and alsa 1.0.8_rc1

----------------------------------------------------------------------
 jdthood - 09-15-05 15:05 
----------------------------------------------------------------------
Davin wrote:
> I'll post a followup once I've got the new install up and running.

What's the status of the problem now?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-14-04 19:02 Davin          New Issue                                    
02-14-04 19:26 Davin          Note Added: 0000240                          
02-14-04 19:27 Davin          Issue Monitored: Davin                       
02-15-04 01:37 Davin          Note Added: 0000241                          
02-20-04 18:37 Clemens LadischNote Added: 0000276                          
02-22-04 00:41 Davin          Note Added: 0000288                          
02-24-04 08:43 Clemens LadischNote Added: 0000300                          
02-25-04 02:39 Davin          Note Added: 0000308                          
02-25-04 10:09 Clemens LadischNote Added: 0000311                          
02-25-04 10:12 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-26-04 04:08 Davin          Note Added: 0000331                          
02-26-04 16:23 Clemens LadischNote Added: 0000354                          
02-26-04 23:54 Davin          Note Added: 0000377                          
03-01-04 18:43 Clemens LadischNote Added: 0000412                          
03-01-04 19:51 Davin          Note Added: 0000421                          
03-01-04 19:53 Davin          Note Added: 0000422                          
03-01-04 20:02 Davin          Note Added: 0000423                          
03-01-04 20:27 Davin          Note Added: 0000425                          
03-02-04 17:01 Clemens LadischNote Added: 0000442                          
03-03-04 05:01 Davin          Note Added: 0000449                          
03-03-04 05:08 Davin          Note Added: 0000450                          
03-03-04 05:12 Davin          Note Added: 0000451                          
03-04-04 14:31 Clemens LadischNote Added: 0000478                          
03-04-04 15:17 Davin          Note Added: 0000480                          
03-04-04 15:39 Davin          Note Added: 0000481                          
03-04-04 16:31 Davin          Note Added: 0000483                          
03-04-04 18:30 Davin          Note Added: 0000486                          
03-05-04 01:13 Davin          Note Added: 0000494                          
03-05-04 06:52 Davin          Note Added: 0000496                          
03-05-04 13:42 Clemens LadischNote Added: 0000503                          
03-08-04 10:57 Clemens LadischFile Added: highspeed.patch                    
03-16-04 21:39 nilsr          Note Added: 0000631                          
03-17-04 20:43 nilsr          Issue Monitored: nilsr                       
03-18-04 09:00 Clemens LadischNote Added: 0000637                          
03-18-04 09:01 Clemens LadischFile Deleted: highspeed.patch                    
03-18-04 09:04 Clemens LadischFile Added: highspeed.patch                    
03-18-04 09:09 Clemens LadischNote Added: 0000638                          
03-18-04 21:29 nilsr          Note Added: 0000643                          
03-29-04 00:56 Davin          Note Added: 0000715                          
04-23-04 21:45 Davin          Note Added: 0000918                          
06-27-04 17:02 micmac         File Added: .asoundrc                        
06-27-04 17:16 micmac         Note Added: 0001339                          
06-27-04 19:31 micmac         Note Added: 0001340                          
01-19-05 00:56 sw25481        Note Added: 0003262                          
09-15-05 15:05 jdthood        Note Added: 0006198                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
