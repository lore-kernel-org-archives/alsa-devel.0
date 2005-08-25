From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000542]: custom kernel with latest alsa-source fails when CONFIG_SND_DEBUG_MEMORY is NOT set
Date: Thu, 25 Aug 2005 11:56:43 +0200
Message-ID: <c9c073dac6a7ec772a48ce888a1891cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03C9E206
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 11:56:43 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The issue 0001359 has been removed as a DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=542> 
======================================================================
Reported By:                ahasver
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   542
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               debian sid
Kernel Version:             2.6.9rc1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-25-2004 19:31 CEST
Last Modified:              11-09-2004 16:39 CET
======================================================================
Summary:                    custom kernel with latest alsa-source fails when
CONFIG_SND_DEBUG_MEMORY is NOT set
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
 ahasver - 09-26-04 11:48 
----------------------------------------------------------------------
Seems to be corrected with linux 2.6.9rc2
(alsa-cvs 1.0.6 is merged there)
please close

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 19:31 ahasver        New Issue                                    
09-25-04 19:31 ahasver        Distribution              => debian sid      
09-25-04 19:31 ahasver        Kernel Version            => 2.6.9rc1        
09-26-04 11:48 ahasver        Note Added: 0001917                          
09-28-04 19:23 tiwai          Status                   assigned => resolved
09-28-04 19:23 tiwai          Resolution               open => fixed       
11-09-04 16:39 tiwai          Status                   resolved => closed  
08-23-05 16:35 tiwai          Relationship added       has duplicate 0001359
08-25-05 11:56 tiwai          Relationship deleted     has duplicate 0001359
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
