From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000826]: sparc: "Assembler messages: Warning: unterminated string; newline inserted"
Date: Wed, 19 Jan 2005 14:46:50 +0100
Message-ID: <b49284702971693173414bb626886052@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D0ED924E
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 14:46:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=826> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   826
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-17-2005 09:10 CET
Last Modified:              01-19-2005 14:46 CET
======================================================================
Summary:                    sparc: "Assembler messages: Warning: unterminated
string; newline inserted"
Description: 
The build log on sparc has several (on the order of 10) warnings like this
one:

Making all in control
[...]
if /bin/sh ../../libtool --mode=compile sparc-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../include -I../../include    -g -Wall -O2 -MT control.lo -MD
-MP -MF ".deps/control.Tpo" \
  -c -o control.lo `test -f 'control.c' || echo './'`control.c; \
then mv -f ".deps/control.Tpo" ".deps/control.Plo"; \
else rm -f ".deps/control.Tpo"; exit 1; \
fi
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c 
-fPIC -DPIC -o .libs/control.o
/tmp/ccVDtR4e.s: Assembler messages:
/tmp/ccVDtR4e.s:6428: Warning: unterminated string; newline inserted
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c -o
control.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:46 
----------------------------------------------------------------------
I don't figure out yet what's wrong.
Can you get the corresponding file (control.s)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:10 jdthood        New Issue                                    
01-19-05 14:46 tiwai          Note Added: 0003278                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
