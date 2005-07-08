From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000248]: Compil problem with au8810
Date: Fri, 8 Jul 2005 10:38:13 +0200
Message-ID: <60c9a2c7fdab30c4ec4667d0f76ede91@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E04F018B
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:13 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=248> 
======================================================================
Reported By:                croiset
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   248
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.7-10 Linux Redhat 7.2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-30-2004 16:25 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    Compil problem with au8810
Description: 
When i want to makes a RPM of alsa-driver 1.0.4, I obtain this message when
I compil it :
-----------------
i386-redhat-linux-gcc -D__KERNEL__ -DMODULE=1
-I/usr/src/redhat/BUILD/alsa-driver-1.0.4/include 
-I/lib/modules/2.4.7-10/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc-iwithprefix include  -DKBUILD_BASENAME=au8810   -c -o au8810.o
au8810.c
In file included from ../../alsa-kernel/pci/au88x0/au8810.c:9,
                 from au8810.c:2:
../../alsa-kernel/pci/au88x0/au88x0_core.c: In function
`vortex_interrupt':
../../alsa-kernel/pci/au88x0/au88x0_core.c:2396: warning: implicit
declaration
of function `unlikely'
In file included from ../../alsa-kernel/pci/au88x0/au8810.c:13,
                 from au8810.c:2:
../../alsa-kernel/pci/au88x0/au88x0_game.c: In function
`vortex_game_read':
../../alsa-kernel/pci/au88x0/au88x0_game.c:48: structure has no member
named `driver'
../../alsa-kernel/pci/au88x0/au88x0_game.c: In function
`vortex_game_trigger':
../../alsa-kernel/pci/au88x0/au88x0_game.c:54: structure has no member
named `driver'
../../alsa-kernel/pci/au88x0/au88x0_game.c: In function
`vortex_game_cooked_read':
../../alsa-kernel/pci/au88x0/au88x0_game.c:61: structure has no member
named `driver'
../../alsa-kernel/pci/au88x0/au88x0_game.c: In function
`vortex_game_open':
../../alsa-kernel/pci/au88x0/au88x0_game.c:77: structure has no member
named `driver'
../../alsa-kernel/pci/au88x0/au88x0_game.c: In function
`vortex_gameport_register':
../../alsa-kernel/pci/au88x0/au88x0_game.c:102: structure has no member
named `driver'
make[2]: *** [au8810.o] Erreur 1
make[2]: Quitte le répertoire
`/usr/src/redhat/BUILD/alsa-driver-1.0.4/pci/au88x0'
make[1]: *** [_modsubdir_au88x0] Erreur 2
make[1]: Quitte le répertoire
`/usr/src/redhat/BUILD/alsa-driver-1.0.4/pci'
make: *** [compile] Erreur 1

======================================================================

----------------------------------------------------------------------
 mjander - 05-24-04 16:38 
----------------------------------------------------------------------
Correct if i got this wrong, but i would conclude that:

- This is a RedHat 7.2 specific problem. There is nothing i can do about
to fix that, except the RedHat kernel maintainers. They no longer support
RedHat 7.2, so unfortunately they won't help either (you're fried,
sorry).

- RedHat kernels are NOT standard kernels. They are custom modified
versions, unique to RedHat. So changing anything on the ALSA source code
won't make any sense. Its there business to stay compatible.

- If you are having latency problems with other newer kernels, You should
rather fix your application than expecting the kernel source to change. Or
try enabling "preemptible" in kernel 2.6, which does a much better job in
the latency department than 2.4.

Best Regards

Manuel Jander

----------------------------------------------------------------------
 jdthood - 04-07-05 21:03 
----------------------------------------------------------------------
Presumed fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-30-04 16:25 croiset        New Issue                                    
04-30-04 16:25 croiset        Kernel Version            => 2.4.7-10 Linux Redhat
7.2
05-17-04 15:20 mjander        Note Added: 0001132                          
05-22-04 16:50 mjander        Note Added: 0001175                          
05-22-04 16:50 mjander        File Added: aureal-2.6.6.diff.gz                  
 
05-24-04 10:48 croiset        Note Added: 0001182                          
05-24-04 16:38 mjander        Note Added: 0001189                          
04-07-05 21:03 jdthood        Note Added: 0004369                          
04-07-05 21:03 jdthood        Status                   assigned => resolved
04-07-05 21:03 jdthood        Resolution               open => fixed       
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
