From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000652]: Compilation fails (alsa-driver/drivers/serialmidi.c)
Date: Thu, 18 Nov 2004 08:51:23 +0100
Message-ID: <5bb9f2ae87e5b69b250e7bc6ed9b05a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C6111D4
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 08:51:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=652> 
======================================================================
Reported By:                visit0r
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   652
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Unstable
Kernel Version:             2.6.10-rc2
======================================================================
Date Submitted:             11-18-2004 08:51 CET
Last Modified:              11-18-2004 08:51 CET
======================================================================
Summary:                    Compilation fails (alsa-driver/drivers/serialmidi.c)
Description: 
Both 1.0.7 and CVS compilation fail with following:

[...]
 CC [M] /usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c: In function
`tx_loop':
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: warning: passing
arg 3 of pointer to function makes integer from pointer without a cast
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: error: too many
arguments to function
make[4]: ***
[/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o] Error 1
make[3]: *** [/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers] Error 2
make[2]: *** [_module_/usr/src/alsa-cvs/alsa-driver/kbuild] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10-rc2'
make: *** [compile] Error 2

I tried it with gcc 3.2.3 (Debian), 3.3.5 (Debian 1:3.3.5-2) and
3.4.2 (Debian 3.4.2-3). Looks more like Linux version incompatibility?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 08:51 visit0r        New Issue                                    
11-18-04 08:51 visit0r        Distribution              => Debian Unstable 
11-18-04 08:51 visit0r        Kernel Version            => 2.6.10-rc2      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
