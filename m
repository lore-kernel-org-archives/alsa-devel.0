From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000376]: inserting maestro3 hangs system
Date: Fri, 15 Apr 2005 19:37:27 +0200
Message-ID: <bd2137cf9fe81f83d87c060bf45dba3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1983A21D
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 19:37:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=376> 
======================================================================
Reported By:                tmarble
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   376
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Debian unstable
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-11-2004 18:30 CEST
Last Modified:              04-15-2005 19:37 CEST
======================================================================
Summary:                    inserting maestro3 hangs system
Description: 
modprobe snd-maestro3 consistently hangs the system.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 21:02 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

----------------------------------------------------------------------
 tmarble - 04-15-05 14:21 
----------------------------------------------------------------------
I am now using 2.6.9 (still debian unstable) on this hardware
and sound is working fine.

I do not have the time to investigate if this problem has
been resolved in the 2.4 series kernels.

Please go ahead and close this bug.

Thank you!

--Tom

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-04 18:30 tmarble        New Issue                                    
07-11-04 18:30 tmarble        Distribution              => Debian unstable 
07-11-04 18:30 tmarble        Kernel Version            => 2.4.26          
07-13-04 07:37 tmarble        File Added: 2.4.26-tm2.config.txt                 
  
07-13-04 07:38 tmarble        File Added: System.map-2.4.26-tm2.txt             
      
07-13-04 07:38 tmarble        File Added: alsa-1.0.conf                    
07-13-04 07:39 tmarble        File Added: depmod.txt                       
07-13-04 07:40 tmarble        File Added: depends.txt                      
07-13-04 07:41 tmarble        File Added: 20040712233907.modules.txt            
       
07-13-04 07:41 tmarble        File Added: 20040712233907.ksyms.txt              
     
07-13-04 07:43 tmarble        Note Added: 0001412                          
07-15-04 11:25 tiwai          Note Added: 0001428                          
07-15-04 19:40 tmarble        Note Added: 0001437                          
04-07-05 21:02 jdthood        Note Added: 0004368                          
04-15-05 14:21 tmarble        Note Added: 0004500                          
04-15-05 19:37 jdthood        Status                   assigned => resolved
04-15-05 19:37 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
