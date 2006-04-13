From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002019]: Build fails on pcm_dmix.c
Date: Fri, 14 Apr 2006 01:00:43 +0200
Message-ID: <89092dc1da950f11eb5a691f3ae609ad@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D8A8F175
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 01:00:43 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              04-14-2006 01:00 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-06 01:00 GrueMaster     New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
