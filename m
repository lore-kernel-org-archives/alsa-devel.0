From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000829]: powerpc: "confmisc.c:879: warning: passing arg 2 of `snd_config_get_pointer' from incompatible pointer type"
Date: Tue, 18 Jan 2005 16:49:41 +0100
Message-ID: <637905eafbbfb1714135429228f1897b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 02567248
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 16:49:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=829> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   829
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:21 CET
Last Modified:              01-18-2005 16:49 CET
======================================================================
Summary:                    powerpc: "confmisc.c:879: warning: passing arg 2 of
`snd_config_get_pointer' from incompatible pointer type"
Description: 
Making all in alisp
[...]
if /bin/sh ../libtool --mode=compile powerpc-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../include -I../include  -D__ppc__  -g -Wall -O2 -MT confmisc.lo -MD
-MP -MF ".deps/confmisc.Tpo" \
  -c -o confmisc.lo `test -f 'confmisc.c' || echo './'`confmisc.c; \
then mv -f ".deps/confmisc.Tpo" ".deps/confmisc.Plo"; \
else rm -f ".deps/confmisc.Tpo"; exit 1; \
fi
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT confmisc.lo -MD -MP -MF .deps/confmisc.Tpo -c
confmisc.c  -fPIC -DPIC -o .libs/confmisc.o
confmisc.c: In function `snd_func_private_pcm_subdevice':
confmisc.c:879: warning: passing arg 2 of `snd_config_get_pointer' from
incompatible pointer type
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT confmisc.lo -MD -MP -MF .deps/confmisc.Tpo -c
confmisc.c -o confmisc.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 jdthood - 01-17-05 11:26 
----------------------------------------------------------------------
Also on s390.  See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=s390&stamp=1105954179&file=log&as=raw
for the full s390 build log.

----------------------------------------------------------------------
 jdthood - 01-18-05 16:49 
----------------------------------------------------------------------
Also on mips.  See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=mips&stamp=1106048896&file=log&as=raw
for the full mips build log.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:21 jdthood        New Issue                                    
01-17-05 09:30 jdthood        Note Added: 0003224                          
01-17-05 11:26 jdthood        Note Added: 0003233                          
01-18-05 16:49 jdthood        Note Added: 0003251                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
