From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000825]: On alpha: "alisp.c:2933: warning: int format, different type arg (arg 6)"
Date: Mon, 17 Jan 2005 11:22:25 +0100
Message-ID: <0f2aab699d25099ac668b558e59c8657@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B153B1FB
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 11:22:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=825> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   825
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:05 CET
Last Modified:              01-17-2005 11:22 CET
======================================================================
Summary:                    On alpha: "alisp.c:2933: warning: int format,
different type arg (arg 6)"
Description: 
Making all in alisp
make[3]: Entering directory `/build/buildd/alsa-lib-1.0.8/src/alisp'
if /bin/sh ../../libtool --mode=compile alpha-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../include -I../../include    -g -Wall -O2 -MT alisp.lo -MD
-MP -MF ".deps/alisp.Tpo" \
  -c -o alisp.lo `test -f 'alisp.c' || echo './'`alisp.c; \
then mv -f ".deps/alisp.Tpo" ".deps/alisp.Plo"; \
else rm -f ".deps/alisp.Tpo"; exit 1; \
fi
mkdir .libs
 alpha-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT alisp.lo -MD -MP -MF .deps/alisp.Tpo -c alisp.c  -fPIC
-DPIC -o .libs/alisp.o
alisp.c: In function `F_stat_memory':
alisp.c:2933: warning: int format, different type arg (arg 6)
 alpha-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT alisp.lo -MD -MP -MF .deps/alisp.Tpo -c alisp.c -o
alisp.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 jdthood - 01-17-05 09:25 
----------------------------------------------------------------------
For the full build log on alpha see
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=alpha&stamp=1105907568&file=log&as=raw

This appears in the ia64 build too.  See:
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=ia64&stamp=1105907385&file=log&as=raw
for the ia64 build log.

----------------------------------------------------------------------
 jdthood - 01-17-05 11:22 
----------------------------------------------------------------------
This warning also appears on s390.  See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=s390&stamp=1105954179&file=log&as=raw
for the full build log on s390.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:05 jdthood        New Issue                                    
01-17-05 09:25 jdthood        Note Added: 0003223                          
01-17-05 11:22 jdthood        Note Added: 0003231                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
