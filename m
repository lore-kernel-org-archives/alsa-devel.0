From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000901]: The onboard audigyls chip on msi k8 diamond motherboard not recognized. Path supplied.
Date: Sun, 13 Feb 2005 01:27:14 +0100
Message-ID: <c3305eaca2fc9f0b7dfe89a52c73a811@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 21D2E202
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2005 01:27:14 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=901> 
======================================================================
Reported By:                kiksen
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   901
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2005 23:49 CET
Last Modified:              02-13-2005 01:27 CET
======================================================================
Summary:                    The onboard audigyls chip on msi k8 diamond
motherboard not recognized. Path supplied.
Description: 
We'll. The driver fails to load (and dmesg comlaints about a missing AC97)

Have made a path.
======================================================================

----------------------------------------------------------------------
 sHINOBI - 02-13-05 01:21 
----------------------------------------------------------------------
*nods*, seems to be better:

0 [CA0106         ]: CA0106 - CA0106
                     Live! by MSI [SB0438] at 0xde00 irq 233

----------------------------------------------------------------------
 jcdutton - 02-13-05 01:27 
----------------------------------------------------------------------
Thank you. A modified patch will be added to alsa cvs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-05 23:49 kiksen         New Issue                                    
02-11-05 23:49 kiksen         File Added: msi_audigyls_patch.patch              
     
02-11-05 23:49 kiksen         Distribution              => Gentoo          
02-11-05 23:49 kiksen         Kernel Version            => 2.6.10          
02-12-05 00:56 jcdutton       Note Added: 0003569                          
02-12-05 14:36 kiksen         Note Added: 0003571                          
02-12-05 22:43 sHINOBI        Issue Monitored: sHINOBI                     
02-12-05 22:47 sHINOBI        Note Added: 0003572                          
02-13-05 00:18 jcdutton       Note Added: 0003574                          
02-13-05 00:54 sHINOBI        Note Added: 0003575                          
02-13-05 01:08 jcdutton       Note Added: 0003576                          
02-13-05 01:21 sHINOBI        Note Added: 0003577                          
02-13-05 01:27 jcdutton       Status                   assigned => resolved
02-13-05 01:27 jcdutton       Resolution               open => fixed       
02-13-05 01:27 jcdutton       Note Added: 0003578                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
