From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000371]: dmix does not work with snd-cs46xx driver
Date: Thu, 10 Mar 2005 15:03:47 +0100
Message-ID: <89dfd6a35ad1fd0049c01e62b5e958a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F6041C5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:03:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=371> 
======================================================================
Reported By:                fmoraes
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   371
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             07-09-2004 15:59 CEST
Last Modified:              03-10-2005 15:03 CET
======================================================================
Summary:                    dmix does not work with snd-cs46xx driver
Description: 
When trying to use dmix with the snd-cs46xx driver, no output is produced.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-09-05 18:37 
----------------------------------------------------------------------
Does it happen with the latest version, too?

----------------------------------------------------------------------
 jdthood - 03-10-05 15:03 
----------------------------------------------------------------------
Does it help if you add:

    bindings {
        0 0
        1 1
    }

to the definition of the dmix device?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-04 15:59 fmoraes        New Issue                                    
07-09-04 15:59 fmoraes        Kernel Version            => 2.6.6-1.435.2.3 
07-15-04 14:10 perex          Status                   new => assigned     
07-15-04 14:10 perex          Assigned To               => perex           
03-09-05 03:09 fmoraes        Note Added: 0003823                          
03-09-05 18:37 tiwai          Note Added: 0003830                          
03-10-05 15:03 jdthood        Note Added: 0003857                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
