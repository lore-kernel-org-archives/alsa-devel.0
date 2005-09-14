From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000763]: I can't make the emulation of /dev/dsp work;  the driver "executes" but reports errors;  there is no sound output.
Date: Wed, 14 Sep 2005 16:22:54 +0200
Message-ID: <f3aaba11915e087b3bcfa411e7cd1d7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFB181A6
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:22:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=763> 
======================================================================
Reported By:                lovett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   763
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-30-2004 22:48 CET
Last Modified:              09-14-2005 16:22 CEST
======================================================================
Summary:                    I can't make the emulation of /dev/dsp work;  the
driver "executes" but reports errors;  there is no sound output.
Description: 
I have a "Sound Blaster" card.  /proc/asound/cards says:
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.8, serial:0x80641102) at
0x8c00, irq 23
======================================================================

----------------------------------------------------------------------
 lovett - 01-14-05 17:25 
----------------------------------------------------------------------
The ALSA installation consisted of going through the ./configure | make | 
make install sequence with the follow packages: alsa-driver-1.0.8rc1
alsa-lib-1.0.8rc1 alsa-utils-1.0.8rc1 alsa-oss-1.0.8rc1
All compiled and installed without complaint.
Booting produced this error message:
  kernel: Error seeking in /dev/kmem  Symbol #snd-page-alloc, value
002c4000 
  kernel: Error adding kernel module table entry.
Loading all the ALSA modules ==> this error message (repeated twice):
 modprobe: modprobe: Can't locate module snd-seq-client-62

----------------------------------------------------------------------
 jdthood - 09-14-05 16:22 
----------------------------------------------------------------------
Submitter: Did you ever manage to solve this problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 22:48 lovett         New Issue                                    
01-03-05 12:05 tiwai          Note Added: 0003052                          
01-03-05 18:12 lovett         File Added: dspFailure                       
01-03-05 23:35 lovett         Note Added: 0003076                          
01-14-05 17:25 lovett         Note Added: 0003208                          
09-14-05 16:22 jdthood        Note Added: 0006183                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
