From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000824]: sparc, powerpc, hppa, alpha, ia64: "Please, recode mix_areas1() routine to your architecture..."
Date: Tue, 18 Jan 2005 18:01:52 +0100
Message-ID: <e83c3ab0fe13c0c56db04feeda55b719@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7E139227
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 18:01:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=824> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   824
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 08:58 CET
Last Modified:              01-18-2005 18:01 CET
======================================================================
Summary:                    sparc, powerpc, hppa, alpha, ia64: "Please, recode
mix_areas1() routine to your architecture..."
Description: 
Making all in pcm
[...]
if /bin/sh ../../libtool --mode=compile powerpc-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../include -I../../include  -D__ppc__  -g -Wall -O2 -MT
pcm_dmix.lo -MD -MP -MF ".deps/pcm_dmix.Tpo" \
  -c -o pcm_dmix.lo `test -f 'pcm_dmix.c' || echo './'`pcm_dmix.c; \
then mv -f ".deps/pcm_dmix.Tpo" ".deps/pcm_dmix.Plo"; \
else rm -f ".deps/pcm_dmix.Tpo"; exit 1; \
fi
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-D__ppc__ -g -Wall -O2 -MT pcm_dmix.lo -MD -MP -MF .deps/pcm_dmix.Tpo -c
pcm_dmix.c  -fPIC -DPIC -o .libs/pcm_dmix.o
pcm_dmix.c:221:2: warning: #warning Please, recode mix_areas1() routine to
your architecture...
pcm_dmix.c: In function `mix_areas1':
pcm_dmix.c:247: warning: use of cast expressions as lvalues is deprecated
pcm_dmix.c:248: warning: use of cast expressions as lvalues is deprecated
pcm_dmix.c:249: warning: use of cast expressions as lvalues is deprecated
pcm_dmix.c:253:2: warning: #warning Please, recode mix_areas2() routine to
your architecture...
pcm_dmix.c: In function `mix_areas2':
pcm_dmix.c:279: warning: use of cast expressions as lvalues is deprecated
pcm_dmix.c:280: warning: use of cast expressions as lvalues is deprecated
pcm_dmix.c:281: warning: use of cast expressions as lvalues is deprecated
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-D__ppc__ -g -Wall -O2 -MT pcm_dmix.lo -MD -MP -MF .deps/pcm_dmix.Tpo -c
pcm_dmix.c -o pcm_dmix.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 jdthood - 01-18-05 17:59 
----------------------------------------------------------------------
> Well, should we disable dmix & co for these architectures?

I don't know -- I haven't investigated the cause of this warning message.
I just assume that it may be helpful if the ALSA team is informed of
compiler warning messages thrown on non-i386 architectures.

----------------------------------------------------------------------
 tiwai - 01-18-05 18:01 
----------------------------------------------------------------------
The warning messages are intentional.  On these platforms, dmix & co won't
work properly because no atomic operations are implemented.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 08:58 jdthood        New Issue                                    
01-17-05 09:06 jdthood        Note Added: 0003222                          
01-17-05 11:21 jdthood        Note Added: 0003230                          
01-18-05 16:48 jdthood        Note Added: 0003250                          
01-18-05 17:45 tiwai          Note Added: 0003253                          
01-18-05 17:59 jdthood        Note Added: 0003255                          
01-18-05 18:01 tiwai          Note Added: 0003256                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
