From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000533]: Cannot restore from file it created
Date: Mon, 27 Sep 2004 14:49:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040927124916.AC8032400C@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 036412D5
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 14:49:16 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000533
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Bug ID:                     533
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             09-24-2004 06:39 CEST
Last Modified:              09-27-2004 14:49 CEST
======================================================================
Summary:                    Cannot restore from file it created
Description: 
Package: alsa-utils
Version: 1.0.3-1

fishbowl:~# alsactl store
fishbowl:~# alsactl restore
alsactl: set_control:966: Cannot write control '2:0:0:CD Playback
Switch:0' : Invalid argument

I got nothing more to add.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:06 CEST 
----------------------------------------------------------------------
Which driver?  I guess it's nm256, which was already fixed.

----------------------------------------------------------------------
 jdthood - 09-27-2004 09:56 CEST 
----------------------------------------------------------------------
OK, thanks.  Please close this report.

----------------------------------------------------------------------
 jdthood - 09-27-2004 09:57 CEST 
----------------------------------------------------------------------
OK, thanks.  Please close this report.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 06:39 jdthood        New Bug                                      
09-24-04 12:06 tiwai          Bugnote Added: 0001870                       
09-27-04 09:56 jdthood        Bugnote Added: 0001934                       
09-27-04 09:57 jdthood        Bugnote Added: 0001935                       
09-27-04 14:49 tiwai          Assigned To               => tiwai           
09-27-04 14:49 tiwai          Resolution               open => fixed       
09-27-04 14:49 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
