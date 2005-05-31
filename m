From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000794]: can't compile alsa-driver 1.0.7 with a linux kernel 2.4.29-rc1
Date: Tue, 31 May 2005 18:03:51 +0200
Message-ID: <dc27d9f2ac6644c9e4ac7da92d3f5bc7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6C4651B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:51 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=794> 
======================================================================
Reported By:                zebul666
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   794
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               slackware
Kernel Version:             2.4.29-rc1 (from kernel.org and not provide by the
distribution)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-08-2005 18:20 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    can't compile alsa-driver 1.0.7 with a linux kernel
2.4.29-rc1
Description: 
[...]
gcc -D__KERNEL__ -DMODULE=1 -I/tmp/buildSXOSxz/alsa-driver-1.0.7/include 
-I/usr/src/linux/include -O2 -mpreferred-stack-boundary=2 -march=athlon
-DLINUX -Wall-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include   -DEXPORT_SYMTAB -c timer.c
In file included from timer.c:23:
/usr/src/linux/include/linux/delay.h:57: error: parse error before "do"
/usr/src/linux/include/linux/delay.h:57: error: parse error before '('
token
/usr/src/linux/include/linux/delay.h:60: error: parse error before '('
token
make[1]: *** [timer.o] Error 1
make[1]: Leaving directory `/tmp/buildSXOSxz/alsa-driver-1.0.7/acore'
make: *** [compile] Error 1


======================================================================

----------------------------------------------------------------------
 zebul666 - 02-24-05 15:11 
----------------------------------------------------------------------
no.

there is no pb with 1.0.8rc2.
I haven't tested it with 1.0.8 but i don't think there will be any pb. No
pb either with a stock kernel 2.4.29 and 1.0.8 

not a usefull report ?

----------------------------------------------------------------------
 perex - 02-24-05 15:13 
----------------------------------------------------------------------
Fixed in latest code.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-05 18:20 zebul666       New Issue                                    
01-08-05 18:20 zebul666       Distribution              => slackware       
01-08-05 18:20 zebul666       Kernel Version            => 2.4.29-rc1 (from
kernel.org and not provide by the distribution)
02-22-05 09:33 perex          Note Added: 0003687                          
02-24-05 15:11 zebul666       Note Added: 0003720                          
02-24-05 15:13 perex          Status                   assigned => resolved
02-24-05 15:13 perex          Resolution               open => fixed       
02-24-05 15:13 perex          Note Added: 0003721                          
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
