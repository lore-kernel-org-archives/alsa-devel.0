From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001158]: dlmisc.c:211: warning: passing arg 1 of `free' discards qualifiers from pointer target type
Date: Wed, 8 Jun 2005 15:53:10 +0200
Message-ID: <c07d165d4fb882d3e6024b205c2fc2e3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DF021F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:53:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1158> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1158
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 09:35 CEST
Last Modified:              06-08-2005 15:53 CEST
======================================================================
Summary:                    dlmisc.c:211: warning: passing arg 1 of `free'
discards qualifiers from pointer target type
Description: 
if /bin/sh ../libtool --mode=compile powerpc-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../include -I../include  -D__ppc__  -g -Wall -O2 -MT dlmisc.lo -MD
-MP -MF ".deps/dlmisc.Tpo" \
  -c -o dlmisc.lo `test -f 'dlmisc.c' || echo './'`dlmisc.c; \
then mv -f ".deps/dlmisc.Tpo" ".deps/dlmisc.Plo"; \
else rm -f ".deps/dlmisc.Tpo"; exit 1; \
fi
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT dlmisc.lo -MD -MP -MF .deps/dlmisc.Tpo -c
dlmisc.c  -fPIC -DPIC -o .libs/dlmisc.o
dlmisc.c: In function `snd_dlobj_cache_cleanup':
dlmisc.c:211: warning: passing arg 1 of `free' discards qualifiers from
pointer target type
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT dlmisc.lo -MD -MP -MF .deps/dlmisc.Tpo -c
dlmisc.c -o dlmisc.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 15:53 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 09:35 jdthood        New Issue                                    
06-08-05 15:53 tiwai          Status                   new => resolved     
06-08-05 15:53 tiwai          Resolution               open => fixed       
06-08-05 15:53 tiwai          Assigned To               => tiwai           
06-08-05 15:53 tiwai          Note Added: 0004938                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
