From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000526]: Kernel crash during the module snd-azx load
Date: Thu, 23 Sep 2004 19:33:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923173335.E72694500F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4B31E2B5
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 19:33:36 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 094C4271C1
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 19:33:36 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000526
======================================================================
Reported By:                Grazy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     526
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-23-2004 19:33 CEST
Last Modified:              09-23-2004 19:33 CEST
======================================================================
Summary:                    Kernel crash during the module snd-azx load
Description: 
The kernel crash during the load of the snd-azx.
It is the recursive funtion set_mic_rp_wid_connection wich never end.

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 19:33 Grazy          New Bug                                      
09-23-04 19:33 Grazy          File Added: patch_azx_discover.gz                    
09-23-04 19:33 Grazy          Distribution              => Debian          
09-23-04 19:33 Grazy          Kernel Version            => 2.6.8           
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
