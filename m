From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000542]: custom kernel with latest alsa-source fails when CONFIG_SND_DEBUG_MEMORY is NOT set
Date: Tue, 28 Sep 2004 19:23:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928172347.9397346008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D0D74316
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 19:23:47 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000542
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
Status:                     resolved
Distribution:               debian sid
Kernel Version:             2.6.9rc1
Resolution:                 fixed
======================================================================
Date Submitted:             09-25-2004 19:31 CEST
Last Modified:              09-28-2004 19:23 CEST
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

----------------------------------------------------------------------
 ahasver - 09-26-2004 11:48 CEST 
----------------------------------------------------------------------
Seems to be corrected with linux 2.6.9rc2
(alsa-cvs 1.0.6 is merged there)
please close

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 19:31 ahasver        New Bug                                      
09-25-04 19:31 ahasver        Distribution              => debian sid      
09-25-04 19:31 ahasver        Kernel Version            => 2.6.9rc1        
09-26-04 11:48 ahasver        Bugnote Added: 0001917                       
09-28-04 19:23 tiwai          Resolution               open => fixed       
09-28-04 19:23 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
