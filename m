From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000823]: Shutdown messages
Date: Thu, 17 Feb 2005 18:33:52 +0100
Message-ID: <3bf756fccd92030584a2b95de09b2063@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE97523D
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 18:33:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=823> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   823
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               FC2/PlanetCCRMA - up to date but not running newest
kernel due to other Alsa problems
Kernel Version:             2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-16-2005 21:45 CET
Last Modified:              02-17-2005 18:33 CET
======================================================================
Summary:                    Shutdown messages
Description: 
When shutting my system down I consistently get the following message:

Shutting down sound driver rme_hammerfall dsp 0:00:0f 
device was removed without properly calling pci_disable_device()
This may need fixing
======================================================================

----------------------------------------------------------------------
 tiwai - 01-17-05 15:04 
----------------------------------------------------------------------
Already fixed in 1.0.8.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-05 21:45 Mark Knecht    New Issue                                    
01-16-05 21:45 Mark Knecht    Distribution              => FC2/PlanetCCRMA - up
to date but not running newest kernel due to other Alsa problems
01-16-05 21:45 Mark Knecht    Kernel Version            =>
2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
01-17-05 15:04 tiwai          Status                   assigned => resolved
01-17-05 15:04 tiwai          Resolution               open => fixed       
01-17-05 15:04 tiwai          Note Added: 0003234                          
02-17-05 18:33 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
