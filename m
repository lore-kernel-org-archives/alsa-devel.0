From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000946]: Early playback DMA IRQ with CMI8738MC6 ==> extra noise
Date: Sun, 27 Feb 2005 14:20:39 +0100
Message-ID: <e23a81471cfbfdd8b1cc83b9a099e595@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5A246259
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2005 14:20:39 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=946> 
======================================================================
Reported By:                charles_levert
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   946
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-27-2005 14:20 CET
Last Modified:              02-27-2005 14:20 CET
======================================================================
Summary:                    Early playback DMA IRQ with CMI8738MC6 ==> extra
noise
Description: 
This problem combines both a feature of the CMI8738MC6
hardware (alsa-kernel/pci/cmipci.c driver) and of the core
pcm kernel code (in alsa-kernel/core/pcm_lib.c).

It appears that the device produces an IRQ a little before
the end of its programmed period.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 14:20 charles_levert New Issue                                    
02-27-05 14:20 charles_levert File Added: pcm_lib.c.diff                    
02-27-05 14:20 charles_levert Kernel Version            => 2.4.22          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
