From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Thu, 14 Apr 2005 00:02:45 +0200
Message-ID: <505b4565797d5374e8afce8186a16539@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1490C189
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2005 00:02:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=879> 
======================================================================
Reported By:                iive
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   879
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             all 2.6.x kernel version (current 2.6.10)
======================================================================
Date Submitted:             02-03-2005 03:42 CET
Last Modified:              04-14-2005 00:02 CEST
======================================================================
Summary:                    (snd_)opl3sa2 (isa) doesn't work (fails on playback)
on 2.6.x kernels
Description: 
It doesn't work on all 2.6.x kernel I have tried (current 2.6.10)
alsaconf doesn't detect the card as PnP, and fails to find it with
bruteforce.

When module is loaded by hand it shows no error, but on `aplay samle.wav`
I got
"ALSA /work/install/alsa-driver-1.0.5a/alsa-kernel/core/pcm_lib.c:2172:
playback
write error (DMA or IRQ trouble?"

on boot with 2.4.x kernel, everything magically works (alsaconf, aplay
etc..)

the bug is reported 4 months ago on
http://bugzilla.kernel.org/show_bug.cgi?id=3117
that's why some versions are old (but I had tried alsa-1.0.8 before
reposting this bug here)

======================================================================

----------------------------------------------------------------------
 jdthood - 04-13-05 21:59 
----------------------------------------------------------------------
Submitter: Is there any way you can do more research into the problem?

----------------------------------------------------------------------
 iive - 04-14-05 00:02 
----------------------------------------------------------------------
Tell me what to do and I'll do it.
btw have you took a look of the attached file?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 03:42 iive           New Issue                                    
02-03-05 03:42 iive           File Added: isa_opl3sa2.tgz                    
02-03-05 03:42 iive           Distribution              => Slackware 10    
02-03-05 03:42 iive           Kernel Version            => all 2.6.x kernel
version (current 2.6.10)
04-13-05 21:59 jdthood        Note Added: 0004478                          
04-14-05 00:02 iive           Note Added: 0004485                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
