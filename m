From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in full duplex, works with OSS, griffin imic
Date: Tue, 21 Sep 2004 21:06:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921190631.4CF4B39006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9E43A309
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 21:06:31 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000521
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              09-21-2004 21:06 CEST
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Bug                                      
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
