From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000827]: sparc: '../../include/iatomic.h:1017:2: warning: #warning "Atomic operations are not supported on this architecture."'
Date: Mon, 17 Jan 2005 09:13:39 +0100
Message-ID: <bdf717bfaafb6e66865d99d12472bb4a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 09CCC2A9
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 09:13:42 +0100 (MET)
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
Last Modified:              01-17-2005 09:13 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:13 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
