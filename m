From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: alsa-driver 1.0.18 doesn't built on PPC 2.6.27 and
	2.6.28
Date: Tue, 4 Nov 2008 14:44:34 +0100
Message-ID: <20081104134434.GA4122@bilbo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id EBD7724542
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 14:44:43 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org


Hi all,

please note the following error:

/usr/bin/make -C /usr/src/linux-2.6.27.2 SUBDIRS=/usr/src/modules/alsa-driver  CPP="gcc-4.3 -E" CC="gcc-4.3" modules
make[4]: Entering directory `/usr/src/linux-2.6.27.2'
  CC [M]  /usr/src/modules/alsa-driver/acore/hwdep.o
In file included from /usr/src/linux-2.6.27.2/arch/powerpc/include/asm/system.h:528,
                 from include/linux/list.h:7,
                 from include/linux/module.h:9,
                 from /usr/src/modules/alsa-driver/include/adriver.h:26,
                 from /usr/src/modules/alsa-driver/acore/hwdep.c:1:
include/asm-generic/cmpxchg-local.h: In function '__cmpxchg_local_generic':
include/asm-generic/cmpxchg-local.h:23: error: implicit declaration of function 'local_irq_save'
include/asm-generic/cmpxchg-local.h:44: error: implicit declaration of function 'local_irq_restore'
make[6]: *** [/usr/src/modules/alsa-driver/acore/hwdep.o] Fehler 1
make[5]: *** [/usr/src/modules/alsa-driver/acore] Fehler 2
make[4]: *** [_module_/usr/src/modules/alsa-driver] Fehler 2
make[4]: Leaving directory `/usr/src/linux-2.6.27.2'
make[3]: *** [compile] Fehler 2
make[3]: Leaving directory `/usr/src/modules/alsa-driver'
make[2]: *** [build-stamp] Fehler 2
make[2]: Leaving directory `/usr/src/modules/alsa-driver'
make[1]: *** [kdist_image] Fehler 2
make[1]: Leaving directory `/usr/src/modules/alsa-driver'
Module /usr/src/modules/alsa-driver failed.

Same on 2.6.28-rc3

BTW, alsa-driver 1.0.18 builds fine on PPC 2.6.26. The PPC divers
build fine out of vanilla trees (1.6.26/1.0.17 and 2.6.28/1.0.18-rc3)

Thanks for cooperation
Elimar

-- 
  "Talking much about oneself can also 
   be a means to conceal oneself."
         -Friedrich Nietzsche
