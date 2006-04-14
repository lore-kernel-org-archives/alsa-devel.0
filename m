From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002019]: Build fails on pcm_dmix.c
Date: Fri, 14 Apr 2006 18:30:22 +0200
Message-ID: <ec741e065fa44e65f4399bd0befc5ffe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 944DC199
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 18:30:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2019> 
======================================================================
Reported By:                GrueMaster
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2019
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-14-2006 01:00 CEST
Last Modified:              04-14-2006 18:30 CEST
======================================================================
Summary:                    Build fails on pcm_dmix.c
Description: 
Build output:

 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_dmix.lo -MD -MP -MF .deps/pcm_dmix.Tpo -c pcm_dmix.c  -fPIC -DPIC -o
.libs/pcm_dmix.o
/tmp/ccJTuE56.s: Assembler messages:
/tmp/ccJTuE56.s:209: Error: `(%ecx,%eax,1)' is not a valid 64 bit
base/index expression
/tmp/ccJTuE56.s:385: Error: `(%ecx,%eax,1)' is not a valid 64 bit
base/index expression


linux:/usr/src/alsa # gcc -v
Reading specs from /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr
--with-local-prefix=/usr/local --infodir=/usr/share/info
--mandir=/usr/share/man --enable-languages=c,c++,f77,objc,java,ada
--disable-checking --libdir=/usr/lib64 --enable-libgcj
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib64
--with-system-zlib --enable-shared --enable-__cxa_atexit
x86_64-suse-linux
Thread model: posix
gcc version 3.3.3 (SuSE Linux)


Tested on RedHat Enterprise Desktop 4 update 2 - builds ok.

======================================================================

----------------------------------------------------------------------
 GrueMaster - 04-14-06 18:01 
----------------------------------------------------------------------
Compiler apparently has an issue with the pcm_dmix_x86_64.h inline assembly
macro MIX_AREAS3.  The line in the macro is:

291:  	"\tleal (%%ecx,%%eax,1), %%ecx\n"

----------------------------------------------------------------------
 GrueMaster - 04-14-06 18:30 
----------------------------------------------------------------------
Workaround:  Install a newer binutils package.  Not exactly a clean
solution, but it works.

The version that ships with Novell is
binutils-2.15.90.0.1.1-32.11.x86_64.rpm.  Updating to 2.15.92 worked. 
Prefer cleaner solution, though, as this will be going out to large
customer base.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-06 01:00 GrueMaster     New Issue                                    
04-14-06 18:01 GrueMaster     Note Added: 0009285                          
04-14-06 18:30 GrueMaster     Note Added: 0009286                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
