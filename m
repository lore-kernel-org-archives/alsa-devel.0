From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000827]: sparc: '../../include/iatomic.h:1017:2: warning: #warning "Atomic operations are not supported on this architecture."'
Date: Thu, 20 Jan 2005 12:40:50 +0100
Message-ID: <30bce945c640d829861a9e286dca5faa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A385A2B0
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 12:40:50 +0100 (MET)
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
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:13 CET
Last Modified:              01-20-2005 12:40 CET
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
 jdthood - 01-17-05 11:19 
----------------------------------------------------------------------
The warning also appears on s390.  See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=s390&stamp=1105954179&file=log&as=raw
for the full build log on s390.

----------------------------------------------------------------------
 jdthood - 01-20-05 12:40 
----------------------------------------------------------------------
(For completeness) Also seen on m68k.  Full m68k build log:
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=m68k&stamp=1106208530&file=log&as=raw

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:13 jdthood        New Issue                                    
01-17-05 09:41 jdthood        Note Added: 0003225                          
01-17-05 11:19 jdthood        Note Added: 0003229                          
01-20-05 12:40 jdthood        Note Added: 0003327                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
