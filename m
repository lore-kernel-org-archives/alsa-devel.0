From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001245]: crash while building latest driver for mia soundcard on ubuntu linux.
Date: Sat, 9 Jul 2005 05:11:20 +0200
Message-ID: <cc051688cffd302e57b785179e4aa44f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BC720170
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 05:11:20 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1245> 
======================================================================
Reported By:                wbrown338
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1245
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Linux ubuntu 2.6.10-5-386
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Fri Jun 24 16:53:01 UTC
2005 i686 GNU/Linux
Kernel Version:             2.6.10-5-386
======================================================================
Date Submitted:             07-09-2005 05:11 CEST
Last Modified:              07-09-2005 05:11 CEST
======================================================================
Summary:                    crash while building latest driver for mia soundcard
on ubuntu linux.
Description: 
crash during build:

make -C /usr/src/linux-source-2.6.10
SUBDIRS=/usr/src/alsa/alsa-driver-1.0.9b  modules
make[1]: Entering directory `/usr/src/linux-source-2.6.10'
  CC [M]  /usr/src/alsa/alsa-driver-1.0.9b/acore/memalloc.o
/bin/sh: scripts/genksyms/genksyms: No such file or directory
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore/memalloc.o] Error 1
make[2]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore] Error 2
make[1]: *** [_module_/usr/src/alsa/alsa-driver-1.0.9b] Error 2
make[1]: Leaving directory `/usr/src/linux-source-2.6.10'
make: *** [compile] Error 2
rm -f /lib/modules/2.6.10/misc/snd*.*o /lib/modules/2.6.10/misc/persist.o
/lib/modules/2.6.10/misc/isapnp.o
make[1]: Entering directory `/usr/src/alsa/alsa-driver-1.0.9b/acore'
mkdir -p /lib/modules/2.6.10/misc/acore
cp snd-hpet.ko snd-page-alloc.ko snd-pcm.ko snd-rawmidi.ko snd-rtctimer.ko
snd-timer.ko snd.ko /lib/modules/2.6.10/misc/acore
cp: cannot stat `snd-hpet.ko': No such file or directory
cp: cannot stat `snd-page-alloc.ko': No such file or directory
cp: cannot stat `snd-pcm.ko': No such file or directory
cp: cannot stat `snd-rawmidi.ko': No such file or directory
cp: cannot stat `snd-rtctimer.ko': No such file or directory
cp: cannot stat `snd-timer.ko': No such file or directory
cp: cannot stat `snd.ko': No such file or directory
make[1]: *** [modules_install] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.9b/acore'
make: *** [install-modules] Error 1
root@ubuntu:/usr/src/alsa/alsa-driver-1.0.9b #

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 05:11 wbrown338      New Issue                                    
07-09-05 05:11 wbrown338      Distribution              => Linux ubuntu
2.6.10-5-386 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Fri Jun 24
16:53:01 UTC 2005 i686 GNU/Linux
07-09-05 05:11 wbrown338      Kernel Version            => 2.6.10-5-386    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
