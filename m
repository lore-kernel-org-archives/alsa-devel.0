From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001318]: Volume control per PCM
Date: Sat, 11 Feb 2006 14:30:27 +0100
Message-ID: <35bb254cab0eb8cb88039b23a7d4ac01@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0D3D1A8
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2006 14:30:27 +0100 (MET)
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
Last Modified:              02-11-2006 14:30 CET
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
 Raymond - 02-11-06 03:00 
----------------------------------------------------------------------
It seem that when you change "DAC Volume", cs46xx_dsp_set_dac_volume() will
set all scb to the same volume. This is the major problem which you have
to solve


	/* main output */
	scb = ins->master_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}

	/* rear output */
	scb = ins->rear_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}



----------------------------------------------------------------------
 darkbrain - 02-11-06 14:30 
----------------------------------------------------------------------
No it's not a problem. Infact  "DAC Volume" changes master_mix_scb and my
patch wants to modify pcm_reader_scb. I've tested it.
Btw stopping and restarting playback, the pcm volume goes right, so i
suspect that there is a way to set the initial volume and a different one
to change it, but i have no documentation.

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
02-09-06 08:11 Raymond        Note Edited: 0007970                         
02-09-06 10:37 Raymond        Note Deleted: 0007970                        
02-10-06 12:59 Raymond        Note Added: 0008002                          
02-10-06 15:29 darkbrain      Note Added: 0008005                          
02-11-06 02:38 Raymond        Note Added: 0008011                          
02-11-06 02:51 Raymond        Note Edited: 0007962                         
02-11-06 02:53 Raymond        Note Edited: 0008011                         
02-11-06 03:00 Raymond        Note Edited: 0008011                         
02-11-06 14:30 darkbrain      Note Added: 0008017                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
