From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000559]: 64 Bit Drivers for Analog Devices SoundMax
Date: Mon, 22 Nov 2004 14:48:38 +0100
Message-ID: <6315abdf3ea0d3e7c6462ce768460b9f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 84A6D2B4
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 14:48:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=559> 
======================================================================
Reported By:                sandy bodell
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   559
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Suse
Kernel Version:             2.6.5-7.108
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-02-2004 13:46 CEST
Last Modified:              11-22-2004 14:48 CET
======================================================================
Summary:                    64 Bit Drivers for Analog Devices SoundMax
Description: 
Are there any 64 bit drivers available anywhere for this chipset?

Thanks
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-02-04 15:08 
----------------------------------------------------------------------
When compiled with a 64 bit kernel, the drivers are 64 bit, too.

The driver for your device is snd-intel8x0 or snd-via82xx or snd-atiixp,
depending on your chipset.

----------------------------------------------------------------------
 perex - 10-22-04 16:55 
----------------------------------------------------------------------
Yes, there is no difference between source code for 32-bit and 64-bit
drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-02-04 13:46 sandy bodell   New Issue                                    
10-02-04 13:46 sandy bodell   Distribution              => Suse            
10-02-04 13:46 sandy bodell   Kernel Version            => 2.6.5-7.108     
10-02-04 15:08 Clemens LadischNote Added: 0002006                          
10-22-04 16:55 perex          Status                   new => resolved     
10-22-04 16:55 perex          Resolution               open => fixed       
10-22-04 16:55 perex          Assigned To               => perex           
10-22-04 16:55 perex          Note Added: 0002250                          
11-22-04 14:48 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
