From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000784]: CMI 9739A PCM does not allow volume control only on/off (when on starts with full volume)
Date: Wed, 9 Feb 2005 18:02:09 +0100
Message-ID: <a05c74a066a061c293a641f7356e297e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3086265
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 18:02:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=784> 
======================================================================
Reported By:                ajir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   784
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-04-2005 20:34 CET
Last Modified:              02-09-2005 18:02 CET
======================================================================
Summary:                    CMI 9739A PCM does not allow volume control only
on/off (when on starts with full volume)
Description: 
This issue was studied before but without any effect. Some says that this
codec has different hadrware and it can not be controled.BUT WINDOWS
DRIVER CAN CONTROL damn VOLUME. Please can it be fixed?
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 17:54 
----------------------------------------------------------------------
ALSA 1.0.8rc2 includes the softvol feature.

When you access to the PCM "default", softvol is automatically enabled.

----------------------------------------------------------------------
 tiwai - 01-07-05 17:55 
----------------------------------------------------------------------
I move this issue to FIXED.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-05 20:34 ajir           New Issue                                    
01-04-05 20:34 ajir           Kernel Version            => 2.6.8.1         
01-04-05 20:57 rlrevell       Note Added: 0003080                          
01-04-05 22:42 rlrevell       Note Added: 0003087                          
01-06-05 12:03 ajir           Note Added: 0003091                          
01-07-05 17:54 tiwai          Note Added: 0003104                          
01-07-05 17:55 tiwai          Status                   new => resolved     
01-07-05 17:55 tiwai          Resolution               open => fixed       
01-07-05 17:55 tiwai          Assigned To               => tiwai           
01-07-05 17:55 tiwai          Note Added: 0003105                          
01-07-05 17:55 tiwai          Assigned To              tiwai =>            
02-09-05 18:02 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
