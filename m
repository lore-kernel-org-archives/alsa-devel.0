From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000575]: alsa mixer settings and sporatic loss of sound
Date: Tue, 12 Oct 2004 14:40:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012124028.9A93E18009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 30C622D9
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:40:29 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000575
======================================================================
Reported By:                grapnell
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     575
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-09-2004 18:09 CEST
Last Modified:              10-12-2004 14:40 CEST
======================================================================
Summary:                    alsa mixer settings and sporatic loss of sound
Description: 
one thing i have noticed about alsa, is a very small event can trigger a
major crash of alsa, such as the forced quit of a non-responding
application that uses sound etc will cause alsa to crash, and I cannot get
sound support to come back unless I reboot. also, the mixer settings will
not save, I have to unmute and restore all the mixer settings manually
everytime I reboot.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:40 CEST 
----------------------------------------------------------------------
The crash really depends on the hardware.  Please describe as precisely
as possible which board you have, on which kernel and distro with which
ALSA driver version, and what happens with which procedure how
frequently.

The mixer setting is FAQ.  It's a feature.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 18:09 grapnell       New Bug                                      
10-12-04 14:40 tiwai          Bugnote Added: 0002095                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
