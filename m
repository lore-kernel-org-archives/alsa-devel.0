From: noreply@alsa-project.org
Subject: [ALSA - driver 0000390]: modprobe on snd-cmipci fails
Date: Fri, 16 Jul 2004 11:57:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716095726.7406B26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C760E254
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 11:57:26 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000390
======================================================================
Reported By:                mudpuppy
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     390
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               redhat 7.3
Kernel Version:             2.4.20-28
Resolution:                 won't fix
======================================================================
Date Submitted:             07-15-2004 20:52 CEST
Last Modified:              07-16-2004 11:57 CEST
======================================================================
Summary:                    modprobe on snd-cmipci fails
Description: 
following the directions on the website;
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=C-Media&card=CMI8738&chip=CMI8738&module=cmipci
get to the modprobe line and it fails with the following text;

bash-2.05a# modprobe snd-cmipci 
/lib/modules/2.4.20-28.7athalon-new_mobo/kernel/sound/acore/snd.o:
unresolved symbol schedule_work
/lib/modules/2.4.20-28.7athalon-new_mobo/kernel/sound/acore/snd.o: insmod
/lib/modules/2.4.20-28.7athalon-new_mobo/kernel/sound/acore/snd.o failed
/lib/modules/2.4.20-28.7athalon-new_mobo/kernel/sound/acore/snd.o: insmod
snd-cmipci failed
bash-2.05a#uname -a 
Linux u66-dsystem1 2.4.20-28.7athalon-new_mobo https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000008 SMP Fri Jul 16 11:09:29
EDT 2004 i686 unknown.
bash-2.05a#gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)



======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-2004 11:57 CEST 
----------------------------------------------------------------------
See alsa-driver/INSTALL.

You need to run
  % touch include/linux/workqueue.h
on alsa-driver tree before building modules.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-15-04 20:52 mudpuppy       New Bug                                      
07-15-04 20:52 mudpuppy       Distribution              => redhat 7.3      
07-15-04 20:52 mudpuppy       Kernel Version            => 2.4.20-28       
07-16-04 11:57 tiwai          Bugnote Added: 0001441                       
07-16-04 11:57 tiwai          Resolution               open => won't fix   
07-16-04 11:57 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
