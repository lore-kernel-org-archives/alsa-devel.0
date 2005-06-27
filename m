From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001192]: Microphone doesn't work in record and/or Skype
Date: Mon, 27 Jun 2005 15:57:07 +0200
Message-ID: <15de212ecec289ffc0f784e01fa60b97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 683321DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 15:57:07 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000183.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1192> 
======================================================================
Reported By:                iljaguaro
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1192
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Testing "Etch"
Kernel Version:             kernel-image-2.6.11-1-k7
======================================================================
Date Submitted:             06-15-2005 11:38 CEST
Last Modified:              06-26-2005 23:21 CEST
======================================================================
Summary:                    Microphone doesn't work in record and/or Skype
Description: 
The microphone input doesnt work well, the volume are too low and the noisy
is to high, when you record it.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000183 Mic boost boosts mic playback and not r...
======================================================================

----------------------------------------------------------------------
 iljaguaro - 06-24-05 08:11 
----------------------------------------------------------------------
same problem with ALSA 1.0.9b

----------------------------------------------------------------------
 tiwai - 06-24-05 15:00 
----------------------------------------------------------------------
Try the attached patch and turn on "Mic Boost" in alsamixer capture view. 
Note that there are two "Mic Boost" switches in playback and capture after
the patch.

----------------------------------------------------------------------
 iljaguaro - 06-26-05 11:46 
----------------------------------------------------------------------
Sorry, where put the patch? In alsa source & recompile it?

----------------------------------------------------------------------
 sst4 - 06-26-05 23:21 
----------------------------------------------------------------------
Look above, against  "Attached Files":  cmipci-mic-boost2.diff,
its URL is:

https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=744&type=bug
.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 11:38 iljaguaro      New Issue                                    
06-15-05 11:38 iljaguaro      Distribution              => Debian Testing "Etch"
06-15-05 11:38 iljaguaro      Kernel Version            =>
kernel-image-2.6.11-1-k7
06-24-05 08:11 iljaguaro      Note Added: 0005203                          
06-24-05 15:00 tiwai          Note Added: 0005224                          
06-24-05 15:01 tiwai          File Added: cmipci-mic-boost2.diff                
   
06-26-05 11:46 iljaguaro      Note Added: 0005262                          
06-26-05 23:21 sst4           Note Added: 0005269                          
06-27-05 15:57 tiwai          Relationship added       related to 0000183  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
