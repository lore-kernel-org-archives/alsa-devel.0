From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001318]: Volume control per PCM
Date: Thu, 9 Feb 2006 08:06:57 +0100
Message-ID: <8f59e8db1f8d52c549d44b64015406d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFB281AB
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2006 08:06:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1318> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1318
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-07-2005 14:45 CEST
Last Modified:              02-09-2006 08:06 CET
======================================================================
Summary:                    Volume control per PCM
Description: 
Hi, i'm trying to implement a volume control per PCM streams, i've attached
a function that does the job. Unfortunally when it change the volume it
also change the equalizer cutting off low frequencyes. I think 
there is a problem with the second poke, infact withot that poke, the
volume works correctly for left case. Any suggestion? Any documentation?
Thanks,
   Dino

======================================================================

----------------------------------------------------------------------
 darkbrain - 02-08-06 10:41 
----------------------------------------------------------------------
It's not that the point. This patch want to use a mixer slider to change
the volume for the first only subdevice, it's only a test. The volume
changes but incorrectlly, i've got an hardware problem, without
documentation of the chip i can't fix it, and without any help we'll never
have this feature. 
But is there any mantainer? It was past 7 months and no one drop me a line
of documentation, hardware registry or similar, is this driver dead?

----------------------------------------------------------------------
 Raymond - 02-09-06 08:06 
----------------------------------------------------------------------
Your patch does not include snd_cs46xx_vol_info.

It seem to me that the value in the range of the snd_kcontrol_t does not
support negative number by the alsa-lib.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-07-05 14:45 darkbrain      New Issue                                    
08-07-05 14:45 darkbrain      File Added: volume.c                         
08-13-05 10:43 darkbrain      Note Added: 0005802                          
01-10-06 12:55 darkbrain      Note Added: 0007548                          
02-05-06 04:55 Raymond        Note Added: 0007929                          
02-05-06 05:33 Raymond        Note Edited: 0007929                         
02-05-06 13:19 darkbrain      Note Added: 0007932                          
02-05-06 14:42 Raymond        Note Added: 0007934                          
02-06-06 03:43 Raymond        Note Edited: 0007934                         
02-07-06 21:04 darkbrain      File Added: pcm1.patch                       
02-07-06 21:05 darkbrain      Note Added: 0007960                          
02-08-06 02:39 Raymond        Note Edited: 0007934                         
02-08-06 03:24 Raymond        Note Added: 0007962                          
02-08-06 03:31 Raymond        Note Edited: 0007962                         
02-08-06 09:54 Raymond        Note Edited: 0007934                         
02-08-06 10:41 darkbrain      Note Added: 0007964                          
02-09-06 08:06 Raymond        Note Added: 0007970                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
