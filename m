From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000542]: custom kernel with latest alsa-source fails when CONFIG_SND_DEBUG_MEMORY is NOT set
Date: Sat, 25 Sep 2004 19:31:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040925173120.88CE325017@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E0C4A287
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 19:31:20 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 9D12425EC4
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 19:31:20 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000542
======================================================================
Reported By:                ahasver
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     542
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               debian sid
Kernel Version:             2.6.9rc1
======================================================================
Date Submitted:             09-25-2004 19:31 CEST
Last Modified:              09-25-2004 19:31 CEST
======================================================================
Summary:                    custom kernel with latest alsa-source fails when CONFIG_SND_DEBUG_MEMORY is NOT set
Description: 
Compiling a custom kernel with latest alsa-source from cvs fails:

[...]
sound/built-in.o(.text+0x122c): In function `snd_card_new':
: undefined reference to `kcalloc'
sound/built-in.o(.text+0x2b87): In function `snd_info_entry_open':
: undefined reference to `kcalloc'
sound/built-in.o(.text+0x2cb8): In function `snd_info_entry_open':
: undefined reference to `kcalloc'
sound/built-in.o(.text+0x2d68): In function `snd_info_entry_open':
: undefined reference to `kcalloc'
sound/built-in.o(.text+0x343f): In function `snd_info_create_entry':
: undefined reference to `kcalloc'
sound/built-in.o(.text+0x38a9): more undefined references to `kcalloc'
follow
make[1]: *** [.tmp_vmlinux1] Fehler 1
make[1]: Leaving directory `/usr/src/linux-2.6.9-rc1'
make: *** [stamp-build] Fehler 2

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 19:31 ahasver        New Bug                                      
09-25-04 19:31 ahasver        Distribution              => debian sid      
09-25-04 19:31 ahasver        Kernel Version            => 2.6.9rc1        
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
