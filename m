From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000500]: CS4236+ soundcard not found or device busy
Date: Tue, 14 Sep 2004 02:18:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040914001828.9248513001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F15FF22A
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2004 02:18:28 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id A703F23C44
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2004 02:18:28 +0200 (MEST)
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


The following bug has been SUBMITTED.
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
Last Modified:              09-14-2004 02:18 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-14-04 02:18 nlmarco        New Bug                                      
09-14-04 02:18 nlmarco        Kernel Version            => 2.6.5-7.108     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
