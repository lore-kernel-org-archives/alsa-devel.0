From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000927]: Support for Creative SB Audigy 2 ZS Notebook
Date: Wed, 21 Dec 2005 16:09:01 +0100
Message-ID: <690658600cdd7e198db496eabfc69b40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE7E21B4
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 16:09:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=927> 
======================================================================
Reported By:                gflash
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   927
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-20-2005 08:53 CET
Last Modified:              12-21-2005 16:09 CET
======================================================================
Summary:                    Support for Creative SB Audigy 2 ZS Notebook
Description: 
Is this PCMCIA Souncard supported or will it be supported in the next time?
I haven't heard any positive reports yet...

Thank you!
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-13-05 12:15 
----------------------------------------------------------------------
This card is still not working in Linux.
The current status is that the card is now recognised, but the sound
output is badly distorted. Until that is fixed, the card is still unusable
in Linux.
The distortion is like it doing massive gain (+12 dB) and then clipping
the result, so pretty nasty. So, still work-in-progress

----------------------------------------------------------------------
 jcdutton - 12-21-05 16:09 
----------------------------------------------------------------------
audigy2-notebook-sound-fix.diff fixes the distortion problem with output.
Only headphone output tested.
Other speakers and sound capture not tested.

This fix has been put in alsa CVS.

So, we are getting there.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-20-05 08:53 gflash         New Issue                                    
02-20-05 12:32 jcdutton       Note Added: 0003673                          
02-20-05 14:06 gflash         Note Added: 0003674                          
02-20-05 14:39 jcdutton       Note Added: 0003675                          
02-20-05 14:47 jcdutton       Note Edited: 0003675                         
07-25-05 17:43 dale           Note Added: 0005564                          
07-31-05 03:52 buckvitulli    Issue Monitored: buckvitulli                    
08-01-05 01:03 jpeak          Issue Monitored: jpeak                       
10-30-05 21:08 jcdutton       Note Added: 0006577                          
10-31-05 00:55 buckvitulli    Note Added: 0006578                          
10-31-05 12:43 jcdutton       Status                   new => assigned     
10-31-05 12:43 jcdutton       Assigned To               => jcdutton        
11-30-05 15:57 bubbleguuum    Note Added: 0006876                          
11-30-05 15:58 bubbleguuum    Issue Monitored: bubbleguuum                    
12-06-05 02:55 hades          Issue Monitored: hades                       
12-06-05 02:56 hades          Note Added: 0006918                          
12-06-05 13:26 jpeak          Issue End Monitor: jpeak                     
12-13-05 12:15 jcdutton       Note Added: 0006990                          
12-21-05 16:07 jcdutton       File Added: audigy2-notebook-sound-fix.diff       
            
12-21-05 16:09 jcdutton       Note Added: 0007109                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
