From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000980]: nforce4/alc850 line-in -> spdif out - solution ???
Date: Fri, 11 Mar 2005 16:44:41 +0100
Message-ID: <5d569f5d3041e1668f3b57fd2c31158f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8FE091CA
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2005 16:44:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=980> 
======================================================================
Reported By:                dobromir
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   980
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-11-2005 01:17 CET
Last Modified:              03-11-2005 16:44 CET
======================================================================
Summary:                    nforce4/alc850 line-in -> spdif out - solution ???
Description: 
I found in the alc850 spec that setting 12th bit in register 0x6a routes to
spdif all data from ADC. I write small program that sets this register,
and this works for me, but I use only 2 speakers configuration.
Unfortunately I don't have enough 
knowledge of alsa architecture to write a proper patch.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-11-05 16:15 
----------------------------------------------------------------------
You hit a bug hidden in this control :)
Try the attached patch.

----------------------------------------------------------------------
 dobromir - 03-11-05 16:44 
----------------------------------------------------------------------
Yes, it works. Thank You for your help.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-05 01:17 dobromir       New Issue                                    
03-11-05 08:27 dobromir       Note Added: 0003880                          
03-11-05 10:19 dobromir       File Added: alc_850_mixer.patch                   

03-11-05 10:24 dobromir       Note Added: 0003883                          
03-11-05 12:11 tiwai          Note Added: 0003884                          
03-11-05 16:08 dobromir       Note Added: 0003889                          
03-11-05 16:15 tiwai          Note Added: 0003890                          
03-11-05 16:16 tiwai          File Added: alc655-spdif-route-fix.diff           
        
03-11-05 16:44 dobromir       Note Added: 0003892                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
