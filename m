From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000487]: Driver builds, but offers wrong mixer controls and no sound
Date: Tue, 21 Sep 2004 12:53:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921105342.96CB932005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ED52A303
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 12:53:42 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000487
======================================================================
Reported By:                Quietti
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     487
Category:                   PARISC - harmony
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1-pa7
======================================================================
Date Submitted:             09-08-2004 06:40 CEST
Last Modified:              09-21-2004 12:53 CEST
======================================================================
Summary:                    Driver builds, but offers wrong mixer controls and no sound
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
 Quietti - 09-14-2004 10:13 CEST 
----------------------------------------------------------------------
I would like to point out that this bug is still unresolved in
2.6.8.1-pa11.

----------------------------------------------------------------------
 tiwai - 09-21-2004 12:42 CEST 
----------------------------------------------------------------------
No developer is working on this driver because of lack of hardware.
Any patches appreciated, of course :)

----------------------------------------------------------------------
 Quietti - 09-21-2004 12:53 CEST 
----------------------------------------------------------------------
Actually, someone from the Debian hppa port is working on this. 

As such, there have been recent changes done to the Harmony ALSA driver on
the parisc-linux CVS. It might be a good idea to contact them and ask for
the patches to be merged back or, better yet, to have them join the ALSA
core team and commit directly to ALSA upstream. 

http://www.parisc-linux.org/

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 06:40 Quietti        New Bug                                      
09-08-04 06:40 Quietti        Distribution              => Debian          
09-08-04 06:40 Quietti        Kernel Version            => 2.6.8.1-pa7     
09-14-04 10:13 Quietti        Bugnote Added: 0001757                       
09-21-04 12:42 tiwai          Bugnote Added: 0001801                       
09-21-04 12:53 Quietti        Bugnote Added: 0001802                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
