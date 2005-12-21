From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000927]: Support for Creative SB Audigy 2 ZS Notebook
Date: Wed, 21 Dec 2005 18:12:05 +0100
Message-ID: <10e7929f454ad5c3d50da6f96465c217@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 61E5C1A7
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 18:12:05 +0100 (MET)
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
Last Modified:              12-21-2005 18:12 CET
======================================================================
Summary:                    Support for Creative SB Audigy 2 ZS Notebook
Description: 
Is this PCMCIA Souncard supported or will it be supported in the next time?
I haven't heard any positive reports yet...

Thank you!
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-21-05 16:32 
----------------------------------------------------------------------
audigy-notebook-speakers-enable.diff 
This patch adds support for surround7.1 output from the Audigy 2 ZS
notebook card.

TODO:
Sound capture (analog and digital)
Digital output (untested, might already work).

----------------------------------------------------------------------
 bubbleguuum - 12-21-05 18:12 
----------------------------------------------------------------------
Many thanks for this !

I just tested and I have sound. However:

- At low volume the sound is badly distorded with some noise. I suppose it
might be the case at higher volume too. There's also this constant volume
white noise at all volume level : listen to some quiet music at high
volume to hear it. Test done using xmms + alsa out plug in
Just for reference using windows you can put the card to 0db in the
creative mixer (ie all the way to the max) and the sound is crystal
clear)

- Output is very loud, a lot louder at the same settings that the internal
intel hda card (which I always found a bit low)

- If you go too high with the Master or PCM slider clicks appears

- front, rear and center outputs give no sound but I suppose this is
expected

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
12-21-05 16:31 jcdutton       File Added: audigy-notebook-speakers-enable.diff  
                 
12-21-05 16:32 jcdutton       Note Added: 0007110                          
12-21-05 18:12 bubbleguuum    Note Added: 0007111                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
