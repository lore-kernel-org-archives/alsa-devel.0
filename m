From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001866]: Build Error
Date: Wed, 22 Feb 2006 09:14:59 +0100
Message-ID: <184bd349cc85f857857db32dfe38ad89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8A671AC
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2006 09:14:59 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1866> 
======================================================================
Reported By:                mtlca
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1866
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-22-2006 09:06 CET
Last Modified:              02-22-2006 09:14 CET
======================================================================
Summary:                    Build Error
Description: 
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_shm.lo -MD -MP -MF .deps/pcm_shm.Tpo -c pcm_shm.c  -fPIC -DPIC -o
.libs/pcm_shm.o
if /bin/sh ../../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I.
-I../../include -I../../include    -g -O2 -MT pcm_file.lo -MD -MP -MF
".deps/pcm_file.Tpo" \
  -c -o pcm_file.lo `test -f 'pcm_file.c' || echo './'`pcm_file.c; \
then mv -f ".deps/pcm_file.Tpo" ".deps/pcm_file.Plo"; \
else rm -f ".deps/pcm_file.Tpo"; exit 1; \
fi
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_file.lo -MD -MP -MF .deps/pcm_file.Tpo -c pcm_file.c  -fPIC -DPIC -o
.libs/pcm_file.o
pcm_file.c: In function `snd_pcm_file_forward':
pcm_file.c:191: parse error before `n'
make[2]: *** [pcm_file.lo] Error 1

======================================================================

----------------------------------------------------------------------
 mtlca - 02-22-06 09:14 
----------------------------------------------------------------------
SoundCard: YMFPCI
Driver:    1.0.10

./configure

checking build system type... i686-pc-linux
checking host system type... i686-pc-linux
checking target system type... i686-pc-linux
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for /usr/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc -E
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
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking how to run the C++ preprocessor... g++ -E
checking for g77... g77
checking whether we are using the GNU Fortran 77 compiler... yes
checking whether g77 accepts -g... yes
checking the maximum length of command line arguments... 32768
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for objdir... .libs
checking for ar... ar
checking for ranlib... ranlib
checking for strip... strip
checking if gcc static flag  works... yes
checking if gcc supports -fno-rtti -fno-exceptions... yes
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
yes
checking whether -lc should be explicitly linked in... no
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking for shl_load... no
checking for shl_load in -ldld... no
checking for dlopen... no
checking for dlopen in -ldl... yes
checking whether a program can dlopen itself... yes
checking whether a statically linked program can dlopen itself... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by g++... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
yes
checking for g++ option to produce PIC... -fPIC
checking if g++ PIC flag -fPIC works... yes
checking if g++ supports -c -o file.o... yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
yes
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking for shl_load... (cached) no
checking for shl_load in -ldld... (cached) no
checking for dlopen... (cached) no
checking for dlopen in -ldl... (cached) yes
checking whether a program can dlopen itself... (cached) yes
checking whether a statically linked program can dlopen itself... (cached)
yes
appending configuration tag "F77" to libtool
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for g77 option to produce PIC... -fPIC
checking if g77 PIC flag -fPIC works... yes
checking if g77 supports -c -o file.o... yes
checking whether the g77 linker (/usr/bin/ld) supports shared libraries...
yes
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking for ANSI C header files... (cached) yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for hsearch_r... yes
checking for library version... major 1 minor 0 subminor 10 extrastr 
extraver 1000000
checking for versioned symbols... yes
checking for debug... yes
checking for tmpdir... /tmp
checking for softfloat... no
checking for architecture... x86
checking for resmgr support... no
checking for aload* support... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/pictures/Makefile
config.status: creating include/Makefile
config.status: creating include/sound/Makefile
config.status: creating src/Makefile
config.status: creating src/control/Makefile
config.status: creating src/mixer/Makefile
config.status: creating src/pcm/Makefile
config.status: creating src/pcm/scopes/Makefile
config.status: creating src/rawmidi/Makefile
config.status: creating src/timer/Makefile
config.status: creating src/hwdep/Makefile
config.status: creating src/seq/Makefile
config.status: creating src/instr/Makefile
config.status: creating src/compat/Makefile
config.status: creating src/alisp/Makefile
config.status: creating src/conf/Makefile
config.status: creating src/conf/cards/Makefile
config.status: creating src/conf/pcm/Makefile
config.status: creating modules/Makefile
config.status: creating modules/mixer/Makefile
config.status: creating modules/mixer/simple/Makefile
config.status: creating alsalisp/Makefile
config.status: creating aserver/Makefile
config.status: creating test/Makefile
config.status: creating utils/Makefile
config.status: creating utils/alsa-lib.spec
config.status: creating utils/alsa.pc
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: executing depfiles commands

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-06 09:06 mtlca          New Issue                                    
02-22-06 09:14 mtlca          Note Added: 0008155                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
