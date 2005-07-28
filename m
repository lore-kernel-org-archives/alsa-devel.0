From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Thu, 28 Jul 2005 05:17:34 +0200
Message-ID: <d6a82f4fb95bba26714e4474a23c791c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11D3A1C7
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 05:17:34 +0200 (MEST)
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
Last Modified:              07-28-2005 05:17 CEST
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
 jdthood - 07-09-05 11:14 
----------------------------------------------------------------------
See also: https://bugzilla.ubuntu.com/show_bug.cgi?id=5456

----------------------------------------------------------------------
 ahaning - 07-28-05 05:17 
----------------------------------------------------------------------
Is there any news on this? I see on LKML that there is a move to remove
"obsolete" OSS drivers from the kernel. This could be fairly disasterous
for people who don't know how to configure their OPL3SA2 card in 2.6
kernels with the ALSA driver, since alsaconf will not detect those cards
correctly on 2.6 kernels.

I was told to file a bug report, which I may do eventually, but I figured
maybe it would be best to keep everything in one place. And since I'd
already posted what I know in this bug, I didn't think it would be worth
writing up another bug report.

Anyway, just wanting to see what may have been done to get OPL3SA2 cards
detected and working well on 2.6 kernels. Thanks.

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
07-09-05 06:26 ahaning        Note Added: 0005438                          
07-09-05 06:38 ahaning        Note Edited: 0005438                         
07-09-05 11:13 jdthood        Note Added: 0005439                          
07-09-05 11:14 jdthood        Note Added: 0005440                          
07-28-05 05:17 ahaning        Note Added: 0005577                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
