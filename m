From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000827]: sparc: '../../include/iatomic.h:1017:2: warning: #warning "Atomic operations are not supported on this architecture."'
Date: Mon, 13 Feb 2006 09:18:08 +0100
Message-ID: <ce367aceeb96bb02fbc4d9fdbed97b2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 512631B4
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 09:18:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=827> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   827
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:13 CET
Last Modified:              02-13-2006 09:18 CET
======================================================================
Summary:                    sparc: '../../include/iatomic.h:1017:2: warning:
#warning "Atomic operations are not supported on this architecture."'
Description: 
On sparc the build contains several (on the order of 10) warnings like this
one:

Making all in pcm
make[3]: Entering directory `/build/buildd/alsa-lib-1.0.8/src/pcm'
make[4]: Entering directory `/build/buildd/alsa-lib-1.0.8/src/pcm'
make[4]: Nothing to be done for `all-am'.
make[4]: Leaving directory `/build/buildd/alsa-lib-1.0.8/src/pcm'
if /bin/sh ../../libtool --mode=compile sparc-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../include -I../../include    -g -Wall -O2 -MT atomic.lo -MD
-MP -MF ".deps/atomic.Tpo" \
  -c -o atomic.lo `test -f 'atomic.c' || echo './'`atomic.c; \
then mv -f ".deps/atomic.Tpo" ".deps/atomic.Plo"; \
else rm -f ".deps/atomic.Tpo"; exit 1; \
fi
mkdir .libs
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT atomic.lo -MD -MP -MF .deps/atomic.Tpo -c atomic.c  -fPIC
-DPIC -o .libs/atomic.o
In file included from atomic.c:24:
../../include/iatomic.h:1017:2: warning: #warning "Atomic operations are
not supported on this architecture."
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT atomic.lo -MD -MP -MF .deps/atomic.Tpo -c atomic.c -o
atomic.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 jdthood - 01-20-05 12:40 
----------------------------------------------------------------------
(For completeness) Also seen on m68k.  Full m68k build log:
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=m68k&stamp=1106208530&file=log&as=raw

----------------------------------------------------------------------
 jdthood - 02-13-06 09:18 
----------------------------------------------------------------------
Update for the record: The warning is still issued for 1.0.11rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:13 jdthood        New Issue                                    
01-17-05 09:41 jdthood        Note Added: 0003225                          
01-17-05 11:19 jdthood        Note Added: 0003229                          
01-20-05 12:40 jdthood        Note Added: 0003327                          
05-30-05 13:31 perex          Category                 alisp => general    
02-13-06 09:18 jdthood        Note Added: 0008040                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
