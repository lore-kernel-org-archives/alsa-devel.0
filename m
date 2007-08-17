From: Bill Unruh <unruh@physics.ubc.ca>
Subject: floating point exception in compiling alsa 1.0.14
Date: Fri, 17 Aug 2007 13:32:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708171326210.9350@string.physics.ubc.ca>
References: <46C4E23A.5090000@gia.usb.ve>
	<Pine.LNX.4.64.0708162003310.22506@info.physics.ubc.ca>
	<s5hodh6nsev.wl%tiwai@suse.de> <200708171909.49451.mgerdau@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <200708171909.49451.mgerdau@tiscali.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Michael Gerdau <mgerdau@tiscali.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Iam trying to compile alsa 1.0.14 agains Mandriva Linux kernel 2.6.17-13mdv
And I get a floating point exception.

I No idea how I get a floating point exception.

Anyway, here is the error

.....
make[2]: Leaving directory `/usr/local/src/alsa-driver-1.0.14/misc'
make[1]: Leaving directory `/usr/local/src/alsa-driver-1.0.14'
make -C /lib/modules/2.6.17-13mdv/source
SUBDIRS=/usr/local/src/alsa-driver-1.0.14 O=/lib/modules/2.6.17-13mdv/build
CPP="gcc -E" CC="gcc" modules
make[1]: Entering directory `/usr/src/linux-2.6.17-13mdv'

   WARNING: Symbol version dump /usr/src/linux-2.6.17-13mdv/Module.symvers
            is missing; modules will have no dependencies and modversions.

   CC [M]  /usr/local/src/alsa-driver-1.0.14/acore/hwdep.o
/bin/sh: line 1:  9628 Floating point exception(core dumped)
scripts/basic/fixdep /usr/local/src/alsa-driver-1.0.14/acore/.hwdep.o.d
/usr/local/src/alsa-driver-1.0.14/acore/hwdep.o 'gcc
-Wp,-MD,/usr/local/src/alsa-driver-1.0.14/acore/.hwdep.o.d  -nostdinc
-isystem /usr/lib/gcc/i586-mandriva-linux-gnu/4.1.1/include
-I/usr/local/src/alsa-driver-1.0.14/include -D__KERNEL__ -Iinclude
-Iinclude2 -I/usr/src/linux-2.6.17-13mdv/include -include
include/linux/autoconf.h   -I/usr/local/src/alsa-driver-1.0.14/acore
-I/usr/local/src/alsa-driver-1.0.14/include -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2
-fno-omit-frame-pointer -fno-optimize-sibling-calls -pipe -msoft-float
-mpreferred-stack-boundary=2 -march=i686 -ffreestanding
-I/usr/src/linux-2.6.17-13mdv/include/asm-i386/mach-default
-Iinclude/asm-i386/mach-default -Wdeclaration-after-statement
-Wno-pointer-sign -DALSA_BUILD -DMODULE -D"KBUILD_STR(s)=\#s"
-D"KBUILD_BASENAME=KBUILD_STR(hwdep)"
-D"KBUILD_MODNAME=KBUILD_STR(snd_hwdep)" -c -o
/usr/local/src/alsa-driver-1.0.14/acore/hwdep.o
/usr/local/src/alsa-driver-1.0.14/acore/hwdep.c'
>/usr/local/src/alsa-driver-1.0.14/acore/.hwdep.o.tmp
make[4]: *** [/usr/local/src/alsa-driver-1.0.14/acore/hwdep.o] Error 136
make[3]: *** [/usr/local/src/alsa-driver-1.0.14/acore] Error 2
make[2]: *** [_module_/usr/local/src/alsa-driver-1.0.14] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.17-13mdv'
make: *** [compile] Error 2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
