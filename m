From: Bob Ham <rah@bash.sh>
Subject: can't build snd-sbawe with linux 2.5.64
Date: 05 Mar 2003 22:52:42 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046904762.10136.8.camel@insanity.tek.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HNWmD5omWsIoTMwcs8h/"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from blueyonder.co.uk (pcow058o.blueyonder.co.uk [195.188.53.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA27540
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 23:53:34 +0100
Received: from insanity ([172.18.111.2] helo=insanity.tek.net)
	by depression with esmtp (Exim 3.35 #1 (Debian))
	id 18qhkd-0001hx-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2003 22:52:39 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-HNWmD5omWsIoTMwcs8h/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry to report that I've been unable to get alsa to build the
snd-sbawe driver with 2.5.64.  Both the kernel's version and 0.9.0rc8
fail.  I've attached the output of both build attempts.

Bob

-- 
Bob Ham <rah@bash.sh>

--=-HNWmD5omWsIoTMwcs8h/
Content-Disposition: attachment; filename=alsa-driver-output
Content-Type: text/plain; name=alsa-driver-output; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

make[1]: Entering directory `/usr/src/alsa-driver-0.9.0rc8a/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c hwdep.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c memalloc.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=sgbuf   -c -o sgbuf.o sgbuf.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=memory_wrapper   -c -o memory_wrapper.o memory_wrapper.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c pcm.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc8a/include  -I/lib/modules/2.5.64/build/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=pcm_native   -c -o pcm_native.o pcm_native.c
In file included from /lib/modules/2.5.64/build/include/linux/irq.h:19,
                 from /lib/modules/2.5.64/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.5.64/build/include/linux/interrupt.h:9,
                 from /usr/src/alsa-driver-0.9.0rc8a/include/sound/timer.h:27,
                 from ../alsa-kernel/core/pcm_native.c:33,
                 from pcm_native.c:2:
/lib/modules/2.5.64/build/include/asm/irq.h:16: irq_vectors.h: No such file or directory
In file included from /lib/modules/2.5.64/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.5.64/build/include/linux/interrupt.h:9,
                 from /usr/src/alsa-driver-0.9.0rc8a/include/sound/timer.h:27,
                 from ../alsa-kernel/core/pcm_native.c:33,
                 from pcm_native.c:2:
/lib/modules/2.5.64/build/include/linux/irq.h:67: `NR_IRQS' undeclared here (not in a function)
In file included from /lib/modules/2.5.64/build/include/linux/irq.h:69,
                 from /lib/modules/2.5.64/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.5.64/build/include/linux/interrupt.h:9,
                 from /usr/src/alsa-driver-0.9.0rc8a/include/sound/timer.h:27,
                 from ../alsa-kernel/core/pcm_native.c:33,
                 from pcm_native.c:2:
/lib/modules/2.5.64/build/include/asm/hw_irq.h:27: `NR_IRQS' undeclared here (not in a function)
/lib/modules/2.5.64/build/include/asm/hw_irq.h:30: `NR_IRQS' undeclared here (not in a function)
make[1]: *** [pcm_native.o] Error 1
make[1]: Leaving directory `/usr/src/alsa-driver-0.9.0rc8a/acore'
make: *** [compile] Error 1

--=-HNWmD5omWsIoTMwcs8h/
Content-Disposition: attachment; filename=linux-2.5.64-output
Content-Type: text/plain; name=linux-2.5.64-output; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

make -f scripts/Makefile.build obj=scripts
rm -rf .tmp_versions
mkdir -p .tmp_versions
  Starting the build. KBUILD_BUILTIN= KBUILD_MODULES=1
make -f scripts/Makefile.build obj=init
...
make -f scripts/Makefile.build obj=sound/isa/cs423x
make -f scripts/Makefile.build obj=sound/isa/es1688
make -f scripts/Makefile.build obj=sound/isa/gus
make -f scripts/Makefile.build obj=sound/isa/opti9xx
make -f scripts/Makefile.build obj=sound/isa/sb
  gcc -Wp,-MD,sound/isa/sb/.sbawe.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sbawe -DKBUILD_MODNAME=snd_sbawe -c -o sound/isa/sb/sbawe.o sound/isa/sb/sbawe.c
In file included from sound/isa/sb/sbawe.c:2:
sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
sound/isa/sb/sb16.c:279: warning: implicit declaration of function `isapnp_find_dev'
sound/isa/sb/sb16.c:279: warning: assignment makes pointer from integer without a cast
sound/isa/sb/sb16.c:280: structure has no member named `active'
sound/isa/sb/sb16.c:285: warning: assignment makes pointer from integer without a cast
sound/isa/sb/sb16.c:286: structure has no member named `active'
sound/isa/sb/sb16.c:293: structure has no member named `prepare'
sound/isa/sb/sb16.c:296: warning: implicit declaration of function `isapnp_resource_change'
sound/isa/sb/sb16.c:307: structure has no member named `activate'
sound/isa/sb/sb16.c:324: structure has no member named `prepare'
sound/isa/sb/sb16.c:325: structure has no member named `deactivate'
sound/isa/sb/sb16.c:333: structure has no member named `activate'
sound/isa/sb/sb16.c:335: structure has no member named `deactivate'
sound/isa/sb/sb16.c: In function `snd_sb16_deactivate':
sound/isa/sb/sb16.c:347: structure has no member named `deactivate'
sound/isa/sb/sb16.c:352: structure has no member named `deactivate'
sound/isa/sb/sb16.c: In function `alsa_card_sb16_init':
sound/isa/sb/sb16.c:632: warning: implicit declaration of function `isapnp_probe_cards'
make[3]: *** [sound/isa/sb/sbawe.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2

--=-HNWmD5omWsIoTMwcs8h/--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
