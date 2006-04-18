From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002031]: compilation problem in pci/trident/trident_main.c
Date: Tue, 18 Apr 2006 12:11:08 +0200
Message-ID: <d6a6cf17ddf2fb0832d56a497a933b18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97CC61A7
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 12:11:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2031> 
======================================================================
Reported By:                croiset
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2031
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             04-18-2006 12:11 CEST
Last Modified:              04-18-2006 12:11 CEST
======================================================================
Summary:                    compilation problem in pci/trident/trident_main.c
Description: 
There is an undeclared variable for kernel 2.4

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
e/linux/modversions.h  -DKBUILD_BASENAME=trident   -c -o trident.o
trident.c
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
e/linux/modversions.h   -DEXPORT_SYMTAB -c trident_main.c
In file included from trident_main.c:2:
../../alsa-kernel/pci/trident/trident_main.c: In function
`snd_trident_create':
../../alsa-kernel/pci/trident/trident_main.c:3558: `DMA_30BIT_MASK'
undeclared
(first use in this function)
../../alsa-kernel/pci/trident/trident_main.c:3558: (Each undeclared
identifier
is reported only once
../../alsa-kernel/pci/trident/trident_main.c:3558: for each function it
appears
 in.)
make[2]: *** [trident_main.o] Erreur 1
make[2]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc5/pci/tri
dent'
make[1]: *** [_modsubdir_trident] Erreur 2
make[1]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc5/pci'
make: *** [compile] Erreur 1
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 12:11 croiset        New Issue                                    
04-18-06 12:11 croiset        Distribution              => Redhat 7.2      
04-18-06 12:11 croiset        Kernel Version            => 2.4.7-10        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
