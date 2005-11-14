From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000838]: m68k: "simple.c:223: warning: `n' might be used uninitialized in this function"
Date: Mon, 14 Nov 2005 10:31:43 +0100
Message-ID: <d3794d11b794f99a26f2bb238c609067@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAF4A19E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:31:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=838> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   838
Category:                   2_mixer
Reproducibility:            always
Severity:                   minor
Priority:                   none
Status:                     resolved
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             01-20-2005 12:39 CET
Last Modified:              11-14-2005 10:31 CET
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

----------------------------------------------------------------------
 jdthood - 06-06-05 09:38 
----------------------------------------------------------------------
This warning is still present on m68k (at least) so I am going to mark this
report "wontfix".

----------------------------------------------------------------------
 perex - 11-14-05 10:31 
----------------------------------------------------------------------
Looks like the mips GCC compiler problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-05 12:39 jdthood        New Issue                                    
01-20-05 19:09 tiwai          Note Added: 0003330                          
05-30-05 13:39 perex          Status                   new => resolved     
05-30-05 13:39 perex          Resolution               open => fixed       
05-30-05 13:39 perex          Assigned To               => perex           
05-30-05 13:39 perex          Note Added: 0004811                          
06-06-05 09:38 jdthood        Status                   resolved => feedback
06-06-05 09:38 jdthood        Resolution               fixed => reopened   
06-06-05 09:38 jdthood        Note Added: 0004890                          
06-06-05 09:38 jdthood        Priority                 normal => none      
06-06-05 09:38 jdthood        Status                   feedback => acknowledged
06-06-05 09:38 jdthood        Resolution               reopened => won't fix
06-06-05 09:38 jdthood        version                  1.0.8 => 1.0.9      
11-14-05 10:31 perex          Status                   acknowledged => resolved
11-14-05 10:31 perex          Resolution               won't fix => suspended
11-14-05 10:31 perex          Note Added: 0006707                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
