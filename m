From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000794]: can't compile alsa-driver 1.0.7 with a linux kernel 2.4.29-rc1
Date: Sat, 8 Jan 2005 18:20:12 +0100
Message-ID: <1646cb70c5bc0e11235d5f403c4624fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EB4F3289
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 18:20:12 +0100 (MET)
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
Status:                     assigned
Distribution:               slackware
Kernel Version:             2.4.29-rc1 (from kernel.org and not provide by the
distribution)
======================================================================
Date Submitted:             01-08-2005 18:20 CET
Last Modified:              01-08-2005 18:20 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-05 18:20 zebul666       New Issue                                    
01-08-05 18:20 zebul666       Distribution              => slackware       
01-08-05 18:20 zebul666       Kernel Version            => 2.4.29-rc1 (from
kernel.org and not provide by the distribution)
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
