From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002030]: compilation problem ali5451.c
Date: Tue, 18 Apr 2006 11:57:54 +0200
Message-ID: <d97dda99b88f4c536315879705271cb1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 650781A7
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 11:57:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2030> 
======================================================================
Reported By:                croiset
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2030
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             04-18-2006 11:57 CEST
Last Modified:              04-18-2006 11:57 CEST
======================================================================
Summary:                    compilation problem ali5451.c
Description: 
it is impossible to compil under kernel 2.4.7 because there is an
undeclared variable.

make  -C ali5451 modules
make[2]: Entre dans le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc5/pci
/ali5451'
i386-redhat-linux-gcc -D__KERNEL__ -DMODULE=1
-I/home/redhat/BUILD/alsa-driver-
1.0.11rc5/include  -I/lib/modules/2.4.7-10/build/include -O2
-mpreferred-stack-
boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc
 -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/includ
e/linux/modversions.h  -DKBUILD_BASENAME=ali5451   -c -o ali5451.o
ali5451.c
In file included from ali5451.c:1:
../../alsa-kernel/pci/ali5451/ali5451.c: In function `snd_ali_create':
../../alsa-kernel/pci/ali5451/ali5451.c:2224: `DMA_31BIT_MASK' undeclared
(firs
t use in this function)
../../alsa-kernel/pci/ali5451/ali5451.c:2224: (Each undeclared identifier
is re
ported only once
../../alsa-kernel/pci/ali5451/ali5451.c:2224: for each function it appears
in.)
ali5451.c: At top level:
../../alsa-kernel/pci/ali5451/ali5451.c:64: warning: `enable' defined but
not u
sed
make[2]: *** [ali5451.o] Erreur 1
make[2]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc5/pci/ali
5451'
make[1]: *** [_modsubdir_ali5451] Erreur 2
make[1]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc5/pci'
make: *** [compile] Erreur 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 11:57 croiset        New Issue                                    
04-18-06 11:57 croiset        Distribution              => Redhat 7.2      
04-18-06 11:57 croiset        Kernel Version            => 2.4.7-10        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
