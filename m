From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000925]: no sound with CMI9761A
Date: Tue, 22 Feb 2005 14:34:01 +0100
Message-ID: <8d06019e07fdc5e1906db8002441bfdc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4AA4217A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 14:34:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=925> 
======================================================================
Reported By:                Cus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   925
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.11-rc3
======================================================================
Date Submitted:             02-19-2005 18:55 CET
Last Modified:              02-22-2005 14:34 CET
======================================================================
Summary:                    no sound with CMI9761A
Description: 
I have no sound with my Chaintech VNF-250 motherboard. It has
an integrated CMI9761A chip, the alsa driver detects it as CMI9761,
everything seems to be ok, but i hear nothing.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-22-05 14:34 
----------------------------------------------------------------------
Maybe better to use 0x0001 instead?  I guess 0x0008 controls the "IEC958
Capture Monitor", and got some reports that this disturbs the output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-05 18:55 Cus            New Issue                                    
02-19-05 18:55 Cus            File Added: lspci                            
02-19-05 18:55 Cus            Distribution              => SuSE Linux 9.2  
02-19-05 18:55 Cus            Kernel Version            => 2.6.11-rc3      
02-22-05 14:34 tiwai          Note Added: 0003700                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
