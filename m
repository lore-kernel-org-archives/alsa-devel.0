From: "Stephen Stocker" <lpar@terraworld.net>
Subject: alsa-driver compile error (1.0.21 and latest snapshot)
Date: Sun, 18 Oct 2009 10:43:01 -0500 (CDT)
Message-ID: <20091018154308.025EB10380E@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.terraworld.net (mail.valnet.net [64.254.32.52])
	by alsa0.perex.cz (Postfix) with SMTP id 025EB10380E
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 17:43:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

   Hi,

   Using Slackware and gcc 3.3.6, I'm getting the following error compiling 
the alsa-driver for intel8x0. This is on a 2.4.24-ck1 kernel, if that helps.

make[1]: Entering directory `/home/lpar/alsa-driver-1.0.21.1.g098ab.13.g15db1/pc
i'
gcc -D__KERNEL__ -DMODULE=1 -I/home/lpar/alsa-driver-1.0.21.1.g098ab.13.g15db1/i
nclude  -I/usr/src/linux-2.4.24-ck1/include -O2 -mpreferred-stack-boundary=2 -ma
rch=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -
O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix in
clude -DMODVERSIONS -include /usr/src/linux-2.4.24-ck1/include/linux/modversions
.h  -DKBUILD_BASENAME=intel8x0   -c -o intel8x0.o intel8x0.c
In file included from intel8x0.c:39:
/home/lpar/alsa-driver-1.0.21.1.g098ab.13.g15db1/include/sound/ac97_codec.h: In
function `snd_ac97_dev_add_pdata':
/home/lpar/alsa-driver-1.0.21.1.g098ab.13.g15db1/include/sound/ac97_codec.h:651:
  error: structure has no member named `platform_data'
intel8x0.c: At top level:
pci_iomap_compat.c:62: warning: `ioport_unmap' defined but not used
intel8x0.c:103: warning: `enable' defined but not used
intel8x0.c:105: warning: `joystick' defined but not used
make[1]: *** [intel8x0.o] Error 1
make[1]: Leaving directory `/home/lpar/alsa-driver-1.0.21.1.g098ab.13.g15db1/pci
'
make: *** [compile] Error 1

   Thanks in advance for any help you can offer. :)
   Steve


-- 
Hope, Despair and the Triumph of Life
          http://www.hdtl.org
   Abuse Prevention/Survivor Support
