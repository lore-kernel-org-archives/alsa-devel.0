From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000838]: m68k: "simple.c:223: warning: `n' might be used uninitialized in this function"
Date: Thu, 20 Jan 2005 12:39:48 +0100
Message-ID: <3f5dd6fc078a3766c33152ee8575b56d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 84A3E2B0
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 12:39:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=838> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   838
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-20-2005 12:39 CET
Last Modified:              01-20-2005 12:39 CET
======================================================================
Summary:                    m68k: "simple.c:223: warning: `n' might be used
uninitialized in this function"
Description: 
Making all in mixer
[...]
if /bin/sh ../../libtool --mode=compile m68k-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../../include -I../../include    -g -Wall -O2 -MT simple.lo -MD -MP
-MF ".deps/simple.Tpo" \
  -c -o simple.lo `test -f 'simple.c' || echo './'`simple.c; \
then mv -f ".deps/simple.Tpo" ".deps/simple.Plo"; \
else rm -f ".deps/simple.Tpo"; exit 1; \
fi
 m68k-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g
-Wall -O2 -MT simple.lo -MD -MP -MF .deps/simple.Tpo -c simple.c  -fPIC
-DPIC -o .libs/simple.o
simple.c: In function `to_user':
simple.c:223: warning: `n' might be used uninitialized in this function
simple.c: In function `from_user':
simple.c:232: warning: `n' might be used uninitialized in this function
 m68k-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g
-Wall -O2 -MT simple.lo -MD -MP -MF .deps/simple.Tpo -c simple.c -o
simple.o >/dev/null 2>&1

See
http://buildd.debian.org/fetch.php?&pkg=alsa-lib&ver=1.0.8-1&arch=m68k&stamp=1106208530&file=log&as=raw
for the full m68k build log.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-05 12:39 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
