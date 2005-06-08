From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001159]: /tmp/ccN0wta4.s:6428: Warning: unterminated string; newline inserted
Date: Wed, 8 Jun 2005 15:49:41 +0200
Message-ID: <b34346e0a3a47dbdb2949182b0355b6b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C06521F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:49:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1159> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1159
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   low
Status:                     new
======================================================================
Date Submitted:             06-06-2005 09:41 CEST
Last Modified:              06-08-2005 15:49 CEST
======================================================================
Summary:                    /tmp/ccN0wta4.s:6428: Warning: unterminated string;
newline inserted
Description: 
if /bin/sh ../../libtool --mode=compile sparc-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../../include -I../../include    -g -Wall -O2 -MT control.lo -MD -MP
-MF ".deps/control.Tpo" \
  -c -o control.lo `test -f 'control.c' || echo './'`control.c; \
then mv -f ".deps/control.Tpo" ".deps/control.Plo"; \
else rm -f ".deps/control.Tpo"; exit 1; \
fi
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c 
-fPIC -DPIC -o .libs/control.o
/tmp/ccN0wta4.s: Assembler messages:
/tmp/ccN0wta4.s:6428: Warning: unterminated string; newline inserted
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c -o
control.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 perex - 06-08-05 15:49 
----------------------------------------------------------------------
It looks like a specific sparc / binutils problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 09:41 jdthood        New Issue                                    
06-08-05 15:49 perex          Note Added: 0004936                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
