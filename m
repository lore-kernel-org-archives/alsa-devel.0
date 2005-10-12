From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: alsa-driver build fails with gcc-3.3
Date: Wed, 12 Oct 2005 16:12:49 +0200
Message-ID: <434D19E1.4010201@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailservice.tudelft.nl (mailservice.tudelft.nl [130.161.131.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A0A5134
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 16:12:48 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 01C7F2330FD
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 16:12:48 +0200 (CEST)
Received: from aglu.demon.nl (x104.decis.nl [130.161.177.104])
	by mx2.tudelft.nl (Postfix) with ESMTP id 3A5A32330FC
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 16:12:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by aglu.demon.nl (Postfix) with ESMTP id 4AF1E3FFBB
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 16:12:50 +0200 (CEST)
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

gcc-3.3 -D__KERNEL__ -DMODULE=1 -I/usr/src/modules/alsa-driver/include  -I/usr/src/kernel-headers-2.4.27-2-686/include -I/usr/src/kernel-headers-2.4.27-2-686/include -O2 -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include /usr/src/kernel-headers-2.4.27-2-686/include/linux/modversions.h  -DKBUILD_BASENAME=memory   -c -o
memory.o memory.c
In file included from memory.c:2:
../alsa-kernel/core/memory.c:37: error: syntax error before '*' token
../alsa-kernel/core/memory.c:38: warning: function declaration isn't a prototype
../alsa-kernel/core/memory.c: In function `copy_to_user_fromio':
../alsa-kernel/core/memory.c:40: error: `count' undeclared (first use in this function)
../alsa-kernel/core/memory.c:40: error: (Each undeclared identifier is reported only once
../alsa-kernel/core/memory.c:40: error: for each function it appears in.)
../alsa-kernel/core/memory.c:40: error: `dst' undeclared (first use in this function)
../alsa-kernel/core/memory.c:40: error: syntax error before "__force"
../alsa-kernel/core/memory.c:40: error: syntax error before "__force"
../alsa-kernel/core/memory.c: At top level:
../alsa-kernel/core/memory.c:68: error: syntax error before '*' token
../alsa-kernel/core/memory.c:69: warning: function declaration isn't a prototype
../alsa-kernel/core/memory.c: In function `copy_from_user_toio':
../alsa-kernel/core/memory.c:71: error: `count' undeclared (first use in this function)
../alsa-kernel/core/memory.c:71: error: syntax error before "__force"
../alsa-kernel/core/memory.c:71: error: `src' undeclared (first use in this function)
../alsa-kernel/core/memory.c:71: error: syntax error before "__force"
make[4]: *** [memory.o] Error 1
make[4]: Leaving directory `/usr/src/modules/alsa-driver/acore'
make[3]: *** [compile] Error 1
make[3]: Leaving directory `/usr/src/modules/alsa-driver'
make[2]: *** [build-stamp] Error 2
make[2]: Leaving directory `/usr/src/modules/alsa-driver'
make[1]: *** [kdist_image] Error 2
make[1]: Leaving directory `/usr/src/modules/alsa-driver'


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
