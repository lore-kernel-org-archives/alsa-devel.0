From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000996]: Noise when enabling dmix
Date: Wed, 16 Mar 2005 12:52:55 +0100
Message-ID: <ebad8ed8a98e1bcd27ac47f5921b374c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 379621F6
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 12:52:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=996> 
======================================================================
Reported By:                daspooky
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   996
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-15-2005 16:25 CET
Last Modified:              03-16-2005 12:52 CET
======================================================================
Summary:                    Noise when enabling dmix
Description: 
I get noise/static when i use the dmix plugin. When i use alsa without an
.asoundrc file there is no problem. I noticed this since i upgraded alsa
from 1.0.5 to 1.0.8. Version 1.0.5 didn't have this problem. I didn't try
versions between 1.0.5 and 1.0.8. The oise dissapears when i lower the
samplerate in asoundrc to 22000 KHz. Higher than that i get noise. 
======================================================================

----------------------------------------------------------------------
 tiwai - 03-16-05 12:52 
----------------------------------------------------------------------
Does the noise occur constantly or occasionally?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-05 16:25 daspooky       New Issue                                    
03-15-05 16:27 daspooky       Issue Monitored: daspooky                    
03-15-05 16:28 daspooky       Issue End Monitor: daspooky                    
03-16-05 12:52 tiwai          Note Added: 0003948                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
