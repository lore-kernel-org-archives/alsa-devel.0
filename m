From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000829]: powerpc: "confmisc.c:879: warning: passing arg 2 of `snd_config_get_pointer' from incompatible pointer type"
Date: Mon, 17 Jan 2005 09:21:01 +0100
Message-ID: <1aa25e9b3f32ecb25aa72b3b3f306b3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 37D9B2AB
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 09:21:01 +0100 (MET)
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
Last Modified:              01-17-2005 09:21 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:21 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
