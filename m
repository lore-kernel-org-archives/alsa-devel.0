From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000520]: [PATCH] 91_debian_alsaconf_noclear
Date: Wed, 22 Sep 2004 18:24:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922162455.363083200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 87249368
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 18:24:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000520
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     520
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-21-2004 20:03 CEST
Last Modified:              09-22-2004 18:24 CEST
======================================================================
Summary:                    [PATCH] 91_debian_alsaconf_noclear
Description: 
This is a patch for alsaconf which makes it not clear the
screen, but print a newline instead.  The advantage is that
error messages are not cleared.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-22-2004 18:24 CEST 
----------------------------------------------------------------------
Why overwrite clear() even if no error state?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 20:03 jdthood        New Bug                                      
09-21-04 20:03 jdthood        File Added: 91_debian_alsaconf_noclear.dpatch                    
09-22-04 18:24 tiwai          Bugnote Added: 0001816                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
