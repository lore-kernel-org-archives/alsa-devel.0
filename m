From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000865]: On this machine, sound only works if the modem driver is not loaded
Date: Sun, 3 Apr 2005 02:03:06 +0200
Message-ID: <90d32f3486beb71bc8a5c01332efc336@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5392D1DA
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 02:03:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=865> 
======================================================================
Reported By:                hpa
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   865
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.741_FC3
======================================================================
Date Submitted:             01-31-2005 02:46 CET
Last Modified:              04-03-2005 02:03 CEST
======================================================================
Summary:                    On this machine, sound only works if the modem
driver is not loaded
Description: 
On this machine, if the intel8x0 driver is loaded alone, all is well; if
the intel8x0m driver gets loaded, any attempt to use the sound card
results in no output, and messages such as:

codec_write 0: semaphore is not ready for register 0x2
codec_write 0: semaphore is not ready for register 0x4
codec_write 0: semaphore is not ready for register 0x26
codec_write 0: semaphore is not ready for register 0x26

Furthermore 
======================================================================

----------------------------------------------------------------------
 sashak - 04-03-05 02:03 
----------------------------------------------------------------------
Try with attached patches.
Sasha.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 02:46 hpa            New Issue                                    
01-31-05 02:46 hpa            Distribution              => Fedora Core 3   
01-31-05 02:46 hpa            Kernel Version            => 2.6.10-1.741_FC3
04-03-05 02:00 sashak         File Added: mc97-reset.patch                    
04-03-05 02:01 sashak         File Added: mc97_not_ready-fix.patch              
     
04-03-05 02:02 sashak         File Added: intel8x0m-busy_sem.patch              
     
04-03-05 02:03 sashak         Note Added: 0004302                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
