From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001840]: vortex: IRQ fifo error - au8830
Date: Wed, 15 Feb 2006 09:47:01 +0100
Message-ID: <486fe2a3f7164288ae5359e40d441917@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 910A61B6
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 09:47:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1840> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1840
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2006 09:29 CET
Last Modified:              02-15-2006 09:47 CET
======================================================================
Summary:                    vortex: IRQ fifo error - au8830
Description: 
The message "vortex: IRQ fifo error" was logged in system log after au88x0
migrated from alsa-driver to alsa-kernel on au8830.

Does au8810 and au8820 has this error ?


======================================================================

----------------------------------------------------------------------
 Raymond - 02-15-06 07:38 
----------------------------------------------------------------------
Using au88x0_surround40.patch
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726 which fix the swap
of front/rear
channels problem by using vortex_adbdma_stopfifo(chip, dma) instead of
vortex_adbdma_pausefifo(chip, dma) for case SNDRV_PCM_TRIGGER_STOP.

It seem that the fifo error do not occur in system log when 

aplay -D hw:0,0 first.wav 
aplay -D hw:0,0 second.wav 
aplay -D hw:0,0 third.wav 

but the fifo error occur whenever 

aplay -D hw:0,0 *.wav 

for each .wav played by aplay.

----------------------------------------------------------------------
 Raymond - 02-15-06 09:47 
----------------------------------------------------------------------
To be more accurate, fifo error does not occur when playing mono .wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 09:29 Raymond        New Issue                                    
02-11-06 10:24 mjander        Note Added: 0008012                          
02-11-06 10:25 mjander        Status                   assigned => closed  
02-11-06 10:25 mjander        Note Added: 0008013                          
02-15-06 07:38 Raymond        Status                   closed => feedback  
02-15-06 07:38 Raymond        Resolution               open => reopened    
02-15-06 07:38 Raymond        Note Added: 0008077                          
02-15-06 09:47 Raymond        Note Added: 0008078                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
