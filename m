From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000559]: 64 Bit Drivers for Analog Devices SoundMax
Date: Fri, 22 Oct 2004 16:55:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a202cd67e173a4efb7b546edf65e28b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2761D29D
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 16:55:46 +0200 (MEST)
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
Status:                     resolved
Distribution:               Suse
Kernel Version:             2.6.5-7.108
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-02-2004 13:46 CEST
Last Modified:              10-22-2004 16:55 CEST
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
