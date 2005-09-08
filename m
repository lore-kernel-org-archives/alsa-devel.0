From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001403]: Ensoniq PCI Audio 3000/ak4531 - no sound
Date: Thu, 8 Sep 2005 10:08:41 +0200
Message-ID: <5b602d6b51af2358a83df283c676d156@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 94FA31AD
	for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2005 10:08:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1403> 
======================================================================
Reported By:                goldenfish
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1403
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Debian testing
Kernel Version:             2.6.13 vanilla
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-08-2005 01:14 CEST
Last Modified:              09-08-2005 10:08 CEST
======================================================================
Summary:                    Ensoniq PCI Audio 3000/ak4531 - no sound
Description: 
I have this card. Card has bad PCI identification. 

 Unknown device 0101:0400 
 Subsystem: Unknown device 4942:4c4c

If i loaded module, no structure about this card in /proc/asound.

I was solved this. I was created patch - in attachment.

Module loaded, structure in /proc/asound created. alsamixer working.

Basic problem:
I don't hear any sound from card. PCM or from Line-In or from Mic no
sound.

Next problem:
Module is not possible unload with command rmmod.

======================================================================

----------------------------------------------------------------------
 perex - 09-08-05 10:08 
----------------------------------------------------------------------
I think that it's not an issue for us. The PCI configuration space is
totaly broken (even the I/O region is not visible, thus the driver cannot
communicate with the card at all). I know that these first PCI cards have
trouble sometimes with the EEPROM / PCI accesses. It appears like a dead
hardware or you might try to move this card to an old machine with the
first PCI bus revision.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-05 01:14 goldenfish     New Issue                                    
09-08-05 01:14 goldenfish     File Added: ens1370_report.tar.bz2                
   
09-08-05 01:14 goldenfish     Distribution              => Debian testing  
09-08-05 01:14 goldenfish     Kernel Version            => 2.6.13 vanilla  
09-08-05 10:08 perex          Status                   new => resolved     
09-08-05 10:08 perex          Resolution               open => not an issue
09-08-05 10:08 perex          Assigned To               => perex           
09-08-05 10:08 perex          Note Added: 0006071                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
