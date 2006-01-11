From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001641]: "error: cannot find input file: src/pcm/Makefile.in" when building under Linux 2.4
Date: Wed, 11 Jan 2006 03:24:31 +0100
Message-ID: <06d14748cb50038bb2866d4a9caaaa91@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C2AE102
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 03:24:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1641> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1641
Category:                   0_general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             12-11-2005 11:12 CET
Last Modified:              01-11-2006 03:24 CET
======================================================================
Summary:                    "error: cannot find input file: src/pcm/Makefile.in"
when building under Linux 2.4
Description: 
I can compile alsa-lib-1.0.10 on Kernel 2.4

alsa-lib CVS 11/Dec/2005

./cvscompile
./cvscompile: line 7:  9376 Terminated              automake --foreign
--copy --add-missing
CFLAGS=-O2 -Wall -W -pipe -g
./configure
checking build system type... i686-redhat-linux-gnu
checking host system type... i686-redhat-linux-gnu
checking target system type... i686-redhat-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for gcc... gcc32
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc32 accepts -g... yes
checking for gcc32 option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc32... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by gcc32... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for /usr/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc32 -E
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
checking command to parse /usr/bin/nm -B output from gcc32 object... ok
checking for objdir... .libs
checking for ar... ar
checking for ranlib... ranlib
checking for strip... strip
checking if gcc32 static flag  works... yes
checking if gcc32 supports -fno-rtti -fno-exceptions... no
checking for gcc32 option to produce PIC... -fPIC
checking if gcc32 PIC flag -fPIC works... yes
checking if gcc32 supports -c -o file.o... yes
checking whether the gcc32 linker (/usr/bin/ld) supports shared
libraries... yeschecking whether -lc should be explicitly linked in... no
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
checking whether gcc32 needs -traditional... no
checking for hsearch_r... yes
checking for library version... major 1 minor 0 subminor 10 extrastr 
extraver 1000000
checking for versioned symbols... yes
checking for debug... yes
checking for tmpdir... /tmp
checking for softfloat... no
checking for architecture... x86
checking wordexp.h usability... yes
checking wordexp.h presence... yes
checking for wordexp.h... yes
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
config.status: error: cannot find input file: src/pcm/Makefile.in

======================================================================

----------------------------------------------------------------------
 Raymond - 01-07-06 05:04 
----------------------------------------------------------------------
It look like automake 1.7.8 do not support that change in

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/Makefile.am?r1=1.55&r2=1.56

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/pcm/Makefile.am?r1=1.59&r2=1.60

After revert back to previous revision (Makefile.am)

./cvscompile is OK for /cvs/alsa-lib

Please note that there is no RPM upgrade of automake available for FC1.

----------------------------------------------------------------------
 Raymond - 01-11-06 03:24 
----------------------------------------------------------------------
The PCI subsystem vendor and device id is OK for the onboard intel8x0 but
not au8830(PCI sound card)


	memcpy(ac97->reg_accessed, template->reg_accessed,
sizeof(ac97->reg_accessed));
	bus->codec[ac97->num] = ac97;
	init_MUTEX(&ac97->reg_mutex);
	init_MUTEX(&ac97->page_mutex);

#ifdef CONFIG_PCI
	if (ac97->pci) {
		pci_read_config_word(ac97->pci, PCI_SUBSYSTEM_VENDOR_ID,
&ac97->subsystem_vendor);
		pci_read_config_word(ac97->pci, PCI_SUBSYSTEM_ID,
&ac97->subsystem_device);
	}
#endif
	if (bus->ops->reset) {
		bus->ops->reset(ac97);
		goto __access_ok;
	}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-11-05 11:12 Raymond        New Issue                                    
12-13-05 12:36 jdthood        Summary                  error: cannot find input
file: src/pcm/Makefile.in => "error: cannot find input file:
src/pcm/Makefile.in" when building under Linux 2.4
12-13-05 18:21 Raymond        Note Added: 0007020                          
12-15-05 10:08 perex          Status                   new => resolved     
12-15-05 10:08 perex          Resolution               open => fixed       
12-15-05 10:08 perex          Assigned To               => perex           
12-15-05 10:08 perex          Note Added: 0007048                          
12-15-05 13:30 Raymond        Status                   resolved => feedback
12-15-05 13:30 Raymond        Resolution               fixed => reopened   
12-15-05 13:30 Raymond        Note Added: 0007049                          
12-15-05 13:38 Raymond        Note Added: 0007050                          
12-15-05 13:50 Raymond        Note Added: 0007051                          
01-07-06 03:16 Raymond        Note Added: 0007504                          
01-07-06 05:04 Raymond        Note Added: 0007507                          
01-11-06 03:24 Raymond        Note Added: 0007557                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
