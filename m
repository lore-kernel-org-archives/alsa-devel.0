From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000500]: CS4236+ soundcard not found or device busy
Date: Thu, 23 Sep 2004 19:19:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923171941.BA1824500E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3C105354
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 19:19:42 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000500
======================================================================
Reported By:                nlmarco
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     500
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.5-7.108
======================================================================
Date Submitted:             09-14-2004 02:18 CEST
Last Modified:              09-23-2004 19:19 CEST
======================================================================
Summary:                    CS4236+ soundcard not found or device busy
Description: 
After the ALSA version 1.0.3, which is distributed with SuSE 9.1, didn't
want to run at all and froze the system, I downloaded, compiled and
installed the version 1.0.6a. This doesn't freeze anymore, but doesn't
work either and produces strange log messages:

/var/log/messages:
---
Sep 14 02:06:14 sexbomb kernel: snd_page_alloc: unsupported module,
tainting kernel.
Sep 14 02:06:14 sexbomb kernel: snd: unsupported module, tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_timer: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_pcm: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_cs4231_lib: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_seq_device: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_rawmidi: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_mpu401_uart: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_cs4236_lib: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_hwdep: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_opl3_lib: unsupported module, tainting
kernel.
Sep 14 02:06:16 sexbomb kernel: snd_cs4236: unsupported module, tainting
kernel.
Sep 14 02:06:16 sexbomb kernel: CS4236+ soundcard not found or device
busy
---

Please HELP! I've already invested days into that and googling around, I
saw that others have similar problems to get ALSA running on IBM ThinkPad
600E.

======================================================================

----------------------------------------------------------------------
 nlmarco - 09-14-2004 22:28 CEST 
----------------------------------------------------------------------
I just tried it again with 1.0.7rc1, but the problem remains the same. BTW:
I tried legacy probe (all possible IRQ/DMA combinations for CS4236,
CS4232, CS4231) with alsaconf, but it didn't find anything.

----------------------------------------------------------------------
 tiwai - 09-21-2004 11:59 CEST 
----------------------------------------------------------------------
You can ignore "unsupported module..." messages.  They are harmless,
indicating
that the modules are not provided by SUSE.

If it's TP600E, it has to be a non-isapnp chip.
I guess the IRQ 9 conflicts with ACPI.  You can change it via setpnp
program
(you'll need to compile by yourself, SUSE doesn't ship this any more).

----------------------------------------------------------------------
 nlmarco - 09-23-2004 19:16 CEST 
----------------------------------------------------------------------
I just came back from Berlin (was fighting against software patents
<http://swpat.ffii.org>) and wanted to try it out. But unfortunately, I
was not able to find where to download setpnp (neither source nor binary).
Could you please provide a link?

----------------------------------------------------------------------
 tiwai - 09-23-2004 19:19 CEST 
----------------------------------------------------------------------
Some info about TP:
  http://tpctl.sourceforge.net/

IIRC, setpnp is included in pcmcia-cs package.
You can find it in pcmcia source rpm in SUSE distro.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-14-04 02:18 nlmarco        New Bug                                      
09-14-04 02:18 nlmarco        Kernel Version            => 2.6.5-7.108     
09-14-04 02:18 nlmarco        Bug Monitored: nlmarco                       
09-14-04 22:28 nlmarco        Bugnote Added: 0001759                       
09-21-04 11:59 tiwai          Bugnote Added: 0001798                       
09-23-04 19:16 nlmarco        Bugnote Added: 0001833                       
09-23-04 19:19 tiwai          Bugnote Added: 0001834                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
