From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000539]: Problem with changing size of etram
Date: Fri, 24 Sep 2004 23:55:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924215539.9027EB09D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE733298
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 23:55:39 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000539
======================================================================
Reported By:                mikma
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     539
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.5
======================================================================
Date Submitted:             09-24-2004 23:55 CEST
Last Modified:              09-24-2004 23:55 CEST
======================================================================
Summary:                    Problem with changing size of etram
Description: 
It doesn't work to double the etram size, because of a bad comparison
statement.

patch of emufx.c:
-       if (emu->fx8010.etram_pages.bytes == size)
+       if ((emu->fx8010.etram_pages.bytes / 2) == size)

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 23:55 mikma          New Bug                                      
09-24-04 23:55 mikma          Distribution              => Debian          
09-24-04 23:55 mikma          Kernel Version            => 2.6.5           
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
