From: John Spencer <maillist-alsa@barfooze.de>
Subject: Re: [PATCH] pcm.h: include sys/types.h,
 necessary for u_int_XX types
Date: Thu, 10 Oct 2013 15:36:11 +0200
Message-ID: <5256AD4B.3030009@barfooze.de>
References: <1381411060-15484-1-git-send-email-maillist-alsa@barfooze.de>
 <s5hbo2x8d0p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080404090109040006030008"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 759F12655A1
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 15:39:57 +0200 (CEST)
In-Reply-To: <s5hbo2x8d0p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080404090109040006030008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2013 03:35 PM, Takashi Iwai wrote:
> At Thu, 10 Oct 2013 15:17:40 +0200,
> John Spencer wrote:
>>
>> fixes compilation on musl libc.
>
> But sys/types.h is already included in asoundlib.h...

maybe, but right now this header is not usable standalone as-is, and 
something during build includes it without including asoundlib.h:

In file included from ../../include/local.h:141:0,
                  from control_local.h:22,
                  from hcontrol.c:51:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'

full build log attached.

--JS


>
>
> Takashi
>
>> ---
>>   include/pcm.h |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/pcm.h b/include/pcm.h
>> index 95b8aed..7ea9e84 100644
>> --- a/include/pcm.h
>> +++ b/include/pcm.h
>> @@ -29,6 +29,8 @@
>>   #ifndef __ALSA_PCM_H
>>   #define __ALSA_PCM_H
>>
>> +#include<sys/types.h>
>> +
>>   #ifdef __cplusplus
>>   extern "C" {
>>   #endif
>> --
>> 1.7.3.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>


--------------080404090109040006030008
Content-Type: text/x-log;
 name="build_alsa-lib.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="build_alsa-lib.log"

Thu Oct 10 13:31:59 UTC 2013: start
sourcing user defined optimization config //etc/butch-optflags.sh
Thu Oct 10 13:31:59 UTC 2013: starting to untar
Thu Oct 10 13:31:59 UTC 2013: untar done
Thu Oct 10 13:31:59 UTC 2013: start build
patching file include/iatomic.h
patching file src/pcm/mask_inline.h
patching file include/local.h
configure: loading cache config.cache
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking for a BSD-compatible install... /bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... ./install-sh -c -d
checking for gawk... no
checking for mawk... no
checking for nawk... no
checking for awk... awk
checking whether make sets $(MAKE)... (cached) yes
checking whether to enable maintainer-specific portions of Makefiles... yes
checking whether make supports nested variables... yes
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... (cached) o
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking how to run the C preprocessor... gcc -E
checking whether ln -s works... yes
checking how to print strings... printf
checking for a sed that does not truncate output... (cached) sed
checking for grep that handles long lines and -e... (cached) grep
checking for egrep... (cached) grep -E
checking for fgrep... (cached) grep -F
checking for ld used by gcc... /bin/ld
checking if the linker (/bin/ld) is GNU ld... (cached) yes
checking for BSD- or MS-compatible name lister (nm)... /bin/nm -B
checking the name lister (/bin/nm -B) interface... BSD nm
checking the maximum length of command line arguments... 32768
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... no
checking how to convert x86_64-unknown-linux-gnu file names to x86_64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /bin/ld option to reload object files... -r
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... (cached) ar
checking for archiver @FILE support... @
checking for ranlib... (cached) ranlib
checking command to parse /bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... no
checking if : is a manifest tool... no
checking for ANSI C header files... (cached) yes
checking for sys/types.h... (cached) yes
checking for sys/stat.h... (cached) yes
checking for stdlib.h... (cached) yes
checking for string.h... (cached) yes
checking for memory.h... (cached) yes
checking for strings.h... (cached) yes
checking for inttypes.h... (cached) yes
checking for stdint.h... (cached) yes
checking for unistd.h... (cached) yes
checking for dlfcn.h... (cached) yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... (cached) -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... (cached) yes
checking if gcc static flag -static works... (cached) yes
checking if gcc supports -c -o file.o... (cached) yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking for shl_load... no
checking for shl_load in -ldld... (cached) no
checking for dlopen... (cached) yes
checking whether a program can dlopen itself... (cached) yes
checking whether a statically linked program can dlopen itself... no
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
./configure: ./configure.lineno: line 11551: CC_NOUNDEFINED: not found
checking for ANSI C header files... (cached) yes
checking for an ANSI C-conforming const... (cached) yes
checking for inline... (cached) inline
checking whether time.h and sys/time.h may both be included... (cached) yes
checking whether gcc needs -traditional... (cached) no
checking for hsearch_r... no
checking for uselocale... (cached) yes
checking for library version... major 1 minor 0 subminor 27 extrastr  extraver 1000000
checking for versioned symbols... no
checking for symbolic-functions... no
checking for custom symbol prefixes... 
checking for debug... yes
checking for debug assert... no
checking for tmpdir... /tmp
checking for softfloat... no
checking for libdl... checking for dlsym in -ldl... yes
checking for pthread... checking for pthread_join in -lpthread... yes
checking for __thread... yes
checking for librt... checking for clock_gettime in -lrt... yes
checking for architecture... x86
checking wordexp.h usability... yes
checking wordexp.h presence... yes
checking for wordexp.h... yes
checking for resmgr support... no
checking for aload* support... yes
checking for ALSA device file directory... /dev/snd/
checking for aload* device file directory... /dev/
checking for max number of cards... 32
configure: updating cache config.cache
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/pictures/Makefile
config.status: creating doc/doxygen.cfg
config.status: creating include/Makefile
config.status: creating include/sound/Makefile
config.status: creating src/Versions
config.status: creating src/Makefile
config.status: creating src/control/Makefile
config.status: creating src/mixer/Makefile
config.status: creating src/pcm/Makefile
config.status: creating src/pcm/scopes/Makefile
config.status: creating src/rawmidi/Makefile
config.status: creating src/timer/Makefile
config.status: creating src/hwdep/Makefile
config.status: creating src/seq/Makefile
config.status: creating src/ucm/Makefile
config.status: creating src/compat/Makefile
config.status: creating src/alisp/Makefile
config.status: creating src/conf/Makefile
config.status: creating src/conf/alsa.conf.d/Makefile
config.status: creating src/conf/cards/Makefile
config.status: creating src/conf/pcm/Makefile
config.status: creating src/conf/ucm/Makefile
config.status: creating src/conf/ucm/DAISY-I2S/Makefile
config.status: creating src/conf/ucm/PandaBoard/Makefile
config.status: creating src/conf/ucm/PandaBoardES/Makefile
config.status: creating src/conf/ucm/SDP4430/Makefile
config.status: creating src/conf/ucm/tegraalc5632/Makefile
config.status: creating modules/Makefile
config.status: creating modules/mixer/Makefile
config.status: creating modules/mixer/simple/Makefile
config.status: creating alsalisp/Makefile
config.status: creating aserver/Makefile
config.status: creating test/Makefile
config.status: creating test/lsb/Makefile
config.status: creating utils/Makefile
config.status: creating utils/alsa-lib.spec
config.status: creating utils/alsa.pc
config.status: creating include/config.h
config.status: executing depfiles commands
config.status: executing libtool commands
Creating asoundlib.h...
Making all in doc
make[1]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc'
Making all in pictures
make[2]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc/pictures'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc/pictures'
make[2]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc'
make[1]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/doc'
Making all in include
make[1]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
make  all-recursive
make[2]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
Making all in sound
make[3]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include/sound'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include/sound'
make[3]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
make[3]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
make[2]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
make[1]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/include'
Making all in src
make[1]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/src'
Making all in control
make[2]: Entering directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/src/control'
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT cards.lo -MD -MP -MF .deps/cards.Tpo -c -o cards.lo cards.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT tlv.lo -MD -MP -MF .deps/tlv.Tpo -c -o tlv.lo tlv.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT namehint.lo -MD -MP -MF .deps/namehint.Tpo -c -o namehint.lo namehint.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT hcontrol.lo -MD -MP -MF .deps/hcontrol.Tpo -c -o hcontrol.lo hcontrol.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT control.lo -MD -MP -MF .deps/control.Tpo -c -o control.lo control.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT control_hw.lo -MD -MP -MF .deps/control_hw.Tpo -c -o control_hw.lo control_hw.c
/bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include    -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os  -D_GNU_SOURCE -MT setup.lo -MD -MP -MF .deps/setup.Tpo -c -o setup.lo setup.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT hcontrol.lo -MD -MP -MF .deps/hcontrol.Tpo -c hcontrol.c  -fPIC -DPIC -o .libs/hcontrol.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT tlv.lo -MD -MP -MF .deps/tlv.Tpo -c tlv.c  -fPIC -DPIC -o .libs/tlv.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT setup.lo -MD -MP -MF .deps/setup.Tpo -c setup.c  -fPIC -DPIC -o .libs/setup.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT cards.lo -MD -MP -MF .deps/cards.Tpo -c cards.c  -fPIC -DPIC -o .libs/cards.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT namehint.lo -MD -MP -MF .deps/namehint.Tpo -c namehint.c  -fPIC -DPIC -o .libs/namehint.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c  -fPIC -DPIC -o .libs/control.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include -I../../include -include stdlib.h -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -Os -D_GNU_SOURCE -MT control_hw.lo -MD -MP -MF .deps/control_hw.Tpo -c control_hw.c  -fPIC -DPIC -o .libs/control_hw.o
In file included from ../../include/local.h:33:0,
                 from control_local.h:22,
                 from hcontrol.c:51:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from namehint.c:28:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from setup.c:38:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from control_local.h:22,
                 from cards.c:35:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from control_local.h:22,
                 from control_hw.c:30:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from control.c:51:0:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from control_local.h:22,
                 from control.c:52:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:33:0,
                 from control_local.h:22,
                 from tlv.c:36:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from ../../include/local.h:141:0,
                 from control_local.h:22,
                 from hcontrol.c:51:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
In file included from ../../include/local.h:141:0,
                 from namehint.c:28:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
In file included from ../../include/local.h:141:0,
                 from control_local.h:22,
                 from cards.c:35:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
In file included from ../../include/local.h:141:0,
                 from setup.c:38:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
In file included from ../../include/local.h:141:0,
                 from control_local.h:22,
                 from control_hw.c:30:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
In file included from ../../include/local.h:141:0,
                 from control_local.h:22,
                 from tlv.c:36:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
In file included from ../../include/local.h:141:0,
                 from control_local.h:22,
                 from control.c:52:
../../include/pcm.h:1051:1: error: unknown type name 'u_int8_t'
../../include/pcm.h:1052:1: error: unknown type name 'u_int16_t'
../../include/pcm.h:1053:1: error: unknown type name 'u_int32_t'
../../include/pcm.h:1054:1: error: unknown type name 'u_int64_t'
make[2]: *** [cards.lo] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [namehint.lo] Error 1
make[2]: *** [tlv.lo] Error 1
make[2]: *** [control_hw.lo] Error 1
make[2]: *** [setup.lo] Error 1
make[2]: *** [hcontrol.lo] Error 1
make[2]: *** [control.lo] Error 1
make[2]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/src/build/alsa-lib/alsa-lib-1.0.27.2/src'
make: *** [all-recursive] Error 1

--------------080404090109040006030008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080404090109040006030008--
