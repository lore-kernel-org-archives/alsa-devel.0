From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000824]: sparc, powerpc, hppa, alpha, ia64: "Please, recode mix_areas1() routine to your architecture..."
Date: Tue, 29 Mar 2005 19:06:45 +0200
Message-ID: <850e0cc974894091d0c311564d3186b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6D461F0
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 19:06:45 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=824> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   824
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2005 08:58 CET
Last Modified:              03-29-2005 19:06 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000926 There is no source code for the functio...
======================================================================

----------------------------------------------------------------------
 jdthood - 03-16-05 22:34 
----------------------------------------------------------------------
See also bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=926.

----------------------------------------------------------------------
 tiwai - 03-29-05 19:06 
----------------------------------------------------------------------
The CVS version has the generic architecture support without atomic ops.

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
01-20-05 12:37 jdthood        Note Added: 0003326                          
01-23-05 17:59 jdthood        Note Added: 0003388                          
03-16-05 22:34 jdthood        Note Added: 0003971                          
03-17-05 08:16 perex          Relationship added       related to 0000926  
03-29-05 19:06 tiwai          Status                   new => resolved     
03-29-05 19:06 tiwai          Resolution               open => fixed       
03-29-05 19:06 tiwai          Assigned To               => tiwai           
03-29-05 19:06 tiwai          Note Added: 0004255                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
