From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Thu, 3 Feb 2005 03:42:32 +0100
Message-ID: <409553c2651223f85e683afc676eeb1e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 82986217
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2005 03:42:32 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              02-03-2005 03:42 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 03:42 iive           New Issue                                    
02-03-05 03:42 iive           File Added: isa_opl3sa2.tgz                    
02-03-05 03:42 iive           Distribution              => Slackware 10    
02-03-05 03:42 iive           Kernel Version            => all 2.6.x kernel
version (current 2.6.10)
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
