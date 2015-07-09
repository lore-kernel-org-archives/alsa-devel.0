From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Cannot open shared library
 /usr/lib/alsa-lib/libasound_module_pcm_jack.so
Date: Thu, 9 Jul 2015 05:52:34 +0000
Message-ID: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0115.outbound.protection.outlook.com [134.170.140.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 75683265D8E
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 07:52:44 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Clemens,


Am trying to cross compile, could you pls help me out for cross_compiling


Am facing some configuration issue as shown below

srinivasan@tata-HP-Elite-7100-Microtower-PC:~/alsa-plugins-1.0.29$ ./configure --host=arm-linux CC=/opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc --prefix=/home/srinivasan/alsa-plugins-1.0.29/
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for arm-linux-strip... no
checking for strip... strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether to enable maintainer-specific portions of Makefiles... yes
checking for arm-linux-gcc... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc accepts -g... yes
checking for /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc... gcc3
checking build system type... x86_64-unknown-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/arm-linux-gnueabihf/bin/ld
checking if the linker (/opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/arm-linux-gnueabihf/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... no
checking for arm-linux-dumpbin... no
checking for arm-linux-link... no
checking for dumpbin... no
checking for link... link -dump
configure: WARNING: using cross tools not prefixed with host triplet
checking the name lister (nm) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert x86_64-unknown-linux-gnu file names to arm-unknown-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/arm-linux-gnueabihf/bin/ld option to reload object files... -r
checking for arm-linux-objdump... no
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for arm-linux-dlltool... no
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for arm-linux-ar... no
checking for ar... ar
checking for archiver @FILE support... @
checking for arm-linux-strip... strip
checking for arm-linux-ranlib... no
checking for ranlib... ranlib
checking command to parse nm output from /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc object... ok
checking for sysroot... no
checking for arm-linux-mt... no
checking for mt... mt
checking if mt is a manifest tool... no
checking how to run the C preprocessor... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc supports -fno-rtti -fno-exceptions... no
checking for /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc option to produce PIC... -fPIC -DPIC
checking if /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc PIC flag -fPIC -DPIC works... yes
checking if /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc static flag -static works... yes
checking if /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc supports -c -o file.o... yes
checking if /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc supports -c -o file.o... (cached) yes
checking whether the /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-gcc linker (/opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/arm-linux-gnueabihf/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for ANSI C header files... (cached) yes
./configure: line 11534: CC_NOUNDEFINED: command not found
checking for arm-linux-pkg-config... no
checking for pkg-config... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin//pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for ALSA... no
configure: error: Package requirements (alsa >= 1.0.11) were not met:

No package 'alsa' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables ALSA_CFLAGS
and ALSA_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.
srinivasan@tata-HP-Elite-7100-Microtower-PC:~/alsa-plugins-1.0.29$

Thanks
Srini
