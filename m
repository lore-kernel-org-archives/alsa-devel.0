From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000227]: Audigy 2 ZS ACPI suspend (S3) problem
Date: Sun, 3 Apr 2005 19:58:55 +0200
Message-ID: <13037ff39764b948fafadf2944b8a2a5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 634181EC
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 19:58:55 +0200 (MEST)
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


The following issue has been CONFIRMED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=227> 
======================================================================
Reported By:                kanthak
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   227
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               debian/sarge
Kernel Version:             2.6.4
======================================================================
Date Submitted:             04-20-2004 23:46 CEST
Last Modified:              04-03-2005 19:58 CEST
======================================================================
Summary:                    Audigy 2 ZS ACPI suspend (S3) problem
Description: 
I want an Audigy 2 ZS to work together with kernel 2.6.x
ACPI suspend (s3). On resume it says that AC'97 does not
respond:

...
PCI: Enabling device 0000:02:02.0 (0000 -> 0001)
PCI: Setting latency timer of device 0000:02:02.0 to 64
ALSA sound/pci/ac97/ac97_codec.c:1749: AC'97 0 does not respond - RESET
ALSA sound/pci/ac97/ac97_codec.c:1757: AC'97 0 access is not valid
[0xffffffff], removing mixer.
EMU10K1_Audigy: probe of 0000:02:02.0 failed with error -5

Everything else in the system works together perfectly
with ACPI S3. Mainboard is a gigabyte 6IEML. Send mail
to stylon@gmx.de for more details.

======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-04 17:35 
----------------------------------------------------------------------
there is no suspend/resume routines implemented in emu10k1 driver yet.

----------------------------------------------------------------------
 jdthood - 04-03-05 19:58 
----------------------------------------------------------------------
I still don't see any suspend/resume routines in the emu10k1 driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-04 23:46 kanthak        New Issue                                    
04-20-04 23:46 kanthak        Distribution              => debian/sarge    
04-20-04 23:46 kanthak        Kernel Version            => 2.6.4           
04-23-04 17:35 tiwai          Note Added: 0000909                          
04-03-05 19:58 jdthood        Note Added: 0004314                          
04-03-05 19:58 jdthood        Status                   new => confirmed    
04-03-05 19:58 jdthood        Description Updated                          
04-03-05 19:58 jdthood        Additional Information Updated                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
