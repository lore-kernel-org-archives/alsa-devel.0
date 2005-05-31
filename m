From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001012]: TI AC97 volume bit 5 sets bits 0-4
Date: Tue, 31 May 2005 17:56:52 +0200
Message-ID: <0aa359320e7e7e5f3c62e71d08c48d6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 20D1D1C6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:56:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1012> 
======================================================================
Reported By:                Daniel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1012
Category:                   OTHERS
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2005 19:15 CET
Last Modified:              05-31-2005 17:56 CEST
======================================================================
Summary:                    TI AC97 volume bit 5 sets bits 0-4
Description: 
Since ALSA driver 1.0.8 the width of the volume controls is probed to be 6
bits.
The Texas Instruments datasheet contains a footnote for the 5th and 13th
bit of register 2 and the 5th bif of register 6, 12 and 14 saying:
"Special function volume settings. If bit is set, then the 5 volume bits
implemented are set to all ones."
check_volume_resolution in ac97_codec.c should check if setting bit 5 (13)
results in bits 0-4 (8-12) set.
======================================================================

----------------------------------------------------------------------
 Daniel - 03-24-05 20:13 
----------------------------------------------------------------------
Yes, it does.

----------------------------------------------------------------------
 tiwai - 03-29-05 17:33 
----------------------------------------------------------------------
The patch was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 19:15 Daniel         New Issue                                    
03-24-05 19:44 tiwai          Note Added: 0004196                          
03-24-05 19:45 tiwai          File Added: ac97-res-check.diff                   

03-24-05 20:13 Daniel         Note Added: 0004199                          
03-29-05 17:33 tiwai          Status                   new => resolved     
03-29-05 17:33 tiwai          Resolution               open => fixed       
03-29-05 17:33 tiwai          Assigned To               => tiwai           
03-29-05 17:33 tiwai          Note Added: 0004251                          
05-31-05 17:56 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
