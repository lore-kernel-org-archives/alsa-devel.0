From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002168]: --enable-shared=no
	--enable-static=yes fails
Date: Thu, 20 Jul 2006 06:57:05 +0200
Message-ID: <c8b2c5d727ed74e167c16c5327c0b26c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C373D229
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 06:57:05 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2168> 
======================================================================
Reported By:                pierrelux
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2168
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-28-2006 19:30 CEST
Last Modified:              07-20-2006 06:57 CEST
======================================================================
Summary:                    --enable-shared=no --enable-static=yes fails
Description: 
It seems to be impossible to compile alsa-lib 1.0.11 statically. Here's
where it fails:

make[1]: Entering directory
`/home/pierre-luc/fLux/alsa-lib-1.0.11/aserver'
if i486-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-I../src/pcm    -g -O2 -MT aserver.o -MD -MP -MF ".deps/aserver.Tpo" -c -o

then mv -f ".deps/aserver.Tpo" ".deps/aserver.Po"; else rm -f
".deps/aserver.Tpo"; exit 1; fi
/bin/sh ../libtool --tag=CC --mode=link i486-linux-gcc  -g -O2   -o
aserver  aserver.o ../src/libasound.la
i486-linux-gcc -g -O2 -o aserver aserver.o  ../src/.libs/libasound.a -lm
-ldl -lpthread
 ../src/.libs/libasound.a(pcm_symbols.o):(.data+0x60): undefined reference
to `_snd_module_pcm_extplug'
 ../src/.libs/libasound.a(pcm_symbols.o):(.data+0x64): undefined reference
to `_snd_module_pcm_ioplug'
collect2: ld returned 1 exit status
make[1]: *** [aserver] Error 1
make[1]: Leaving directory
`/home/pierre-luc/fLux/alsa-lib-1.0.11/aserver'
make: *** [all-recursive] Error 1 
======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-09-06 13:54 
----------------------------------------------------------------------
Works for me with 1.0.11 (normal glibc system).

Please try with a freshly unpacked 1.0.11 tarball on the glibc system.

If it still fails, please attach the complete configure and make logs to
this bug.

----------------------------------------------------------------------
 tiwai - 07-20-06 06:57 
----------------------------------------------------------------------
This was already fixed in 1.0.12rc1.  (Missing entries in pcm_symbols.c)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-06 19:30 pierrelux      New Issue                                    
07-09-06 13:54 Adrian Bunk    Note Added: 0010947                          
07-20-06 06:57 tiwai          Status                   new => resolved     
07-20-06 06:57 tiwai          Resolution               open => fixed       
07-20-06 06:57 tiwai          Assigned To               => tiwai           
07-20-06 06:57 tiwai          Note Added: 0011111                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
