From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001012]: TI AC97 volume bit 5 sets bits 0-4
Date: Thu, 24 Mar 2005 19:44:41 +0100
Message-ID: <72ba456eb5ca8c7295b0c57aa4a7f7bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E51A7264
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 19:44:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1012> 
======================================================================
Reported By:                Daniel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1012
Category:                   OTHERS
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-24-2005 19:15 CET
Last Modified:              03-24-2005 19:44 CET
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
 tiwai - 03-24-05 19:44 
----------------------------------------------------------------------
Does the attached patch work?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 19:15 Daniel         New Issue                                    
03-24-05 19:44 tiwai          Note Added: 0004196                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
