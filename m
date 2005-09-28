From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001447]: SPDIF IN>OUT Loop missing
Date: Wed, 28 Sep 2005 09:20:44 +0200
Message-ID: <6d05d88a71b7276a7850d6cc7cdc0997@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 678D416E
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 09:20:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1447> 
======================================================================
Reported By:                Mimosius
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1447
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-23-2005 20:47 CEST
Last Modified:              09-28-2005 09:20 CEST
======================================================================
Summary:                    SPDIF IN>OUT Loop missing
Description: 
Hi,

I'm using a Hoontech Digital-XG and I was missing the capability to loop
the digital signal from SPDIF-in to SPDIF- out, so I modified the
ymfpci_main.c, adding an extra mixer switch (patch against latest CVS
version included). Would anyone of the developers verify this patch and
add this feature to the ymfpci module?

Regards,
Glen Masgai
======================================================================

----------------------------------------------------------------------
 Mimosius - 09-26-05 19:36 
----------------------------------------------------------------------
Hi Clemens,

I think some things are clarified now. :)
I uploaded the new patch and I hope, there are no stupid mistakes
anymore.

Regards
Glen Masgai

----------------------------------------------------------------------
 Clemens Ladisch - 09-28-05 09:20 
----------------------------------------------------------------------
Thanks, applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 Mimosius       New Issue                                    
09-23-05 20:47 Mimosius       File Added: ymfpci_spdifloop.diff                 
  
09-23-05 20:47 Mimosius       Issue Monitored: Mimosius                    
09-26-05 11:10 Clemens LadischNote Added: 0006392                          
09-26-05 15:38 Mimosius       Note Added: 0006393                          
09-26-05 15:48 Clemens LadischNote Added: 0006394                          
09-26-05 15:48 Clemens LadischAssigned To               => Clemens Ladisch 
09-26-05 15:48 Clemens LadischStatus                   new => assigned     
09-26-05 19:35 Mimosius       File Added: ymfpci_spdif_inoutloop.diff           
        
09-26-05 19:36 Mimosius       Note Added: 0006396                          
09-28-05 09:20 Clemens LadischStatus                   assigned => resolved
09-28-05 09:20 Clemens LadischResolution               open => fixed       
09-28-05 09:20 Clemens LadischNote Added: 0006406                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
