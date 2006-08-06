From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002333]: alsa -1.0.12rc2 compilation
	problem on kernel 2.4
Date: Sun, 6 Aug 2006 14:34:25 +0200
Message-ID: <55382935e693c8632402fcac37c8fe36@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84B8F17E
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 14:34:25 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2333> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2333
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             08-04-2006 17:32 CEST
Last Modified:              08-06-2006 14:34 CEST
======================================================================
Summary:                    alsa -1.0.12rc2 compilation problem on kernel 2.4
Description: 
./configure --with-cards=all

make

gcc32 -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/alsa-driver-1.0.12rc2/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -DALSA_BUILD -nostdinc
-iwithprefix include -I/alsa-driver-1.0.12rc2/alsa-kernel/core/oss
-fno-omit-frame-pointer mixer_oss.c pcm_oss.c pcm_plugin.c io.c copy.c
linear.c mulaw.c route.c rate.c > .depend
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from mixer_oss.c:22:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from pcm_oss.c:29:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/pcm_plugin.c:27,
                 from pcm_plugin.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/io.c:22,
                 from io.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/copy.c:22,
                 from copy.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/linear.c:23,
                 from linear.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/mulaw.c:24,
                 from mulaw.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/route.c:22,
                 from route.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/rate.c:22,
                 from rate.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
make[3]: *** [fastdep] Error 1
make[3]: Leaving directory `/alsa-driver-1.0.12rc2/acore/oss'
make[2]: *** [_sfdep_oss] Error 2
make[2]: Leaving directory `/alsa-driver-1.0.12rc2/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/alsa-driver-1.0.12rc2'
make: *** [include/sndversions.h] Error 2

======================================================================

----------------------------------------------------------------------
 Raymond - 08-06-06 13:43 
----------------------------------------------------------------------
Still has error after download adriver.h from 

http://hg.alsa-project.org/alsa-driver?fd=9dca103e6e5c;file=include/adriver.h



gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa-driver-1.0.12rc2/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h  
-DEXPORT_SYMTAB -c hwdep.c
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from hwdep.c:22:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from hwdep.c:22:
/alsa-driver-1.0.12rc2/include/adriver.h:142: syntax error before '{'
token
make[1]: *** [hwdep.o] Error 1
make[1]: Leaving directory `/alsa-driver-1.0.12rc2/acore'
make: *** [compile] Error 1

----------------------------------------------------------------------
 Raymond - 08-06-06 14:34 
----------------------------------------------------------------------
{standard input}: Assembler messages:
{standard input}:5552: Warning: rest of line ignored; first ignored
character is `"'
{standard input}:5553: Error: unknown pseudo-op: `.text.lock.'
{standard input}:5634: Warning: rest of line ignored; first ignored
character is `"'
{standard input}:5635: Error: unknown pseudo-op: `.text.lock.'

This error seem related to the following patch

http://hg-mirror.alsa-project.org/alsa-driver?cmd=changeset;node=8a02d60ea2be;style=gitweb

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-06 17:32 Raymond        New Issue                                    
08-04-06 17:32 Raymond        Distribution              => Fedora Core 1   
08-04-06 17:32 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
08-05-06 13:14 Raymond        Note Added: 0011427                          
08-06-06 13:43 Raymond        Note Added: 0011466                          
08-06-06 14:34 Raymond        Note Added: 0011468                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
