From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000830]: ia64, alpha: "pcm_jack.c:742: warning: int format, different type arg (arg 5)"
Date: Mon, 17 Jan 2005 11:23:59 +0100
Message-ID: <89b08de20e2a2af8ab08b05e5d2ba2e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1B7C1FB
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 11:23:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=830> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   830
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:36 CET
Last Modified:              01-17-2005 11:23 CET
======================================================================
Summary:                    ia64, alpha: "pcm_jack.c:742: warning: int format,
different type arg (arg 5)"
Description: 
This warning is thrown on ia64 and alpha.

Making all in utils
[...]
make[1]: Entering directory `/build/buildd/alsa-lib-1.0.8/src/pcm/ext'
if /bin/sh ../../../libtool --mode=compile ia64-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../../include -I../../../include -I../../../src/pcm 
-D__ia64__  -g -Wall -O2 -MT pcm_jack.lo -MD -MP -MF ".deps/pcm_jack.Tpo"
\
  -c -o pcm_jack.lo `test -f 'pcm_jack.c' || echo './'`pcm_jack.c; \
then mv -f ".deps/pcm_jack.Tpo" ".deps/pcm_jack.Plo"; \
else rm -f ".deps/pcm_jack.Tpo"; exit 1; \
fi
mkdir .libs
 ia64-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../../include
-I../../../include -I../../../src/pcm -D__ia64__ -g -Wall -O2 -MT
pcm_jack.lo -MD -MP -MF .deps/pcm_jack.Tpo -c pcm_jack.c  -fPIC -DPIC -o
.libs/pcm_jack.o
pcm_jack.c: In function `snd_pcm_jack_open':
pcm_jack.c:742: warning: int format, different type arg (arg 5)
 ia64-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../../include
-I../../../include -I../../../src/pcm -D__ia64__ -g -Wall -O2 -MT
pcm_jack.lo -MD -MP -MF .deps/pcm_jack.Tpo -c pcm_jack.c -o pcm_jack.o
>/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 jdthood - 01-17-05 11:23 
----------------------------------------------------------------------
This warning is also thrown on s390.  See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=s390&stamp=1105954179&file=log&as=raw
for the full build log on s390.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:36 jdthood        New Issue                                    
01-17-05 11:23 jdthood        Note Added: 0003232                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
