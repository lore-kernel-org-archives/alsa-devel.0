From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000243]: the duration option does not work in arecord and aplay too
Date: Fri, 24 Sep 2004 05:41:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924034151.D539F9005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3AE5A2AD
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 05:41:52 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000243
======================================================================
Reported By:                Nibble
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     243
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-28-2004 01:31 CEST
Last Modified:              09-24-2004 05:41 CEST
======================================================================
Summary:                    the duration option does not work in arecord and aplay too
Description: 
when using that option: -d 1 or any other number for seconds arecord and
aplay don't stop. The only way to stop recording is Ctrl+C.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-24-2004 05:41 CEST 
----------------------------------------------------------------------
Works for me

$ arecord -d5 foo.wav
Recording WAVE 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
$ arecord --version
arecord: version 1.0.6 by Jaroslav Kysela <perex@suse.cz>

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 01:31 Nibble         New Bug                                      
09-24-04 05:41 jdthood        Bugnote Added: 0001855                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
