From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000487]: Driver builds, but offers wrong mixer controls and no sound
Date: Tue, 14 Sep 2004 10:13:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040914081339.F08901D008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 52C62243
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2004 10:13:40 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 0B36223E7C
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2004 10:13:40 +0200 (MEST)
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
Last Modified:              09-14-2004 10:13 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 06:40 Quietti        New Bug                                      
09-08-04 06:40 Quietti        Distribution              => Debian          
09-08-04 06:40 Quietti        Kernel Version            => 2.6.8.1-pa7     
09-14-04 10:13 Quietti        Bugnote Added: 0001757                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
