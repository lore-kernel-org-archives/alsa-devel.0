From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002168]: --enable-shared=no
	--enable-static=yes fails
Date: Sun, 28 May 2006 19:30:31 +0200
Message-ID: <6be0240245cbed5168743e99822d349a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E74C164
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 19:30:31 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2168> 
======================================================================
Reported By:                pierrelux
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2168
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-28-2006 19:30 CEST
Last Modified:              05-28-2006 19:30 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-06 19:30 pierrelux      New Issue                                    
======================================================================
