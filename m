From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001192]: Microphone doesn't work in record and/or Skype
Date: Sat, 16 Jul 2005 19:58:58 +0200
Message-ID: <e49ac6eea005d2a69b67ade29649459e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B5971198
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 19:58:58 +0200 (MEST)
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
Last Modified:              07-16-2005 19:58 CEST
======================================================================
Summary:                    Microphone doesn't work in record and/or Skype
Description: 
The microphone input doesnt work well, the volume are too low and the noisy
is to high, when you record it.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000183 Mic boost boosts mic playback and not r...
related to          0000653 poor microphone recording quality on pc...
======================================================================

----------------------------------------------------------------------
 sst4 - 06-26-05 23:21 
----------------------------------------------------------------------
Look above, against  "Attached Files":  cmipci-mic-boost2.diff,
its URL is:

https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=744&type=bug
.

----------------------------------------------------------------------
 mlehto - 07-16-05 19:58 
----------------------------------------------------------------------
I have tried the cmipci-mic-boost2.diff patch and it seems to work.
Before mic was really silent but after using the patch and enabling
new settings in alsa mixer, mic is working ok. 

I'm using CMI8738-MC6 intergrated in motherboard.

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
06-27-05 15:58 tiwai          Relationship added       related to 0000653  
07-16-05 19:58 mlehto         Note Added: 0005501                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
