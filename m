From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000532]: Should reject invalid commands
Date: Fri, 24 Sep 2004 06:30:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924043028.2ACFF9005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9106D2F6
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 06:30:28 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 3EAC6264A4
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 06:30:28 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000532
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     532
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-24-2004 06:30 CEST
Last Modified:              09-24-2004 06:30 CEST
======================================================================
Summary:                    Should reject invalid commands
Description: 
The following proves that amixer accepts nonsense arguments with no hint to
the user that nothing was done,

$ amixer set Master,0 nocap; amixer|sum
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
63938     6
$ amixer set Master,0 cap; amixer|sum
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
63938     6

Furthermore, not even $? was set [shell error value]
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 06:30 jdthood        New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
