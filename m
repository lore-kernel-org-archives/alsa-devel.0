From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000507]: Soundcard cannot play more than one thing at a time (but Stereo!)
Date: Mon, 20 Sep 2004 17:38:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040920153854.1CFE64904D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6D97D335
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2004 17:38:57 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000507
======================================================================
Reported By:                DashX
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     507
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
Resolution:                 not a bug
======================================================================
Date Submitted:             09-19-2004 17:34 CEST
Last Modified:              09-20-2004 17:38 CEST
======================================================================
Summary:                    Soundcard cannot play more than one thing at a time (but Stereo!)
Description: 
Sound Card:   SoundMAX Integrated Digital Audio
HWBrowser says 82801DB (ICH4) AC'97 Audio Controller

2x xmms with esound = works
2x xmms with alsa = doesent work because of audio device in use.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:38 CEST 
----------------------------------------------------------------------
This hardware doesn't support multiple PCM streams (h/w mixing).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 17:34 DashX          New Bug                                      
09-19-04 17:34 DashX          Distribution              => Fedora Core 2   
09-19-04 17:34 DashX          Kernel Version            => 2.6.8-1.521     
09-19-04 17:36 DashX          Bug Monitored: DashX                         
09-20-04 17:38 tiwai          Bugnote Added: 0001788                       
09-20-04 17:38 tiwai          Resolution               open => not a bug   
09-20-04 17:38 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
