From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000545]: midi note off ignored?! (i'm not sure that this is driver problem - correct me if wrong)
Date: Sun, 26 Sep 2004 17:34:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040926153444.F092B12009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 42082210
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2004 17:34:45 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000545
======================================================================
Reported By:                vlajsa
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     545
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-26-2004 17:34 CEST
Last Modified:              09-26-2004 17:34 CEST
======================================================================
Summary:                    midi note off ignored?! (i'm not sure that this is driver problem - correct me if wrong)
Description: 
Using sequencer application (tested with rosegarden) and vkeybd produce
some strange sustain-like channel-lock effect. With rosegarden midi note
is played only once (only first that appeared in midi track) and others
are corrctly sent to alsa but not audiable. That first note is pitch and
velocity correct. With vkeybd this is some kind wierder - Every played
note is audiable as it should, but effect is more like deep reverb on most
instuments piano), and sustan like on looping instruments (organs)!
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 17:34 vlajsa         New Bug                                      
09-26-04 17:34 vlajsa         Kernel Version            => 2.6.9-rc2       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
