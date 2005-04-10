From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000487]: Driver builds, but offers wrong mixer controls and no sound
Date: Sun, 10 Apr 2005 12:21:48 +0200
Message-ID: <318037913771b4e6b83da4ecccd784eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4547322C
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 12:21:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=487> 
======================================================================
Reported By:                Quietti
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   487
Category:                   PARISC - harmony
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     acknowledged
Distribution:               Debian
Kernel Version:             2.6.8.1-pa7
======================================================================
Date Submitted:             09-08-2004 06:40 CEST
Last Modified:              04-10-2005 12:21 CEST
======================================================================
Summary:                    Driver builds, but offers wrong mixer controls and
no sound
Description: 
The driver builds with the correct options, the module can be loaded, but
the mixer control it offers do not correspond to my model 712 (Gecko)
hardware. 

Additionally, trying to send sound to the module produces horrible
chainsaw noise in the speakers. Esound also informs me that the hardware
does not support any suitable sample rate. Something is evidently broken.

I am quite positive that the corresponding Harmony OSS driver in kernel
2.4 works well with this workstation, so this is definitely not a hardware
problem (the same module in kernel 2.6 has been broken from day 1).
======================================================================

----------------------------------------------------------------------
 Quietti - 04-10-05 12:15 
----------------------------------------------------------------------
FYI the current PA-RISC Linux ALSA tree is at:

http://cvs.parisc-linux.org/linux-2.6/sound/parisc/

----------------------------------------------------------------------
 Quietti - 04-10-05 12:21 
----------------------------------------------------------------------
Still unresolved as of kernel 2.6.11-pa1 from the PA-RISC Linux tree.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 06:40 Quietti        New Issue                                    
09-08-04 06:40 Quietti        Distribution              => Debian          
09-08-04 06:40 Quietti        Kernel Version            => 2.6.8.1-pa7     
09-14-04 10:13 Quietti        Note Added: 0001757                          
09-21-04 12:42 tiwai          Note Added: 0001801                          
09-21-04 12:53 Quietti        Note Added: 0001802                          
04-09-05 16:07 jdthood        Note Added: 0004405                          
04-10-05 10:51 Quietti        Note Added: 0004435                          
04-10-05 12:07 jdthood        Status                   new => acknowledged 
04-10-05 12:15 Quietti        Note Added: 0004436                          
04-10-05 12:21 Quietti        Note Added: 0004437                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
