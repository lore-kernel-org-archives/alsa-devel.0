From: noreply@alsa-project.org
Subject: [ALSA - tools 0000105]: compilation failure with kernel 2.6.3
Date: Fri, 16 Jul 2004 14:33:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123353.26E512C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 61BFA1DB
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:33:53 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000105
======================================================================
Reported By:                eradicator
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Bug ID:                     105
Category:                   ac3dec
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-02-2004 08:10 CET
Last Modified:              07-16-2004 14:33 CEST
======================================================================
Summary:                    compilation failure with kernel 2.6.3
Description: 
We have reports from many different users that alsa-tools is failing to
compile with the 2.6.3 kernels, but it works fine with 2.6.2.

configure: WARNING: If you wanted to set the --build type, don't use
--host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-pc-linux-gnu-strip... no
checking for strip... strip
checking for i686-pc-linux-gnu-gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for a BSD-compatible install... /bin/install -c
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for ALSA CFLAGS... 
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 0.9.0... found.
checking for snd_ctl_open in -lasound... yes
checking for kernel header files... /lib/modules/2.6.3-mm1/build/include
checking for directory with ALSA kernel headers... 
-I/lib/modules/2.6.3-mm1/build/include
configure: creating ./config.status
config.status: creating Makefile
config.status: executing depfiles commands
if gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\"
-DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"sbiload\"
-DVERSION=\"0.3.0\" -DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1  -I. -I.  
-I/usr/include/fltk-1.1  -march=athlon-tbird -mmmx -m3dnow -ffast-math -O3
-pipe -fomit-frame-pointer -funroll-loops
-I/lib/modules/2.6.3-mm1/build/include 
-I/lib/modules/2.6.3-mm1/build/include -MT sbiload.o -MD -MP -MF
".deps/sbiload.Tpo" \
  -c -o sbiload.o `test -f 'sbiload.c' || echo './'`sbiload.c; \
then mv -f ".deps/sbiload.Tpo" ".deps/sbiload.Po"; \
else rm -f ".deps/sbiload.Tpo"; exit 1; \
fi
In file included from
/lib/modules/2.6.3-mm1/build/include/sound/ainstr_fm.h:29,
                 from sbiload.c:23:
/lib/modules/2.6.3-mm1/build/include/asm/byteorder.h:14: error: syntax
error before "__u32"
/lib/modules/2.6.3-mm1/build/include/asm/byteorder.h:28: error: syntax
error before "__u64"
In file included from
/lib/modules/2.6.3-mm1/build/include/linux/byteorder/little_endian.h:11,
                 from
/lib/modules/2.6.3-mm1/build/include/asm/byteorder.h:57,
                 from
/lib/modules/2.6.3-mm1/build/include/sound/ainstr_fm.h:29,
                 from sbiload.c:23:
/lib/modules/2.6.3-mm1/build/include/linux/byteorder/swab.h:133: error:
syntax error before "__u16"
/lib/modules/2.6.3-mm1/build/include/linux/byteorder/swab.h:146: error:
syntax error before "__u32"
/lib/modules/2.6.3-mm1/build/include/linux/byteorder/swab.h:160: error:
syntax error before "__u64"
make: *** [sbiload.o] Error 1

======================================================================

----------------------------------------------------------------------
 perex - 03-09-2004 13:55 CET 
----------------------------------------------------------------------
It's fixed in CVS (sorry no patch).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-02-04 08:10 eradicator     New Bug                                      
03-02-04 14:46 vq             Bug Monitored: vq                            
03-09-04 13:55 perex          Bugnote Added: 0000543                       
03-09-04 13:55 perex          Resolution               open => fixed       
03-09-04 13:55 perex          Status                   assigned => resolved
07-16-04 14:33 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
