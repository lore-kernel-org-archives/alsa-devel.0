From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000500]: CS4236+ soundcard not found or device busy
Date: Tue, 9 Nov 2004 16:43:41 +0100
Message-ID: <94e5ebb1507961ce43e0baad10f4fa24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A20BA1EF
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:43:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=500> 
======================================================================
Reported By:                nlmarco
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   500
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.5-7.108
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-14-2004 02:18 CEST
Last Modified:              11-09-2004 16:43 CET
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
 tiwai - 10-04-04 18:56 
----------------------------------------------------------------------
Ok, close this bug now.

----------------------------------------------------------------------
 runderwo - 10-06-04 23:50 
----------------------------------------------------------------------
Reminder sent to nlmarco, tiwai

Someone should add this to the Wiki since it is an obscure issue.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-04 02:18 nlmarco        New Issue                                    
09-14-04 02:18 nlmarco        Kernel Version            => 2.6.5-7.108     
09-14-04 02:18 nlmarco        Issue Monitored: nlmarco                     
09-14-04 22:28 nlmarco        Note Added: 0001759                          
09-21-04 11:59 tiwai          Note Added: 0001798                          
09-23-04 19:16 nlmarco        Note Added: 0001833                          
09-23-04 19:19 tiwai          Note Added: 0001834                          
09-23-04 22:03 nlmarco        Note Added: 0001850                          
09-24-04 12:24 tiwai          Note Added: 0001875                          
10-02-04 18:39 nlmarco        Note Added: 0002007                          
10-04-04 18:56 tiwai          Status                   new => resolved     
10-04-04 18:56 tiwai          Resolution               open => fixed       
10-04-04 18:56 tiwai          Assigned To               => tiwai           
10-04-04 18:56 tiwai          Note Added: 0002013                          
10-06-04 23:50 runderwo       Note Added: 0002027                          
11-09-04 16:43 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
