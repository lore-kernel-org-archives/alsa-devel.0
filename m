From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000024]: suspend-resume cycle either hardlocks or locks soundcard (reboot necessary)
Date: Thu, 10 Mar 2005 15:20:31 +0100
Message-ID: <d71908993abd1cd8ce67da13254a7e9a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 486C0157
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:20:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24> 
======================================================================
Reported By:                runia
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   24
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-01-2004 13:10 CET
Last Modified:              03-10-2005 15:20 CET
======================================================================
Summary:                    suspend-resume cycle either hardlocks or locks
soundcard (reboot necessary)
Description: 
See summary.
======================================================================

----------------------------------------------------------------------
 runia - 02-02-04 19:22 
----------------------------------------------------------------------
ok, I'll try 1.0.2a asap.
Just for making sure, the problem existed in 1.0.1x also.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:20 
----------------------------------------------------------------------
Does version 1.0.8 of the intel8x0 driver still lock your soundcard or
your system after resume?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-04 13:10 runia          New Issue                                    
02-02-04 15:23 tiwai          Note Added: 0000107                          
02-02-04 18:55 runia          File Added: alsadebug.log.bz2                    
02-02-04 18:56 runia          Note Added: 0000116                          
02-02-04 18:56 runia          Note Edited: 0000116                         
02-02-04 19:08 tiwai          Note Added: 0000117                          
02-02-04 19:22 runia          Note Added: 0000118                          
03-10-05 15:20 jdthood        Note Added: 0003862                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
