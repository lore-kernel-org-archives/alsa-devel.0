From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000510]: Utilization of AC'97 on Aureon 7.1 Space
Date: Tue, 21 Sep 2004 09:41:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921074149.3EBAE32005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 99EA8287
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 09:41:49 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 53552262E2
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 09:41:49 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000510
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     510
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             3.1
======================================================================
Date Submitted:             09-21-2004 09:41 CEST
Last Modified:              09-21-2004 09:41 CEST
======================================================================
Summary:                    Utilization of AC'97 on Aureon 7.1 Space
Description: 
As of now, the Aureon driver lacks the capability to playback both analog
input channels and the PCM channel, and the input channels have no
seperate volume control, although the AC'97 chip on the board, STAC9744,
apparently has the capability.

I tried some commercial OSS drivers, and they worked properly, so I know
that it is possible.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 09:41 ungod          New Bug                                      
09-21-04 09:41 ungod          Distribution              => Debian GNU/Linux
09-21-04 09:41 ungod          Kernel Version            => 3.1             
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
