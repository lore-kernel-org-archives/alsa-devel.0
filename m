From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000494]: aoss crashes (patch)
Date: Mon, 13 Sep 2004 15:49:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913134938.BA9BC1200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9D12628B
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 15:49:39 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000494
======================================================================
Reported By:                stsp
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Bug ID:                     494
Category:                   
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-09-2004 20:46 CEST
Last Modified:              09-13-2004 15:49 CEST
======================================================================
Summary:                    aoss crashes (patch)
Description: 
aoss always causes a SIGSEGV for me. Here is a
stack trace:
---
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000  0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001  0x4002a76d in fopen (path=0x40039c3a "/proc/mounts", mode=0x40039c38
"r")
    at alsa-oss.c:661
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002  0x40036d4d in print_access_vector () from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003  0x40038971 in setfscreatecon () from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000004  0x4002fc55 in _init () from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000005  0x4000bf71 in _dl_init_internal () from /lib/ld-linux.so.2
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006  0x400007f5 in _dl_start_user () from /lib/ld-linux.so.2
---
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:49 CEST 
----------------------------------------------------------------------
Could you give the patch summary and signed-off-by line to apply
your patch (preferably with detailed description).

It looks like below.

Summary: [ALSA-OSS] Fix segfault at fopen

This patch fixes the bug....
More description...

Signed-off-by: Foo Bar <foo@bar.com>

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 20:46 stsp           New Bug                                      
09-09-04 20:46 stsp           File Added: alsa-oss.c.diff                    
09-13-04 15:49 tiwai          Bugnote Added: 0001749                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
