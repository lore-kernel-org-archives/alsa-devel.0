From: Ivica Bukvic <ico@fuse.net>
Subject: Problem compiling alsa-lib 0.9.0rc3 on MDK 9.0
Date: Mon, 14 Oct 2002 14:54:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210141454.21142.ico@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

These are the errors I came up against compiling either CVS or the latest=
=20
official rc3 version. I do not know the guts of the alsa to be able to fi=
x it=20
myself, so I would greatly appreciate any help I can get on this matter:

creating cache ./config.cache
checking host system type... i686-pc-linux-gnu
checking target system type... i686-pc-linux-gnu
checking build system type... i686-pc-linux-gnu
checking for a BSD compatible install... /usr//bin/install -c
checking whether build environment is sane... yes
checking whether make sets ${MAKE}... yes
checking for working aclocal... found
checking for working autoconf... found
checking for working automake... found
checking for working autoheader... found
checking for working makeinfo... found
checking for gcc... gcc
checking whether the C compiler (gcc  ) works... yes
checking whether the C compiler (gcc  ) is a cross-compiler... no
checking whether we are using GNU C... yes
checking whether gcc accepts -g... yes
checking for a BSD compatible install... /usr//bin/install -c
checking whether ln -s works... yes
checking for ranlib... ranlib
checking for ld used by GCC... /usr//bin/ld
checking if the linker (/usr//bin/ld) is GNU ld... yes
checking for BSD-compatible nm... /usr//bin/nm -B
updating cache ./config.cache
loading cache ./config.cache within ltconfig
checking for object suffix... o
checking for executable suffix... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.lo... yes
checking if gcc supports -fno-rtti -fno-exceptions ... yes
checking if gcc static flag -static works... none
checking if the linker (/usr//bin/ld) is GNU ld... yes
checking whether the linker (/usr//bin/ld) supports shared libraries... y=
es
checking command to parse /usr//bin/nm -B output... ok
checking how to hardcode library paths into programs... immediate
checking for /usr//bin/ld option to reload object files... -r
checking dynamic linker characteristics... Linux ld.so
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for objdir... .libs
checking for dlopen in -ldl... yes
checking for dlfcn.h... yes
checking whether a program can dlopen itself... yes
checking whether a statically linked program can dlopen itself... yes
creating libtool
updating cache ./config.cache
loading cache ./config.cache
checking for kernel header files... not specified
checking for directory with ALSA kernel headers...  -I/usr/include
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sound/asound.h... yes
checking for working const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for hsearch_r... yes
checking for alsa-driver package... present
checking for library version... major 0 minor 9 subminor 0 extrastr rc=20
extraver 100000
checking for debug... yes
checking for architecture... x86
updating cache ./config.cache
creating ./config.status
creating Makefile
creating doc/Makefile
creating doc/pictures/Makefile
creating include/Makefile
creating src/Makefile
creating src/control/Makefile
creating src/mixer/Makefile
creating src/pcm/Makefile
creating src/rawmidi/Makefile
creating src/timer/Makefile
creating src/hwdep/Makefile
creating src/seq/Makefile
creating src/instr/Makefile
creating src/compat/Makefile
creating src/conf/Makefile
creating src/conf/cards/Makefile
creating src/conf/pcm/Makefile
creating aserver/Makefile
creating test/Makefile
creating utils/Makefile
creating utils/alsa-lib.spec
creating include/config.h
include/config.h is unchanged
[ico@test alsa-lib-0.9.0rc3]$ make
Making all in doc
make[1]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/doc'
Making all in pictures
make[2]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/doc/pictures'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/doc/pictures'
make[2]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/doc'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/doc'
make[1]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/doc'
Making all in include
make[1]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/include'
make[1]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/include'
Making all in src
make[1]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/src'
Making all in control
make[2]: Entering directory `/home/ico/alsa-lib-0.9.0rc3/src/control'
/bin/sh ../../libtool --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=20
-I../../include -I../../include    -g -O2 -I/usr/include -c cards.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2=20
-I/usr/include -c  -fPIC -DPIC cards.c -o cards.lo
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system director=
y
/bin/sh ../../libtool --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=20
-I../../include -I../../include    -g -O2 -I/usr/include -c hcontrol.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2=20
-I/usr/include -c  -fPIC -DPIC hcontrol.c -o hcontrol.lo
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system director=
y
/bin/sh ../../libtool --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=20
-I../../include -I../../include    -g -O2 -I/usr/include -c control.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2=20
-I/usr/include -c  -fPIC -DPIC control.c -o control.lo
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system director=
y
/bin/sh ../../libtool --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=20
-I../../include -I../../include    -g -O2 -I/usr/include -c control_hw.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2=20
-I/usr/include -c  -fPIC -DPIC control_hw.c -o control_hw.lo
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system director=
y
/bin/sh ../../libtool --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=20
-I../../include -I../../include    -g -O2 -I/usr/include -c control_shm.c
gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2=20
-I/usr/include -c  -fPIC -DPIC control_shm.c -o control_shm.lo
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system director=
y
In file included from ../../src/pcm/mask.h:27,
                 from ../../src/pcm/pcm_local.h:39,
                 from ../../include/aserver.h:22,
                 from control_shm.c:36:
=2E./../src/pcm/mask_inline.h: In function `snd_mask_sizeof':
=2E./../src/pcm/mask_inline.h:68: sizeof applied to an incomplete type
=2E./../src/pcm/mask_inline.h: In function `snd_mask_none':
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h:73: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h: In function `snd_mask_empty':
=2E./../src/pcm/mask_inline.h:85: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h: In function `snd_mask_full':
=2E./../src/pcm/mask_inline.h:94: dereferencing pointer to incomplete typ=
e
=2E./../src/pcm/mask_inline.h: In function `snd_mask_count':
=2E./../src/pcm/mask_inline.h:103: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_min':
=2E./../src/pcm/mask_inline.h:112: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:113: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_max':
=2E./../src/pcm/mask_inline.h:123: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:124: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_set':
=2E./../src/pcm/mask_inline.h:132: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_reset':
=2E./../src/pcm/mask_inline.h:138: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_set_range':
=2E./../src/pcm/mask_inline.h:146: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_reset_range':
=2E./../src/pcm/mask_inline.h:154: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_leave':
=2E./../src/pcm/mask_inline.h:161: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:163: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_intersect':
=2E./../src/pcm/mask_inline.h:170: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:170: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_union':
=2E./../src/pcm/mask_inline.h:177: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:177: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_copy':
=2E./../src/pcm/mask_inline.h:187: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:187: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_test':
=2E./../src/pcm/mask_inline.h:193: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_single':
=2E./../src/pcm/mask_inline.h:201: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:203: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:203: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h: In function `snd_mask_refine':
=2E./../src/pcm/mask_inline.h:214: storage size of `old' isn't known
=2E./../src/pcm/mask_inline.h: In function `snd_mask_never_eq':
=2E./../src/pcm/mask_inline.h:290: dereferencing pointer to incomplete ty=
pe
=2E./../src/pcm/mask_inline.h:290: dereferencing pointer to incomplete ty=
pe
make[2]: *** [control_shm.lo] Error 1
make[2]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/ico/alsa-lib-0.9.0rc3/src'
make: *** [all-recursive] Error 1

Sincerely,

Ico


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
