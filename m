From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000523]: Unable to get SPDIF output on Biostar IDEQ minipc
Date: Wed, 22 Sep 2004 22:48:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922204852.3A7C44E011@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A0A731D
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 22:48:52 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 4E48A26A76
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 22:48:52 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000523
======================================================================
Reported By:                pharm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     523
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
======================================================================
Date Submitted:             09-22-2004 22:48 CEST
Last Modified:              09-22-2004 22:48 CEST
======================================================================
Summary:                    Unable to get SPDIF output on Biostar IDEQ minipc
Description: 
I have a Biostar IDEQ 210V minipc. As well as 6 channel analog out (which
appears to work, at least stereo analog out does for certain) there are
two digital (optical) SPDIF outputs. Unfortunately I can't get anything to
recognise these -- mplayer complains about the lack of IEC958 mixer
entries if I try to use the hwac3 output, and if I point the 
alsa output at any of the list of hardware outputs I get nothing from the
digital amp -- it doesn't appear to get any signal.

Assuming I'm not doing something dumb, is there anything else I should
try? I've tried all the ac97_quirk options.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 22:48 pharm          New Bug                                      
09-22-04 22:48 pharm          Distribution              => Debian unstable 
09-22-04 22:48 pharm          Kernel Version            => 2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
