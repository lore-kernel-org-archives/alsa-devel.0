From: matt yee-king <yeeking@no-future.com>
Subject: pmac.c compilation error
Date: 30 Mar 2002 14:05:50 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1017497155.5918.17.camel@bennyhill.belmont>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hhen8ioa1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello

I have tried to build alsa-driver 0.9beta12 on 

1. a rev A powerbook g4 400 (kernel 2.4.19-pre3-ben0 and 2.4.10-12a
system yellow dog 2.1)
2. a firewire imac g3 400 (kernel 2.4.10-12a yellow dog 2.1)

on both machines, i pass these arguments to configure:

./configure --with-cards=powermac --with-oss=yes --with-isapnp=no


configure outputs this:

___________

./configure --with-cards=powermac --wi
th-oss=yes --with-isapnp=no

loading cache ./config.cache
checking for gcc... (cached) gcc
checking whether the C compiler (gcc  ) works... yes
checking whether the C compiler (gcc  ) is a cross-compiler... no
checking whether we are using GNU C... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for ranlib... (cached) ranlib
checking for a BSD compatible install... (cached) /usr/bin/install -c
checking how to run the C preprocessor... (cached) gcc -E
checking for ANSI C header files... (cached) yes
checking for working const... (cached) yes
checking for inline... (cached) inline
checking whether time.h and sys/time.h may both be included... (cached)
yes
checking whether gcc needs -traditional... (cached) no
checking for current directory...
/usr/src/audio/alsa/alsa-driver-0.9.0beta12
checking for directory with kernel source...
/lib/modules/2.4.10-12a/build
checking for kernel version... 2.4.10-12a
checking for kernel linux/pm.h... yes
checking for kernel module symbol versions... yes
checking for PCI support in kernel... yes
checking for SGI/MIPS (HAL2) architecture... no
checking for directory to store kernel modules...
/lib/modules/2.4.10-12a/kernel
/sound
checking for verbose printk... on
checking for debug level... none
checking for processor type... ppc
checking for SMP... no
checking for ISA PnP driver in kernel... yes
checking for ISA PnP support... no
checking for driver version... 0.9.0beta12
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... no
checking for which soundcards to compile driver for... powermac
creating ./config.status
creating version
creating Makefile.conf
creating snddevices
creating utils/alsa-driver.spec
creating utils/buildrpm
creating toplevel.config
creating include/config.h
creating include/config1.h
include/config1.h is unchanged
creating include/version.h
include/version.h is unchanged

_____________


make barfs like this:

___________


gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/lib/modules/2.4.10-12a/build/include
-I/usr/src/audio/alsa/alsa-driver-0.9.0beta12/include -O2 -D__powerpc__
-fsigned-char -fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -pipe   -c -o powermac.o powermac.c
../alsa-kernel/ppc/powermac.c:40: warning: `snd_enable' defined but not
used
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/lib/modules/2.4.10-12a/build/include
-I/usr/src/audio/alsa/alsa-driver-0.9.0beta12/include -O2 -D__powerpc__
-fsigned-char -fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -pipe   -c -o pmac.o pmac.c
In file included from pmac.c:1:
../alsa-kernel/ppc/pmac.c: In function `snd_pmac_suspend':
../alsa-kernel/ppc/pmac.c:1313: too many arguments to function
`snd_power_lock'
../alsa-kernel/ppc/pmac.c:1324: warning: implicit declaration of
function `disable_irq_R3ce4ca6f'
../alsa-kernel/ppc/pmac.c: In function `snd_pmac_resume':
../alsa-kernel/ppc/pmac.c:1337: too many arguments to function
`snd_power_lock'
../alsa-kernel/ppc/pmac.c:1353: warning: implicit declaration of
function `enable_irq_Rfcec0987'
make[1]: *** [pmac.o] Error 1
make[1]: Leaving directory
`/usr/src/audio/alsa/alsa-driver-0.9.0beta12/ppc'
make: *** [compile] Error 1

_______________


given that i am not a c coder, is there anything i can do to help get
this working?

cheers

matthew
