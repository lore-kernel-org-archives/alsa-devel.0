From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000516]: [PATCH] 20_alsaconf_lspci
Date: Wed, 22 Sep 2004 22:34:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922203447.7E0B14500E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D37D4320
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 22:34:47 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000516
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     516
Category:                   alsaconf
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-21-2004 19:52 CEST
Last Modified:              09-22-2004 22:34 CEST
======================================================================
Summary:                    [PATCH] 20_alsaconf_lspci
Description: 
Patch to make alsaconf parse lspci output correctly
======================================================================

----------------------------------------------------------------------
 tiwai - 09-22-2004 18:16 CEST 
----------------------------------------------------------------------
On which system the string "Class" doesn't match?
Depending on locale?

----------------------------------------------------------------------
 jdthood - 09-22-2004 22:34 CEST 
----------------------------------------------------------------------
Here is my lspci output:

$ sudo lspci -n
0000:00:00.0 0600: 8086:7190 (rev 03)
0000:00:01.0 0604: 8086:7191 (rev 03)
0000:00:02.0 0607: 104c:ac1b (rev 03)
0000:00:02.1 0607: 104c:ac1b (rev 03)
0000:00:03.0 0780: 11c1:0449 (rev 01)
0000:00:06.0 0401: 1013:6003 (rev 01)
0000:00:07.0 0680: 8086:7110 (rev 02)
0000:00:07.1 0101: 8086:7111 (rev 01)
0000:00:07.2 0c03: 8086:7112 (rev 01)
0000:00:07.3 0680: 8086:7113 (rev 03)
0000:01:00.0 0300: 10c8:0006

$ uname -a
Linux thanatos 2.6.8.1 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 Mon Aug 30 12:40:53 CEST 2004 i686 GNU/Linux

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 19:52 jdthood        New Bug                                      
09-21-04 19:52 jdthood        File Added: 20_alsaconf_lspci.dpatch                    
09-22-04 18:16 tiwai          Bugnote Added: 0001815                       
09-22-04 22:34 jdthood        Bugnote Added: 0001819                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
