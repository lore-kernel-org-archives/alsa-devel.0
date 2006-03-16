From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000344]: usx2y driver causes kernel oops
Date: Thu, 16 Mar 2006 08:36:11 +0100
Message-ID: <f98443320f40fda01c79f7626aa76480@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76C7216D
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:36:11 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=344> 
======================================================================
Reported By:                maggoi
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   344
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.6
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-24-2004 18:06 CEST
Last Modified:              03-16-2006 08:36 CET
======================================================================
Summary:                    usx2y driver causes kernel oops
Description: 
While playing a soundfile using my Tascam us-122 (Alsa Module snd-usx2y)
after a few seconds the sound stutters and i get an Kernel oops. 
This is not happening if I use Jack.
I'm using the latest alsa drivers 1.0.5. With kernel 2.6.6. 

dmesg:
Debug: sleeping function called from invalid context at mm/slab.c:1996
in_atomic():1, irqs_disabled():1
 [<c01152f7>] __might_sleep+0xb7/0xe0
 [<c013be33>] __kmalloc+0xa3/0xb0
 [<c026dad1>] usb_alloc_urb+0x21/0x60
 [<f89b3775>] snd_usX2Y_substream_prepare+0xd5/0x1c0 [snd_usb_usx2y]
 [<f89b3397>] snd_usX2Y_urb_play_start+0xa7/0x170 [snd_usb_usx2y]
 [<f89b35bf>] snd_usX2Y_pcm_play_trigger+0x3f/0x50 [snd_usb_usx2y]
 [<f89490e8>] snd_pcm_do_start+0x28/0x30 [snd_pcm]
 [<f8948dc9>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<f8948f12>] snd_pcm_action_lock_irq+0x92/0x1e0 [snd_pcm]
 [<c0112a8c>] do_page_fault+0x34c/0x54e
 [<f894c4d7>] snd_pcm_common_ioctl1+0x167/0x2f0 [snd_pcm]
 [<f894c6c0>] snd_pcm_playback_ioctl1+0x60/0x3b0 [snd_pcm]
 [<c0150a32>] vfs_write+0xd2/0x130
 [<c0162f20>] sys_ioctl+0x100/0x270
 [<c010413b>] syscall_call+0x7/0xb



======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 12:27 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:36 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-24-04 18:06 maggoi         New Issue                                    
06-24-04 18:06 maggoi         Distribution              => Gentoo          
06-24-04 18:06 maggoi         Kernel Version            => 2.6.6           
06-24-04 22:17 karsten        Note Added: 0001337                          
06-28-04 09:51 maggoi         Note Added: 0001343                          
06-28-04 10:34 maggoi         Note Added: 0001344                          
06-28-04 21:04 karsten        Note Added: 0001346                          
06-29-04 10:45 maggoi         Note Added: 0001347                          
06-30-04 15:44 tiwai          Note Added: 0001351                          
07-01-04 00:43 karsten        Note Added: 0001367                          
07-15-04 11:48 karsten        Note Added: 0001431                          
08-25-04 10:02 maggoi         Note Added: 0001619                          
10-01-04 01:27 karsten        Note Added: 0001990                          
08-30-05 12:27 jdthood        Note Added: 0005977                          
03-16-06 08:36 rlrevell       Status                   assigned => closed  
03-16-06 08:36 rlrevell       Note Added: 0008594                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
